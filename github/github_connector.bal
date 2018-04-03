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

package github;

import ballerina/net.http;

//endpoint http:ClientEndpoint gitHubEndpoint;
//endpoint http:ClientEndpoint gitHubEndpoint {
//    targets:[{uri:GIT_GRAPHQL_API_URL}]
//};

@Description {value:"GitHub client connector"}
public struct GitHubConnector {
    string accessToken;
    http:ClientEndpoint githubClientEndpoint;
}

@Description {value:"Get a repository of an owner"}
@Param {value:"name: Name of the form owner/repository"}
@Return {value:"Repository: Repository object"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getRepository (string name) returns Repository|GitConnectorError {

    endpoint http:ClientEndpoint gitHubEndpoint = gitHubConnector.githubClientEndpoint;

    GitConnectorError connectorError = {};

    if (name == null || name == "") {
        connectorError = {message:["Repository owner and name should be specified."]};
        return connectorError;
    }
    string[] repoIdentifier = name.split(GIT_PATH_SEPARATOR);
    string repoOwner = repoIdentifier[GIT_INDEX_ZERO];
    string repoName = repoIdentifier[GIT_INDEX_ONE];
    Repository singleRepository = {};

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repoOwner}}","{{GIT_NAME}}":"{{repoName}}"},
    "{{GIT_QUERY}}":"{{GET_REPOSITORY}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            // Set headers and payload to the request
            constructRequest(request, jsonQuery, gitHubConnector.accessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }

    // Make an HTTP POST request 
    var response = gitHubEndpoint -> post("", request);

    json|GitConnectorError validatedResponse  = getValidatedResponse(response, GIT_NAME);
    
    match validatedResponse {
        json jsonValidatedResponse => {
            try {
                var githubRepositoryJson = <json>jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY];
                singleRepository =? <Repository>githubRepositoryJson;
            } catch (error e) {
                connectorError = {message:[e.message]};
                return connectorError;
            }
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }
    
    return singleRepository;
}

@Description {value:"Get an organization"}
@Param {value:"name: Name of the organization"}
@Return {value:"Organization: Organization object"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getOrganization (string name) returns Organization|GitConnectorError {

    endpoint http:ClientEndpoint gitHubEndpoint = gitHubConnector.githubClientEndpoint;

    GitConnectorError connectorError = {};

    if (null == name || "" == name) {
        connectorError = {message:["Organization name should be specified."]};
        return connectorError;
    }
    Organization singleOrganization = {};

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{name}}"},
        "{{GIT_QUERY}}":"{{GET_ORGANIZATION}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            // Set headers and payload to the request
            constructRequest(request, jsonQuery, gitHubConnector.accessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint -> post("", request);

    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_NAME);
    
    match validatedResponse {
        json jsonValidatedResponse => {
            try {
                var githubRepositoryJson = <json>jsonValidatedResponse[GIT_DATA][GIT_ORGANIZATION];
                singleOrganization =? <Organization>githubRepositoryJson;
            } catch (error e) {
                connectorError = {message:[e.message]};
                return connectorError;
            }
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }

    return singleOrganization;
}

@Description {value:"Get all columns of a project board"}
@Param {value: "recordCount: Specify number of records in the list"}
@Return {value:"ColumnList: Column list object"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getProjectColumnList (Project project, int recordCount)
                                                                                returns ColumnList|GitConnectorError {

    GitConnectorError connectorError = {};

    if (project == null) {
        connectorError = {message:["Project cannot be null"]};
        return connectorError;
    }

    if (recordCount > GIT_MAX_RECORD_COUNT) {
        connectorError = {message:["Maximum record count limited to " + GIT_MAX_RECORD_COUNT]};
        return connectorError;
    }
    string projectOwnerType = project.owner.getOwnerType();
    if (projectOwnerType.equalsIgnoreCase(GIT_ORGANIZATION) && project.resourcePath != null) {
        string organization = project.resourcePath.split(GIT_PATH_SEPARATOR)[GIT_INDEX_TWO];
        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization}}",
            "{{GIT_NUMBER}}":{{project.number}},"{{GIT_RECORD_COUNT}}":{{recordCount}}},
            "{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECT_COLUMNS}}"}`;
        return getProjectColumns(GIT_ORGANIZATION, stringQuery, gitHubConnector);

    } else if (projectOwnerType.equalsIgnoreCase(GIT_REPOSITORY) && project.resourcePath != null) {
        string ownerName = project.resourcePath.split(GIT_PATH_SEPARATOR)[GIT_INDEX_ONE];
        string repositoryName = project.resourcePath.split(GIT_PATH_SEPARATOR)[GIT_INDEX_TWO];

        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{ownerName}}"
        ,"{{GIT_NAME}}":"{{repositoryName}}","{{GIT_NUMBER}}":{{project.number}},"{{GIT_RECORD_COUNT}}":{{recordCount}}}
        ,"{{GIT_QUERY}}":"{{GET_REPOSITORY_PROJECT_COLUMNS}}"}`;
        return getProjectColumns(GIT_REPOSITORY, stringQuery, gitHubConnector);
    }
    connectorError.message = ["No records found"];
    return connectorError;
}

@Description {value:"Get a single project of an organization."}
@Param {value:"projectNumber: The number of the project"}
@Return {value:"Project object"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getOrganizationProject (Organization organization, int projectNumber)
                                                                                    returns Project|GitConnectorError {
    endpoint http:ClientEndpoint gitHubEndpoint = gitHubConnector.githubClientEndpoint;

    GitConnectorError connectorError = {};

    if (organization == null || projectNumber <= 0) {
        connectorError = {message:["Organization cannot be null and project number should be positive integer."]};
        return connectorError;
    }


    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization.login}}",
    "{{GIT_NUMBER}}":{{projectNumber}}},"{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECT}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
        //Set headers and payload to the request
            constructRequest(request, jsonQuery, gitHubConnector.accessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint -> post("", request);

    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_PROJECT);

    match validatedResponse {
        json jsonValidatedResponse => {
            var githubProjectJson = jsonValidatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_PROJECT];
            var singleProject =? <Project>githubProjectJson;

            return singleProject;
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }
}

@Description {value:"Gets the next page of a project list"}
@Return {value:"ProjectList: Project list"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getProjectListNextPage (ProjectList projectList)
                                                                                returns ProjectList|GitConnectorError {
    endpoint http:ClientEndpoint gitHubEndpoint = gitHubConnector.githubClientEndpoint;

    if (projectList.hasNextPage()) {

        http:Request request = {};
        json dataQuery;
        var convertedQuery = stringToJson(projectList.projectListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorProjects = projectList.pageInfo.endCursor;
                if (projectList.listOwner.equalsIgnoreCase(GIT_ORGANIZATION)) {
                    jsonQuery["query"] = GET_ORGANIZATION_PROJECTS_NEXT_PAGE;
                } else if (projectList.listOwner.equalsIgnoreCase(GIT_REPOSITORY)) {
                    jsonQuery["query"] = GET_REPOSITORY_PROJECTS_NEXT_PAGE;
                }
                dataQuery = jsonQuery;
                //Set headers and payload to the request
                constructRequest(request, jsonQuery, gitHubConnector.accessToken);
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }

        // Make an HTTP POST request
        var response = gitHubEndpoint -> post("", request);

        //Check for empty payloads and errors
        json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_PROJECTS);

        match validatedResponse {
            json jsonValidatedResponse => {
                var projectsJson = jsonValidatedResponse[GIT_DATA][projectList.listOwner][GIT_PROJECTS];
                var projList =  jsonToProjectList(projectsJson, projectList.listOwner, dataQuery.toString());

                return projList;
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }
    }

    GitConnectorError connectorError = {message:["Project list has no next page"]};

    return connectorError;
}

@Description {value:"Get the next page of a repository list"}
@Return {value:"RepositoryList: Repository list"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getRepositoryListNextPage (RepositoryList repositoryList)
                                                                            returns RepositoryList|GitConnectorError {
    endpoint http:ClientEndpoint gitHubEndpoint = gitHubConnector.githubClientEndpoint;

    if (repositoryList.hasNextPage()) {

        http:Request request = {};
        var convertedQuery = stringToJson(repositoryList.repositoryListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorRepos = repositoryList.pageInfo.endCursor;
                jsonQuery["query"] = GET_ORGANIZATION_REPOSITORIES_NEXT_PAGE;
                //Set headers and payload to the request
                constructRequest(request, jsonQuery, gitHubConnector.accessToken);
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }

        // Make an HTTP POST request
        var response = gitHubEndpoint -> post("", request);

        //Check for empty payloads and errors
        json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_REPOSITORIES);

        match validatedResponse {
            json jsonValidatedResponse => {
                var repositoriesJson = jsonValidatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_REPOSITORIES];
                var repoList =  jsonToRepositoryList(repositoriesJson, repositoryList.repositoryListQuery);

                return repoList;
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }
    }
    GitConnectorError connectorError = {message:["Repository list has no next page"]};

    return connectorError;
}

@Description {value:"Get all pull requests of a repository"}
@Param {value:"state: State of the repository (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_MERGED, GIT_STATE_ALL)"}
@Param {value: "recordCount: Specify number of records in the list"}
@Return {value:"PullRequestList: Pull request list"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getPullRequestList
                    (Repository repository, string state, int recordCount) returns PullRequestList|GitConnectorError {

    endpoint http:ClientEndpoint gitHubEndpoint = gitHubConnector.githubClientEndpoint;

    GitConnectorError connectorError = {};

    if (repository == null || state == "" || state == null) {
        connectorError = {message:["Repository and state cannot be null."]};
        return connectorError;
    }

    if (recordCount > GIT_MAX_RECORD_COUNT) {
        connectorError = {message:["Maximum record count limited to " + GIT_MAX_RECORD_COUNT]};
        return connectorError;
    }

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}"
    ,"{{GIT_NAME}}":"{{repository.name}}","{{GIT_STATES}}":{{state}},"{{GIT_RECORD_COUNT}}":{{recordCount}}},
    "{{GIT_QUERY}}":"{{GET_PULL_REQUESTS}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
        //Set headers and payload to the request
            constructRequest(request, jsonQuery, gitHubConnector.accessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint -> post("", request);

    //Check for empty payloads and errors
    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_PULL_REQUESTS);

    match validatedResponse {
        json jsonValidatedResponse => {
            var githubPullRequestsJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PULL_REQUESTS];
            var pullRequestList = jsonToPullRequestList(githubPullRequestsJson, stringQuery);

            return pullRequestList;
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }
}

@Description {value:"Get all projects of a repository"}
@Param {value:"state: State of the repository (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_ALL)"}
@Param {value: "recordCount: Specify number of records in the list"}
@Return {value:"ProjectList: Project list"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getRepositoryProjectList
                        (Repository repository, string state, int recordCount) returns ProjectList|GitConnectorError {

    endpoint http:ClientEndpoint gitHubEndpoint = gitHubConnector.githubClientEndpoint;

    GitConnectorError connectorError = {};

    if (repository == null || state == null) {
        connectorError = {message:["Repository and state cannot be null"]};
        return connectorError;
    }

    if (recordCount > GIT_MAX_RECORD_COUNT) {
        connectorError = {message:["Maximum record count limited to " + GIT_MAX_RECORD_COUNT]};
        return connectorError;
    }

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}",
        "{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_STATES}}":{{state}},"{{GIT_RECORD_COUNT}}":{{recordCount}}}
        ,"{{GIT_QUERY}}":"{{GET_REPOSITORY_PROJECTS}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
        //Set headers and payload to the request
            constructRequest(request, jsonQuery, gitHubConnector.accessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint -> post("", request);

    //Check for empty payloads and errors
    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_PROJECTS);

    match validatedResponse {
        json jsonValidatedResponse => {
            var githubProjectsJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECTS];
            var projectList = jsonToProjectList(githubProjectsJson, GIT_REPOSITORY, stringQuery);

            return projectList;
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }
}

@Description {value:"Get a single project of a repository."}
@Param {value:"projectNumber: The number of the project"}
@Return {value:"Project object"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getRepositoryProject (Repository repository, int projectNumber)
                                                                                    returns Project|GitConnectorError {

    endpoint http:ClientEndpoint gitHubEndpoint = gitHubConnector.githubClientEndpoint;

    GitConnectorError connectorError = {};

    if (repository == null || projectNumber <= 0) {
        connectorError = {message:["Repository cannot be null and project number should be positive integer."]};
        return connectorError;
    }

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}"
    ,"{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_NUMBER}}":{{projectNumber}}}
    ,"{{GIT_QUERY}}":"{{GET_REPOSITORY_PROJECT}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
        //Set headers and payload to the request
            constructRequest(request, jsonQuery, gitHubConnector.accessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint -> post("", request);

    //Check for empty payloads and errors
    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_PROJECT);

    match validatedResponse {
        json jsonValidatedResponse => {
            var githubProjectJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECT];
            var singleProject =? <Project>githubProjectJson;

            return singleProject;
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }
}

@Description {value:"Get a list of issues of a repository."}
@Param {value:"state: State of the issue (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_ALL)"}
@Param {value: "recordCount: Specify number of records in the list"}
@Return {value:"IssueList: Issue list"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getIssueList (Repository repository, string state, int recordCount)
                                                                                returns IssueList|GitConnectorError {

    endpoint http:ClientEndpoint gitHubEndpoint = gitHubConnector.githubClientEndpoint;

    GitConnectorError connectorError = {};

    if (repository == null) {
        connectorError = {message:["Repository cannot be null"]};
        return connectorError;
    }

    if (recordCount > GIT_MAX_RECORD_COUNT) {
        connectorError = {message:["Maximum record count limited to " + GIT_MAX_RECORD_COUNT]};
        return connectorError;
    }
    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}"
    ,"{{GIT_NAME}}":"{{repository.name}}","{{GIT_STATES}}":{{state}},"{{GIT_RECORD_COUNT}}":{{recordCount}}},
    "{{GIT_QUERY}}":"{{GET_REPOSITORY_ISSUES}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
        //Set headers and payload to the request
            constructRequest(request, jsonQuery, gitHubConnector.accessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint -> post("", request);

    //Check for empty payloads and errors
    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_ISSUES);

    match validatedResponse {
        json jsonValidatedResponse => {
            var githubIssuesJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_ISSUES];
            var issueList = jsonToIssueList(githubIssuesJson, stringQuery);

            return issueList;
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }
}

@Description {value:"Get all projects of an organization"}
@Param {value:"state: State of the project (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_ALL)"}
@Param {value: "recordCount: Specify number of records in the list"}
@Return {value:"ProjectList: Project list"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getOrganizationProjectList
                    (Organization organization, string state, int recordCount) returns ProjectList|GitConnectorError {

    endpoint http:ClientEndpoint gitHubEndpoint = gitHubConnector.githubClientEndpoint;

    GitConnectorError connectorError = {};

    if (organization == null || state == null) {
        connectorError = {message:["Organization and state cannot be null."]};
        return connectorError;
    }

    if (recordCount > GIT_MAX_RECORD_COUNT) {
        connectorError = {message:["Maximum record count limited to " + GIT_MAX_RECORD_COUNT]};
        return connectorError;
    }

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization.login}}"
    ,"{{GIT_STATES}}":{{state}},"{{GIT_RECORD_COUNT}}":{{recordCount}}},
    "{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECTS}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
        //Set headers and payload to the request
            constructRequest(request, jsonQuery, gitHubConnector.accessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint -> post("", request);

    //Check for empty payloads and errors
    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_PROJECTS);

    match validatedResponse {
        json jsonValidatedResponse => {
            var githubProjectsJson = jsonValidatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_PROJECTS];
            var projectList = jsonToProjectList(githubProjectsJson, GIT_ORGANIZATION, stringQuery);

            return projectList;
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }
}

@Description {value:"Get a list of repositories of an organization."}
@Param {value: "recordCount: Specify number of records in the list"}
@Return {value:"RepositoryList: Repository list object"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getOrganizationRepositoryList
                                (Organization organization, int recordCount) returns RepositoryList|GitConnectorError {

    endpoint http:ClientEndpoint gitHubEndpoint = gitHubConnector.githubClientEndpoint;

    GitConnectorError connectorError = {};

    if (organization == null) {
        connectorError = {message:["Organization cannot be null."]};
        return connectorError;
    }

    if (recordCount > GIT_MAX_RECORD_COUNT) {
        connectorError = {message:["Maximum record count limited to " + GIT_MAX_RECORD_COUNT]};
        return connectorError;
    }

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization.login}}",
    "{{GIT_RECORD_COUNT}}":{{recordCount}}},"{{GIT_QUERY}}":"{{GET_ORGANIZATION_REPOSITORIES}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
        //Set headers and payload to the request
            constructRequest(request, jsonQuery, gitHubConnector.accessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint -> post("", request);

    //Check for empty payloads and errors
    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_REPOSITORIES);

    match validatedResponse {
        json jsonValidatedResponse => {
            var githubRepositoriesJson = jsonValidatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_REPOSITORIES];
            var repositoryList = jsonToRepositoryList(githubRepositoriesJson, stringQuery);

            return repositoryList;
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }
}

@Description {value:"Get the next page of the card list"}
@Return {value:"CardList: Card list object"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getCardListNextPage (CardList cardList)
                                                                                returns CardList|GitConnectorError {

    if (cardList.hasNextPage()) {
        var cardListColumnId = cardList.columnId;
        var convertedQuery = stringToJson(cardList.cardListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorCards = cardList.pageInfo.endCursor;

                if (cardList.listOwner.equalsIgnoreCase(GIT_ORGANIZATION)) {
                    jsonQuery["query"] = GET_ORGANIZATION_PROJECT_CARDS_NEXT_PAGE;
                    ColumnList|GitConnectorError columnList =
                                getProjectColumns(GIT_ORGANIZATION, jsonQuery.toString(), gitHubConnector);
                    match columnList {
                        ColumnList colList => {
                            foreach column in colList.getAllColumns() {
                                if (column.id == cardListColumnId) {
                                    return column.getCardList();
                                }
                            }
                        }

                        GitConnectorError gitConError => {
                            return gitConError;
                        }
                    }

                } else if (cardList.listOwner.equalsIgnoreCase(GIT_REPOSITORY)) {
                    jsonQuery["query"] = GET_REPOSITORY_PROJECT_CARDS_NEXT_PAGE;
                    ColumnList|GitConnectorError columnList =
                                getProjectColumns(GIT_REPOSITORY, jsonQuery.toString(), gitHubConnector);
                    match columnList {
                        ColumnList colList => {
                            foreach column in colList.getAllColumns() {
                                if (column.id == cardListColumnId) {
                                    return column.getCardList();
                                }
                            }
                        }

                        GitConnectorError gitConError => {
                            return gitConError;
                        }
                    }
                }
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }

    }
    GitConnectorError connectorError = {message:["Card list has no next page"]};

    return connectorError;
}

@Description {value:"Get the next page of column list"}
@Return {value:"ColumList: Column list object"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getColumnListNextPage (ColumnList columnList)
                                                                                returns ColumnList|GitConnectorError {

    if (columnList.hasNextPage()) {
        var convertedQuery = stringToJson(columnList.columnListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorColumns = columnList.pageInfo.endCursor;
                if (columnList.listOwner.equalsIgnoreCase(GIT_ORGANIZATION)) {
                    jsonQuery["query"] = GET_ORGANIZATION_PROJECT_COLUMNS_NEXT_PAGE;

                    return getProjectColumns(GIT_ORGANIZATION, jsonQuery.toString(), gitHubConnector);
                } else if (columnList.listOwner.equalsIgnoreCase(GIT_REPOSITORY)) {
                    jsonQuery["query"] = GET_REPOSITORY_PROJECT_COLUMNS_NEXT_PAGE;

                    return getProjectColumns(GIT_REPOSITORY, jsonQuery.toString(), gitHubConnector);
                }
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }

    }
    GitConnectorError connectorError = {message:["Column list has no next page"]};

    return connectorError;
}

@Description {value:"Get the next page of the issue list"}
@Return {value:"IssueList: Issue list"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getIssueListNextPage (IssueList issueList)
                                                                                returns IssueList|GitConnectorError {

    endpoint http:ClientEndpoint gitHubEndpoint = gitHubConnector.githubClientEndpoint;

    if (issueList.hasNextPage()) {
        http:Request request = {};
        var convertedQuery = stringToJson(issueList.issueListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorIssues = issueList.pageInfo.endCursor;
                jsonQuery["query"] = GET_REPOSITORY_ISSUES_NEXT_PAGE;
                //Set headers and payload to the request
                constructRequest(request, jsonQuery, gitHubConnector.accessToken);
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }

        // Make an HTTP POST request
        var response = gitHubEndpoint -> post("", request);

        //Check for empty payloads and errors
        json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_ISSUES);
        match validatedResponse {
            json jsonValidatedResponse => {
                var repositoryIssuesJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_ISSUES];
                var issuesList = jsonToIssueList(repositoryIssuesJson, issueList.issueListQuery);

                return issuesList;
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }

    }
    GitConnectorError connectorError = {message:["Issue list has no next page"]};

    return connectorError;

}

@Description {value:"Get the next page of the pull request list"}
@Return {value:"PullRequestList: PullRequest list object"}
@Return {value:"GitConnectorError: Error"}
public function <GitHubConnector gitHubConnector> getPullRequestListNextPage (PullRequestList pullRequestList)
                                                                            returns PullRequestList|GitConnectorError {

    endpoint http:ClientEndpoint gitHubEndpoint = gitHubConnector.githubClientEndpoint;

    if (pullRequestList.hasNextPage()) {

        http:Request request = {};
        var convertedQuery = stringToJson(pullRequestList.pullRequestListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorPullRequests = pullRequestList.pageInfo.endCursor;
                jsonQuery["query"] = GET_PULL_REQUESTS_NEXT_PAGE;
                //Set headers and payload to the request
                constructRequest(request, jsonQuery, gitHubConnector.accessToken);
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }

        // Make an HTTP POST request
        var response = gitHubEndpoint -> post("", request);

        //Check for empty payloads and errors
        json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_PULL_REQUESTS);

        match validatedResponse {
            json jsonValidatedResponse => {
                var projectColumnsJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PULL_REQUESTS];
                var prList = jsonToPullRequestList(projectColumnsJson, pullRequestList.pullRequestListQuery);

                return prList;
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }

    }
    GitConnectorError connectorError = {message:["Pull request list has no next page"]};

    return connectorError;

}