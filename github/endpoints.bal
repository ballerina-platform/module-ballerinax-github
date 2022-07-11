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
@display {label: "GitHub", iconPath: "icon.png"}
public isolated client class Client {
    final string authToken;
    final http:Client githubGraphQlClient;

    # Initialize the connector. During the initialization you have to pass 
    # Create a GitHub account and obtain tokens following [this guid](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token)
    #
    # + config - Configurations required to initialize the `Client`
    # + return - Error at failure of client initialization
    public isolated function init(ConnectionConfig config) returns error? {
        self.authToken = config.auth.token;
        self.githubGraphQlClient = check new (GIT_GRAPHQL_API_URL, config);
    }

    # Get user
    #
    # + username - GitHub username
    # + return - `github:User` record if successful else `github:Error`
    @display {label: "Get User"}
    remote isolated function getUser(string? username = ()) returns @tainted User|Error {

        string stringQuery = getFormulatedStringQueryForGetUser(username);
        map<json>|Error graphQlData = getGraphQlData(self.githubGraphQlClient, self.authToken, stringQuery);

        if graphQlData is map<json> {
            json user = username is () ? graphQlData[GIT_VIEWER] : graphQlData[GIT_USER];
            if user is map<json> {
                User|error result = user.cloneWithType();
                return result is User ? result : error ClientError("GitHub Client Error", result);
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
    # + return - `github:Error` if not successful
    @display {label: "Create Repository"}
    remote isolated function createRepository(CreateRepositoryInput createRepositoryInput) returns Error? {
        return createRepository(createRepositoryInput, self.authToken, self.githubGraphQlClient);
    }

    # Update repository
    #
    # + updateRepositoryInput - Update repository input
    # + owner - Repository owner name
    # + repositoryName - Repository name
    #
    # + return - `github:Error` if not successful
    @display {label: "Update Repository"}
    remote isolated function updateRepository(UpdateRepositoryInput updateRepositoryInput, string owner,
                                            string repositoryName) returns @tainted Error? {
        return updateRepository(updateRepositoryInput, owner, repositoryName, self.authToken,
                                self.githubGraphQlClient);
    }

    # Get repository
    #
    # + owner - Repository owner name
    # + repositoryName - GitHub repository name
    #
    # + return - `github:Repository` record if successful else `github:Error`
    @display {label: "Get Repository"}
    remote isolated function getRepository(string owner, string repositoryName) returns Repository|Error {
        return getRepository(owner, repositoryName, self.authToken, self.githubGraphQlClient);
    }

    # Get repositories
    #
    # + owner - Repository owner name
    # + isOrganization - Represents if the owner is an organization or not
    #
    # + return - `github:stream<Repository,Error?>` record if successful else `github:Error`
    @display {label: "Get Repositories"}
    remote isolated function getRepositories(string? owner = (), boolean isOrganization = false)
                                            returns stream<Repository, Error?>|Error {

        RepositoryStream repositoryStream = check new RepositoryStream(self.githubGraphQlClient, self.authToken, owner,
                                                                        isOrganization);
        return new stream<Repository, Error?>(repositoryStream);
    }

    # Get repository content
    #
    # + owner - Repository owner name
    # + repositoryName - GitHub repository name
    # + expression - The expression in the form `<branch_name>:<path_to_directory>` 
    #   Eg: master:.github path will list the contents on .github folder in the master branch
    #
    # + return - `github:File[]` record if successful else `github:Error`
    @display {label: "Get repository content"}
    remote isolated function getRepositoryContent(string owner, string repositoryName, string expression) returns File[]|Error {
        return getRepositoryContent(owner, repositoryName, expression, self.authToken, self.githubGraphQlClient);
    }

    # Get collaborators
    #
    # + owner - Repository owner name
    # + repositoryName - Repository name
    #
    # + return - `github:stream<User,Error?>` record if successful else `github:Error`
    @display {label: "Get Collaborators"}
    remote isolated function getCollaborators(string owner, string repositoryName) returns stream<User, Error?>|Error {

        CollaboratorStream collaboratorStream = check new CollaboratorStream(self.githubGraphQlClient, self.authToken,
                                                                            owner, repositoryName);
        return new stream<User, Error?>(collaboratorStream);
    }

    # Get repository branches
    #
    # + owner - Repository owner name
    # + repositoryName - Repository name
    #
    # + return - `github:stream<Branch,Error?>` record if success else `github:Error`
    @display {label: "Get Branches"}
    remote isolated function getBranches(string owner, string repositoryName) returns stream<Branch, Error?>|Error {
        BranchStream branchStream = check new BranchStream(self.githubGraphQlClient, self.authToken, owner,
                                                            repositoryName);
        return new stream<Branch, Error?>(branchStream);
    }

    // Issues 
    # Create issue
    #
    # + createIssueInput - `CreateIssueInput` record
    # + owner - Repository owner name
    # + repositoryName - Repository name
    #
    # + return - `github:Issue` record if successful else `github:Error`
    @display {label: "Create Issue"}
    remote isolated function createIssue(CreateIssueInput createIssueInput, string owner, string repositoryName)
                                        returns Issue|Error {
        return createIssue(createIssueInput, owner, repositoryName, self.authToken, self.githubGraphQlClient);
    }

    # Update issue
    #
    # + updateIssueInput - `UpdateIssueInput` record
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + issueNumber - Issue number of the issue to be updated
    #
    # + return - `github:Issue` record if successful else `github:Error`
    @display {label: "Update Issue"}
    remote isolated function updateIssue(UpdateIssueInput updateIssueInput, string owner, string repositoryName,
                                        int issueNumber) returns Issue|Error {
        return updateIssue(updateIssueInput, owner, repositoryName, issueNumber, self.authToken,
                            self.githubGraphQlClient);
    }

    # Get issue
    #
    # + owner - Repository owner name
    # + repositoryName - repositoryName
    # + issueNumber - Issue number
    #
    # + return - `github:Issue` record if successful else `github:Error`
    @display {label: "Get Issue"}
    remote isolated function getIssue(string owner, string repositoryName, int issueNumber) returns Issue|Error {
        return getIssue(owner, repositoryName, issueNumber, self.authToken, self.githubGraphQlClient);
    }

    # Get issues
    #
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + issueFilters - Filters to filter issues
    #
    # + return - `github:stream<Issue,Error?>` record if successful else `github:Error`
    @display {label: "Get Issues"}
    remote isolated function getIssues(string owner, string repositoryName, IssueFilters issueFilters = {})
                                        returns stream<Issue, Error?>|Error {
        IssueStream issueStream = check new IssueStream(self.githubGraphQlClient, self.authToken, owner,
                                                            repositoryName, issueFilters);
        return new stream<Issue, Error?>(issueStream);
    }

    // Comments

    # Add comment
    #
    # + addIssueCommentInput - `AddIssueCommentInput` record
    #
    # + return - `github:IssueComment` if successful else `github:Error`
    @display {label: "Add Comment"}
    remote isolated function addComment(AddIssueCommentInput addIssueCommentInput)
                                        returns IssueComment|Error {
        return addComment(addIssueCommentInput, self.authToken, self.githubGraphQlClient);
    }

    # Update comment
    #
    # + updateCommentInput - `UpdateIssueCommentInput` record
    #
    # + return - `github:Error` if un-successful
    @display {label: "Update Comment"}
    remote isolated function updateComment(UpdateIssueCommentInput updateCommentInput) returns Error? {
        return updateComment(updateCommentInput, self.authToken, self.githubGraphQlClient);
    }

    # Delete comment
    #
    # + deleteCommentInput - `DeleteCommentInput` record
    #
    # + return - `github:Error` if un-successful
    @display {label: "Delete Comment"}
    remote isolated function deleteComment(DeleteIssueCommentInput deleteCommentInput) returns Error? {
        return deleteComment(deleteCommentInput, self.authToken, self.githubGraphQlClient);
    }

    //Labels

    // mutation is in preview state
    // remote isolated function createLabel(CreateLabelInput createLabelInput) returns Error? {
    //     return createLabel(createLabelInput, self.accessToken, self.githubGraphQlClient);
    // }

    # Add labels
    #
    # + addLabelsInput - `AddIssueLabelInput` record
    #
    # + return - `github:LabelList` record if successful else `github:Error`
    @display {label: "Add Labels"}
    remote isolated function addLabels(AddLabelsInput addLabelsInput) returns LabelList|Error {
        return addLabels(addLabelsInput, self.authToken, self.githubGraphQlClient);
    }

    # Remove labeles
    #
    # + removeIssueLabelInput - `RemoveIssueLabelInput` record
    #
    # + return - `github:Error` if failed
    @display {label: "Remove Labels"}
    remote isolated function removeLabel(RemoveIssueLabelInput removeIssueLabelInput) returns Error? {
        return removeLabel(removeIssueLabelInput, self.authToken, self.githubGraphQlClient);
    }

    # Get label
    #
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + labelName - Label name
    #
    # + return - `github:Label` record if successful else `github:Error`
    @display {label: "Get Label"}
    remote isolated function getLabel(string owner, string repositoryName, string labelName)
                                                returns Label|Error {
        return getLabel(owner, repositoryName, labelName, self.authToken, self.githubGraphQlClient);
    }

    # Get labels
    #
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + issueNumber - Issue number
    #
    # + return - `github:stream<Label,Error?>` record if successful else `github:Error`
    @display {label: "Get Labels"}
    remote isolated function getLabels(string owner, string repositoryName, int issueNumber)
                                            returns stream<Label, Error?>|Error {

        LabelStream labelStream = check new LabelStream(self.githubGraphQlClient, self.authToken, owner,
                                                        repositoryName, issueNumber);
        return new stream<Label, Error?>(labelStream);
    }

    // Milestones

    # Get milestone
    #
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + milestoneNumber - Milestone number
    #
    # + return - `github:Milestone` record if successful elese `github:Error`
    @display {label: "Get Milestone"}
    remote isolated function getMilestone(string owner, string repositoryName, int milestoneNumber)
                                        returns Milestone|Error {
        return getMilestone(owner, repositoryName, milestoneNumber, self.authToken,
                                    self.githubGraphQlClient);
    }
    # Get milestones
    #
    # + owner - Repository owner name
    # + repositoryName - Repository name
    #
    # + return - `github:stream<Milestone,Error?>` record if successful else `github:Error`
    @display {label: "Get Milestones"}
    remote isolated function getMilestones(string owner, string repositoryName)
                                            returns stream<Milestone, Error?>|Error {

        MilestoneStream milestoneStream = check new MilestoneStream(self.githubGraphQlClient, self.authToken, owner,
                                                                    repositoryName);
        return new stream<Milestone, Error?>(milestoneStream);
    }

    //Pul Requests

    # Create pull request
    #
    # + createPullRequestInput - `CreatePullRequestInput` record
    # + owner - Repository owner name
    # + repositoryName - Repository name
    #
    # + return - `github:PullRequest` record if success or else `github:Error`
    @display {label: "Create Pull Request"}
    remote isolated function createPullRequest(CreatePullRequestInput createPullRequestInput, string owner,
                                                string repositoryName) returns PullRequest|Error {
        return createPullRequest(createPullRequestInput, owner, repositoryName, self.authToken,
                                self.githubGraphQlClient);
    }

    # Update pull request
    #
    # + updatePullRequestInput - `UpdatePullRequestInput` record if successful else `github:Error`
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + pullRequestNumber - Pull request number
    #
    # + return - `github:PullRequest` record if successful else `github:Error`
    @display {label: "Update Pull Request"}
    remote isolated function updatePullRequest(UpdatePullRequestInput updatePullRequestInput, string owner,
                                            string repositoryName, int pullRequestNumber) returns PullRequest|Error {
        return updatePullRequest(updatePullRequestInput, owner, repositoryName, pullRequestNumber,
                                self.authToken, self.githubGraphQlClient);
    }

    # Get pull request
    #
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + pullRequestNumber - Pull request number
    #
    # + return - `github:PullRequest` record if successful else `github:Error`
    @display {label: "Get Pull Request"}
    remote isolated function getPullRequest(string owner, string repositoryName, int pullRequestNumber)
                                            returns PullRequest|Error {
        return getPullRequest(owner, repositoryName, pullRequestNumber, self.authToken,
                            self.githubGraphQlClient);
    }

    # Get pull requests
    #
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + state - `Pull request state`
    #
    # + return - `github:stream<PullRequest,Error?>` record if successful else `github:Error`
    @display {label: "Get Pull Requests"}
    remote isolated function getPullRequests(string owner, string repositoryName, PullRequestState state)
                                                        returns stream<PullRequest, Error?>|Error {

        PullRequestStream pullRequestStream = check new PullRequestStream(self.githubGraphQlClient, self.authToken,
                                                                            owner, repositoryName, state);
        return new stream<PullRequest, Error?>(pullRequestStream);
    }

    # Create pull request review 
    #
    # + addPullRequestReviewInput - `AddPullRequestReviewInput` record
    # + owner - Repository owner name
    # + repositoryName - Repository name
    # + pullRequestNumber - Pull request number
    #
    # + return - `github:PullRequestReview` record if successful else `github:Error`
    @display {label: "Create Pull Request Review"}
    remote isolated function createPullRequestReview(AddPullRequestReviewInput addPullRequestReviewInput,
                                                    string owner, string repositoryName, int pullRequestNumber)
                                                    returns PullRequestReview|Error {
        return createPullRequestReview(addPullRequestReviewInput, owner, repositoryName,
                                        pullRequestNumber, self.authToken, self.githubGraphQlClient);
    }

    # Update pull request review
    #
    # + updatePullRequestReviewInput - `UpdatePullRequestReviewInput` record
    #
    # + return - `github:Error` if failed.
    @display {label: "Update Pull Request Review"}
    remote isolated function updatePullRequestReview(UpdatePullRequestReviewInput updatePullRequestReviewInput)
                                                    returns Error? {
        return updatePullRequestReview(updatePullRequestReviewInput, self.authToken, self.githubGraphQlClient);
    }

    # Delete pending pull request review
    #
    # + deletePullRequestReview - `DeletePullRequestReviewInput` record
    #
    # + return - `github:Error` if failed
    @display {label: "Delete Pull Request Review"}
    remote isolated function deletePendingPullRequestReview(DeletePullRequestReviewInput deletePullRequestReview)
                                                            returns Error? {
        return deletePendingPullRequestReview(deletePullRequestReview, self.authToken, self.githubGraphQlClient);
    }

    // Projects

    # Create project
    #
    # + createRepositoryProjectInput - `CreateRepositoryProjectInput` record
    #
    # + return - `github:Project` record if successful else `github:Error`
    @display {label: "Create Project"}
    remote isolated function createProject(CreateRepositoryProjectInput createRepositoryProjectInput)
                                            returns Project|Error {
        return createProject(createRepositoryProjectInput, self.authToken, self.githubGraphQlClient);
    }

    # Update project
    #
    # + updateProjectInput - `UpdateProjectInput`
    #
    # + return - `github:Project` record if successful or else `github:Error`
    @display {label: "Update Project"}
    remote isolated function updateProject(UpdateProjectInput updateProjectInput)
                                            returns Project|Error {
        return updateProject(updateProjectInput, self.authToken, self.githubGraphQlClient);
    }

    # Delete project
    #
    # + deleteProjectInput - `DeleteProjectInput` record
    #
    # + return - `github:Error` if failed
    @display {label: "Delete Project"}
    remote isolated function deleteProject(DeleteProjectInput deleteProjectInput) returns Error? {
        return deleteProject(deleteProjectInput, self.authToken, self.githubGraphQlClient);
    }

    # Get project
    #
    # + username - Project owner name
    # + projectNumber - Project number
    #
    # + return - `github:Project` record if successful or else `github:Error`
    @display {label: "Get Project"}
    remote isolated function getProject(string username, int projectNumber)
                                            returns Project|Error {
        return getProject(username, projectNumber, self.authToken, self.githubGraphQlClient);
    }

    # Get Repository projects
    #
    # + owner - Repository owner name
    # + ownerType - Repository owner type : user or organization
    # + repositoryName - Repository name
    # + state - Project state
    #
    # + return - `github:stream<Project,Error?>` record if successful or else `github:Error`
    @display {label: "Get Projects"}
    remote isolated function getProjects(string owner, OwnerType ownerType, string? repositoryName = (),
                                        ProjectState? state = ()) returns stream<Project, Error?>|Error {
        ProjectStream projectStream = check new ProjectStream(self.githubGraphQlClient, self.authToken, owner,
                                                        ownerType, repositoryName, state);
        return new stream<Project, Error?>(projectStream);
    }

    # Get organizations
    #
    # + owner - Organization owner name
    # + ownerType - OwnerType : user or organization
    #
    # + return - `github:stream<Organization,Error?>` record or else `github:Error`
    @display {label: "Get Organizations"}
    remote isolated function getOrganizations(string owner, OwnerType ownerType)
                                            returns stream<Organization, Error?>|Error {
        OrganizationStream organizationStream = check new OrganizationStream(self.githubGraphQlClient, self.authToken,
                                                                            owner, ownerType);
        return new stream<Organization, Error?>(organizationStream);
    }

    # Get organization members
    #
    # + organizationName - Organization username
    #
    # + return - `github:stream<User,Error?>` record if successful or else `github:Error`
    @display {label: "Get Organization Members"}
    remote isolated function getOrganizationMembers(string organizationName) returns stream<User, Error?>|Error {
        OrganizationMemberStream organizationMemberStream = check new OrganizationMemberStream(self.githubGraphQlClient,
                                                                                                self.authToken,
                                                                                                organizationName);
        return new stream<User, Error?>(organizationMemberStream);
    }

    # Search
    #
    # + searchQuery - The search string to look for
    # + searchType - The types of search items to search within. Either one of the following can be used: 
    # `github:SEARCH_TYPE_USER`, `github:SEARCH_TYPE_ORGANIZATION`, `github:SEARCH_TYPE_ISSUE`,
    # `github:SEARCH_TYPE_REPOSITORY`.
    # + perPageCount - Number of elements to be returned
    # + lastPageCursor - Next page curser
    # + return - `github:SearchResult` record if successful or else `github:Error`
    @display {label: "Search"}
    remote isolated function search(string searchQuery, SearchType searchType, int perPageCount,
                                                    string? lastPageCursor = ()) returns SearchResult|Error {

        SearchType querySearchType = searchType is SEARCH_TYPE_ORGANIZATION ? SEARCH_TYPE_USER : searchType;
        string stringQuery = getFormulatedStringQueryForSearch(searchQuery, querySearchType, perPageCount,
                                                                lastPageCursor);
        map<json>|Error graphQlData = getGraphQlData(self.githubGraphQlClient, self.authToken, stringQuery);

        if graphQlData is map<json> {
            json searchResult = graphQlData.get(GIT_SEARCH);
            if (searchResult is map<json>) {
                //Here get search results nodes is handling manually. This can be re implemented after the following
                // issue resolved. https://github.com/ballerina-platform/ballerina-lang/issues/34377
                json nodes = searchResult.get(GIT_NODES);
                if nodes is json[] {
                    if nodes.length() > 0 {
                        do {
                            User[] users = [];
                            Organization[] orgs = [];
                            Issue[] issues = [];
                            Repository[] repos = [];
                            match querySearchType {
                                SEARCH_TYPE_USER => {
                                    foreach json node in nodes {
                                        if node is map<json> {
                                            int numberOfFields = 0;
                                            numberOfFields = node.keys().length();
                                            if numberOfFields > 12 {
                                                User user = check node.cloneWithType();
                                                users.push(user);
                                            } else {
                                                Organization org = check node.cloneWithType();
                                                orgs.push(org);
                                            }
                                        }
                                    }
                                }
                                SEARCH_TYPE_ISSUE => {
                                    issues = check nodes.cloneWithType();
                                }
                                SEARCH_TYPE_REPOSITORY => {
                                    repos = check nodes.cloneWithType();
                                }
                            }
                            SearchResult searchResponse = {
                                results: searchType is SEARCH_TYPE_ISSUE ? issues :
                                        searchType is SEARCH_TYPE_REPOSITORY ? repos :
                                        searchType is SEARCH_TYPE_USER ? users : orgs,
                                pageInfo: check searchResult.get(GIT_PAGE_INFO).cloneWithType(PageInfo),
                                codeCount: <int>searchResult.get(GIT_CODE_COUNT),
                                discussionCount: <int>searchResult.get(GIT_DISCUSSION_COUNT),
                                issueCount: <int>searchResult.get(GIT_ISSUE_COUNT),
                                repositoryCount: <int>searchResult.get(GIT_REPO_COUNT),
                                userCount: <int>searchResult.get(GIT_USER_COUNT),
                                wikiCount: <int>searchResult.get(GIT_WIKI_COUNT)
                            };
                            return searchResponse;
                        } on fail var e {
                            return error ClientError("GitHub Client Error in search result conversion.", e);
                        }
                    } else {
                        do {
                            SearchResult searchResponse = {
                                results: searchType is SEARCH_TYPE_USER ? <User[]>[] :
                                        searchType is SEARCH_TYPE_ISSUE ? <Issue[]>[] :
                                        searchType is SEARCH_TYPE_REPOSITORY ? <Repository[]>[] : <Organization[]>[],
                                pageInfo: check searchResult.get(GIT_PAGE_INFO).cloneWithType(PageInfo),
                                codeCount: <int>searchResult.get(GIT_CODE_COUNT),
                                discussionCount: <int>searchResult.get(GIT_DISCUSSION_COUNT),
                                issueCount: <int>searchResult.get(GIT_ISSUE_COUNT),
                                repositoryCount: <int>searchResult.get(GIT_REPO_COUNT),
                                userCount: <int>searchResult.get(GIT_USER_COUNT),
                                wikiCount: <int>searchResult.get(GIT_WIKI_COUNT)
                            };
                            return searchResponse;
                        } on fail var e {
                            return error ClientError("GitHub Client Error in empty search result conversion.", e);
                        }
                    }
                } else {
                    return error ClientError("GitHub Client Error", body = nodes);
                }
            }
            return error ClientError("GitHub Client Error", body = searchResult);
        }
        return graphQlData;
    }
}
