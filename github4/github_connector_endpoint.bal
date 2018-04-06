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

package github4;

import ballerina/http;

@Description {value: "GitHub connector configurations can be setup here. In order to use this connector,
the user will need to have a GitHub Personal Access Token. The token can be obtained by visiting

https://github.com/<profile> -> Settings -> Developer Settings -> Personal access tokens

and provide the obtained token to the GitHubConnectorConfiguration"}
public type GitHubConnectorConfiguration {
        string accessToken;
        http:ClientEndpointConfiguration clientEndpointConfiguration = {};

};

@Description {value: "GitHub connector endpoint"}
public type GitHubClient object {
    public {
        GitHubConnectorConfiguration githubConnectorConfiguration = {};
        GitHubConnector githubConnector = new;
    }

    public function init (GitHubConnectorConfiguration githubConnectorConfig);
    public function register (typedesc serviceType);
    public function start ();
    public function getClient () returns GitHubConnector;
    public function stop ();
};

@Description {value: "GitHub connector endpoint initialization function"}
@Param {value: "GitHubConnectorConfiguration: GitHub connector configuration"}
public function GitHubClient::init(GitHubConnectorConfiguration githubConnectorConfig) {

    githubConnector = {
                        accessToken : githubConnectorConfig.accessToken,
                        githubClientEndpoint : {}
                      };

    // Set the target url to the GitHub API endpoint
    githubConnectorConfig.clientEndpointConfiguration.targets = [];
    githubConnectorConfig.clientEndpointConfiguration.targets = [{uri:GIT_GRAPHQL_API_URL}];

    // Initialize the client endpoint with the configurations
    githubConnector.githubClientEndpoint.init(githubConnectorConfig.clientEndpointConfiguration);
}

@Description {value: "Register GitHub connector endpoint"}
@Param {value: "typedesc: Accepts types of data (int, float, string, boolean, etc)"}
public function GitHubClient::register (typedesc serviceType) {}

@Description {value: "Start GitHub connector endpoint"}
public function GitHubClient::start () {}

@Description {value: "Get GitHub connector endpoint client"}
@Return {value: "GitHubConnector instance"}
public function GitHubClient::getClient () returns GitHubConnector {
    return githubConnector;
}

@Description {value: "Stop GitHub connector endpoint"}
public function GitHubClient::stop () {}