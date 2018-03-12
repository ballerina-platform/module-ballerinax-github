package src.wso2.github;

import ballerina.net.http;

http:HttpClient gitHTTPClient = create http:HttpClient (GIT_API_URL, {});
//*********************************************************************************************************************
//*********************************************************************************************************************
//  Struct Templates
//*********************************************************************************************************************
//*********************************************************************************************************************


//*********************************************************************************************************************
//*********************************************************************************************************************
// Project struct
//*********************************************************************************************************************
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
public function <Project project> getColumnList () (ColumnList , GitConnectorError ) {
    endpoint <http:HttpClient> gitClient {
        gitHTTPClient;
    }

    GitConnectorError connectorError;

    if (project == null) {
        connectorError = {message:["Project cannot be null"]};
        return null, connectorError;
    }
    string projectOwnerType = project.owner.__typename;
    if (projectOwnerType.equalsIgnoreCase(GIT_ORGANIZATION) && project.resourcePath != null) {
        string organization = project.resourcePath.split(GIT_PATH_SEPARATOR)[GIT_INDEX_TWO];

        return getOrganizationProjectColumns(organization, project.number);
    } else if (projectOwnerType.equalsIgnoreCase(GIT_REPOSITORY)) {
        string ownerName = project.resourcePath.split(GIT_PATH_SEPARATOR)[GIT_INDEX_ONE];
        string repositoryName = project.resourcePath.split(GIT_PATH_SEPARATOR)[GIT_INDEX_TWO];

        return getRepositoryProjectColumns(ownerName, repositoryName, project.number);
    }
    return null, connectorError;
}

@Description {value:"Get all columns of an organization project"}
@Param{value: "organization: Name of the organization"}
@Param{value: "projectNumber: Number of the project"}
@Return {value:"ColumnList: Column list object"}
@Return {value:"GitConnectorError: Error"}
function getOrganizationProjectColumns (string organization, int projectNumber) (ColumnList , GitConnectorError ) {
    endpoint <http:HttpClient> gitClient {
        gitHTTPClient;
    }
    GitConnectorError connectorError;

    if (organization == null || organization == "" || projectNumber <= 0) {
        connectorError = {message:["Repository and state cannot be null."]};
        return null, connectorError;
    }

    http:HttpConnectorError httpError;

    http:OutRequest request = {};
    http:InResponse response = {};

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization}}",
            "{{GIT_NUMBER}}":{{projectNumber}}},"{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECT_CARDS}}"}`;

    var query, _ = <json>stringQuery;

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
    validatedResponse, connectorError = validateResponse(response, GIT_PROJECT);
    if (connectorError != null) {
        return null, connectorError;
    }
    var projectColumnsJson, _ = (json)validatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_PROJECT][GIT_COLUMNS];
    var columnList, err = <ColumnList>projectColumnsJson;

    return columnList, connectorError;
}

@Description {value:"Get all columns of an organization project"}
@Param{value: "owner: Owner of the repository"}
@Param{value: "repoName: Name of the repository"}
@Param{value: "projectNumber: Number of the project"}
@Return {value:"ColumnList: Column list object"}
@Return {value:"GitConnectorError: Error"}
function getRepositoryProjectColumns (string owner, string repoName, int projectNumber) (ColumnList , GitConnectorError ) {
    endpoint <http:HttpClient> gitClient {
        gitHTTPClient;
    }
    GitConnectorError connectorError;

    if (owner == null || owner == "" || repoName == null || repoName == "" || projectNumber <= 0) {
        connectorError = {message:["Owner, repository name cannot be empty and project number must be positive"]};
        return null, connectorError;
    }

    http:HttpConnectorError httpError;

    http:OutRequest request = {};
    http:InResponse response = {};

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{owner}}","{{GIT_NAME}}":"{{repoName}}",
            "{{GIT_NUMBER}}":{{projectNumber}}},"{{GIT_QUERY}}":"{{GET_REPOSITORY_PROJECT_CARDS}}"}`;

    var query, _ = <json>stringQuery;

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
    validatedResponse, connectorError = validateResponse(response, GIT_PROJECT);
    if (connectorError != null) {
        return null, connectorError;
    }
    var projectColumnsJson, _ = (json)validatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECT][GIT_COLUMNS];
    var columnList, err = <ColumnList>projectColumnsJson;

    return columnList, connectorError;
}
//*********************************************************************************************************************
// End of Project struct
//*********************************************************************************************************************
//*********************************************************************************************************************

public struct Creator {
    string login;
    string resourcePath;
    string url;
    string avatarUrl;
}

public struct ProjectOwner {
    string id;
    string projectsResourcePath;
    string projectsUrl;
    string viewerCanCreateProjects;
    string __typename;
}

public struct RepositoryOwner {
    string id;
    string login;
    string url;
    string avatarUrl;
    string resourcePath;
}

public struct Error {
    string message;
}



public struct Content {
    string title;
    string url;
    string issueState;
}

//*********************************************************************************************************************
//*********************************************************************************************************************
// Repository struct
//*********************************************************************************************************************

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
@Param{value: "state: State of the repository (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_MERGED, GIT_STATE_ALL)"}
@Return {value:"PullRequest[]: Array of pull requests"}
@Return {value:"GitConnectorError: Error"}
public function <Repository repository> getPullRequests (string state) (PullRequest[], GitConnectorError){
    endpoint <http:HttpClient> gitClient {
        gitHTTPClient;
    }
    GitConnectorError connectorError;

    if (repository == null || state == "" || state == null) {
        connectorError = {message:["Repository and state cannot be null."]};
        return [], connectorError;
    }

    boolean hasNextPage = true;
    http:HttpConnectorError httpError;
    PullRequest[] pullRequestArray= [];

    http:OutRequest request = {};
    http:InResponse response = {};

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}","{{GIT_NAME}}":"{{repository.name}}","{{GIT_STATES}}":{{state}}},"{{GIT_QUERY}}":"{{GET_PULL_REQUESTS}}"}`;

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
        validatedResponse, connectorError = validateResponse(response, GIT_PULL_REQUESTS);
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
            var endCursor, _ = (string)validatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PULL_REQUESTS][GIT_PAGE_INFO][GIT_END_CURSOR];

            string stringQueryNextPage = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}","{{GIT_NAME}}":"{{repository.name}}","{{GIT_STATES}}":{{state}},"{{GIT_END_CURSOR}}":"{{endCursor}}"},"{{GIT_QUERY}}":"{{GET_PULL_REQUESTS_NEXT_PAGE}}"}`;
            var queryNextPage, _ = <json>stringQueryNextPage;
            request = {};
            constructRequest(request, queryNextPage, gitAccessToken);
        }

    }
    return pullRequestArray, connectorError;

}

@Description{ value : "Get all projects of a repository"}
@Param{value: "state: State of the repository (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_ALL)"}
@Return { value:"Project[]: Array of projects" }
@Return {value:"GitConnectorError: Error"}
public function <Repository repository> getProjects (string state) (Project[], GitConnectorError) {
    endpoint <http:HttpClient> gitClient {
        gitHTTPClient;
    }

    GitConnectorError connectorError;

    if (repository == null || state == null) {
        connectorError = {message:["Repository and state cannot be null"]};
        return [], connectorError;
    }

    boolean hasNextPage = true;
    http:HttpConnectorError httpError;
    Project[] projectArray= [];

    http:OutRequest request = {};
    http:InResponse response = {};

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}",
        "{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_STATES}}":{{state}}},"{{GIT_QUERY}}":"{{GET_REPOSITORY_PROJECTS}}"}`;

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
        validatedResponse, connectorError = validateResponse(response, GIT_PROJECTS);
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
            var endCursor, _ = (string)validatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECTS][GIT_PAGE_INFO][GIT_END_CURSOR];

            string stringQueryNextPage = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}","{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_STATES}}":{{state}},"{{GIT_END_CURSOR}}":"{{endCursor}}"},"{{GIT_QUERY}}":"{{GET_REPOSITORY_PROJECTS_NEXT_PAGE}}"}`;
            var queryNextPage, _ = <json>stringQueryNextPage;
            request = {};
            constructRequest(request, queryNextPage, gitAccessToken);
        }

    }
    return projectArray, connectorError;
}

@Description{ value : "Get a single project of a specified repository."}
@Param {value:"projectNumber: The number of the project"}
@Return { value:"Project object" }
@Return {value:"Error"}
public function <Repository repository> getProject (int projectNumber) (Project, GitConnectorError) {
    endpoint <http:HttpClient> gitClient {
        gitHTTPClient;
    }

    GitConnectorError connectorError;

    if (repository == null || projectNumber <= 0 ) {
        connectorError = {message:["Repository cannot be null and project number should be positive integer."]};
        return null, connectorError;
    }

    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError httpError;
    Project singleProject;

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}","{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_NUMBER}}":{{projectNumber}}},"{{GIT_QUERY}}":"{{GET_REPOSITORY_PROJECT}}"}`;

    var query, _ = <json>stringQuery;

    //Set headers and payload to the request
    constructRequest(request, query, gitAccessToken);

    response, httpError = gitClient.post("", request);
    if (httpError != null) {
        connectorError = {message:[httpError.message], statusCode:httpError.statusCode};
        return {}, connectorError;
    }
    json validatedResponse;
    validatedResponse, connectorError = validateResponse(response, GIT_PROJECT);
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
//*********************************************************************************************************************
// End of Repository struct
//*********************************************************************************************************************
//*********************************************************************************************************************

//*********************************************************************************************************************
//*********************************************************************************************************************
// Organization struct
//*********************************************************************************************************************
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
@Description{ value : "Get all projects of an organization"}
@Param{value: "state: State of the repository (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_ALL)"}
@Return { value:"Project[]:Array of projects" }
@Return {value:"GitConnectorError: Error"}
public function <Organization organization> getProjects (string state) (Project[], GitConnectorError) {
        endpoint <http:HttpClient> gitClient {
            gitHTTPClient;
        }
        
        GitConnectorError connectorError;

        if (organization == null || state == null) {
            connectorError = {message:["Organization and state cannot be null."]};
            return [], connectorError;
        }

        boolean hasNextPage = true;
        http:HttpConnectorError httpError;
        Project[] projectArray= [];

        http:OutRequest request = {};
        http:InResponse response = {};

        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization.login}}","{{GIT_STATES}}":{{state}}},"{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECTS}}"}`;

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
            validatedResponse, connectorError = validateResponse(response, GIT_PROJECTS);
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
                var endCursor, _ = (string)validatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECTS][GIT_PAGE_INFO][GIT_END_CURSOR];

                string stringQueryNextPage = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization.login}}","{{GIT_STATES}}":{{state}},"{{GIT_END_CURSOR}}":"{{endCursor}}"},"{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECTS_NEXT_PAGE}}"}`;
                var queryNextPage, _ = <json>stringQueryNextPage;
                request = {};
                constructRequest(request, queryNextPage, gitAccessToken);
            }

        }
        return projectArray, connectorError;
}

@Description{ value : "Get a single project of a specified organization."}
@Param{value: "organization: Name of the organization"}
@Param {value:"projectNumber: The number of the project"}
@Return { value:"Project object" }
@Return {value:"Error"}
public function <Organization organization> getProject (int projectNumber) (Project, GitConnectorError) {
    endpoint <http:HttpClient> gitClient {
        gitHTTPClient;
    }

    GitConnectorError connectorError;

    if (organization == null || projectNumber <= 0 ) {
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
    validatedResponse, connectorError = validateResponse(response, GIT_PROJECT);
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
//*********************************************************************************************************************
// End of Organization struct
//*********************************************************************************************************************
//*********************************************************************************************************************

public struct Issue {
    string id;
    string name;
}

public struct Language {
    string id;
    string name;
    string color;
}

public struct State {
    string OPEN = "OPEN";
    string CLOSED = "CLOSED";
    string ALL = "OPEN,CLOSED";
}

public struct GitConnectorError {
    int statusCode;
    string[] message;
    string reasonPhrase;
    string server;
}

public struct PullRequest {
    string id;
    string title;
    string createdAt;
    string updatedAt;
    boolean closed;
    string closedAt;
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
}

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
//*********************************************************************************************************************
//*********************************************************************************************************************
// Column struct
//*********************************************************************************************************************
public struct Column {
   private: string name;
    CardList cards;
}
//*********************************************************************************************************************
// Column bound functions
//*********************************************************************************************************************
public function <Column column> getColumnName() (string) {
    return column.name;
}
public function <Column column> getCardList() (CardList) {
    return column.cards;
}
public struct PageInfo {
    boolean hasNextPage;
    boolean hasPreviousPage;
    string startCursor;
    string endCursor;
}
//*********************************************************************************************************************
// End of Column struct
//*********************************************************************************************************************
//*********************************************************************************************************************

//*********************************************************************************************************************
//*********************************************************************************************************************
// CardList struct
//*********************************************************************************************************************
public struct CardList {
    PageInfo pageInfo;
    Card[] nodes;
}
//*********************************************************************************************************************
// CardList bound functions
//*********************************************************************************************************************
public function <CardList cardList> hasNextPage()(boolean) {
    return cardList.pageInfo.hasNextPage;
}

public function <CardList cardList> hasPreviousPage() (boolean) {
    return cardList.pageInfo.hasPreviousPage;
}

public function <CardList cardList> nextPage () {

}

public function <CardList cardList> getAllCards() (Card[]) {
    return cardList.nodes;
}
//*********************************************************************************************************************
// End of CardList struct
//*********************************************************************************************************************
//*********************************************************************************************************************

//*********************************************************************************************************************
//*********************************************************************************************************************
// Column List struct
//*********************************************************************************************************************
public struct ColumnList {
    private:PageInfo pageInfo;
    Column[] nodes;
}
//*********************************************************************************************************************
// ColumnList bound functions
//*********************************************************************************************************************
public function <ColumnList columnList> hasNextPage() (boolean) {
    return columnList.pageInfo.hasNextPage;
}

public function <ColumnList columnList> hasPreviousPage() (boolean) {
    return columnList.pageInfo.hasPreviousPage;
}

public function <ColumnList columnList> nextPage() {

}

public function <ColumnList columnList> getAllColumns() (Column[]) {
    return columnList.nodes;
}
//*********************************************************************************************************************
// End of ColumnList struct
//*********************************************************************************************************************
//*********************************************************************************************************************

//*************************************************
// End of structs
//*************************************************
