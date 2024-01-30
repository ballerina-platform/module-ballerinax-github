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

import ballerina/os;
import ballerinax/github;

configurable string authToken = os:getEnv("ACCESS_TOKEN");

// NOTE: Replace with actual values.
string ballerinaOrg = "ballerina-platform";
string userName = "TEST_USER_NAME";
string userRepoName = "TEST_REPO_NAME";

// GitHub Connection Configurations
github:ConnectionConfig gitHubConfig = {
    auth: {
        token: authToken
    }
};
github:Client github = check new (gitHubConfig);

public function main() returns error? {
    // List all Organization Repositories
    int currentPage = 1;
    github:MinimalRepository[] allOrgRepos = [];

    var fetchRepos = function (int pageNumber) returns boolean|error {
        github:MinimalRepository[] orgRepos = check github->/orgs/[ballerinaOrg]/repos();
        allOrgRepos.push(...orgRepos);
        return orgRepos.length() > 0;
    };

    while (check fetchRepos(currentPage)) {
        currentPage += 1;
    }
    
    // Star all Organization Repositories
    foreach github:MinimalRepository repo in allOrgRepos {
        check github->/user/starred/[userName]/[repo.name].put();
    }
}
