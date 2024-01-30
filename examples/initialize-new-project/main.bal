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
string collaboratorUserName = "COLLABORATOR_USER_NAME";
string userRepoName = "TEST_REPO_NAME";
string readmeFilePath = "README.md";

// GitHub Connection Configurations
github:ConnectionConfig gitHubConfig = {
    auth: {
        token: authToken
    }
};
github:Client github = check new (gitHubConfig);

public function main() returns error? {
    // Create a New Repository
    github:User_repos_body newRepoBody = {
        name: userRepoName,
        description: "New Repository Description"
    };
    github:Repository newRepository = check github->/user/repos.post(newRepoBody);

    // Commit a README.md file
    github:Contents_path_body newFileBody = {
        message: "Add README.md file",
        content: "This is a test content."
    };
    github:FileCommit fileCommit = check github->/repos/[userName]/[userRepoName]/contents/[readmeFilePath].put(newFileBody);

    // Add a New Collaborator
    github:Collaborators_username_body_1 collaboratorBody = {

    };
    github:RepositoryInvitation repoInvite =
        check github->/repos/[userName]/[userRepoName]/collaborators/[collaboratorUserName].put(collaboratorBody);
    io:println(repoInvite.toString());
}
