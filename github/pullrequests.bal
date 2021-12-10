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

isolated function getPullRequest(string owner, string repositoryName, int pullRequestNumber, 
                                 string accessToken, http:Client graphQlClient) returns @tainted PullRequest|Error {
    string stringQuery = getFormulatedStringQueryForGetAPullRequest(owner, repositoryName, 
                                                                    pullRequestNumber);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        var repository = graphQlData.get(GIT_REPOSITORY);
        if (repository is map<json>) {
            var pr = repository.get(GIT_PULL_REQUEST);
            if(pr is map<json>){
                PullRequest|error pullRequestObj = pr.cloneWithType(PullRequest);
                if pullRequestObj is error {
                    return error ClientError ("GitHub Client Error", pullRequestObj);
                }
                PullRequestReviewList reviewCommentList = check getPullRequestReviewCommentList(owner, 
                                                                                                repositoryName,
                                                                                                pullRequestNumber,
                                                                                                100, 
                                                                                                accessToken,
                                                                                                graphQlClient);
                PullRequestReview[] reviewComments = [];
                boolean hasPRCommentListNextPage = reviewCommentList.pageInfo.hasNextPage;
                string? nextPageCursor= reviewCommentList.pageInfo.endCursor;

                foreach PullRequestReview comment in reviewCommentList.pullRequestReviews {
                    reviewComments.push(comment);
                }
                while (hasPRCommentListNextPage) {
                    reviewCommentList = check getPullRequestReviewCommentList(owner, 
                                                                              repositoryName,
                                                                              pullRequestNumber,
                                                                              100, 
                                                                              accessToken,
                                                                              graphQlClient,
                                                                              nextPageCursor);
                    hasPRCommentListNextPage = reviewCommentList.pageInfo.hasNextPage;
                    nextPageCursor= reviewCommentList.pageInfo.endCursor;

                    foreach PullRequestReview comment in reviewCommentList.pullRequestReviews {
                        reviewComments.push(comment);
                    }
                }
                pullRequestObj.pullRequestReviews = reviewComments;
                return pullRequestObj;
            }
            return error ClientError ("GitHub Client Error", body=pr);
        }
        return error ClientError ("GitHub Client Error", body=repository);
    }
    return graphQlData;
}

isolated function getPullRequests(string repositoryOwnerName, string repositoryName, 
                                               PullRequestState state, int perPageCount, string accessToken, 
                                               http:Client graphQlClient, string? nextPageCursor=()) 
                                               returns @tainted PullRequestList|Error {
    string stringQuery = getFormulatedStringQueryForGetPullRequestList(repositoryOwnerName, repositoryName, state,
                                                                       perPageCount, nextPageCursor);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        var repository = graphQlData.get(GIT_REPOSITORY);
        if (repository is map<json>) {
            var pullRequests = repository.get(GIT_PULL_REQUESTS);
            if(pullRequests is map<json>){
                PullRequestListPayload|error pullRequestListResp = pullRequests.cloneWithType(PullRequestListPayload);
                if pullRequestListResp is PullRequestListPayload {
                    PullRequestList pullRequestList = {
                        pullRequests: pullRequestListResp.nodes,
                        pageInfo: pullRequestListResp.pageInfo,
                        totalCount: pullRequestListResp.totalCount
                    };
                    return pullRequestList;
                }
                return error ClientError ("GitHub Client Error", pullRequestListResp);
            }
            return error ClientError ("GitHub Client Error", body=pullRequests);
        }
        return error ClientError ("GitHub Client Error", body=repository);
    }
    return graphQlData;
}

isolated function createPullRequest(@tainted CreatePullRequestInput createPullRequestInput, string repositoryOwnerName, 
                                    string repositoryName, string accessToken, http:Client graphQlClient) 
                                    returns @tainted PullRequest|Error {
    if(createPullRequestInput?.repositoryId is ()) {
        createPullRequestInput["repositoryId"] = check getRepositoryId(repositoryOwnerName, repositoryName, 
                                                                       accessToken, graphQlClient);
    }
    string stringQuery = getFormulatedStringQueryForCreatePullRequest(createPullRequestInput);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        var createPullRequests = graphQlData.get(GIT_CREATE_PULL_REQUESTS);
        if (createPullRequests is map<json>) {
            var pullRequest = createPullRequests.get(GIT_PULL_REQUEST);
            if(pullRequest is map<json>){
                PullRequest|error pr = pullRequest.cloneWithType(PullRequest);
                return pr is PullRequest? pr: error ClientError ("GitHub Client Error", pr);
            }
            return error ClientError ("GitHub Client Error", body=pullRequest);
        }
        return error ClientError ("GitHub Client Error", body=createPullRequests);
    }
    return graphQlData;
}

isolated function updatePullRequest(@tainted UpdatePullRequestInput updatePullRequestInput, string repositoryOwnerName, 
                                    string repositoryName,  int pullRequestNumber, string accessToken, 
                                    http:Client graphQlClient) returns @tainted PullRequest|Error {
    
    UpdatePullRequestInputPayload updatePullRequestInputPayload = {};
    do {
        if(updatePullRequestInput?.pullRequestId is ()) {
            updatePullRequestInputPayload["pullRequestId"] = check getPullRequestId(repositoryOwnerName, repositoryName, 
            pullRequestNumber, accessToken, graphQlClient);
        }

        string[] assigneeIds = [];
        if (!(updatePullRequestInput?.assigneeNames is ())) { 
            foreach string assigneeName in <string[]>updatePullRequestInput?.assigneeNames {
                string userId = check getUserId(assigneeName, accessToken, graphQlClient);
                assigneeIds.push(userId);
            }
            updatePullRequestInputPayload["assigneeIds"] = assigneeIds;
        }

        string[] labelIds = [];
        if (!(updatePullRequestInput?.labelNames is ())) { 
            foreach string labelName in <string[]>updatePullRequestInput?.labelNames {
                Label label = check getLabel(repositoryOwnerName, repositoryName, labelName, accessToken, graphQlClient);
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
    } on fail var e {
        return error ClientError("GraphQL Client Error", e);
    }

    string stringQuery = getFormulatedStringQueryForUpdatePullRequest(updatePullRequestInputPayload);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        var updatePullRequests = graphQlData.get(GIT_UPDATE_PULL_REQUESTS);
        if (updatePullRequests is map<json>) {
            var pullRequest = updatePullRequests.get(GIT_PULL_REQUEST);
            if(pullRequest is map<json>){
                PullRequest|error pr = pullRequest.cloneWithType(PullRequest);
                return pr is PullRequest? pr: error ClientError ("GitHub Client Error", pr);
            }
            return error ClientError ("GitHub Client Error", body=pullRequest);
        }
        return error ClientError ("GitHub Client Error", body=updatePullRequests);
    }
    return graphQlData;
}

isolated function getPullRequestReviewCommentList(string repositoryOwnerName, string repositoryName, 
                                                  int pullRequestNumber, int perPageCount, string accessToken, 
                                                  http:Client graphQlClient, string? nextPageCursor=()) 
                                                  returns @tainted PullRequestReviewList|Error {
    string stringQuery = getFormulatedStringQueryForGetReviewListForRepository(repositoryOwnerName, repositoryName, 
                                                                               pullRequestNumber, perPageCount, 
                                                                               nextPageCursor);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        var repository = graphQlData.get(GIT_REPOSITORY);
        if (repository is map<json>) {
            var pullRequest = repository.get(GIT_PULL_REQUEST);
            if(pullRequest is map<json>){
                var comments = pullRequest.get(GIT_REVIEWS);
                if(comments is map<json>){
                    PullRequestReviewListPayload|error reviews = comments.cloneWithType(PullRequestReviewListPayload);
                    if reviews is PullRequestReviewListPayload {
                        PullRequestReviewList pullRequestReviewList = {
                            pullRequestReviews: reviews.nodes,
                            pageInfo: reviews.pageInfo,
                            totalCount: reviews.totalCount 
                        };
                        return pullRequestReviewList;
                    }
                    return error ClientError ("GitHub Client Error", reviews);
                }
                return error ClientError ("GitHub Client Error", body=comments);
            }
            return error ClientError ("GitHub Client Error", body=pullRequest);
        }
        return error ClientError ("GitHub Client Error", body=repository);
    }
    return graphQlData;
}

 isolated function createPullRequestReview(@tainted AddPullRequestReviewInput addPullRequestReviewInput, 
                                           string repositoryOwnerName, string repositoryName,  int pullRequestNumber, 
                                           string accessToken, http:Client graphQlClient) 
                                           returns @tainted PullRequestReview|Error {
    if (addPullRequestReviewInput?.pullRequestId is ()) {
        addPullRequestReviewInput["pullRequestId"] = check getPullRequestId(repositoryOwnerName, repositoryName, 
                                                                            pullRequestNumber, accessToken, 
                                                                            graphQlClient);
    }
    string stringQuery = getFormulatedStringQueryForAddPullRequestReview(addPullRequestReviewInput);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        var addPullRequestReview = graphQlData.get(GIT_ADD_PULL_REQUEST_REVIEW);
        if (addPullRequestReview is map<json>) {
            var pullRequestReview = addPullRequestReview.get(GIT_PULL_REQUEST_REVIEW);
            if(pullRequestReview is map<json>){
                PullRequestReview|error review = pullRequestReview.cloneWithType(PullRequestReview);
                return review is PullRequestReview? review: error ClientError ("GitHub Client Error", review);
            }
            return error ClientError ("GitHub Client Error", body=pullRequestReview);
        }
        return error ClientError ("GitHub Client Error", body=addPullRequestReview);
    }
    return graphQlData;
}

isolated function updatePullRequestReview(UpdatePullRequestReviewInput updatePullRequestReviewInput, 
                                          string accessToken, http:Client graphQlClient) returns @tainted Error? {

    string stringQuery = getFormulatedStringQueryForUpdatePullRequestReview(updatePullRequestReviewInput);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);
    if graphQlData is Error {
        return graphQlData;
    }
    return ;
}

isolated function deletePendingPullRequestReview(DeletePullRequestReviewInput deletePullRequestReview, 
                                                 string accessToken, http:Client graphQlClient) 
                                                 returns @tainted Error? {
    string stringQuery = getFormulatedStringQueryForDeletePullRequestReview(deletePullRequestReview);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);
    if graphQlData is Error {
        return graphQlData;
    }
    return ;
}
