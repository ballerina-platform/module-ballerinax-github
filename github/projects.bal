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

isolated function getOrganizationProjectList(string organizationName, ProjectState state, int perPageCount, 
                                             string accessToken, http:Client graphQlClient, string? nextPageCursor=()) 
                                             returns @tainted ProjectList|error {
    string stringQuery = getFormulatedStringQueryForOrgProjectList(organizationName, state, perPageCount, 
                                                                   nextPageCursor);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json validatedResponse = check getValidatedResponse(response);

    if (validatedResponse is map<json>) {
        var gitData = validatedResponse[GIT_DATA];
        if (gitData is map<json>) {
            var org = gitData[GIT_ORGANIZATION];
            if(org is map<json>){
                var orgProjects = org[GIT_PROJECTS];
                ProjectListPayload|error projectListResponse = orgProjects.cloneWithType(ProjectListPayload);

                if(projectListResponse is error){
                    return error(GITHUB_ERROR_CODE+ "Error parsing org project list response", message = "Error parsing org project list response");
                }else {
                    ProjectList projectList = {
                        projects: projectListResponse.nodes,
                        pageInfo: projectListResponse.pageInfo,
                        totalCount: projectListResponse.totalCount 
                    };
                    return projectList;
                }
            }

        }
    }
    error err = error(GITHUB_ERROR_CODE+ " Error parsing org project list response", message = "Error parsing org project list response");
    return err;
}

isolated function createProject(CreateRepositoryProjectInput createRepositoryProjectInput, string accessToken, http:Client graphQlClient) 
                                returns @tainted Project|error {
    
    string userId = check getUserId(createRepositoryProjectInput.ownerName, accessToken, graphQlClient);

    CreateProjectInput createProjectInput = {
        ownerId: userId,
        name: createRepositoryProjectInput.name
    };

    string[] repositoryIds = [];
    if (!(createRepositoryProjectInput?.repositoryNames is ())) { 
        foreach string repositoryName in <string[]>createRepositoryProjectInput?.repositoryNames {
            Repository repository = check getUserRepository(createRepositoryProjectInput.ownerName, repositoryName, accessToken, graphQlClient);
            repositoryIds.push(repository.id);
        }
        createProjectInput["repositoryIds"] = repositoryIds;
    }

    if (!(createRepositoryProjectInput?.body is ())) { 
        createProjectInput["body"] = <string>createRepositoryProjectInput?.body;
    }

    if (!(createRepositoryProjectInput?.template is ())) { 
        createProjectInput["template"] = <ProjectTemplate>createRepositoryProjectInput?.template;
    }

    if (!(createRepositoryProjectInput?.clientMutationId is ())) { 
        createProjectInput["clientMutationId"] = <string>createRepositoryProjectInput?.clientMutationId;
    }

    string stringQuery = getFormulatedStringQueryForCreateProject(createProjectInput);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);
    json validatedResponse = check getValidatedResponse(response);

    if (validatedResponse is map<json>) {
        var gitData = validatedResponse[GIT_DATA];
        if (gitData is map<json>) {
            var createProject = gitData[GIT_CREATE_PROJECT];
            if(createProject is map<json>){
                var project = createProject[GIT_PROJECT];
                return check project.cloneWithType(Project);
            }

        }
    }
    error err = error(GITHUB_ERROR_CODE+ " Error parsing create project response", message = "Error parsing create project response");
    return err;
}

isolated function getUserProject(string username, int projectNumber, string accessToken, http:Client graphQlClient) 
                                 returns @tainted Project|error {
    string stringQuery = getFormulatedStringQueryForGetAProject(username, projectNumber);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);


    //Check for empty payloads and errors
    json validatedResponse = check getValidatedResponse(response);

    if (validatedResponse is map<json>) {
        var gitData = validatedResponse[GIT_DATA];
        if (gitData is map<json>) {
            var user = gitData[GIT_USER];
            if(user is map<json>){
                var userProject = user[GIT_PROJECT];
                if (userProject is ()) {
                    error err = error(GITHUB_ERROR_CODE+string `: Could not resolve to a project with the number ${projectNumber}.`, message = string `: Could not resolve to a project with the number ${projectNumber}.`);
                    return err;
                }
                Project project = check userProject.cloneWithType(Project);
                return project;
            }
        }
    }
    error err = error(GITHUB_ERROR_CODE+ " Error parsing user project response", message = "Error parsing user project response");
    return err;
}

isolated function updateProject(UpdateProjectInput updateProjectInput, string accessToken, http:Client graphQlClient) 
                                returns @tainted Project|error {
    string stringQuery = getFormulatedStringQueryForUpdateProject(updateProjectInput);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);
    json validatedResponse = check getValidatedResponse(response);

    if (validatedResponse is map<json>) {
        var gitData = validatedResponse[GIT_DATA];
        if (gitData is map<json>) {
            var createProject = gitData[GIT_UPDATE_PROJECT];
            if(createProject is map<json>){
                var project = createProject[GIT_PROJECT];
                return check project.cloneWithType(Project);
            }

        }
    }
    error err = error(GITHUB_ERROR_CODE+ " Error parsing update project response", message = "Error parsing update project response");
    return err;
}

isolated function deleteProject(DeleteProjectInput deleteProjectInput, string accessToken, http:Client graphQlClient) 
                                returns @tainted error? {
    string stringQuery = getFormulatedStringQueryForDeleteProject(deleteProjectInput);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);

    _ = check getValidatedResponse(response);
}

isolated function getRepositoryProjectList(string repositoryOwner, string repositoryName, ProjectState state, 
                                           int perPageCount, string accessToken, http:Client graphQlClient, 
                                           string? nextPageCursor=()) returns @tainted ProjectList|error {
    string stringQuery = getFormulatedStringQueryForRepositoryProjectList(repositoryOwner, repositoryName, state, 
                                                                          perPageCount, nextPageCursor);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json validatedResponse = check getValidatedResponse(response);

    if (validatedResponse is map<json>) {
        var gitData = validatedResponse[GIT_DATA];
        if (gitData is map<json>) {
            var org = gitData[GIT_REPOSITORY];
            if(org is map<json>){
                var orgProjects = org[GIT_PROJECTS];
                ProjectListPayload|error projectListResponse = orgProjects.cloneWithType(ProjectListPayload);

                if(projectListResponse is error){
                    return error(GITHUB_ERROR_CODE+ "Error parsing org project list response", message = "Error parsing org project list response");
                }else {
                    ProjectList projectList = {
                        projects: projectListResponse.nodes,
                        pageInfo: projectListResponse.pageInfo,
                        totalCount: projectListResponse.totalCount 
                    };
                    return projectList;
                }
            }

        }
    }
    error err = error(GITHUB_ERROR_CODE+ " Error parsing repository project list response", message = "Error parsing repository project list response");
    return err;
}

isolated function getUserProjectList(string username, int perPageCount, string accessToken, http:Client graphQlClient,
                                     string? nextPageCursor=()) returns @tainted ProjectList|error {
    string stringQuery = getFormulatedStringQueryForGetUserProjectList(username, perPageCount, nextPageCursor);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json validatedResponse = check getValidatedResponse(response);

    if (validatedResponse is map<json>) {
        var gitData = validatedResponse[GIT_DATA];
        if (gitData is map<json>) {
            var org = gitData[GIT_USER];
            if(org is map<json>){
                var orgProjects = org[GIT_PROJECTS];
                ProjectListPayload|error projectListResponse = orgProjects.cloneWithType(ProjectListPayload);

                if(projectListResponse is error){
                    return error(GITHUB_ERROR_CODE+ "Error parsing org project list response", message = "Error parsing org project list response");
                }else {
                    ProjectList projectList = {
                        projects: projectListResponse.nodes,
                        pageInfo: projectListResponse.pageInfo,
                        totalCount: projectListResponse.totalCount 
                    };
                    return projectList;
                }
            }

        }
    }
    error err = error(GITHUB_ERROR_CODE + " Error parsing user project list response", message = "Error parsing user project list response");
    return err;
}
