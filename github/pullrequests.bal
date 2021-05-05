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

isolated function getPullRequest(string repositoryOwnerName, string repositoryName, int pullRequestNumber, 
                                 string accessToken, http:Client graphQlClient) returns @tainted PullRequest|error {
    string stringQuery = getFormulatedStringQueryForGetAPullRequest(repositoryOwnerName, repositoryName, 
                                                                    pullRequestNumber);
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
                var pr = repository[GIT_PULL_REQUEST];
                PullRequest pullRequestObj = check pr.cloneWithType(PullRequest);
                return pullRequestObj;
            }

        }
    }
    error err = error(GITHUB_ERROR_CODE, message = "Error parsing git repository milestone response");
    return err;
}

isolated function getRepositoryPullRequestList(string repositoryOwnerName, string repositoryName, 
                                               PullRequestState state, int perPageCount, string accessToken, 
                                               http:Client graphQlClient, string? nextPageCursor=()) 
                                               returns @tainted PullRequestList|error {
    string stringQuery = getFormulatedStringQueryForGetPullRequestList(repositoryOwnerName, repositoryName, state,
                                                                       perPageCount, nextPageCursor);
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
                var pullRequests = repository[GIT_PULL_REQUESTS];
                PullRequestList|error pullRequestList = pullRequests.cloneWithType(PullRequestList);
                if(pullRequestList is error){
                    return error(GITHUB_ERROR_CODE, message = "Error parsing pull request list response");
                }else {
                    return pullRequestList;
                }
            }

        }
    }
    error err = error(GITHUB_ERROR_CODE, message = "Error parsing git repository pull request response");
    return err;
}

isolated function createPullRequest(@tainted CreatePullRequestInput createPullRequestInput, string repositoryOwnerName, 
                                    string repositoryName, string accessToken, http:Client graphQlClient) 
                                    returns @tainted PullRequest|error {
    if(createPullRequestInput?.repositoryId is ()) {
        createPullRequestInput["repositoryId"] = check getRepositoryId(repositoryOwnerName, repositoryName, 
                                                                       accessToken, graphQlClient);
    }
    string stringQuery = getFormulatedStringQueryForCreatePullRequest(createPullRequestInput);
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
            var createPullRequests = gitData[GIT_CREATE_PULL_REQUESTS];
            if (createPullRequests is map<json>) {
                var pullRequest = createPullRequests[GIT_PULL_REQUEST];
                PullRequest pr = check pullRequest.cloneWithType(PullRequest);
                return pr;
            }
        }
    }

    error err = error(GITHUB_ERROR_CODE, message = "Error parsing git issue response");
    return err;
}

isolated function updatePullRequest(@tainted UpdatePullRequestInput updatePullRequestInput, string repositoryOwnerName, 
                                    string repositoryName,  int pullRequestNumber, string accessToken, 
                                    http:Client graphQlClient) returns @tainted PullRequest|error {
    if(updatePullRequestInput?.pullRequestId is ()) {
        updatePullRequestInput["pullRequestId"] = check getPullRequestId(repositoryOwnerName, repositoryName, 
        pullRequestNumber, accessToken, graphQlClient);
    }
    string stringQuery = getFormulatedStringQueryForUpdatePullRequest(updatePullRequestInput);
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
            var createPullRequests = gitData[GIT_UPDATE_PULL_REQUESTS];
            if (createPullRequests is map<json>) {
                var pullRequest = createPullRequests[GIT_PULL_REQUEST];
                PullRequest pr = check pullRequest.cloneWithType(PullRequest);
                return pr;
            }
        }
    }

    error err = error(GITHUB_ERROR_CODE, message = "Error parsing git issue response");
    return err;
}

isolated function getPullRequestReviewCommentList(string repositoryOwnerName, string repositoryName, 
                                                  int pullRequestNumber, int perPageCount, string accessToken, 
                                                  http:Client graphQlClient, string? nextPageCursor=()) 
                                                  returns @tainted PullRequestReviewList|error {
    string stringQuery = getFormulatedStringQueryForGetReviewListForRepository(repositoryOwnerName, repositoryName, 
                                                                               pullRequestNumber, perPageCount, 
                                                                               nextPageCursor);
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
                var pullRequests = repository[GIT_PULL_REQUEST];
                if(pullRequests is map<json>){
                    var reviews = pullRequests[GIT_REVIEWS];
                    PullRequestReviewList|error prReviewList = reviews.cloneWithType(PullRequestReviewList);
                    if(prReviewList is error){
                        return error(GITHUB_ERROR_CODE, message = "Error parsing pull request review list response");
                    }else {
                        return prReviewList;
                    }
                }
            }

        }
    }
    error err = error(GITHUB_ERROR_CODE, message = "Error parsing git repository pull request review response");
    return err;
}

 isolated function createPullRequestReview(@tainted AddPullRequestReviewInput addPullRequestReviewInput, 
                                           string repositoryOwnerName, string repositoryName,  int pullRequestNumber, 
                                           string accessToken, http:Client graphQlClient) 
                                           returns @tainted PullRequestReview|error {
    if(addPullRequestReviewInput?.pullRequestId is ()) {
        addPullRequestReviewInput["pullRequestId"] = check getPullRequestId(repositoryOwnerName, repositoryName, 
                                                                            pullRequestNumber, accessToken, 
                                                                            graphQlClient);
    }
    string stringQuery = getFormulatedStringQueryForAddPullRequestReview(addPullRequestReviewInput);
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
            var addPullRequestReview = gitData[GIT_ADD_PULL_REQUEST_REVIEW];
            if(addPullRequestReview is map<json>){
                var pullRequestReview = addPullRequestReview[GIT_PULL_REQUEST_REVIEW];
                if(pullRequestReview is map<json>){
                    return check pullRequestReview.cloneWithType(PullRequestReview);
                }
            }

        }
    }
    error err = error(GITHUB_ERROR_CODE, message = "Error parsing git repository pull request review response");
    return err;
}

isolated function updatePullRequestReview(UpdatePullRequestReviewInput updatePullRequestReviewInput, 
                                          string accessToken, http:Client graphQlClient) returns @tainted error? {

    string stringQuery = getFormulatedStringQueryForUpdatePullRequestReview(updatePullRequestReviewInput);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    var response = graphQlClient->post(EMPTY_STRING, request);

    _ = check getValidatedResponse(response);
}

isolated function deletePendingPullRequestReview(DeletePullRequestReviewInput deletePullRequestReview, 
                                                 string accessToken, http:Client graphQlClient) 
                                                 returns @tainted error? {
    string stringQuery = getFormulatedStringQueryForDeletePullRequestReview(deletePullRequestReview);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    var response = graphQlClient->post(EMPTY_STRING, request);

    _ = check getValidatedResponse(response);
}
