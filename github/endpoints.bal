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

# GitHub Client.
# + accessToken - The access token of the github account
# + githubGraphQlClient - HTTP client endpoint
# + headers - Request Header map
@display {label: "GitHub Client",iconPath:"GithubLogo.png"}
public client class Client {
    string accessToken;
    http:Client githubGraphQlClient;
    map<string> headers;

    public isolated function init(Configuration config) returns error? {
        self.accessToken = config.accessToken;
        self.githubGraphQlClient = check new(GIT_GRAPHQL_API_URL, config.clientConfig);
        self.headers = {
           AUTHORIZATION_HEADER: TOKEN + self.accessToken
        };
    }

    @display {label: "Get Authenticated User"}
    remote isolated function getAuthenticatedUser()  returns @display {label: "Authenticated User"} 
                                                  @tainted User|error {

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


    @display {label: "Get User Id"}
    remote isolated function getUserId(@display {label: "User name"} string userName) 
                                       returns @display {label: "User Id"} @tainted string|error {
        return getUserId(userName, self.accessToken, self.githubGraphQlClient);
    }

    @display {label: "Get User Repository"}
    remote isolated function getUserRepository(@display {label: "Repository Owner Name"} string username, 
                                               @display {label: "Repository Name"} string repositoryName) 
                                               returns @display {label: "Repository"} @tainted Repository|error {
        return getUserRepository(username, repositoryName, self.accessToken, self.githubGraphQlClient);
    }


    // Repositories

    @display {label: "Get Authenticated User Repository List"}
    remote isolated function getAuthenticatedUserRepositoryList(@display {label: "Per Page Count"} int perPageCount, 
                                                                @display {label: "Next Page Cursor"} 
                                                                string? nextPageCursor=()) 
                                                                returns @display {label: "Repository List"} 
                                                                @tainted RepositoryList|error {
        return getAuthenticatedUserRepositoryList(perPageCount, self.accessToken, self.githubGraphQlClient, 
                                                  nextPageCursor=());

    }

    @display {label: "Get User Repository List"}
    remote isolated function getUserRepositoryList(@display {label: "Repository Owner Name"} string username, 
                                                   @display {label: "Per Page Count"} int perPageCount, 
                                                   @display {label: "Next Page Cursor"} string? nextPageCursor = ())
                                                   returns @display {label: "Repository List"} @tainted 
                                                   RepositoryList|error {
        return getUserRepositoryList(username, perPageCount, self.accessToken, self.githubGraphQlClient, 
                                     nextPageCursor);
    }

    @display {label: "Get Organization Repository List"}
    remote isolated function getOrganizationRepositoryList(@display {label: "Organization Name"} 
                                                           string organizationName, 
                                                           @display {label: "Per Page Count"} int perPageCount,
                                                           @display {label: "Next Page Cursor"} 
                                                           string? nextPageCursor = ()) 
                                                           returns @display {label: "Repository List"} 
                                                           @tainted RepositoryList|error {
        return getOrganizationRepositoryList(organizationName, perPageCount, self.accessToken, 
                                             self.githubGraphQlClient, nextPageCursor);
    }

    @display {label: "Get Repository Collobarator List"}
    remote isolated function getRepositoryCollobaratorList(@display {label: "Repository Owner Name"} string ownerName,
                                                           @display {label: "Repository Name"} string repositoryName,
                                                           @display {label: "Per Page Count"} int perPageCount, 
                                                           @display {label: "Next Page Cursor"} 
                                                           string? nextPageCursor = ()) 
                                                           returns @display {label: "Collaborator List"} @tainted 
                                                           CollaboratorList|error {
        return getRepositoryCollobaratorList(ownerName, repositoryName, perPageCount, self.accessToken, 
                                             self.githubGraphQlClient, nextPageCursor);

    }

    @display {label: "Get Repository Branch List"}
    remote isolated function getRepositoryBranchList(@display {label: "Repository Owner Name"} string ownerName,
                                                     @display {label: "Repository Name"} string repositoryName, 
                                                     @display {label: "Per Page Count"} int perPageCount, 
                                                     @display {label: "Next Page Cursor"} string? nextPageCursor = ())
                                                     returns @display {label: "Branch List"} 
                                                     @tainted BranchList|error {
        return getRepositoryBranchList(ownerName, repositoryName, perPageCount, self.accessToken, 
                                       self.githubGraphQlClient, nextPageCursor);
    }

    @display {label: "Update Repository"}
    remote isolated function updateRepository(@display {label: "Update Repository Input"} 
                                              @tainted UpdateRepositoryInput updateRepositoryInput, 
                                              @display {label: "Repository Owner Name"} string repositoryOwnerName,
                                              @display {label: "Repository Name"} string repositoryName) 
                                              returns @tainted error? {
        return  updateRepository(updateRepositoryInput, repositoryOwnerName, repositoryName, self.accessToken, 
                                 self.githubGraphQlClient);
    }


    // Issues

    @display {label: "Get Repository Issue List Assigned To User"}
    remote isolated function getRepositoryIssueListAssignedToUser(@display {label: "Repository Owner Name"} 
                                                                  string repositoryOwnerName, 
                                                                  @display {label: "Repository Name"} 
                                                                  string repositoryName, 
                                                                  @display {label: "Assignee User Name"} 
                                                                  string assignee, 
                                                                  @display {label: "Per Page Count"} int perPageCount,
                                                                  @display {label: "Next Page Cursor"} 
                                                                  string? nextPageCursor = ()) 
                                                                  returns @display {label: "Issue List"} 
                                                                  @tainted IssueList|error {
        return getRepositoryIssueListAssignedToUser(repositoryOwnerName, repositoryName, assignee, perPageCount, 
                                                    self.accessToken, self.githubGraphQlClient, nextPageCursor);

    }

    @display {label: "Get Repository Issue List"}
    remote isolated function getRepositoryIssueList(@display {label: "Repository Owner Name"} 
                                                    string repositoryOwnerName, 
                                                    @display {label: "Repository Name"} string repositoryName, 
                                                    @display {label: "Issue States"} IssueState[] states, 
                                                    @display {label: "Per Page Count"} int perPageCount, 
                                                    @display {label: "Next Page Cursor"} string? nextPageCursor = ())
                                                    returns @display {label: "Issue List"} @tainted IssueList|error {
        return getRepositoryIssueList(repositoryOwnerName, repositoryName, states, perPageCount, self.accessToken, 
                                      self.githubGraphQlClient, nextPageCursor);
    }

    @display {label: "Create Issue"}
    remote isolated function createIssue(@display {label: "Create Issue Input"} @tainted 
                                         CreateIssueInput createIssueInput, 
                                         @display {label: "Repository Owner Name"} string repositoryOwnerName, 
                                         @display {label: "Repository Name"} string repositoryName) 
                                         returns @display {label: "Issue"} @tainted Issue|error {
        return createIssue(createIssueInput, repositoryOwnerName, repositoryName, self.accessToken, 
                           self.githubGraphQlClient);
    }

    @display {label: "Update Issue"}
    remote isolated function updateIssue(@display {label: "Update Issue Input"} @tainted 
                                         UpdateIssueInput updateIssueInput,
                                         @display {label: "Repository Owner Name"} string repositoryOwnerName, 
                                         @display {label: "Repository Name"} string repositoryName, 
                                         @display {label: "Issue Number"} int issueNumber) 
                                         returns @display {label: "Issue"} @tainted Issue|error {
        return  updateIssue(updateIssueInput, repositoryOwnerName, repositoryName, issueNumber, self.accessToken, 
                            self.githubGraphQlClient);
    }

    @display {label: "Get Repository Issue"}
    remote isolated function getRepositoryIssue(@display {label: "Repository Owner Name"} string repositoryOwnerName,
                                                @display {label: "Repository Name"} string repositoryName, 
                                                @display {label: "Issue Number"} int issueNumber) 
                                                returns @display {label: "Issue"} @tainted Issue|error {
        return getRepositoryIssue(repositoryOwnerName, repositoryName, issueNumber, self.accessToken, 
                                  self.githubGraphQlClient);
    }

    @display {label: "Get Repository Issue Comment List"}
    remote isolated function getRepositoryIssueCommentList(@display {label: "Repository Owner Name"} 
                                                           string repositoryOwnerName, 
                                                           @display {label: "Repository Name"} string repositoryName, 
                                                           @display {label: "Issue Number"} int issueNumber, 
                                                           @display {label: "Per Page Count"}int perPageCount, 
                                                           @display {label: "Next Page Cursor"} 
                                                           string? nextPageCursor=()) 
                                                           returns @display {label: "Issue Comment List"} 
                                                           @tainted IssueCommentList|error {
        return getRepositoryIssueCommentList(repositoryOwnerName, repositoryName, issueNumber, perPageCount, 
                                             self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }

    @display {label: "Get Issues WIth Label"}
    remote isolated function getIssuesWithLabel(@display {label: "Repository Owner Name"} string repositoryOwnerName,
                                                @display {label: "Repository Name"} string repositoryName, 
                                                @display {label: "Label Name"} string labelName, 
                                                @display {label: "Per Page Count"} int perPageCount, 
                                                @display {label: "Next Page Cursor"} string? nextPageCursor=()) 
                                                returns @display {label: "Issue List"} @tainted IssueList|error {
        return getIssuesWithLabel(repositoryOwnerName, repositoryName, labelName, perPageCount, self.accessToken, 
                                  self.githubGraphQlClient, nextPageCursor);
    }


    // Comments

    @display {label: "Add Issue Comment"}
    remote isolated function addComment(@display {label: "Add Comment Input"} AddCommentInput addCommentInput) 
                                        returns @display {label: "Issue Comment"} @tainted IssueComment|error {
        return addComment(addCommentInput, self.accessToken, self.githubGraphQlClient);
    }

    @display {label: "Update Issue Comment"}
    remote isolated function updateComment(@display {label: "Update Comment Input"} 
                                           UpdateIssueCommentInput updateCommentInput) returns @tainted error? {
        return updateComment(updateCommentInput, self.accessToken, self.githubGraphQlClient);
    }

    @display {label: "Delete Issue Comment"}
    remote isolated function deleteComment(@display {label: "Delete Comment Input"} 
                                           DeleteIssueCommentInput deleteCommentInput) returns @tainted error? {
        return deleteComment(deleteCommentInput, self.accessToken, self.githubGraphQlClient);
    }


    //Labels

    // mutation is in preview state
    // remote isolated function createLabel(CreateLabelInput createLabelInput) returns error? {
    //     return createLabel(createLabelInput, self.accessToken, self.githubGraphQlClient);
    // }

    @display {label: "Get Repository Label"}
    remote isolated function getRepositoryLabel(@display {label: "Repository Owner Name"} string repositoryOwnerName,
                                                @display {label: "Repository Name"} string repositoryName, 
                                                @display {label: "Label Name"} string labelName) 
                                                returns @display {label: "Label"} @tainted Label|error {
        return getRepositoryLabel(repositoryOwnerName, repositoryName, labelName, self.accessToken, 
                                  self.githubGraphQlClient);
    }

    @display {label: "Get Labels In An Issue"}
    remote isolated function getLabelsInIssue(@display {label: "Repository Owner Name"} string repositoryOwnerName,
                                             @display {label: "Repository Name"} string repositoryName, 
                                             @display {label: "Issue Number"} int issueNumber, 
                                             @display {label: "Per Page Count"} int perPageCount, 
                                             @display {label: "Next Page Cursor"} string? nextPageToken=()) 
                                             returns @display {label: "Label List"} @tainted LabelList|error {
        return getLabelsInIssue(repositoryOwnerName, repositoryName, issueNumber, perPageCount, self.accessToken, 
                                self.githubGraphQlClient, nextPageToken);
    }

    @display {label: "Add Labels To Labelable"}
    remote isolated function addLabelsToLabelable(@display {label: "Add Labels To Labelable Input"} 
                                                  AddLabelsToLabelableInput addLabelsToLabelableInput) 
                                                  returns @display {label: "Label List"} @tainted LabelList|error {
        return addLabelsToLabelable(addLabelsToLabelableInput, self.accessToken, self.githubGraphQlClient);
    }

    @display {label: "Remove Labels From Labelable"}
    remote isolated function removeLabelFromLabelable(@display {label: "Remove Labels From Labelable Input"} 
                                                      RemoveLabelsFromLabelableInput removeLabelsFromLabelable) 
                                                      returns @tainted error? {
        return removeLabelFromLabelable(removeLabelsFromLabelable, self.accessToken, self.githubGraphQlClient);
    }


    // Milestones

    @display {label: "Get Repository Milestone List"}
    remote isolated function getRepositoryMilestoneList(@display {label: "Repository Owner Name"} 
                                                        string repositoryOwnerName, @display {label: "Repository Name"}
                                                        string repositoryName, 
                                                        @display {label: "Per Page Count"} int perPageCount, 
                                                        @display {label: "Next Page Cursor"} string? nextPageCursor=())
                                                        returns @display {label: "Milestone List"} @tainted 
                                                        MilestoneList|error {
        return getRepositoryMilestoneList(repositoryOwnerName, repositoryName, perPageCount, self.accessToken, 
                                          self.githubGraphQlClient, nextPageCursor);
    }

    @display {label: "Get Repository Milestone"}
    remote isolated function getRepositoryMilestone(@display {label: "Repository Owner Name"} 
                                                    string repositoryOwnerName, 
                                                    @display {label: "Repository Name"} string repositoryName, 
                                                    @display {label: "Milestone Number"} int milestoneNumber) 
                                                    returns @display {label: "Milestone"} @tainted Milestone|error {
        return getRepositoryMilestone(repositoryOwnerName, repositoryName, milestoneNumber, self.accessToken, 
                                      self.githubGraphQlClient);
    }


    //Pul Requests

    @display {label: "Get Pull Request"}
    remote isolated function getPullRequest(@display {label: "Repository Owner Name"} string repositoryOwnerName, 
                                            @display {label: "Repository Name"} string repositoryName, 
                                            @display {label: "Pull Request Number"} int pullRequestNumber) 
                                            returns @display {label: "Pull Request"} @tainted PullRequest|error {
        return getPullRequest(repositoryOwnerName, repositoryName, pullRequestNumber, self.accessToken, 
                              self.githubGraphQlClient);
    }

    @display {label: "Get Repository Pull Request List"}
    remote isolated function getRepositoryPullRequestList(@display {label: "Repository Owner Name"} 
                                                          string repositoryOwnerName, 
                                                          @display {label: "Repository Name"} string repositoryName, 
                                                          @display {label: "Pull Request State"} 
                                                          PullRequestState state, 
                                                          @display {label: "Per Page Count"} int perPageCount, 
                                                          @display {label: "Next Page Cursor"} 
                                                          string? nextPageCursor=()) 
                                                          returns @display {label: "Pull Request List"} @tainted 
                                                          PullRequestList|error {
        return getRepositoryPullRequestList(repositoryOwnerName, repositoryName, state, perPageCount, 
                                            self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }

    @display {label: "Create Pull Request"}
    remote isolated function createPullRequest(@display {label: "Create Pull Request Input"} 
                                               @tainted CreatePullRequestInput createPullRequestInput, 
                                               @display {label: "Repository Owner Name"} string repositoryOwnerName, 
                                               @display {label: "Repository Name"} string repositoryName) 
                                               returns @display {label: "Pull Request"} @tainted PullRequest|error {
        return createPullRequest(createPullRequestInput, repositoryOwnerName, repositoryName, self.accessToken, 
                                 self.githubGraphQlClient);
    }

    @display {label: "Update Pull Request"}
    remote isolated function updatePullRequest(@display {label: "Update Pull Request Input"} @tainted 
                                               UpdatePullRequestInput updatePullRequestInput, 
                                               @display {label: "Repository Owner Name"} string repositoryOwnerName, 
                                               @display {label: "Repository Name"} string repositoryName, 
                                               @display {label: "Pull Request Number"} int pullRequestNumber) 
                                               returns @display {label: "Pull Request"} @tainted PullRequest|error {
        return updatePullRequest(updatePullRequestInput, repositoryOwnerName, repositoryName, pullRequestNumber, 
                                 self.accessToken, self.githubGraphQlClient);
    }

    @display {label: "Get Pull Request Review Comment List"}
    remote isolated function getPullRequestReviewCommentList(@display {label: "Repository Owner Name"} 
                                                             string repositoryOwnerName, 
                                                             @display {label: "Repository Name"} string repositoryName, 
                                                             @display {label: "Pull Request Number"} 
                                                             int pullRequestNumber, 
                                                             @display {label: "Per Page Count"} int perPageCount, 
                                                             @display {label: "Next Page Cursor"} 
                                                             string? nextPageCursor=()) 
                                                             returns @display {label: "Pull Request Review List"}
                                                             @tainted PullRequestReviewList|error {
        return getPullRequestReviewCommentList(repositoryOwnerName, repositoryName, pullRequestNumber, perPageCount, 
                                               self.accessToken, self.githubGraphQlClient, nextPageCursor);

    }

    @display {label: "Create Pull Request Review"}
    remote isolated function createPullRequestReview(@display {label: "Add Pull Request Review Input"} @tainted 
                                                     AddPullRequestReviewInput addPullRequestReviewInput, 
                                                     @display {label: "Repository Owner Name"} 
                                                     string repositoryOwnerName, 
                                                     @display {label: "Repository Name"} string repositoryName,  
                                                     @display {label: "Pull Request Number"} int pullRequestNumber) 
                                                     returns @display {label: "Pull Request Review"} @tainted 
                                                     PullRequestReview|error {
         return createPullRequestReview(addPullRequestReviewInput, repositoryOwnerName, repositoryName, 
                                        pullRequestNumber, self.accessToken, self.githubGraphQlClient);
    }

    @display {label: "Update Pull Request Review"}
    remote isolated function updatePullRequestReview(@display {label: "Update Pull Request Review"} 
                                                     UpdatePullRequestReviewInput updatePullRequestReviewInput) 
                                                     returns @tainted error? {
        return updatePullRequestReview(updatePullRequestReviewInput, self.accessToken, self.githubGraphQlClient);
    }

    @display {label: "Delete Pending Pull Request Review"}
    remote isolated function deletePendingPullRequestReview(@display {label: "Delete Pull Request Review Input"}
                                                            DeletePullRequestReviewInput deletePullRequestReview) 
                                                            returns @tainted error? {
        return deletePendingPullRequestReview(deletePullRequestReview, self.accessToken, self.githubGraphQlClient);
    }


    // Projects

    @display {label: "Get Organization Project List"}
    remote isolated function getOrganizationProjectList(@display {label: "Organization Name"} string organizationName, 
                                                        @display {label: "Project State"} ProjectState state, 
                                                        @display {label: "Per Page Count"} int perPageCount, 
                                                        @display {label: "Next Page Cursor"} string? nextPageCursor=()) 
                                                        returns @display {label: "Project List"} @tainted 
                                                        ProjectList|error {
        return getOrganizationProjectList(organizationName, state, perPageCount, self.accessToken, 
                                          self.githubGraphQlClient, nextPageCursor);
    }

    @display {label: "Create Project"}
    remote isolated function createProject(@display {label: "Create Project Input"} 
                                           CreateProjectInput createProjectInput) 
                                           returns @display {label: "Project"} @tainted Project|error {
        return createProject(createProjectInput, self.accessToken, self.githubGraphQlClient);
    }

    @display {label: "Get User Project"}
    remote isolated function getUserProject(@display {label: "Project Owner Name"} string username, 
                                            @display {label: "Project Number"} int projectNumber) 
                                            returns @display {label: "Project"} @tainted Project|error {
        return getUserProject(username, projectNumber, self.accessToken, self.githubGraphQlClient);
    }

    @display {label: "Update Project"}
    remote isolated function updateProject(@display {label: "Update Project Input"} 
                                           UpdateProjectInput updateProjectInput) 
                                           returns @display {label: "Project"} @tainted Project|error {
        return updateProject(updateProjectInput, self.accessToken, self.githubGraphQlClient);
    }

    @display {label: "Delete Project"}
    remote isolated function deleteProject(@display {label: "Delete Project Input"} 
                                           DeleteProjectInput deleteProjectInput) returns @tainted error? {
        return deleteProject(deleteProjectInput, self.accessToken, self.githubGraphQlClient);
    }

    @display {label: "Get Repository Project List"}
    remote isolated function getRepositoryProjectList(@display {label: "Repository Owner Name"} string repositoryOwner, 
                                                      @display {label: "Repository Name"} string repositoryName, 
                                                      @display {label: "Project State"} ProjectState state, 
                                                      @display {label: "Per Page Count"} int perPageCount, 
                                                      @display {label: "Next Page Cursor"} string? nextPageCursor=()) 
                                                      returns @display {label: "Project List"} @tainted 
                                                      ProjectList|error {
        return getRepositoryProjectList(repositoryOwner, repositoryName, state, perPageCount, self.accessToken, 
                                        self.githubGraphQlClient, nextPageCursor);
    }

    @display {label: "Get User Project List"}
    remote isolated function getUserProjectList(@display {label: "Project Owner Name"} string username, 
                                                @display {label: "Per Page Count"} int perPageCount, 
                                                @display {label: "Next Page Cursor"} string? nextPageCursor=()) 
                                                returns @display {label: "Project List"} @tainted ProjectList|error {
        return getUserProjectList(username, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }


    // Organizations

    @display {label: "Get An Organization"}
    remote isolated function getOrganization(@display {label: "Organization Name"} string organizationName) 
                                             returns @display {label: "Organization"} @tainted Organization|error {
        return getOrganization(organizationName, self.accessToken, self.githubGraphQlClient);
    }

    @display {label: "Get User Organization List"}
    remote isolated function getUserOrganizationList(@display {label: "User Name"} string username, 
                                                     @display {label: "Per Page Count"} int perPageCount, 
                                                     @display {label: "Next Page Cursor"} string? lastPageCursor=()) 
                                                     returns @display {label: "Organization List"} @tainted 
                                                     OrganizationList|error {
        return getUserOrganizationList(username, perPageCount, self.accessToken, self.githubGraphQlClient, 
                                       lastPageCursor);
    }

    @display {label: "Get Organization Member List"}
    remote isolated function getOrganizationMemberList(@display {label: "Organization Name"} string organizationName, 
                                                       @display {label: "Per Page Count"} int perPageCount, 
                                                       @display {label: "Next Page Cursor"} string? nextPageCursor=()) 
                                                       returns @display {label: "User List"} @tainted UserList|error {
        return getOrganizationMemberList(organizationName, perPageCount, self.accessToken, self.githubGraphQlClient, 
                                         nextPageCursor);
    }

    @display {label: "Get Organization Id"}
    remote isolated function getOrganizationOwnerId(@display {label: "Organization Name"} string organizationName) 
                                                    returns @display {label: "Organization Id"} @tainted string|error {
        return getOrganizationOwnerId(organizationName, self.accessToken, self.githubGraphQlClient);
    }
}
