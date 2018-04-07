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

import ballerina/http;

@Description {value: "GitHub connector configurations can be setup here. In order to use this connector,
the user will need to have a GitHub Personal Access Token. The token can be obtained by visiting

https://github.com/<profile> -> Settings -> Developer Settings -> Personal access tokens

and provide the obtained token to the GitHubConnectorConfiguration"}
@Field {value: "accessToken: The GitHub API access token"}
@Field {value: "clientEndpointConfiguration: Client endpoint configurations provided by the user"}
public type GitHubConnectorConfiguration {
        string accessToken;
        http:ClientEndpointConfiguration clientEndpointConfiguration = {};

};

@Description {value: "GitHub connector endpoint"}
@Field {value: "githubConnectorConfiguration: GitHub connector configurations
                                                                    (Access token, Client endpoint configurations)"}
@Field {value: "githubConnector: GitHub Connector object"}
public type GitHubClient object {
    public {
        GitHubConnectorConfiguration githubConnectorConfiguration = {};
        GitHubConnector githubConnector = new;
    }

    @Description {value: "GitHub connector endpoint initialization function"}
    @Param {value: "GitHubConnectorConfiguration: GitHub connector configuration"}
    public function init (GitHubConnectorConfiguration githubConnectorConfig);

    @Description {value: "Register GitHub connector endpoint"}
    @Param {value: "typedesc: Accepts types of data (int, float, string, boolean, etc)"}
    public function register (typedesc serviceType);

    @Description {value: "Start GitHub connector endpoint"}
    public function start ();

    @Description {value: "Return the GitHub connector client"}
    @Return {value: "GitHubConnector client"}
    public function getClient () returns GitHubConnector;

    @Description {value: "Stop GitHub connector client"}
    public function stop ();
};

@Description {value: "GitHub connector endpoint initialization function"}
@Param {value: "GitHubConnectorConfiguration: GitHub connector configuration"}
public function GitHubClient::init(GitHubConnectorConfiguration githubConnectorConfig) {

    // Set the access token to the connector from configurations
    githubConnector.accessToken = githubConnectorConfig.accessToken;

    // Set the target url to the GitHub API endpoint
    githubConnectorConfig.clientEndpointConfiguration.targets = [{url:GIT_GRAPHQL_API_URL}];

    // Initialize the client endpoint with the configurations
    githubConnector.githubClientEndpoint.init(githubConnectorConfig.clientEndpointConfiguration);
}

@Description {value: "Register GitHub connector endpoint"}
@Param {value: "typedesc: Accepts types of data (int, float, string, boolean, etc)"}
public function GitHubClient::register (typedesc serviceType) {}

@Description {value: "Start GitHub connector endpoint"}
public function GitHubClient::start () {}

@Description {value: "Return the GitHub connector client"}
@Return {value: "GitHubConnector client"}
public function GitHubClient::getClient () returns GitHubConnector {
    return githubConnector;
}

@Description {value: "Stop GitHub connector client"}
public function GitHubClient::stop () {}