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

public client class Client {
    string accessToken;
    http:Client githubGraphQlClient;
    map<string> headers;

    public isolated function init(Configuration config) {
        self.accessToken = config.accessToken;
        self.githubGraphQlClient = checkpanic new(GIT_GRAPHQL_API_URL, config.clientConfig);
        self.headers = {
           AUTHORIZATION_HEADER: TOKEN + self.accessToken
        };
    }

    remote isolated function getAuthenticatedUser()  returns User|error {

        string stringQuery = getFormulatedStringQueryForGetAuthenticatedUser();
        http:Request request = new;
        setHeader(request, self.accessToken);
        json convertedQuery = check stringToJson(stringQuery);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> convertedQuery);

        var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

        //Check for empty payloads and errors
        json validatedResponse = check getValidatedResponse(response);

        if (validatedResponse is map<json>) {
            var gitData = validatedResponse[GIT_DATA];
            if (gitData is map<json>) {
                var viewer = gitData[GIT_VIEWER];
                if (viewer is map<json>) {
                    User user = check viewer.cloneWithType(User);
                    return user;
                }
            }
        }
        error err = error(GITHUB_ERROR_CODE, message = "Error parsing git user response");
        return err;
    }

    isolated function getUserId(string userName) returns string|error {
        string stringQuery = getFormulatedStringQueryForGetUserOwnerId(userName);
        http:Request request = new;
        setHeader(request, self.accessToken);
        json convertedQuery = check stringToJson(stringQuery);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> convertedQuery);

        var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

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

    remote isolated function getUserRepository(string username, string repositoryName) returns Repository|error {
        return getUserRepository(username, repositoryName, self.accessToken, self.githubGraphQlClient);
    }


    // Repositories

    remote isolated function getAuthenticatedUserRepositoryList(int perPageCount, string? nextPageCursor=()) returns RepositoryList|error {
        return getAuthenticatedUserRepositoryList(perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor=());

    }

    remote isolated function getUserRepositoryList(string username, int perPageCount, string? nextPageCursor = ()) returns RepositoryList|error {
        return getUserRepositoryList(username, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }

    remote isolated function getOrganizationRepositoryList(string organizationName, int perPageCount, string? nextPageCursor = ()) returns RepositoryList|error {
        return getOrganizationRepositoryList(organizationName, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }

    remote isolated function getRepositoryCollobaratorList(string ownerName, string repositoryName, int perPageCount, string? nextPageCursor = ()) returns CollaboratorList|error {
        return getRepositoryCollobaratorList(ownerName, repositoryName, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);

    }

    remote isolated function getRepositoryBranchList(string ownerName, string repositoryName, int perPageCount, string? nextPageCursor = ()) returns BranchList|error {
        return getRepositoryBranchList(ownerName, repositoryName, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }

    remote isolated function updateRepository(UpdateRepositoryInput updateRepositoryInput, string repositoryOwnerName, string repositoryName) returns error? {
        return  updateRepository(updateRepositoryInput, repositoryOwnerName, repositoryName, self.accessToken, self.githubGraphQlClient);
    }


    // Issues

    remote isolated function getRepositoryIssueListAssignedToUser(string repositoryOwnerName, string repositoryName, string assignee, int perPageCount, string? nextPageCursor = ()) returns IssueList|error {
        return getRepositoryIssueListAssignedToUser(repositoryOwnerName, repositoryName, assignee, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);

    }

    remote isolated function getRepositoryIssueList(string repositoryOwnerName, string repositoryName, IssueState[] states, int perPageCount, string? nextPageCursor = ()) returns IssueList|error {
        return getRepositoryIssueList(repositoryOwnerName, repositoryName, states, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }

    remote isolated function createIssue(CreateIssueInput createIssueInput, string repositoryOwnerName, string repositoryName) returns Issue|error {
        return createIssue(createIssueInput, repositoryOwnerName, repositoryName, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function updateIssue(UpdateIssueInput updateIssueInput, string repositoryOwnerName, string repositoryName, int issueNumber) returns Issue|error {
        return  updateIssue(updateIssueInput, repositoryOwnerName, repositoryName, issueNumber, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function getRepositoryIssue(string repositoryOwnerName, string repositoryName, int issueNumber) returns Issue|error {
        return getRepositoryIssue(repositoryOwnerName, repositoryName, issueNumber, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function getRepositoryIssueCommentList(string repositoryOwnerName, string repositoryName, int issueNumber, int perPageCount, string? nextPageCursor=()) returns IssueCommentList|error {
        return getRepositoryIssueCommentList(repositoryOwnerName, repositoryName, issueNumber, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }

    remote isolated function getIssuesWithLabel(string repositoryOwnerName, string repositoryName, string labelName, int perPageCount, string? nextPageCursor=()) returns IssueList|error {
        return getIssuesWithLabel(repositoryOwnerName, repositoryName, labelName, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }


    // Comments

    remote isolated function addComment(AddCommentInput addCommentInput) returns IssueComment|error {
        return addComment(addCommentInput, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function updateComment(UpdateIssueCommentInput updateCommentInput) returns error? {
        return updateComment(updateCommentInput, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function deleteComment(DeleteIssueCommentInput deleteCommentInput) returns error? {
        return deleteComment(deleteCommentInput, self.accessToken, self.githubGraphQlClient);
    }


    //Labels

    // mutation is in preview state
    remote isolated function createLabel(CreateLabelInput createLabelInput) returns error? {
        return createLabel(createLabelInput, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function getRepositoryLabel(string repositoryOwnerName, string repositoryName, string labelName) returns Label|error {
        return getRepositoryLabel(repositoryOwnerName, repositoryName, labelName, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function getLabelsInIssue(string repositoryOwnerName, string repositoryName, int issueNumber, int perPageCount, string? nextPageToken=()) returns LabelList|error {
        return getLabelsInIssue(repositoryOwnerName, repositoryName, issueNumber, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageToken);
    }

    remote isolated function addLabelsToLabelable(AddLabelsToLabelableInput addLabelsToLabelableInput) returns LabelList|error {
        return addLabelsToLabelable(addLabelsToLabelableInput, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function removeLabelFromLabelable(RemoveLabelsFromLabelableInput removeLabelsFromLabelable) returns error? {
        return removeLabelFromLabelable(removeLabelsFromLabelable, self.accessToken, self.githubGraphQlClient);
    }


    // Milestones

    remote isolated function getRepositoryMilestoneList(string repositoryOwnerName, string repositoryName, int perPageCount, string? nextPageCursor=()) returns MilestoneList|error {
        return getRepositoryMilestoneList(repositoryOwnerName, repositoryName, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }

    remote isolated function getRepositoryMilestone(string repositoryOwnerName, string repositoryName, int milestoneNumber) returns Milestone|error {
        return getRepositoryMilestone(repositoryOwnerName, repositoryName, milestoneNumber, self.accessToken, self.githubGraphQlClient);
    }


    //Pul Requests

    remote isolated function getPullRequest(string repositoryOwnerName, string repositoryName, int pullRequestNumber) returns PullRequest|error {
        return getPullRequest(repositoryOwnerName, repositoryName, pullRequestNumber, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function getRepositoryPullRequestList(string repositoryOwnerName, string repositoryName, PullRequestState state, int perPageCount, string? nextPageCursor=()) returns PullRequestList|error {
        return getRepositoryPullRequestList(repositoryOwnerName, repositoryName, state, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }

    remote isolated function createPullRequest(CreatePullRequestInput createPullRequestInput, string repositoryOwnerName, string repositoryName) returns PullRequest|error {
        return createPullRequest(createPullRequestInput, repositoryOwnerName, repositoryName, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function updatePullRequest(UpdatePullRequestInput updatePullRequestInput, string repositoryOwnerName, string repositoryName, int pullRequestNumber) returns PullRequest|error {
        return updatePullRequest(updatePullRequestInput, repositoryOwnerName, repositoryName, pullRequestNumber, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function getPullRequestReviewCommentList(string repositoryOwnerName, string repositoryName, int pullRequestNumber, int perPageCount, string? nextPageCursor=()) returns PullRequestReviewList|error {
        return getPullRequestReviewCommentList(repositoryOwnerName, repositoryName, pullRequestNumber, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);

    }

     remote isolated function createPullRequestReview(AddPullRequestReviewInput addPullRequestReviewInput, string repositoryOwnerName, string repositoryName,  int pullRequestNumber) returns PullRequestReview|error {
         return createPullRequestReview(addPullRequestReviewInput, repositoryOwnerName, repositoryName, pullRequestNumber, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function updatePullRequestReview(UpdatePullRequestReviewInput updatePullRequestReviewInput) returns error? {
        return updatePullRequestReview(updatePullRequestReviewInput, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function deletePendingPullRequestReview(DeletePullRequestReviewInput deletePullRequestReview) returns error? {
        return deletePendingPullRequestReview(deletePullRequestReview, self.accessToken, self.githubGraphQlClient);
    }


    // Projects

    remote isolated function getOrganizationProjectList(string organizationName, ProjectState state, int perPageCount, string? nextPageCursor=()) returns ProjectList|error {
        return getOrganizationProjectList(organizationName, state, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }

    remote isolated function createProject(CreateProjectInput createProjectInput) returns Project|error {
        return createProject(createProjectInput, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function getUserProject(string username, int projectNumber) returns Project|error {
        return getUserProject(username, projectNumber, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function updateProject(UpdateProjectInput updateProjectInput) returns Project|error {
        return updateProject(updateProjectInput, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function deleteProject(DeleteProjectInput deleteProjectInput) returns error? {
        return deleteProject(deleteProjectInput, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function getRepositoryProjectList(string repositoryOwner, string repositoryName, ProjectState state, int perPageCount, string? nextPageCursor=()) returns ProjectList|error {
        return getRepositoryProjectList(repositoryOwner, repositoryName, state, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }

    remote isolated function getUserProjectList(string username, int perPageCount, string? nextPageCursor=()) returns ProjectList|error {
        return getUserProjectList(username, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }


    // Organizations

    remote isolated function getOrganization(string organizationName) returns Organization|error {
        return getOrganization(organizationName, self.accessToken, self.githubGraphQlClient);
    }

    remote isolated function getUserOrganizationList(string username, int perPageCount, string? lastPageCursor=()) returns OrganizationList|error {
        return getUserOrganizationList(username, perPageCount, self.accessToken, self.githubGraphQlClient, lastPageCursor);
    }

    remote isolated function getOrganizationMemberList(string organizationName, int perPageCount, string? nextPageCursor=()) returns UserList|error {
        return getOrganizationMemberList(organizationName, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }

    remote isolated function getOrganizationOwnerId(string organizationName) returns string|error {
        return getOrganizationOwnerId(organizationName, self.accessToken, self.githubGraphQlClient);
    }
}