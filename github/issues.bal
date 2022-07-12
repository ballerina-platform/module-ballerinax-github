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
                            returns @tainted Issue|Error {

    string repositoryId = check getRepositoryId(repositoryOwnerName, repositoryName, accessToken, graphQlClient);
    CreateIssueInputPayload createIssueInputPayload = {
        repositoryId: repositoryId,
        title: createIssueInput.title
    };
    do {
        string[] labelIds = [];
        if (!(createIssueInput?.labelNames is ())) {
            foreach string labelName in <string[]>createIssueInput?.labelNames {
                Label label = check getLabel(repositoryOwnerName, repositoryName, labelName, accessToken, graphQlClient);
                labelIds.push(label.id);
            }
            createIssueInputPayload["labelIds"] = labelIds;
        }

        string[] assigneeIds = [];
        if (!(createIssueInput?.assigneeNames is ())) {
            foreach string assigneeName in <string[]>createIssueInput?.assigneeNames {
                string userId = check getUserId(assigneeName, accessToken, graphQlClient);
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
    } on fail var e {
        return error ClientError("GitHub Client Error", e);
    }

    string stringQuery = getFormulatedStringQueryForCreateIssue(createIssueInputPayload);

    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json createIssue = graphQlData.get(GIT_CREATE_ISSUE);
        if (createIssue is map<json>) {
            json issue = createIssue.get(GIT_ISSUE);
            if issue is map<json> {
                Issue|error issueObj = issue.cloneWithType(Issue);
                return issueObj is Issue ? issueObj : error ClientError("GitHub Client Error", issueObj);
            }
            return error ClientError("GitHub Client Error", body = issue);
        }
        return error ClientError("GitHub Client Error", body = createIssue);
    }
    return graphQlData;
}

isolated function updateIssue(@tainted UpdateIssueInput updateIssueInput, string repositoryOwnerName, string repositoryName,
                            int issueNumber, string accessToken, http:Client graphQlClient)
                            returns @tainted Issue|Error {
    UpdateIssueInputPayload updateIssueInputPayload = {};

    do {
        if (updateIssueInput?.id is ()) {
            updateIssueInputPayload["id"] = check getIssueId(repositoryOwnerName, repositoryName, issueNumber,
                                                            accessToken, graphQlClient);
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
                Label label = check getLabel(repositoryOwnerName, repositoryName, labelName, accessToken, graphQlClient);
                labelIds.push(label.id);
            }
            updateIssueInputPayload["labelIds"] = labelIds;
        }

        string[] assigneeIds = [];
        if (!(updateIssueInput?.assigneeNames is ())) {
            foreach string assigneeName in <string[]>updateIssueInput?.assigneeNames {
                string userId = check getUserId(assigneeName, accessToken, graphQlClient);
                assigneeIds.push(userId);
            }
            updateIssueInputPayload["assigneeIds"] = assigneeIds;
        }
    } on fail var e {
        return error ClientError("GitHub Client Error", e);
    }

    string stringQuery = getFormulatedStringQueryForUpdateIssue(updateIssueInputPayload);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json updateIssue = graphQlData.get(GIT_UPDATE_ISSUE);
        if (updateIssue is map<json>) {
            json issue = updateIssue.get(GIT_ISSUE);
            if issue is map<json> {
                Issue|error issueObj = issue.cloneWithType(Issue);
                return issueObj is Issue ? issueObj : error ClientError("GitHub Client Error", issueObj);
            }
            return error ClientError("GitHub Client Error", body = issue);
        }
        return error ClientError("GitHub Client Error", body = updateIssue);
    }
    return graphQlData;
}

isolated function getIssue(string repositoryOwnerName, string repositoryName, int issueNumber, string accessToken, 
                           http:Client graphQlClient, int perPageCountForLabels = 10) returns @tainted Issue|Error {
    string stringQuery = getFormulatedStringQueryForGetIssue(repositoryOwnerName, repositoryName, issueNumber, 
                                                             perPageCountForLabels);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repository = graphQlData.get(GIT_REPOSITORY);
        if (repository is map<json>) {
            json issue = repository.get(GIT_ISSUE);
            if (issue is map<json>) {
                Issue|error issueObj = issue.cloneWithType(Issue);
                if issueObj is error {
                    return error ClientError("GitHub Client Error", issueObj);
                }
                IssueCommentList issueCommentList = check getIssueCommentList(repositoryOwnerName,
                                                                                        repositoryName,
                                                                                        issueNumber,
                                                                                        100,
                                                                                        accessToken,
                                                                                        graphQlClient);
                IssueComment[] issueComments = [];
                boolean hasIssueCommentListNextPage = issueCommentList.pageInfo.hasNextPage;
                string? nextPageCursor = issueCommentList.pageInfo.endCursor;

                foreach IssueComment comment in issueCommentList.issueComments {
                    issueComments.push(comment);
                }
                while (hasIssueCommentListNextPage) {
                    issueCommentList = check getIssueCommentList(repositoryOwnerName,
                                                                                        repositoryName,
                                                                                        issueNumber,
                                                                                        100,
                                                                                        accessToken,
                                                                                        graphQlClient,
                                                                                        nextPageCursor);
                    hasIssueCommentListNextPage = issueCommentList.pageInfo.hasNextPage;
                    nextPageCursor = issueCommentList.pageInfo.endCursor;

                    foreach IssueComment comment in issueCommentList.issueComments {
                        issueComments.push(comment);
                    }
                }
                issueObj.issueComments = issueComments;
                return issueObj;
            }
            return error ClientError("GitHub Client Error", body = issue);
        }
        return error ClientError("GitHub Client Error", body = repository);
    }
    return graphQlData;
}

isolated function getIssueCommentList(string repositoryOwnerName, string repositoryName, int issueNumber,
                                                int perPageCount, string accessToken, http:Client graphQlClient,
                                                string? nextPageCursor = ()) returns @tainted IssueCommentList|Error {
    string stringQuery = getFormulatedStringQueryForGetIssueCommentList(repositoryOwnerName, repositoryName,
                                                                        issueNumber, perPageCount, nextPageCursor);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repository = graphQlData.get(GIT_REPOSITORY);
        if (repository is map<json>) {
            json issue = repository.get(GIT_ISSUE);
            if (issue is map<json>) {
                json comments = issue.get(GIT_COMMENTS);
                if (comments is map<json>) {
                    IssueCommentListPayload|error commentListResponse = comments.cloneWithType(IssueCommentListPayload);
                    if commentListResponse is IssueCommentListPayload {
                        IssueCommentList issueCommentList = {
                            issueComments: commentListResponse.nodes,
                            pageInfo: commentListResponse.pageInfo,
                            totalCount: commentListResponse.totalCount
                        };
                        return issueCommentList;
                    }
                    return error ClientError("GitHub Client Error", commentListResponse);
                }
                return error ClientError("GitHub Client Error", body = comments);
            }
            return error ClientError("GitHub Client Error", body = issue);
        }
        return error ClientError("GitHub Client Error", body = repository);
    }
    return graphQlData;
}
