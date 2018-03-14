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

import ballerina.net.http;

string gitAccessToken = "";

@Description {value: "GitHub client connector"}
@Param {value: "accessToken: GitHub access token"}
public connector GithubConnector (string accessToken) {

    endpoint <http:HttpClient> gitHubEndpoint {
        create http:HttpClient(GIT_API_URL, {});
    }

    @Description {value:"Get a repository of an owner"}
    @Param {value:"name: Name of the form owner/repository"}
    @Return {value:"Repository: Repository struct"}
    @Return {value:"error: Error"}
    action getRepository(string name)(Repository, GitConnectorError ) {
        GitConnectorError connectorError;

        if (name == null || name == "") {
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



