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

isolated function createIssue(@tainted CreateIssueInput createIssueInput, string repositoryOwnerName, 
                              string repositoryName, string accessToken, http:Client graphQlClient) 
                              returns @tainted Issue|error {
    
    string repositoryId = check getRepositoryId(repositoryOwnerName, repositoryName, accessToken,
                                                                 graphQlClient);

     CreateIssueInputPayload createIssueInputPayload = {
        repositoryId: repositoryId,
        title: createIssueInput.title
    };                                                                 

    string[] labelIds = [];
    if (!(createIssueInput?.labelNames is ())) { 
        foreach string labelName in <string[]>createIssueInput?.labelNames {
            Label label = check getRepositoryLabel(repositoryOwnerName, repositoryName, labelName, accessToken, graphQlClient);
            labelIds.push(label.id);
        }
        createIssueInputPayload["labelIds"] = labelIds;
    }

    string[] assigneeIds = [];
    if (!(createIssueInput?.assigneeNames is ())) { 
        foreach string assigneeName in <string[]>createIssueInput?.assigneeNames {
            string userId = check getUserId(repositoryOwnerName, accessToken, graphQlClient);
            assigneeIds.push(userId);
        }
        createIssueInputPayload["assigneeIds"] = assigneeIds;
    }

    if (!(createIssueInput?.projectIds is ())) { 
        createIssueInputPayload["projectIds"] = <string[]>createIssueInput?.projectIds;
    }

    if (!(createIssueInput?.milestoneId is ())) { 
        createIssueInputPayload["milestoneId"] = <string>createIssueInput?.milestoneId;
    }

    if (!(createIssueInput?.issueTemplate is ())) { 
        createIssueInputPayload["issueTemplate"] = <string>createIssueInput?.issueTemplate;
    }

    if (!(createIssueInput?.body is ())) { 
        createIssueInputPayload["body"] = <string>createIssueInput?.body;
    }

    if (!(createIssueInput?.clientMutationId is ())) { 
        createIssueInputPayload["clientMutationId"] = <string>createIssueInput?.clientMutationId;
    }

    
    string stringQuery = getFormulatedStringQueryForCreateIssue(createIssueInputPayload);
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
            var viewer = gitData[GIT_CREATE_ISSUE];
            if (viewer is map<json>) {
                var issue = viewer[GIT_ISSUE];
                Issue issueObj = check issue.cloneWithType(Issue);
                return issueObj;

            }
        }
    }

    error err = error(GITHUB_ERROR_CODE+ " Error parsing git issue response", message = "Error parsing git issue response");
    return err;

}

isolated function updateIssue(@tainted UpdateIssueInput updateIssueInput, string repositoryOwnerName, string repositoryName,  
                              int issueNumber, string accessToken, http:Client graphQlClient) 
                              returns @tainted Issue|error {
    UpdateIssueInputPayload updateIssueInputPayload = {};

    if(updateIssueInput?.id is ()) {
        updateIssueInputPayload["id"] = check getIssueId(repositoryOwnerName, repositoryName, issueNumber, accessToken, 
                                                  graphQlClient);
    }

    if (!(updateIssueInput?.title is ())) { 
        updateIssueInputPayload["title"] = <string>updateIssueInput?.title;
    }

    if (!(updateIssueInput?.body is ())) { 
        updateIssueInputPayload["body"] = <string>updateIssueInput?.body;
    }

    if (!(updateIssueInput?.milestoneId is ())) { 
        updateIssueInputPayload["milestoneId"] = <string>updateIssueInput?.milestoneId;
    }

    if (!(updateIssueInput?.state is ())) { 
        updateIssueInputPayload["state"] = <IssueState>updateIssueInput?.state;
    }

    if (!(updateIssueInput?.projectIds is ())) { 
        updateIssueInputPayload["projectIds"] = <string[]>updateIssueInput?.projectIds;
    }

    if (!(updateIssueInput?.clientMutationId is ())) { 
        updateIssueInputPayload["clientMutationId"] = <string>updateIssueInput?.clientMutationId;
    }

    string[] labelIds = [];
    if (!(updateIssueInput?.labelNames is ())) { 
        foreach string labelName in <string[]>updateIssueInput?.labelNames {
            Label label = check getRepositoryLabel(repositoryOwnerName, repositoryName, labelName, accessToken, graphQlClient);
            labelIds.push(label.id);
        }
        updateIssueInputPayload["labelIds"] = labelIds;
    }

    string[] assigneeIds = [];
    if (!(updateIssueInput?.assigneeNames is ())) { 
        foreach string assigneeName in <string[]>updateIssueInput?.assigneeNames {
            string userId = check getUserId(repositoryOwnerName, accessToken, graphQlClient);
            assigneeIds.push(userId);
        }
        updateIssueInputPayload["assigneeIds"] = assigneeIds;
    }

    

    string stringQuery = getFormulatedStringQueryForUpdateIssue(updateIssueInputPayload);
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
            var viewer = gitData[GIT_UPDATE_ISSUE];
            if (viewer is map<json>) {
                var issue = viewer[GIT_ISSUE];
                Issue issueObj = check issue.cloneWithType(Issue);
                return issueObj;
            }
        }
    }

    error err = error(GITHUB_ERROR_CODE+ " Error parsing git issue response", message = "Error parsing git issue response");
    return err;

}

isolated function getRepositoryIssue(string repositoryOwnerName, string repositoryName, int issueNumber, 
                                     string accessToken, http:Client graphQlClient) returns @tainted Issue|error {
    string stringQuery = getFormulatedStringQueryForGetRepositoryIssue(repositoryOwnerName, repositoryName, 
                                                                       issueNumber);
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
            var viewer = gitData[GIT_REPOSITORY];
            if (viewer is map<json>) {
                var issue = viewer[GIT_ISSUE];
                Issue issueObj = check issue.cloneWithType(Issue);
                return issueObj;
            }
        }
    }
    error err = error(GITHUB_ERROR_CODE+ " Error parsing git repository issue response", message = "Error parsing git repository issue response");
    return err;
}

isolated function getRepositoryIssueCommentList(string repositoryOwnerName, string repositoryName, int issueNumber, 
                                                int perPageCount, string accessToken, http:Client graphQlClient, 
                                                string? nextPageCursor=()) returns @tainted IssueCommentList|error {
    string stringQuery = getFormulatedStringQueryForGetIssueCommentList(repositoryOwnerName, repositoryName, 
                                                                        issueNumber, perPageCount, nextPageCursor);
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
            var viewer = gitData[GIT_REPOSITORY];
            if (viewer is map<json>) {
                var issue = viewer[GIT_ISSUE];
                if(issue is map<json>){
                    var comments = issue[GIT_COMMENTS];
                    if(comments is map<json>){
                        IssueCommentListPayload issueCommentListResponse = check comments.cloneWithType(IssueCommentListPayload);
                        IssueCommentList issueCommentList = {
                            issueComments: issueCommentListResponse.nodes,
                            pageInfo: issueCommentListResponse.pageInfo,
                            totalCount: issueCommentListResponse.totalCount
                        };
                        return issueCommentList;
                    }
                }
            }
        }
    }
    error err = error(GITHUB_ERROR_CODE+ " Error parsing git issue comment list response", message = "Error parsing git issue comment list response");
    return err;
}

isolated function getIssuesWithLabel(string repositoryOwnerName, string repositoryName, string labelName, 
                                     int perPageCount, string accessToken, http:Client graphQlClient, 
                                     string? nextPageCursor=()) returns @tainted IssueList|error {
    string stringQuery = getFormulatedStringQueryForGetIssueListWithLabel(repositoryOwnerName, repositoryName, labelName, perPageCount, nextPageCursor);
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
            var repository = gitData[GIT_REPOSITORY];
            if(repository is map<json>){
                var label = repository[GIT_LABEL];
                if (label is map<json>) {
                    var issues = label[GIT_ISSUES];
                    if(issues is map<json>){
                        IssueListPayload issueListResponse = check issues.cloneWithType(IssueListPayload);
                        IssueList issueList = {
                            issues: issueListResponse.nodes,
                            pageInfo: issueListResponse.pageInfo,
                            totalCount: issueListResponse.totalCount
                        };
                        return issueList;
                    }
                }
            }

        }
    }
    error err = error(GITHUB_ERROR_CODE+ " Error parsing git issue list response", message = "Error parsing git issue list response");
    return err;
}
