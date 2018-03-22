package tests.github;

import ballerina.net.http;
import src.github;
import ballerina.io;

public function main (string[] args) {
    github:GitHubConnector githubConnector = { accessToken: getAccessToken()};
    io:println("Starting samples...");

    github:GitConnectorError e = {};


    //Get a single organization
    github:Organization organization = {};
    var organizationData = githubConnector.getOrganization("wso2");
    match organizationData {
        github:Organization org => {
            organization = org;
            io:println(organization);
        }

        github:GitConnectorError err => {
            io:println(err);
        }
    }
    io:println("=========================================================");
    
    //Get a list of projects of an organization
    github:ProjectList projectList = {};
    var responseProjectList = organization.getProjectList(github:GIT_STATE_OPEN);
    match responseProjectList {
        github:ProjectList prjtList=> {
            projectList = prjtList;
            io:println(projectList);
        }

        github:GitConnectorError err => {
            io:println(err);
        }
    }
    io:println("=========================================================");
    // Next page
    responseProjectList = projectList.nextPage();
        match responseProjectList {
        github:ProjectList prjtList=> {
            projectList = prjtList;
            io:println(projectList);
        }

        github:GitConnectorError err => {
            io:println(err);
        }
    }
    io:println("=========================================================");

     //Get Organization Project
     github:Project orgProject = {};
     var singleProject = organization.getProject(1);
     match singleProject {
         github:Project prjt => {
             orgProject = prjt;
             io:println(orgProject);
         }
         github:GitConnectorError err => {
            io:println(err);
        }
     }
    io:println("=========================================================");
    
    //Get project column list
    github:ColumnList columnList = {};
    var columns = orgProject.getColumnList();
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
       var cdl = cardList.nextPage();
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

    //Get a all the repositories of Organization
    github:RepositoryList repositoryList = {};
    var repoList = organization.getRepositoryList();
    match repoList {
        github:RepositoryList repList => {
            repositoryList = repList;
            io:println(repositoryList);
        }
        github:GitConnectorError err => {
             io:println(err);
         }
    }
    io:println("=========================================================");
    // Next page
    repoList = repositoryList.nextPage();
        match repoList {
        github:RepositoryList repList=> {
            repoList = repList;
            io:println(repoList);
        }

        github:GitConnectorError err => {
            io:println(err);
        }
    }
    io:println("=========================================================");

    //Get a single repository
    github:Repository repository = {};
    var repo = githubConnector.getRepository("wso2/docker-is");
    match repo {
        github:Repository rep => {
            repository = rep;
            io:println(repository);
        }
        github:GitConnectorError err => {
            io:println(err);
        }
    }
    io:println("=========================================================");


    //Get a list of projects of a repository
    github:ProjectList repoProjectList = {};
    var responseRepoProjectList = repository.getProjectList(github:GIT_STATE_OPEN);
    match responseRepoProjectList {
        github:ProjectList prjtList => {
            repoProjectList = prjtList;
            io:println(repoProjectList);
        }
        github:GitConnectorError err => {
            io:println(err);
        }
    }
    io:println("=========================================================");
    // Next page
    responseRepoProjectList = repoProjectList.nextPage();
        match responseRepoProjectList {
        github:ProjectList prjList=> {
            repoProjectList = prjList;
            io:println(repoProjectList);
        }
        github:GitConnectorError err => {
            io:println(err);
        }
    }
    io:println("=========================================================");

    //Get a list of pull requests in a repository
    github:PullRequestList pullRequestList = {};
    var prList = repository.getPullRequestList(github:GIT_STATE_OPEN);
    match prList {
        github:PullRequestList pList => {
            pullRequestList = pList;
            io:println(pullRequestList);
        }
        github:GitConnectorError err => {
            io:println(err);
        }
    }
    io:println("=========================================================");
    // Next page
    prList = pullRequestList.nextPage();
    match prList {
        github:PullRequestList pList => {
            pullRequestList = pList;
            io:println(pullRequestList);
        }
        github:GitConnectorError err => {
            io:println(err);
        }
    }
    io:println("=========================================================");


    //Get a Repository Project
    github:Project repoProject = {};
    var singleRepoProject = repository.getProject(1);
    match singleRepoProject {
        github:Project prjt => {
            repoProject = prjt;
            io:println(repoProject);
        }
        github:GitConnectorError err => {
            io:println(err);
        }
    }
    io:println("=========================================================");

    //Get a list of issues of a repository
    github:IssueList issueList = {};
    var issues = repository.getIssueList(github:GIT_STATE_OPEN);
    match issues {
        github:IssueList isList => {
            issueList = isList;
            io:println(issueList);
        }
        github:GitConnectorError err => {
            io:println(err);
        }
    }
    io:println("=========================================================");
    // Next page
    issues = issueList.nextPage();
    match issues {
        github:IssueList isList => {
            issueList = isList;
            io:println(issueList);
        }
        github:GitConnectorError err => {
            io:println(err);
        }
    }
    io:println("=========================================================");

}


