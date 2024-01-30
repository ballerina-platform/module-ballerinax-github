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
int issueNumber = -1;

// GitHub Connection Configurations
github:ConnectionConfig gitHubConfig = {
    auth: {
        token: authToken
    }
};
github:Client github = check new (gitHubConfig);

public function main() returns error? {
    // Create a New Issue
    github:Repo_issues_body createIssueBody = {
        title: "This is a test Issue Title",
        body: "This is test issue body"
    };
    github:Issue issueResp = check github->/repos/[userName]/[userRepoName]/issues.post(createIssueBody);
    issueNumber = issueResp.number;

    // Add Labels to the Issue
    github:Issues_issue_number_body labelIssueBody = {
        labels: ["enhancement", "good-first"]
    };
    github:Issue issueWithLabelResp = check github->/repos/[userName]/[userRepoName]/issues/[issueNumber].patch(labelIssueBody);

    // Assign the Issue to a Usesr
    github:Issues_issue_number_body assignIssueBody = {
        assignees: [userName]
    };
    github:Issue assignedIssueResp = check github->/repos/[userName]/[userRepoName]/issues/[issueNumber].patch(assignIssueBody);
    io:println(assignedIssueResp.toString());
}
