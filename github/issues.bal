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

isolated function createIssue(CreateIssueInput createIssueInput, string repositoryOwnerName, string repositoryName, string accessToken, http:Client graphQlClient) returns Issue|error {
    if(createIssueInput?.repositoryId is ()) {
        createIssueInput["repositoryId"] = check getRepositoryId(repositoryOwnerName, repositoryName, accessToken, graphQlClient);
    }
    string stringQuery = getFormulatedStringQueryForCreateIssue(createIssueInput);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    var response = graphQlClient->post(EMPTY_STRING, request);

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

    error err = error(GITHUB_ERROR_CODE, message = "Error parsing git issue response");
    return err;

}

isolated function updateIssue(UpdateIssueInput updateIssueInput, string repositoryOwnerName, string repositoryName,  int issueNumber, string accessToken, http:Client graphQlClient) returns Issue|error {
    if(updateIssueInput?.id is ()) {
        updateIssueInput["id"] = check getIssueId(repositoryOwnerName, repositoryName, issueNumber, accessToken, graphQlClient);
    }
    string stringQuery = getFormulatedStringQueryForUpdateIssue(updateIssueInput);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    var response = graphQlClient->post(EMPTY_STRING, request);
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

    error err = error(GITHUB_ERROR_CODE, message = "Error parsing git issue response");
    return err;

}

isolated function getRepositoryIssue(string repositoryOwnerName, string repositoryName, int issueNumber, string accessToken, http:Client graphQlClient) returns Issue|error {
    string stringQuery = getFormulatedStringQueryForGetRepositoryIssue(repositoryOwnerName, repositoryName, issueNumber);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    var response = graphQlClient->post(EMPTY_STRING, request);

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
    error err = error(GITHUB_ERROR_CODE, message = "Error parsing git repository response");
    return err;
}

isolated function getRepositoryIssueCommentList(string repositoryOwnerName, string repositoryName, int issueNumber, int perPageCount, string accessToken, http:Client graphQlClient, string? nextPageCursor=()) returns IssueCommentList|error {
    string stringQuery = getFormulatedStringQueryForGetIssueCommentList(repositoryOwnerName, repositoryName, issueNumber, perPageCount, nextPageCursor);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    var response = graphQlClient->post(EMPTY_STRING, request);

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
                        IssueCommentList issueList = check comments.cloneWithType(IssueCommentList);
                        return issueList;
                    }
                }
            }
        }
    }
    error err = error(GITHUB_ERROR_CODE, message = "Error parsing git repository response");
    return err;
}

isolated function getIssuesWithLabel(string repositoryOwnerName, string repositoryName, string labelName, int perPageCount, string accessToken, http:Client graphQlClient, string? nextPageCursor=()) returns IssueList|error {
    string stringQuery = getFormulatedStringQueryForGetIssueListWithLabel(repositoryOwnerName, repositoryName, labelName, perPageCount, nextPageCursor);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    var response = graphQlClient->post(EMPTY_STRING, request);

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
                        IssueList issueList = check issues.cloneWithType(IssueList);
                        return issueList;
                    }
                }
            }

        }
    }
    error err = error(GITHUB_ERROR_CODE, message = "Error parsing git repository response");
    return err;
}
