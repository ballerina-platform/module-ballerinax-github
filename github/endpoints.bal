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

# Ballerina GitHub connector provides the capability to access GitHub GraphQL API.
# This connector lets you to get authorized access to GitHub data in a personal or organization
# account. 
@display { label: "GitHub Client", iconPath:"icon.png" }
public isolated client class Client {
    final string authToken;
    final http:Client githubGraphQlClient;

    # Initialize the connector. During the initialization you have to pass 
    # Create a GitHub account and obtain tokens following [this guid](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token)
    #
    # + config - Configurations required to initialize the `Client`
    # + return -  Error at failure of client initialization
    public isolated function init(ConnectionConfig config) returns error? {
        self.authToken = config.auth.token;
        self.githubGraphQlClient = check new(GIT_GRAPHQL_API_URL, config);
    }

    # Get user
    #
    # + username - GitHub username
    # + return - `github:User` record if successful else `github:Error`
    @display { label: "Get User" }
    remote isolated function getUser(string? username = ())  returns @tainted User|Error {

        string stringQuery = getFormulatedStringQueryForGetUser(username);
        map<json>|Error graphQlData = getGraphQlData(self.githubGraphQlClient, self.authToken, stringQuery);

        if graphQlData is map<json> {
            var user = username is () ? graphQlData[GIT_VIEWER] : graphQlData[GIT_USER];
            if user is map<json>{
                 User|error result = user.cloneWithType();
                 return result is User? result : error ClientError ("GitHub Client Error", result);
            } else {
                return error ClientError("GitHub Client Error", body = user);
            }
        } else {
            return graphQlData;
        }
    }
    //Repositories

    # Create repository
    # 
    # + createRepositoryInput - Create repository input
    # 
    # + return - `error` if not successful
    @display { label: "Create Repository" }
    remote isolated function createRepository(CreateRepositoryInput createRepositoryInput) returns error? {
        return createRepository(createRepositoryInput, self.authToken, self.githubGraphQlClient);
    }

    # Update repository
    # 
    # + updateRepositoryInput - Update repository input
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # 
    # + return - `error` if not successful
    @display { label: "Update Repository" }
    remote isolated function updateRepository(UpdateRepositoryInput updateRepositoryInput, string owner,
                                              string repositoryName) returns @tainted error? {
        return  updateRepository(updateRepositoryInput, owner, repositoryName, self.authToken, 
                                 self.githubGraphQlClient);
    }

    # Get repository
    # 
    # + owner - GitHub repository owner name
    # + repositoryName - GitHub repository name
    # 
    # + return - `github:Repository` record if successful else `github:Error`
    @display { label: "Get Repository" }
    remote isolated function getRepository(string owner, string repositoryName) returns Repository|Error {
        return getRepository(owner, repositoryName, self.authToken, self.githubGraphQlClient);
    }

    # Get repositories
    # 
    # + owner - Repo Owner
    # + isOrganization - Is Organization
    # 
    # + return - `github:stream<Repository, error?>` record if successful else `error`
    @display { label: "Get Repositories" }
    remote isolated function getRepositories(string? owner=(), boolean isOrganization=false) 
                                             returns stream<Repository,error?>|error {

        RepositoryStream repositoryStream = check new RepositoryStream (self.githubGraphQlClient,self.authToken, owner,
                                                                        isOrganization);
        return new stream<Repository,error?>(repositoryStream);        
    }

    # Get collaborators
    # 
    # + owner - Repository owner username
    # + repositoryName - Repository name
    # 
    # + return - `github:stream<User,error?>` record if successful else `error`
    @display { label: "Get Collaborators" }
    remote isolated function getCollaborators(string owner, string repositoryName) returns stream<User,error?>|error {
                                    
        CollaboratorStream collaboratorStream = check new CollaboratorStream (self.githubGraphQlClient,self.authToken,
                                                                              owner, repositoryName);
        return new stream<User,error?>(collaboratorStream);
    }

    # Get repository branches
    # 
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # 
    # + return - `github:stream<Branch,error?>` record if success else `error`
    @display { label: "Get Branches" }
    remote isolated function getBranches(string owner, string repositoryName) returns stream<Branch,error?>|error {
        BranchStream branchStream = check new BranchStream (self.githubGraphQlClient,self.authToken, owner,
                                                            repositoryName);
        return new stream<Branch,error?>(branchStream);
    }

    // Issues 
    # Create issue
    # 
    # + createIssueInput - `CreateIssueInput` record
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # 
    # + return - `github:Issue` record if successful else `error`
    @display { label: "Create Issue" }
    remote isolated function createIssue(CreateIssueInput createIssueInput, string owner, string repositoryName) 
                                         returns Issue|error {
        return createIssue(createIssueInput, owner, repositoryName, self.authToken, self.githubGraphQlClient);
    }

    # Update issue
    # 
    # + updateIssueInput - `UpdateIssueInput` record
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + issueNumber - Issue number of the issue to be updated
    # 
    # + return - `github:Issue` record if successful else `error`
    @display { label: "Update Issue" }
    remote isolated function updateIssue(UpdateIssueInput updateIssueInput, string owner, string repositoryName, 
                                         int issueNumber) returns Issue|error {
        return  updateIssue(updateIssueInput, owner, repositoryName, issueNumber, self.authToken, 
                            self.githubGraphQlClient);
    }

    # Get issue
    # 
    # + owner - Repository owner name
    # + repositoryName - repositoryName
    # + issueNumber - Issue number
    # 
    # + return - `github:Issue` record if successful else `error`
    @display { label: "Get Issue" }
    remote isolated function getIssue(string owner, string repositoryName, int issueNumber) returns Issue|error {
        return getIssue(owner, repositoryName, issueNumber, self.authToken, self.githubGraphQlClient);
    }

    # Get issues
    # 
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + issueFilters - Filters to filter issues
    # 
    # + return - `github:IssueList` record if successful else `error`
    @display { label: "Get Issues" }
    remote isolated function getIssues(string owner, string repositoryName, IssueFilters issueFilters = {})
                                       returns stream<Issue,error?>|error {
        IssueStream issueStream = check new IssueStream (self.githubGraphQlClient,self.authToken, owner,
                                                            repositoryName, issueFilters);
        return new stream<Issue,error?>(issueStream);
    }

    // Comments

    # Add comment
    # 
    # + addIssueCommentInput - `AddIssueCommentInput` record
    # 
    # + return - `github:IssueComment` if successful else `error`
    @display { label: "Add IComment" }
    remote isolated function addComment(AddIssueCommentInput addIssueCommentInput)
                                        returns IssueComment|error {
        return addComment(addIssueCommentInput, self.authToken, self.githubGraphQlClient);
    }

    # Update comment
    # 
    # + updateCommentInput - `UpdateIssueCommentInput` record
    # 
    # + return - `error` if un-successful
    @display { label: "Update Comment" }
    remote isolated function updateComment(UpdateIssueCommentInput updateCommentInput) returns error? {
        return updateComment(updateCommentInput, self.authToken, self.githubGraphQlClient);
    }

    # Delete issue comment
    # 
    # + deleteCommentInput - `DeleteCommentInput` record
    # 
    # + return - `error` if un-successful
    @display { label: "Delete Comment" }
    remote isolated function deleteComment(DeleteIssueCommentInput deleteCommentInput) returns error? {
        return deleteComment(deleteCommentInput, self.authToken, self.githubGraphQlClient);
    }

    //Labels

    // mutation is in preview state
    // remote isolated function createLabel(CreateLabelInput createLabelInput) returns error? {
    //     return createLabel(createLabelInput, self.accessToken, self.githubGraphQlClient);
    // }

    # Add labels to an issue
    # 
    # + addLabelsInput - `AddIssueLabelInput` record
    # 
    # + return - `github:LabelList` record if successful else `error`
    @display { label: "Add Labels" }
    remote isolated function addLabels( AddLabelsInput  addLabelsInput) returns LabelList|error {
        return addLabels(addLabelsInput, self.authToken, self.githubGraphQlClient);
    }

    # Remove issue labeles
    # 
    # + removeIssueLabelInput - `RemoveIssueLabelInput` record
    # 
    # + return - `error` if failed
    @display { label: "Remove Issue Labels" }
    remote isolated function removeLabel(RemoveIssueLabelInput removeIssueLabelInput) returns  error? {
        return removeLabel(removeIssueLabelInput, self.authToken, self.githubGraphQlClient);
    }

    # Get repository label
    # 
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + labelName - Label name
    # 
    # + return - `Label` record if successful else `error`
    @display { label: "Get Label" }
    remote isolated function getLabel(string owner, string repositoryName, string labelName) 
                                                returns Label|error {
        return getLabel(owner, repositoryName, labelName, self.authToken, self.githubGraphQlClient);
    }

    # Get labels in an issue
    # 
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + issueNumber - Issue number
    # 
    # + return - `LabelList` record if successful else `error`
    @display { label: "Get Labels" }
    remote isolated function getLabels(string owner, string repositoryName,  int issueNumber) 
                                             returns stream<Label, error?> | error {

        LabelStream labelStream = check new LabelStream(self.githubGraphQlClient, self.authToken, owner,
                                                        repositoryName, issueNumber);
        return new stream<Label,error?>(labelStream);
    }

    // Milestones

    # Get milestone
    # 
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + milestoneNumber - Milestone number
    # 
    # + return - `github:Milestone` record if successful elese `error`
    @display { label: "Get Milestone" }
    remote isolated function getMilestone(string owner, string repositoryName, int milestoneNumber)
                                          returns Milestone|error {
        return getMilestone(owner, repositoryName, milestoneNumber, self.authToken, 
                                      self.githubGraphQlClient);
    }
    # Get milestones
    # 
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # 
    # + return - `github:stream<Milestone,error?>` record if successful else `error`
    @display { label: "Get Milestones" }
    remote isolated function getMilestones(string owner, string repositoryName)
                                           returns stream<Milestone,error?> | error {

        MilestoneStream milestoneStream = check new MilestoneStream (self.githubGraphQlClient,self.authToken, owner,
                                                                     repositoryName);
        return new stream<Milestone,error?>(milestoneStream);
    }

    //Pul Requests

    # Create pull request
    # 
    # + createPullRequestInput - `CreatePullRequestInput` record
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # 
    # + return - `PullRequest` record if success or else `error`
    @display { label: "Create Pull Request" }
    remote isolated function createPullRequest(CreatePullRequestInput createPullRequestInput,string owner, 
                                               string repositoryName) returns PullRequest|error {
        return createPullRequest(createPullRequestInput, owner, repositoryName, self.authToken, 
                                 self.githubGraphQlClient);
    }

    # Update pull request
    # 
    # + updatePullRequestInput - `UpdatePullRequestInput` record if successful else `error`
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + pullRequestNumber - Pull request number
    # 
    # + return - `PullRequest` record if successful else `error`
    @display { label: "Update Pull Request" }
    remote isolated function updatePullRequest(UpdatePullRequestInput updatePullRequestInput, string owner, 
                                              string repositoryName, int pullRequestNumber) returns PullRequest|error {
        return updatePullRequest(updatePullRequestInput, owner, repositoryName, pullRequestNumber, 
                                 self.authToken, self.githubGraphQlClient);
    }

    # Get pull requests 
    # 
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + pullRequestNumber - Pull request number
    # 
    # + return - `PullRequest` record if successful else `error`
    @display { label: "Get Pull Request" }
    remote isolated function getPullRequest(string owner, string repositoryName, int pullRequestNumber) 
                                            returns PullRequest|error {
        return getPullRequest(owner, repositoryName, pullRequestNumber, self.authToken, 
                              self.githubGraphQlClient);
    }

    # Get repository pull request list
    # 
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + state - `Pull request state`
    # 
    # + return - `PullRequestList` record if successful else `error`
    @display { label: "Get Pull Requests" }
    remote isolated function getPullRequests(string owner, string repositoryName, PullRequestState state) 
                                                          returns stream<PullRequest, error?> | error {
        
        PullRequestStream pullRequestStream = check new PullRequestStream (self.githubGraphQlClient, self.authToken,
                                                                           owner, repositoryName, state);
        return new stream<PullRequest,error?>(pullRequestStream);
    }

    # Create pull request review 
    # 
    # + addPullRequestReviewInput - `AddPullRequestReviewInput` record
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + pullRequestNumber - Pull request number
    # 
    # + return - `PullRequestReview` record
    @display {label: "Create Pull Request Review"}
    remote isolated function createPullRequestReview(AddPullRequestReviewInput addPullRequestReviewInput, 
                                                     string owner, string repositoryName,  int pullRequestNumber) 
                                                     returns PullRequestReview|error {
         return createPullRequestReview(addPullRequestReviewInput, owner, repositoryName, 
                                        pullRequestNumber, self.authToken, self.githubGraphQlClient);
    }

    # Update pull request review
    # 
    # + updatePullRequestReviewInput - `UpdatePullRequestReviewInput` record
    # 
    # + return - `error` if failed.
    @display {label: "Update Pull Request Review"}
    remote isolated function updatePullRequestReview(UpdatePullRequestReviewInput updatePullRequestReviewInput) 
                                                     returns error? {
        return updatePullRequestReview(updatePullRequestReviewInput, self.authToken, self.githubGraphQlClient);
    }

    # Delete pending pull request review
    # 
    # + deletePullRequestReview - `DeletePullRequestReviewInput` record
    # 
    # + return - `error` if failed
    @display {label: "Delete Pull Request Review"}
    remote isolated function deletePendingPullRequestReview(DeletePullRequestReviewInput deletePullRequestReview) 
                                                            returns error? {
        return deletePendingPullRequestReview(deletePullRequestReview, self.authToken, self.githubGraphQlClient);
    }


    // Projects

    # Create project
    # 
    # + createRepositoryProjectInput - `CreateRepositoryProjectInput` record
    # 
    # + return - `Project` record if successful else `error`
    @display { label: "Create Project" }
    remote isolated function createProject(CreateRepositoryProjectInput createRepositoryProjectInput) 
                                           returns Project|error {
        return createProject(createRepositoryProjectInput, self.authToken, self.githubGraphQlClient);
    }

    # Update project
    # 
    # + updateProjectInput - `UpdateProjectInput`
    # 
    # + return - `Project` record if successful or else `error`
    @display { label: "Update Project" }
    remote isolated function updateProject(UpdateProjectInput updateProjectInput) 
                                           returns Project|error {
        return updateProject(updateProjectInput, self.authToken, self.githubGraphQlClient);
    }

    # Delete project
    # 
    # + deleteProjectInput - `DeleteProjectInput` record
    # 
    # + return - `error` if failed
    @display { label: "Delete Project" }
    remote isolated function deleteProject(DeleteProjectInput deleteProjectInput) returns  error? {
        return deleteProject(deleteProjectInput, self.authToken, self.githubGraphQlClient);
    }

    # Get user project
    # 
    # + username - Project owner name
    # + projectNumber - Project number
    # 
    # + return - `Project`
    @display { label: "Get Project" }
    remote isolated function getProject(string username, int projectNumber) 
                                            returns Project|error {
        return getProject(username, projectNumber, self.authToken, self.githubGraphQlClient);
    }

    # Get Repository project list
    # 
    # + owner - Repository owner name
    # + ownerType - OwnerType : user or organization
    # + repositoryName - Repository name
    # + state - Project state
    # 
    # + return - `ProjectList` record if successful or else `error`
    @display { label: "Get Repository Projects" }
    remote isolated function getProjects(string owner, OwnerType ownerType, string? repositoryName = (), 
                                         ProjectState? state = ()) returns stream <Project, error?>|error {
        ProjectStream projectStream = check new ProjectStream(self.githubGraphQlClient, self.authToken, owner,
                                                        ownerType, repositoryName, state);
        return new stream<Project, error?>(projectStream);
    }



    # Get user organization list
    # 
    # + owner - Organization username
    # + ownerType - OwnerType : user or organization
    # 
    # + return - `OrganizationList` record or else `error`
    @display { label: "Get User Organization List" }
    remote isolated function getOrganizations(string owner,OwnerType ownerType) 
                                              returns stream<Organization, error?>|error {
        OrganizationStream organizationStream = check new OrganizationStream(self.githubGraphQlClient, self.authToken,
                                                                             owner, ownerType);
        return new stream<Organization, error?> (organizationStream);
    }

    # Get organization member list
    # 
    # + organizationName - Organization username
    # 
    # + return - `UserList` record if successful or else `error`
    @display { label: "Get Organization Members" }
    remote isolated function getOrganizationMembers(string organizationName) returns stream<User,error?>|error {
        OrganizationMemberStream organizationMemberStream = check new OrganizationMemberStream(self.githubGraphQlClient,
                                                                                               self.authToken,
                                                                                               organizationName);
        return new stream<User,error?>(organizationMemberStream);
    }

    # Search
    #
    # + searchQuery - The search string to look for
    # + searchType - The types of search items to search within
    # + perPageCount - Number of elements to be returned
    # + lastPageCursor - Next page curser
    # + return - `github:SearchResult` record if successful or else `error`
    remote isolated function search(string searchQuery, SearchType searchType, int perPageCount,
                                                    string? lastPageCursor=()) returns SearchResult | error {

        string stringQuery = getFormulatedStringQueryForSearch(searchQuery, searchType, perPageCount, lastPageCursor);
        map<json>|Error graphQlData = getGraphQlData(self.githubGraphQlClient, self.authToken, stringQuery);

        if graphQlData is map<json> {
            var searchResult = graphQlData.get(GIT_SEARCH);
            if (searchResult is map<json>) {
                SearchResultPayload payload = check searchResult.cloneWithType(SearchResultPayload);

                    SearchResult searchResponse = {
                                results: payload.nodes,
                                pageInfo: payload.pageInfo,
                                codeCount: payload.codeCount,
                                discussionCount: payload.discussionCount,
                                issueCount: payload.issueCount,
                                repositoryCount: payload.repositoryCount,
                                userCount: payload.userCount,
                                wikiCount: payload.wikiCount
                            };
                            return searchResponse; 
            }
            return error ClientError ("GitHub Client Error", body=searchResult);
        }
        return graphQlData;
    }
}
