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

isolated function getRepository(string username, string repositoryName, string accessToken,
                                    http:Client graphQlClient) returns @tainted Repository|Error {

    string stringQuery = getFormulatedStringQueryForGetRepository(username, repositoryName);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repository = graphQlData[GIT_REPOSITORY];
        if repository is map<json> {
            Repository|error result = repository.cloneWithType(Repository);
            if result is error {
                return error ClientError("GitHub Client Error", result);
            }
            LanguageList languageList = check getLanguageList(username, repositoryName, 100, accessToken,
                                                            graphQlClient);

            Language[] languages = [];
            boolean hasNextPage = languageList.pageInfo.hasNextPage;
            string? nextPageCursor = languageList.pageInfo.endCursor;

            foreach Language language in languageList.languages {
                languages.push(language);
            }

            while (hasNextPage) {
                languageList = check getLanguageList(username, repositoryName, 100, accessToken, graphQlClient,
                                                    nextPageCursor);
                hasNextPage = languageList.pageInfo.hasNextPage;
                nextPageCursor = languageList.pageInfo.endCursor;

                foreach Language language in languageList.languages {
                    languages.push(language);
                }
            }
            result.languages = languages;
            return result;
        }
        return error ClientError("GitHub Client Error", body = repository);
    }
    return graphQlData;
}

isolated function getRepositoryContent(string username, string repositoryName, string expression, string accessToken,
                                    http:Client graphQlClient) returns File[]|Error {
    string stringQuery = getFormulatedStringQueryForGetRepositoryContent(username, repositoryName, expression);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repository = graphQlData[GIT_REPOSITORY];
        if repository is map<json> {
            json objects = repository["object"];
            if objects is map<json> {
                if objects.hasKey("entries") {
                    json entries = objects.get("entries");
                    File[]|error result = entries.cloneWithType();
                    if result is error {
                        return error ClientError("GitHub Client Error", result);
                    }
                    return result;
                } else {
                    return error ClientError("Invalid folder path. Content not found");
                }
            }
        }
        return error ClientError("GitHub Client Error", body = repository);
    }
    return graphQlData;
}

isolated function getRepositoryList(int perPageCount, string accessToken, http:Client graphQlClient,
                                    boolean isOrganization, string? owner, string? nextPageCursor = ())
                                    returns @tainted RepositoryList|Error {
    string stringQuery = getFormulatedStringQueryForGetRepositoryList(perPageCount, isOrganization, owner,
                                                                    nextPageCursor);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repoOwner;
        if owner is string && isOrganization {
            repoOwner = graphQlData[GIT_ORGANIZATION];
        } else if owner is string && !isOrganization {
            repoOwner = graphQlData[GIT_USER];
        } else {
            repoOwner = graphQlData[GIT_VIEWER];
        }

        if repoOwner is map<json> {
            json repositories = repoOwner[GIT_REPOSITORIES];
            if repositories is map<json> {
                RepositoryListPayload|error repositoryListResponse = repositories.cloneWithType(RepositoryListPayload);
                if repositoryListResponse is RepositoryListPayload {
                    RepositoryList repositoryList = {
                        repositories: repositoryListResponse.nodes,
                        pageInfo: repositoryListResponse.pageInfo,
                        totalCount: repositoryListResponse.totalCount
                    };
                    return repositoryList;
                }
                return error ClientError("GitHub Client Error", repositoryListResponse);
            } else {
                return error ClientError("GitHub Client Error", body = repositories);
            }
        } else {
            return error ClientError("GitHub Client Error", body = repoOwner);
        }
    } else {
        return graphQlData;
    }
}

isolated function getCollaborators(string owner, string repositoryName, int perPageCount,
                                                string accessToken, http:Client graphQlClient,
                                                string? nextPageCursor = ())
                                                returns @tainted CollaboratorList|Error {
    string stringQuery = getFormulatedStringQueryForGetCollaboratorList(owner, repositoryName, perPageCount,
                                                                        nextPageCursor);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repository = graphQlData.get(GIT_REPOSITORY);
        if repository is map<json> {
            json collaborators = repository.get(GIT_COLLABORATORS);
            if collaborators is map<json> {
                CollaboratorListPayload|error payload = collaborators.cloneWithType(CollaboratorListPayload);
                if payload is CollaboratorListPayload {
                    CollaboratorList collaboratorList = {
                        collaborators: payload.nodes,
                        pageInfo: payload.pageInfo,
                        totalCount: payload.totalCount
                    };
                    return collaboratorList;
                }
                return error ClientError("GitHub Client Error", payload);
            }
            return error ClientError("GitHub Client Error", body = collaborators);
        }
        return error ClientError("GitHub Client Error", body = repository);
    }
    return graphQlData;
}

isolated function getBranches(string ownerName, string repositoryName, int perPageCount,
                                        string accessToken, http:Client graphQlClient, string? nextPageCursor = ())
                                        returns @tainted BranchList|Error {
    string stringQuery = getFormulatedStringQueryForGetBranches(ownerName, repositoryName, perPageCount,
                                                                            nextPageCursor);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repository = graphQlData.get(GIT_REPOSITORY);
        if repository is map<json> {
            json branches = repository.get(GIT_REFS);
            if branches is map<json> {
                BranchListPayload|error branchListResponse = branches.cloneWithType(BranchListPayload);
                if branchListResponse is BranchListPayload {
                    BranchList branchList = {
                        branches: branchListResponse.nodes,
                        pageInfo: branchListResponse.pageInfo,
                        totalCount: branchListResponse.totalCount
                    };
                    return branchList;
                }
                return error ClientError("GitHub Client Error", branchListResponse);
            }
            return error ClientError("GitHub Client Error", body = branches);
        }
        return error ClientError("GitHub Client Error", body = repository);
    }
    return graphQlData;
}

isolated function updateRepository(@tainted UpdateRepositoryInput updateRepositoryInput, string repositoryOwnerName,
                                    string repositoryName, string accessToken, http:Client graphQlClient)
                                    returns @tainted Error? {
    if updateRepositoryInput?.repositoryId is () {
        updateRepositoryInput["repositoryId"] = check getRepositoryId(repositoryOwnerName, repositoryName, accessToken,
                                                                    graphQlClient);
    }
    string stringQuery = getFormulatedStringQueryForUpdateRepository(updateRepositoryInput);

    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);
    if graphQlData is Error {
        return graphQlData;
    }
    return;
}

isolated function getIssues(string repositoryOwnerName, string repositoryName, int perPageCount,
                                        string accessToken, http:Client graphQlClient, string? nextPageCursor,
                                        IssueFilters issueFilters) returns @tainted IssueList|Error {
    string stringQuery = getFormulatedStringQueryForGetIssueList(repositoryOwnerName, repositoryName,
                                                                perPageCount, nextPageCursor, issueFilters);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repository = graphQlData.get(GIT_REPOSITORY);
        if repository is map<json> {
            json issues = repository.get(GIT_ISSUES);
            if issues is map<json> {
                IssueListPayload|error issueListResponse = issues.cloneWithType(IssueListPayload);
                if issueListResponse is IssueListPayload {
                    IssueList issueList = {
                        issues: issueListResponse.nodes,
                        pageInfo: issueListResponse.pageInfo,
                        totalCount: issueListResponse.totalCount
                    };
                    return issueList;
                }
                return error ClientError("GitHub Client Error", issueListResponse);
            }
            return error ClientError("GitHub Client Error", body = issues);
        }
        return error ClientError("GitHub Client Error", body = repository);
    }
    return graphQlData;
}

isolated function createRepository(@tainted CreateRepositoryInput createRepositoryInput, string accessToken,
                                    http:Client graphQlClient) returns @tainted Error? {

    if createRepositoryInput?.template is () {
        createRepositoryInput["template"] = false;
    }
    if createRepositoryInput?.hasWikiEnabled is () {
        createRepositoryInput["hasWikiEnabled"] = false;
    }
    if createRepositoryInput?.hasIssuesEnabled is () {
        createRepositoryInput["hasIssuesEnabled"] = true;
    }

    string stringQuery = getFormulatedStringQueryForCreateRepository(createRepositoryInput);

    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);
    if graphQlData is Error {
        return graphQlData;
    }
    return;
}

isolated function getLanguageList(string owner, string repositoryName, int perPageCount, string accessToken,
                                http:Client graphQlClient, string? nextPageCursor = ()) returns LanguageList|Error {

    string stringQuery = getFormulatedStringQueryForGetLanguages(owner, repositoryName, perPageCount, nextPageCursor);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repository = graphQlData.get(GIT_REPOSITORY);
        if repository is map<json> {
            json languages = repository.get(GIT_LANGUAGES);
            if languages is map<json> {
                LanguageListPayload|error languageListResponse = languages.cloneWithType();
                if languageListResponse is LanguageListPayload {
                    LanguageList languageList = {
                        languages: languageListResponse.nodes,
                        pageInfo: languageListResponse.pageInfo,
                        totalCount: languageListResponse.totalCount
                    };
                    return languageList;
                }
                return error ClientError("GitHub Client Error while clone with type.", languageListResponse);
            }
            return error ClientError("GitHub Client Error while getting languages.", body = languages);
        }
        return error ClientError("GitHub Client Error while getting repository.", body = repository);
    }
    return graphQlData;
}
