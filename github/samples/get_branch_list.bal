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

   // Get Branch list of a given repository
    log:print("githubClient -> getBranchList()");
    int recordCount = 10; // number of records per page
    string repositoryOwner = "MadhurangaWije";
    string repositoryName = "github-connector";
    
    var branchList = githubClient->getBranchList([repositoryOwner, repositoryName], recordCount);
    if (branchList is github:BranchList) {
        log:print(string `Branch List: ${branchList.getAllBranches().length()} found`);
    } else {
        log:printError("Error: "+ branchList.toString());
    }
    
}
