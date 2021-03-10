
// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import ballerina/log;
import ballerinax/github;

github:GitHubConfiguration gitHubConfig = {
    accessToken: "<access token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    // Update a pull request
    log:print("githubClient -> updatePullRequest()");

    github:UpdatePullRequest pullRequestUpdatePayload = {
        title:"This is a pull request made for testing updated",
        base:"master",
        body:"updated pull request body",
        state: "open",
        maintainer_can_modify: false
    };

    string repositoryOwner = "MadhurangaWije";
    string githubConnector = "github-connector";
    int pullNumber = 165;

    var response = githubClient->updatePullRequest(repositoryOwner, githubConnector, pullNumber, pullRequestUpdatePayload);
    if (response is github:PullRequest) {
        log:print("Updated Pull Request: "+ response.toString());
    } else {
        log:printError("Error: "+ response.toString());
    }
}
