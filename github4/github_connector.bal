//
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
//

import ballerina/http;
import ballerina/io;

# GitHub client connector.
# + githubGraphQlClient - Http client for GitHub GraphQL API
# + githubRestClient - Http client for GitHub REST API
public type GitHubConnector object {
    public http:Client githubGraphQlClient = new;
    public http:Client githubRestClient = new;

    # Creates a new issue in a repository.
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + issueTitle - Title of the issue
    # + issueContent - Details of the issue
    # + labelList - List of labels for the issue
    # + assigneeList - Users to be assigned to the issue
    # + return - Created issue object or Connector error
    public function createIssue(string repositoryOwner, string repositoryName, string issueTitle, string issueContent,
                                string[] labelList, string[] assigneeList) returns Issue|GitClientError;

    # Get the next page of the card list.
    # + cardList - Card list object
    # + return - Card list object of next page or Connector error
    public function getCardListNextPage(CardList cardList) returns CardList|GitClientError;

    # Get the next page of column list.
    # + columnList - Column list object
    # + return - Column list object of next page or Connector error
    public function getColumnListNextPage(ColumnList columnList) returns ColumnList|GitClientError;

    # Get a list of issues of a repository.
    # + repository - Repository object or tuple `("repository owner", "repository name")`
    # + state - State of the issue (STATE_OPEN, STATE_CLOSED, STATE_ALL)
    # + recordCount - Specify number of records in the list
    # + return - Issue list object or Connector error
    public function getIssueList(Repository|(string, string) repository, string state, int recordCount)
                        returns IssueList|GitClientError;

    # Get the next page of the issue list.
    # + issueList - Issue list object
    # + return - Issue list object of next page or Connector error
    public function getIssueListNextPage(IssueList issueList) returns IssueList|GitClientError;

    # Get an organization.
    # + name - Name of the organization
    # + return - Organization object or Connector error
    public function getOrganization(string name) returns Organization|GitClientError;

    # Get a single project of an organization.
    # + organization - Organization object or organization name
    # + projectNumber - The number of the project
    # + return - Project object or Connector error
    public function getOrganizationProject(Organization|string organization, int projectNumber)
                        returns Project|GitClientError;

    # Get all projects of an organization.
    # + organization - Organization object or organization name
    # + state - State of the project (STATE_OPEN, STATE_CLOSED, STATE_ALL)
    # + recordCount - Specify number of records in the list
    # + return - Project list object or Connector error
    public function getOrganizationProjectList(Organization|string organization, string state, int recordCount)
                        returns ProjectList|GitClientError;

    # Get a list of repositories of an organization.
    # + organization - Organization object or organization name
    # + recordCount - Specify number of records in the list
    # + return - Repository list object or Connector error
    public function getOrganizationRepositoryList(Organization|string organization, int recordCount)
                        returns RepositoryList|GitClientError;

    # Get all columns of a project board.
    # + project - Project object
    # + recordCount - Specify number of records in the list
    # + return - Column list object or Connector error
    public function getProjectColumnList(Project project, int recordCount) returns ColumnList|GitClientError;

    # Gets the next page of a project list.
    # + projectList - Project list object
    # + return - Project list object of next page or Connector error
    public function getProjectListNextPage(ProjectList projectList) returns ProjectList|GitClientError;

    # Get all pull requests of a repository.
    # + repository - Repository object or tuple `("repository owner", "repository name")`
    # + state - State of the pull request (STATE_OPEN, STATE_CLOSED, STATE_MERGED, STATE_ALL)
    # + recordCount - Specify number of records in the list
    # + return - Pull request list object or Connector error
    public function getPullRequestList(Repository|(string, string) repository, string state, int recordCount)
                        returns PullRequestList|GitClientError;

    # Get the next page of the pull request list.
    # + pullRequestList - Pull request list object
    # + return - Pull request list object of next page or Connector error
    public function getPullRequestListNextPage(PullRequestList pullRequestList) returns PullRequestList|GitClientError;

    # Get a repository of an owner.
    # + name - Name of the repository and its owner Format: ("owner/repository")
    # + return - Repository object or Connector error
    public function getRepository(string name) returns Repository|GitClientError;

    # Get the next page of a repository list.
    # + repositoryList - Repository list object
    # + return - Repository list object of next page or Connector error
    public function getRepositoryListNextPage(RepositoryList repositoryList) returns RepositoryList|GitClientError;

    # Get a single project of a repository.
    # + repository - Repository object or tuple `("repository owner", "repository name")`
    # + projectNumber - Project identification number
    # + return - Project object or Connector error
    public function getRepositoryProject(Repository|(string, string) repository, int projectNumber)
                        returns Project|GitClientError;
                        
    # Get all projects of a repository.
    # + repository - Repository object or tuple `("repository owner", "repository name")`
    # + state - State of the project (STATE_OPEN, STATE_CLOSED, STATE_ALL)
    # + recordCount - Specify number of records in the list
    # + return - Project list object or Connector error
    public function getRepositoryProjectList(Repository|(string, string) repository, string state, int recordCount)
                        returns ProjectList|GitClientError;
};

function GitHubConnector::createIssue(string repositoryOwner, string repositoryName, string issueTitle,
                                      string issueContent, string[] labelList, string[] assigneeList)
                              returns Issue|GitClientError {

    endpoint http:Client gitHubEndpoint = self.githubRestClient;

    if (repositoryName == EMPTY_STRING || repositoryOwner == EMPTY_STRING || issueTitle == EMPTY_STRING) {
        GitClientError connectorError = { message: "Repository name, owner and issue title should be specified" };
        return connectorError;
    }

    json[] jsonLabelList;
    foreach i, label in labelList {
        jsonLabelList[i] = label;
    }

    json[] jsonAssigneeList;
    foreach i, assignee in assigneeList {
        jsonAssigneeList[i] = assignee;
    }

    json issueJsonPayload = { "title": issueTitle, "body": issueContent, "labels": jsonLabelList,
        "assignees": jsonAssigneeList };

    http:Request request = new;
    //Set headers and payload to the request
    constructRequest(request, issueJsonPayload);

    string endpointResource = PATH_SEPARATOR + GIT_REPOS + PATH_SEPARATOR + repositoryOwner +
        PATH_SEPARATOR + repositoryName + PATH_SEPARATOR + GIT_ISSUES;
    // Make an HTTP POST request
    var response = gitHubEndpoint->post(endpointResource, request);

    //Check for empty payloads and errors
    var validatedResponse = getValidatedRestResponse(response);
    match validatedResponse {
        json jsonResponse => {
            return restResponseJsonToIssue(jsonResponse);
        }
        GitClientError gitClientError => {
            return gitClientError;
        }
    }
}

function GitHubConnector::getCardListNextPage(CardList cardList) returns CardList|GitClientError {

    if (cardList.hasNextPage()) {
        var cardListColumnId = cardList.columnId;
        var convertedQuery = stringToJson(cardList.cardListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorCards = cardList.pageInfo.endCursor;

                if (cardList.listOwner.equalsIgnoreCase(GIT_ORGANIZATION)) {
                    jsonQuery[GIT_QUERY] = GET_ORGANIZATION_PROJECT_CARDS_NEXT_PAGE;
                    ColumnList|GitClientError columnList = getProjectColumns(GIT_ORGANIZATION,
                        jsonQuery.toString(), self.githubGraphQlClient);
                    match columnList {
                        ColumnList colList => {
                            foreach column in colList.getAllColumns() {
                                if (column.id == cardListColumnId) {
                                    return column.getCardList();
                                }
                            }
                        }

                        GitClientError gitClientError => {
                            return gitClientError;
                        }
                    }

                } else if (cardList.listOwner.equalsIgnoreCase(GIT_REPOSITORY)) {
                    jsonQuery[GIT_QUERY] = GET_REPOSITORY_PROJECT_CARDS_NEXT_PAGE;
                    ColumnList|GitClientError columnList = getProjectColumns(GIT_REPOSITORY, jsonQuery.toString()
                        , self.githubGraphQlClient);
                    match columnList {
                        ColumnList colList => {
                            foreach column in colList.getAllColumns() {
                                if (column.id == cardListColumnId) {
                                    return column.getCardList();
                                }
                            }
                        }

                        GitClientError gitClientError => {
                            return gitClientError;
                        }
                    }
                }
            }

            GitClientError gitClientError => {
                return gitClientError;
            }
        }

    }

    return { message: "Card list has no next page" };
}

function GitHubConnector::getColumnListNextPage(ColumnList columnList) returns ColumnList|GitClientError {

    if (columnList.hasNextPage()) {
        var convertedQuery = stringToJson(columnList.columnListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorColumns = columnList.pageInfo.endCursor;
                if (columnList.listOwner.equalsIgnoreCase(GIT_ORGANIZATION)) {
                    jsonQuery[GIT_QUERY] = GET_ORGANIZATION_PROJECT_COLUMNS_NEXT_PAGE;

                    return getProjectColumns(GIT_ORGANIZATION, jsonQuery.toString(), self.githubGraphQlClient);
                } else if (columnList.listOwner.equalsIgnoreCase(GIT_REPOSITORY)) {
                    jsonQuery[GIT_QUERY] = GET_REPOSITORY_PROJECT_COLUMNS_NEXT_PAGE;

                    return getProjectColumns(GIT_REPOSITORY, jsonQuery.toString(), self.githubGraphQlClient);
                }
            }

            GitClientError gitClientError => {
                return gitClientError;
            }
        }

    }
    GitClientError gitClientError = { message: "Column list has no next page" };

    return gitClientError;
}

function GitHubConnector::getIssueList(Repository|(string, string) repository, string state, int recordCount)
                                     returns IssueList|GitClientError {

    endpoint http:Client gitHubEndpoint = self.githubGraphQlClient;
    string repositoryOwner;
    string repositoryName;
    match repository {
        Repository repoObject => {
            repositoryOwner = repoObject.owner.login;
            repositoryName = repoObject.name;
        }
        (string, string) repoDetails => {
            (repositoryOwner, repositoryName) = repoDetails;
        }
    }

    if (repositoryOwner == EMPTY_STRING || repositoryName == EMPTY_STRING) {
        GitClientError gitClientError = { message: "Repository owner and name should be specified" };
        return gitClientError;
    }

    if (recordCount > MAX_RECORD_COUNT) {
        GitClientError gitClientError = { message: "Maximum record count limited to " + MAX_RECORD_COUNT };
        return gitClientError;
    }

    string stringQuery = io:sprintf(TEMPLATE_GET_REPOSITORY_ISSUES,
        repositoryOwner, repositoryName, state, recordCount);

    http:Request request = new;
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            //Set headers and payload to the request
            constructRequest(request, jsonQuery);
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json|GitClientError validatedResponse = getValidatedResponse(response, GIT_ISSUES);

    match validatedResponse {
        json jsonValidatedResponse => {
            var githubIssuesJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_ISSUES];
            var issueList = jsonToIssueList(githubIssuesJson, stringQuery);

            return issueList;
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }
}

function GitHubConnector::getIssueListNextPage(IssueList issueList) returns IssueList|GitClientError {

    endpoint http:Client gitHubEndpoint = self.githubGraphQlClient;

    if (issueList.hasNextPage()) {
        http:Request request = new;
        var convertedQuery = stringToJson(issueList.issueListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorIssues = issueList.pageInfo.endCursor;
                jsonQuery[GIT_QUERY] = GET_REPOSITORY_ISSUES_NEXT_PAGE;
                //Set headers and payload to the request
                constructRequest(request, jsonQuery);
            }

            GitClientError gitClientError => {
                return gitClientError;
            }
        }

        // Make an HTTP POST request
        var response = gitHubEndpoint->post(EMPTY_STRING, request);

        //Check for empty payloads and errors
        json|GitClientError validatedResponse = getValidatedResponse(response, GIT_ISSUES);
        match validatedResponse {
            json jsonValidatedResponse => {
                var repositoryIssuesJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_ISSUES];
                var issuesList = jsonToIssueList(repositoryIssuesJson, issueList.issueListQuery);

                return issuesList;
            }

            GitClientError gitClientError => {
                return gitClientError;
            }
        }

    }
    GitClientError gitClientError = { message: "Issue list has no next page" };

    return gitClientError;

}

function GitHubConnector::getOrganization(string name) returns Organization|GitClientError {

    endpoint http:Client gitHubEndpoint = self.githubGraphQlClient;


    if (name == EMPTY_STRING) {
        GitClientError gitClientError = { message: "Organization name should be specified" };
        return gitClientError;
    }
    Organization singleOrganization = {};

    string stringQuery = io:sprintf(TEMPLATE_GET_ORGANIZATION, name);

    http:Request request = new;
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            // Set headers and payload to the request
            constructRequest(request, jsonQuery);
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint->post(EMPTY_STRING, request);

    json|GitClientError validatedResponse = getValidatedResponse(response, GIT_NAME);

    match validatedResponse {
        json jsonValidatedResponse => {
            try {
                var githubRepositoryJson = <json>jsonValidatedResponse[GIT_DATA][GIT_ORGANIZATION];
                singleOrganization = check <Organization>githubRepositoryJson;
            } catch (error e) {
                GitClientError gitClientError = { message: e.message, cause: e.cause };
                return gitClientError;
            }
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }

    return singleOrganization;
}

function GitHubConnector::getOrganizationProject(Organization|string organization, int projectNumber)
                                     returns Project|GitClientError {
    endpoint http:Client gitHubEndpoint = self.githubGraphQlClient;

    string organizationName = organization but {
        Organization orgObject => orgObject.login,
        string orgName => orgName
    };

    if (organizationName == EMPTY_STRING || projectNumber <= INDEX_ZERO) {
        GitClientError gitClientError = { message: "Organization should have a name and
                                                                        project number should be positive integer" };
        return gitClientError;
    }

    string stringQuery = io:sprintf(TEMPLATE_GET_ORGANIZATION_PROJECT, organizationName, projectNumber);

    http:Request request = new;
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            //Set headers and payload to the request
            constructRequest(request, jsonQuery);
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint->post(EMPTY_STRING, request);

    json|GitClientError validatedResponse = getValidatedResponse(response, GIT_PROJECT);

    match validatedResponse {
        json jsonValidatedResponse => {
            var githubProjectJson = jsonValidatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_PROJECT];
            var singleProject = check <Project>githubProjectJson;

            return singleProject;
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }
}

function GitHubConnector::getOrganizationProjectList(Organization|string organization, string state,
                                                            int recordCount) returns ProjectList|GitClientError {

    endpoint http:Client gitHubEndpoint = self.githubGraphQlClient;

    string organizationName = organization but {
        Organization orgObject => orgObject.login,
        string orgName => orgName
    };

    if (organizationName == EMPTY_STRING || state == EMPTY_STRING) {
        GitClientError gitClientError = { message: "Organization should have a name and
                                                                                project state should be specified" };
        return gitClientError;
    }

    if (recordCount > MAX_RECORD_COUNT) {
        GitClientError gitClientError = { message: "Maximum record count limited to " + MAX_RECORD_COUNT };
        return gitClientError;
    }

    string stringQuery = io:sprintf(TEMPLATE_GET_ORGANIZATION_PROJECTS, organizationName, state, recordCount);

    http:Request request = new;
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            //Set headers and payload to the request
            constructRequest(request, jsonQuery);
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json|GitClientError validatedResponse = getValidatedResponse(response, GIT_PROJECTS);

    match validatedResponse {
        json jsonValidatedResponse => {
            var githubProjectsJson = jsonValidatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_PROJECTS];
            var projectList = jsonToProjectList(githubProjectsJson, GIT_ORGANIZATION, stringQuery);

            return projectList;
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }
}

function GitHubConnector::getOrganizationRepositoryList(Organization|string organization, int recordCount)
                                     returns RepositoryList|GitClientError {

    endpoint http:Client gitHubEndpoint = self.githubGraphQlClient;

    string organizationName = organization but {
        Organization orgObject => orgObject.login,
        string orgName => orgName
    };

    if (organizationName == EMPTY_STRING) {
        GitClientError gitClientError = { message: "Organization should have a name" };
        return gitClientError;
    }

    if (recordCount > MAX_RECORD_COUNT) {
        GitClientError gitClientError = { message: "Maximum record count limited to " + MAX_RECORD_COUNT };
        return gitClientError;
    }

    string stringQuery = io:sprintf(TEMPLATE_GET_ORGANIZATION_REPOSITORIES, organizationName, recordCount);

    http:Request request = new;
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            //Set headers and payload to the request
            constructRequest(request, jsonQuery);
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json|GitClientError validatedResponse = getValidatedResponse(response, GIT_REPOSITORIES);

    match validatedResponse {
        json jsonValidatedResponse => {
            var githubRepositoriesJson = jsonValidatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_REPOSITORIES];
            var repositoryList = jsonToRepositoryList(githubRepositoriesJson, stringQuery);

            return repositoryList;
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }
}

function GitHubConnector::getProjectColumnList(Project project, int recordCount) returns ColumnList|GitClientError {

    GitClientError gitClientError = {};

    if (project.owner.getOwnerType() == EMPTY_STRING || project.number <= INDEX_ZERO ||
            project.resourcePath == EMPTY_STRING) {
        gitClientError = { message: "Project owner, number and resource path should be specified" };
        return gitClientError;
    }

    if (recordCount > MAX_RECORD_COUNT) {
        gitClientError = { message: "Maximum record count limited to " + MAX_RECORD_COUNT };
        return gitClientError;
    }
    string projectOwnerType = project.owner.getOwnerType();
    string resourcePath = project.resourcePath but { () => EMPTY_STRING };
    if (projectOwnerType.equalsIgnoreCase(GIT_ORGANIZATION)) {
        string organization = resourcePath.split(PATH_SEPARATOR)[INDEX_TWO];
        string stringQuery = io:sprintf(TEMPLATE_GET_ORGANIZATION_PROJECT_COLUMNS,
            organization, project.number, recordCount);

        return getProjectColumns(GIT_ORGANIZATION, stringQuery, self.githubGraphQlClient);

    } else if (projectOwnerType.equalsIgnoreCase(GIT_REPOSITORY)) {
        string ownerName = resourcePath.split(PATH_SEPARATOR)[INDEX_ONE];
        string repositoryName = resourcePath.split(PATH_SEPARATOR)[INDEX_TWO];
        string stringQuery = io:sprintf(TEMPLATE_GET_REPOSITORY_PROJECT_COLUMNS,
            ownerName, repositoryName, project.number, recordCount);

        return getProjectColumns(GIT_REPOSITORY, stringQuery, self.githubGraphQlClient);
    }
    gitClientError.message = "No records found";
    return gitClientError;
}

function GitHubConnector::getProjectListNextPage(ProjectList projectList) returns ProjectList|GitClientError {
    endpoint http:Client gitHubEndpoint = self.githubGraphQlClient;

    if (projectList.hasNextPage()) {

        http:Request request = new;
        json dataQuery;
        var convertedQuery = stringToJson(projectList.projectListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorProjects = projectList.pageInfo.endCursor;
                if (projectList.listOwner.equalsIgnoreCase(GIT_ORGANIZATION)) {
                    jsonQuery[GIT_QUERY] = GET_ORGANIZATION_PROJECTS_NEXT_PAGE;
                } else if (projectList.listOwner.equalsIgnoreCase(GIT_REPOSITORY)) {
                    jsonQuery[GIT_QUERY] = GET_REPOSITORY_PROJECTS_NEXT_PAGE;
                }
                dataQuery = jsonQuery;
                //Set headers and payload to the request
                constructRequest(request, jsonQuery);
            }

            GitClientError gitClientError => {
                return gitClientError;
            }
        }

        // Make an HTTP POST request
        var response = gitHubEndpoint->post(EMPTY_STRING, request);

        //Check for empty payloads and errors
        json|GitClientError validatedResponse = getValidatedResponse(response, GIT_PROJECTS);

        match validatedResponse {
            json jsonValidatedResponse => {
                var projectsJson = jsonValidatedResponse[GIT_DATA][projectList.listOwner][GIT_PROJECTS];
                var projList = jsonToProjectList(projectsJson, projectList.listOwner, dataQuery.toString());

                return projList;
            }

            GitClientError gitClientError => {
                return gitClientError;
            }
        }
    }

    GitClientError gitClientError = { message: "Project list has no next page" };

    return gitClientError;
}

function GitHubConnector::getPullRequestList(Repository|(string, string) repository, string state, int recordCount)
                                     returns PullRequestList|GitClientError {

    endpoint http:Client gitHubEndpoint = self.githubGraphQlClient;

    string repositoryOwner;
    string repositoryName;
    match repository {
        Repository repoObject => {
            repositoryOwner = repoObject.owner.login;
            repositoryName = repoObject.name;
        }
        (string, string) repoDetails => {
            (repositoryOwner, repositoryName) = repoDetails;
        }
    }

    if (repositoryOwner == EMPTY_STRING || repositoryName == EMPTY_STRING) {
        GitClientError gitClientError = { message: "Repository owner and name should be specified" };
        return gitClientError;
    }

    if (recordCount > MAX_RECORD_COUNT) {
        GitClientError gitClientError = { message: "Maximum record count limited to " + MAX_RECORD_COUNT };
        return gitClientError;
    }

    string stringQuery = io:sprintf(TEMPLATE_GET_PULL_REQUESTS, repositoryOwner, repositoryName, state, recordCount);

    http:Request request = new;
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            //Set headers and payload to the request
            constructRequest(request, jsonQuery);
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json|GitClientError validatedResponse = getValidatedResponse(response, GIT_PULL_REQUESTS);

    match validatedResponse {
        json jsonValidatedResponse => {
            var githubPullRequestsJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PULL_REQUESTS];
            var pullRequestList = jsonToPullRequestList(githubPullRequestsJson, stringQuery);

            return pullRequestList;
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }
}

function GitHubConnector::getPullRequestListNextPage(PullRequestList pullRequestList)
                                     returns PullRequestList|GitClientError {

    endpoint http:Client gitHubEndpoint = self.githubGraphQlClient;

    if (pullRequestList.hasNextPage()) {

        http:Request request = new;
        var convertedQuery = stringToJson(pullRequestList.pullRequestListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorPullRequests = pullRequestList.pageInfo.endCursor;
                jsonQuery[GIT_QUERY] = GET_PULL_REQUESTS_NEXT_PAGE;
                //Set headers and payload to the request
                constructRequest(request, jsonQuery);
            }

            GitClientError gitClientError => {
                return gitClientError;
            }
        }

        // Make an HTTP POST request
        var response = gitHubEndpoint->post(EMPTY_STRING, request);

        //Check for empty payloads and errors
        json|GitClientError validatedResponse = getValidatedResponse(response, GIT_PULL_REQUESTS);

        match validatedResponse {
            json jsonValidatedResponse => {
                var projectColumnsJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PULL_REQUESTS];
                var prList = jsonToPullRequestList(projectColumnsJson, pullRequestList.pullRequestListQuery);

                return prList;
            }

            GitClientError gitClientError => {
                return gitClientError;
            }
        }

    }
    GitClientError gitClientError = { message: "Pull request list has no next page" };

    return gitClientError;
}

function GitHubConnector::getRepository(string name) returns Repository|GitClientError {

    endpoint http:Client gitHubEndpoint = self.githubGraphQlClient;

    if (name == EMPTY_STRING || name == EMPTY_STRING) {
        GitClientError gitClientError = { message: "Repository owner and name should be specified." };
        return gitClientError;
    }
    string[] repoIdentifier = name.split(PATH_SEPARATOR);
    string repoOwner = repoIdentifier[INDEX_ZERO];
    string repoName = repoIdentifier[INDEX_ONE];
    Repository singleRepository = {};

    string stringQuery = io:sprintf(TEMPLATE_GET_REPOSITORY, repoOwner, repoName);

    http:Request request = new;
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            // Set headers and payload to the request
            constructRequest(request, jsonQuery);
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }

    // Make an HTTP POST request 
    var response = gitHubEndpoint->post(EMPTY_STRING, request);

    json|GitClientError validatedResponse = getValidatedResponse(response, GIT_NAME);
    match validatedResponse {
        json jsonValidatedResponse => {
            try {
                var githubRepositoryJson = <json>jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY];
                singleRepository = jsonToRepository(githubRepositoryJson);
            } catch (error e) {
                GitClientError gitClientError = { message: e.message, cause: e.cause };
                return gitClientError;
            }
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }

    return singleRepository;
}

function GitHubConnector::getRepositoryListNextPage(RepositoryList repositoryList)
                                     returns RepositoryList|GitClientError {
    endpoint http:Client gitHubEndpoint = self.githubGraphQlClient;

    if (repositoryList.hasNextPage()) {

        http:Request request = new;
        var convertedQuery = stringToJson(repositoryList.repositoryListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorRepos = repositoryList.pageInfo.endCursor;
                jsonQuery[GIT_QUERY] = GET_ORGANIZATION_REPOSITORIES_NEXT_PAGE;
                //Set headers and payload to the request
                constructRequest(request, jsonQuery);
            }

            GitClientError gitClientError => {
                return gitClientError;
            }
        }

        // Make an HTTP POST request
        var response = gitHubEndpoint->post(EMPTY_STRING, request);

        //Check for empty payloads and errors
        json|GitClientError validatedResponse = getValidatedResponse(response, GIT_REPOSITORIES);

        match validatedResponse {
            json jsonValidatedResponse => {
                var repositoriesJson = jsonValidatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_REPOSITORIES];
                var repoList = jsonToRepositoryList(repositoriesJson, repositoryList.repositoryListQuery);

                return repoList;
            }

            GitClientError gitClientError => {
                return gitClientError;
            }
        }
    }
    GitClientError gitClientError = { message: "Repository list has no next page" };

    return gitClientError;
}

function GitHubConnector::getRepositoryProject(Repository|(string, string) repository, int projectNumber)
                                     returns Project|GitClientError {

    endpoint http:Client gitHubEndpoint = self.githubGraphQlClient;

    string repositoryOwner;
    string repositoryName;
    match repository {
        Repository repoObject => {
            repositoryOwner = repoObject.owner.login;
            repositoryName = repoObject.name;
        }
        (string, string) repoDetails => {
            (repositoryOwner, repositoryName) = repoDetails;
        }
    }

    if (repositoryOwner == EMPTY_STRING || repositoryName == EMPTY_STRING) {
        GitClientError gitClientError = { message: "Repository owner and name should be specified" };
        return gitClientError;
    }

    string stringQuery = io:sprintf(TEMPLATE_GET_REPOSITORY_PROJECT, repositoryOwner, repositoryName, projectNumber);

    http:Request request = new;
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            //Set headers and payload to the request
            constructRequest(request, jsonQuery);
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json|GitClientError validatedResponse = getValidatedResponse(response, GIT_PROJECT);

    match validatedResponse {
        json jsonValidatedResponse => {
            var githubProjectJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECT];
            var singleProject = check <Project>githubProjectJson;

            return singleProject;
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }
}

function GitHubConnector::getRepositoryProjectList(Repository|(string, string) repository, string state,
                                                          int recordCount) returns ProjectList|GitClientError {

    endpoint http:Client gitHubEndpoint = self.githubGraphQlClient;

    string repositoryOwner;
    string repositoryName;
    match repository {
        Repository repoObject => {
            repositoryOwner = repoObject.owner.login;
            repositoryName = repoObject.name;
        }
        (string, string) repoDetails => {
            (repositoryOwner, repositoryName) = repoDetails;
        }
    }

    if (repositoryOwner == EMPTY_STRING || repositoryName == EMPTY_STRING) {
        GitClientError gitClientError = { message: "Repository owner and name should be specified" };
        return gitClientError;
    }

    if (recordCount > MAX_RECORD_COUNT) {
        GitClientError gitClientError = { message: "Maximum record count limited to " + MAX_RECORD_COUNT };
        return gitClientError;
    }

    string stringQuery = io:sprintf(TEMPLATE_GET_REPOSITORY_PROJECTS,
        repositoryOwner, repositoryName, state, recordCount);

    http:Request request = new;
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            //Set headers and payload to the request
            constructRequest(request, jsonQuery);
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json|GitClientError validatedResponse = getValidatedResponse(response, GIT_PROJECTS);

    match validatedResponse {
        json jsonValidatedResponse => {
            var githubProjectsJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECTS];
            var projectList = jsonToProjectList(githubProjectsJson, GIT_REPOSITORY, stringQuery);

            return projectList;
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }
}