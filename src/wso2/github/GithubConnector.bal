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

package src.wso2.github;

import ballerina.net.http;
import src.wso2.github.graphqlQueries as gq;
import ballerina.log;
import ballerina.io;

@Description {value: "GitHub client connector"}
@Param {value: "accessToken:Access token"}
public connector GithubConnector (string accessToken) {

    endpoint <http:HttpClient> gitHubEndpoint {
        create http:HttpClient(GIT_API_URL, {} );
    }

    @Description{ value : "Get all projects of a repository"}
    @Param{ value : "owner: Owner of the repository"}
    @Param{ value : "repository: Name of the repository"}
    @Param{value: "states: State of the repository (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_ALL)"}
    @Return { value:"Project[]: Array of projects" }
    @Return {value:"GitConnectorError: Error"}
    action getRepositoryProjects (Repository repository, string state) (Project[], GitConnectorError) {
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
        "{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_STATES}}":{{state}}},"{{GIT_QUERY}}":"{{gq:GET_REPOSITORY_PROJECTS}}"}`;

        var query, _ = <json>stringQuery;

        //Set headers and payload to the request
        constructRequest(request, query, accessToken);
        int i = 0;
        //Iterate through multiple pages of results
        while (hasNextPage) {
            response, httpError = gitHubEndpoint.post("", request);
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

                string stringQueryNextPage = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}","{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_STATES}}":{{state}},"{{GIT_END_CURSOR}}":"{{endCursor}}"},"{{GIT_QUERY}}":"{{gq:GET_REPOSITORY_PROJECTS_NEXT_PAGE}}"}`;
                 var queryNextPage, _ = <json>stringQueryNextPage;
                 request = {};
                 constructRequest(request, queryNextPage, accessToken);
            }

        }
        return projectArray, connectorError;
    }

    @Description{ value : "Get all projects of an organization"}
    @Param{ value : "organzation: Github organization name"}
    @Param{value: "state: State of the repository (open, closed, all)"}
    @Return { value:"Project[]:Array of projects" }
    @Return {value:"GitConnectorError: Error"}
    action getOrganizationProjects (string organization, string state) (Project[], GitConnectorError) {
        GitConnectorError connectorError;

        if (organization == null || organization == "" || state == null) {
            connectorError = {message:["Organization name and state cannot be null"]};
            return [], connectorError;
        }

        boolean hasNextPage = true;
        http:HttpConnectorError httpError;
        Project[] projectArray= [];

        http:OutRequest request = {};
        http:InResponse response = {};

        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization}}","{{GIT_STATES}}":{{state}}},"{{GIT_QUERY}}":"{{gq:GET_ORGANIZATION_PROJECTS}}"}`;

        var query, _ = <json>stringQuery;

        //Set headers and payload to the request
        constructRequest(request, query, accessToken);
        int i = 0;
        //Iterate through multiple pages of results
        while (hasNextPage) {
            response, httpError = gitHubEndpoint.post("", request);
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

                string stringQueryNextPage = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization}}","{{GIT_STATES}}":{{state}},"{{GIT_END_CURSOR}}":"{{endCursor}}"},"{{GIT_QUERY}}":"{{gq:GET_ORGANIZATION_PROJECTS_NEXT_PAGE}}"}`;
                var queryNextPage, _ = <json>stringQueryNextPage;
                request = {};
                constructRequest(request, queryNextPage, accessToken);
            }

        }
        return projectArray, connectorError;
    }

    @Description{ value : "Get a single project of a specified repository."}
    @Param{value: "repository: Name of the repository"}
    @Param {value:"projectNumber: The number of the project"}
    @Return { value:"Project object" }
    @Return {value:"Error"}
    action getRepositoryProject (Repository repository, int projectNumber) (Project, GitConnectorError) {
        GitConnectorError connectorError;

        if (repository == null || projectNumber <= 0 ) {
            connectorError = {message:["Repository cannot be null and project number should be positive integer."]};
            return null, connectorError;
        }

        http:OutRequest request = {};
        http:InResponse response = {};
        http:HttpConnectorError httpError;
        Project singleProject;

        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}","{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_NUMBER}}":{{projectNumber}}},"{{GIT_QUERY}}":"{{gq:GET_REPOSITORY_PROJECT}}"}`;

        var query, _ = <json>stringQuery;

        //Set headers and payload to the request
        constructRequest(request, query, accessToken);

        response, httpError = gitHubEndpoint.post("", request);
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

    @Description{ value : "Get a single project of a specified organization."}
    @Param{value: "organization: Name of the organization"}
    @Param {value:"projectNumber: The number of the project"}
    @Return { value:"Project object" }
    @Return {value:"Error"}
    action getOrganizationProject (string organization, int projectNumber) (Project, GitConnectorError) {
        GitConnectorError connectorError;

        if (organization == null || projectNumber <= 0 ) {
            connectorError = {message:["Organization cannot be null and project number should be positive integer."]};
            return null, connectorError;
        }

        http:OutRequest request = {};
        http:InResponse response = {};
        http:HttpConnectorError httpError;
        Project singleProject;

        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization}}","{{GIT_NUMBER}}":{{projectNumber}}},"{{GIT_QUERY}}":"{{gq:GET_ORGANIZATION_PROJECT}}"}`;

        var query, _ = <json>stringQuery;

        //Set headers and payload to the request
        constructRequest(request, query, accessToken);

        response, httpError = gitHubEndpoint.post("", request);
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

    @Description {value:"Get cards relevant to a project"}
    @Param {value:"organzation: Github organization name"}
    @Param {value:"projectNumber: The number of the project"}
    @Return {value:"error: Error"}
    action getProjectCards (string organization, int projectNumber) (Card[], error ) {
        http:OutRequest request = {};
        http:InResponse response = {};
        error returnError;
        http:HttpConnectorError httpError;
        Card[] cardArray = [];

        json query = {"variables":{"organization":organization, "number":projectNumber},
                     "query":gq:GET_PROJECT_CARDS};

        constructRequest(request, query, accessToken);

        response, httpError = gitHubEndpoint.post("", request);
        if (httpError != null) {
            returnError = {message:httpError.message, cause:httpError.cause};
            return cardArray, returnError;
        }

        json jsonResponse = response.getJsonPayload();
        try {
            var githubJson, _ = (json) jsonResponse["data"]["organization"]["project"]["columns"]["edges"];
            int i = 0;
            foreach columnJson in githubJson {
                foreach cardJson in columnJson["node"]["cards"]["edges"] {
                    //println(cardJson); println("====");
                    var card, _ = <Card>cardJson["node"];
                    io:println(cardJson["node"]);io:println("%%%%");
                    cardArray[i] = card;
                    i = i + 1;
                }
            }
        } catch (error e) {
            returnError = {message:e.message, cause:e.cause};
            log:printError(returnError.message);
            return cardArray, returnError;
        }

        return cardArray, returnError;
    }

    @Description {value:"Get a repository of an owner"}
    @Param {value:"name: Name of the form owner/repository"}
    @Return {value:"Repository: Repository struct"}
    @Return {value:"error: Error"}
    action getRepository(string name)(Repository, GitConnectorError ) {
        GitConnectorError connectorError;

        if (null == name || "" == name) {
            connectorError = {message:["Repository owner and name should be specified."]};
            return null, connectorError;
        }
        string[] repoIdentifier = name.split("/");
        string repoOwner = repoIdentifier[GIT_INDEX_ZERO];
        string repoName = repoIdentifier[GIT_INDEX_ONE];
        http:OutRequest request = {};
        http:InResponse response = {};
        http:HttpConnectorError httpError;
        Repository singleRepository;

        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repoOwner}}","{{GIT_NAME}}":"{{repoName}}"},"{{GIT_QUERY}}":"{{gq:GET_REPOSITORY}}"}`;

        var query, _ = <json>stringQuery;

        //Set headers and payload to the request
        constructRequest(request, query, accessToken);

        response, httpError = gitHubEndpoint.post("", request);
        if (httpError != null) {
            connectorError = {message:[httpError.message], statusCode:httpError.statusCode};
            return null, connectorError;
        }
        json validatedResponse;
        validatedResponse, connectorError = validateResponse(response, GIT_NAME);
        if (connectorError != null) {
            return null, connectorError;
        }
        try {
            var githubRepositoryJson, _ = (json)validatedResponse[GIT_DATA][GIT_REPOSITORY];
            singleRepository, _ = <Repository>githubRepositoryJson;
        } catch (error e) {
            connectorError = {message:[e.message]};
            return null, connectorError;
        }

        return singleRepository, connectorError;
    }
}

@Description {value:"Construct the request headers"}
@Param {value:"request: The http request object"}
@Param {value:"query: GraphQL API query"}
@Param {value:"accessToken: GitHub access token"}
function constructRequest (http:OutRequest request, json query, string accessToken) {
    request.removeAllHeaders();
    request.addHeader("Authorization", "Bearer " + accessToken);
    request.setJsonPayload(query);

}

@Description {value:"Validate the http response"}
@Param {value:"http:InResponse: The http response object"}
@Param {value:"component:"}
@Return {value:"json: The JSON payload in the response"}
@Return {value:"GitConnectoError: GitConnectorError object"}
function validateResponse (http:InResponse response, string validateComponent) (json, GitConnectorError){
    GitConnectorError connectorError;
    json responsePayload;
    try {
        responsePayload = response.getJsonPayload();
        string[] payLoadKeys = responsePayload.getKeys();
        //Check all the keys in the payload to see if an error object is returned.
        foreach key in payLoadKeys {
            if (GIT_ERRORS.equalsIgnoreCase(key)){
                string[] errors = [];
                var errorList, _ = (json[])responsePayload[GIT_ERRORS];
                int i = 0;
                foreach singleError in errorList {
                    errors[i], _ = (string)singleError[GIT_MESSAGE];
                    i = i + 1;
                }
                connectorError = {message:errors, statusCode:response.statusCode, reasonPhrase:response.reasonPhrase, server:response.server};
                return null, connectorError;
            }
        }
        //If no error object is returned, then check if the response contains the requested data.
        string keyInData = responsePayload[GIT_DATA].getKeys()[GIT_INDEX_ZERO];
        if (null == responsePayload[GIT_DATA][keyInData][validateComponent]) {
            string[] errorMessage = [GIT_ERROR_WHILE_RETRIEVING_DATA];
            responsePayload = null;
            connectorError = {message:errorMessage, statusCode:response.statusCode, reasonPhrase:response.reasonPhrase, server:response.server};
        }


    } catch (error e) {
        string[] errorMessage = [GIT_ERROR_WHILE_RETRIEVING_PAYLOAD];
        responsePayload = null;
        connectorError = {message:errorMessage, statusCode:response.statusCode, reasonPhrase:response.reasonPhrase, server:response.server};
    }

    return responsePayload, connectorError;

}

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

public function <Repository repository> getPullRequests(string state) (PullRequest[]){
    endpoint<http:HttpClient> prEndpoint {
        create http:HttpClient(GIT_API_URL, {});
    }
    http:OutRequest request = {};
    http:InResponse response = {};

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}",
        "{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_STATES}}":{{state}}},"{{GIT_QUERY}}":"{{gq:GET_PULL_REQUESTS}}"}`;

    var query, _ = <json>stringQuery;

    constructRequest(request, query, "");
    return [];

}


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