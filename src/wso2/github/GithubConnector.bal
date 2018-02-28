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
        create http:HttpClient("https://api.github.com/graphql", {} );
    }
    http:HttpConnectorError httpError;

    @Description{ value : "Get all projects of a repository"}
    @Param{ value : "owner: Owner of the repository"}
    @Param{ value : "repository: Name of the repository"}
    @Param{value: "state: State of the repository (open, closed, all)"}
    @Return { value:"Project[]: Array of projects" }
    @Return {value:"error: Error"}
    action getRepositoryProjects (Repository repository, string states) (Project[], error ) {
        boolean hasNextPage = true;
        error returnError;
        Project[] projectArray= [];
        if (repository == null || states == null) {
            returnError = {message: "Repository and state cannot be null"};
            return [], returnError;
        }
        http:OutRequest request = {};
        http:InResponse response = {};

        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}",
        "{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_STATES}}":"{{states}}"},"{{GIT_QUERY}}":"{{gq:GET_REPOSITORY_PROJECTS}}"}`;

        var query, _ = <json>stringQuery;

        //Set headers and payload to the request
        constructRequestHeaders(request, query, accessToken);
        int i = 0;
        while (hasNextPage) {
            response, httpError = gitHubEndpoint.post("", request);
            if (null != httpError) {
                returnError = {message:httpError.message, cause:httpError.cause};
                return [], returnError;
            }
            json jsonResponse;
            try {
                jsonResponse =  response.getJsonPayload();

                var githubProjectsJson, _ = (json[])jsonResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECTS][GIT_NODES];
                foreach projectJson in githubProjectsJson {
                    projectArray[i], _ = <Project>projectJson;
                    i = i + 1;
                }
            } catch (error e) {
                returnError = {message:"", cause:e.cause};
                return [], returnError;
            }

            hasNextPage, _ = (boolean)jsonResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECTS][GIT_PAGE_INFO]
                                              [GIT_HAS_NEXT_PAGE];
            if (hasNextPage) {
                var endCursor, _ = (string)jsonResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECTS][GIT_PAGE_INFO][GIT_END_CURSOR];
                string stringQueryNextPage = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}","{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_STATES}}":"{{states}}","{{GIT_END_CURSOR}}":"{{endCursor}}"},"{{GIT_QUERY}}":"{{gq:GET_REPOSITORY_PROJECTS_NEXT_PAGE}}"}`;
                 var queryNextPage, _ = <json>stringQueryNextPage;
                 request = {};
                 constructRequestHeaders(request, queryNextPage, accessToken);
            }

        }

        return projectArray, returnError;
    }

    @Description{ value : "Get all projects of an organization"}
    @Param{ value : "organzation: Github organization name"}
    @Param{value: "state: State of the repository (open, closed, all)"}
    @Return { value:"Array of projects" }
    @Return {value:"error: Error"}
    action getOrganizationProjects (string organization, string state) (Project[], error ) {
        http:OutRequest request = {};
        http:InResponse response = {};
        error returnError;
        Project[] projectArray= [];

        json query = {"variables":{"organization":organization,"state":state},"query": gq:GET_ORGANIZATION_PROJECTS};
        constructRequestHeaders(request, query, accessToken);
        response, httpError = gitHubEndpoint.post("", request);
        if (httpError != null) {
            returnError = {message:httpError.message, cause:httpError.cause};
            return projectArray, returnError;
        }
        json jsonResponse =  response.getJsonPayload();

        try {
            var githubProjectsJson, _ = (json[])jsonResponse["data"]["organization"]["projects"]["edges"];
            int i = 0;
            foreach projectJson in githubProjectsJson {
                var projectObject, _ = <Project>projectJson["node"];

                projectArray[i] = projectObject;
                i = i + 1;
            }
        } catch (error e) {
            returnError = {message:e.message, cause:e.cause};
            return projectArray, returnError;
        }


        return projectArray, returnError;
    }

    @Description{ value : "Get a single project"}
    @Param{ value : "owner: Owner of the repository"}
    @Param{value: "repository: Name of the repository"}
    @Param {value:"projectNumber: The number of the project"}
    @Return { value:"A project object" }
    @Return {value:"error: Error"}
    action getProject (string owner, string repository, int projectNumber) (Project, error ) {
        http:OutRequest request = {};
        http:InResponse response = {};
        error returnError;
        Project singleProject;
        json query = {"variables":{"owner":owner,"repository":repository,"number":projectNumber},
                         "query": gq:GET_PROJECT};
        constructRequestHeaders(request, query, accessToken);
        response, httpError = gitHubEndpoint.post("", request);
        if (httpError != null) {
            returnError = {message:httpError.message, cause:httpError.cause};
            return singleProject, returnError;
        }
        json jsonResponse =  response.getJsonPayload();
        try {
            var githubProjectJson, _ = (json)jsonResponse["data"]["repositoryOwner"]["repository"]["project"];
            var projectObject, _ = <Project>githubProjectJson;
            singleProject = projectObject;
        } catch (error e) {
            returnError = {message:e.message, cause:e.cause};
            return singleProject, returnError;
        }

        return singleProject, returnError;

    }

    @Description {value:"Get cards relevant to a project"}
    @Param {value:"organzation: Github organization name"}
    @Param {value:"projectNumber: The number of the project"}
    @Return {value:"error: Error"}
    action getProjectCards (string organization, int projectNumber) (Card[], error ) {
        http:OutRequest request = {};
        http:InResponse response = {};
        error returnError;
        Card[] cardArray = [];

        json query = {"variables":{"organization":organization, "number":projectNumber},
                     "query":gq:GET_PROJECT_CARDS};

        constructRequestHeaders(request, query, accessToken);

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
    action getRepository(string name)(Repository, error ) {
        http:OutRequest request = {};
        http:InResponse response = {};
        error returnError;
        Repository repository = {};
        string[] repoDetails = name.split("/");

        json query = {"variables":{"owner":repoDetails[0],"name":repoDetails[1]}, "query":gq:GET_REPOSITORY};

        constructRequestHeaders(request, query, accessToken);

        response, httpError = gitHubEndpoint.post("", request);
        if (httpError != null) {
            returnError = {message:httpError.message, cause:httpError.cause};
            return repository, returnError;
        }

        json responseJson = response.getJsonPayload();

        try {
            var projectJson, _ = (json)responseJson["data"]["repository"];
            var repositoryStruct, _ = <Repository>projectJson;
            repository = repositoryStruct;
        } catch (error e) {
            returnError = {message:e.message, cause:e.cause};
            log:printError(returnError.message);
            return repository, returnError;
        }

        return repository, returnError;
    }
}

@Description {value:"Construct the request headers"}
@Param {value:"request: The http request object"}
@Param {value:"query: GraphQL API query"}
@Param {value:"accessToken: GitHub access token"}
function constructRequestHeaders (http:OutRequest request, json query, string accessToken) {
    request.removeAllHeaders();
    request.addHeader("Authorization", "Bearer " + accessToken);
    request.setJsonPayload(query);

}

@Description {value:"Validate the http response"}
@Param {value:"http:InResponse: The http response object"}
@Return {value:"json: The JSON payload in the response"}
@Return {value:"GitConnectoError: GitConnectorError object"}
function validateResponse (http:InResponse response) (json, GitConnectorError){
    GitConnectorError gitError;
    json responsePayload;
    try {
        responsePayload = response.getJsonPayload();

        if (null == responsePayload[GIT_DATA]) {
            string[] errors = [];
            var errorList, _ = (json[])responsePayload[GIT_ERRORS];
            int i = 0;
            foreach singleError in errorList {
                errors[i], _ = (string)singleError[GIT_MESSAGE];
            }

            gitError = {message:errors, statusCode:response.statusCode, reasonPhrase:response.reasonPhrase, server:response.server};
            return null, gitError;
        }

    } catch (error e) {
        string[] errorMessage = [GIT_ERROR_WHILE_RETRIEVING_DATA];
        gitError = {message:errorMessage, statusCode:response.statusCode, reasonPhrase:response.reasonPhrase, server:response.server};
    }

    return responsePayload, gitError;

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
    RepositoryOwner owner;
    string nameWithOwner;
    string createdAt;
    string updatedAt;
    string description;
    string homepageUrl;
    Language primaryLanguage;
    Language[] language;
    string url;
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