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

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);

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
    error err = error(GITHUB_ERROR_CODE+ " Error parsing git pull request response", message = "Error parsing git pull request response");
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

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json validatedResponse = check getValidatedResponse(response);

    if (validatedResponse is map<json>) {
        var gitData = validatedResponse[GIT_DATA];
        if (gitData is map<json>) {
            var repository = gitData[GIT_REPOSITORY];
            if(repository is map<json>){
                var pullRequests = repository[GIT_PULL_REQUESTS];
                PullRequestListPayload|error pullRequestListResponse = pullRequests.cloneWithType(PullRequestListPayload);

                if(pullRequestListResponse is error){
                    return error(GITHUB_ERROR_CODE+" Error parsing pull request list response", message = "Error parsing pull request list response");
                }else {
                    PullRequestList pullRequestList = {
                        pullRequests: pullRequestListResponse.nodes,
                        pageInfo: pullRequestListResponse.pageInfo,
                        totalCount: pullRequestListResponse.totalCount
                    };
                    return pullRequestList;
                }
            }

        }
    }
    error err = error(GITHUB_ERROR_CODE+ " Error parsing git repository pull request list response", message = "Error parsing git repository pull request list response");
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

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);
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

    error err = error(GITHUB_ERROR_CODE+ " Error parsing git pull request response", message = "Error parsing git pull request response");
    return err;
}

isolated function updatePullRequest(@tainted UpdatePullRequestInput updatePullRequestInput, string repositoryOwnerName, 
                                    string repositoryName,  int pullRequestNumber, string accessToken, 
                                    http:Client graphQlClient) returns @tainted PullRequest|error {
    
    UpdatePullRequestInputPayload updatePullRequestInputPayload = {};
                                            
    if(updatePullRequestInput?.pullRequestId is ()) {
        updatePullRequestInputPayload["pullRequestId"] = check getPullRequestId(repositoryOwnerName, repositoryName, 
        pullRequestNumber, accessToken, graphQlClient);
    }

    string[] assigneeIds = [];
    if (!(updatePullRequestInput?.assigneeNames is ())) { 
        foreach string assigneeName in <string[]>updatePullRequestInput?.assigneeNames {
            string userId = check getUserId(repositoryOwnerName, accessToken, graphQlClient);
            assigneeIds.push(userId);
        }
        updatePullRequestInputPayload["assigneeIds"] = assigneeIds;
    }

    string[] labelIds = [];
    if (!(updatePullRequestInput?.labelNames is ())) { 
        foreach string labelName in <string[]>updatePullRequestInput?.labelNames {
            Label label = check getRepositoryLabel(repositoryOwnerName, repositoryName, labelName, accessToken, graphQlClient);
            labelIds.push(label.id);
        }
        updatePullRequestInputPayload["labelIds"] = labelIds;
    }

    if(updatePullRequestInput?.pullRequestId is ()) {
        updatePullRequestInputPayload["pullRequestId"] = check getPullRequestId(repositoryOwnerName, repositoryName, 
        pullRequestNumber, accessToken, graphQlClient);
    }

    if (!(updatePullRequestInput?.title is ())) { 
        updatePullRequestInputPayload["title"] = <string>updatePullRequestInput?.title;
    }

    if (!(updatePullRequestInput?.body is ())) { 
        updatePullRequestInputPayload["body"] = <string>updatePullRequestInput?.body;
    }

    if (!(updatePullRequestInput?.milestoneId is ())) { 
        updatePullRequestInputPayload["milestoneId"] = <string>updatePullRequestInput?.milestoneId;
    }

    if (!(updatePullRequestInput?.state is ())) { 
        updatePullRequestInputPayload["state"] = <PullRequestState>updatePullRequestInput?.state;
    }

    if (!(updatePullRequestInput?.projectIds is ())) { 
        updatePullRequestInputPayload["projectIds"] = <string[]>updatePullRequestInput?.projectIds;
    }

    if (!(updatePullRequestInput?.baseRefName is ())) { 
        updatePullRequestInputPayload["baseRefName"] = <string>updatePullRequestInput?.baseRefName;
    }

    if (!(updatePullRequestInput?.clientMutationId is ())) { 
        updatePullRequestInputPayload["clientMutationId"] = <string>updatePullRequestInput?.clientMutationId;
    }


    string stringQuery = getFormulatedStringQueryForUpdatePullRequest(updatePullRequestInputPayload);
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

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);

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
                    PullRequestReviewListPayload|error prReviewListResponse = reviews.cloneWithType(PullRequestReviewListPayload);

                    if(prReviewListResponse is error){
                        return error(GITHUB_ERROR_CODE+" Error parsing pull request review list response", message = "Error parsing pull request review list response");
                    }else {
                        PullRequestReviewList pullRequestReviewList = {
                            pullRequestReviews: prReviewListResponse.nodes,
                            pageInfo: prReviewListResponse.pageInfo,
                            totalCount: prReviewListResponse.totalCount 
                        };
                        return pullRequestReviewList;
                    }
                }
            }

        }
    }
    error err = error(GITHUB_ERROR_CODE+ " Error parsing git repository pull request review response", message = "Error parsing git repository pull request review response");
    return err;
}

 isolated function createPullRequestReview(@tainted AddPullRequestReviewInput addPullRequestReviewInput, 
                                           string repositoryOwnerName, string repositoryName,  int pullRequestNumber, 
                                           string accessToken, http:Client graphQlClient) 
                                           returns @tainted PullRequestReview|error {
    if (addPullRequestReviewInput?.pullRequestId is ()) {
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

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);
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
    error err = error(GITHUB_ERROR_CODE+ " Error parsing git repository pull request review response", message = "Error parsing git repository pull request review response");
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

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);
    _ = check getValidatedResponse(response);
    return;
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

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);
    _ = check getValidatedResponse(response);
    return;
}
