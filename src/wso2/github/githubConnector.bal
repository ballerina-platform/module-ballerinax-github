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

@Description {value: "GitHub client connector"}
@Param {value: "accessToken:Access token"}
public connector githubConnector (string accessToken) {

    endpoint <http:HttpClient> gitHubEndpoint {
        create http:HttpClient("https://api.github.com/graphql", {} );
    }
    http:HttpConnectorError httpError;

    @Description{ value : "Get all projects of a repository"}
    @Param{ value : "owner: Owner of the repository"}
    @Param{ value : "repository: Name of the repository"}
    @Param{value: "state: State of the repository (open, closed, all)"}
    @Return { value:"Array of projects" }
    @Return {value:"error: Error"}
    action getRepositoryProjects (string owner, string repository, string state) (Project[], error ) {
        http:OutRequest request = {};
        http:InResponse response = {};
        error returnError;
        Project[] projectArray= [];

        json query = {"variables":{"owner":owner,"repository":repository,"state":state},
                         "query": gq:GET_REPOSITORY_PROJECTS};
        constructRequestHeaders(request, query, accessToken);

        response, httpError = gitHubEndpoint.post("", request);
        if (httpError != null) {
            returnError = {msg:httpError.msg, cause:httpError.cause, stackTrace:httpError.stackTrace};
            return projectArray, returnError;
        }
        json jsonResponse =  response.getJsonPayload();

        try {
            var githubProjectsJson, _ = (json[])jsonResponse["data"]["repositoryOwner"]["repository"]["projects"]["edges"];
            int i = 0;
            foreach projectJson in githubProjectsJson {
                var projectObject, _ = <Project>projectJson["node"];

                projectArray[i] = projectObject;
                i = i + 1;
            }
        } catch (error e) {
            returnError = {msg:e.msg, cause:e.cause, stackTrace:e.stackTrace};
            return projectArray, returnError;
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
            returnError = {msg:httpError.msg, cause:httpError.cause, stackTrace:httpError.stackTrace};
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
            returnError = {msg:e.msg, cause:e.cause, stackTrace:e.stackTrace};
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
            returnError = {msg:httpError.msg, cause:httpError.cause, stackTrace:httpError.stackTrace};
            return singleProject, returnError;
        }
        json jsonResponse =  response.getJsonPayload();
        try {
            var githubProjectJson, _ = (json)jsonResponse["data"]["repositoryOwner"]["repository"]["project"];
            var projectObject, _ = <Project>githubProjectJson;
            singleProject = projectObject;
        } catch (error e) {
            returnError = {msg:e.msg, cause:e.cause, stackTrace:e.stackTrace};
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
            returnError = {msg:httpError.msg, cause:httpError.cause, stackTrace:httpError.stackTrace};
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
                    println(cardJson["node"]);println("%%%%");
                    cardArray[i] = card;
                    i = i + 1;
                }
            }
        } catch (error e) {
            returnError = {msg:e.msg, cause:e.cause, stackTrace:e.stackTrace};
            log:printError(returnError.msg);
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
            returnError = {msg:httpError.msg, cause:httpError.cause, stackTrace:httpError.stackTrace};
            return repository, returnError;
        }

        json responseJson = response.getJsonPayload();

        try {
            var projectJson, _ = (json)responseJson["data"]["repository"];
            var repositoryStruct, _ = <Repository>projectJson;
            repository = repositoryStruct;
        } catch (error e) {
            returnError = {msg:e.msg, cause:e.cause, stackTrace:e.stackTrace};
            log:printError(returnError.msg);
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
    request.addHeader("Authorization", "Bearer " + accessToken);
    request.setJsonPayload(query);

}


//*************************************************
//*************************************************
//  Struct Templates
//*************************************************
// #TODO Move these structs to another package once https://github.com/ballerina-lang/ballerina/issues/4736 is fixed.
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
    Owner owner;
}

public struct Creator {
    string login;
    string resourcePath;
    string url;
    string avatarUrl;
}

public struct Owner {
    string id;
    string projectsResourcePath;
    string projectsUrl;
    boolean viewerCanCreateProjects;
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
    string organization;
}

public struct Issue {
    string id;
    string name;
}
//*************************************************
// End of structs
//*************************************************

public enum State {
    OPEN,
    CLOSED,
    ALL
}
