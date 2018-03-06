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
import ballerina.log;
import ballerina.io;

string gitAccessToken = "";

@Description {value: "GitHub client connector"}
@Param {value: "accessToken:Access token"}
public connector GithubConnector (string accessToken) {

    endpoint <http:HttpClient> gitHubEndpoint {
        create http:HttpClient(GIT_API_URL, {});
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

        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization}}","{{GIT_STATES}}":{{state}}},"{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECTS}}"}`;

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

                string stringQueryNextPage = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization}}","{{GIT_STATES}}":{{state}},"{{GIT_END_CURSOR}}":"{{endCursor}}"},"{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECTS_NEXT_PAGE}}"}`;
                var queryNextPage, _ = <json>stringQueryNextPage;
                request = {};
                constructRequest(request, queryNextPage, accessToken);
            }

        }
        return projectArray, connectorError;
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

        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization}}","{{GIT_NUMBER}}":{{projectNumber}}},"{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECT}}"}`;

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
                     "query":GET_PROJECT_CARDS};

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

        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repoOwner}}","{{GIT_NAME}}":"{{repoName}}"},"{{GIT_QUERY}}":"{{GET_REPOSITORY}}"}`;

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

    @Description {value:"Get an organization"}
    @Param {value:"name: Name of the organization"}
    @Return {value:"Organization: Organization struct"}
    @Return {value:"GitConnectorError: Error"}
    action getOrganization (string name) (Organization, GitConnectorError ) {
        GitConnectorError connectorError;

        if (null == name || "" == name) {
            connectorError = {message:["Organization name should be specified."]};
            return null, connectorError;
        }
        http:OutRequest request = {};
        http:InResponse response = {};
        http:HttpConnectorError httpError;
        Organization singleOrganization;

        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{name}}"},
        "{{GIT_QUERY}}":"{{GET_ORGANIZATION}}"}`;

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
            var githubRepositoryJson, _ = (json)validatedResponse[GIT_DATA][GIT_ORGANIZATION];
            singleOrganization, _ = <Organization >githubRepositoryJson;
        } catch (error e) {
            connectorError = {message:[e.message]};
            return null, connectorError;
        }

        return singleOrganization, connectorError;
    }
}



