package src.wso2.github;

import ballerina.net.http;

http:HttpClient gitHTTPClient = create http:HttpClient (GIT_API_URL, {});
// #TODO Move these structs and enum to another package once https://github.com/ballerina-lang/ballerina/issues/4736 is fixed.
//*************************************************
//*************************************************
//  Struct Templates
//*************************************************

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

public struct Card {
    string id;
    string note;
    string state;
    string createdAt;
    string updatedAt;
    string url;
    Creator creator;
    Column column;
    Content content;
}

public struct Column {
    string id;
    string name;
}

public struct Content {
    string body;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Repository struct
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// End of Repository struct
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Organization struct
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// End of Organization struct
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

//*************************************************
// End of structs
//*************************************************


//*************************************************
//*************************************************
//  Enum
//*************************************************
//public enum State {
//    OPEN,
//    CLOSED,
//    ALL
//}
//*************************************************
// End of Enum
//*************************************************

