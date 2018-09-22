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

# GitHub client configurations can be setup here. In order to use this client,
# the user will need to have a GitHub Personal Access Token. The token can be obtained by visiting
# `https://github.com/<profile> -> Settings -> Developer Settings -> Personal access tokens` and provide the obtained
# token to the GitHubClientConfig.
# + clientConfig - Client endpoint configurations (CircuitBreaker, throttling, proxy, timeout, etc.)
public type GitHubClientConfig record {
    http:ClientEndpointConfig clientConfig = {};
};

# GitHub client.
# + githubClientConfiguration - GitHub client configurations (Access token, Client endpoint configurations)
# + githubConnector - GitHub connector object
public type Client object {
    public GitHubClientConfig githubClientConfiguration = {};
    public GitHubConnector githubConnector = new;

    # GitHub client endpoint initialization function.
    # + githubClientConfig - GitHub client configuration
    public function init(GitHubClientConfig githubClientConfig);

    # Return the GitHub client.
    # + return - GitHub client
    public function getCallerActions() returns GitHubConnector;

};

function Client::init(GitHubClientConfig githubClientConfig) {

    // Set the target url to the GitHub GraphQL API endpoint
    githubClientConfig.clientConfig.url = GIT_GRAPHQL_API_URL;

    // Initialize the client endpoint with the configurations
    self.githubConnector.githubGraphQlClient.init(githubClientConfig.clientConfig);

    // Set the target url to the GitHub REST API endpoint
    githubClientConfig.clientConfig.url = GIT_REST_API_URL;

    // Initialize the client endpoint with the configurations
    self.githubConnector.githubRestClient.init(githubClientConfig.clientConfig);
}

function Client::getCallerActions() returns GitHubConnector {
    return self.githubConnector;
}
