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

package src.github;

import ballerina.io;
import ballerina.net.http;

http:HttpClient gitHTTPClient = create http:HttpClient(GIT_API_URL, {});
map metaData = {};


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Project struct                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a github project"}
public struct Project {
    string id;
    int databaseId;
    string name;
    string body;
    int number;
    string createdAt;
    string closed;
    string closedAt;
    string updatedAt;
    string resourcePath;
    string state;
    string url;
    boolean viewerCanUpdate;
    Creator creator;
    ProjectOwner owner;
}
//*********************************************************************************************************************
// Project bound functions
//*********************************************************************************************************************
@Description {value:"Get all columns of a project"}
@Return {value:"ColumnList: Column list object"}
@Return {value:"GitConnectorError: Error"}
public function <Project project> getColumnList () (ColumnList, GitConnectorError) {
    endpoint<http:HttpClient> gitClient {
        gitHTTPClient;
    }

    GitConnectorError connectorError;

    if (project == null) {
        connectorError = {message:["Project cannot be null"]};
        return null, connectorError;
    }
    metaData["projectOwnerType"] = project.owner.getOwnerType();
    string projectOwnerType = project.owner.getOwnerType();
    if (projectOwnerType.equalsIgnoreCase(GIT_ORGANIZATION) && project.resourcePath != null) {
        string organization = project.resourcePath.split(GIT_PATH_SEPARATOR)[GIT_INDEX_TWO];
        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization}}",
            "{{GIT_NUMBER}}":{{project.number}}},"{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECT_COLUMNS}}"}`;
        metaData["projectColumnQuery"] = stringQuery;
        return getProjectColumns(GIT_ORGANIZATION, stringQuery);

    } else if (projectOwnerType.equalsIgnoreCase(GIT_REPOSITORY)) {
        string ownerName = project.resourcePath.split(GIT_PATH_SEPARATOR)[GIT_INDEX_ONE];
        string repositoryName = project.resourcePath.split(GIT_PATH_SEPARATOR)[GIT_INDEX_TWO];

        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{ownerName}}"
        ,"{{GIT_NAME}}":"{{repositoryName}}","{{GIT_NUMBER}}":{{project.number}}}
        ,"{{GIT_QUERY}}":"{{GET_REPOSITORY_PROJECT_COLUMNS}}"}`;
        metaData["projectColumnQuery"] = stringQuery;
        return getProjectColumns(GIT_REPOSITORY, stringQuery);
    }
    return null, connectorError;
}

@Description {value:"Get all columns of a project"}
@Param {value:"ownerType: Repository or Organization"}
@Param {value:"gitQuery: Graphql query"}
@Return {value:"ColumnList: Column list object"}
@Return {value:"GitConnectorError: Error"}
function getProjectColumns (string ownerType, string gitQuery) (ColumnList, GitConnectorError) {
    endpoint<http:HttpClient> gitClient {
        gitHTTPClient;
    }
    GitConnectorError connectorError;

    if (ownerType == null || ownerType == "" || gitQuery == null || gitQuery == "") {
        connectorError = {message:["Owner type and query cannot be null"]};
        return null, connectorError;
    }

    http:HttpConnectorError httpError;

    http:OutRequest request = {};
    http:InResponse response = {};

    var query, _ = <json>gitQuery;

    //Set headers and payload to the request
    constructRequest(request, query, gitAccessToken);
    int i = 0;
    //Iterate through multiple pages of results
    response, httpError = gitClient.post("", request);
    if (httpError != null) {
        connectorError = {message:[httpError.message], statusCode:httpError.statusCode};
        return null, connectorError;
    }
    json validatedResponse;
    //Check for empty payloads and errors
    validatedResponse, connectorError = getValidatedResponse(response, GIT_PROJECT);
    if (connectorError != null) {
        return null, connectorError;
    }
    var projectColumnsJson, _ = (json)validatedResponse[GIT_DATA][ownerType][GIT_PROJECT][GIT_COLUMNS];
    var columnList, _ = <ColumnList>projectColumnsJson;

    return columnList, connectorError;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of Project struct                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              RepositoryList struct                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a list of repositories"}
public struct RepositoryList {
    private:
        PageInfo pageInfo;
        Repository[] nodes;
}
//*********************************************************************************************************************
// RepositoryList bound functions
//*********************************************************************************************************************
@Description {value:"Check if repository list next page is available"}
@Return {value:"boolean: Return true or false"}
public function <RepositoryList repositoryList> hasNextPage () (boolean) {
    return repositoryList.pageInfo.hasNextPage;
}

@Description {value:"Check if repository list previous page is available"}
@Return {value:"boolean: Return true or false"}
public function <RepositoryList repositoryList> hasPreviousPage () (boolean) {
    return repositoryList.pageInfo.hasPreviousPage;
}

@Description {value:"Get the next page of a repository list"}
@Return {value:"RepositoryList: Repository list"}
@Return {value:"GitConnectorError: Error"}
public function <RepositoryList repositoryList> nextPage () (RepositoryList, GitConnectorError) {
    endpoint<http:HttpClient> gitClient {
        gitHTTPClient;
    }

    GitConnectorError connectorError;
    if (repositoryList.hasNextPage()) {
        var stringQuery, _ = (string)metaData["repositoryListQuery"];
        http:HttpConnectorError httpError;

        http:OutRequest request = {};
        http:InResponse response = {};

        var query, _ = <json>stringQuery;
        query.variables.endCursorRepos = repositoryList.pageInfo.endCursor;
        query.query = GET_ORGANIZATION_REPOSITORIES_NEXT_PAGE;
        //Set headers and payload to the request
        constructRequest(request, query, gitAccessToken);
        //Iterate through multiple pages of results
        response, httpError = gitClient.post("", request);
        if (httpError != null) {
            connectorError = {message:[httpError.message], statusCode:httpError.statusCode};
            return null, connectorError;
        }
        json validatedResponse;
        //Check for empty payloads and errors
        validatedResponse, connectorError = getValidatedResponse(response, GIT_REPOSITORIES);
        if (connectorError != null) {
            return null, connectorError;
        }
        var projectColumnsJson, _ = (json)validatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_REPOSITORIES];
        var repoList, _ = <RepositoryList>projectColumnsJson;

        return repoList, connectorError;
    }
    connectorError = {message:["Repository list has no next page"]};

    return null, connectorError;
}

@Description {value:"Get an array of repositories"}
@Return {value:"RepositoryList[]: Array of repositories"}
public function <RepositoryList repositoryList> getAllRepositories () (Repository[]) {
    return repositoryList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                         End of RepositoryList struct                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Repository struct                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a github repository"}
public struct Repository {
    string id;
    string name;
    string createdAt;
    string updatedAt;
    string description;
    int forkCount;
    boolean hasIssuesEnabled;
    boolean hasWikiEnabled;
    string homepageUrl;
    boolean isArchived;
    boolean isFork;
    boolean isLocked;
    boolean isMirror;
    boolean isPrivate;
    string license;
    string lockReason;
    string mirrorUrl;
    string url;
    string sshUrl;
    RepositoryOwner owner;
    Language primaryLanguage;
}
//*********************************************************************************************************************
// Repository bound functions
//*********************************************************************************************************************
@Description {value:"Get all pull requests of a repository"}
@Param {value:"state: State of the repository (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_MERGED, GIT_STATE_ALL)"}
@Return {value:"PullRequest[]: Array of pull requests"}
@Return {value:"GitConnectorError: Error"}
public function <Repository repository> getPullRequests (string state) (PullRequest[], GitConnectorError) {
    endpoint<http:HttpClient> gitClient {
        gitHTTPClient;
    }
    GitConnectorError connectorError;

    if (repository == null || state == "" || state == null) {
        connectorError = {message:["Repository and state cannot be null."]};
        return [], connectorError;
    }

    boolean hasNextPage = true;
    http:HttpConnectorError httpError;
    PullRequest[] pullRequestArray = [];

    http:OutRequest request = {};
    http:InResponse response = {};

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}"
    ,"{{GIT_NAME}}":"{{repository.name}}","{{GIT_STATES}}":{{state}}},"{{GIT_QUERY}}":"{{GET_PULL_REQUESTS}}"}`;

    var query, _ = <json>stringQuery;

    //Set headers and payload to the request
    constructRequest(request, query, gitAccessToken);
    int i = 0;
    //Iterate through multiple pages of results
    while (hasNextPage) {
        response, httpError = gitClient.post("", request);
        if (httpError != null) {
            connectorError = {message:[httpError.message], statusCode:httpError.statusCode};
            return [], connectorError;
        }
        json validatedResponse;
        //Check for empty payloads and errors
        validatedResponse, connectorError = getValidatedResponse(response, GIT_PULL_REQUESTS);
        if (connectorError != null) {
            return [], connectorError;
        }
        var githubProjectsJson, _ = (json[])validatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PULL_REQUESTS][GIT_NODES];
        foreach projectJson in githubProjectsJson {
            pullRequestArray[i], _ = <PullRequest>projectJson;
            i = i + 1;
        }

        hasNextPage, _ = (boolean)validatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PULL_REQUESTS][GIT_PAGE_INFO]
                                  [GIT_HAS_NEXT_PAGE];
        if (hasNextPage) {
            var endCursor, _ = (string)validatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PULL_REQUESTS][GIT_PAGE_INFO]
                                       [GIT_END_CURSOR];

            string stringQueryNextPage = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}"
            ,"{{GIT_NAME}}":"{{repository.name}}","{{GIT_STATES}}":{{state}},"{{GIT_END_CURSOR}}":"{{endCursor}}"},"{{GIT_QUERY}}":"{{GET_PULL_REQUESTS_NEXT_PAGE}}"}`;
            var queryNextPage, _ = <json>stringQueryNextPage;
            request = {};
            constructRequest(request, queryNextPage, gitAccessToken);
        }

    }
    return pullRequestArray, connectorError;

} //TODO getPullRequestList

@Description {value:"Get all projects of a repository"}
@Param {value:"state: State of the repository (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_ALL)"}
@Return {value:"Project[]: Array of projects"}
@Return {value:"GitConnectorError: Error"}
public function <Repository repository> getProjects (string state) (Project[], GitConnectorError) {
    endpoint<http:HttpClient> gitClient {
        gitHTTPClient;
    }

    GitConnectorError connectorError;

    if (repository == null || state == null) {
        connectorError = {message:["Repository and state cannot be null"]};
        return [], connectorError;
    }

    boolean hasNextPage = true;
    http:HttpConnectorError httpError;
    Project[] projectArray = [];

    http:OutRequest request = {};
    http:InResponse response = {};

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}",
        "{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_STATES}}":{{state}}}
        ,"{{GIT_QUERY}}":"{{GET_REPOSITORY_PROJECTS}}"}`;

    var query, _ = <json>stringQuery;

    //Set headers and payload to the request
    constructRequest(request, query, gitAccessToken);
    int i = 0;
    //Iterate through multiple pages of results
    while (hasNextPage) {
        response, httpError = gitClient.post("", request);
        if (httpError != null) {
            connectorError = {message:[httpError.message], statusCode:httpError.statusCode};
            return [], connectorError;
        }
        json validatedResponse;
        //Check for empty payloads and errors
        validatedResponse, connectorError = getValidatedResponse(response, GIT_PROJECTS);
        if (connectorError != null) {
            return [], connectorError;
        }
        var githubProjectsJson, _ = (json[])validatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECTS][GIT_NODES];
        foreach projectJson in githubProjectsJson {
            projectArray[i], _ = <Project>projectJson;
            i = i + 1;
        }

        hasNextPage, _ = (boolean)validatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECTS][GIT_PAGE_INFO]
                                  [GIT_HAS_NEXT_PAGE];
        if (hasNextPage) {
            var endCursor, _ = (string)validatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECTS][GIT_PAGE_INFO]
                                       [GIT_END_CURSOR];

            string stringQueryNextPage = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}"
            ,"{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_STATES}}":{{state}}
            ,"{{GIT_END_CURSOR}}":"{{endCursor}}"},"{{GIT_QUERY}}":"{{GET_REPOSITORY_PROJECTS_NEXT_PAGE}}"}`;
            var queryNextPage, _ = <json>stringQueryNextPage;
            request = {};
            constructRequest(request, queryNextPage, gitAccessToken);
        }

    }
    return projectArray, connectorError;
} //TODO getProjectList

@Description {value:"Get a single project of a repository."}
@Param {value:"projectNumber: The number of the project"}
@Return {value:"Project object"}
@Return {value:"GitConnectorError: Error"}
public function <Repository repository> getProject (int projectNumber) (Project, GitConnectorError) {
    endpoint<http:HttpClient> gitClient {
        gitHTTPClient;
    }

    GitConnectorError connectorError;

    if (repository == null || projectNumber <= 0) {
        connectorError = {message:["Repository cannot be null and project number should be positive integer."]};
        return null, connectorError;
    }

    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError httpError;
    Project singleProject;

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}"
    ,"{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_NUMBER}}":{{projectNumber}}}
    ,"{{GIT_QUERY}}":"{{GET_REPOSITORY_PROJECT}}"}`;

    var query, _ = <json>stringQuery;

    //Set headers and payload to the request
    constructRequest(request, query, gitAccessToken);

    response, httpError = gitClient.post("", request);
    if (httpError != null) {
        connectorError = {message:[httpError.message], statusCode:httpError.statusCode};
        return {}, connectorError;
    }
    json validatedResponse;
    validatedResponse, connectorError = getValidatedResponse(response, GIT_PROJECT);
    if (connectorError != null) {
        return null, connectorError;
    }
    try {
        var githubProjectJson, _ = (json)validatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECT];
        singleProject, _ = <Project>githubProjectJson;
    } catch (error e) {
        connectorError = {message:[e.message]};
        return null, connectorError;
    }

    return singleProject, connectorError;
}

@Description {value:"Get a list of issues of a repository."}
@Param {value:"state: State of the issue (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_ALL)"}
@Return {value:"IssueList: Issue list object"}
@Return {value:"GitConnectorError: Error"}
public function <Repository repository> getIssueList (string state) (IssueList, GitConnectorError) {

    endpoint<http:HttpClient> gitClient {
        gitHTTPClient;
    }

    GitConnectorError connectorError;

    if (repository == null) {
        connectorError = {message:["Repository cannot be null"]};
        return null, connectorError;
    }

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}"
    ,"{{GIT_NAME}}":"{{repository.name}}","{{GIT_STATES}}":{{state}}},"{{GIT_QUERY}}":"{{GET_REPOSITORY_ISSUES}}"}`;
    metaData["issueListQuery"] = stringQuery;
    var query, _ = <json>stringQuery;

    //Set headers and payload to the request
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError httpError;
    constructRequest(request, query, gitAccessToken);
    response, httpError = gitClient.post("", request);
    if (httpError != null) {
        connectorError = {message:[httpError.message], statusCode:httpError.statusCode};
        return null, connectorError;
    }

    //Check for empty payloads and errors
    json validatedResponse;
    validatedResponse, connectorError = getValidatedResponse(response, GIT_ISSUES);
    if (connectorError != null) {
        return null, connectorError;
    }
    var githubIssuesJson, _ = (json)validatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_ISSUES];
    IssueList issueList; error err;
    issueList, err = <IssueList>githubIssuesJson;
    io:println(err);
    return issueList, connectorError;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Repository struct                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Organization struct                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a github organization"}
public struct Organization {
    string id;
    string login;
    string name;
    string email;
    string description;
    string location;
    string resourcePath;
    string projectsResourcePath;
    string projectsUrl;
    string url;
    string websiteUrl;
    string avatarUrl;
}
//*********************************************************************************************************************
// Organization bound functions
//*********************************************************************************************************************
@Description {value:"Get all projects of an organization."}
@Param {value:"state: State of the project (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_ALL)"}
@Return {value:"Project[]: Array of projects"}
@Return {value:"GitConnectorError: Error"}
public function <Organization organization> getProjects (string state) (Project[], GitConnectorError) {
    endpoint<http:HttpClient> gitClient {
        gitHTTPClient;
    }

    GitConnectorError connectorError;

    if (organization == null || state == null) {
        connectorError = {message:["Organization and state cannot be null."]};
        return [], connectorError;
    }

    boolean hasNextPage = true;
    http:HttpConnectorError httpError;
    Project[] projectArray = [];

    http:OutRequest request = {};
    http:InResponse response = {};

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization.login}}"
    ,"{{GIT_STATES}}":{{state}}},"{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECTS}}"}`;

    var query, _ = <json>stringQuery;

    //Set headers and payload to the request
    constructRequest(request, query, gitAccessToken);
    int i = 0;
    //Iterate through multiple pages of results
    while (hasNextPage) {
        response, httpError = gitClient.post("", request);
        if (httpError != null) {
            connectorError = {message:[httpError.message], statusCode:httpError.statusCode};
            return [], connectorError;
        }
        json validatedResponse;
        //Check for empty payloads and errors
        validatedResponse, connectorError = getValidatedResponse(response, GIT_PROJECTS);
        if (connectorError != null) {
            return [], connectorError;
        }
        var githubProjectsJson, _ = (json[])validatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_PROJECTS][GIT_NODES];
        foreach projectJson in githubProjectsJson {
            projectArray[i], _ = <Project>projectJson;
            i = i + 1;
        }

        hasNextPage, _ = (boolean)validatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_PROJECTS][GIT_PAGE_INFO]
                                  [GIT_HAS_NEXT_PAGE];
        if (hasNextPage) {
            var endCursor, _ = (string)validatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECTS][GIT_PAGE_INFO]
                                       [GIT_END_CURSOR];

            string stringQueryNextPage = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization.login}}"
            ,"{{GIT_STATES}}":{{state}},"{{GIT_END_CURSOR}}":"{{endCursor}}"}
            ,"{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECTS_NEXT_PAGE}}"}`;
            var queryNextPage, _ = <json>stringQueryNextPage;
            request = {};
            constructRequest(request, queryNextPage, gitAccessToken);
        }

    }
    return projectArray, connectorError;
} //TODO getPojectList()

@Description {value:"Get a single project of an organization."}
@Param {value:"projectNumber: The number of the project"}
@Return {value:"Project object"}
@Return {value:"GitConnectorError: Error"}
public function <Organization organization> getProject (int projectNumber) (Project, GitConnectorError) {
    endpoint<http:HttpClient> gitClient {
        gitHTTPClient;
    }

    GitConnectorError connectorError;

    if (organization == null || projectNumber <= 0) {
        connectorError = {message:["Organization cannot be null and project number should be positive integer."]};
        return null, connectorError;
    }

    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError httpError;
    Project singleProject;

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization.login}}","{{GIT_NUMBER}}":{{projectNumber}}},"{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECT}}"}`;

    var query, _ = <json>stringQuery;

    //Set headers and payload to the request
    constructRequest(request, query, gitAccessToken);

    response, httpError = gitClient.post("", request);
    if (httpError != null) {
        connectorError = {message:[httpError.message], statusCode:httpError.statusCode};
        return {}, connectorError;
    }
    json validatedResponse;
    validatedResponse, connectorError = getValidatedResponse(response, GIT_PROJECT);
    if (connectorError != null) {
        return null, connectorError;
    }
    try {
        var githubProjectJson, _ = (json)validatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_PROJECT];
        singleProject, _ = <Project>githubProjectJson;
    } catch (error e) {
        connectorError = {message:[e.message]};
        return null, connectorError;
    }

    return singleProject, connectorError;
}

@Description {value:"Get a list of repositories of an organization."}
@Return {value:"RepositoryList: Repository list object"}
@Return {value:"GitConnectorError: Error"}
public function <Organization organization> getRepositoryList () (RepositoryList, GitConnectorError) {
    endpoint<http:HttpClient> gitClient {
        gitHTTPClient;
    }

    GitConnectorError connectorError;

    if (organization == null) {
        connectorError = {message:["Organization cannot be null."]};
        return null, connectorError;
    }

    http:HttpConnectorError httpError;
    RepositoryList repositoryList;

    http:OutRequest request = {};
    http:InResponse response = {};

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization.login}}"},
    "{{GIT_QUERY}}":"{{GET_ORGANIZATION_REPOSITORIES}}"}`;
    metaData["repositoryListQuery"] = stringQuery;
    var query, _ = <json>stringQuery;

    //Set headers and payload to the request
    constructRequest(request, query, gitAccessToken);
    response, httpError = gitClient.post("", request);
    if (httpError != null) {
        connectorError = {message:[httpError.message], statusCode:httpError.statusCode};
        return null, connectorError;
    }
    json validatedResponse;
    //Check for empty payloads and errors
    validatedResponse, connectorError = getValidatedResponse(response, GIT_REPOSITORIES);
    if (connectorError != null) {
        return null, connectorError;
    }
    var githubRepositoriesJson, _ = (json)validatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_REPOSITORIES];
    repositoryList, _ = <RepositoryList>githubRepositoriesJson;

    return repositoryList, connectorError;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                       End of Organization struct                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Column struct                                                        //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a github Column"}
public struct Column {
    string id;
    string name;
    private:
        CardList cards;
}
//*********************************************************************************************************************
// Column bound functions
//*********************************************************************************************************************
@Description {value: "Get a list of cards of a column"}
@Return {value: "CardList: A card list object"}
public function <Column column> getCardList () (CardList) {
    metaData["projectColumnId"] = column.id;
    return column.cards;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              End of Column struct                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              CardList struct                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a list of cards of a column"}
public struct CardList {
    private:
        PageInfo pageInfo;
        Card[] nodes;
}
//*********************************************************************************************************************
// CardList bound functions
//*********************************************************************************************************************
@Description {value: "Check if the card list next page is available"}
@Return {value: "boolean: Return true or false"}
public function <CardList cardList> hasNextPage () (boolean) {
    return cardList.pageInfo.hasNextPage;
}

@Description {value: "Check if the card list previous page is available"}
@Return {value: "boolean: Return true or false"}
public function <CardList cardList> hasPreviousPage () (boolean) {
    return cardList.pageInfo.hasPreviousPage;
}

@Description {value: "Get the next page of the card list"}
@Return {value: "CardList: Card list object"}
@Return {value:"GitConnectorError: Error"}
public function <CardList cardList> nextPage () (CardList, GitConnectorError) {
    GitConnectorError connectorError;
    if (cardList.hasNextPage()) {
        var stringQuery, _ = (string)metaData["projectColumnQuery"];
        var projectColumnId, _ = (string)metaData["projectColumnId"];
        var query, _ = <json>stringQuery;
        query.variables.endCursorCards = cardList.pageInfo.endCursor;
        var projectOwnerType, _ = (string)metaData["projectOwnerType"];
        if (projectOwnerType.equalsIgnoreCase(GIT_ORGANIZATION)) {
            query.query = GET_ORGANIZATION_PROJECT_CARDS_NEXT_PAGE; // TODO
            metaData["projectColumnQuery"] = query.toString();
            ColumnList columnList;
            columnList, _ = getProjectColumns(GIT_ORGANIZATION, query.toString());
            foreach column in columnList.getAllColumns() {
                if (column.id == projectColumnId) {
                    return column.getCardList(), connectorError;
                }
            }
        } else if (projectOwnerType.equalsIgnoreCase(GIT_REPOSITORY)) {
            query.query = GET_REPOSITORY_PROJECT_CARDS_NEXT_PAGE; //TODO
            metaData["projectColumnQuery"] = query.toString();
            ColumnList columnList;
            columnList, _ = getProjectColumns(GIT_REPOSITORY, query.toString());
            foreach column in columnList.getAllColumns() {
                if (column.id == projectColumnId) {
                    return column.getCardList(), connectorError;
                }
            }
        }
        io:println(query);
    }
    connectorError = {message:["Card list has no next page"]};

    return null, connectorError;
}

@Description {value: "Get an array of all the cards"}
@Return {value: "Card[]: Array of cards"}
public function <CardList cardList> getAllCards () (Card[]) {
    return cardList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of CardList struct                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              ColumnList struct                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a list of columns of a project"}
public struct ColumnList {
    private:
        PageInfo pageInfo;
        Column[] nodes;
}
//*********************************************************************************************************************
// ColumnList bound functions
//*********************************************************************************************************************
@Description {value: "Check if column list next page is available"}
@Return {value: "boolean: Return true or false"}
public function <ColumnList columnList> hasNextPage () (boolean) {
    return columnList.pageInfo.hasNextPage;
}

@Description {value: "Check if column list previosu page is available"}
@Return {value: "boolean: Return true or false"}
public function <ColumnList columnList> hasPreviousPage () (boolean) {
    return columnList.pageInfo.hasPreviousPage;
}

@Description {value: "Get the next page of colum list"}
@Return {value: "ColumList: Column list object"}
@Return {value:"GitConnectorError: Error"}
public function <ColumnList columnList> nextPage () (ColumnList, GitConnectorError) {
    GitConnectorError connectorError;
    if (columnList.hasNextPage()) {
        var stringQuery, _ = (string)metaData["projectColumnQuery"];
        var query, _ = <json>stringQuery;
        query.variables.endCursorColumns = columnList.pageInfo.endCursor;
        var projectOwnerType, _ = (string)metaData["projectOwnerType"];
        if (projectOwnerType.equalsIgnoreCase(GIT_ORGANIZATION)) {
            query.query = GET_ORGANIZATION_PROJECT_COLUMNS_NEXT_PAGE;
            metaData["projectColumnQuery"] = query.toString();

            return getProjectColumns(GIT_ORGANIZATION, query.toString());
        } else if (projectOwnerType.equalsIgnoreCase(GIT_REPOSITORY)) {
            query.query = GET_REPOSITORY_PROJECT_COLUMNS_NEXT_PAGE;
            metaData["projectColumnQuery"] = query.toString();

            return getProjectColumns(GIT_REPOSITORY, query.toString());
        }
        io:println(query);
    }
    connectorError = {message:["Column list has no next page"]};

    return null, connectorError;
}

@Description {value: "Get an array of all the columns"}
@Return {value: "Column[]: Column array"}
public function <ColumnList columnList> getAllColumns () (Column[]) {
    return columnList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                          End of ColumnList struct                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               Creator struct                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a github Creator"}
public struct Creator {
    string login;
    string resourcePath;
    string url;
    string avatarUrl;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of Creator struct                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              ProjectOwner struct                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a github project owner"}
public struct ProjectOwner {
    string id;
    string projectsResourcePath;
    string projectsUrl;
    string viewerCanCreateProjects;
    private:
        string __typename;
}

@Description {value: "Get the type of the project owner"}
@Return {value: "string: Type of the owner"}
public function <ProjectOwner projectOwner> getOwnerType () (string) {
    return projectOwner.__typename;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of ProjectOwner struct                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            RepositoryOwner struct                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a github repository owner"}
public struct RepositoryOwner {
    string id;
    string login;
    string url;
    string avatarUrl;
    string resourcePath;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                          End RepositoryOwner struct                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               Content struct                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a content in a github card"}
public struct Content {
    string title;
    string url;
    string issueState;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Content struct                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                Issue struct                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a github issue"}
public struct Issue {
    string id;
    string bodyText;
    string closed;
    string closedAt;
    string createdAt;
    Creator author;
    Creator editor;
    LabelList labels;
    int number;
    string state;
    string title;
    string updatedAt;
    string url;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              End of Issue struct                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                IssueList struct                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a list of github issues"}
public struct IssueList {
    private:
        PageInfo pageInfo;
        Issue[] nodes;
}
//*********************************************************************************************************************
// IssueList bound functions
//*********************************************************************************************************************
@Description {value: "Check if issue list next page is available"}
@Return {value: "boolean: Return true or false"}
public function <IssueList issueList> hasNextPage () (boolean) {
    return issueList.pageInfo.hasNextPage;
}

@Description {value: "Check if issue list previous page is avaiable"}
@Return {value: "boolean: Return ture or false"}
public function <IssueList issueList> hasPreviousPage () (boolean) {
    return issueList.pageInfo.hasPreviousPage;
}

@Description {value: "Get an array of all the issues"}
@Return {value: "Issue[]: Issue array"}
public function <IssueList issueList> getAllIssues () (Issue[]) {
    return issueList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of IssueList struct                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                Language struct                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a github language"}
public struct Language {
    string id;
    string name;
    string color;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of Language struct                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            GitConnectorError struct                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "GitHub Connector Error"}
public struct GitConnectorError {
    int statusCode;
    string[] message;
    string reasonPhrase;
    string server;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                         End of GitConnectorError struct                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              PullRequest struct                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a github pull request"}
public struct PullRequest {
    string id;
    string title;
    string createdAt;
    string updatedAt;
    boolean closed;
    string closedAt;
    string mergedAt;
    string state;
    int number;
    string url;
    string body;
    string changedFiles;
    int additions;
    int deletions;
    string resourcePath;
    string revertResourcePath;
    string revertUrl;
    Creator author;
    string headRefName;
    string baseRefName;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of PullRequest struct                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             PullRequestList struct                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a list of github pull requests"}
public struct PullRequestList {
    private:
        PageInfo pageInfo;
        PullRequest[] nodes;
}
//*********************************************************************************************************************
// ColumnList bound functions
//*********************************************************************************************************************
@Description {value: "Check if pull request list next page is available"}
@Return {value: "boolean: Return true or false"}
public function <PullRequestList pullRequestList> hasNextPage () (boolean) {
    return pullRequestList.pageInfo.hasNextPage;
}

@Description {value: "Check if pull request list previous page is avaiable"}
@Return {value: "boolean: Return ture or false"}
public function <PullRequestList pullRequestList> hasPreviousPage () (boolean) {
    return pullRequestList.pageInfo.hasPreviousPage;
}

@Description {value: "Get an array of all the pull requests"}
@Return {value: "PullRequest[]: PullRequest array"}
public function <PullRequestList pullRequestList> getAllPullrequests () (PullRequest[]) {
    return pullRequestList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                          End of PullRequestList struct                                            //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                   Card struct                                                     //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a github card"}
public struct Card {
    string id;
    string note;
    string state;
    string createdAt;
    string updatedAt;
    string url;
    Creator creator;
    json column;
    json content;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               End of Card struct                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                PageInfo struct                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a github page information"}
struct PageInfo {
    boolean hasNextPage;
    boolean hasPreviousPage;
    string startCursor;
    string endCursor;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of PageInfo struct                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                 Label struct                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a github label"}
public struct Label {
    string id;
    string name;
    string description;
    string color;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of Label struct                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               LabelList struct                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value: "Represents a list of github labels"}
public struct LabelList {
    private:
        Label[] nodes;
}

@Description {value: "Get an array of labels"}
@Return {value: "Lebel[]: Label array"}
public function <LabelList labelList> getAllLabels () (Label[]) {
    return labelList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              End of LabelList struct                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

