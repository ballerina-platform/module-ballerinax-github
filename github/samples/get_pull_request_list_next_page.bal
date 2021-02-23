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

    //Get a list of pull requests in a repository
    log:print("githubClient -> getPullRequestListNextPage()");
    int recordCount = 1;
    string organizationName = "wso2";
    string repositoryName = "product-is";
    
    github:Repository pullRequestRepository = {owner: {login: organizationName}, name: repositoryName};
    var prList = githubClient->getPullRequestList(pullRequestRepository, github:STATE_CLOSED, recordCount);
    if (prList is github:PullRequestList) {
        // Next page
        prList = githubClient->getPullRequestListNextPage(prList);
        if (prList is github:PullRequestList) {
            log:print(string`PR List Next page: ${prList.getAllPullRequests().length()} Pull Requests Found`);
        } else {
            log:printError("Error: "+ prList.toString());
        }
    } else {
        log:printError("Error: "+ prList.toString());
    }
    
    
}
