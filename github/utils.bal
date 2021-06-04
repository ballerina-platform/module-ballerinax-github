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
import ballerina/lang.'string as strings;
//import ballerina/io;

# Construct the request by adding the payload and authorization tokens.
# + request - HTTP request object
# + stringQuery - GraphQL API query
isolated function constructRequest(http:Request request, json stringQuery) {
    request.setJsonPayload(stringQuery);
}

# Validate the HTTP response and return payload or error.
# + response - HTTP response object or HTTP Connector error
# + return - `json` payload of the response or Connector error
isolated function getValidatedResponse(http:Response|http:PayloadType|error response) returns @tainted json | error {

    if (response is http:Response) {
        var jsonPayload = response.getJsonPayload();
        if (jsonPayload is json) {
            string[] payLoadKeys = [];
            map<json> mapJsonPayload = <map<json>> jsonPayload;
            payLoadKeys = mapJsonPayload.keys();
            //Check all the keys in the payload to see if an error is returned.
            foreach var key in payLoadKeys {
                if (strings:equalsIgnoreCaseAscii(GIT_ERRORS, key)) {
                    var errorList = mapJsonPayload[GIT_ERRORS];
                    if (errorList is json[]) {
                        int i = 0;
                        foreach var singleError in errorList {
                            map<json> mapSingleerror = <map<json>> singleError;
                            string errorMessage = mapSingleerror[GIT_MESSAGE].toString();
                            string errMessage = string ` ${GITHUB_ERROR_CODE} : ${errorMessage}`;
                            error err = error(errMessage, message = errorMessage);
                            return err;
                        }
                    } else {
                        string errorMessage = string ` ${GITHUB_ERROR_CODE} : Error occurred while accessing the Json payload of the response.`;
                        error err = error(errorMessage,
                        message = "Error occurred while accessing the Json payload of the response.");
                        return err;
                    }
                }

                if (strings:equalsIgnoreCaseAscii(GIT_MESSAGE, key)) {
                    string errorMessage = string ` ${GITHUB_ERROR_CODE} : ${mapJsonPayload[GIT_MESSAGE].toString()}`;
                    error err = error(errorMessage, message = mapJsonPayload[GIT_MESSAGE].toString());
                    return err;
                }
            }

            //If no error is returned, then check if the response contains the requested data.
            string[] keySet = [];
            var data = mapJsonPayload[GIT_DATA];
            if (data is map<json>) {
                keySet = data.keys();
            }
            map<json> mapJsondata = <map<json>> data;
            string keyInData = keySet[INDEX_ZERO];
            map<json> output = <map<json>> mapJsondata[keyInData];
            return jsonPayload;
        } else {
            string errorMessage = string `${GITHUB_ERROR_CODE}: Entity body is not json compatible since the received content-type is : null`;
            error err = error(errorMessage,
            message = "Entity body is not json compatible since the received content-type is : null");
            return err;
        }
    } else {
        string errorMessage = string ` ${GITHUB_ERROR_CODE} : HTTP Connector Error`;
        error err = error(errorMessage, message = "HTTP Connector Error");
        return err;
    }
}

# Validate the REST HTTP response and return payload or error.
# + response - HTTP response object or HTTP Connector error
# + return - `json` payload of the response or Connector error
isolated function getValidatedRestResponse(http:Response|http:PayloadType|error response) returns json | error {
    if (response is http:Response) {
        var payload = response.getJsonPayload();
        if (payload is json) {
            map<json> mapPayload = <map<json>> payload;
            if (mapPayload["message"] == null) {
                return <@untainted>payload;
            } else {
                error err = error(GITHUB_ERROR_CODE, message = mapPayload["message"].toString());
                return <@untainted>err;
            }
        } else {
            error err = error(GITHUB_ERROR_CODE,
            message = "Entity body is not json compatible since the received content-type is : null");
            return err;
        }
    } else {
        error err = error(GITHUB_ERROR_CODE, message = "HTTP Connector Error");
        return err;
    }
}

# Set Auth header
# + request - HTTP Request where the header needs to be set
# + accessToken - Access token
isolated function setHeader(http:Request request, string accessToken){
    request.setHeader("Authorization", "token " + accessToken);
}

# Convert string representation of JSON object to JSON object.
# + src - String representation of the JSON object
# + return - Converted `json` object or Connector error
isolated function stringToJson(string src) returns json | error {
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

isolated function getFormulatedStringQueryForGetAuthenticatedUser() returns string {
    return string `{"query":"${GET_AUTHENTICATED_USER_QUERY}"}`;
}

isolated function getFormulatedStringQueryForGetRepository(string username, string repositoryName) returns string {
    return string `{"variables":{"owner":"${username}", "name":"${repositoryName}"},"query":"${GET_REPOSIOTRY}"}`;
}

isolated function getFormulatedStringQueryForGetAuthenticatedUserRepositoryList(int perPageCount, 
                                                                                string? lastPageCursor=()) 
                                                                                returns string {

    if (lastPageCursor is string){
        return string `{"variables":{"perPageCount":${perPageCount}, "lastPageCursor":"${lastPageCursor}"},
                        "query":"${GET_REPOSITORY_LIST_FOR_AUTHENTICATED_USER}"}`;
    }else{
        return string `{"variables":{"perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${GET_REPOSITORY_LIST_FOR_AUTHENTICATED_USER}"}`;
    }
}

isolated function getFormulatedStringQueryForGetUserRepositoryList(string username, int perPageCount, 
                                                                   string? lastPageCursor=()) returns string {

    if (lastPageCursor is string){
        return string `{"variables":{"username":"${username}", "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_REPOSITORY_LIST_FOR_USER}"}`;
    }else{
        return string `{"variables":{"username":"${username}", "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${GET_REPOSITORY_LIST_FOR_USER}"}`;
    }
}

isolated function getFormulatedStringQueryForGetOrganizationRepositoryList(string organizationName, int perPageCount,
                                                                           string? lastPageCursor=()) returns string {

    if (lastPageCursor is string){
        return string `{"variables":{"organizationName":"${organizationName}", "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_REPOSITORY_LIST_FOR_ORGANIZATION}"}`;
    }else{
        return string `{"variables":{"organizationName":"${organizationName}", "perPageCount":${perPageCount}, 
                        "lastPageCursor":null},"query":"${GET_REPOSITORY_LIST_FOR_ORGANIZATION}"}`;
    }
}

isolated function getFormulatedStringQueryForUpdateRepository(UpdateRepositoryInput updateRepositoryInput) 
                                                              returns string {
    return string `{"variables":{"updateRepositoryInput": ${updateRepositoryInput.toJsonString()}},
                    "query":"${UPDATE_REPOSITORY}"}`;
}

isolated function getFormulatedStringQueryForGetRepositoryCollaboratorList(string username, string repositoryName, 
                                                                           int perPageCount, string? lastPageCursor=()) 
                                                                           returns string {
    if (lastPageCursor is string){
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "perPageCount":${perPageCount}, "lastPageCursor":"${lastPageCursor}"},
                        "query":"${LIST_REPOSITORY_COLLOBORATORS}"}`;
    }else{
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${LIST_REPOSITORY_COLLOBORATORS}"}`;
    }
}

isolated function getFormulatedStringQueryForGetRepositoryBranchList(string username, string repositoryName, 
                                                                     int perPageCount, string? lastPageCursor=()) 
                                                                     returns string {
    if (lastPageCursor is string){
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "perPageCount":${perPageCount}, "lastPageCursor":"${lastPageCursor}"},
                        "query":"${GET_BRANCH_LIST_OF_A_REPOSITORY}"}`;
    }else{
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${GET_BRANCH_LIST_OF_A_REPOSITORY}"}`;
    }
}

isolated function getFormulatedStringQueryForGetIssueListAssignedToUser(string repositoryOwnerName, 
                                                                        string repositoryName, string assignee, 
                                                                        int perPageCount, string? lastPageCursor = ())
                                                                        returns string {

    if (lastPageCursor is string){
        return string `{"variables":{"owner":"${repositoryOwnerName}", "name":"${repositoryName}", 
                        "assignee":"${assignee}", "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_ISSUE_LIST_ASSIGNED_TO_USER}"}`;
    }else{
        return string `{"variables":{"owner":"${repositoryOwnerName}", "name":"${repositoryName}", 
                        "assignee":"${assignee}", "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${GET_ISSUE_LIST_ASSIGNED_TO_USER}"}`;
    }
}

isolated function getFormulatedStringQueryForGetIssueList(string repositoryOwnerName, string repositoryName, 
                                                          string[] state, int perPageCount, 
                                                          string? lastPageCursor = ()) returns string {
    if (lastPageCursor is string){
        return string `{"variables":{"owner":"${repositoryOwnerName}","name":"${repositoryName}",
                        "states":${state.toBalString()}, "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":" ${GET_ISSUE_LIST}"}`;
    }else{
        return string `{"variables":{"owner":"${repositoryOwnerName}","name":"${repositoryName}",
                        "states":${state.toBalString()}, "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":" ${GET_ISSUE_LIST}"}`;
    }

}

isolated function getFormulatedStringQueryForCreateIssue(CreateIssueInputPayload createIssueInput) returns string {
    return string `{"variables":{"createIssueInput": ${createIssueInput.toJsonString()}},"query":"${CREATE_ISSUE}"}`;
}

isolated function getFormulatedStringQueryForUpdateIssue( UpdateIssueInputPayload updateIssueInput) returns string {
    return string `{"variables":{"updateIssueInput": ${updateIssueInput.toJsonString()}},"query":"${UPDATE_ISSUE}"}`;
}


isolated function getFormulatedStringQueryForGetRepositoryIssue(string repositoryOwnerName, string repositoryName, 
                                                                int issueNumber) returns string {
    return string `{"variables":{"owner":"${repositoryOwnerName}", "name":"${repositoryName}", 
                    "issueNumber":${issueNumber}},"query":"${GET_ISSUE}"}`;
}






isolated function getFormulatedStringQueryForGetIssueCommentList(string username, string repositoryName, 
                                                                 int issueNumber, int perPageCount, 
                                                                 string? lastPageCursor=()) returns string {
    if (lastPageCursor is string){
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "issueNumber":${issueNumber}, "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_COMMENT_ISSUE_COMMENT_LIST}"}`;
    }else{
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "issueNumber":${issueNumber}, "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${GET_COMMENT_ISSUE_COMMENT_LIST}"}`;
    }
}

isolated function getFormulatedStringQueryForAddComment( AddCommentInput addCommentInput) returns string {
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

isolated function getFormulatedStringQueryForCreateLabel( CreateLabelInput createLabelInput) returns string {
    return string `{"variables":{"createLabelInput": ${createLabelInput.toJsonString()}},"query":"${CREATE_LABEL}"}`;
}

isolated function getFormulatedStringQueryForGetLabel(string username, string repositoryName, string labelName) 
                                                      returns string {
    return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                    "labelName": "${labelName}"},"query":"${GET_A_REPOSITORY_LABEL}"}`;
}

isolated function getFormulatedStringQueryForUpdateLabel( UpdateLabelInput updateLabelInput) returns string {
    return string `{"variables":{"updateLabelInput": ${updateLabelInput.toJsonString()}},"query":"${UPDATE_LABEL}"}`;
}

isolated function getFormulatedStringQueryForDeleteLabel( DeleteLabelInput deleteLabelInput) returns string {
    return string `{"variables":{"deleteLabelInput": ${deleteLabelInput.toJsonString()}},"query":"${DELETE_LABEL}"}`;
}

isolated function getFormulatedStringQueryForGetAllLabelsForAIssue(string username, string repositoryName, 
                                                                   int issueNumber, int perPageCount, 
                                                                   string? lastPageCursor=()) returns string {
    if (lastPageCursor is string){
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "issueNumber":${issueNumber}, "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_ALL_LABELS_FOR_A_ISSUE}"}`;
    }else{
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

isolated function getFormulatedStringQueryForGetIssueListWithLabel(string username, string repositoryName, 
                                                                   string labelName, int perPageCount, 
                                                                   string? lastPageCursor=()) returns string {
    if (lastPageCursor is string){
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "labelName":"${labelName}", "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_REPOSITORY_ISSUES_WITH_LABEL}"}`;
    }else{
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}", 
                        "labelName":"${labelName}", "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${GET_REPOSITORY_ISSUES_WITH_LABEL}"}`;
    }
}

isolated function getFormulatedStringQueryForGetMilestoneListOfARepository(string username, string repositoryName, 
                                                                           int perPageCount, string? lastPageCursor=())
                                                                           returns string {
    if (lastPageCursor is string){
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}",  
                        "perPageCount":${perPageCount}, "lastPageCursor":"${lastPageCursor}"},
                        "query":"${LIST_MILESTONES}"}`;
    }else{
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
                                                                string? lastPageCursor=()) returns string {

    if (lastPageCursor is string){
        return string `{"variables":{"owner":"${repositoryOwner}","name":"${repositoryName}",
                        "states":${state.toBalString()}, ` + string `"perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_PULL_REQUESTS_LIST}"}`;
    }else{
        return string `{"variables":{"owner":"${repositoryOwner}","name":"${repositoryName}",
                        "states":${state.toBalString()}, ` + string `"perPageCount":${perPageCount}, 
                        "lastPageCursor":null},"query":"${GET_PULL_REQUESTS_LIST}"}`;
    }
}


isolated function getFormulatedStringQueryForGetReviewListForRepository(string username, string repositoryName, 
                                                                        int pullRequestNumber, int perPageCount, 
                                                                        string? lastPageCursor=()) returns string {
    if (lastPageCursor is string){
        return string `{"variables":{"username":"${username}", "repositoryName":"${repositoryName}",    
                        "pullRequestNumber":${pullRequestNumber}, "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${PULL_REQUEST_REVIEW_LIST}"}`;
    }else{
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




isolated function getFormulatedStringQueryForOrgProjectList(string organizationName, ProjectState state, 
                                                            int perPageCount, string? lastPageCursor=()) 
                                                            returns string {
    if (lastPageCursor is string){
        return string `{"variables":{"organization":"${organizationName}", "states":${state.toBalString()}, 
                        "perPageCount":${perPageCount}, "lastPageCursor":"${lastPageCursor}"},
                        "query":"${GET_ORGANIZATION_PROJECT_LIST}"}`;
    }else{
        return string `{"variables":{"organization":"${organizationName}", "states":${state.toBalString()}, 
                        "perPageCount":${perPageCount}, "lastPageCursor":null},
                        "query":"${GET_ORGANIZATION_PROJECT_LIST}"}`;
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
                                                                   ProjectState state, int perPageCount, 
                                                                   string? lastPageCursor=()) returns string {

    if (lastPageCursor is string){
        return string `{"variables":{"owner":"${repositoryOwner}","repository":"${repositoryName}",` +
                string `"states":${state.toBalString()},"perPageCount":${perPageCount}, 
                "lastPageCursor":"${lastPageCursor}"},"query":"${GET_REPOSITORY_PROJECT_LIST}"}`;
    }else{
        return string `{"variables":{"owner":"${repositoryOwner}","repository":"${repositoryName}",` +
               string `"states":${state.toBalString()},"perPageCount":${perPageCount}, "lastPageCursor":null},
               "query":"${GET_REPOSITORY_PROJECT_LIST}"}`;
    }
}

isolated function getFormulatedStringQueryForGetUserProjectList(string username, int perPageCount, 
                                                                string? lastPageCursor=()) returns string {
    if (lastPageCursor is string){
        return string `{"variables":{"username":"${username}", "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_USER_PROJECT_LIST}"}`;
    }else{
        return string `{"variables":{"username":"${username}", "perPageCount":${perPageCount}, 
                        "lastPageCursor":null},"query":"${GET_USER_PROJECT_LIST}"}`;
    }
}




isolated function getFormulatedStringQueryForGetAnOrganization(string organizationName) returns string {
    return string `{"variables":{"organization":"${organizationName}"},"query":"`
                      + string `${GET_ORG}"}`;
}


isolated function getFormulatedStringQueryForGetOrganizationMemberList(string organizationName, int perPageCount, 
                                                                       string? lastPageCursor=()) returns string {
    if (lastPageCursor is string){
        return string `{"variables":{"organizationName":"${organizationName}", "perPageCount":${perPageCount},
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_ORGANIZATION_MEMBERS_LIST}"}`;
    }else{
        return string `{"variables":{"organizationName":"${organizationName}", "perPageCount":${perPageCount},
                        "lastPageCursor":null},"query":"${GET_ORGANIZATION_MEMBERS_LIST}"}`;
    }
}

isolated function getFormulatedStringQueryForGetUserOrganizationList(string username, int perPageCount, 
                                                                     string? lastPageCursor=()) returns string {
    if (lastPageCursor is string){
        return string `{"variables":{"username":"${username}", "perPageCount":${perPageCount}, 
                        "lastPageCursor":"${lastPageCursor}"},"query":"${GET_USER_ORGANIZATION_LIST}"}`;
    }else{
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

isolated function getFormulatedStringQueryForGetOrganizationOwnerId(string organizationName) returns string {
    return string `{"variables":{"organizationName":"${organizationName}"},"query":"`
                      + string `${GET_ORG_OWNER_ID}"}`;
}

// get resource id utl functions

isolated function getRepositoryId(string repositoryOwnerName, string repositoryName, string accessToken, 
                                  http:Client graphQlClient) returns @tainted string|error {
    string stringQuery = getFormulatedStringQueryForGetRepositoryId(repositoryOwnerName, repositoryName);
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
            var repo = gitData[GIT_REPOSITORY];
            if (repo is map<json>) {
                json repoId = repo["id"];
                return repoId.toBalString();
            }
        }
    }
    error err = error(GITHUB_ERROR_CODE, message = "Error parsing git repository response");
    return err;
}

isolated function getIssueId(string repositoryOwnerName, string repositoryName, int issueNumber, string accessToken,
                             http:Client graphQlClient) returns @tainted string|error {
    string stringQuery = getFormulatedStringQueryForGetIssueId(repositoryOwnerName, repositoryName, issueNumber);
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
            var repo = gitData[GIT_REPOSITORY];
            if (repo is map<json>) {
                var issue = repo["issue"];
                if(issue is map<json>){
                    json issueId = issue["id"];
                    return issueId.toBalString();
                }
            }
        }
    }
    error err = error(GITHUB_ERROR_CODE, message = "Error parsing git repository response");
    return err;
}

isolated function getPullRequestId(string repositoryOwnerName, string repositoryName, int pullRequestNumber, 
                                   string accessToken, http:Client graphQlClient) returns @tainted string|error {
    string stringQuery = getFormulatedStringQueryForGetPullRequestId(repositoryOwnerName, repositoryName, 
                                                                     pullRequestNumber);
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
            var repo = gitData[GIT_REPOSITORY];
            if (repo is map<json>) {
                var pr = repo["pullRequest"];
                if(pr is map<json>){
                    json prId = pr["id"];
                    return prId.toBalString();
                }
            }
        }
    }
    error err = error(GITHUB_ERROR_CODE, message = "Error parsing git repository response");
    return err;
}

isolated function getUserId(string userName, string accessToken, http:Client graphQlClient) 
                            returns @tainted string|error {
    string stringQuery = getFormulatedStringQueryForGetUserOwnerId(userName);
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
        if(gitData is map<json>){
            var user = gitData[GIT_USER];
            if(user is map<json>){
                json userId = user[GIT_ID];
                return userId.toBalString();
            }

        }

    }
    error err = error(GITHUB_ERROR_CODE, message = "Error parsing user response");
    return err;
} 

