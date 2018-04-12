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

documentation { GitHub connector configurations can be setup here. In order to use this connector,
the user will need to have a GitHub Personal Access Token. The token can be obtained by visiting
`https://github.com/<profile> -> Settings -> Developer Settings -> Personal access tokens` and provide the obtained
token to the GitHubClientConfig

    F{{clientEndpointConfiguration}} - Client endpoint configurations (CircuitBreaker, throttling, proxy, timeout, etc.)
}
public type GitHubClientConfig {
        http:ClientEndpointConfig clientEndpointConfiguration = {};
};

documentation { GitHub connector client
    F{{githubClientConfiguration}} - GitHub connector configurations (Access token, Client endpoint configurations)
    F{{githubConnector}} - GitHub connector object
}
public type Client object {
    public {
        GitHubClientConfig githubClientConfiguration = {};
        GitHubConnector githubConnector = new;
    }

    documentation { GitHub connector endpoint initialization function
        P{{githubClientConfig}} - GitHub connector configuration
    }
    public function init (GitHubClientConfig githubClientConfig);

    documentation { Register GitHub connector endpoint
        P{{serviceType}} - Accepts types of data (int, float, string, boolean, etc)
    }
    public function register (typedesc serviceType);

    documentation { Start GitHub connector endpoint}
    public function start ();

    documentation { Return the GitHub connector client
        R{{}} - GitHub connector client
    }
    public function getClient () returns GitHubConnector;

    documentation { Stop GitHub connector client}
    public function stop ();
};

public function Client::init(GitHubClientConfig githubClientConfig) {

    // Set the target url to the GitHub GraphQL API endpoint
    githubClientConfig.clientEndpointConfiguration.targets = [{url:GIT_GRAPHQL_API_URL}];

    // Initialize the client endpoint with the configurations
    self.githubConnector.githubGraphQlClient.init(githubClientConfig.clientEndpointConfiguration);

    // Set the target url to the GitHub REST API endpoint
    githubClientConfig.clientEndpointConfiguration.targets = [{url:GIT_REST_API_URL}];

    // Initialize the client endpoint with the configurations
    self.githubConnector.githubRestClient.init(githubClientConfig.clientEndpointConfiguration);
}

public function Client::register (typedesc serviceType) {}

public function Client::start () {}

public function Client::getClient () returns GitHubConnector {
    return self.githubConnector;
}

public function Client::stop () {}