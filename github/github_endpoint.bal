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

# GitHub Client object.
# + accessToken - The access token of the github account
# + githubRestClient - HTTP client endpoint
# + githubGraphQlClient - HTTP client endpoint
@display {label: "GitHub Client"}
public client class Client {

    string accessToken;
    http:Client githubRestClient;
    http:Client githubGraphQlClient;
    map<string> headers;

    public isolated function init(GitHubConfiguration gitHubConfig) {
        self.accessToken = gitHubConfig.accessToken;
        self.githubRestClient = checkpanic new(GIT_REST_API_URL, gitHubConfig.clientConfig);
        self.githubGraphQlClient = checkpanic new(GIT_GRAPHQL_API_URL, gitHubConfig.clientConfig);
        self.headers = {
           "Authorization": "token " + self.accessToken
        };
    }

    # Get authenticated User
    # 
    # + return - User object or Connector error
    @display {label: "Get Authenticated User"}
    remote isolated function getAuthenticatedUser() returns @display {label: "Authenticated user"} User|error {
        string path = PATH_SEPARATOR + GIT_USER;
        http:Request request = new;
        setHeader(request, self.accessToken);
        var response = self.githubRestClient->get(path,self.headers);
        json validatedResponse = check getValidatedRestResponse(response);
        return restResponseJsonToUser(validatedResponse);
    }

    # Creates a new issue in a repository.
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + issueTitle - Title of the issue
    # + issueContent - Details of the issue
    # + labelList - List of labels for the issue
    # + assigneeList - Users to be assigned to the issue
    # + return - Created issue object or Connector error
    @display {label: "Create An Issue"}
    remote isolated function createIssue(@display {label: "Repository owner username"} string repositoryOwner, @display {label: "Repository name"} string repositoryName, @display {label: "Title of the issue"} string issueTitle,
                                   @display {label: "Detail of the issue"} string issueContent, @display {label: "List of label names for the issue"} string[] labelList, @display {label: "Assignee's username list"} string[] assigneeList)
                           returns @display {label: "Created issue object"} Issue|error {

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
    @display {label: "Get project card list next page"}
    remote isolated function getCardListNextPage(@display {label: "Card list"} CardList cardList) returns @display {label: "Card list next page"} CardList|error {
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
    @display {label: "Get project column list next page"}
    remote isolated function getColumnListNextPage(@display {label: "Column list object"} ColumnList columnList) returns @display {label: "Column list next page"} ColumnList|error {

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
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + recordCount - Specify number of records in the list
    # + return - Branch list object or Connector error
    @display {label: "Get branch list"}
    remote isolated function getBranchList(@display {label: "Repository owner username"} string repositoryOwner, @display {label: "Repository name"}  string repositoryName, @display {label: "Number of records per page"} int recordCount)
                           returns @tainted @display {label: "Branch list"} BranchList|error {

        if (repositoryOwner == EMPTY_STRING || repositoryName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Repository owner and name should be specified");
            return err;
        }

        if (recordCount > MAX_RECORD_COUNT) {
            error err = error(GITHUB_ERROR_CODE, message = "Maximum record count limited to " + MAX_RECORD_COUNT.toString());
            return err;
        }

        string stringQuery = getTemplateStringForGetRepoBranches(repositoryOwner, repositoryName, recordCount);

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
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + state - State of the issue (`STATE_OPEN`, `STATE_CLOSED`, `STATE_ALL`)
    # + recordCount - Specify number of records in the list
    # + return - Issue list object or Connector error
    @display {label: "Get a list of issues of a repository"}
    remote isolated function getIssueList(@display {label: "Repository owner username"} string repositoryOwner, @display {label: "Repository name"}  string repositoryName, @display {label: "State of the issue"} string state, @display {label: "Number of records per page"} int recordCount)
                           returns @tainted @display {label: "Issue list"} IssueList|error {


        if (repositoryOwner == EMPTY_STRING || repositoryName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Repository owner and name should be specified");
            return err;
        }

        if (recordCount > MAX_RECORD_COUNT) {
            error err = error(GITHUB_ERROR_CODE, message = "Maximum record count limited to " + MAX_RECORD_COUNT.toString());
            return err;
        }

        string stringQuery = getTemplateStringForGetRepoIssues(repositoryOwner, repositoryName, state, recordCount);

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
    @display {label: "Get issue list next page"}
    remote isolated function getIssueListNextPage(@display {label: "Issue list"} IssueList issueList) returns @tainted @display {label: "Issue list"} IssueList|error {

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
    # + organizationName - Name of the organization
    # + return - Organization object or Connector error
    @display {label: "Get an organization"}
    remote isolated function getOrganization(@display {label: "Organization name"} string organizationName) returns @tainted @display {label: "Organization"} Organization|error {

        if (organizationName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Organization name should be specified.");
            return err;
        }
        Organization singleOrganization = {};

        string stringQuery = getTemplateStringForGetOrganization(organizationName);

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
    # + organizationName - Organization object or organization name
    # + projectNumber - The number of the project
    # + return - Project object or Connector error
    @display {label: "Get an organization's project"}
    remote isolated function getOrganizationProject(@display {label: "Organization name"} string organizationName, @display {label: "Project number"} int projectNumber)
                           returns @tainted @display {label: "Project"} Project|error {

        if (organizationName == EMPTY_STRING || projectNumber <= INDEX_ZERO) {
            error err = error(GITHUB_ERROR_CODE,
            message = "Organization should have a name and project number should be positive integer");
            return err;
        }

        string stringQuery = getTemplateStringForGetOrgProject(organizationName, projectNumber);

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
    # + organizationName - Organization object or organization name
    # + state - State of the project (`STATE_OPEN`, `STATE_CLOSED`, `STATE_ALL`)
    # + recordCount - Specify number of records in the list
    # + return - Project list object or Connector error
    @display {label: "Get an organization's project list"}
    remote isolated function getOrganizationProjectList(@display {label: "Organization name"} string organizationName, @display {label: "State of the project"} string state,
                                                  @display {label: "Number of records per page"} int recordCount) returns @tainted @display {label: "Project list"} ProjectList|error {

        http:Client gitHubEndpoint = self.githubGraphQlClient;

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

        string stringQuery = getTemplateStringForGetOrgProjects(organizationName, state, recordCount);

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
    # + userName - User object or user name
    # + recordCount - Specify number of records in the list
    # + return - Repository list object or Connector error
    @display {label: "Get an user's repository list"}
    remote isolated function getUserRepositoryList(@display {label: "Username"} string userName, @display {label: "Number of records per page"} int recordCount)
                           returns @tainted @display {label: "Repository list"} RepositoryList|error {

        if (userName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "User name should be specified");
            return err;
        }

        if (recordCount > MAX_RECORD_COUNT) {
            error err = error(GITHUB_ERROR_CODE, message = "Maximum record count limited to " + MAX_RECORD_COUNT.toString());
            return err;
        }

        string stringQuery = getTemplateStringForGetUserRepositories(userName, recordCount);

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
    # + organizationName - Organization name
    # + recordCount - Specify number of records in the list
    # + return - Repository list object or Connector error
    @display {label: "Get an organization's repository list"}
    remote isolated function getOrganizationRepositoryList(@display {label: "Organization name"} string organizationName, @display {label: "Number of records per page"} int recordCount)
                           returns @tainted @display {label: "Repository list"} RepositoryList|error {

        if (organizationName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Organization should have a name");
            return err;
        }

        if (recordCount > MAX_RECORD_COUNT) {
            error err = error(GITHUB_ERROR_CODE, message = "Maximum record count limited to " +
            MAX_RECORD_COUNT.toString());
            return err;
        }

        string stringQuery = getTemplateStringForGetOrgRepositories(organizationName, recordCount);

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
    @display {label: "Get a project's column list"}
    remote isolated function getProjectColumnList(@display {label: "Project"} Project project, @display {label: "Number of records per page"} int recordCount) returns @tainted @display {label: "Column list"} ColumnList|error {
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
            string stringQuery = getTemplateStringForGetOrgProjectColumns(organization, project.number, recordCount);
            return getProjectColumns(GIT_ORGANIZATION, stringQuery, self.githubGraphQlClient, self.accessToken);
        } else if (projectOwnerType == GIT_REPOSITORY) {
            string ownerName = split(resourcePath, PATH_SEPARATOR, INDEX_ONE);
            string repositoryName = split(resourcePath, PATH_SEPARATOR, INDEX_TWO);
            string stringQuery = getTemplateStringForGetRepoProjectColumns(ownerName, repositoryName, project.number, recordCount);
            return getProjectColumns(GIT_REPOSITORY, stringQuery, self.githubGraphQlClient, self.accessToken);
        } else {
            error err = error(GITHUB_ERROR_CODE, message = "No records found.");
            return err;
        }
    }

    # Gets the next page of a project list.
    # + projectList - Project list object
    # + return - Project list object of next page or Connector error
    @display {label: "Get project list next page"}
    remote isolated function getProjectListNextPage(@display {label: "Project list"} ProjectList projectList) returns @tainted @display {label: "Next page of the project list"} ProjectList|error {
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
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + state - State of the pull request (STATE_OPEN, STATE_CLOSED, STATE_MERGED, STATE_ALL)
    # + recordCount - Specify number of records in the list
    # + return - Pull request list object or Connector error
    @display {label: "Get pull request list"}
    remote isolated function getPullRequestList(@display {label: "Repository owner username"} string repositoryOwner, @display {label: "Repository name"} string repositoryName, @display {label: "State of the pull request"} string state, @display {label: "Number of records per page"} int recordCount)
                           returns @tainted @display {label: "Pull request list"} PullRequestList|error {

        if (repositoryOwner == EMPTY_STRING || repositoryName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Repository owner and name should be specified");
            return err;
        }

        if (recordCount > MAX_RECORD_COUNT) {
            error err = error(GITHUB_ERROR_CODE, message = "Maximum record count limited to " + MAX_RECORD_COUNT.toString());
            return err;
        }

        string stringQuery = getTemplateStringForGetPullRequests(repositoryOwner, repositoryName, state, recordCount);

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
    @display {label: "Get pull request list next page"}
    remote isolated function getPullRequestListNextPage(@display {label: "Pull request list"} PullRequestList pullRequestList) returns @tainted
    @display {label: "Next page of pull request list"} PullRequestList|error {

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
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + return - Repository object or Connector error
    @display {label: "Get a repository"}
    remote isolated function getRepository(@display {label: "Repository owner username"} string repositoryOwner, @display {label: "Repository name"} string repositoryName) returns @tainted
    @display {label: "Repository"} Repository|error {

        if (repositoryOwner == EMPTY_STRING || repositoryName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Repository owner and name should be specified.");
            return err;
        }

        Repository singleRepository = {};

        string stringQuery = getTemplateStringForGetRepository(repositoryOwner, repositoryName);

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
    @display {label: "Get repository list next page"}
    remote isolated function getRepositoryListNextPage(@display {label: "Repository list"} RepositoryList repositoryList) returns @tainted
    @display {label: "Next page of repository list"} RepositoryList|error {

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
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + projectNumber - Project identification number
    # + return - Project object or Connector error
    @display {label: "Get repository project"}
    remote isolated function getRepositoryProject(@display {label: "Repository owner username"} string repositoryOwner, @display {label: "Repository name"} string repositoryName, @display {label: "Project number"} int projectNumber)
                           returns @tainted @display {label: "Project"} Project|error {

        if (repositoryOwner == EMPTY_STRING || repositoryName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Repository owner and name should be specified");
            return err;
        }

        string stringQuery = getTemplateStringForGetRepoProject(repositoryOwner, repositoryName, projectNumber);

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
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + state - State of the project (STATE_OPEN, STATE_CLOSED, STATE_ALL)
    # + recordCount - Specify number of records in the list
    # + return - Project list object or Connector error
    @display {label: "Get repository project list"}
    remote isolated function getRepositoryProjectList(@display {label: "Repository owner username"} string repositoryOwner, @display {label: "Repository name"} string repositoryName, @display {label: "State of the project"} string state,
                                                @display {label: "Number of records per page"} int recordCount) returns @tainted @display {label: "Project list"} ProjectList|error {

        if (repositoryOwner == EMPTY_STRING || repositoryName == EMPTY_STRING) {
            error err = error(GITHUB_ERROR_CODE, message = "Repository owner and name should be specified");
            return err;
        }

        if (recordCount > MAX_RECORD_COUNT) {
            error err = error(GITHUB_ERROR_CODE, message = "Maximum record count limited to " + MAX_RECORD_COUNT.toString());
            return err;
        }

        string stringQuery = getTemplateStringForGetRepoProjects(repositoryOwner, repositoryName, state, recordCount);

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

    # Creates a new Pull request .
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + pullRequest -  Pull request create record
    # + return - Created issue object or Connector error
    @display {label: "Create a pull request"}
    remote isolated function createPullRequest(@display {label: "Repository owner username"} string repositoryOwner, @display {label: "Repository name"} string repositoryName, @display {label: "Pull request creation"} PullRequestCreate pullRequest)
                           returns PullRequest|error {

        if (repositoryName == EMPTY_STRING || repositoryOwner == EMPTY_STRING) {
            error connectorError = error(GITHUB_ERROR_CODE,
            message = "Repository name, owner should be specified");
            return connectorError;
        }

        json createPullRequestPayload = check pullRequest.cloneWithType(json);

        http:Request request = new;
        setHeader(request, self.accessToken);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> createPullRequestPayload);

        string endpointResource = PATH_SEPARATOR + GIT_REPOS + PATH_SEPARATOR + repositoryOwner +
            PATH_SEPARATOR + repositoryName + PATH_SEPARATOR + GIT_PULLS;
        // Make an HTTP POST request
        var response = self.githubRestClient->post(endpointResource, request);
        //Check for empty payloads and errors
        json validatedResponse = check getValidatedRestResponse(response);
        return jsonToPullRequest(<map<json>>validatedResponse);

    }

    # Creates a review comment for a pull request .
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + pullNumber - Pull request number
    # + pullRequestReviewComment - Pull request review comment create record
    # + return - Created PullRequestReviewComment object or Connector error
    @display {label: "Create a pull request review comment"}
    remote isolated function createPullRequestReviewComment(@display {label: "Repository owner username"} string repositoryOwner, @display {label: "Repository name"} string repositoryName, @display {label: "Pull request number"} int pullNumber, @display {label: "Pull request review comment create record"} PullRequestReviewCommentCreate pullRequestReviewComment)
                           returns @display {label: "Pull request review comment"} PullRequestReviewComment|error {

        if (repositoryName == EMPTY_STRING || repositoryOwner == EMPTY_STRING) {
            error connectorError = error(GITHUB_ERROR_CODE,
            message = "Repository name, owner should be specified");
            return connectorError;
        }

        json createPullRequestReviewCommentPayload = check pullRequestReviewComment.cloneWithType(json);

        http:Request request = new;
        setHeader(request, self.accessToken);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> createPullRequestReviewCommentPayload);

        string endpointResource = string `${PATH_SEPARATOR}${GIT_REPOS}${PATH_SEPARATOR}${repositoryOwner}${PATH_SEPARATOR}${repositoryName}${PATH_SEPARATOR}${GIT_PULLS}${PATH_SEPARATOR}${pullNumber}${PATH_SEPARATOR}${GIT_COMMENTS}`;
        // Make an HTTP POST request
        var response = self.githubRestClient->post(endpointResource, request);
        //Check for empty payloads and errors
        json validatedResponse = check getValidatedRestResponse(response);
        // return jsonToPullRequestReviewComment(<map<json>>validatedResponse);
        return check validatedResponse.cloneWithType(PullRequestReviewComment);

    }

    # Create a review for a pull request
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + pullNumber - Pull request number
    # + pullRequestReview - PullRequestReviewCreate record
    # + return - Created PullRequestReview object or Connector error
    @display {label: "Create a review for a pull request"}
    remote isolated function createPullRequestReview(@display {label: "Repository owner username"} string repositoryOwner, @display {label: "Repository name"} string repositoryName, @display {label: "Pull request number"} int pullNumber , @display {label: "Pull request review create"} PullRequestReviewCreate pullRequestReview)
                           returns @display {label: "Pull request review"} PullRequestReview|error {

        if (repositoryName == EMPTY_STRING || repositoryOwner == EMPTY_STRING) {
            error connectorError = error(GITHUB_ERROR_CODE,
            message = "Repository name, owner should be specified");
            return connectorError;
        }

        json createPullRequestReviewPayload = check pullRequestReview.cloneWithType(json);


        http:Request request = new;
        setHeader(request, self.accessToken);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> createPullRequestReviewPayload);

        string endpointResource = string `${PATH_SEPARATOR}${GIT_REPOS}${PATH_SEPARATOR}${repositoryOwner}${PATH_SEPARATOR}${repositoryName}${PATH_SEPARATOR}${GIT_PULLS}${PATH_SEPARATOR}${pullNumber}${PATH_SEPARATOR}${GIT_REVIEWS}`;
        // Make an HTTP POST request
        var response = self.githubRestClient->post(endpointResource, request);
        //Check for empty payloads and errors
        json validatedResponse = check getValidatedRestResponse(response);

        return jsonToPullRequestReview(<map<json>>validatedResponse);
    }



    # Delete a brach
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + branchName - Name of the branch to delete
    # + return - An error if operation failed.
    @display {label: "Delete a branch"}
    remote isolated function deleteBranch(@display {label: "Repository owner username"} string repositoryOwner, @display {label: "Repository name"} string repositoryName, @display {label: "Name of the branch"} string branchName)
                           returns error? {

        if (repositoryName == EMPTY_STRING || repositoryOwner == EMPTY_STRING) {
            error connectorError = error(GITHUB_ERROR_CODE,
            message = "Repository name, owner should be specified");
            return connectorError;
        }

        http:Request request = new;
        setHeader(request, self.accessToken);

        string endpointResource = string `${PATH_SEPARATOR}${GIT_REPOS}${PATH_SEPARATOR}${repositoryOwner}${PATH_SEPARATOR}${repositoryName}${PATH_SEPARATOR}${GIT}${PATH_SEPARATOR}${GIT_BRANCH_REF_PREFIX}${branchName}`;
        // Make an HTTP DELETE request
        var response = self.githubRestClient->delete(endpointResource, request);

        if(response is http:Response){
            if(response.statusCode == 422) {
                error err = error(GITHUB_ERROR_CODE, message = "Unprocessable Entity - Validation failed");
                return err;
            }
        } else {
            error err = error(GITHUB_ERROR_CODE, message = "HTTP Connector Error");
            return err;
        }

    }

    # Create a Gist
    # + createGist - Gist create request payload
    # + return - Created Gist object or Connector error
    @display {label: "Create a gist"}
    remote isolated function createGist(@display {label: "Gist Create"} GistCreate createGist)
                           returns @display {label: "Gist"} Gist|error {

        if (createGist.gistFiles.length()<=0) {
            error connectorError = error(GITHUB_ERROR_CODE,
            message = "Required. names and content for the files that make up gist");
            return connectorError;
        }

        http:Request request = new;
        setHeader(request, self.accessToken);

        map<json> files = {};

        foreach var file in createGist.gistFiles {
            files[file.fileName] = {
                "content": file.content
            };
        }

        map<json> payload = {
            description: createGist?.description,
            'public: createGist?.'public,
            files:files
        };

        constructRequest(request, <@untainted> payload);

        string endpointResource = string `${PATH_SEPARATOR}${GIT_GISTS}`;
        // Make an HTTP POST request
        var response = self.githubRestClient->post(endpointResource, request);
        //Check for empty payloads and errors
        json validatedResponse = check getValidatedRestResponse(response);

        return check validatedResponse.cloneWithType(Gist);
    }

    # Check Organization Membership
    # + organization - Name of the organization
    # + username - GitHub username of the member
    # + return - OrganizationMembership object or Connector error
    @display {label: "Check organization membership"}
    remote isolated function getOrganizationUserMembership(@display {label: "Organization name"} string organization, @display {label: "GitHub username of the member"} string username)
                           returns @display {label: "Organization membership"} OrganizationMembership|error {

        if (organization == EMPTY_STRING || username == EMPTY_STRING) {
            error connectorError = error(GITHUB_ERROR_CODE,
            message = "Organization name, username should be specified");
            return connectorError;
        }

        string endpointResource = string `${PATH_SEPARATOR}${GIT_ORGS}${PATH_SEPARATOR}${organization}${PATH_SEPARATOR}${GIT_MEMBERSHIPS}${PATH_SEPARATOR}${username}`;
        // Make an HTTP POST request
        var response = self.githubRestClient->get(endpointResource, self.headers);
        //Check for empty payloads and errors
        json validatedResponse = check getValidatedRestResponse(response);

        return check validatedResponse.cloneWithType(OrganizationMembership);

    }

    # Find a user
    # + username - GitHub username of the member
    # + return - User object or Connector error
    @display {label: "Find a user"}
    remote isolated function getUser(@display {label: "GitHub username of the user"} string username)
                           returns @display {label: "User"} User|error {

        if (username == EMPTY_STRING) {
            error connectorError = error(GITHUB_ERROR_CODE,
            message = "Username should be specified");
            return connectorError;
        }

        string endpointResource = string `${PATH_SEPARATOR}${GIT_USERS}${PATH_SEPARATOR}${username}`;
        // Make an HTTP GET request
        var response = self.githubRestClient->get(endpointResource, self.headers);
        //Check for empty payloads and errors
        json validatedResponse = check getValidatedRestResponse(response);

        return check validatedResponse.cloneWithType(User);

    }

    # Find a Issue
    # + username - GitHub username of the member
    # + repositoryName - Name of the repository
    # + issueNumber - Number of the issue which needs to retrieved
    # + return - Issue object or Connector error
    @display {label: "Find an issue"}
    remote isolated function getIssue(@display {label: "Github username"} string username, @display {label: "Repository name"} string repositoryName, @display {label: "Number of the issue"} int issueNumber)
                           returns @display {label: "Issue"} IssueFound|error {

        if (username == EMPTY_STRING || repositoryName == EMPTY_STRING) {
            error connectorError = error(GITHUB_ERROR_CODE,
            message = "Username and repository name should be specified");
            return connectorError;
        }

        string endpointResource = string `${PATH_SEPARATOR}${GIT_REPOS}${PATH_SEPARATOR}${username}${PATH_SEPARATOR}${repositoryName}${PATH_SEPARATOR}${GIT_ISSUES}${PATH_SEPARATOR}${issueNumber}`;
        // Make an HTTP GET request
        var response = self.githubRestClient->get(endpointResource, self.headers);
        // Check for empty payloads and errors
        json validatedResponse = check getValidatedRestResponse(response);

        return jsonToIssueFound(<map<json>>validatedResponse);

    }

    # Update an issue in a repository.
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + issueNumber - Issue number
    # + issueTitle - Title of the issue
    # + issueContent - Details of the issue
    # + labelList - List of labels for the issue
    # + assigneeList - Users to be assigned to the issue
    # + state - State of the issue. Either open or closed.
    # + return - Created issue object or Connector error
    @display {label: "Update an issue in a repository"}
    remote isolated function updateIssue(@display {label: "Repository owner username"} string repositoryOwner, @display {label: "Repository name"} string repositoryName, @display {label: "Issue number"} int issueNumber, @display {label: "Issue title"} string issueTitle,
                                   @display {label: "Details of the issue"} string issueContent, @display {label: "List of label names for the issue"} string[] labelList, @display {label: "Users to be assigned to the issue"} string[] assigneeList, @display {label: "State of the issue"} string state)
                           returns @display {label: "Issue"} Issue|error {

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
            "assignees": jsonAssigneeList, "state": state };

        http:Request request = new;
        setHeader(request, self.accessToken);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> issueJsonPayload);

        string endpointResource = string `${PATH_SEPARATOR}${GIT_REPOS}${PATH_SEPARATOR}${repositoryOwner}${PATH_SEPARATOR}${repositoryName}${PATH_SEPARATOR}${GIT_ISSUES}${PATH_SEPARATOR}${issueNumber}`;
        // Make an HTTP POST request
        var response = self.githubRestClient->patch(endpointResource, request);

        //Check for empty payloads and errors
        json validatedResponse = check getValidatedRestResponse(response);
        return restResponseJsonToIssue(validatedResponse);
    }

    # Updates a Pull request .
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + pullNumber - Pull request number
    # + pullRequest - Pull request update record
    # + return - Updated pull request object or Connector error
    @display {label: "Update a pull request"}
    remote isolated function updatePullRequest(@display {label: "Repository owner username"} string repositoryOwner, @display {label: "Repository name"} string repositoryName, @display {label: "Pull request number"} int pullNumber, @display {label: "Pull request update"} PullRequestUpdate pullRequest)
                           returns @display {label: "Pull request"} PullRequest|error {

        if (repositoryName == EMPTY_STRING || repositoryOwner == EMPTY_STRING) {
            error connectorError = error(GITHUB_ERROR_CODE,
            message = "Repository name, owner should be specified");
            return connectorError;
        }

        json updatePullRequestPayload = check pullRequest.cloneWithType(json);

        http:Request request = new;
        setHeader(request, self.accessToken);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> updatePullRequestPayload);

        string endpointResource = string `${PATH_SEPARATOR}${GIT_REPOS}${PATH_SEPARATOR}${repositoryOwner}${PATH_SEPARATOR}${repositoryName}${PATH_SEPARATOR}${GIT_PULLS}${PATH_SEPARATOR}${pullNumber}`;
        // Make an HTTP POST request
        var response = self.githubRestClient->patch(endpointResource, request);
        //Check for empty payloads and errors
        json validatedResponse = check getValidatedRestResponse(response);
        return jsonToPullRequest(<map<json>>validatedResponse);

    }

}

# Represents the Github Client Connector Endpoint configuration.
# + clientConfig - HTTP client endpoint configuration
# + accessToken - The access token of the Github account
public type GitHubConfiguration record {
    http:ClientConfiguration clientConfig = {};
    string accessToken;
};
