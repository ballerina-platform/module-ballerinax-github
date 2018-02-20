package samples.wso2.github;

import ballerina.net.http;
import src.wso2.github;
import src.wso2.github.structTemplates;

public function main (string[] args) {
    endpoint<github:ClientConnector> githubConnector {
        create github:ClientConnector("f9fd45c0f9bbbcfc9174ccae62135dee3bda53cd");
    }
    http:InResponse gitResponse = {};
    error e;
    github:Project[] responseProjectList;

    //responseProjectList, e = githubConnector.getRepositoryProjects("vlgunarathne", "carbon-apimgt", "open");
    responseProjectList, e = githubConnector.getRepositoryProjects("vlgunrathne", "ProLAd-ExpertSystem", "open");
    println(responseProjectList);
    println(e);
    println("=========================================================");
    //
    //responseProjectList, e = githubConnector.getOrganizationProjects("wso23", "open");
    //println(responseProjectList);
    //println(e);
    //println("=========================================================");

    //github:Project singleProject;
    //singleProject, e = githubConnector.getProject("wso2", "testgrid", 1);
    ////singleProject, e = githubConnector.getProject("vlgunarathne", "ProLAd-ExpertSystem", 1);
    //println(singleProject);
    //println(e);

}

