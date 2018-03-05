package samples.wso2.github;

import ballerina.net.http;
import src.wso2.github;
import src.wso2.github.structTemplates;
import ballerina.io;

public function main (string[] args) {
    endpoint<github:GithubConnector> githubConnector {
        create github:GithubConnector(getAccessToken());
    }

    http:InResponse gitResponse = {};
    github:GitConnectorError e;
    github:Project[] responseProjectList;
    github:Repository sampleRepo = {name:"ProLAd-ExpertSystem", owner:{login:"vlgunarathne"}};

    ////Get a list of projects of a repository
    //responseProjectList, e = githubConnector.getRepositoryProjects(sampleRepo, github:GIT_STATE_OPEN);
    //io:println(responseProjectList);
    //io:println(e);
    //io:println("=========================================================");

    ////Get a list of projects of an organization
    //responseProjectList, e = githubConnector.getOrganizationProjects("wso2", github:GIT_STATE_ALL);
    //io:println(lengthof responseProjectList);
    //io:println(e);
    //io:println("=========================================================");

    ////Get Repository Project
    //github:Project singleProject;
    //singleProject, e = githubConnector.getRepositoryProject(sampleRepo, 1);
    //io:println(singleProject);
    //io:print("Error : ");io:println(e);

    ////Get Organization Project
    //github:Project singleProject;
    //singleProject, e = githubConnector.getOrganizationProject("wso2", 14);
    //io:println(singleProject);
    //io:print("Error : ");io:println(e);


    //github:Card[] cardList;
    //cardList, e = githubConnector.getProjectCards("wso2", 2);
    //io:println(cardList);
    //io:println(e);
    //

    //Get a single repository
    github:Repository repo;
    repo, e= githubConnector.getRepository("wso2/docker-is");
    io:println(repo);
    io:println(e);
    io:println("=========================================================");

    //github:Issue[] issueList = githubConnector.getRepositoryIssues(repo.organization, repo.name, github:State.ALL);
    //
    //io:println(issueList);

}

