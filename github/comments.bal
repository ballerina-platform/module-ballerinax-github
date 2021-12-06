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
   Issue issue = check getIssue(addIssueCommentInput.repositoryOwnerName, addIssueCommentInput.repositoryName,
             addIssueCommentInput.issueNumber, accessToken, graphQlClient);

    AddCommentInput addCommentInput = {
        subjectId: issue.id,
        body: addIssueCommentInput.body
    };

    if (!(addIssueCommentInput?.clientMutationId is ())) { 
        addCommentInput["clientMutationId"] = <string>addIssueCommentInput?.clientMutationId;
    }

    string stringQuery = getFormulatedStringQueryForAddComment(addCommentInput);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        var addComment = graphQlData.get(GIT_ADD_COMMENT);
        if (addComment is map<json>) {
            var commentEdge = addComment.get(GIT_COMMENT_EDGE);
            if(commentEdge is map<json>){
                var node = commentEdge.get(GIT_NODE);
                if node is map<json> {
                    IssueComment|error issueComment = node.cloneWithType(IssueComment);
                    return issueComment is IssueComment? issueComment:
                        error ClientError ("GitHub Client Error", issueComment);
                }
                return error ClientError ("GitHub Client Error", body=node);
            }
            return error ClientError ("GitHub Client Error", body=commentEdge);
        }
        return error ClientError ("GitHub Client Error", body=addComment);
    }
    return graphQlData;
}

isolated function updateComment(UpdateIssueCommentInput updateCommentInput, string accessToken, 
                                http:Client graphQlClient) returns @tainted error? {
    string stringQuery = getFormulatedStringQueryForUpdateIssueComment(updateCommentInput);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);
    if graphQlData is Error {
        return graphQlData;
    }
    return ;
}

isolated function deleteComment(DeleteIssueCommentInput deleteCommentInput, string accessToken, 
                                http:Client graphQlClient) returns @tainted error? {
    string stringQuery = getFormulatedStringQueryForDeleteIssueComment(deleteCommentInput);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);
    if graphQlData is Error {
        return graphQlData;
    }
    return ;
}
