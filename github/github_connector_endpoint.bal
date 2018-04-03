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

import ballerina/http;

@Description {value: "GitHub connector configurations can be setup here. In order to use this connector,
the user will need to have a GitHub Personal Access Token. The token can be obtained by visiting

https://github.com/<profile> -> Settings -> Developer Settings -> Personal access tokens

and provide the obtained token to the GitHubConnectorConfiguration"}
public struct GitHubConnectorConfiguration {
    string accessToken;
    http:ClientEndpointConfiguration clientEndpointConfiguration;
}

@Description {value: "GitHub connector configuration initializer"}
public function <GitHubConnectorConfiguration githubConnectorConfiguration> GitHubConfiguration () {
    githubConnectorConfiguration.clientEndpointConfiguration = {};
}

@Description {value: "GitHub connector endpoint"}
public struct GitHubConnectorEndpoint {
    GitHubConnectorConfiguration githubConnectorConfiguration;
    GitHubConnector githubConnector;
}

@Description {value: "GitHub connector endpoint initialization function"}
@Param {value: "GitHubConnectorConfiguration: GitHub connector configuration"}
public function <GitHubConnectorEndpoint githubConnectorEndpoint> init
                                                        (GitHubConnectorConfiguration githubConnectorConfiguration) {
    githubConnectorEndpoint.githubConnector = {
                                                  accessToken : githubConnectorConfiguration.accessToken,
                                                  githubClientEndpoint : {}
                                              };
    githubConnectorEndpoint.githubConnector.githubClientEndpoint.httpClient =
                http:createHttpClient(GIT_GRAPHQL_API_URL, githubConnectorConfiguration.clientEndpointConfiguration);

}

@Description {value: "Register GitHub connector endpoint"}
@Param {value: "typedesc: Accepts types of data (int, float, string, boolean, etc)"}
public function <GitHubConnectorEndpoint githubConnectorEndpoint> register (typedesc serviceType) {}

@Description {value: "Start GitHub connector endpoint"}
public function <GitHubConnectorEndpoint githubConnectorEndpoint> start () {}

@Description {value: "Get GitHub connector endpoint client"}
@Return {value: "GitHubConnector instance"}
public function <GitHubConnectorEndpoint githubConnectorEndpoint> getClient () returns GitHubConnector {
    return githubConnectorEndpoint.githubConnector;
}

@Description {value: "Stop GitHub connector endpoint"}
public function <GitHubConnectorEndpoint githubConnectorEndpoint> stop () {}