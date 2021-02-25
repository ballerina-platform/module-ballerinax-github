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

import ballerina/http;
import ballerina/log;
import ballerina/test;

configurable string testOrganizationName = ?;
configurable string testRepositoryName = ?;
configurable string testResourcePath = ?;
configurable string testIssueAssignee = ?;
configurable string testUserName = ?;
configurable string accessToken = ?;

GitHubConfiguration gitHubConfig = {
    accessToken: accessToken
};

Client githubClient = new (gitHubConfig);

@test:Config {
    groups: ["network-calls"]
}
function testGetAuthenticatedUser() {
    log:print("githubClient -> getAuthenticatedUser()");
    var response = githubClient->getAuthenticatedUser();
    if (response is User) {
        test:assertEquals(response.login, testUserName, msg = "Failed getAuthenticatedUser()");
    } else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetOrganization() {
    //Get a single organization
    log:print("githubClient -> getOrganization()");
    var organizationData = githubClient->getOrganization("wso2");
    if (organizationData is Organization) {
        test:assertEquals(organizationData.name, "WSO2", msg = "Failed getOrganization()");
    } else {
        test:assertFail(msg = organizationData.message());
    }

}

@test:Config {
    groups: ["network-calls"]
}
function testGetOrganizationProject() {
    // Get an organization project
    log:print("githubClient -> getOrganizationProject()");
    Project orgProject = {};
    Organization projectOrganization = {login: testOrganizationName};
    var projectData = githubClient->getOrganizationProject(projectOrganization, 26);
    if (projectData is Project) {
        orgProject = projectData;
    } else {
        test:assertFail(msg = projectData.message());
    }
    test:assertEquals(orgProject.number, 26, msg = "Failed getOrganizationProject()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetOrganizationProjectList() {
    //Get a list of projects of an organization
    log:print("githubClient -> getOrganizationProjectList()");
    int recordCount = 1;
    ProjectList projectList = new;
    Organization projectListOrganization = {login: testOrganizationName};
    var responseProjectList = githubClient->
    getOrganizationProjectList(projectListOrganization, STATE_OPEN, recordCount);
    if (responseProjectList is ProjectList) {
        projectList = responseProjectList;
    } else {
        test:assertFail(msg = responseProjectList.message());
    }
    boolean lengthEqualsRecords = projectList.getAllProjects().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Organization project count of " + testOrganizationName
         + " does not match with " + recordCount.toString());
}

@test:Config {
    dependsOn: [testGetOrganizationProjectList],
    groups: ["network-calls"]
}
function testGetOrganizationProjectListNextPage() {
    //Get a list of projects of an organization
    log:print("githubClient -> getOrganizationProjectListNextPage()");
    int recordCount = 1;
    ProjectList projectList = new;
    Organization projectListOrganization = {login: testOrganizationName};
    var responseProjectList = githubClient->
    getOrganizationProjectList(projectListOrganization, STATE_OPEN, 1);
    if (responseProjectList is ProjectList) {
        projectList = responseProjectList;
    } else {
        test:assertFail(msg = responseProjectList.message());
    }
    // Next page
    responseProjectList = githubClient->getProjectListNextPage(projectList);
    if (responseProjectList is ProjectList) {
        projectList = responseProjectList;
    } else {
        test:assertFail(msg = <string>responseProjectList.message());
    }
    boolean lengthEqualsRecords = projectList.getAllProjects().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getProjectListNextPage()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetProjectColumnList() {
    //Get project column list
    log:print("githubClient -> getProjectColumnList()");
    int recordCount = 1;
    Project columnListProject = {number: 1, resourcePath: testResourcePath};
    columnListProject["owner"]["__typename"] = "repository";
    ColumnList columnList = new;
    var columns = githubClient->getProjectColumnList(columnListProject, recordCount);
    if (columns is ColumnList) {
        columnList = columns;
    } else {
        test:assertFail(msg = <string>columns.message());
    }
    boolean lengthEqualsRecords = columnList.getAllColumns().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getProjectColumnList()");
}

@test:Config {
    dependsOn: [testGetProjectColumnList],
    groups: ["network-calls"]
}
function testGetCardListOfColumn() {
    //Get column card list
    log:print("Column -> getCardList()");
    int recordCount = 1;
    Project columnListProject = {number: 1, resourcePath: testResourcePath};
    columnListProject["owner"]["__typename"] = "repository";
    ColumnList columnList = new;
    var columns = githubClient->getProjectColumnList(columnListProject, recordCount);
    if (columns is ColumnList) {
        columnList = columns;
    } else {
        test:assertFail(msg = columns.message());
    }
    Column column = columnList.getAllColumns()[0];
    CardList cardList = column.getCardList();
    boolean lengthEqualsRecords = cardList.nodes.length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getCardList()");
}

@test:Config {
    dependsOn: [testGetCardListOfColumn],
    groups: ["network-calls"]
}
function testGetCardListNextPage() {
    //Get card list next page
    log:print("githubClient -> getCardListNextPage()");
    int recordCount = 1;
    Project columnListProject = {number: 1, resourcePath: testResourcePath};
    columnListProject.owner.__typename = "repository";
    ColumnList columnList = new;
    var columns = githubClient->getProjectColumnList(columnListProject, recordCount);
    if (columns is ColumnList) {
        columnList = columns;
    } else {
        test:assertFail(msg = columns.message());
    }
    Column column = columnList.getAllColumns()[0];
    CardList cardList = column.getCardList();
    var cardListNextPage = githubClient->getCardListNextPage(cardList);
    if (cardListNextPage is CardList) {
        cardList = cardListNextPage;
    } else {
        test:assertFail(msg = cardListNextPage.message());
    }
    boolean lengthEqualsRecords = cardList.nodes.length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getCardListNextPage()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetOrganizationRepositoryList() {
    //Get a all the repositories of Organization
    log:print("githubClient -> getOrganizationRepositoryList()");
    int recordCount = 1;
    Organization repositoryListOrganization = {login: testOrganizationName};
    RepositoryList repositoryList = new;
    var repoList = githubClient->getOrganizationRepositoryList(repositoryListOrganization, recordCount);
    if (repoList is RepositoryList) {
        repositoryList = repoList;
    } else {
        test:assertFail(msg = repoList.message());
    }
    boolean lengthEqualsRecords = repositoryList.getAllRepositories().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getOrganizationRepositoryList()");
}

@test:Config {
    dependsOn: [testGetOrganizationRepositoryList],
    groups: ["network-calls"]
}
function testGetOrganizationRepositoryListNextPage() {
    //Get a all the repositories of Organization
    log:print("githubClient -> getRepositoryListNextPage()");
    int recordCount = 1;
    Organization repositoryListOrganization = {login: testOrganizationName};
    RepositoryList repositoryList = new;
    var repoList = githubClient->getOrganizationRepositoryList(repositoryListOrganization, recordCount);
    if (repoList is RepositoryList) {
        repositoryList = repoList;
    } else {
        test:assertFail(msg = repoList.message());
    }
    // Next page
    repoList = githubClient->getRepositoryListNextPage(repositoryList);
    if (repoList is RepositoryList) {
        repositoryList = repoList;
    } else {
        test:assertFail(msg = repoList.message());
    }
    boolean lengthEqualsRecords = repositoryList.getAllRepositories().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getRepositoryListNextPage()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetRepository() {
    //Get a single repository
    log:print("githubClient -> getRepository()");
    Repository repository = {};
    var repo = githubClient->getRepository("wso2/product-apim");
    if (repo is Repository) {
        repository = repo;
    } else {
        test:assertFail(msg = repo.message());
    }

    test:assertEquals(repository.name, "product-apim", msg = "Failed getRepository()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetRepositoryProject() {
    //Get a Repository Project
    log:print("githubClient -> getRepositoryProject()");
    Repository projectRepository = {owner: {login: testIssueAssignee}, name: "github-connector"};
    Project repositoryProject = {};
    var singleRepoProject = githubClient->getRepositoryProject(projectRepository, 1);
    if (singleRepoProject is Project) {
        repositoryProject = singleRepoProject;
    } else {
        test:assertFail(msg = singleRepoProject.message());
    }

    test:assertEquals(repositoryProject.name, "New Project", msg = "Failed getRepositoryProject()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetRepositoryProjectList() {
    //Get a list of projects of a repository
    log:print("githubClient -> getRepositoryProjectList()");
    int recordCount = 1;
    Repository projectRepositoryList = {owner: {login: testIssueAssignee}, name: "github-connector"};
    ProjectList repoProjectList = new;
    var responseRepoProjectList = githubClient->
    getRepositoryProjectList(projectRepositoryList, STATE_OPEN, recordCount);
    if (responseRepoProjectList is ProjectList) {
        repoProjectList = responseRepoProjectList;
    } else {
        test:assertFail(msg = responseRepoProjectList.message());
    }
    boolean lengthEqualsRecords = repoProjectList.getAllProjects().length() == recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Project list count of github-connector does not match with "
    + recordCount.toString());
}

@test:Config {
    dependsOn: [testGetRepositoryProjectList],
    groups: ["network-calls"]
}
function testGetRepositoryProjectListNextPage() {
    //Get a list of projects of a repository
    log:print("githubClient -> getProjectListNextPage()");
    int recordCount = 1;
    Repository projectRepository = {owner: {login: testIssueAssignee}, name: "github-connector"};
    ProjectList repoProjectList = new;
    var responseRepoProjectList = githubClient->
    getRepositoryProjectList(projectRepository, STATE_OPEN, 1);
    if (responseRepoProjectList is ProjectList) {
        repoProjectList = responseRepoProjectList;
    } else {
        test:assertFail(msg = responseRepoProjectList.message());
    }
    // Next page
    responseRepoProjectList = githubClient->getProjectListNextPage(repoProjectList);
    if (responseRepoProjectList is ProjectList) {
        repoProjectList = responseRepoProjectList;
    } else {
        test:assertFail(msg = responseRepoProjectList.message());
    }
    boolean lengthEqualsRecords = repoProjectList.getAllProjects().length() == recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getProjectListNextPage()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetPullRequestList() {
    //Get a list of pull requests in a repository
    log:print("githubClient -> getPullRequestList()");
    int recordCount = 1;
    Repository pullRequestRepository = {owner: {login: testOrganizationName}, name: testRepositoryName};
    PullRequestList pullRequestList = new;
    var prList = githubClient->getPullRequestList(pullRequestRepository, STATE_CLOSED, recordCount);
    if (prList is PullRequestList) {
        pullRequestList = prList;
    } else {
        test:assertFail(msg = prList.message());
    }
    boolean lengthEqualsRecords = pullRequestList.getAllPullRequests().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getPullRequestList()");
}

@test:Config {
    dependsOn: [testGetPullRequestList],
    groups: ["network-calls"]
}
function testGetPullRequestListNextPage() {
    //Get a list of pull requests in a repository
    log:print("githubClient -> getPullRequestListNextPage()");
    int recordCount = 1;
    Repository pullRequestRepository = {owner: {login: testOrganizationName}, name: testRepositoryName};
    PullRequestList pullRequestList = new;
    var prList = githubClient->getPullRequestList(pullRequestRepository, STATE_CLOSED, recordCount);
    if (prList is PullRequestList) {
        pullRequestList = prList;
    } else {
        test:assertFail(msg = prList.message());
    }
    // Next page
    prList = githubClient->getPullRequestListNextPage(pullRequestList);
    if (prList is PullRequestList) {
        pullRequestList = prList;
    } else {
        test:assertFail(msg = prList.message());
    }
    boolean lengthEqualsRecords = pullRequestList.getAllPullRequests().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getPullRequestListNextPage()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetIssueList() {
    //Get a list of issues of a repository
    log:print("githubClient -> getIssueList()");
    int recordCount = 1;

    Repository issueRepository = {owner: {login: testOrganizationName}, name: testRepositoryName};
    IssueList issueList = new;
    var issues = githubClient->getIssueList(issueRepository, STATE_CLOSED, recordCount);
    if (issues is IssueList) {
        issueList = issues;
    } else {
        test:assertFail(msg = issues.message());
    }
    boolean lengthEqualsRecords = issueList.getAllIssues().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getIssueList()");
}

@test:Config {
    dependsOn: [testGetIssueList],
    groups: ["network-calls"]
}
function testGetIssueListNextPage() {
    //Get a list of issues of a repository
    log:print("githubClient -> getIssueListNextPage()");
    int recordCount = 1;
    Repository issueRepository = {owner: {login: testOrganizationName}, name: testRepositoryName};
    IssueList issueList = new;
    var issues = githubClient->getIssueList(issueRepository, STATE_CLOSED, recordCount);
    if (issues is IssueList) {
        issueList = issues;
    } else {
        test:assertFail(msg = issues.message());
    }
    // Next page
    issues = githubClient->getIssueListNextPage(issueList);
    if (issues is IssueList) {
        issueList = issues;
    } else {
        test:assertFail(msg = issues.message());
    }
    boolean lengthEqualsRecords = issueList.getAllIssues().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getIssueListNextPage()");
}

@test:Config {
    groups: ["network-calls"]
}
function testCreateIssue() {
    log:print("githubClient -> createIssue()");
    var createdIssue = githubClient->createIssue(testIssueAssignee, "github-connector",
    "This is a test issue", "This is the body of the test issue", ["bug", "critical"], [testIssueAssignee]);
    if (createdIssue is Issue) {
        test:assertEquals(createdIssue.title, "This is a test issue", msg = "Failed createIssue()");
    } else {
        test:assertFail(msg = createdIssue.message());
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testCreatePullRequest() {
    log:print("githubClient -> createPullRequest()");

    CreatePullRequest createPullRequest = {
        title:"This is a pull request made for testing from feature4 -> master",
        head:"feature4",
        base:"master",
        body:"ksdfiusdhfs sdfbiusdhfus dfounsoud"
    };

    var response = githubClient->createPullRequest("MadhurangaWije", "github-connector",createPullRequest);
    if (response is PullRequest) {
        log:print(response.toBalString());
        test:assertTrue(true);
    } else {
        log:printError(response.toBalString());
        test:assertFail(msg = response.message());
        
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testCreatePullRequestReviewComment() {
    log:print("githubClient -> createPullRequestReviewComment()");

    CreatePullRequestReviewComment createPullRequestReviewComment = {
        body:"This can be improved with better logic!",
        position: 4,
        path:"src/db/main.bal",
        commit_id:"89c0f8fa665f1e55a7dccc70a1bf6ffe83df97e5"
    };

    var response = githubClient->createPullRequestReviewComment("MadhurangaWije", "github-connector", 206, createPullRequestReviewComment);

    if (response is PullRequestReviewComment) {
        log:print(response.toBalString());
        test:assertTrue(true);
    } else {
        log:printError(response.toBalString());
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testDeleteBranch() {
    log:print("githubClient -> deleteBranch()");

    var response = githubClient->deleteBranch("MadhurangaWije", "github-connector", "feature3");
    if (response is error) {
        log:printError(response.detail().toBalString());
        test:assertFail(msg = response.message());
    } else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testCreateGist() {
    log:print("githubClient -> createGist()");

    CreateGist createGist = {
        description: "Hello Gists",
        'public: true,
        gistFiles:[
            {
                fileName:"first_bal_gist.txt",
                content:"Hello sdjf sidf isd fs dfs d fsjd fojsd fsod"
            }
        ]
    };

    var response = githubClient->createGist(createGist);
    if (response is Gist) {
        test:assertTrue(true);
    } else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetOrganizationUserMembership() {
    log:print("githubClient -> getOrganizationUserMembership()");


    var response = githubClient->getOrganizationUserMembership("MyTestOrgBallerina", "MadhurangaWije");
    if (response is OrganizationMembership) {
        test:assertTrue(true);
    } else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetUser() {
    log:print("githubClient -> getUser()");


    var response = githubClient->getUser("MadhurangaWije");
    if (response is User) {
        test:assertTrue(true);
    } else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetIssue() {
    log:print("githubClient -> getIssue()");

    var response = githubClient->getIssue("MadhurangaWije","github-connector",158);
    if (response is IssueFound) {
        test:assertTrue(true);
    } else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testUpdateIssue() {
    log:print("githubClient -> updateIssue()");
    var createdIssue = githubClient->updateIssue(testIssueAssignee, "github-connector",198,
    "This is a test issue", "This is the body of the test issue updated", ["bug", "critical"], [testIssueAssignee], "open");
    if (createdIssue is Issue) {
        test:assertEquals(createdIssue.title, "This is a test issue", msg = "Failed updateIssue()");
    } else {
        test:assertFail(msg = createdIssue.message());
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testUpdatePullRequest() {
    log:print("githubClient -> updatePullRequest()");

    UpdatePullRequest pullRequestUpdate = {
        title:"This is a pull request made for testing updated",
        base:"master",
        body:"ksdfiusdhfs sdfbiusdhfus dfounsoud",
        state: "open",
        maintainer_can_modify: false
    };

    var response = githubClient->updatePullRequest("MadhurangaWije", "github-connector", 165, pullRequestUpdate);
    if (response is PullRequest) {
        log:print(response.toBalString());
        test:assertTrue(true);
    } else {
        log:printError(response.toBalString());
        test:assertFail(msg = response.toBalString());
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testCreatePullRequestReview() {
    log:print("githubClient -> createPullRequestReview()");

    CreatePullRequestReview createPullRequestReview = {
        body:"this is create pr review body. blah blah blah3",
        event:"COMMENT"
    };

    var response = githubClient->createPullRequestReview("MadhurangaWije", "github-connector", 206, createPullRequestReview);
    if (response is PullRequestReview) {
        log:print(response.toBalString());
        test:assertTrue(true);
    } else {
        log:printError(response.toBalString());
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testRepositoryListHasNextPage() {
    log:print("RepositoryList -> hasNextPage()");
    RepositoryList repositoryList = new;
    test:assertFalse(repositoryList.hasNextPage(), msg = "Failed RepositoryList.hasNextPage()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testRepositoryListHasPreviousPage() {
    log:print("RepositoryList -> hasPreviousPage()");
    RepositoryList repositoryList = new;
    test:assertFalse(repositoryList.hasPreviousPage(), msg = "Failed RepositoryList.hasPreviousPage()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testRepositoryListGetAllRepositories() {
    log:print("RepositoryList -> getAllRepositories()");
    RepositoryList repositoryList = new;
    var repoArray = repositoryList.getAllRepositories();
    Repository[] sampleRepoArray = [];
    test:assertEquals(repoArray, sampleRepoArray, msg = "Failed RepositoryList.getAllRepositories()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testProjectListHasNextPage() {
    log:print("ProjectList -> hasNextPage()");
    ProjectList projectList = new;
    test:assertFalse(projectList.hasNextPage(), msg = "Failed ProjectList.hasNextPage()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testProjectListHasPreviousPage() {
    log:print("ProjectList -> hasPreviousPage()");
    ProjectList projectList = new;
    test:assertFalse(projectList.hasPreviousPage(), msg = "Failed ProjectList.hasPreviousPage()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testProjectListGetAllProjects() {
    log:print("ProjectList -> getAllRepositories()");
    ProjectList projectList = new;
    var projectArray = projectList.getAllProjects();
    Project[] sampleProjectArray = [];
    test:assertEquals(projectArray, sampleProjectArray, msg = "Failed ProjectList.getAllProjects()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testColumnGetCardList() {
    log:print("Column.getCardList()");
    Column column = new;
    var cardList = column.getCardList();
    CardList sampleCardList = {};
    test:assertEquals(cardList, sampleCardList, msg = "Failed Column.getCardList()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testColumnListHasNextPage() {
    log:print("ColumnList -> hasNextPage()");
    ColumnList columnList = new;
    test:assertFalse(columnList.hasNextPage(), msg = "Failed ColumnList.hasNextPage()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testColumnListHasPreviousPage() {
    log:print("ColumnList.hasPreviousPage()");
    ColumnList columnList = new;
    test:assertFalse(columnList.hasPreviousPage(), msg = "Failed ColumnList.hasPreviousPage()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testColumnListGetAllColumns() {
    log:print("ColumnList -> getAllColumns()");
    ColumnList columnList = new;
    var columnArray = columnList.getAllColumns();
    Column[] sampleColumnArray = [];
    test:assertEquals(columnArray.toString(), sampleColumnArray.toString(), msg = "Failed ColumnList.getAllColumns()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testCardListHasNextPage() {
    log:print("CardList -> hasNextPage()");
    CardList cardList = {};
    test:assertFalse(cardList.pageInfo.hasNextPage, msg = "Failed CardList.hasNextPage()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testCardListHasPreviousPage() {
    log:print("CardList -> hasPreviousPage()");
    CardList cardList = {};
    test:assertFalse(cardList.pageInfo.hasPreviousPage, msg = "Failed CardList.hasPreviousPage()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testCardListGetAllCards() {
    log:print("CardList -> getAllCards()");
    CardList cardList = {};
    var cardArray = cardList.nodes;
    Card[] sampleCardArray = [];
    test:assertEquals(cardArray, sampleCardArray, msg = "Failed CardList.getAllCards()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testPullRequestListHasNextPage() {
     log:print("PullRequestList -> hasNextPage()");
     PullRequestList pullRequestList = new;
     test:assertFalse(pullRequestList.hasNextPage(), msg = "Failed PullRequestList.hasNextPage()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testPullRequestListHasPreviousPage() {
     log:print("PullRequestList -> hasPreviousPage()");
     PullRequestList pullRequestList = new;
     test:assertFalse(pullRequestList.hasPreviousPage(), msg = "Failed PullRequestList.hasPreviousPage()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testPullRequestListGetAllPullRequests() {
    log:print("PullRequestList -> getAllPullRequests()");
    PullRequestList pullRequestList = new;
    var pullRequestArray = pullRequestList.getAllPullRequests();
    PullRequest[] samplePullRequestArray = [];
    test:assertEquals(pullRequestArray, samplePullRequestArray, msg = "Failed PullRequestList.getAllPullRequests()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testIssueListHasNextPage() {
    log:print("IssueList -> hasNextPage()");
    IssueList issueList = new;
    test:assertFalse(issueList.hasNextPage(), msg = "Failed IssueList.hasNextPage()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testIssueListHasPreviousPage() {
     log:print("IssueList -> hasPreviousPage()");
     IssueList issueList = new;
     test:assertFalse(issueList.hasPreviousPage(), msg = "Failed IssueList.hasPreviousPage()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testIssueListGetAllIssues() {
     log:print("IssueList -> getAllIssues()");
     IssueList issueList = new;
     var issueArray = issueList.getAllIssues();
     Issue[] sampleIssueArray = [];
     test:assertEquals(issueArray, sampleIssueArray, msg = "Failed IssueList.getAllIssues()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testProjectOwnerGetOwnerType() {
     log:print("ProjectOwner -> getOwnerType()");
     ProjectOwner projectOwner = {};
     test:assertEquals(projectOwner["__typename"], "", msg = "Failed ProjectOwner.getOwnerType()");
}

@test:Config {
    groups: ["object-functions"]
}
public isolated function testProjectOwnerSetOwnerType() {
     log:print("ProjectOwner -> setOwnerType()");
     ProjectOwner projectOwner = {};
     projectOwner["__typename"] = "Organization";
     string ownerType = <string>projectOwner["__typename"];
     test:assertEquals(<string>ownerType, "Organization", msg = "Failed ProjectOwner.getOwnerType()");
}

@test:Config {
    groups: ["utility-functions"]
}
public isolated function testConstructRequest() {
    log:print("constructRequest()");
    http:Request request = new;
    json samplePayload = {"query": "query body"};
    string sampleToken = "12345";
    string expectedToken = "Bearer " + sampleToken;

    constructRequest(request, samplePayload);
    var value = request.getJsonPayload();
    if (value is error) {
        test:assertFail(msg = value.message());
    } else {
        test:assertEquals(value, samplePayload, msg = "Payload mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
public isolated function testGetValidatedResponseSuccess() {
    log:print("getValidatedResponse() successful");
    http:Response sampleHttpResponse = new;

    json samplePayload = {"data": {"org": {"name": "WSO2"}}};
    sampleHttpResponse.setJsonPayload(samplePayload);

    http:Response|error response = sampleHttpResponse;

    json|error validatedResponse = getValidatedResponse(response, "name");

    if (validatedResponse is json) {
        json|error responseOrgName = validatedResponse.data.org.name;
        if (responseOrgName is json) {
            string orgName = responseOrgName.toString();
            test:assertEquals(orgName, "WSO2", msg = "Returned json data mismatch");
        }
    } else {
        test:assertFail(msg = validatedResponse.message());
    }
}

@test:Config {
    groups: ["utility-functions"]
}
public isolated function testGetValidatedResponseError() {
    log:print("getValidatedResponse() error payload");

    http:Response sampleHttpResponse = new;

    json samplePayload = {"data": {"org": {"name": ""}}, "errors": [{"message": "API error"}]};
    sampleHttpResponse.setJsonPayload(samplePayload);

    http:Response|error response = sampleHttpResponse;

    json|error validatedResponse = getValidatedResponse(response, "name");

    if (validatedResponse is json) {
        test:assertFail(msg = "Payload error should be handled");
    } else {
        test:assertEquals(validatedResponse.detail()["message"], "API error",
        msg = "Validated response error mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
public isolated function testGetValidatedResponseNoRequestedData() {
    log:print("getValidatedResponse() no requested data");

    http:Response sampleHttpResponse = new;

    json samplePayload = {"data": {"org": {}}};
    sampleHttpResponse.setJsonPayload(samplePayload);

    http:Response|error response = sampleHttpResponse;

    json|error validatedResponse = getValidatedResponse(response, "name");

    if (validatedResponse is json) {
        test:assertFail(msg = "Payload error should be handled");
    } else {
        test:assertEquals(validatedResponse.detail()["message"], "name is not available in the response",
        msg = "Validated response error mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
public isolated function testGetValidatedResponseNoPayload() {
    log:print("getValidatedResponse() no payload");

    http:Response sampleHttpResponse = new;

    http:Response|error response = sampleHttpResponse;

    json|error validatedResponse = getValidatedResponse(response, "name");

    if (validatedResponse is json) {
        test:assertFail(msg = "Payload error should be handled");
    } else {
        test:assertEquals(validatedResponse.detail()["message"],
        "Entity body is not json compatible since the received content-type is : null",
        msg = "Validated response error mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
public isolated function testGetValidatedResponseHttpError() {
    log:print("getValidatedResponse() HttpConnectorError");

    error sampleHttpError = error(GITHUB_ERROR_CODE, message = "HTTP Connector Error.");

    http:Response|error response = sampleHttpError;

    json|error validatedResponse = getValidatedResponse(response, "name");

    if (validatedResponse is json) {
        test:assertFail(msg = "HttpConnector error should be handled");
    } else {
        test:assertEquals(validatedResponse.detail()["message"], "HTTP Connector Error",
        msg = "Validated response error mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
public isolated function testGetValidatedRestResponseSuccess() {
    log:print("getValidatedRestResponse() successful");
    http:Response sampleHttpResponse = new;

    json samplePayload = {"title": "Sample title", "number": 150};
    sampleHttpResponse.setJsonPayload(samplePayload);

    http:Response|error response = sampleHttpResponse;

    json|error validatedResponse = getValidatedRestResponse(response);

    if (validatedResponse is json) {
        json|error responseTitle = validatedResponse.title;
        if (responseTitle is json) {
            string title = responseTitle.toString();
            test:assertEquals(title, "Sample title", msg = "Returned json data mismatch");
        } 
    } else {
        test:assertFail(msg = validatedResponse.message());
    }
}

@test:Config {
    groups: ["utility-functions"]
}
public isolated function testGetValidatedRestResponseError() {
    log:print("getValidatedRestResponse() error payload");

    http:Response sampleHttpResponse = new;

    json samplePayload = {"message": "API error"};
    sampleHttpResponse.setJsonPayload(samplePayload);

    http:Response|error response = sampleHttpResponse;
    json|error validatedResponse = getValidatedRestResponse(response);

    if (validatedResponse is json) {
        test:assertFail(msg = "Payload error should be handled");
    } else {
        test:assertEquals(validatedResponse.detail()["message"], "API error",
        msg = "Validated response error mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
public isolated function testGetValidatedRestResponseNoPayload() {
    log:print("getValidatedRestResponse() no payload");

    http:Response sampleHttpResponse = new;

    http:Response|error response = sampleHttpResponse;

    json|error validatedResponse = getValidatedRestResponse(response);

    if (validatedResponse is json) {
        test:assertFail(msg = "Payload error should be handled");
    } else {
        test:assertEquals(validatedResponse.detail()["message"],
        "Entity body is not json compatible since the received content-type is : null",
        msg = "Validated response error mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
public isolated function testGetValidatedRestResponseHttpError() {
    log:print("getValidatedRestResponse() HttpConnectorError");

    error sampleHttpError = error(GITHUB_ERROR_CODE, message = "HTTP Connector Error.");

    http:Response|error response = sampleHttpError;

    json|error validatedResponse = getValidatedRestResponse(response);

    if (validatedResponse is json) {
        test:assertFail(msg = "HttpConnector error should be handled");
    } else {
        test:assertEquals(validatedResponse.detail()["message"], "HTTP Connector Error",
        msg = "Validated response error mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
public isolated function testStringToJsonError() {
    log:print("stringToJson() error");
    string stringJson = "{\"title\":Sample title}";

    var convertedValue = stringToJson(stringJson);
    if (convertedValue is json) {
        test:assertFail(msg = "Invalid string json. Expected failure");
    } else {
        test:assertEquals(convertedValue.detail()["message"],
        "unrecognized token 'Sample' at line: 1 column: 17", msg = "Error message mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
public isolated function testStringToJsonSuccess() {
    log:print("stringToJson() success");
    string stringJson = "{\"title\":\"Sample title\", \"author\":{\"name\":\"Author1\"}}";

    var convertedValue = stringToJson(stringJson);
    if (convertedValue is json) {
        json|error responseTitle = convertedValue.title;
        json|error responseAuthorName = convertedValue.author.name;
        if ((responseTitle is json) && (responseAuthorName is json)) {
            test:assertEquals(responseTitle.toString(), "Sample title", msg = "String to Json conversion failed");
            test:assertEquals(responseAuthorName.toString(), "Author1", msg = "String to Json conversion failed");
        }  
    } else {
        test:assertFail(msg = "stringToJson() returned error");
    }
}

