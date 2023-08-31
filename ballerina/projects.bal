// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

isolated function getOrganizationProjectList(string organizationName, ProjectState? state, int perPageCount,
        string accessToken, http:Client graphQlClient, string? nextPageCursor = ()) returns ProjectList|Error {
    string stringQuery = getFormulatedStringQueryForOrgProjectList(organizationName, state, perPageCount,
            nextPageCursor);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json org = graphQlData.get(GIT_ORGANIZATION);
        if org is map<json> {
            json projects = org.get(GIT_PROJECTS);
            if projects is map<json> {
                ProjectListPayload|error projectListResponse = projects.cloneWithType(ProjectListPayload);
                if projectListResponse is ProjectListPayload {
                    Project[] projectsFromResponse = from Project? project in projectListResponse.nodes where project 
                            is Project select project;
                    ProjectList projectList = {
                        projects: projectsFromResponse,
                        pageInfo: projectListResponse.pageInfo,
                        totalCount: projectsFromResponse.length()
                    };
                    return projectList;
                }
                return error ClientError("GitHub Client Error", projectListResponse);
            }
            return error ClientError("GitHub Client Error", body = projects);
        }
        return error ClientError("GitHub Client Error", body = org);
    }
    return graphQlData;
}

isolated function createProject(CreateRepositoryProjectInput createRepositoryProjectInput, string accessToken, 
        http:Client graphQlClient) returns Project|Error {
    string userId = check getUserId(createRepositoryProjectInput.ownerName, accessToken, graphQlClient);
    CreateProjectInput createProjectInput = {
        ownerId: userId,
        name: createRepositoryProjectInput.name
    };
    do {
        string[] repositoryIds = [];
        if !(createRepositoryProjectInput?.repositoryNames is ()) {
            foreach string repositoryName in <string[]>createRepositoryProjectInput?.repositoryNames {
                Repository repository = check getRepository(createRepositoryProjectInput.ownerName, repositoryName, accessToken, graphQlClient);
                repositoryIds.push(repository.id);
            }
            createProjectInput["repositoryIds"] = repositoryIds;
        }

        if !(createRepositoryProjectInput?.body is ()) {
            createProjectInput["body"] = <string>createRepositoryProjectInput?.body;
        }

        if !(createRepositoryProjectInput?.template is ()) {
            createProjectInput["template"] = <ProjectTemplate>createRepositoryProjectInput?.template;
        }

        if !(createRepositoryProjectInput?.clientMutationId is ()) {
            createProjectInput["clientMutationId"] = <string>createRepositoryProjectInput?.clientMutationId;
        }
    } on fail var e {
        return error ClientError("GitHub Client Error", e);
    }

    string stringQuery = getFormulatedStringQueryForCreateProject(createProjectInput);

    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json createProject = graphQlData.get(GIT_CREATE_PROJECT);
        if createProject is map<json> {
            json project = createProject.get(GIT_PROJECT);
            if project is map<json> {
                Project|error createdProject = project.cloneWithType(Project);
                return createdProject is Project ? createdProject :
                    error ClientError("GitHub Client Error", createdProject);
            }
            return error ClientError("GitHub Client Error", body = project);
        }
        return error ClientError("GitHub Client Error", body = createProject);
    }
    return graphQlData;
}

isolated function getProject(string username, int projectNumber, string accessToken, http:Client graphQlClient)
        returns Project|Error {
    string stringQuery = getFormulatedStringQueryForGetAProject(username, projectNumber);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json user = graphQlData.get(GIT_USER);
        if user is map<json> {
            json project = user.get(GIT_PROJECT);
            if project is map<json> {
                Project|error userProject = project.cloneWithType(Project);
                return userProject is Project ? userProject :
                    error ClientError("GitHub Client Error", userProject);
            }
            return error ClientError("GitHub Client Error", body = project);
        }
        return error ClientError("GitHub Client Error", body = user);
    }
    return graphQlData;
}

isolated function updateProject(UpdateProjectInput updateProjectInput, string accessToken, http:Client graphQlClient)
        returns Project|Error {
    string stringQuery = getFormulatedStringQueryForUpdateProject(updateProjectInput);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json updateProject = graphQlData.get(GIT_UPDATE_PROJECT);
        if updateProject is map<json> {
            json project = updateProject.get(GIT_PROJECT);
            if project is map<json> {
                Project|error updatedProject = project.cloneWithType(Project);
                return updatedProject is Project ? updatedProject :
                    error ClientError("GitHub Client Error", updatedProject);
            }
            return error ClientError("GitHub Client Error", body = project);
        }
        return error ClientError("GitHub Client Error", body = updateProject);
    }
    return graphQlData;
}

isolated function deleteProject(DeleteProjectInput deleteProjectInput, string accessToken, http:Client graphQlClient)
        returns Error? {
    string stringQuery = getFormulatedStringQueryForDeleteProject(deleteProjectInput);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);
    if graphQlData is Error {
        return graphQlData;
    }
    return;
}

isolated function getRepositoryProjectList(string repositoryOwner, string repositoryName, ProjectState? state,
        int perPageCount, string accessToken, http:Client graphQlClient, string? nextPageCursor = ()) returns 
        ProjectList|Error {
    string stringQuery = getFormulatedStringQueryForRepositoryProjectList(repositoryOwner, repositoryName, state,
            perPageCount, nextPageCursor);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repo = graphQlData.get(GIT_REPOSITORY);
        if repo is map<json> {
            json projects = repo.get(GIT_PROJECTS);
            if projects is map<json> {
                ProjectListPayload|error projectListResponse = projects.cloneWithType(ProjectListPayload);
                if projectListResponse is ProjectListPayload {
                    Project[] projectsFromResponse = from Project? project in
                        projectListResponse.nodes where project is Project select project;
                    ProjectList projectList = {
                        projects: projectsFromResponse,
                        pageInfo: projectListResponse.pageInfo,
                        totalCount: projectsFromResponse.length()
                    };
                    return projectList;
                }
                return error ClientError("GitHub Client Error", projectListResponse);
            }
            return error ClientError("GitHub Client Error", body = projects);
        }
        return error ClientError("GitHub Client Error", body = repo);
    }
    return graphQlData;
}

isolated function getUserProjectList(string username, int perPageCount, string accessToken, http:Client graphQlClient,
        string? nextPageCursor = ()) returns ProjectList|Error {
    string stringQuery = getFormulatedStringQueryForGetUserProjectList(username, perPageCount, nextPageCursor);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json user = graphQlData.get(GIT_USER);
        if user is map<json> {
            json projects = user.get(GIT_PROJECTS);
            if projects is map<json> {
                ProjectListPayload|error projectListResponse = projects.cloneWithType(ProjectListPayload);
                if projectListResponse is ProjectListPayload {
                    Project[] projectsFromResponse = from Project? project in projectListResponse.nodes where project is
                            Project select project;
                    ProjectList projectList = {
                        projects: projectsFromResponse,
                        pageInfo: projectListResponse.pageInfo,
                        totalCount: projectsFromResponse.length()
                    };
                    return projectList;
                }
                return error ClientError("GitHub Client Error", projectListResponse);
            }
            return error ClientError("GitHub Client Error", body = projects);
        }
        return error ClientError("GitHub Client Error", body = user);
    }
    return graphQlData;
}
