// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
import ballerina/regex;

# Construct the request by adding the payload and authorization tokens.
# + request - HTTP request object
# + stringQuery - GraphQL API query
isolated function constructRequest(http:Request request, json stringQuery) {
    request.setJsonPayload(stringQuery);
}

# Set Auth header
# + request - HTTP Request where the header needs to be set
# + accessToken - Access token
isolated function setHeader(http:Request request, string accessToken) {
    request.setHeader("Authorization", "token " + accessToken);
}

# Convert string representation of JSON object to JSON object.
# + src - String representation of the JSON object
# + return - Converted `json` object or Connector error
isolated function stringToJson(string src) returns json|error {
    return src.fromJsonString();
}

# Split the given string using the given delimeter and return the string component of the given index.
# + receiver - The string to be split
# + delimeter - Delimeter used to split the string
# + index - Index of the string component which should be returned
# + return - String component
isolated function split(string receiver, string delimeter, int index) returns string {
    string[] resultArray = regex:split(receiver, delimeter);
    return resultArray[index];
}

// GraphQL Query Formulation Methods

isolated function getFormulatedStringQueryForGetUser(string? username = ()) returns string {
    if username is string {
        return string `{"variables":{"userName":"${username}"},"query":"`
                    + string `${GET_USER}"}`;
    } else {
        return string `{"query":"${GET_AUTHENTICATED_USER_QUERY}"}`;
    }
}

isolated function getFormulatedStringQueryForGetLastCommit(string username, string repositoryName,
                                                                int pullRequestNumber) returns string {
    return string `{"variables":{"owner":"${username}", "name":"${repositoryName}",
                    "pullRequestNumber":${pullRequestNumber}},"query":"${GET_LAST_COMMIT}"}`;
}

isolated function getFormulatedStringQueryForGetLanguages(string username, string repositoryName, int perPageCount,
                                                        string? lastPageCursor = ()) returns string {
    if (lastPageCursor is string) {
        return string `{"variables":{"owner":"${username}", "name":"${repositoryName}", "perPageCount":${perPageCount}, 
                            "lastPageCursor": "${lastPageCursor}"},"query":"${GET_LANGUAGE_LIST}"}`;
    } else {
        return string `{"variables":{"owner":"${username}", "name":"${repositoryName}", "perPageCount":${perPageCount}, 
                            "lastPageCursor":null},"query":"${GET_LANGUAGE_LIST}"}`;
    }
}

isolated function getFormulatedStringQueryForGetRepository(string username, string repositoryName) returns string {
    return string `{"variables":{"owner":"${username}", "name":"${repositoryName}"},"query":"${GET_REPOSIOTRY}"}`;
}

isolated function getFormulatedStringQueryForGetRepositoryContent(string username, string repositoryName, string expression) returns string {
    return string `{"variables":{"owner":"${username}", "name":"${repositoryName}", "expr": "${expression}"},"query":"${GET_REPOSITORY_CONTENT}"}`;
}

isolated function getFormulatedStringQueryForGetRepositoryList(int perPageCount, boolean isOrganization,
                                                                string? owner, string? lastPageCursor = ())
                                                                returns string {
    if (owner is string && isOrganization) {
        if (lastPageCursor is string) {
            return string `{"variables":{"organizationName":"${owner}", "perPageCount":${perPageCount}, 
                            "lastPageCursor":"${lastPageCursor}"},"query":"${GET_REPOSITORY_LIST_FOR_ORGANIZATION}"}`;
        } else {
            return string `{"variables":{"organizationName":"${owner}", "perPageCount":${perPageCount}, 
                            "lastPageCursor":null},"query":"${GET_REPOSITORY_LIST_FOR_ORGANIZATION}"}`;
        }
    } else if (owner is string && !isOrganization) {
        if (lastPageCursor is string) {
            return string `{"variables":{"username":"${owner}", "perPageCount":${perPageCount}, 
                            "lastPageCursor":"${lastPageCursor}"},"query":"${GET_REPOSITORY_LIST_FOR_USER}"}`;
        } else {
            return string `{"variables":{"username":"${owner}", "perPageCount":${perPageCount}, "lastPageCursor":null},
                            "query":"${GET_REPOSITORY_LIST_FOR_USER}"}`;
        }
    } else {
        if (lastPageCursor is string) {
            return string `{"variables":{"perPageCount":${perPageCount}, "lastPageCursor":"${lastPageCursor}"},
                            "query":"${GET_REPOSITORY_LIST_FOR_AUTHENTICATED_USER}"}`;
        } else {
            return string `{"variables":{"perPageCount":${perPageCount}, "lastPageCursor":null},
                            "query":"${GET_REPOSITORY_LIST_FOR_AUTHENTICATED_USER}"}`;
        }
    }
}

isolated function getFormulatedStringQueryForCreateRepository(CreateRepositoryInput createRepositoryInput)
                                                            returns string {
    return string `{"variables":{"createRepositoryInput": ${createRepositoryInput.toJsonString()}},
                    "query":"${CREATE_REPOSITORY}"}`;
}

isolated function getFormulatedStringQueryForUpdateRepository(UpdateRepositoryInput updateRepositoryInput)
                                                            returns string {
    return string `{"variables":{"updateRepositoryInput": ${updateRepositoryInput.toJsonString()}},
                    "query":"${UPDATE_REPOSITORY}"}`;
}

isolated function getFormulatedStringQueryForGetCollaboratorList(string username, string repositoryName,
                                                                            int perPageCount, string? lastPageCursor = ())
                                                                            returns string {
    if (lastPageCursor is string) {
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "perPageCount":${perPageCount}, "lastPageCursor":"${lastPageCursor}"},
                        "query":"${LIST_COLLOBORATORS}"}`;
    } else {
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${LIST_COLLOBORATORS}"}`;
    }
}

isolated function getFormulatedStringQueryForGetBranches(string username, string repositoryName,
                                                                    int perPageCount, string? lastPageCursor = ())
                                                                    returns string {
    if (lastPageCursor is string) {
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "perPageCount":${perPageCount}, "lastPageCursor":"${lastPageCursor}"},
                        "query":"${GET_BRANCH_LIST}"}`;
    } else {
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${GET_BRANCH_LIST}"}`;
    }
}

isolated function getFormulatedStringQueryForGetIssueListAssignedToUser(string repositoryOwnerName,
                                                                        string repositoryName, string assignee,
                                                                        int perPageCount, string? lastPageCursor = ())
                                                                        returns string {

    if (lastPageCursor is string) {
        return string `{"variables":{"owner":"${repositoryOwnerName}", "name":"${repositoryName}", 
                        "assignee":"${assignee}", "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_ISSUE_LIST_ASSIGNED_TO_USER}"}`;
    } else {
        return string `{"variables":{"owner":"${repositoryOwnerName}", "name":"${repositoryName}", 
                        "assignee":"${assignee}", "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${GET_ISSUE_LIST_ASSIGNED_TO_USER}"}`;
    }
}

isolated function getFormulatedStringQueryForGetIssueList(string repositoryOwnerName, string repositoryName,
                                                        int perPageCount, string? lastPageCursor,
                                                        IssueFilters issueFilters) returns string {
    if (lastPageCursor is string) {
        return string `{"variables":{"owner":"${repositoryOwnerName}","name":"${repositoryName}",
                        "issueFilters":${issueFilters.toBalString()}, "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":" ${GET_ISSUE_LIST}"}`;
    } else {
        return string `{"variables":{"owner":"${repositoryOwnerName}","name":"${repositoryName}",
                        "issueFilters":${issueFilters.toBalString()}, "perPageCount":${perPageCount},
                        "lastPageCursor":null},"query":" ${GET_ISSUE_LIST}"}`;
    }

}

isolated function getFormulatedStringQueryForCreateIssue(CreateIssueInputPayload createIssueInput) returns string {
    return string `{"variables":{"createIssueInput": ${createIssueInput.toJsonString()}},"query":"${CREATE_ISSUE}"}`;
}

isolated function getFormulatedStringQueryForUpdateIssue(UpdateIssueInputPayload updateIssueInput) returns string {
    return string `{"variables":{"updateIssueInput": ${updateIssueInput.toJsonString()}},"query":"${UPDATE_ISSUE}"}`;
}

isolated function getFormulatedStringQueryForGetIssue(string repositoryOwnerName, string repositoryName,
                                                                int issueNumber) returns string {
    return string `{"variables":{"owner":"${repositoryOwnerName}", "name":"${repositoryName}", 
                    "issueNumber":${issueNumber}},"query":"${GET_ISSUE}"}`;
}

isolated function getFormulatedStringQueryForGetIssueCommentList(string username, string repositoryName,
                                                                int issueNumber, int perPageCount,
                                                                string? lastPageCursor = ()) returns string {
    if (lastPageCursor is string) {
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "issueNumber":${issueNumber}, "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_COMMENT_ISSUE_COMMENT_LIST}"}`;
    } else {
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "issueNumber":${issueNumber}, "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${GET_COMMENT_ISSUE_COMMENT_LIST}"}`;
    }
}

isolated function getFormulatedStringQueryForAddComment(AddCommentInput addCommentInput) returns string {
    return string `{"variables":{"addCommentInput": ${addCommentInput.toJsonString()}},"query":"${ADD_COMMENT}"}`;
}

isolated function getFormulatedStringQueryForUpdateIssueComment(UpdateIssueCommentInput updateIssueCommentInput)
                                                                returns string {
    return string `{"variables":{"updateIssueCommentInput": ${updateIssueCommentInput.toJsonString()}},
                    "query":"${UPDATE_ISSUE_COMMENT}"}`;
}

isolated function getFormulatedStringQueryForDeleteIssueComment(DeleteIssueCommentInput deleteIssueCommentInput)
                                                                returns string {
    return string `{"variables":{"deleteIssueCommentInput": ${deleteIssueCommentInput.toJsonString()}},
                    "query":"${DELETE_ISSUE_COMMENT}"}`;
}

isolated function getFormulatedStringQueryForCreateLabel(CreateLabelInput createLabelInput) returns string {
    return string `{"variables":{"createLabelInput": ${createLabelInput.toJsonString()}},"query":"${CREATE_LABEL}"}`;
}

isolated function getFormulatedStringQueryForGetLabel(string username, string repositoryName, string labelName)
                                                    returns string {
    return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                    "labelName": "${labelName}"},"query":"${GET_A_REPOSITORY_LABEL}"}`;
}

isolated function getFormulatedStringQueryForUpdateLabel(UpdateLabelInput updateLabelInput) returns string {
    return string `{"variables":{"updateLabelInput": ${updateLabelInput.toJsonString()}},"query":"${UPDATE_LABEL}"}`;
}

isolated function getFormulatedStringQueryForDeleteLabel(DeleteLabelInput deleteLabelInput) returns string {
    return string `{"variables":{"deleteLabelInput": ${deleteLabelInput.toJsonString()}},"query":"${DELETE_LABEL}"}`;
}

isolated function getFormulatedStringQueryForGetAllLabelsForAIssue(string username, string repositoryName,
                                                                    int issueNumber, int perPageCount,
                                                                    string? lastPageCursor = ()) returns string {
    if (lastPageCursor is string) {
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "issueNumber":${issueNumber}, "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_ALL_LABELS_FOR_A_ISSUE}"}`;
    } else {
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "issueNumber":${issueNumber}, "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${GET_ALL_LABELS_FOR_A_ISSUE}"}`;
    }
}

isolated function getFormulatedStringQueryForAddLabelsToLabelable(AddLabelsToLabelableInput addLabelsToLabelable)
                                                                returns string {
    return string `{"variables":{"addLabelsToLabelableInput": ${addLabelsToLabelable.toJsonString()}},
                    "query":"${ADD_LABELS_TO_LABELABLE}"}`;
}

isolated function getFormulatedStringQueryForRemoveLabelsFromLabelable(RemoveLabelsFromLabelableInput
                                                                        removeLabelsFromLabelable)
                                                                        returns string {
    return string `{"variables":{"removeLabelsFromLabelableInput": ${removeLabelsFromLabelable.toJsonString()}},
                    "query":"${REMOVE_LABELS_TO_LABELABLE}"}`;
}

isolated function getFormulatedStringQueryForGetMilestones(string username, string repositoryName,
                                                                            int perPageCount, string? lastPageCursor = ())
                                                                            returns string {
    if (lastPageCursor is string) {
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}",  
                        "perPageCount":${perPageCount}, "lastPageCursor":"${lastPageCursor}"},
                        "query":"${LIST_MILESTONES}"}`;
    } else {
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}",  
                        "perPageCount":${perPageCount}, "lastPageCursor":null},"query":"${LIST_MILESTONES}"}`;
    }
}

isolated function getFormulatedStringQueryForGetAMilestone(string username, string repositoryName, int milestoneNumber)
                                                            returns string {
    return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}",  
                    "milestoneNumber":${milestoneNumber}},"query":"${GET_A_MILESTONE}"}`;
}

isolated function getFormulatedStringQueryForGetAPullRequest(string username, string repositoryName,
                                                            int pullRequestNumber) returns string {
    return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                    "pullRequestNumber":${pullRequestNumber}},"query":"${GET_A_PULL_REQUEST}"}`;
}

isolated function getFormulatedStringQueryForGetPullRequestList(string repositoryOwner, string repositoryName,
                                                                PullRequestState state, int perPageCount,
                                                                string? lastPageCursor = ()) returns string {

    if (lastPageCursor is string) {
        return string `{"variables":{"owner":"${repositoryOwner}","name":"${repositoryName}",
                        "states":${state.toBalString()}, ` + string `"perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_PULL_REQUESTS_LIST}"}`;
    } else {
        return string `{"variables":{"owner":"${repositoryOwner}","name":"${repositoryName}",
                        "states":${state.toBalString()}, ` + string `"perPageCount":${perPageCount}, 
                        "lastPageCursor":null},"query":"${GET_PULL_REQUESTS_LIST}"}`;
    }
}

isolated function getFormulatedStringQueryForGetReviewListForRepository(string username, string repositoryName,
                                                                        int pullRequestNumber, int perPageCount,
                                                                        string? lastPageCursor = ()) returns string {
    if (lastPageCursor is string) {
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}",    
                        "pullRequestNumber":${pullRequestNumber}, "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${PULL_REQUEST_REVIEW_LIST}"}`;
    } else {
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "pullRequestNumber":${pullRequestNumber}, "perPageCount":${perPageCount}, 
                        "lastPageCursor":null},"query":"${PULL_REQUEST_REVIEW_LIST}"}`;
    }
}

isolated function getFormulatedStringQueryForCreatePullRequest(CreatePullRequestInput createPullRequestInput)
                                                                returns string {
    return string `{"variables":{"createPullRequestInput": ${createPullRequestInput.toJsonString()}},
                    "query":"${CREATE_PULL_REQUEST}"}`;
}

isolated function getFormulatedStringQueryForUpdatePullRequest(UpdatePullRequestInputPayload updatePullRequestInput)
                                                                returns string {
    return string `{"variables":{"updatePullRequestInput": ${updatePullRequestInput.toJsonString()}},
                    "query":"${UPDATE_PULL_REQUEST}"}`;
}

isolated function getFormulatedStringQueryForAddPullRequestReview(AddPullRequestReviewInput addPullRequestReview)
                                                                returns string {
    return string `{"variables":{"addPullRequestReview": ${addPullRequestReview.toJsonString()}},
                    "query":"${ADD_PULL_REQUEST_REVIEW}"}`;
}

isolated function getFormulatedStringQueryForUpdatePullRequestReview(UpdatePullRequestReviewInput
                                                                    updatePullRequestReview) returns string {
    return string `{"variables":{"updatePullRequestReview": ${updatePullRequestReview.toJsonString()}},
                    "query":"${UPDATE_PULL_REQUEST_REVIEW}"}`;
}

isolated function getFormulatedStringQueryForDeletePullRequestReview(DeletePullRequestReviewInput
                                                                    deletePullRequestReview) returns string {
    return string `{"variables":{"deletePullRequestReview": ${deletePullRequestReview.toJsonString()}},
                    "query":"${DELETE_PULL_REQUEST_REVIEW}"}`;
}

isolated function getFormulatedStringQueryForOrgProjectList(string organizationName, ProjectState? state,
                                                            int perPageCount, string? lastPageCursor = ())
                                                            returns string {
    if (lastPageCursor is string) {
        if (state is ProjectState) {
            return string `{"variables":{"organization":"${organizationName}", "states":${state.toBalString()}, 
                        "perPageCount":${perPageCount}, "lastPageCursor":"${lastPageCursor}"},
                        "query":"${GET_ORGANIZATION_PROJECT_LIST}"}`;
        } else {
            return string `{"variables":{"organization":"${organizationName}", "states":null, 
                        "perPageCount":${perPageCount}, "lastPageCursor":"${lastPageCursor}"},
                        "query":"${GET_ORGANIZATION_PROJECT_LIST}"}`;
        }
    } else {
        if (state is ProjectState) {
            return string `{"variables":{"organization":"${organizationName}", "states":${state.toBalString()}, 
                        "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${GET_ORGANIZATION_PROJECT_LIST}"}`;
        } else {
            return string `{"variables":{"organization":"${organizationName}", "states":null, 
                        "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${GET_ORGANIZATION_PROJECT_LIST}"}`;
        }
    }
}

isolated function getFormulatedStringQueryForCreateProject(CreateProjectInput createProjectInput) returns string {
    return string `{"variables":{"createProjectInput": ${createProjectInput.toJsonString()}},
                    "query":"${CREATE_PROJECT}"}`;
}

isolated function getFormulatedStringQueryForGetAProject(string username, int projectNumber) returns string {
    return string `{"variables":{"username":"${username}", "projectNumber":${projectNumber}},
                    "query":"${GET_USER_PROJECT}"}`;
}

isolated function getFormulatedStringQueryForUpdateProject(UpdateProjectInput updateProjectInput) returns string {
    return string `{"variables":{"updateProjectInput": ${updateProjectInput.toJsonString()}},
                    "query":"${UPDATE_PROJECT}"}`;
}

isolated function getFormulatedStringQueryForDeleteProject(DeleteProjectInput deleteProjectInput) returns string {
    return string `{"variables":{"deleteProjectInput": ${deleteProjectInput.toJsonString()}},
                    "query":"${DELETE_PROJECT}"}`;
}

isolated function getFormulatedStringQueryForRepositoryProjectList(string repositoryOwner, string repositoryName,
                                                                    ProjectState? state, int perPageCount,
                                                                    string? lastPageCursor = ()) returns string {

    if (lastPageCursor is string) {
        if (state is ProjectState) {
            return string `{"variables":{"owner":"${repositoryOwner}","repository":"${repositoryName}",` +
                string `"states":${state.toBalString()},"perPageCount":${perPageCount}, 
                "lastPageCursor":"${lastPageCursor}"},"query":"${GET_REPOSITORY_PROJECT_LIST}"}`;
        } else {
            return string `{"variables":{"owner":"${repositoryOwner}","repository":"${repositoryName}",` +
                string `"states":null,"perPageCount":${perPageCount}, 
                "lastPageCursor":"${lastPageCursor}"},"query":"${GET_REPOSITORY_PROJECT_LIST}"}`;
        }

    } else {
        if (state is ProjectState) {
            return string `{"variables":{"owner":"${repositoryOwner}","repository":"${repositoryName}",` +
                string `"states":${state.toBalString()},"perPageCount":${perPageCount}, "lastPageCursor":null},
               "query":"${GET_REPOSITORY_PROJECT_LIST}"}`;
        } else {
            return string `{"variables":{"owner":"${repositoryOwner}","repository":"${repositoryName}",` +
                string `"states":null,"perPageCount":${perPageCount}, "lastPageCursor":null},
               "query":"${GET_REPOSITORY_PROJECT_LIST}"}`;
        }

    }
}

isolated function getFormulatedStringQueryForGetUserProjectList(string username, int perPageCount,
                                                                string? lastPageCursor = ()) returns string {
    if (lastPageCursor is string) {
        return string `{"variables":{"username":"${username}", "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_USER_PROJECT_LIST}"}`;
    } else {
        return string `{"variables":{"username":"${username}", "perPageCount":${perPageCount}, 
                        "lastPageCursor":null},"query":"${GET_USER_PROJECT_LIST}"}`;
    }
}

isolated function getFormulatedStringQueryForGetAnOrganization(string organizationName) returns string {
    return string `{"variables":{"organization":"${organizationName}"},"query":"`
                    + string `${GET_ORG}"}`;
}

isolated function getFormulatedStringQueryForGetOrganizationMemberList(string organizationName, int perPageCount,
                                                                        string? lastPageCursor = ()) returns string {
    if (lastPageCursor is string) {
        return string `{"variables":{"organizationName":"${organizationName}", "perPageCount":${perPageCount},
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_ORGANIZATION_MEMBERS_LIST}"}`;
    } else {
        return string `{"variables":{"organizationName":"${organizationName}", "perPageCount":${perPageCount},
                        "lastPageCursor":null},"query":"${GET_ORGANIZATION_MEMBERS_LIST}"}`;
    }
}

isolated function getFormulatedStringQueryForGetUserOrganizationList(string username, int perPageCount,
                                                                    string? lastPageCursor = ()) returns string {
    if (lastPageCursor is string) {
        return string `{"variables":{"username":"${username}", "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_USER_ORGANIZATION_LIST}"}`;
    } else {
        return string `{"variables":{"username":"${username}", "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${GET_USER_ORGANIZATION_LIST}"}`;
    }
}

isolated function getFormulatedStringQueryForGetRepositoryId(string repositoryOwnerName, string repositoryName)
                                                            returns string {
    return string `{"variables":{"repositoryOwnerName":"${repositoryOwnerName}", 
                    "repositoryName": "${repositoryName}"},"query":"`
                    + string `${GET_REPOSITORY_ID}"}`;
}

isolated function getFormulatedStringQueryForGetIssueId(string repositoryOwnerName, string repositoryName,
                                                        int issueNumber) returns string {
    return string `{"variables":{"repositoryOwnerName":"${repositoryOwnerName}", 
                    "repositoryName": "${repositoryName}", "issueNumber":${issueNumber}},"query":"`
                    + string `${GET_ISSUE_ID}"}`;
}

isolated function getFormulatedStringQueryForGetPullRequestId(string repositoryOwnerName, string repositoryName,
                                                            int pullRequestNumber) returns string {
    return string `{"variables":{"repositoryOwnerName":"${repositoryOwnerName}", "repositoryName": "${repositoryName}",
                    "pullRequestNumber":${pullRequestNumber}},"query":"`
                    + string `${GET_PULL_REQUEST_ID}"}`;
}

//isolated function getFormulatedStringQueryForGetPullRequestId(string repositoryOwnerName, string repositoryName)
// returns string {
//    return string `{"variables":{"repositoryOwnerName":"${repositoryOwnerName}", "repositoryName": "${repositoryName}
//"},"query":"`
//                      + string `${GET_REPOSITORY_ID}"}`;
//}

isolated function getFormulatedStringQueryForGetProjectId(string repositoryOwnerName, string repositoryName,
                                                        int projectNumber) returns string {
    return string `{"variables":{"repositoryOwnerName":"${repositoryOwnerName}", "repositoryName": "${repositoryName}",
                    "projectNumber":${projectNumber}},"query":"`
                    + string `${GET_PROJECT_ID}"}`;
}

isolated function getFormulatedStringQueryForGetUserOwnerId(string userName) returns string {
    return string `{"variables":{"userName":"${userName}"},"query":"`
                    + string `${GET_USER_OWNER_ID}"}`;
}

isolated function getFormulatedStringQueryForSearch(string searchQuery, SearchType searchType, int perPageCount,
                                                    string? lastPageCursor) returns string {
    string query = searchQuery.indexOf(string `"`) !is () ? regex:replaceAll(searchQuery, string `"`, string `\\"`) : 
    searchQuery;
    if lastPageCursor is string {
        return string `{"variables":{"searchQuery":"${query}", "searchType": ${searchType.toBalString()},
                    "perPageCount":${perPageCount}, "lastPageCursor":"${lastPageCursor}"},"query":"`
                    + string `${SEARCH}"}`;
    } else {
        return string `{"variables":{"searchQuery":"${query}", "searchType": ${searchType.toBalString()},
                    "perPageCount":${perPageCount}, "lastPageCursor":null},"query":"`
                    + string `${SEARCH}"}`;
    }
}

// get resource id utl functions

isolated function getRepositoryId(string repositoryOwnerName, string repositoryName, string accessToken,
                                http:Client graphQlClient) returns @tainted string|Error {
    string stringQuery = getFormulatedStringQueryForGetRepositoryId(repositoryOwnerName, repositoryName);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repo = graphQlData.get(GIT_REPOSITORY);
        if (repo is map<json>) {
            json repoId = repo.get(GIT_ID);
            return repoId.toBalString();
        }
        return error ClientError("GitHub Client Error", body = repo);
    }
    return graphQlData;
}

isolated function getIssueId(string repositoryOwnerName, string repositoryName, int issueNumber, string accessToken,
                            http:Client graphQlClient) returns @tainted string|Error {
    string stringQuery = getFormulatedStringQueryForGetIssueId(repositoryOwnerName, repositoryName, issueNumber);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repo = graphQlData.get(GIT_REPOSITORY);
        if (repo is map<json>) {
            json issue = repo.get(GIT_ISSUE);
            if issue is map<json> {
                json issueId = issue.get(GIT_ID);
                return issueId.toBalString();
            }
            return error ClientError("GitHub Client Error", body = issue);
        }
        return error ClientError("GitHub Client Error", body = repo);
    }
    return graphQlData;
}

isolated function getPullRequestId(string repositoryOwnerName, string repositoryName, int pullRequestNumber,
                                    string accessToken, http:Client graphQlClient) returns @tainted string|Error {
    string stringQuery = getFormulatedStringQueryForGetPullRequestId(repositoryOwnerName, repositoryName,
                                                                    pullRequestNumber);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repo = graphQlData.get(GIT_REPOSITORY);
        if (repo is map<json>) {
            json pr = repo.get(GIT_PULL_REQUEST);
            if pr is map<json> {
                json prId = pr.get(GIT_ID);
                return prId.toBalString();
            }
            return error ClientError("GitHub Client Error", body = pr);
        }
        return error ClientError("GitHub Client Error", body = repo);
    }
    return graphQlData;
}

isolated function getUserId(string userName, string accessToken, http:Client graphQlClient)
                            returns @tainted string|Error {
    string stringQuery = getFormulatedStringQueryForGetUserOwnerId(userName);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json user = graphQlData.get(GIT_USER);
        if (user is map<json>) {
            json userId = user.get(GIT_ID);
            return userId.toBalString();
        }
        return error ClientError("GitHub Client Error", body = user);
    }
    return graphQlData;
}

isolated function getGraphQlData(http:Client githubGraphQlClient, string authToken, string stringQuery)
                                returns map<json>|Error {

    json|error convertedQuery = stringToJson(stringQuery);
    if convertedQuery is error {
        return error ClientError("GitHub Client Error", convertedQuery);
    }
    //Set headers and payload to the request
    http:Request request = new;
    setHeader(request, authToken);
    constructRequest(request, <@untainted>convertedQuery.cloneReadOnly());

    json|http:ClientError httpResponse = githubGraphQlClient->post(EMPTY_STRING, request);

    do {
        if httpResponse is http:ClientError {
            if (httpResponse is http:ApplicationResponseError) {
                anydata data = check httpResponse.detail().get("body").ensureType(anydata);
                return error ClientError("GitHub Client Error", body = data);
            }
            return error ClientError("GitHub Client Error", httpResponse);
        } else {
            map<json> responseMap = <map<json>>httpResponse;

            if (responseMap.hasKey("errors")) {
                GraphQLClientError[] errors = check responseMap.get("errors").cloneWithType(GraphQLClientErrorArray);

                if (responseMap.hasKey("data") && !responseMap.hasKey("extensions")) {
                    return error ServerError("GitHub Server Error", data = responseMap.get("data"), errors = errors);
                } else if (responseMap.hasKey("extensions") && !responseMap.hasKey("data")) {
                    map<json>? extensionsMap =
                    (responseMap.get("extensions") is ()) ? () : <map<json>>responseMap.get("extensions");
                    return error ServerError("GitHub Server Error", errors = errors, extensions = extensionsMap);
                } else if (responseMap.hasKey("data") && responseMap.hasKey("extensions")) {
                    map<json>? extensionsMap =
                    (responseMap.get("extensions") is ()) ? () : <map<json>>responseMap.get("extensions");
                    return error ServerError("GitHub Server Error", data = responseMap.get("data"), errors = errors,
                    extensions = extensionsMap);
                } else {
                    return error ServerError("GitHub Server Error", errors = errors);
                }
            } else {
                json responseData = responseMap.get("data");
                if (responseMap.hasKey("extensions")) {
                    responseData = check responseData.mergeJson({"extensions": responseMap.get("extensions")});
                }

                if responseData is map<json> {
                    return responseData;
                } else {
                    return error ClientError("GitHub Client Error", body = responseData);
                }
            }
        }
    } on fail var e {
        return error ClientError("GitHub Client Error", e);
    }
}
