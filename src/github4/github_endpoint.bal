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
import ballerina/io;

# GitHub Client object.
# + accessToken - The access token of the github account
# + githubRestClient - HTTP client endpoint
# + githubGraphQlClient - HTTP client endpoint
public type Client client object {

    string accessToken;
    http:Client githubRestClient;
    http:Client githubGraphQlClient;

    public function __init(GitHubConfiguration gitHubConfig) {
        self.accessToken = gitHubConfig.accessToken;
        self.githubRestClient = new(GIT_REST_API_URL, gitHubConfig.clientConfig);
        self.githubGraphQlClient = new(GIT_GRAPHQL_API_URL, gitHubConfig.clientConfig);
    }

    # Creates a new issue in a repository.
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + issueTitle - Title of the issue
    # + issueContent - Details of the issue
    # + labelList - List of labels for the issue
    # + assigneeList - Users to be assigned to the issue
    # + return - Created issue object or Connector error
    public remote function createIssue(string repositoryOwner, string repositoryName, string issueTitle,
                                   string issueContent, string[] labelList, string[] assigneeList)
                           returns Issue|error {

        if (repositoryName == EMPTY_STRING || repositoryOwner == EMPTY_STRING || issueTitle == EMPTY_STRING) {
            error connectorError = error(GITHUB_ERROR_CODE,
            message = "Repository name, owner and issue title should be specified");
            return connectorError;
        }

        json[] jsonLabelList = [];
        int i = 0;
        foreach var label in labelList {
            jsonLabelList[i] = label;
            i = i + 1;
        }

        json[] jsonAssigneeList = [];
        int j = 0;
        foreach var assignee in assigneeList {
            jsonAssigneeList[j] = assignee;
            j = j + 1;
        }

        json issueJsonPayload = { "title": issueTitle, "body": issueContent, "labels": jsonLabelList,
            "assignees": jsonAssigneeList };

        http:Request request = new;
        setHeader(request, self.accessToken);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> issueJsonPayload);

        string endpointResource = PATH_SEPARATOR + GIT_REPOS + PATH_SEPARATOR + repositoryOwner +
            PATH_SEPARATOR + repositoryName + PATH_SEPARATOR + GIT_ISSUES;
        // Make an HTTP POST request
        var response = self.githubRestClient->post(endpointResource, request);
        //Check for empty payloads and errors
        json validatedResponse = check getValidatedRestResponse(response);
        return restResponseJsonToIssue(validatedResponse);
    }

    # Get the next page of the card list.
    # + cardList - Card list object
    # + return - Card list object of next page or Connector error
    public remote function getCardListNextPage(CardList cardList) returns CardList|error {
        if (cardList.pageInfo.hasNextPage) {
            var cardListColumnId = cardList.columnId;
            json convertedQuery = check stringToJson(cardList.cardListQuery.toJsonString());
            if (convertedQuery is map<json>) {
                json variables = convertedQuery["variables"];
                if (variables is map<json>) {
                    variables["endCursorCards"] = cardList.pageInfo.endCursor;
                } else {
                    variables = {endCursorCards : cardList.pageInfo.endCursor};
                    convertedQuery["variables"] = variables;
                }

                if (cardList.listOwner == (GIT_ORGANIZATION)) {
                    convertedQuery[GIT_QUERY] = GET_ORGANIZATION_PROJECT_CARDS_NEXT_PAGE;
                    ColumnList columnList = check getProjectColumns(GIT_ORGANIZATION,
                        convertedQuery.toJsonString(), self.githubGraphQlClient, self.accessToken);
                    foreach var column in columnList.getAllColumns() {
                        if (column.id == cardListColumnId) {
                            return column.cards;
                        }
                    }
                } else if (cardList.listOwner == (GIT_REPOSITORY)) {
                    convertedQuery[GIT_QUERY] = GET_REPOSITORY_PROJECT_CARDS_NEXT_PAGE;
                    ColumnList columnList = check getProjectColumns(GIT_REPOSITORY, convertedQuery.toJsonString(),
                        self.githubGraphQlClient, self.accessToken);
                    foreach var column in columnList.getAllColumns() {
                        if (column.id == cardListColumnId) {
                            return column.cards;
                        }
                    }
                }
            } else {
                error err = error(GITHUB_ERROR_CODE, message = "Cannot parse cardListQuery.");
                return err;
            }
        }
        error err = error(GITHUB_ERROR_CODE, message = "Card list has no next page.");
        return err;
    }

    # Get the next page of column list.
    # + columnList - Column list object
    # + return - Column list object of next page or Connector error
    public remote function getColumnListNextPage(ColumnList columnList) returns ColumnList|error {

        if (columnList.hasNextPage()) {
            json jsonQuery = check stringToJson(columnList.columnListQuery);
            if (jsonQuery is map<json>) {
                json variables = jsonQuery["variables"];
                if (variables is map<json>) {
                    variables["endCursorColumns"] = columnList.pageInfo.endCursor;
                } else {
                    variables = {endCursorColumns : columnList.pageInfo.endCursor};
                    jsonQuery["variables"] = variables;
                }

                if (columnList.listOwner == GIT_ORGANIZATION) {
                    jsonQuery[GIT_QUERY] = GET_ORGANIZATION_PROJECT_COLUMNS_NEXT_PAGE;
                    return getProjectColumns(GIT_ORGANIZATION, jsonQuery.toString(), self.githubGraphQlClient,
                    self.accessToken);
                } else if (columnList.listOwner == GIT_REPOSITORY) {
                    jsonQuery[GIT_QUERY] = GET_REPOSITORY_PROJECT_COLUMNS_NEXT_PAGE;
                    return getProjectColumns(GIT_REPOSITORY, jsonQuery.toString(), self.githubGraphQlClient,
                    self.accessToken);
                }
            } else {
                error err = error(GITHUB_ERROR_CODE, message = "Cannot parse columnListQuery.");
                return err;
            }
        }
        error err = error(GITHUB_ERROR_CODE, message = "Column list has no next page.");
        return err;
    }

    # Get a list of branches of a repository.
    # + repository - Repository object or tuple (`repository owner`, `repository name`)
    # + recordCount - Specify number of records in the list
    # + return - Branch list object or Connector error
    public remote function getBranchList(Repository|[string, string] repository, int recordCount)
                           returns @tainted BranchList|error {

        string repositoryOwner = "";
        string repositoryName = "";
        if (repository is Repository) {
            repositoryOwner = repository.owner.login;
            repositoryName = repository.name;
        } else {
            [repositoryOwner, repositoryName] = repository;
        }

        if (repositoryOwner == EMPTY_STRING || repositoryName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Repository owner and name should be specified");
            return err;
        }

        if (recordCount > MAX_RECORD_COUNT) {
            error err = error(GITHUB_ERROR_CODE, message = "Maximum record count limited to " + MAX_RECORD_COUNT.toString());
            return err;
        }

        string stringQuery = io:sprintf(TEMPLATE_GET_REPOSITORY_BRANCHES,
            repositoryOwner, repositoryName, recordCount);

        http:Request request = new;
        setHeader(request, self.accessToken);
        json convertedQuery = check stringToJson(stringQuery);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> convertedQuery);

        // Make an HTTP POST request
        var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

        //Check for empty payloads and errors
        json validatedResponse = check getValidatedResponse(response, GIT_REFS);

        if (validatedResponse is map<json>) {
            var gitData = validatedResponse[GIT_DATA];
            if (gitData is map<json>) {
                var gitRepo = gitData[GIT_REPOSITORY];
                if (gitRepo is map<json>) {
                    var gitBranches = gitRepo[GIT_REFS];
                    var branchList = jsonToBranchList(gitBranches, stringQuery);
                    return branchList;
                }
            } 
        }
        error err = error(GITHUB_ERROR_CODE, message = "Error parsing git issue response");
        return err;
    }

    # Get a list of issues of a repository.
    # + repository - Repository object or tuple (`repository owner`, `repository name`)
    # + state - State of the issue (`STATE_OPEN`, `STATE_CLOSED`, `STATE_ALL`)
    # + recordCount - Specify number of records in the list
    # + return - Issue list object or Connector error
    public remote function getIssueList(Repository|[string, string] repository, string state, int recordCount)
                           returns @tainted IssueList|error {

        string repositoryOwner = "";
        string repositoryName = "";
        if (repository is Repository) {
            repositoryOwner = repository.owner.login;
            repositoryName = repository.name;
        } else {
            [repositoryOwner, repositoryName] = repository;
        }

        if (repositoryOwner == EMPTY_STRING || repositoryName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Repository owner and name should be specified");
            return err;
        }

        if (recordCount > MAX_RECORD_COUNT) {
            error err = error(GITHUB_ERROR_CODE, message = "Maximum record count limited to " + MAX_RECORD_COUNT.toString());
            return err;
        }

        string stringQuery = io:sprintf(TEMPLATE_GET_REPOSITORY_ISSUES,
            repositoryOwner, repositoryName, state, recordCount);

        http:Request request = new;
        setHeader(request, self.accessToken);
        json convertedQuery = check stringToJson(stringQuery);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> convertedQuery);

        // Make an HTTP POST request
        var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

        //Check for empty payloads and errors
        json validatedResponse = check getValidatedResponse(response, GIT_ISSUES);

        if (validatedResponse is map<json>) {
            var gitData = validatedResponse[GIT_DATA];
            if (gitData is map<json>) {
                var gitRepo = gitData[GIT_REPOSITORY];
                if (gitRepo is map<json>) {
                    var githubIssuesJson = gitRepo[GIT_ISSUES];
                    var issueList = jsonToIssueList(githubIssuesJson, stringQuery);
                    return issueList;
                }
            } 
        }
        error err = error(GITHUB_ERROR_CODE, message = "Error parsing git issue response");
        return err;
    }

    # Get the next page of the issue list.
    # + issueList - Issue list object
    # + return - Issue list object of next page or Connector error
    public remote function getIssueListNextPage(IssueList issueList) returns @tainted IssueList|error {

        if (issueList.hasNextPage()) {
            http:Request request = new;
            setHeader(request, self.accessToken);
            json jsonQuery = check stringToJson(issueList.issueListQuery);
            if (jsonQuery is map<json>) {
                json variables = jsonQuery["variables"];
                if (variables is map<json>) {
                    variables["endCursorIssues"] = issueList.pageInfo.endCursor;
                } else {
                    variables = {endCursorIssues : issueList.pageInfo.endCursor};
                    jsonQuery["variables"] = variables;
                }

                jsonQuery[GIT_QUERY] = GET_REPOSITORY_ISSUES_NEXT_PAGE;
                //Set headers and payload to the request
                constructRequest(request, <@untainted> jsonQuery);

                // Make an HTTP POST request
                var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

                //Check for empty payloads and errors
                json jsonValidatedResponse = check getValidatedResponse(response, GIT_ISSUES);
                if (jsonValidatedResponse is map<json>) {
                    var gitData = jsonValidatedResponse[GIT_DATA];
                    if (gitData is map<json>) {
                        var gitRepo = gitData[GIT_REPOSITORY];
                        if (gitRepo is map<json>) {
                            var githubIssuesJson = gitRepo[GIT_ISSUES];
                            var gitIssueList = jsonToIssueList(githubIssuesJson, issueList.issueListQuery);
                            return gitIssueList;
                        }
                    }
                }
                error err = error(GITHUB_ERROR_CODE, message = "Cannot parse jsonValidatedResponse.");
                return err;
            } else {
                error err = error(GITHUB_ERROR_CODE, message = "Cannot parse issueListQuery.");
                return err;
            }       
        } else {
            error err = error(GITHUB_ERROR_CODE, message = "Issue list has no next page.");
            return err;
        }
    }

    # Get an organization.
    # + name - Name of the organization
    # + return - Organization object or Connector error
    public remote function getOrganization(string name) returns @tainted Organization|error {

        if (name == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Organization name should be specified.");
            return err;
        }
        Organization singleOrganization = {};

        string stringQuery = io:sprintf(TEMPLATE_GET_ORGANIZATION, name);

        http:Request request = new;
        setHeader(request, self.accessToken);
        json jsonQuery = check stringToJson(stringQuery);
        // Set headers and payload to the request
        // Set headers and payload to the request
        constructRequest(request, <@untainted> jsonQuery);

        // Make an HTTP POST request
        var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

        json jsonValidatedResponse = check getValidatedResponse(response, GIT_NAME);
        map<json> jsonPayloadInMap = <map<json>> jsonValidatedResponse;
        json githubRepositoryJson = jsonPayloadInMap[GIT_DATA];
        map<json> jsonPayloadInMap1 = <map<json>> githubRepositoryJson;
        return jsonToOrganization(<map<json>>jsonPayloadInMap1[GIT_ORGANIZATION]);
    }

    # Get a single project of an organization.
    # + organization - Organization object or organization name
    # + projectNumber - The number of the project
    # + return - Project object or Connector error
    public remote function getOrganizationProject(Organization|string organization, int projectNumber)
                           returns @tainted Project|error {

        string organizationName = "";
        var value = organization;
        if (value is Organization) {
            organizationName = value.login;
        } else {
            organizationName = value;
        }

        if (organizationName == EMPTY_STRING || projectNumber <= INDEX_ZERO) {
            error err = error(GITHUB_ERROR_CODE,
            message = "Organization should have a name and project number should be positive integer");
            return err;
        }

        string stringQuery = io:sprintf(TEMPLATE_GET_ORGANIZATION_PROJECT, organizationName, projectNumber);

        http:Request request = new;
        setHeader(request, self.accessToken);
        json jsonQuery = check stringToJson(stringQuery);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> jsonQuery);

        // Make an HTTP POST request
        var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

        json jsonValidatedResponse = check getValidatedResponse(response, GIT_PROJECT);
        if (jsonValidatedResponse is map<json>) {
            var gitData = jsonValidatedResponse[GIT_DATA];
            if (gitData is map<json>) {
                var gitOrg = gitData[GIT_ORGANIZATION];
                if (gitOrg is map<json>) {
                    json githubProjectJson = gitOrg[GIT_PROJECT];
                    var result = jsonToProject(githubProjectJson);
                    if (result is Project) {
                        return result;
                    }
                }
            }
        }
        error err = error(GITHUB_ERROR_CODE,
        message = "Error occurred while converting the json into Project.");
        return err;
    }

    # Get all projects of an organization.
    # + organization - Organization object or organization name
    # + state - State of the project (`STATE_OPEN`, `STATE_CLOSED`, `STATE_ALL`)
    # + recordCount - Specify number of records in the list
    # + return - Project list object or Connector error
    public remote function getOrganizationProjectList(Organization|string organization, string state,
                                                  int recordCount) returns @tainted ProjectList|error {

        http:Client gitHubEndpoint = self.githubGraphQlClient;
        string organizationName = "";
        if (organization is Organization) {
            organizationName = organization.login;
        } else {
            organizationName = organization;
        }

        if (organizationName == EMPTY_STRING || state == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE,
            message = "Organization should have a name and project state should be specified");
            return err;
        }

        if (recordCount > MAX_RECORD_COUNT) {
            error err = error(GITHUB_ERROR_CODE,
            message = "Maximum record count limited to " + MAX_RECORD_COUNT.toString());
            return err;
        }

        string stringQuery = io:sprintf(TEMPLATE_GET_ORGANIZATION_PROJECTS, organizationName, state, recordCount);

        http:Request request = new;
        setHeader(request, self.accessToken);
        json jsonQuery = check stringToJson(stringQuery);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> jsonQuery);

        // Make an HTTP POST request
        var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

        //Check for empty payloads and errors
        json jsonValidatedResponse = check getValidatedResponse(response, GIT_PROJECTS);
        if (jsonValidatedResponse is map<json>) {
            var gitData = jsonValidatedResponse[GIT_DATA];
            if (gitData is map<json>) {
                var gitOrg = gitData[GIT_ORGANIZATION];
                if (gitOrg is map<json>) {
                    var githubProjectsJson = gitOrg[GIT_PROJECTS];
                    var projectList = jsonToProjectList(githubProjectsJson, GIT_ORGANIZATION, stringQuery);
                    return projectList;
                }
            }           
        }
        error err = error(GITHUB_ERROR_CODE, message = "Error occurred while converting the json into Project List.");
        return err;
    }

    # Get a list of repositories of an user.
    # + user - User object or user name
    # + recordCount - Specify number of records in the list
    # + return - Repository list object or Connector error
    public remote function getUserRepositoryList(User|string user, int recordCount)
                           returns @tainted RepositoryList|error {

        string userName = "";
        if (user is User) {
            userName = user.login;
        } else {
            userName = user;
        }

        if (userName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "User should have a name");
            return err;
        }

        if (recordCount > MAX_RECORD_COUNT) {
            error err = error(GITHUB_ERROR_CODE, message = "Maximum record count limited to " + MAX_RECORD_COUNT.toString());
            return err;
        }

        string stringQuery = io:sprintf(TEMPLATE_GET_USER_REPOSITORIES, userName, recordCount);

        http:Request request = new;
        setHeader(request, self.accessToken);
        json jsonQuery = check stringToJson(stringQuery);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> jsonQuery);

        // Make an HTTP POST request
        var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

        //Check for empty payloads and errors
        json validatedResponse = check getValidatedResponse(response, GIT_REPOSITORIES);
        if (validatedResponse is map<json>) {
            var gitData = validatedResponse[GIT_DATA];
            if (gitData is map<json>) {
                var gitUser = gitData["user"];
                if (gitUser is map<json>) {
                    var githubRepositoriesJson = gitUser[GIT_REPOSITORIES];
                    var repositoryList = jsonToRepositoryList(githubRepositoriesJson, stringQuery);
                    return repositoryList;
                }
            }
        }
        error err = error(GITHUB_ERROR_CODE, message = "Error parsing org repos");
        return err;
    }

    # Get a list of repositories of an organization.
    # + organization - Organization object or organization name
    # + recordCount - Specify number of records in the list
    # + return - Repository list object or Connector error
    public remote function getOrganizationRepositoryList(Organization|string organization, int recordCount)
                           returns @tainted RepositoryList|error {

        string organizationName = "";
        if (organization is Organization) {
            organizationName = organization.login;
        } else {
            organizationName = organization;
        }

        if (organizationName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Organization should have a name");
            return err;
        }

        if (recordCount > MAX_RECORD_COUNT) {
            error err = error(GITHUB_ERROR_CODE, message = "Maximum record count limited to " +
            MAX_RECORD_COUNT.toString());
            return err;
        }

        string stringQuery = io:sprintf(TEMPLATE_GET_ORGANIZATION_REPOSITORIES, organizationName, recordCount);

        http:Request request = new;
        setHeader(request, self.accessToken);
        json jsonQuery = check stringToJson(stringQuery);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> jsonQuery);

        // Make an HTTP POST request
        var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

        //Check for empty payloads and errors
        json validatedResponse = check getValidatedResponse(response, GIT_REPOSITORIES);
        map<json> mapValidatedResponse = <map<json>> validatedResponse;
        map<json> data = <map<json>> mapValidatedResponse[GIT_DATA];
        map<json> organizationData = <map<json>> data[GIT_ORGANIZATION];
        json githubRepositoriesJson = organizationData[GIT_REPOSITORIES];
        return jsonToRepositoryList(githubRepositoriesJson, stringQuery);
    }

    # Get all columns of a project board.
    # + project - Project object
    # + recordCount - Specify number of records in the list
    # + return - Column list object or Connector error
    public remote function getProjectColumnList(Project project, int recordCount) returns @tainted ColumnList|error {
        if (project["owner"]["__typename"] == EMPTY_STRING || project.number <= INDEX_ZERO ||
                project.resourcePath == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Project owner, number and resource path should be specified");
            return err;
        }

        if (recordCount > MAX_RECORD_COUNT) {
            error err = error(GITHUB_ERROR_CODE, message = "Maximum record count limited to " + MAX_RECORD_COUNT.toString());
            return err;
        }

        string projectOwnerType = <string>project["owner"]["__typename"];
        string resourcePath = "";
        if (project.resourcePath is string) {
            resourcePath = <string>project.resourcePath;
        } else {        
            resourcePath = EMPTY_STRING;
        }
        if (projectOwnerType == GIT_ORGANIZATION) {
            string organization = split(resourcePath, PATH_SEPARATOR, INDEX_TWO);
            string stringQuery = io:sprintf(TEMPLATE_GET_ORGANIZATION_PROJECT_COLUMNS,
                organization, project.number, recordCount);
            return getProjectColumns(GIT_ORGANIZATION, stringQuery, self.githubGraphQlClient, self.accessToken);
        } else if (projectOwnerType == GIT_REPOSITORY) {

            string ownerName = split(resourcePath, PATH_SEPARATOR, INDEX_ONE);
            string repositoryName = split(resourcePath, PATH_SEPARATOR, INDEX_TWO);
            string stringQuery = io:sprintf(TEMPLATE_GET_REPOSITORY_PROJECT_COLUMNS,
                ownerName, repositoryName, project.number, recordCount);
            return getProjectColumns(GIT_REPOSITORY, stringQuery, self.githubGraphQlClient, self.accessToken);
        } else {
            error err = error(GITHUB_ERROR_CODE, message = "No records found.");
            return err;
        }
    }

    # Gets the next page of a project list.
    # + projectList - Project list object
    # + return - Project list object of next page or Connector error
    public remote function getProjectListNextPage(ProjectList projectList) returns @tainted ProjectList|error {

        if (projectList.hasNextPage()) {

            http:Request request = new;
            setHeader(request, self.accessToken);
            json dataQuery;
            json jsonQuery = check stringToJson(projectList.projectListQuery);
            if (jsonQuery is map<json>) {
                json variables = jsonQuery["variables"];
                if (variables is map<json>) {
                    variables["endCursorProjects"] = projectList.pageInfo.endCursor;
                } else {
                    variables = {endCursorProjects : projectList.pageInfo.endCursor};
                    jsonQuery["variables"] = variables;
                }

                if (projectList.listOwner == GIT_ORGANIZATION) {
                    jsonQuery[GIT_QUERY] = GET_ORGANIZATION_PROJECTS_NEXT_PAGE;
                } else if (projectList.listOwner == GIT_REPOSITORY) {
                    jsonQuery[GIT_QUERY] = GET_REPOSITORY_PROJECTS_NEXT_PAGE;
                }
                dataQuery = jsonQuery;
                //Set headers and payload to the request
                constructRequest(request, <@untainted> jsonQuery);

                // Make an HTTP POST request
                var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

                //Check for empty payloads and errors
                json validatedResponse = check getValidatedResponse(response, GIT_PROJECTS);
                if (validatedResponse is map<json>) {
                    var gitData = validatedResponse[GIT_DATA];
                    if (gitData is map<json>) {
                        var projectOwner = gitData[projectList.listOwner];
                        if (projectOwner is map<json>) {
                            var projectsJson = projectOwner[GIT_PROJECTS];
                            var projList = jsonToProjectList(projectsJson, projectList.listOwner, dataQuery.toString());
                            return projList;
                        }
                    }
                }
                error err = error(GITHUB_ERROR_CODE, message = "Cannot parse projectListQuery response.");
                return err;
            } else {
                error err = error(GITHUB_ERROR_CODE, message = "Cannot parse projectListQuery.");
                return err;
            }
        } else {
            error err = error(GITHUB_ERROR_CODE, message = "Project list has no next page");
            return err;
        }
    }

    # Get all pull requests of a repository.
    # + repository - Repository object or tuple `("repository owner", "repository name")`
    # + state - State of the pull request (STATE_OPEN, STATE_CLOSED, STATE_MERGED, STATE_ALL)
    # + recordCount - Specify number of records in the list
    # + return - Pull request list object or Connector error
    public remote function getPullRequestList(Repository|[string, string] repository, string state, int recordCount)
                           returns @tainted PullRequestList|error {

        string repositoryOwner;
        string repositoryName;
        if (repository is Repository) {
            repositoryOwner = repository.owner.login;
            repositoryName = repository.name;
        } else {
            [repositoryOwner, repositoryName] = repository;
        }
        if (repositoryOwner == EMPTY_STRING || repositoryName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Repository owner and name should be specified");
            return err;
        }

        if (recordCount > MAX_RECORD_COUNT) {
            error err = error(GITHUB_ERROR_CODE, message = "Maximum record count limited to " + MAX_RECORD_COUNT.toString());
            return err;
        }

        string stringQuery = io:sprintf(TEMPLATE_GET_PULL_REQUESTS, repositoryOwner, repositoryName, state, recordCount);

        http:Request request = new;
        setHeader(request, self.accessToken);
        json jsonQuery = check stringToJson(stringQuery);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> jsonQuery);

        // Make an HTTP POST request
        var response = self.githubGraphQlClient->post(EMPTY_STRING, request);
        //Check for empty payloads and errors
        json validatedResponse = check getValidatedResponse(response, GIT_PULL_REQUESTS);
        if (validatedResponse is map<json>) {
            var gitData = validatedResponse[GIT_DATA];
            if (gitData is map<json>) {
                var gitRepo = gitData[GIT_REPOSITORY];
                if (gitRepo is map<json>) {
                    var githubPullRequestsJson = gitRepo[GIT_PULL_REQUESTS];
                    var pullRequestList = jsonToPullRequestList(githubPullRequestsJson, stringQuery);
                    return pullRequestList;
                }
            }
        }
        error err = error(GITHUB_ERROR_CODE, message = "Cannot parse getPullRequestList response.");
        return err;
    }

    # Get the next page of the pull request list.
    # + pullRequestList - Pull request list object
    # + return - Pull request list object of next page or Connector error
    public remote function getPullRequestListNextPage(PullRequestList pullRequestList) returns @tainted
    PullRequestList|error {

        if (pullRequestList.hasNextPage()) {

            http:Request request = new;
            setHeader(request, self.accessToken);
            json jsonQuery = check stringToJson(pullRequestList.pullRequestListQuery);
            if (jsonQuery is map<json>) {
                json variables = jsonQuery["variables"];
                if (variables is map<json>) {
                    variables["endCursorPullRequests"] = pullRequestList.pageInfo.endCursor;
                } else {
                    variables = {endCursorPullRequests : pullRequestList.pageInfo.endCursor};
                    jsonQuery["variables"] = variables;
                }

                jsonQuery[GIT_QUERY] = GET_PULL_REQUESTS_NEXT_PAGE;
                //Set headers and payload to the request
                constructRequest(request, <@untainted> jsonQuery);

                // Make an HTTP POST request
                var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

                //Check for empty payloads and errors
                json jsonValidatedResponse = check getValidatedResponse(response, GIT_PULL_REQUESTS);
                if (jsonValidatedResponse is map<json>) {
                    var gitData = jsonValidatedResponse[GIT_DATA];
                    if (gitData is map<json>) {
                        var gitRepo = gitData[GIT_REPOSITORY];
                        if (gitRepo is map<json>) {
                            var projectColumnsJson = gitRepo[GIT_PULL_REQUESTS];
                            var prList = jsonToPullRequestList(projectColumnsJson, pullRequestList.pullRequestListQuery);
                            return prList;
                        }
                    }
                }
                error err = error(GITHUB_ERROR_CODE, message = "Cannot parse pullRequestListQuery response.");
                return err;
            } else {
                error err = error(GITHUB_ERROR_CODE, message = "Cannot parse pullRequestListQuery.");
                return err;
            }     
        } else {
            error err = error(GITHUB_ERROR_CODE, message = "Pull request list has no next page.");
            return err;
        }
    }

    # Get a repository of an owner.
    # + repoIdentifier - Name of the repository and its owner Format: ("owner/repository")
    # + return - Repository object or Connector error
    public remote function getRepository(string|[string, string] repoIdentifier) returns @tainted
    Repository|error {

        string repoOwner;
        string repoName;
        if (repoIdentifier is string) {
            repoOwner = split(repoIdentifier, PATH_SEPARATOR, INDEX_ZERO);
            repoName = split(repoIdentifier, PATH_SEPARATOR, INDEX_ONE);
        } else {
            [repoOwner, repoName] = repoIdentifier;
        }
        
        if (repoOwner == EMPTY_STRING || repoName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Repository owner and name should be specified.");
            return err;
        }

        Repository singleRepository = {};

        string stringQuery = io:sprintf(TEMPLATE_GET_REPOSITORY, repoOwner, repoName);

        http:Request request = new;
        setHeader(request, self.accessToken);
        json jsonQuery = check stringToJson(stringQuery);
        // Set headers and payload to the request
        constructRequest(request, <@untainted> jsonQuery);

        // Make an HTTP POST request
        var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

        json jsonValidatedResponse = check getValidatedResponse(response, GIT_NAME);
        map<json> mapJsonValidatedResponse = <map<json>> jsonValidatedResponse;
        map<json> data = <map<json>> mapJsonValidatedResponse[GIT_DATA];
        map<json> githubRepositoryJson = <map<json>> data[GIT_REPOSITORY];
        return jsonToRepository(githubRepositoryJson);
    }

    # Get the next page of a repository list.
    # + repositoryList - Repository list object
    # + return - Repository list object of next page or Connector error
    public remote function getRepositoryListNextPage(RepositoryList repositoryList) returns @tainted
    RepositoryList|error {

        if (repositoryList.hasNextPage()) {

            http:Request request = new;
            setHeader(request, self.accessToken);
            json jsonQuery = check stringToJson(repositoryList.repositoryListQuery);
            if (jsonQuery is map<json>) {
                json variables = jsonQuery["variables"];
                if (variables is map<json>) {
                    variables["endCursorRepos"] = repositoryList.pageInfo.endCursor;
                } else {
                    variables = {endCursorRepos : repositoryList.pageInfo.endCursor};
                    jsonQuery["variables"] = variables;
                }

                jsonQuery[GIT_QUERY] = GET_ORGANIZATION_REPOSITORIES_NEXT_PAGE;
                //Set headers and payload to the request
                constructRequest(request, <@untainted> jsonQuery);

                // Make an HTTP POST request
                var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

                //Check for empty payloads and errors
                json jsonValidatedResponse = check getValidatedResponse(response, GIT_REPOSITORIES);
                if (jsonValidatedResponse is map<json>) {
                    var gitData = jsonValidatedResponse[GIT_DATA];
                    if (gitData is map<json>) {
                        var gitOrg = gitData[GIT_ORGANIZATION];
                        if (gitOrg is map<json>) {
                            var repositoriesJson = gitOrg[GIT_REPOSITORIES];
                            var repoList = jsonToRepositoryList(repositoriesJson, repositoryList.repositoryListQuery);
                            return repoList;
                        }
                    }
                }
                error err = error(GITHUB_ERROR_CODE, message = "Cannot parse repositoryListQuery response.");
                return err;
            } else {
                error err = error(GITHUB_ERROR_CODE, message = "Cannot parse repositoryListQuery.");
                return err;
            }      
        } else {
            error err = error(GITHUB_ERROR_CODE, message = "Repository list has no next page.");
            return err;
        }
    }

    # Get a single project of a repository.
    # + repository - Repository object or tuple `("repository owner", "repository name")`
    # + projectNumber - Project identification number
    # + return - Project object or Connector error
    public remote function getRepositoryProject(Repository|[string, string] repository, int projectNumber)
                           returns @tainted Project|error {

        string repositoryOwner;
        string repositoryName;
        if (repository is Repository) {
            repositoryOwner = repository.owner.login;
            repositoryName = repository.name;
        } else {
            [repositoryOwner, repositoryName] = repository;
        }

        if (repositoryOwner == EMPTY_STRING || repositoryName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Repository owner and name should be specified");
            return err;
        }

        string stringQuery = io:sprintf(TEMPLATE_GET_REPOSITORY_PROJECT, repositoryOwner, repositoryName, projectNumber);

        http:Request request = new;
        setHeader(request, self.accessToken);
        json jsonQuery = check stringToJson(stringQuery);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> jsonQuery);

        // Make an HTTP POST request
        var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

        //Check for empty payloads and errors
        json jsonValidatedResponse = check getValidatedResponse(response, GIT_PROJECT);
        if (jsonValidatedResponse is map<json>) {
            var gitData = jsonValidatedResponse[GIT_DATA];
            if (gitData is map<json>) {
                var gitRepo = gitData[GIT_REPOSITORY];
                if (gitRepo is map<json>) {
                    var githubProjectJson = gitRepo[GIT_PROJECT];
                    return jsonToProject(githubProjectJson);
                }
            }
        }
        error err = error(GITHUB_ERROR_CODE, message = "Cannot parse json response.");
        return err;
    }

    # Get all projects of a repository.
    # + repository - Repository object or tuple `("repository owner", "repository name")`
    # + state - State of the project (STATE_OPEN, STATE_CLOSED, STATE_ALL)
    # + recordCount - Specify number of records in the list
    # + return - Project list object or Connector error
    public remote function getRepositoryProjectList(Repository|[string, string] repository, string state,
                                                int recordCount) returns @tainted ProjectList|error {

        string repositoryOwner;
        string repositoryName;
        if (repository is Repository) {
            repositoryOwner = repository.owner.login;
            repositoryName = repository.name;
        } else {
            [repositoryOwner, repositoryName] = repository;
        }

        if (repositoryOwner == EMPTY_STRING || repositoryName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Repository owner and name should be specified");
            return err;
        }

        if (recordCount > MAX_RECORD_COUNT) {
            error err = error(GITHUB_ERROR_CODE, message = "Maximum record count limited to " + MAX_RECORD_COUNT.toString());
            return err;
        }

        string stringQuery = io:sprintf(TEMPLATE_GET_REPOSITORY_PROJECTS,
            repositoryOwner, repositoryName, state, recordCount);

        http:Request request = new;
        setHeader(request, self.accessToken);
        json jsonQuery = check stringToJson(stringQuery);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> jsonQuery);

        // Make an HTTP POST request
        var response = self.githubGraphQlClient->post(EMPTY_STRING, request);

        //Check for empty payloads and errors
        json jsonValidatedResponse = check getValidatedResponse(response, GIT_PROJECTS);
        if (jsonValidatedResponse is map<json>) {
            var gitData = jsonValidatedResponse[GIT_DATA];
            if (gitData is map<json>) {
                var gitRepo = gitData[GIT_REPOSITORY];
                if (gitRepo is map<json>) {
                    var githubProjectsJson = gitRepo[GIT_PROJECTS];
                    var projectList = jsonToProjectList(githubProjectsJson, GIT_REPOSITORY, stringQuery);
                    return projectList;
                }
            }
        }
        error err = error(GITHUB_ERROR_CODE, message = "Cannot parse json response.");
        return err;
    }
};

# Represents the Github Client Connector Endpoint configuration.
# + clientConfig - HTTP client endpoint configuration
# + accessToken - The access token of the Github account
public type GitHubConfiguration record {
    http:ClientConfiguration clientConfig = {};
    string accessToken;
};
