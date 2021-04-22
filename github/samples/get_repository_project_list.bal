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

    //Get a list of projects of a repository
    log:print("githubClient -> getRepositoryProjectList()");
    int recordCount = 10;
    string repositoryOwner = "MadhurangaWije";
    string repositoryName = "github-connector";
    
    github:Repository projectRepository = {owner: {login: repositoryOwner}, name: repositoryName};
    var responseRepoProjectList = githubClient->getRepositoryProjectList(projectRepository, github:STATE_OPEN, recordCount);
    if (responseRepoProjectList is github:ProjectList) {
        log:print(string`Project list of the given repository: ${responseRepoProjectList.getAllProjects().length()} Projects found`);
    } else {
        log:printError("Error: "+ responseRepoProjectList.toString());
    }
    
}
