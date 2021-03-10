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

    // Create a pull request
    log:print("githubClient -> createPullRequest()");

    github:CreatePullRequest createPullRequestPayload = {
        title:"Feature4 Implementation",
        head:"feature4",
        base:"master",
        body:"Implementation of feature4"
    };

    string repositoryOwner = "MadhurangaWije";
    string repositoryName = "github-connector";

    var response = githubClient->createPullRequest(repositoryOwner, repositoryName, createPullRequestPayload);
    if (response is github:PullRequest) {
        log:print("Created Pull Request: "+ response.toBalString());
    } else {
        log:printError("Error: "+ response.toBalString());
    }
    
}
