package tests;

import ballerina/net.http;
import github;
import ballerina/io;

public function main (string[] args) {

    endpoint github:GitHubConnectorEndpoint githubConnectorEP {
        accessToken:getAccessToken()
    };

    io:println("Starting tests...");

    github:GitConnectorError e = {};


    ////Get a single organization
    //github:Organization organization = {};
    //var organizationData = githubConnectorEP -> getOrganization("wso2");
    //match organizationData {
    //    github:Organization org => {
    //        organization = org;
    //        io:println(organization);
    //    }
    //
    //    github:GitConnectorError err => {
    //        io:println(err);
    //    }
    //}
    //io:println("=========================================================");

    //// Get an organization project
    //github:Project orgProject = {};
    //github:Organization projectOrganization = {login:"wso2"};
    //var projectData = githubConnectorEP -> getOrganizationProject(projectOrganization, 1);
    //match projectData {
    //    github:Project proj => {
    //        orgProject = proj;
    //        io:println(orgProject);
    //    }
    //
    //    github:GitConnectorError err => {
    //        io:println(err);
    //    }
    //}
    //io:println("=========================================================");

    ////Get a list of projects of an organization
    //github:ProjectList projectList = {};
    //github:Organization projectListOrganization = {login:"wso2"};
    //var responseProjectList = githubConnectorEP -> getOrganizationProjectList(projectListOrganization, 2, github:GIT_STATE_OPEN);
    //match responseProjectList {
    //    github:ProjectList prjtList=> {
    //        projectList = prjtList;
    //        io:println(projectList);
    //    }
    //
    //    github:GitConnectorError err => {
    //        io:println(err);
    //    }
    //}
    //io:println("=========================================================");
    //// Next page
    //responseProjectList = githubConnectorEP -> getProjectListNextPage(projectList);
    //    match responseProjectList {
    //    github:ProjectList prjtList=> {
    //        projectList = prjtList;
    //        io:println(projectList);
    //    }
    //
    //    github:GitConnectorError err => {
    //        io:println(err);
    //    }
    //}
    //io:println("=========================================================");
    //

    //Get project column list
    github:Project columnListProject = {number:1, resourcePath:"/orgs/wso2/projects/1", owner:{}};
    columnListProject.owner.setOwnerType("Organization");
    github:ColumnList columnList = {};
    var columns = githubConnectorEP -> getProjectColumnList(columnListProject, 2);
    match columns {
        github:ColumnList colList => {
            columnList = colList;
            io:println(columnList);
        }
        github:GitConnectorError err => {
            io:println(err);
        }
    }
    io:println("=========================================================");

    github:Column column = columnList.getAllColumns()[0];

    github:CardList cardList = column.getCardList();
    boolean hasNext = true;
    while (hasNext) {
       foreach card in cardList.getAllCards() {
           io:println(card.note);
           io:println(card.content);
           io:println("=========================");
       }
       hasNext = cardList.hasNextPage();
       var cdl = githubConnectorEP -> getCardListNextPage(cardList);
       match cdl {
           github:CardList cd => {
               cardList = cd;
           }
           github:GitConnectorError err => {
               io:println(err);
           }
       }
    }
    io:println("=========================================================");
    //
    ////Get a all the repositories of Organization
    //github:RepositoryList repositoryList = {};
    //var repoList = organization.getRepositoryList(2);
    //match repoList {
    //    github:RepositoryList repList => {
    //        repositoryList = repList;
    //        io:println(repositoryList);
    //    }
    //    github:GitConnectorError err => {
    //         io:println(err);
    //     }
    //}
    //io:println("=========================================================");
    //// Next page
    //repoList = repositoryList.nextPage();
    //    match repoList {
    //    github:RepositoryList repList=> {
    //        repoList = repList;
    //        io:println(repoList);
    //    }
    //
    //    github:GitConnectorError err => {
    //        io:println(err);
    //    }
    //}
    //io:println("=========================================================");

    ////Get a single repository
    //github:Repository repository = {};
    //var repo = githubConnectorEP -> getRepository("wso2/product-apim");
    //match repo {
    //    github:Repository rep => {
    //        repository = rep;
    //        io:println(repository);
    //    }
    //    github:GitConnectorError err => {
    //        io:println(err);
    //    }
    //}
    //io:println("=========================================================");
    //
    //
    ////Get a list of projects of a repository
    //github:ProjectList repoProjectList = {};
    //var responseRepoProjectList = repository.getProjectList(2, github:GIT_STATE_OPEN);
    //match responseRepoProjectList {
    //    github:ProjectList prjtList => {
    //        repoProjectList = prjtList;
    //        io:println(repoProjectList);
    //    }
    //    github:GitConnectorError err => {
    //        io:println(err);
    //    }
    //}
    //io:println("=========================================================");
    //// Next page
    //responseRepoProjectList = repoProjectList.nextPage();
    //    match responseRepoProjectList {
    //    github:ProjectList prjList=> {
    //        repoProjectList = prjList;
    //        io:println(repoProjectList);
    //    }
    //    github:GitConnectorError err => {
    //        io:println(err);
    //    }
    //}
    //io:println("=========================================================");
    //
    ////Get a list of pull requests in a repository
    //github:PullRequestList pullRequestList = {};
    //var prList = repository.getPullRequestList(2, github:GIT_STATE_OPEN);
    //match prList {
    //    github:PullRequestList pList => {
    //        pullRequestList = pList;
    //        io:println(pullRequestList);
    //    }
    //    github:GitConnectorError err => {
    //        io:println(err);
    //    }
    //}
    //io:println("=========================================================");
    //// Next page
    //prList = pullRequestList.nextPage();
    //match prList {
    //    github:PullRequestList pList => {
    //        pullRequestList = pList;
    //        io:println(pullRequestList);
    //    }
    //    github:GitConnectorError err => {
    //        io:println(err);
    //    }
    //}
    //io:println("=========================================================");
    //
    //
    ////Get a Repository Project
    //github:Project repoProject = {};
    //var singleRepoProject = repository.getProject(1);
    //match singleRepoProject {
    //    github:Project prjt => {
    //        repoProject = prjt;
    //        io:println(repoProject);
    //    }
    //    github:GitConnectorError err => {
    //        io:println(err);
    //    }
    //}
    //io:println("=========================================================");
    //
    ////Get a list of issues of a repository
    //github:IssueList issueList = {};
    //var issues = repository.getIssueList(2, github:GIT_STATE_OPEN);
    //match issues {
    //    github:IssueList isList => {
    //        issueList = isList;
    //        io:println(issueList);
    //    }
    //    github:GitConnectorError err => {
    //        io:println(err);
    //    }
    //}
    //io:println("=========================================================");
    //// Next page
    //issues = issueList.nextPage();
    //match issues {
    //    github:IssueList isList => {
    //        issueList = isList;
    //        io:println(issueList);
    //    }
    //    github:GitConnectorError err => {
    //        io:println(err);
    //    }
    //}
    //io:println("=========================================================");
    //
    //io:println("End of tests ...");

}


