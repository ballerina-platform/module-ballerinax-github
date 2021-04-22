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

    //Get a all the repositories of an Organization
    log:print("githubClient -> getRepositoryListNextPage()");
    int recordCount = 10; // results per page.
    string organizationName = "wso2";

    github:Organization repositoryListOrganization = {login: organizationName};
    var repoList = githubClient->getOrganizationRepositoryList(repositoryListOrganization, recordCount);
    if (repoList is github:RepositoryList) {
        log:print(string`Repository List First Page: ${repoList.getAllRepositories().length()} Repositories found`);
        // Next page
        repoList = githubClient->getRepositoryListNextPage(repoList);
        if (repoList is github:RepositoryList) {
            log:print(string`Repository List Next Page: ${repoList.getAllRepositories().length()} Repositories found`);
        } else {
            log:printError("Error: "+repoList.toString());
        }
    } else {
        log:printError("Error: "+repoList.toString());
    }
    
}
