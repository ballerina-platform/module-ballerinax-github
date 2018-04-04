//
// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
//

package tests;

import ballerina/io;
import ballerina/log;
import ballerina/http;
import ballerina/test;
import github4;

endpoint github4:GitHubEndpoint githubEP {
    accessToken:getAccessToken(),
    clientEndpointConfiguration: {}
};

@test:Config {
    groups:["network-calls"]
}
function testGetOrganization () {
    //Get a single organization
    log:printInfo("githubEP -> getOrganization()");
    github4:Organization organization = {};
    var organizationData = githubEP -> getOrganization("wso2");
    match organizationData {
        github4:Organization org => {
            organization = org;
        }

        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }

    test:assertEquals(organization.name, "WSO2", msg = "Failed getOrganization()");
}

@test:Config {
    groups:["network-calls"]
}
function testGetOrganizationProject () {
    // Get an organization project
    log:printInfo("githubEP -> getOrganizationProject()");
    github4:Project orgProject = {};
    github4:Organization projectOrganization = {login:"wso2"};
    var projectData = githubEP -> getOrganizationProject(projectOrganization, 1);
    match projectData {
        github4:Project proj => {
            orgProject = proj;
        }

        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }

    test:assertEquals(orgProject.number, 1, msg = "Failed getOrganizationProject()");
}

@test:Config {
    groups:["network-calls"]
}
function testGetOrganizationProjectList () {
    //Get a list of projects of an organization
    log:printInfo("githubEP -> getOrganizationProjectList()");
    int recordCount = 2;
    github4:ProjectList projectList = {};
    github4:Organization projectListOrganization = {login:"wso2"};
    var responseProjectList = githubEP ->
                              getOrganizationProjectList(projectListOrganization, github4:GIT_STATE_OPEN, recordCount);
    match responseProjectList {
        github4:ProjectList prjtList => {
            projectList = prjtList;
        }

        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    boolean lengthEqualsRecords = lengthof projectList.getAllProjects() == recordCount;

    test:assertTrue(lengthEqualsRecords);
}

@test:Config {
    dependsOn:["testGetOrganizationProjectList"],
    groups:["network-calls"]
}
function testGetOrganizationProjectListNextPage () {
    //Get a list of projects of an organization
    log:printInfo("githubEP -> getOrganizationProjectListNextPage()");
    int recordCount = 2;
    github4:ProjectList projectList = {};
    github4:Organization projectListOrganization = {login:"wso2"};
    var responseProjectList = githubEP ->
                              getOrganizationProjectList(projectListOrganization, github4:GIT_STATE_OPEN, 2);
    match responseProjectList {
        github4:ProjectList prjtList => {
            projectList = prjtList;
        }

        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    // Next page
    responseProjectList = githubEP -> getProjectListNextPage(projectList);
    match responseProjectList {
        github4:ProjectList prjtList => {
            projectList = prjtList;
        }

        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    boolean lengthEqualsRecords = lengthof projectList.getAllProjects() == recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getProjectListNextPage()");
}

@test:Config {
    groups:["network-calls"]
}
function testGetProjectColumnList () {
    //Get project column list
    log:printInfo("githubEP -> getProjectColumnList()");
    int recordCount = 2;
    github4:Project columnListProject = {number:1, resourcePath:"/orgs/wso2/projects/1", owner:{}};
    columnListProject.owner.setOwnerType("Organization");
    github4:ColumnList columnList = {};
    var columns = githubEP -> getProjectColumnList(columnListProject, recordCount);
    match columns {
        github4:ColumnList colList => {
            columnList = colList;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    boolean lengthEqualsRecords = lengthof columnList.getAllColumns() == recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getProjectColumnList()");
}

@test:Config {
    dependsOn:["testGetProjectColumnList"],
    groups:["network-calls"]
}
function testGetCardListOfColumn () {
    //Get column card list
    log:printInfo("column.getCardList()");
    int recordCount = 2;
    github4:Project columnListProject = {number:1, resourcePath:"/orgs/wso2/projects/1", owner:{}};
    columnListProject.owner.setOwnerType("Organization");
    github4:ColumnList columnList = {};
    var columns = githubEP -> getProjectColumnList(columnListProject, recordCount);
    match columns {
        github4:ColumnList colList => {
            columnList = colList;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    github4:Column column = columnList.getAllColumns()[0];
    github4:CardList cardList = column.getCardList();
    boolean lengthEqualsRecords = lengthof cardList.getAllCards() > 0;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getCardList()");
}

@test:Config {
    dependsOn:["testGetCardListOfColumn"],
    groups:["network-calls"]
}
function testGetCardListNextPage () {
    //Get card list next page
    log:printInfo("githubEP -> getCardListNextPage()");
    int recordCount = 2;
    github4:Project columnListProject = {number:1, resourcePath:"/orgs/wso2/projects/1", owner:{}};
    columnListProject.owner.setOwnerType("Organization");
    github4:ColumnList columnList = {};
    var columns = githubEP -> getProjectColumnList(columnListProject, recordCount);
    match columns {
        github4:ColumnList colList => {
            columnList = colList;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    github4:Column column = columnList.getAllColumns()[0];
    github4:CardList cardList = column.getCardList();
    var cardListNextPage = githubEP -> getCardListNextPage(cardList);
    match cardListNextPage {
        github4:CardList cd => {
            cardList = cd;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    boolean lengthEqualsRecords = lengthof cardList.getAllCards() > 0;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getCardListNextPage()");
}

@test:Config {
    groups:["network-calls"]
}
function testGetOrganizationRepositoryList () {
    //Get a all the repositories of Organization
    log:printInfo("githubEP -> getOrganizationRepositoryList()");
    int recordCount = 2;
    github4:Organization repositoryListOrganization = {login:"wso2"};
    github4:RepositoryList repositoryList = {};
    var repoList = githubEP -> getOrganizationRepositoryList(repositoryListOrganization, recordCount);
    match repoList {
        github4:RepositoryList repList => {
            repositoryList = repList;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    boolean lengthEqualsRecords = lengthof repositoryList.getAllRepositories() == recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getOrganizationRepositoryList()");
}

@test:Config {
    dependsOn:["testGetOrganizationRepositoryList"],
    groups:["network-calls"]
}
function testGetOrganizationRepositoryListNextPage () {
    //Get a all the repositories of Organization
    log:printInfo("githubEP -> getRepositoryListNextPage()");
    int recordCount = 2;
    github4:Organization repositoryListOrganization = {login:"wso2"};
    github4:RepositoryList repositoryList = {};
    var repoList = githubEP -> getOrganizationRepositoryList(repositoryListOrganization, recordCount);
    match repoList {
        github4:RepositoryList repList => {
            repositoryList = repList;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    // Next page
    repoList = githubEP -> getRepositoryListNextPage(repositoryList);
    match repoList {
        github4:RepositoryList repList => {
            repositoryList = repList;
        }

        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    boolean lengthEqualsRecords = lengthof repositoryList.getAllRepositories() == recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getRepositoryListNextPage()");
}

@test:Config {
    groups:["network-calls"]
}
function testGetRepository () {
    //Get a single repository
    log:printInfo("githubEP -> getRepository()");
    github4:Repository repository = {};
    var repo = githubEP -> getRepository("wso2/product-apim");
    match repo {
        github4:Repository rep => {
            repository = rep;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }

    test:assertEquals(repository.name, "product-apim", msg = "Failed getRepository()");
}

@test:Config {
    groups:["network-calls"]
}
function testGetRepositoryProject () {
    //Get a Repository Project
    log:printInfo("githubEP -> getRepositoryProject()");
    github4:Repository projectRepository = {owner:{login:"wso2"}, name:"testgrid"};
    github4:Project repositoryProject = {};
    var singleRepoProject = githubEP -> getRepositoryProject(projectRepository, 1);
    match singleRepoProject {
        github4:Project project => {
            repositoryProject = project;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }

    test:assertEquals(repositoryProject.name, "TestGrid", msg = "Failed getRepositoryProject()");
}

@test:Config {
    groups:["network-calls"]
}
function testGetRepositoryProjectList () {
    //Get a list of projects of a repository
    log:printInfo("githubEP -> getRepositoryProjectList()");
    int recordCount = 1;
    github4:Repository projectRepositoryList = {name:"testgrid", owner:{login:"wso2"}};
    github4:ProjectList repoProjectList = {};
    var responseRepoProjectList = githubEP ->
                                  getRepositoryProjectList(projectRepositoryList, github4:GIT_STATE_OPEN, recordCount);
    match responseRepoProjectList {
        github4:ProjectList prjtList => {
            repoProjectList = prjtList;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    boolean lengthEqualsRecords = lengthof repoProjectList.getAllProjects() == recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getRepositoryProjectList()");
}

@test:Config {
    dependsOn:["testGetRepositoryProjectList"],
    groups:["network-calls"]
}
function testGetRepositoryProjectListNextPage () {
    //Get a list of projects of a repository
    log:printInfo("githubEP -> getProjectListNextPage()");
    int recordCount = 1;
    github4:Repository projectRepository = {name:"ProLAd-ExpertSystem", owner:{login:"vlgunarathne"}};
    github4:ProjectList repoProjectList = {};
    var responseRepoProjectList = githubEP ->
                                  getRepositoryProjectList(projectRepository, github4:GIT_STATE_OPEN, 1);
    match responseRepoProjectList {
        github4:ProjectList prjtList => {
            repoProjectList = prjtList;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    // Next page
    responseRepoProjectList = githubEP -> getProjectListNextPage(repoProjectList);
    match responseRepoProjectList {
        github4:ProjectList prjList => {
            repoProjectList = prjList;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    boolean lengthEqualsRecords = lengthof repoProjectList.getAllProjects() == recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getProjectListNextPage()");
}

@test:Config {
    groups:["network-calls"]
}
function testGetPullRequestList () {
    //Get a list of pull requests in a repository
    log:printInfo("githubEP -> getPullRequestList()");
    int recordCount = 2;
    github4:Repository pullRequestRepository = {owner:{login:"wso2"}, name:"product-is"};
    github4:PullRequestList pullRequestList = {};
    var prList = githubEP -> getPullRequestList(pullRequestRepository, github4:GIT_STATE_OPEN, recordCount);
    match prList {
        github4:PullRequestList pList => {
            pullRequestList = pList;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    boolean lengthEqualsRecords = lengthof pullRequestList.getAllPullRequests() == recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getPullRequestList()");
}

@test:Config {
    dependsOn:["testGetPullRequestList"],
    groups:["network-calls"]
}
function testGetPullRequestListNextPage () {
    //Get a list of pull requests in a repository
    log:printInfo("githubEP -> getPullRequestListNextPage()");
    int recordCount = 2;
    github4:Repository pullRequestRepository = {owner:{login:"wso2"}, name:"product-is"};
    github4:PullRequestList pullRequestList = {};
    var prList = githubEP -> getPullRequestList(pullRequestRepository, github4:GIT_STATE_OPEN, recordCount);
    match prList {
        github4:PullRequestList pList => {
            pullRequestList = pList;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    // Next page
    prList = githubEP -> getPullRequestListNextPage(pullRequestList);
    match prList {
        github4:PullRequestList pList => {
            pullRequestList = pList;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    boolean lengthEqualsRecords = lengthof pullRequestList.getAllPullRequests() == recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getPullRequestListNextPage()");
}

@test:Config {
    groups:["network-calls"]
}
function testGetIssueList () {
    //Get a list of issues of a repository
    log:printInfo("githubEP -> getIssueList()");
    int recordCount = 2;
    github4:Repository issueRepository = {owner:{login:"wso2"}, name:"carbon-apimgt"};
    github4:IssueList issueList = {};
    var issues = githubEP -> getIssueList(issueRepository, github4:GIT_STATE_OPEN, recordCount);
    match issues {
        github4:IssueList isList => {
            issueList = isList;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    boolean lengthEqualsRecords = lengthof issueList.getAllIssues() == recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getIssueList()");
}

@test:Config {
    dependsOn:["testGetIssueList"],
    groups:["network-calls"]
}
function testGetIssueListNextPage () {
    //Get a list of issues of a repository
    log:printInfo("githubEP -> getIssueListNextPage()");
    int recordCount = 2;
    github4:Repository issueRepository = {owner:{login:"wso2"}, name:"carbon-apimgt"};
    github4:IssueList issueList = {};
    var issues = githubEP -> getIssueList(issueRepository, github4:GIT_STATE_OPEN, recordCount);
    match issues {
        github4:IssueList isList => {
            issueList = isList;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    // Next page
    issues = githubEP -> getIssueListNextPage(issueList);
    match issues {
        github4:IssueList isList => {
            issueList = isList;
        }
        github4:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    boolean lengthEqualsRecords = lengthof issueList.getAllIssues() == recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getIssueListNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testRepositoryListHasNextPage () {
    log:printInfo("RepositoryList.hasNextPage()");
    github4:RepositoryList repositoryList = {};

    test:assertFalse(repositoryList.hasNextPage(), msg = "Failed RepositoryList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testRepositoryListHasPreviousPage () {
    log:printInfo("RepositoryList.hasPreviousPage()");
    github4:RepositoryList repositoryList = {};

    test:assertFalse(repositoryList.hasPreviousPage(), msg = "Failed RepositoryList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testRepositoryListGetAllRepositories () {
    log:printInfo("RepositoryList.getAllRepositories()");
    github4:RepositoryList repositoryList = {};
    github4:Repository[]|null repoArray = repositoryList.getAllRepositories();

    test:assertEquals(typeof repoArray, typeof github4:Repository[], msg = "Failed RepositoryList.getAllRepositories()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testProjectListHasNextPage () {
    log:printInfo("ProjectList.hasNextPage()");
    github4:ProjectList projectList = {};

    test:assertFalse(projectList.hasNextPage(), msg = "Failed ProjectList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testProjectListHasPreviousPage () {
    log:printInfo("ProjectList.hasPreviousPage()");
    github4:ProjectList projectList = {};

    test:assertFalse(projectList.hasPreviousPage(), msg = "Failed ProjectList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testProjectListGetAllProjects () {
    log:printInfo("ProjectList.getAllRepositories()");
    github4:ProjectList projectList = {};
    github4:Project[]|null projectArray = projectList.getAllProjects();

    test:assertEquals(typeof projectArray, typeof github4:Project[], msg = "Failed ProjectList.getAllProjects()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testColumnGetCardList () {
    log:printInfo("Column.getCardList()");
    github4:Column column = {};
    github4:CardList|null cardList = column.getCardList();

    test:assertEquals(typeof cardList, typeof github4:CardList, msg = "Failed Column.getCardList()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testColumnListHasNextPage () {
    log:printInfo("ColumnList.hasNextPage()");
    github4:ColumnList columnList = {};

    test:assertFalse(columnList.hasNextPage(), msg = "Failed ColumnList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testColumnListHasPreviousPage () {
    log:printInfo("ColumnList.hasPreviousPage()");
    github4:ColumnList columnList = {};

    test:assertFalse(columnList.hasPreviousPage(), msg = "Failed ColumnList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testColumnListGetAllColumns () {
    log:printInfo("ColumnList.getAllColumns()");
    github4:ColumnList columnList = {};
    github4:Column[]|null columnArray = columnList.getAllColumns();

    test:assertEquals(typeof columnArray, typeof github4:Column[], msg = "Failed ColumnList.getAllColumns()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testCardListHasNextPage () {
    log:printInfo("CardList.hasNextPage()");
    github4:CardList cardList = {};

    test:assertFalse(cardList.hasNextPage(), msg = "Failed CardList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testCardListHasPreviousPage () {
    log:printInfo("CardList.hasPreviousPage()");
    github4:CardList cardList = {};

    test:assertFalse(cardList.hasPreviousPage(), msg = "Failed CardList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testCardListGetAllCards () {
    log:printInfo("CardList.getAllCards()");
    github4:CardList cardList = {};
    github4:Card[]|null cardArray = cardList.getAllCards();

    test:assertEquals(typeof cardArray, typeof github4:Card[], msg = "Failed CardList.getAllCards()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testPullRequestListHasNextPage () {
    log:printInfo("PullRequestList.hasNextPage()");
    github4:PullRequestList pullRequestList = {};

    test:assertFalse(pullRequestList.hasNextPage(), msg = "Failed PullRequestList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testPullRequestListHasPreviousPage () {
    log:printInfo("PullRequestList.hasPreviousPage()");
    github4:PullRequestList pullRequestList = {};

    test:assertFalse(pullRequestList.hasPreviousPage(), msg = "Failed PullRequestList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testPullRequestListGetAllPullRequests () {
    log:printInfo("PullRequestList.getAllPullRequests()");
    github4:PullRequestList pullRequestList = {};
    github4:PullRequest[]|null pullRequestArray = pullRequestList.getAllPullRequests();

    test:assertEquals(typeof pullRequestArray, typeof github4:PullRequest[],
                      msg = "Failed PullRequestList.getAllPullRequests()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testIssueListHasNextPage () {
    log:printInfo("IssueList.hasNextPage()");
    github4:IssueList issueList = {};

    test:assertFalse(issueList.hasNextPage(), msg = "Failed IssueList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testIssueListHasPreviousPage () {
    log:printInfo("IssueList.hasPreviousPage()");
    github4:IssueList issueList = {};

    test:assertFalse(issueList.hasPreviousPage(), msg = "Failed IssueList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testIssueListGetAllIssues () {
    log:printInfo("IssueList.getAllIssues()");
    github4:IssueList issueList = {};
    github4:Issue[]|null issueArray = issueList.getAllIssues();

    test:assertEquals(typeof issueArray, typeof github4:Issue[], msg = "Failed IssueList.getAllIssues()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testLabelListGetAllLabels () {
    log:printInfo("LabelList.getAllLabels()");
    github4:LabelList labelList = {};
    github4:Label[]|null labelArray = labelList.getAllLabels();

    test:assertEquals(typeof labelArray, typeof github4:Label[], msg = "Failed LabelList.getAllLabels()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testProjectOwnerGetOwnerType () {
    log:printInfo("ProjectOwner.getOwnerType()");
    github4:ProjectOwner projectOwner = {};

    test:assertEquals(typeof projectOwner.getOwnerType(), typeof string, msg = "Failed ProjectOwner.getOwnerType()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testProjectOwnerSetOwnerType () {
    log:printInfo("ProjectOwner.setOwnerType()");
    github4:ProjectOwner projectOwner = {};
    projectOwner.setOwnerType("Organization");
    string ownerType = projectOwner.getOwnerType();

    test:assertEquals(ownerType, "Organization", msg = "Failed ProjectOwner.getOwnerType()");
}