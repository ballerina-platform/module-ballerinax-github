package tests;

import ballerina/io;
import ballerina/net.http;
import ballerina/test;
import wso2/github;

endpoint github:GitHubConnectorEndpoint githubConnectorEP {
    accessToken:getAccessToken()
};

@test:Config {
    groups:["network-calls"]
}
function testGetOrganization () {
    //Get a single organization
    io:println("githubConnectorEP -> getOrganization()");
    github:Organization organization = {};
    var organizationData = githubConnectorEP -> getOrganization("wso2");
    match organizationData {
        github:Organization org => {
            organization = org;
        }

        github:GitConnectorError err => {
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
    io:println("githubConnectorEP -> getOrganizationProject()");
    github:Project orgProject = {};
    github:Organization projectOrganization = {login:"wso2"};
    var projectData = githubConnectorEP -> getOrganizationProject(projectOrganization, 1);
    match projectData {
        github:Project proj => {
            orgProject = proj;
        }

        github:GitConnectorError err => {
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
    io:println("githubConnectorEP -> getOrganizationProjectList()");
    int recordCount = 2;
    github:ProjectList projectList = {};
    github:Organization projectListOrganization = {login:"wso2"};
    var responseProjectList = githubConnectorEP ->
                              getOrganizationProjectList(projectListOrganization, github:GIT_STATE_OPEN, recordCount);
    match responseProjectList {
        github:ProjectList prjtList=> {
            projectList = prjtList;
        }

        github:GitConnectorError err => {
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
    io:println("githubConnectorEP -> getOrganizationProjectListNextPage()");
    int recordCount = 2;
    github:ProjectList projectList = {};
    github:Organization projectListOrganization = {login:"wso2"};
    var responseProjectList = githubConnectorEP ->
                              getOrganizationProjectList(projectListOrganization, github:GIT_STATE_OPEN, 2);
    match responseProjectList {
        github:ProjectList prjtList=> {
            projectList = prjtList;
        }

        github:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    // Next page
    responseProjectList = githubConnectorEP -> getProjectListNextPage(projectList);
    match responseProjectList {
        github:ProjectList prjtList=> {
            projectList = prjtList;
        }

        github:GitConnectorError err => {
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
    io:println("githubConnectorEP -> getProjectColumnList()");
    int recordCount = 2;
    github:Project columnListProject = {number:1, resourcePath:"/orgs/wso2/projects/1", owner:{}};
    columnListProject.owner.setOwnerType("Organization");
    github:ColumnList columnList = {};
    var columns = githubConnectorEP -> getProjectColumnList(columnListProject, recordCount);
    match columns {
        github:ColumnList colList => {
            columnList = colList;
        }
        github:GitConnectorError err => {
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
    io:println("column.getCardList()");
    int recordCount = 2;
    github:Project columnListProject = {number:1, resourcePath:"/orgs/wso2/projects/1", owner:{}};
    columnListProject.owner.setOwnerType("Organization");
    github:ColumnList columnList = {};
    var columns = githubConnectorEP -> getProjectColumnList(columnListProject, recordCount);
    match columns {
        github:ColumnList colList => {
            columnList = colList;
        }
        github:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    github:Column column = columnList.getAllColumns()[0];
    github:CardList cardList = column.getCardList();
    boolean lengthEqualsRecords = lengthof cardList.getAllCards() > 0;

    test:assertTrue(lengthEqualsRecords, msg = "Failed getCardList()");
}

@test:Config {
    dependsOn:["testGetCardListOfColumn"],
    groups:["network-calls"]
}
function testGetCardListNextPage () {
    //Get card list next page
    io:println("githubConnectorEP -> getCardListNextPage()");
    int recordCount = 2;
    github:Project columnListProject = {number:1, resourcePath:"/orgs/wso2/projects/1", owner:{}};
    columnListProject.owner.setOwnerType("Organization");
    github:ColumnList columnList = {};
    var columns = githubConnectorEP -> getProjectColumnList(columnListProject, recordCount);
    match columns {
        github:ColumnList colList => {
            columnList = colList;
        }
        github:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    github:Column column = columnList.getAllColumns()[0];
    github:CardList cardList = column.getCardList();
    var cardListNextPage = githubConnectorEP -> getCardListNextPage(cardList);
    match cardListNextPage {
        github:CardList cd => {
            cardList = cd;
        }
        github:GitConnectorError err => {
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
    io:println("githubConnectorEP -> getOrganizationRepositoryList()");
    int recordCount = 2;
    github:Organization repositoryListOrganization = {login:"wso2"};
    github:RepositoryList repositoryList = {};
    var repoList = githubConnectorEP -> getOrganizationRepositoryList(repositoryListOrganization, recordCount);
    match repoList {
        github:RepositoryList repList => {
            repositoryList = repList;
        }
        github:GitConnectorError err => {
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
    io:println("githubConnectorEP -> getRepositoryListNextPage()");
    int recordCount = 2;
    github:Organization repositoryListOrganization = {login:"wso2"};
    github:RepositoryList repositoryList = {};
    var repoList = githubConnectorEP -> getOrganizationRepositoryList(repositoryListOrganization, recordCount);
    match repoList {
        github:RepositoryList repList => {
            repositoryList = repList;
        }
        github:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    // Next page
    repoList = githubConnectorEP -> getRepositoryListNextPage(repositoryList);
    match repoList {
        github:RepositoryList repList=> {
            repositoryList = repList;
        }

        github:GitConnectorError err => {
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
    io:println("githubConnectorEP -> getRepository()");
    github:Repository repository = {};
    var repo = githubConnectorEP -> getRepository("wso2/product-apim");
    match repo {
        github:Repository rep => {
            repository = rep;
        }
        github:GitConnectorError err => {
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
    io:println("githubConnectorEP -> getRepositoryProject()");
    github:Repository projectRepository = {owner:{login:"wso2"}, name:"testgrid"};
    github:Project repositoryProject = {};
    var singleRepoProject = githubConnectorEP -> getRepositoryProject(projectRepository, 1);
    match singleRepoProject {
        github:Project project => {
            repositoryProject = project;
        }
        github:GitConnectorError err => {
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
    io:println("githubConnectorEP -> getRepositoryProjectList()");
    int recordCount = 1;
    github:Repository projectRepositoryList = {name:"testgrid", owner:{login:"wso2"}};
    github:ProjectList repoProjectList = {};
    var responseRepoProjectList = githubConnectorEP ->
                                  getRepositoryProjectList(projectRepositoryList, github:GIT_STATE_OPEN, recordCount);
    match responseRepoProjectList {
        github:ProjectList prjtList => {
            repoProjectList = prjtList;
        }
        github:GitConnectorError err => {
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
    io:println("githubConnectorEP -> getProjectListNextPage()");
    int recordCount = 1;
    github:Repository projectRepository = {name:"ProLAd-ExpertSystem", owner:{login:"vlgunarathne"}};
    github:ProjectList repoProjectList = {};
    var responseRepoProjectList = githubConnectorEP ->
                                  getRepositoryProjectList(projectRepository, github:GIT_STATE_OPEN, 1);
    match responseRepoProjectList {
        github:ProjectList prjtList => {
            repoProjectList = prjtList;
        }
        github:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    // Next page
    responseRepoProjectList = githubConnectorEP -> getProjectListNextPage(repoProjectList);
    match responseRepoProjectList {
        github:ProjectList prjList=> {
            repoProjectList = prjList;
        }
        github:GitConnectorError err => {
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
    io:println("githubConnectorEP -> getPullRequestList()");
    int recordCount = 2;
    github:Repository pullRequestRepository = {owner:{login:"wso2"}, name:"product-is"};
    github:PullRequestList pullRequestList = {};
    var prList = githubConnectorEP -> getPullRequestList(pullRequestRepository, github:GIT_STATE_OPEN, recordCount);
    match prList {
        github:PullRequestList pList => {
            pullRequestList = pList;
        }
        github:GitConnectorError err => {
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
    io:println("githubConnectorEP -> getPullRequestListNextPage()");
    int recordCount = 2;
    github:Repository pullRequestRepository = {owner:{login:"wso2"}, name:"product-is"};
    github:PullRequestList pullRequestList = {};
    var prList = githubConnectorEP -> getPullRequestList(pullRequestRepository, github:GIT_STATE_OPEN, recordCount);
    match prList {
        github:PullRequestList pList => {
            pullRequestList = pList;
        }
        github:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    // Next page
    prList = githubConnectorEP -> getPullRequestListNextPage(pullRequestList);
    match prList {
        github:PullRequestList pList => {
            pullRequestList = pList;
        }
        github:GitConnectorError err => {
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
    io:println("githubConnectorEP -> getIssueList()");
    int recordCount = 2;
    github:Repository issueRepository = {owner:{login:"wso2"}, name:"carbon-apimgt"};
    github:IssueList issueList = {};
    var issues = githubConnectorEP -> getIssueList(issueRepository, github:GIT_STATE_OPEN, recordCount);
    match issues {
        github:IssueList isList => {
            issueList = isList;
        }
        github:GitConnectorError err => {
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
    io:println("githubConnectorEP -> getIssueListNextPage()");
    int recordCount = 2;
    github:Repository issueRepository = {owner:{login:"wso2"}, name:"carbon-apimgt"};
    github:IssueList issueList = {};
    var issues = githubConnectorEP -> getIssueList(issueRepository, github:GIT_STATE_OPEN, recordCount);
    match issues {
        github:IssueList isList => {
            issueList = isList;
        }
        github:GitConnectorError err => {
            test:assertFail(msg = err.message[0]);
        }
    }
    // Next page
    issues = githubConnectorEP -> getIssueListNextPage(issueList);
    match issues {
        github:IssueList isList => {
            issueList = isList;
        }
        github:GitConnectorError err => {
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
    io:println("RepositoryList.hasNextPage()");
    github:RepositoryList repositoryList = {};

    test:assertFalse(repositoryList.hasNextPage(), msg = "Failed RepositoryList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testRepositoryListHasPreviousPage () {
    io:println("RepositoryList.hasPreviousPage()");
    github:RepositoryList repositoryList = {};

    test:assertFalse(repositoryList.hasPreviousPage(), msg = "Failed RepositoryList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testRepositoryListGetAllRepositories () {
    io:println("RepositoryList.getAllRepositories()");
    github:RepositoryList repositoryList = {};
    github:Repository[]|null repoArray = repositoryList.getAllRepositories();

    test:assertEquals(typeof repoArray, typeof github:Repository[], msg = "Failed RepositoryList.getAllRepositories()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testProjectListHasNextPage () {
    io:println("ProjectList.hasNextPage()");
    github:ProjectList projectList = {};

    test:assertFalse(projectList.hasNextPage(), msg = "Failed ProjectList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testProjectListHasPreviousPage () {
    io:println("ProjectList.hasPreviousPage()");
    github:ProjectList projectList = {};

    test:assertFalse(projectList.hasPreviousPage(), msg = "Failed ProjectList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testProjectListGetAllProjects () {
    io:println("ProjectList.getAllRepositories()");
    github:ProjectList projectList = {};
    github:Project[]|null projectArray = projectList.getAllProjects();

    test:assertEquals(typeof projectArray, typeof github:Project[], msg = "Failed ProjectList.getAllProjects()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testColumnGetCardList () {
    io:println("Column.getCardList()");
    github:Column column = {};
    github:CardList|null cardList = column.getCardList();

    test:assertEquals(typeof cardList, typeof github:CardList, msg = "Failed Column.getCardList()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testColumnListHasNextPage () {
    io:println("ColumnList.hasNextPage()");
    github:ColumnList columnList = {};

    test:assertFalse(columnList.hasNextPage(), msg = "Failed ColumnList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testColumnListHasPreviousPage () {
    io:println("ColumnList.hasPreviousPage()");
    github:ColumnList columnList = {};

    test:assertFalse(columnList.hasPreviousPage(), msg = "Failed ColumnList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testColumnListGetAllColumns () {
    io:println("ColumnList.getAllColumns()");
    github:ColumnList columnList = {};
    github:Column[]|null columnArray = columnList.getAllColumns();

    test:assertEquals(typeof columnArray, typeof github:Column[], msg = "Failed ColumnList.getAllColumns()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testCardListHasNextPage () {
    io:println("CardList.hasNextPage()");
    github:CardList cardList = {};

    test:assertFalse(cardList.hasNextPage(), msg = "Failed CardList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testCardListHasPreviousPage () {
    io:println("CardList.hasPreviousPage()");
    github:CardList cardList = {};

    test:assertFalse(cardList.hasPreviousPage(), msg = "Failed CardList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testCardListGetAllCards () {
    io:println("CardList.getAllCards()");
    github:CardList cardList = {};
    github:Card[]|null cardArray = cardList.getAllCards();

    test:assertEquals(typeof cardArray, typeof github:Card[], msg = "Failed CardList.getAllCards()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testPullRequestListHasNextPage () {
    io:println("PullRequestList.hasNextPage()");
    github:PullRequestList pullRequestList = {};

    test:assertFalse(pullRequestList.hasNextPage(), msg = "Failed PullRequestList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testPullRequestListHasPreviousPage () {
    io:println("PullRequestList.hasPreviousPage()");
    github:PullRequestList pullRequestList = {};

    test:assertFalse(pullRequestList.hasPreviousPage(), msg = "Failed PullRequestList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testPullRequestListGetAllPullRequests () {
    io:println("PullRequestList.getAllPullRequests()");
    github:PullRequestList pullRequestList = {};
    github:PullRequest[]|null pullRequestArray = pullRequestList.getAllPullRequests();

    test:assertEquals(typeof pullRequestArray, typeof github:PullRequest[], msg = "Failed PullRequestList.getAllPullRequests()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testIssueListHasNextPage () {
    io:println("IssueList.hasNextPage()");
    github:IssueList issueList = {};

    test:assertFalse(issueList.hasNextPage(), msg = "Failed IssueList.hasNextPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testIssueListHasPreviousPage () {
    io:println("IssueList.hasPreviousPage()");
    github:IssueList issueList = {};

    test:assertFalse(issueList.hasPreviousPage(), msg = "Failed IssueList.hasPreviousPage()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testIssueListGetAllIssues () {
    io:println("IssueList.getAllIssues()");
    github:IssueList issueList = {};
    github:Issue[]|null issueArray = issueList.getAllIssues();

    test:assertEquals(typeof issueArray, typeof github:Issue[], msg = "Failed IssueList.getAllIssues()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testLabelListGetAllLabels () {
    io:println("LabelList.getAllLabels()");
    github:LabelList labelList = {};
    github:Label[]|null labelArray = labelList.getAllLabels();

    test:assertEquals(typeof labelArray, typeof github:Label[], msg = "Failed LabelList.getAllLabels()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testProjectOwnerGetOwnerType () {
    github:ProjectOwner projectOwner = {};

    test:assertEquals(typeof projectOwner.getOwnerType(), typeof string, msg = "Failed ProjectOwner.getOwnerType()");
}

@test:Config {
    groups:["struct-bound-functions"]
}
function testProjectOwnerSetOwnerType () {
    github:ProjectOwner projectOwner = {};
    projectOwner.setOwnerType("Organization");
    string ownerType = projectOwner.getOwnerType();

    test:assertEquals(ownerType, "Organization", msg = "Failed ProjectOwner.getOwnerType()");
}