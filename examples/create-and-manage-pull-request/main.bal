// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.org).
//
// WSO2 LLC. licenses this file to you under the Apache License,
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

import ballerina/io;
import ballerina/os;
import ballerinax/github;

configurable string authToken = os:getEnv("ACCESS_TOKEN");

// NOTE: Replace with actual values.
string userName = "TEST_USER_NAME";
string userRepoName = "TEST_REPO_NAME";
int prNumber = -1;

// GitHub Connection Configurations
github:ConnectionConfig gitHubConfig = {
    auth: {
        token: authToken
    }
};
github:Client github = check new (gitHubConfig);

public function main() returns error? {
    // Create a New Pull Request
    github:Repo_pulls_body createPRBody = {
        title: "Test PR",
        base: "main",
        head: "feature/feature2",
        body: "This is some dummy content for PR body"
    };
    github:PullRequest createdPRResponse = check github->/repos/[userName]/[userRepoName]/pulls.post(createPRBody);
    prNumber = createdPRResponse.number;

    // Add a Change Request
    github:Pull_number_reviews_body changeReqBody = {
        body: "This is a test review comment to request changes.",
        event: "REQUEST_CHANGES"
    };

    github:PullRequestReview reviewResponse =
        check github->/repos/[userName]/[userRepoName]/pulls/[prNumber]/reviews.post(changeReqBody);
    io:println(reviewResponse.toString());
}
