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

    // Create a review comment for a pull request
    log:print("githubClient -> createPullRequestReviewComment()");

    github:PullRequestReviewCommentCreate pullRequestReviewCommentRequestPayload = {
        body:"This can be improved with better logic!",
        position: 4,
        path:"src/db/main.bal",
        commit_id:"89c0f8fa665f1e55a7dccc70a1bf6ffe83df97e5"
    };

    string repositoryOwner = "MadhurangaWije";
    string repositoryName = "github-connector";
    int pullRequestNumber = 206;

    var response = githubClient->createPullRequestReviewComment(repositoryOwner, repositoryName, pullRequestNumber, pullRequestReviewCommentRequestPayload);

    if (response is github:PullRequestReviewComment) {
        log:print("Pull Request Review Comment: "+response.toBalString());
    } else {
        log:printError("Error: "+ response.toBalString());
    }
    
}
