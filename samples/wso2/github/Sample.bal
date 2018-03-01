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

    //responseProjectList, e = githubConnector.getRepositoryProjects("vlgunarathne", "carbon-apimgt", "open");
    responseProjectList, e = githubConnector.getRepositoryProjects(sampleRepo, github:GIT_STATE_OPEN);
    io:println(responseProjectList);
    io:println(e);
    io:println("=========================================================");

    //responseProjectList, e = githubConnector.getOrganizationProjects("wso23", "open");
    //println(responseProjectList);
    //println(e);
    //println("=========================================================");

    //github:Project singleProject;
    //singleProject, e = githubConnector.getProject("wso2", "testgrid", 1);
    ////singleProject, e = githubConnector.getProject("vlgunarathne", "ProLAd-ExpertSystem", 1);
    //println(singleProject);
    //println(e);
    //github:Card[] cardList;
    //cardList, e = githubConnector.getProjectCards("wso2", 2);
    //io:println(cardList);
    //io:println(e);
    //
    //github:Repository repo = githubConnector.getRepository("wso2/docker-is");
    //github:Issue[] issueList = githubConnector.getRepositoryIssues(repo.organization, repo.name, github:State.ALL);
    //
    //io:println(issueList);

}

