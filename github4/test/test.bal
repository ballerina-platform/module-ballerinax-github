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

import ballerina/config;
import ballerina/http;
import ballerina/log;
import ballerina/test;

endpoint Client githubClient {
    clientEndpointConfiguration: {
        auth:{
            scheme:"oauth",
            accessToken:config:getAsString("GITHUB_TOKEN")
        }
    }
};

@test:Config {
    groups:["network-calls"]
}
function testGetOrganization () {
    //Get a single organization
    log:printInfo("githubClient -> getOrganization()");
    Organization organization = {};
    var organizationData = githubClient -> getOrganization("wso2");
    match organizationData {
        Organization org => {
            organization = org;
        }

        GitClientError err => {
            test:assertFail(msg = err.message);
        }
    }

    test:assertEquals(organization.name, "WSO2", msg = "Failed getOrganization()");
}

@test:Config {
    groups:["network-calls"]
}
function testGetOrganizationProject () {
    // Get an organization project
    log:printInfo("githubClient -> getOrganizationProject()");
    Project orgProject = {};
    Organization projectOrganization = {login:"wso2"};
    var projectData = githubClient -> getOrganizationProject(projectOrganization, 1);
    match projectData {
        Project proj => {
            orgProject = proj;
        }

        GitClientError err => {
            test:assertFail(msg = err.message);
        }
    }

    test:assertEquals(orgProject.number, 1, msg = "Failed getOrganizationProject()");
}

@test:Config {
    groups:["network-calls"]
}
function testGetOrganizationProjectList () {
    //Get a list of projects of an organization
    log:printInfo("githubClient -> getOrganizationProjectList()");
    int recordCount = 2;
    ProjectList projectList = new;
    Organization projectListOrganization = {login:"wso2"};
    var responseProjectList = githubClient ->
                              getOrganizationProjectList(projectListOrganization, STATE_OPEN, recordCount);
    match responseProjectList {
        ProjectList prjtList => {
            projectList = prjtList;
        }

        GitClientError err => {
            test:assertFail(msg = err.message);
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
    log:printInfo("githubClient -> getOrganizationProjectListNextPage()");
    int recordCount = 2;
    ProjectList projectList = new;
    Organization projectListOrganization = {login:"wso2"};
    var responseProjectList = githubClient ->
                              getOrganizationProjectList(projectListOrganization, STATE_OPEN, 2);
    match responseProjectList {
        ProjectList prjtList => {
            projectList = prjtList;
        }

        GitClientError err => {
            test:assertFail(msg = err.message);
        }
    }
    // Next page
    responseProjectList = githubClient -> getProjectListNextPage(projectList);
    match responseProjectList {
        ProjectList prjtList => {
            projectList = prjtList;
        }

        GitClientError err => {
            test:assertFail(msg = err.message);
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
    log:printInfo("githubClient -> getProjectColumnList()");
    int recordCount = 2;
    Project columnListProject = {number:1, resourcePath:"/orgs/wso2/projects/1"};
    columnListProject.owner.setOwnerType("Organization");
    ColumnList columnList = new;
    var columns = githubClient -> getProjectColumnList(columnListProject, recordCount);
    match columns {
        ColumnList colList => {
            columnList = colList;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
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
    Project columnListProject = {number:1, resourcePath:"/orgs/wso2/projects/1"};
    columnListProject.owner.setOwnerType("Organization");
    ColumnList columnList = new;
    var columns = githubClient -> getProjectColumnList(columnListProject, recordCount);
    match columns {
        ColumnList colList => {
            columnList = colList;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
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
    log:printInfo("githubClient -> getCardListNextPage()");
    int recordCount = 2;
    Project columnListProject = {number:1, resourcePath:"/orgs/wso2/projects/1"};
    columnListProject.owner.setOwnerType("Organization");
    ColumnList columnList = new;
    var columns = githubClient -> getProjectColumnList(columnListProject, recordCount);
    match columns {
        ColumnList colList => {
            columnList = colList;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
        }
    }
    Column column = columnList.getAllColumns()[0];
    CardList cardList = column.getCardList();
    var cardListNextPage = githubClient -> getCardListNextPage(cardList);
    match cardListNextPage {
        CardList cd => {
            cardList = cd;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
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
    log:printInfo("githubClient -> getOrganizationRepositoryList()");
    int recordCount = 2;
    Organization repositoryListOrganization = {login:"wso2"};
    RepositoryList repositoryList = new;
    var repoList = githubClient -> getOrganizationRepositoryList(repositoryListOrganization, recordCount);
    match repoList {
        RepositoryList repList => {
            repositoryList = repList;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
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
    log:printInfo("githubClient -> getRepositoryListNextPage()");
    int recordCount = 2;
    Organization repositoryListOrganization = {login:"wso2"};
    RepositoryList repositoryList = new;
    var repoList = githubClient -> getOrganizationRepositoryList(repositoryListOrganization, recordCount);
    match repoList {
        RepositoryList repList => {
            repositoryList = repList;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
        }
    }
    // Next page
    repoList = githubClient -> getRepositoryListNextPage(repositoryList);
    match repoList {
        RepositoryList repList => {
            repositoryList = repList;
        }

        GitClientError err => {
            test:assertFail(msg = err.message);
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
    log:printInfo("githubClient -> getRepository()");
    Repository repository = {};
    var repo = githubClient -> getRepository("wso2/product-apim");
    match repo {
        Repository rep => {
            repository = rep;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
        }
    }

    test:assertEquals(repository.name, "product-apim", msg = "Failed getRepository()");
}

@test:Config {
    groups:["network-calls"]
}
function testGetRepositoryProject () {
    //Get a Repository Project
    log:printInfo("githubClient -> getRepositoryProject()");
    Repository projectRepository = {owner:{login:"wso2"}, name:"testgrid"};
    Project repositoryProject = {};
    var singleRepoProject = githubClient -> getRepositoryProject(projectRepository, 1);
    match singleRepoProject {
        Project project => {
            repositoryProject = project;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
        }
    }

    test:assertEquals(repositoryProject.name, "TestGrid", msg = "Failed getRepositoryProject()");
}

@test:Config {
    groups:["network-calls"]
}
function testGetRepositoryProjectList () {
    //Get a list of projects of a repository
    log:printInfo("githubClient -> getRepositoryProjectList()");
    int recordCount = 1;
    Repository projectRepositoryList = {name:"testgrid", owner:{login:"wso2"}};
    ProjectList repoProjectList = new;
    var responseRepoProjectList = githubClient ->
                                  getRepositoryProjectList(projectRepositoryList, STATE_OPEN, recordCount);
    match responseRepoProjectList {
        ProjectList prjtList => {
            repoProjectList = prjtList;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
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
    log:printInfo("githubClient -> getProjectListNextPage()");
    int recordCount = 1;
    Repository projectRepository = {name:"ProLAd-ExpertSystem", owner:{login:"vlgunarathne"}};
    ProjectList repoProjectList = new;
    var responseRepoProjectList = githubClient ->
                                  getRepositoryProjectList(projectRepository, STATE_OPEN, 1);
    match responseRepoProjectList {
        ProjectList prjtList => {
            repoProjectList = prjtList;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
        }
    }
    // Next page
    responseRepoProjectList = githubClient -> getProjectListNextPage(repoProjectList);
    match responseRepoProjectList {
        ProjectList prjList => {
            repoProjectList = prjList;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
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
    log:printInfo("githubClient -> getPullRequestList()");
    int recordCount = 2;
    Repository pullRequestRepository = {owner:{login:"wso2"}, name:"product-is"};
    PullRequestList pullRequestList = new;
    var prList = githubClient -> getPullRequestList(pullRequestRepository, STATE_CLOSED, recordCount);
    match prList {
        PullRequestList pList => {
            pullRequestList = pList;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
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
    log:printInfo("githubClient -> getPullRequestListNextPage()");
    int recordCount = 2;
    Repository pullRequestRepository = {owner:{login:"wso2"}, name:"product-is"};
    PullRequestList pullRequestList = new;
    var prList = githubClient -> getPullRequestList(pullRequestRepository, STATE_CLOSED, recordCount);
    match prList {
        PullRequestList pList => {
            pullRequestList = pList;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
        }
    }
    // Next page
    prList = githubClient -> getPullRequestListNextPage(pullRequestList);
    match prList {
        PullRequestList pList => {
            pullRequestList = pList;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
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
    log:printInfo("githubClient -> getIssueList()");
    int recordCount = 2;
    Repository issueRepository = {owner:{login:"wso2"}, name:"carbon-apimgt"};
    IssueList issueList = new;
    var issues = githubClient -> getIssueList(issueRepository, STATE_CLOSED, recordCount);
    match issues {
        IssueList isList => {
            issueList = isList;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
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
    log:printInfo("githubClient -> getIssueListNextPage()");
    int recordCount = 2;
    Repository issueRepository = {owner:{login:"wso2"}, name:"carbon-apimgt"};
    IssueList issueList = new;
    var issues = githubClient -> getIssueList(issueRepository, STATE_CLOSED, recordCount);
    match issues {
        IssueList isList => {
            issueList = isList;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
        }
    }
    // Next page
    issues = githubClient -> getIssueListNextPage(issueList);
    match issues {
        IssueList isList => {
            issueList = isList;
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
        }
    }
    boolean lengthEqualsRecords = lengthof issueList.getAllIssues() == recordCount;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getIssueListNextPage()");
}

@test:Config {
    groups:["network-calls"]
}
function testCreateIssue () {
    log:printInfo("githubClient -> createIssue()");

    var createdIssue = githubClient -> createIssue ("vlgunarathne", "ballerina-connector-test" ,
                "This is a test issue", "This is the body of the test issue", ["bug", "critical"], ["vlgunarathne"]);

    match createdIssue {
        Issue issue => {
            test:assertEquals(issue.title, "This is a test issue", msg = "Failed createIssue()");
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
        }
    }
}

@test:Config {
    groups:["object-functions"]
}
function testRepositoryListHasNextPage () {
    log:printInfo("RepositoryList.hasNextPage()");
    RepositoryList repositoryList = new;

    test:assertFalse(repositoryList.hasNextPage(), msg = "Failed RepositoryList.hasNextPage()");
}

@test:Config {
    groups:["object-functions"]
}
function testRepositoryListHasPreviousPage () {
    log:printInfo("RepositoryList.hasPreviousPage()");
    RepositoryList repositoryList = new;

    test:assertFalse(repositoryList.hasPreviousPage(), msg = "Failed RepositoryList.hasPreviousPage()");
}

@test:Config {
    groups:["object-functions"]
}
function testRepositoryListGetAllRepositories () {
    log:printInfo("RepositoryList.getAllRepositories()");
    RepositoryList repositoryList = new;
    var repoArray = repositoryList.getAllRepositories();
    Repository[] sampleRepoArray;
    test:assertEquals(repoArray, sampleRepoArray, msg = "Failed RepositoryList.getAllRepositories()");
}

@test:Config {
    groups:["object-functions"]
}
function testProjectListHasNextPage () {
    log:printInfo("ProjectList.hasNextPage()");
    ProjectList projectList = new;

    test:assertFalse(projectList.hasNextPage(), msg = "Failed ProjectList.hasNextPage()");
}

@test:Config {
    groups:["object-functions"]
}
function testProjectListHasPreviousPage () {
    log:printInfo("ProjectList.hasPreviousPage()");
    ProjectList projectList = new;

    test:assertFalse(projectList.hasPreviousPage(), msg = "Failed ProjectList.hasPreviousPage()");
}

@test:Config {
    groups:["object-functions"]
}
function testProjectListGetAllProjects () {
    log:printInfo("ProjectList.getAllRepositories()");
    ProjectList projectList = new;
    var projectArray = projectList.getAllProjects();
    Project[] sampleProjectArray;
    test:assertEquals(projectArray, sampleProjectArray, msg = "Failed ProjectList.getAllProjects()");
}

@test:Config {
    groups:["object-functions"]
}
function testColumnGetCardList () {
    log:printInfo("Column.getCardList()");
    Column column = new;
    var cardList = column.getCardList();
    CardList sampleCardList = new;
    test:assertEquals(cardList, sampleCardList, msg = "Failed Column.getCardList()");
}

@test:Config {
    groups:["object-functions"]
}
function testColumnListHasNextPage () {
    log:printInfo("ColumnList.hasNextPage()");
    ColumnList columnList = new;

    test:assertFalse(columnList.hasNextPage(), msg = "Failed ColumnList.hasNextPage()");
}

@test:Config {
    groups:["object-functions"]
}
function testColumnListHasPreviousPage () {
    log:printInfo("ColumnList.hasPreviousPage()");
    ColumnList columnList = new;

    test:assertFalse(columnList.hasPreviousPage(), msg = "Failed ColumnList.hasPreviousPage()");
}

@test:Config {
    groups:["object-functions"]
}
function testColumnListGetAllColumns () {
    log:printInfo("ColumnList.getAllColumns()");
    ColumnList columnList = new;
    var columnArray = columnList.getAllColumns();
    Column[] sampleColumnArray;
    test:assertEquals(columnArray, sampleColumnArray, msg = "Failed ColumnList.getAllColumns()");
}

@test:Config {
    groups:["object-functions"]
}
function testCardListHasNextPage () {
    log:printInfo("CardList.hasNextPage()");
    CardList cardList = new;

    test:assertFalse(cardList.hasNextPage(), msg = "Failed CardList.hasNextPage()");
}

@test:Config {
    groups:["object-functions"]
}
function testCardListHasPreviousPage () {
    log:printInfo("CardList.hasPreviousPage()");
    CardList cardList = new;

    test:assertFalse(cardList.hasPreviousPage(), msg = "Failed CardList.hasPreviousPage()");
}

@test:Config {
    groups:["object-functions"]
}
function testCardListGetAllCards () {
    log:printInfo("CardList.getAllCards()");
    CardList cardList = new;
    var cardArray = cardList.getAllCards();
    Card[] sampleCardArray;
    test:assertEquals(cardArray, sampleCardArray, msg = "Failed CardList.getAllCards()");
}

@test:Config {
    groups:["object-functions"]
}
function testPullRequestListHasNextPage () {
    log:printInfo("PullRequestList.hasNextPage()");
    PullRequestList pullRequestList = new;

    test:assertFalse(pullRequestList.hasNextPage(), msg = "Failed PullRequestList.hasNextPage()");
}

@test:Config {
    groups:["object-functions"]
}
function testPullRequestListHasPreviousPage () {
    log:printInfo("PullRequestList.hasPreviousPage()");
    PullRequestList pullRequestList = new;

    test:assertFalse(pullRequestList.hasPreviousPage(), msg = "Failed PullRequestList.hasPreviousPage()");
}

@test:Config {
    groups:["object-functions"]
}
function testPullRequestListGetAllPullRequests () {
    log:printInfo("PullRequestList.getAllPullRequests()");
    PullRequestList pullRequestList = new;
    var pullRequestArray = pullRequestList.getAllPullRequests();
    PullRequest[] samplePullRequestArray;
    test:assertEquals(pullRequestArray, samplePullRequestArray, msg = "Failed PullRequestList.getAllPullRequests()");
}

@test:Config {
    groups:["object-functions"]
}
function testIssueListHasNextPage () {
    log:printInfo("IssueList.hasNextPage()");
    IssueList issueList = new;

    test:assertFalse(issueList.hasNextPage(), msg = "Failed IssueList.hasNextPage()");
}

@test:Config {
    groups:["object-functions"]
}
function testIssueListHasPreviousPage () {
    log:printInfo("IssueList.hasPreviousPage()");
    IssueList issueList = new;

    test:assertFalse(issueList.hasPreviousPage(), msg = "Failed IssueList.hasPreviousPage()");
}

@test:Config {
    groups:["object-functions"]
}
function testIssueListGetAllIssues () {
    log:printInfo("IssueList.getAllIssues()");
    IssueList issueList = new;
    var issueArray = issueList.getAllIssues();
    Issue[] sampleIssueArray;
    test:assertEquals(issueArray, sampleIssueArray, msg = "Failed IssueList.getAllIssues()");
}

@test:Config {
    groups:["object-functions"]
}
function testProjectOwnerGetOwnerType () {
    log:printInfo("ProjectOwner.getOwnerType()");
    ProjectOwner projectOwner = new;
    test:assertEquals(projectOwner.getOwnerType(), "", msg = "Failed ProjectOwner.getOwnerType()");
}

@test:Config {
    groups:["object-functions"]
}
function testProjectOwnerSetOwnerType () {
    log:printInfo("ProjectOwner.setOwnerType()");
    ProjectOwner projectOwner = new;
    projectOwner.setOwnerType("Organization");
    string ownerType = projectOwner.getOwnerType();

    test:assertEquals(ownerType, "Organization", msg = "Failed ProjectOwner.getOwnerType()");
}

@test:Config {
    groups:["utility-functions"]
}
function testConstructRequest () {
    log:printInfo("constructRequest()");
    http:Request request = new;
    json samplePayload = {"query":"query body"};
    string sampleToken = "12345";
    string expectedToken = "Bearer " + sampleToken;

    constructRequest(request, samplePayload);

    json payloadInRequest = check request.getJsonPayload();
    test:assertEquals(payloadInRequest, samplePayload, msg = "Payload mismatch");
}

@test:Config {
    groups:["utility-functions"]
}
function testGetValidatedResponseSuccess () {
    log:printInfo("getValidatedResponse() successful");
    http:Response sampleHttpResponse = new;

    json samplePayload = {"data":{"org":{"name":"WSO2"}}};
    sampleHttpResponse.setJsonPayload(samplePayload);

    http:Response|error response = sampleHttpResponse;

    json|GitClientError validatedResponse = getValidatedResponse(response, "name");

    match validatedResponse {
        json jsonResponse => {
            string orgName = jsonResponse.data.org.name.toString();
            test:assertEquals(orgName, "WSO2", msg = "Returned json data mismatch");
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
        }
    }
}

@test:Config {
    groups:["utility-functions"]
}
function testGetValidatedResponseError () {
    log:printInfo("getValidatedResponse() error payload");

    http:Response sampleHttpResponse = new;

    json samplePayload = {"data":{"org":{"name":""}}, "errors":[{"message":"API error"}]};
    sampleHttpResponse.setJsonPayload(samplePayload);

    http:Response|error response = sampleHttpResponse;

    json|GitClientError validatedResponse = getValidatedResponse(response, "name");

    match validatedResponse {
        json jsonResponse => {
            test:assertFail(msg = "Payload error should be handled");
        }
        GitClientError err => {
            test:assertEquals(err.message, "API error", msg = "Validated response error mismatch");
        }
    }
}

@test:Config {
    groups:["utility-functions"]
}
function testGetValidatedResponseNoRequestedData () {
    log:printInfo("getValidatedResponse() no requested data");

    http:Response sampleHttpResponse = new;

    json samplePayload = {"data":{"org":{}}};
    sampleHttpResponse.setJsonPayload(samplePayload);

    http:Response|error response = sampleHttpResponse;

    json|GitClientError validatedResponse = getValidatedResponse(response, "name");

    match validatedResponse {
        json jsonResponse => {
            test:assertFail(msg = "Payload error should be handled");
        }
        GitClientError err => {
            test:assertEquals(err.message, "name is not available in the response",
                                                                        msg = "Validated response error mismatch");
        }
    }
}

@test:Config {
    groups:["utility-functions"]
}
function testGetValidatedResponseNoPayload () {
    log:printInfo("getValidatedResponse() no payload");

    http:Response sampleHttpResponse = new;

    http:Response|error response = sampleHttpResponse;

    json|GitClientError validatedResponse = getValidatedResponse(response, "name");

    match validatedResponse {
        json jsonResponse => {
            test:assertFail(msg = "Payload error should be handled");
        }
        GitClientError err => {
            test:assertEquals(err.message,
                "Entity body is not json compatible since the received content-type is : null",
                msg = "Validated response error mismatch");
        }
    }
}

@test:Config {
    groups:["utility-functions"]
}
function testGetValidatedResponseHttpError () {
    log:printInfo("getValidatedResponse() HttpConnectorError");

    error sampleHttpError = {};
    sampleHttpError.message = "HTTP Connector Error";

    http:Response|error response = sampleHttpError;

    json|GitClientError validatedResponse = getValidatedResponse(response, "name");

    match validatedResponse {
        json jsonResponse => {
            test:assertFail(msg = "HttpConnector error should be handled");
        }
        GitClientError err => {
            test:assertEquals(err.message, "HTTP Connector Error", msg = "Validated response error mismatch");
        }
    }
}

@test:Config {
    groups:["utility-functions"]
}
function testGetValidatedRestResponseSuccess () {
    log:printInfo("getValidatedRestResponse() successful");
    http:Response sampleHttpResponse = new;

    json samplePayload = {"title":"Sample title", "number":150};
    sampleHttpResponse.setJsonPayload(samplePayload);

    http:Response|error response = sampleHttpResponse;

    json|GitClientError validatedResponse = getValidatedRestResponse(response);

    match validatedResponse {
        json jsonResponse => {
            string orgName = jsonResponse.title.toString();
            test:assertEquals(orgName, "Sample title", msg = "Returned json data mismatch");
        }
        GitClientError err => {
            test:assertFail(msg = err.message);
        }
    }
}

@test:Config {
    groups:["utility-functions"]
}
function testGetValidatedRestResponseError () {
    log:printInfo("getValidatedRestResponse() error payload");

    http:Response sampleHttpResponse = new();

    json samplePayload = {"message":"API error"};
    sampleHttpResponse.setJsonPayload(samplePayload);

    http:Response|error response = sampleHttpResponse;
    json|GitClientError validatedResponse = getValidatedRestResponse(response);

    match validatedResponse {
        json jsonResponse => {
            test:assertFail(msg = "Payload error should be handled");
        }
        GitClientError err => {
            test:assertEquals(err.message, "API error", msg = "Validated response error mismatch");
        }
    }
}

@test:Config {
    groups:["utility-functions"]
}
function testGetValidatedRestResponseNoPayload () {
    log:printInfo("getValidatedRestResponse() no payload");

    http:Response sampleHttpResponse = new;

    http:Response|error response = sampleHttpResponse;

    json|GitClientError validatedResponse = getValidatedRestResponse(response);

    match validatedResponse {
        json jsonResponse => {
            test:assertFail(msg = "Payload error should be handled");
        }
        GitClientError err => {
            test:assertEquals(err.message,
                "Entity body is not json compatible since the received content-type is : null",
                msg = "Validated response error mismatch");
        }
    }
}

@test:Config {
    groups:["utility-functions"]
}
function testGetValidatedRestResponseHttpError () {
    log:printInfo("getValidatedRestResponse() HttpConnectorError");

    error sampleHttpError = {};
    sampleHttpError.message = "HTTP Connector Error";

    http:Response|error response = sampleHttpError;

    json|GitClientError validatedResponse = getValidatedRestResponse(response);

    match validatedResponse {
        json jsonResponse => {
            test:assertFail(msg = "HttpConnector error should be handled");
        }
        GitClientError err => {
            test:assertEquals(err.message, "HTTP Connector Error", msg = "Validated response error mismatch");
        }
    }
}

@test:Config {
    groups:["utility-functions"]
}
function testStringToJsonError () {
    log:printInfo("stringToJson() error");
    string stringJson = "{\"title\":Sample title}";

    var convertedValue = stringToJson(stringJson);
    match convertedValue {
        json jsonValue => {
            test:assertFail(msg = "Invalid string json. Expected failure");
        }
        GitClientError gitClientError => {
            test:assertEquals(gitClientError.message,
                "Failed to parse json string: unrecognized token 'Sample' at line: 1 column: 17",
                msg = "Error message mismatch");
        }
    }
}

@test:Config {
    groups:["utility-functions"]
}
function testStringToJsonSuccess () {
    log:printInfo("stringToJson() success");
    string stringJson = "{\"title\":\"Sample title\", \"author\":{\"name\":\"Author1\"}}";

    var convertedValue = stringToJson(stringJson);
    match convertedValue {
        json jsonValue => {
            test:assertEquals(jsonValue.title.toString(), "Sample title", msg = "String to Json conversion failed");
            test:assertEquals(jsonValue.author.name.toString(), "Author1", msg = "String to Json conversion failed");
        }
        GitClientError gitClientError => {
            test:assertFail(msg = "stringToJson() returned error");
        }
    }
}
