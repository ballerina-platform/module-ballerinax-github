package samples.wso2.github;

import ballerina.net.http;
import src.wso2.github;
//import src.wso2.github.structTemplates;
import ballerina.io;

public function main (string[] args) {
    endpoint<github:GithubConnector> githubConnector {
        create github:GithubConnector(getAccessToken());
    }
    io:println("Starting ...");

    http:InResponse gitResponse = {};
    github:GitConnectorError e;
    ////github:Repository sampleRepo = {name:"ProLAd-ExpertSystem", owner:{login:"vlgunarathne"}};
    github:Repository sampleRepo = {name:"product-is", owner:{login:"wso2"}};


    //Get a single organization
    github:Organization organization;
    organization, e = githubConnector.getOrganization("wso2");
    //io:println(organization);
    //io:println(e);

    ////Get a list of projects of an organization
    //github:Project[] responseProjectList;
    //responseProjectList, e = organization.getProjects(github:GIT_STATE_OPEN);
    //io:println(lengthof responseProjectList);
    //io:println(e);
    //io:println("=========================================================");

     //Get Organization Project
     github:Project singleProject;
     singleProject, e = organization.getProject(1);
     //io:println(singleProject);
     //io:print("Error : ");io:println(e);


    //github:ColumnList columnList;
    //columnList, e = singleProject.getColumns();
    //io:println(columnList);
    //io:println(e);


    ////Get a single repository
    //github:Repository repo;
    //repo, e= githubConnector.getRepository("wso2/testgrid");
    //io:println(repo);
    //io:println(e);
    //io:println("=========================================================");

    ////Get a list of projects of a repository
    //github:Project[] responseProjectList;
    //responseProjectList, e = repo.getProjects(github:GIT_STATE_OPEN);
    //io:println(responseProjectList);
    //io:println(e);
    //io:println("=========================================================");

    ////Get a list of pull requests in a repository
    //github:PullRequest[] prList;
    //prList, e = repo.getPullRequests(github:GIT_STATE_OPEN);
    //io:println(lengthof prList);
    //io:println(prList);
    //io:println(e);
    //io:println("=========================================================");

    //Get Repository Project
    //github:Project singleProject;
    //singleProject, e = repo.getProject(1);
    //io:println(singleProject);
    //io:print("Error : ");io:println(e);
    //io:println("=========================================================");

    github:ColumnList columnList;
    columnList, e = singleProject.getColumnList();
    //io:println(columnList);
    //columnList, e = columnList.nextPage();

    github:Column cl = columnList.getAllColumns()[0];
    github:CardList cd = cl.getCardList();
    cd.nextPage();


    //io:println(columnList);
}

//function getConnector() {
//    endpoint<github:GithubConnector> gitConnector {
//        create github:GithubConnector(getAccessToken());
//    }
//   type t = typeof gitConnector;
//    io:print("Type: ");io:println(t);
//}

