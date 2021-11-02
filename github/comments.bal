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

isolated function addComment(AddIssueCommentInput addIssueCommentInput, string accessToken, http:Client graphQlClient)
                             returns @tainted IssueComment|error {
   Issue issue = check getRepositoryIssue(addIssueCommentInput.repositoryOwnerName, addIssueCommentInput.repositoryName,
             addIssueCommentInput.issueNumber, accessToken, graphQlClient);

    AddCommentInput addCommentInput = {
        subjectId: issue.id,
        body: addIssueCommentInput.body
    };

    if (!(addIssueCommentInput?.clientMutationId is ())) { 
        addCommentInput["clientMutationId"] = <string>addIssueCommentInput?.clientMutationId;
    }

    string stringQuery = getFormulatedStringQueryForAddComment(addCommentInput);
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
            var addComment = gitData[GIT_ADD_COMMENT];
            if (addComment is map<json>) {
                var commentEdge = addComment[GIT_COMMENT_EDGE];
                if(commentEdge is map<json>){
                    var node = commentEdge[GIT_NODE];
                    IssueComment issueComment = check node.cloneWithType(IssueComment);
                    return issueComment;
                }
            }
        }
    }

    error err = error(GITHUB_ERROR_CODE, message = "Error parsing git issue comment response");
    return err;
}

isolated function updateComment(UpdateIssueCommentInput updateCommentInput, string accessToken, 
                                http:Client graphQlClient) returns @tainted error? {
    string stringQuery = getFormulatedStringQueryForUpdateIssueComment(updateCommentInput);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);
    _ = check getValidatedResponse(response);
}

isolated function deleteComment(DeleteIssueCommentInput deleteCommentInput, string accessToken, 
                                http:Client graphQlClient) returns @tainted error? {
    string stringQuery = getFormulatedStringQueryForDeleteIssueComment(deleteCommentInput);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);
    _ = check getValidatedResponse(response);
}
