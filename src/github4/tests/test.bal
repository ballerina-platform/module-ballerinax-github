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

import ballerina/config;
import ballerina/http;
import ballerina/log;
import ballerina/system;
import ballerina/test;

string testOrganizationName = getConfigValue("ORG_NAME");
string testRepositoryName = getConfigValue("REPO_NAME");
string testResourcePath = getConfigValue("RESOURCE_PATH");
string testIssueAssignee = getConfigValue("ASSIGNEE");

GitHubConfiguration gitHubConfig = {
    accessToken: getConfigValue("ACCESS_TOKEN")
};

Client githubClient = new (gitHubConfig);

@test:Config {
    groups: ["network-calls"]
}
function testGetOrganization() {
    //Get a single organization
    log:printInfo("githubClient -> getOrganization()");
    var organizationData = githubClient->getOrganization("wso2");
    if (organizationData is Organization) {
        test:assertEquals(organizationData.name, "WSO2", msg = "Failed getOrganization()");
    } else {
        test:assertFail(msg = <string>organizationData.detail()["message"]);
    }

}

@test:Config {
    groups: ["network-calls"]
}
function testGetOrganizationProject() {
    // Get an organization project
    log:printInfo("githubClient -> getOrganizationProject()");
    Project orgProject = {};
    Organization projectOrganization = {login: testOrganizationName};
    var projectData = githubClient->getOrganizationProject(projectOrganization, 26);
    if (projectData is Project) {
        orgProject = projectData;
    } else {
        test:assertFail(msg = <string>projectData.detail()["message"]);
    }
    test:assertEquals(orgProject.number, 26, msg = "Failed getOrganizationProject()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetOrganizationProjectList() {
    //Get a list of projects of an organization
    log:printInfo("githubClient -> getOrganizationProjectList()");
    int recordCount = 1;
    ProjectList projectList = new;
    Organization projectListOrganization = {login: testOrganizationName};
    var responseProjectList = githubClient->
    getOrganizationProjectList(projectListOrganization, STATE_OPEN, recordCount);
    if (responseProjectList is ProjectList) {
        projectList = responseProjectList;
    } else {
        test:assertFail(msg = <string>responseProjectList.detail()["message"]);
    }
    boolean lengthEqualsRecords = projectList.getAllProjects().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Organization project count of " + testOrganizationName
    + " does not match with " + recordCount.toString());
}

@test:Config {
    dependsOn: ["testGetOrganizationProjectList"],
    groups: ["network-calls"]
}
function testGetOrganizationProjectListNextPage() {
    //Get a list of projects of an organization
    log:printInfo("githubClient -> getOrganizationProjectListNextPage()");
    int recordCount = 1;
    ProjectList projectList = new;
    Organization projectListOrganization = {login: testOrganizationName};
    var responseProjectList = githubClient->
    getOrganizationProjectList(projectListOrganization, STATE_OPEN, 1);
    if (responseProjectList is ProjectList) {
        projectList = responseProjectList;
    } else {
        test:assertFail(msg = <string>responseProjectList.detail()["message"]);
    }
    // Next page
    responseProjectList = githubClient->getProjectListNextPage(projectList);
    if (responseProjectList is ProjectList) {
        projectList = responseProjectList;
    } else {
        test:assertFail(msg = <string>responseProjectList.detail()["message"]);
    }
    boolean lengthEqualsRecords = projectList.getAllProjects().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getProjectListNextPage()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetProjectColumnList() {
    //Get project column list
    log:printInfo("githubClient -> getProjectColumnList()");
    int recordCount = 1;
    Project columnListProject = {number: 1, resourcePath: testResourcePath};
    columnListProject["owner"]["__typename"] = "repository";
    ColumnList columnList = new;
    var columns = githubClient->getProjectColumnList(columnListProject, recordCount);
    if (columns is ColumnList) {
        columnList = columns;
    } else {
        test:assertFail(msg = <string>columns.detail()["message"]);
    }
    boolean lengthEqualsRecords = columnList.getAllColumns().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getProjectColumnList()");
}

@test:Config {
    dependsOn: ["testGetProjectColumnList"],
    groups: ["network-calls"]
}
function testGetCardListOfColumn() {
    //Get column card list
    log:printInfo("Column -> getCardList()");
    int recordCount = 1;
    Project columnListProject = {number: 1, resourcePath: testResourcePath};
    columnListProject["owner"]["__typename"] = "repository";
    ColumnList columnList = new;
    var columns = githubClient->getProjectColumnList(columnListProject, recordCount);
    if (columns is ColumnList) {
        columnList = columns;
    } else {
        test:assertFail(msg = <string>columns.detail()["message"]);
    }
    Column column = columnList.getAllColumns()[0];
    CardList cardList = column.getCardList();
    boolean lengthEqualsRecords = cardList.nodes.length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getCardList()");
}

@test:Config {
    dependsOn: ["testGetCardListOfColumn"],
    groups: ["network-calls"]
}
function testGetCardListNextPage() {
    //Get card list next page
    log:printInfo("githubClient -> getCardListNextPage()");
    int recordCount = 1;
    Project columnListProject = {number: 1, resourcePath: testResourcePath};
    columnListProject.owner.__typename = "repository";
    ColumnList columnList = new;
    var columns = githubClient->getProjectColumnList(columnListProject, recordCount);
    if (columns is ColumnList) {
        columnList = columns;
    } else {
        test:assertFail(msg = <string>columns.detail()["message"]);
    }
    Column column = columnList.getAllColumns()[0];
    CardList cardList = column.getCardList();
    var cardListNextPage = githubClient->getCardListNextPage(cardList);
    if (cardListNextPage is CardList) {
        cardList = cardListNextPage;
    } else {
        test:assertFail(msg = <string>cardListNextPage.detail()["message"]);
    }
    boolean lengthEqualsRecords = cardList.nodes.length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getCardListNextPage()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetOrganizationRepositoryList() {
    //Get a all the repositories of Organization
    log:printInfo("githubClient -> getOrganizationRepositoryList()");
    int recordCount = 1;
    Organization repositoryListOrganization = {login: testOrganizationName};
    RepositoryList repositoryList = new;
    var repoList = githubClient->getOrganizationRepositoryList(repositoryListOrganization, recordCount);
    if (repoList is RepositoryList) {
        repositoryList = repoList;
    } else {
        test:assertFail(msg = <string>repoList.detail()["message"]);
    }
    boolean lengthEqualsRecords = repositoryList.getAllRepositories().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getOrganizationRepositoryList()");
}

@test:Config {
    dependsOn: ["testGetOrganizationRepositoryList"],
    groups: ["network-calls"]
}
function testGetOrganizationRepositoryListNextPage() {
    //Get a all the repositories of Organization
    log:printInfo("githubClient -> getRepositoryListNextPage()");
    int recordCount = 1;
    Organization repositoryListOrganization = {login: testOrganizationName};
    RepositoryList repositoryList = new;
    var repoList = githubClient->getOrganizationRepositoryList(repositoryListOrganization, recordCount);
    if (repoList is RepositoryList) {
        repositoryList = repoList;
    } else {
        test:assertFail(msg = <string>repoList.detail()["message"]);
    }
    // Next page
    repoList = githubClient->getRepositoryListNextPage(repositoryList);
    if (repoList is RepositoryList) {
        repositoryList = repoList;
    } else {
        test:assertFail(msg = <string>repoList.detail()["message"]);
    }
    boolean lengthEqualsRecords = repositoryList.getAllRepositories().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getRepositoryListNextPage()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetRepository() {
    //Get a single repository
    log:printInfo("githubClient -> getRepository()");
    Repository repository = {};
    var repo = githubClient->getRepository("wso2/product-apim");
    if (repo is Repository) {
        repository = repo;
    } else {
        test:assertFail(msg = <string>repo.detail()["message"]);
    }

    test:assertEquals(repository.name, "product-apim", msg = "Failed getRepository()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetRepositoryProject() {
    //Get a Repository Project
    log:printInfo("githubClient -> getRepositoryProject()");
    Repository projectRepository = {owner: {login: "ldclakmal"}, name: "ballerina-github-testing"};
    Project repositoryProject = {};
    var singleRepoProject = githubClient->getRepositoryProject(projectRepository, 1);
    if (singleRepoProject is Project) {
        repositoryProject = singleRepoProject;
    } else {
        test:assertFail(msg = <string>singleRepoProject.detail()["message"]);
    }

    test:assertEquals(repositoryProject.name, "Sample Project 1", msg = "Failed getRepositoryProject()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetRepositoryProjectList() {
    //Get a list of projects of a repository
    log:printInfo("githubClient -> getRepositoryProjectList()");
    int recordCount = 1;
    Repository projectRepositoryList = {owner: {login: "ldclakmal"}, name: "ballerina-github-testing"};
    ProjectList repoProjectList = new;
    var responseRepoProjectList = githubClient->
    getRepositoryProjectList(projectRepositoryList, STATE_OPEN, recordCount);
    if (responseRepoProjectList is ProjectList) {
        repoProjectList = responseRepoProjectList;
    } else {
        test:assertFail(msg = <string>responseRepoProjectList.detail()["message"]);
    }
    boolean lengthEqualsRecords = repoProjectList.getAllProjects().length() == recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Project list count of ldclakmal/ballerina-github-testing does not match with "
    + recordCount.toString());
}

@test:Config {
    dependsOn: ["testGetRepositoryProjectList"],
    groups: ["network-calls"]
}
function testGetRepositoryProjectListNextPage() {
    //Get a list of projects of a repository
    log:printInfo("githubClient -> getProjectListNextPage()");
    int recordCount = 1;
    Repository projectRepository = {owner: {login: "ldclakmal"}, name: "ballerina-github-testing"};
    ProjectList repoProjectList = new;
    var responseRepoProjectList = githubClient->
    getRepositoryProjectList(projectRepository, STATE_OPEN, 1);
    if (responseRepoProjectList is ProjectList) {
        repoProjectList = responseRepoProjectList;
    } else {
        test:assertFail(msg = <string>responseRepoProjectList.detail()["message"]);
    }
    // Next page
    responseRepoProjectList = githubClient->getProjectListNextPage(repoProjectList);
    if (responseRepoProjectList is ProjectList) {
        repoProjectList = responseRepoProjectList;
    } else {
        test:assertFail(msg = <string>responseRepoProjectList.detail()["message"]);
    }
    boolean lengthEqualsRecords = repoProjectList.getAllProjects().length() == recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getProjectListNextPage()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetPullRequestList() {
    //Get a list of pull requests in a repository
    log:printInfo("githubClient -> getPullRequestList()");
    int recordCount = 1;
    Repository pullRequestRepository = {owner: {login: testOrganizationName}, name: testRepositoryName};
    PullRequestList pullRequestList = new;
    var prList = githubClient->getPullRequestList(pullRequestRepository, STATE_CLOSED, recordCount);
    if (prList is PullRequestList) {
        pullRequestList = prList;
    } else {
        test:assertFail(msg = <string>prList.detail()["message"]);
    }
    boolean lengthEqualsRecords = pullRequestList.getAllPullRequests().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getPullRequestList()");
}

@test:Config {
    dependsOn: ["testGetPullRequestList"],
    groups: ["network-calls"]
}
function testGetPullRequestListNextPage() {
    //Get a list of pull requests in a repository
    log:printInfo("githubClient -> getPullRequestListNextPage()");
    int recordCount = 1;
    Repository pullRequestRepository = {owner: {login: testOrganizationName}, name: testRepositoryName};
    PullRequestList pullRequestList = new;
    var prList = githubClient->getPullRequestList(pullRequestRepository, STATE_CLOSED, recordCount);
    if (prList is PullRequestList) {
        pullRequestList = prList;
    } else {
        test:assertFail(msg = <string>prList.detail()["message"]);
    }
    // Next page
    prList = githubClient->getPullRequestListNextPage(pullRequestList);
    if (prList is PullRequestList) {
        pullRequestList = prList;
    } else {
        test:assertFail(msg = <string>prList.detail()["message"]);
    }
    boolean lengthEqualsRecords = pullRequestList.getAllPullRequests().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getPullRequestListNextPage()");
}

@test:Config {
    groups: ["network-calls"]
}
function testGetIssueList() {
    //Get a list of issues of a repository
    log:printInfo("githubClient -> getIssueList()");
    int recordCount = 1;
    Repository issueRepository = {owner: {login: testOrganizationName}, name: testRepositoryName};
    IssueList issueList = new;
    var issues = githubClient->getIssueList(issueRepository, STATE_CLOSED, recordCount);
    if (issues is IssueList) {
        issueList = issues;
    } else {
        test:assertFail(msg = <string>issues.detail()["message"]);
    }
    boolean lengthEqualsRecords = issueList.getAllIssues().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getIssueList()");
}

@test:Config {
    dependsOn: ["testGetIssueList"],
    groups: ["network-calls"]
}
function testGetIssueListNextPage() {
    //Get a list of issues of a repository
    log:printInfo("githubClient -> getIssueListNextPage()");
    int recordCount = 1;
    Repository issueRepository = {owner: {login: testOrganizationName}, name: testRepositoryName};
    IssueList issueList = new;
    var issues = githubClient->getIssueList(issueRepository, STATE_CLOSED, recordCount);
    if (issues is IssueList) {
        issueList = issues;
    } else {
        test:assertFail(msg = <string>issues.detail()["message"]);
    }
    // Next page
    issues = githubClient->getIssueListNextPage(issueList);
    if (issues is IssueList) {
        issueList = issues;
    } else {
        test:assertFail(msg = <string>issues.detail()["message"]);
    }
    boolean lengthEqualsRecords = issueList.getAllIssues().length() >= recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getIssueListNextPage()");
}

@test:Config {
    groups: ["network-calls"]
}
function testCreateIssue() {
    log:printInfo("githubClient -> createIssue()");
    var createdIssue = githubClient->createIssue("ldclakmal", "ballerina-github-testing",
    "This is a test issue", "This is the body of the test issue", ["bug", "critical"], [testIssueAssignee]);
    if (createdIssue is Issue) {
        test:assertEquals(createdIssue.title, "This is a test issue", msg = "Failed createIssue()");
    } else {
        test:assertFail(msg = <string>createdIssue.detail()["message"]);
    }
}

@test:Config {
    groups: ["object-functions"]
}
function testRepositoryListHasNextPage() {
    log:printInfo("RepositoryList -> hasNextPage()");
    RepositoryList repositoryList = new;
    test:assertFalse(repositoryList.hasNextPage(), msg = "Failed RepositoryList.hasNextPage()");
}

@test:Config {
    groups: ["object-functions"]
}
function testRepositoryListHasPreviousPage() {
    log:printInfo("RepositoryList -> hasPreviousPage()");
    RepositoryList repositoryList = new;
    test:assertFalse(repositoryList.hasPreviousPage(), msg = "Failed RepositoryList.hasPreviousPage()");
}

@test:Config {
    groups: ["object-functions"]
}
function testRepositoryListGetAllRepositories() {
    log:printInfo("RepositoryList -> getAllRepositories()");
    RepositoryList repositoryList = new;
    var repoArray = repositoryList.getAllRepositories();
    Repository[] sampleRepoArray = [];
    test:assertEquals(repoArray, sampleRepoArray, msg = "Failed RepositoryList.getAllRepositories()");
}

@test:Config {
    groups: ["object-functions"]
}
function testProjectListHasNextPage() {
    log:printInfo("ProjectList -> hasNextPage()");
    ProjectList projectList = new;
    test:assertFalse(projectList.hasNextPage(), msg = "Failed ProjectList.hasNextPage()");
}

@test:Config {
    groups: ["object-functions"]
}
function testProjectListHasPreviousPage() {
    log:printInfo("ProjectList -> hasPreviousPage()");
    ProjectList projectList = new;
    test:assertFalse(projectList.hasPreviousPage(), msg = "Failed ProjectList.hasPreviousPage()");
}

@test:Config {
    groups: ["object-functions"]
}
function testProjectListGetAllProjects() {
    log:printInfo("ProjectList -> getAllRepositories()");
    ProjectList projectList = new;
    var projectArray = projectList.getAllProjects();
    Project[] sampleProjectArray = [];
    test:assertEquals(projectArray, sampleProjectArray, msg = "Failed ProjectList.getAllProjects()");
}

@test:Config {
    groups: ["object-functions"]
}
function testColumnGetCardList() {
    log:printInfo("Column.getCardList()");
    Column column = new;
    var cardList = column.getCardList();
    CardList sampleCardList = {};
    test:assertEquals(cardList, sampleCardList, msg = "Failed Column.getCardList()");
}

@test:Config {
    groups: ["object-functions"]
}
function testColumnListHasNextPage() {
    log:printInfo("ColumnList -> hasNextPage()");
    ColumnList columnList = new;
    test:assertFalse(columnList.hasNextPage(), msg = "Failed ColumnList.hasNextPage()");
}

@test:Config {
    groups: ["object-functions"]
}
function testColumnListHasPreviousPage() {
    log:printInfo("ColumnList.hasPreviousPage()");
    ColumnList columnList = new;
    test:assertFalse(columnList.hasPreviousPage(), msg = "Failed ColumnList.hasPreviousPage()");
}

@test:Config {
    groups: ["object-functions"]
}
function testColumnListGetAllColumns() {
    log:printInfo("ColumnList -> getAllColumns()");
    ColumnList columnList = new;
    var columnArray = columnList.getAllColumns();
    Column[] sampleColumnArray = [];
    test:assertEquals(columnArray.toString(), sampleColumnArray.toString(), msg = "Failed ColumnList.getAllColumns()");
}

@test:Config {
    groups: ["object-functions"]
}
function testCardListHasNextPage() {
    log:printInfo("CardList -> hasNextPage()");
    CardList cardList = {};
    test:assertFalse(cardList.pageInfo.hasNextPage, msg = "Failed CardList.hasNextPage()");
}

@test:Config {
    groups: ["object-functions"]
}
function testCardListHasPreviousPage() {
    log:printInfo("CardList -> hasPreviousPage()");
    CardList cardList = {};
    test:assertFalse(cardList.pageInfo.hasPreviousPage, msg = "Failed CardList.hasPreviousPage()");
}

@test:Config {
    groups: ["object-functions"]
}
function testCardListGetAllCards() {
    log:printInfo("CardList -> getAllCards()");
    CardList cardList = {};
    var cardArray = cardList.nodes;
    Card[] sampleCardArray = [];
    test:assertEquals(cardArray, sampleCardArray, msg = "Failed CardList.getAllCards()");
}

@test:Config {
    groups: ["object-functions"]
}
function testPullRequestListHasNextPage() {
    log:printInfo("PullRequestList -> hasNextPage()");
    PullRequestList pullRequestList = new;
    test:assertFalse(pullRequestList.hasNextPage(), msg = "Failed PullRequestList.hasNextPage()");
}

@test:Config {
    groups: ["object-functions"]
}
function testPullRequestListHasPreviousPage() {
    log:printInfo("PullRequestList -> hasPreviousPage()");
    PullRequestList pullRequestList = new;
    test:assertFalse(pullRequestList.hasPreviousPage(), msg = "Failed PullRequestList.hasPreviousPage()");
}

@test:Config {
    groups: ["object-functions"]
}
function testPullRequestListGetAllPullRequests() {
    log:printInfo("PullRequestList -> getAllPullRequests()");
    PullRequestList pullRequestList = new;
    var pullRequestArray = pullRequestList.getAllPullRequests();
    PullRequest[] samplePullRequestArray = [];
    test:assertEquals(pullRequestArray, samplePullRequestArray, msg = "Failed PullRequestList.getAllPullRequests()");
}

@test:Config {
    groups: ["object-functions"]
}
function testIssueListHasNextPage() {
    log:printInfo("IssueList -> hasNextPage()");
    IssueList issueList = new;
    test:assertFalse(issueList.hasNextPage(), msg = "Failed IssueList.hasNextPage()");
}

@test:Config {
    groups: ["object-functions"]
}
function testIssueListHasPreviousPage() {
    log:printInfo("IssueList -> hasPreviousPage()");
    IssueList issueList = new;
    test:assertFalse(issueList.hasPreviousPage(), msg = "Failed IssueList.hasPreviousPage()");
}

@test:Config {
    groups: ["object-functions"]
}
function testIssueListGetAllIssues() {
    log:printInfo("IssueList -> getAllIssues()");
    IssueList issueList = new;
    var issueArray = issueList.getAllIssues();
    Issue[] sampleIssueArray = [];
    test:assertEquals(issueArray, sampleIssueArray, msg = "Failed IssueList.getAllIssues()");
}

@test:Config {
    groups: ["object-functions"]
}
function testProjectOwnerGetOwnerType() {
    log:printInfo("ProjectOwner -> getOwnerType()");
    ProjectOwner projectOwner = {};
    test:assertEquals(projectOwner["__typename"], "", msg = "Failed ProjectOwner.getOwnerType()");
}

@test:Config {
    groups: ["object-functions"]
}
function testProjectOwnerSetOwnerType() {
    log:printInfo("ProjectOwner -> setOwnerType()");
    ProjectOwner projectOwner = {};
    projectOwner["__typename"] = "Organization";
    string ownerType = <string>projectOwner["__typename"];
    test:assertEquals(<string>ownerType, "Organization", msg = "Failed ProjectOwner.getOwnerType()");
}

@test:Config {
    groups: ["utility-functions"]
}
function testConstructRequest() {
    log:printInfo("constructRequest()");
    http:Request request = new;
    json samplePayload = {"query": "query body"};
    string sampleToken = "12345";
    string expectedToken = "Bearer " + sampleToken;

    constructRequest(request, samplePayload);
    var value = request.getJsonPayload();
    if (value is error) {
        test:assertFail(msg = <string>value.detail()["message"]);
    } else {
        test:assertEquals(value, samplePayload, msg = "Payload mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
function testGetValidatedResponseSuccess() {
    log:printInfo("getValidatedResponse() successful");
    http:Response sampleHttpResponse = new;

    json samplePayload = {"data": {"org": {"name": "WSO2"}}};
    sampleHttpResponse.setJsonPayload(samplePayload);

    http:Response | error response = sampleHttpResponse;

    json | error validatedResponse = getValidatedResponse(response, "name");

    if (validatedResponse is json) {
        string orgName = validatedResponse.data.org.name.toString();
        test:assertEquals(orgName, "WSO2", msg = "Returned json data mismatch");
    } else {
        test:assertFail(msg = <string>validatedResponse.detail()["message"]);
    }
}

@test:Config {
    groups: ["utility-functions"]
}
function testGetValidatedResponseError() {
    log:printInfo("getValidatedResponse() error payload");

    http:Response sampleHttpResponse = new;

    json samplePayload = {"data": {"org": {"name": ""}}, "errors": [{"message": "API error"}]};
    sampleHttpResponse.setJsonPayload(samplePayload);

    http:Response | error response = sampleHttpResponse;

    json | error validatedResponse = getValidatedResponse(response, "name");

    if (validatedResponse is json) {
        test:assertFail(msg = "Payload error should be handled");
    } else {
        test:assertEquals(<string>validatedResponse.detail()["message"], "API error",
        msg = "Validated response error mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
function testGetValidatedResponseNoRequestedData() {
    log:printInfo("getValidatedResponse() no requested data");

    http:Response sampleHttpResponse = new;

    json samplePayload = {"data": {"org": {}}};
    sampleHttpResponse.setJsonPayload(samplePayload);

    http:Response | error response = sampleHttpResponse;

    json | error validatedResponse = getValidatedResponse(response, "name");

    if (validatedResponse is json) {
        test:assertFail(msg = "Payload error should be handled");
    } else {
        test:assertEquals(<string>validatedResponse.detail()["message"], "name is not available in the response",
        msg = "Validated response error mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
function testGetValidatedResponseNoPayload() {
    log:printInfo("getValidatedResponse() no payload");

    http:Response sampleHttpResponse = new;

    http:Response | error response = sampleHttpResponse;

    json | error validatedResponse = getValidatedResponse(response, "name");

    if (validatedResponse is json) {
        test:assertFail(msg = "Payload error should be handled");
    } else {
        test:assertEquals(<string>validatedResponse.detail()["message"],
        "Entity body is not json compatible since the received content-type is : null",
        msg = "Validated response error mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
function testGetValidatedResponseHttpError() {
    log:printInfo("getValidatedResponse() HttpConnectorError");

    error sampleHttpError = error(GITHUB_ERROR_CODE, message = "HTTP Connector Error.");

    http:Response | error response = sampleHttpError;

    json | error validatedResponse = getValidatedResponse(response, "name");

    if (validatedResponse is json) {
        test:assertFail(msg = "HttpConnector error should be handled");
    } else {
        test:assertEquals(<string>validatedResponse.detail()["message"], "HTTP Connector Error",
        msg = "Validated response error mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
function testGetValidatedRestResponseSuccess() {
    log:printInfo("getValidatedRestResponse() successful");
    http:Response sampleHttpResponse = new;

    json samplePayload = {"title": "Sample title", "number": 150};
    sampleHttpResponse.setJsonPayload(samplePayload);

    http:Response | error response = sampleHttpResponse;

    json | error validatedResponse = getValidatedRestResponse(response);

    if (validatedResponse is json) {
        string orgName = validatedResponse.title.toString();
        test:assertEquals(orgName, "Sample title", msg = "Returned json data mismatch");
    } else {
        test:assertFail(msg = <string>validatedResponse.detail()["message"]);
    }
}

@test:Config {
    groups: ["utility-functions"]
}
function testGetValidatedRestResponseError() {
    log:printInfo("getValidatedRestResponse() error payload");

    http:Response sampleHttpResponse = new ();

    json samplePayload = {"message": "API error"};
    sampleHttpResponse.setJsonPayload(samplePayload);

    http:Response | error response = sampleHttpResponse;
    json | error validatedResponse = getValidatedRestResponse(response);

    if (validatedResponse is json) {
        test:assertFail(msg = "Payload error should be handled");
    } else {
        test:assertEquals(<string>validatedResponse.detail()["message"], "API error",
        msg = "Validated response error mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
function testGetValidatedRestResponseNoPayload() {
    log:printInfo("getValidatedRestResponse() no payload");

    http:Response sampleHttpResponse = new;

    http:Response | error response = sampleHttpResponse;

    json | error validatedResponse = getValidatedRestResponse(response);

    if (validatedResponse is json) {
        test:assertFail(msg = "Payload error should be handled");
    } else {
        test:assertEquals(<string>validatedResponse.detail()["message"],
        "Entity body is not json compatible since the received content-type is : null",
        msg = "Validated response error mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
function testGetValidatedRestResponseHttpError() {
    log:printInfo("getValidatedRestResponse() HttpConnectorError");

    error sampleHttpError = error(GITHUB_ERROR_CODE, message = "HTTP Connector Error.");

    http:Response | error response = sampleHttpError;

    json | error validatedResponse = getValidatedRestResponse(response);

    if (validatedResponse is json) {
        test:assertFail(msg = "HttpConnector error should be handled");
    } else {
        test:assertEquals(<string>validatedResponse.detail()["message"], "HTTP Connector Error",
        msg = "Validated response error mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
function testStringToJsonError() {
    log:printInfo("stringToJson() error");
    string stringJson = "{\"title\":Sample title}";

    var convertedValue = stringToJson(stringJson);
    if (convertedValue is json) {
        test:assertFail(msg = "Invalid string json. Expected failure");
    } else {
        test:assertEquals(<string>convertedValue.detail()["message"],
        "unrecognized token 'Sample' at line: 1 column: 17", msg = "Error message mismatch");
    }
}

@test:Config {
    groups: ["utility-functions"]
}
function testStringToJsonSuccess() {
    log:printInfo("stringToJson() success");
    string stringJson = "{\"title\":\"Sample title\", \"author\":{\"name\":\"Author1\"}}";

    var convertedValue = stringToJson(stringJson);
    if (convertedValue is json) {
        test:assertEquals(convertedValue.title.toString(), "Sample title", msg = "String to Json conversion failed");
        test:assertEquals(convertedValue.author.name.toString(), "Author1", msg = "String to Json conversion failed");
    } else {
        test:assertFail(msg = "stringToJson() returned error");
    }
}

function getConfigValue(string key) returns string {
    return (system:getEnv(key) != "") ? system:getEnv(key) : config:getAsString(key);
}
