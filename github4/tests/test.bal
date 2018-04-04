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

package github4;

import ballerina/io;
import ballerina/log;
import ballerina/http;
import ballerina/test;

endpoint GitHubEndpoint githubEP {
    accessToken:getAccessToken(),
    clientEndpointConfiguration: {}
};

@test:Config {
    groups:["network-calls"]
}
function testGetOrganization () {
    //Get a single organization
    log:printInfo("githubEP -> getOrganization()");
    Organization organization = {};
    var organizationData = githubEP -> getOrganization("wso2");
    match organizationData {
        Organization org => {
            organization = org;
        }

        GitConnectorError err => {
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
    Project orgProject = {};
    Organization projectOrganization = {login:"wso2"};
    var projectData = githubEP -> getOrganizationProject(projectOrganization, 1);
    match projectData {
        Project proj => {
            orgProject = proj;
        }

        GitConnectorError err => {
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
    ProjectList projectList = {};
    Organization projectListOrganization = {login:"wso2"};
    var responseProjectList = githubEP ->
                              getOrganizationProjectList(projectListOrganization, GIT_STATE_OPEN, recordCount);
    match responseProjectList {
        ProjectList prjtList => {
            projectList = prjtList;
        }

        GitConnectorError err => {
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
    ProjectList projectList = {};
    Organization projectListOrganization = {login:"wso2"};
    var responseProjectList = githubEP ->
                              getOrganizationProjectList(projectListOrganization, GIT_STATE_OPEN, 2);
    match responseProjectList {
        ProjectList prjtList => {
            projectList = prjtList;
        }

        GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    // Next page
    responseProjectList = githubEP -> getProjectListNextPage(projectList);
    match responseProjectList {
        ProjectList prjtList => {
            projectList = prjtList;
        }

        GitConnectorError err => {
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
    Project columnListProject = {number:1, resourcePath:"/orgs/wso2/projects/1", owner:{}};
    columnListProject.owner.setOwnerType("Organization");
    ColumnList columnList = {};
    var columns = githubEP -> getProjectColumnList(columnListProject, recordCount);
    match columns {
        ColumnList colList => {
            columnList = colList;
        }
        GitConnectorError err => {
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
    Project columnListProject = {number:1, resourcePath:"/orgs/wso2/projects/1", owner:{}};
    columnListProject.owner.setOwnerType("Organization");
    ColumnList columnList = {};
    var columns = githubEP -> getProjectColumnList(columnListProject, recordCount);
    match columns {
        ColumnList colList => {
            columnList = colList;
        }
        GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    Column column = columnList.getAllColumns()[0];
    CardList cardList = column.getCardList();
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
    Project columnListProject = {number:1, resourcePath:"/orgs/wso2/projects/1", owner:{}};
    columnListProject.owner.setOwnerType("Organization");
    ColumnList columnList = {};
    var columns = githubEP -> getProjectColumnList(columnListProject, recordCount);
    match columns {
        ColumnList colList => {
            columnList = colList;
        }
        GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    Column column = columnList.getAllColumns()[0];
    CardList cardList = column.getCardList();
    var cardListNextPage = githubEP -> getCardListNextPage(cardList);
    match cardListNextPage {
        CardList cd => {
            cardList = cd;
        }
        GitConnectorError err => {
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
    Organization repositoryListOrganization = {login:"wso2"};
    RepositoryList repositoryList = {};
    var repoList = githubEP -> getOrganizationRepositoryList(repositoryListOrganization, recordCount);
    match repoList {
        RepositoryList repList => {
            repositoryList = repList;
        }
        GitConnectorError err => {
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
    Organization repositoryListOrganization = {login:"wso2"};
    RepositoryList repositoryList = {};
    var repoList = githubEP -> getOrganizationRepositoryList(repositoryListOrganization, recordCount);
    match repoList {
        RepositoryList repList => {
            repositoryList = repList;
        }
        GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    // Next page
    repoList = githubEP -> getRepositoryListNextPage(repositoryList);
    match repoList {
        RepositoryList repList => {
            repositoryList = repList;
        }

        GitConnectorError err => {
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
    Repository repository = {};
    var repo = githubEP -> getRepository("wso2/product-apim");
    match repo {
        Repository rep => {
            repository = rep;
        }
        GitConnectorError err => {
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
    Repository projectRepository = {owner:{login:"wso2"}, name:"testgrid"};
    Project repositoryProject = {};
    var singleRepoProject = githubEP -> getRepositoryProject(projectRepository, 1);
    match singleRepoProject {
        Project project => {
            repositoryProject = project;
        }
        GitConnectorError err => {
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
    Repository projectRepositoryList = {name:"testgrid", owner:{login:"wso2"}};
    ProjectList repoProjectList = {};
    var responseRepoProjectList = githubEP ->
                                  getRepositoryProjectList(projectRepositoryList, GIT_STATE_OPEN, recordCount);
    match responseRepoProjectList {
        ProjectList prjtList => {
            repoProjectList = prjtList;
        }
        GitConnectorError err => {
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
    Repository projectRepository = {name:"ProLAd-ExpertSystem", owner:{login:"vlgunarathne"}};
    ProjectList repoProjectList = {};
    var responseRepoProjectList = githubEP ->
                                  getRepositoryProjectList(projectRepository, GIT_STATE_OPEN, 1);
    match responseRepoProjectList {
        ProjectList prjtList => {
            repoProjectList = prjtList;
        }
        GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    // Next page
    responseRepoProjectList = githubEP -> getProjectListNextPage(repoProjectList);
    match responseRepoProjectList {
        ProjectList prjList => {
            repoProjectList = prjList;
        }
        GitConnectorError err => {
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
    Repository pullRequestRepository = {owner:{login:"wso2"}, name:"product-is"};
    PullRequestList pullRequestList = {};
    var prList = githubEP -> getPullRequestList(pullRequestRepository, GIT_STATE_OPEN, recordCount);
    match prList {
        PullRequestList pList => {
            pullRequestList = pList;
        }
        GitConnectorError err => {
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
    Repository pullRequestRepository = {owner:{login:"wso2"}, name:"product-is"};
    PullRequestList pullRequestList = {};
    var prList = githubEP -> getPullRequestList(pullRequestRepository, GIT_STATE_OPEN, recordCount);
    match prList {
        PullRequestList pList => {
            pullRequestList = pList;
        }
        GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    // Next page
    prList = githubEP -> getPullRequestListNextPage(pullRequestList);
    match prList {
        PullRequestList pList => {
            pullRequestList = pList;
        }
        GitConnectorError err => {
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
    Repository issueRepository = {owner:{login:"wso2"}, name:"carbon-apimgt"};
    IssueList issueList = {};
    var issues = githubEP -> getIssueList(issueRepository, GIT_STATE_OPEN, recordCount);
    match issues {
        IssueList isList => {
            issueList = isList;
        }
        GitConnectorError err => {
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
    Repository issueRepository = {owner:{login:"wso2"}, name:"carbon-apimgt"};
    IssueList issueList = {};
    var issues = githubEP -> getIssueList(issueRepository, GIT_STATE_OPEN, recordCount);
    match issues {
        IssueList isList => {
            issueList = isList;
        }
        GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    // Next page
    issues = githubEP -> getIssueListNextPage(issueList);
    match issues {
        IssueList isList => {
            issueList = isList;
        }
        GitConnectorError err => {
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
    RepositoryList repositoryList = {};

    test:assertFalse(repositoryList.hasNextPage(), msg = "Failed RepositoryList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testRepositoryListHasPreviousPage () {
    log:printInfo("RepositoryList.hasPreviousPage()");
    RepositoryList repositoryList = {};

    test:assertFalse(repositoryList.hasPreviousPage(), msg = "Failed RepositoryList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testRepositoryListGetAllRepositories () {
    log:printInfo("RepositoryList.getAllRepositories()");
    RepositoryList repositoryList = {};
    Repository[]|null repoArray = repositoryList.getAllRepositories();

    test:assertEquals(typeof repoArray, typeof Repository[], msg = "Failed RepositoryList.getAllRepositories()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testProjectListHasNextPage () {
    log:printInfo("ProjectList.hasNextPage()");
    ProjectList projectList = {};

    test:assertFalse(projectList.hasNextPage(), msg = "Failed ProjectList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testProjectListHasPreviousPage () {
    log:printInfo("ProjectList.hasPreviousPage()");
    ProjectList projectList = {};

    test:assertFalse(projectList.hasPreviousPage(), msg = "Failed ProjectList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testProjectListGetAllProjects () {
    log:printInfo("ProjectList.getAllRepositories()");
    ProjectList projectList = {};
    Project[]|null projectArray = projectList.getAllProjects();

    test:assertEquals(typeof projectArray, typeof Project[], msg = "Failed ProjectList.getAllProjects()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testColumnGetCardList () {
    log:printInfo("Column.getCardList()");
    Column column = {};
    CardList|null cardList = column.getCardList();

    test:assertEquals(typeof cardList, typeof CardList, msg = "Failed Column.getCardList()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testColumnListHasNextPage () {
    log:printInfo("ColumnList.hasNextPage()");
    ColumnList columnList = {};

    test:assertFalse(columnList.hasNextPage(), msg = "Failed ColumnList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testColumnListHasPreviousPage () {
    log:printInfo("ColumnList.hasPreviousPage()");
    ColumnList columnList = {};

    test:assertFalse(columnList.hasPreviousPage(), msg = "Failed ColumnList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testColumnListGetAllColumns () {
    log:printInfo("ColumnList.getAllColumns()");
    ColumnList columnList = {};
    Column[]|null columnArray = columnList.getAllColumns();

    test:assertEquals(typeof columnArray, typeof Column[], msg = "Failed ColumnList.getAllColumns()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testCardListHasNextPage () {
    log:printInfo("CardList.hasNextPage()");
    CardList cardList = {};

    test:assertFalse(cardList.hasNextPage(), msg = "Failed CardList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testCardListHasPreviousPage () {
    log:printInfo("CardList.hasPreviousPage()");
    CardList cardList = {};

    test:assertFalse(cardList.hasPreviousPage(), msg = "Failed CardList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testCardListGetAllCards () {
    log:printInfo("CardList.getAllCards()");
    CardList cardList = {};
    Card[]|null cardArray = cardList.getAllCards();

    test:assertEquals(typeof cardArray, typeof Card[], msg = "Failed CardList.getAllCards()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testPullRequestListHasNextPage () {
    log:printInfo("PullRequestList.hasNextPage()");
    PullRequestList pullRequestList = {};

    test:assertFalse(pullRequestList.hasNextPage(), msg = "Failed PullRequestList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testPullRequestListHasPreviousPage () {
    log:printInfo("PullRequestList.hasPreviousPage()");
    PullRequestList pullRequestList = {};

    test:assertFalse(pullRequestList.hasPreviousPage(), msg = "Failed PullRequestList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testPullRequestListGetAllPullRequests () {
    log:printInfo("PullRequestList.getAllPullRequests()");
    PullRequestList pullRequestList = {};
    PullRequest[]|null pullRequestArray = pullRequestList.getAllPullRequests();

    test:assertEquals(typeof pullRequestArray, typeof PullRequest[],
                      msg = "Failed PullRequestList.getAllPullRequests()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testIssueListHasNextPage () {
    log:printInfo("IssueList.hasNextPage()");
    IssueList issueList = {};

    test:assertFalse(issueList.hasNextPage(), msg = "Failed IssueList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testIssueListHasPreviousPage () {
    log:printInfo("IssueList.hasPreviousPage()");
    IssueList issueList = {};

    test:assertFalse(issueList.hasPreviousPage(), msg = "Failed IssueList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testIssueListGetAllIssues () {
    log:printInfo("IssueList.getAllIssues()");
    IssueList issueList = {};
    Issue[]|null issueArray = issueList.getAllIssues();

    test:assertEquals(typeof issueArray, typeof Issue[], msg = "Failed IssueList.getAllIssues()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testLabelListGetAllLabels () {
    log:printInfo("LabelList.getAllLabels()");
    LabelList labelList = {};
    Label[]|null labelArray = labelList.getAllLabels();

    test:assertEquals(typeof labelArray, typeof Label[], msg = "Failed LabelList.getAllLabels()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testProjectOwnerGetOwnerType () {
    log:printInfo("ProjectOwner.getOwnerType()");
    ProjectOwner projectOwner = {};

    test:assertEquals(typeof projectOwner.getOwnerType(), typeof string, msg = "Failed ProjectOwner.getOwnerType()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testProjectOwnerSetOwnerType () {
    log:printInfo("ProjectOwner.setOwnerType()");
    ProjectOwner projectOwner = {};
    projectOwner.setOwnerType("Organization");
    string ownerType = projectOwner.getOwnerType();

    test:assertEquals(ownerType, "Organization", msg = "Failed ProjectOwner.getOwnerType()");
}