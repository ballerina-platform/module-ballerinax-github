package samples.wso2.github;

import ballerina.net.http;
import src.wso2.github;
import src.wso2.github.structTemplates;

public function main (string[] args) {
    endpoint<github:ClientConnector> githubConnector {
        create github:ClientConnector("b8277ec704a117743b59a99d794ce6f025255117");
    }
    http:InResponse gitResponse = {};
    http:HttpConnectorError e;
    github:Project[] gitJsonResponse;
    //gitJsonResponse, e = githubConnector.getRepositoryProjects("vlgunarathne", "carbon-apimgt", "open");
    gitJsonResponse, e = githubConnector.getRepositoryProjects("vlgunarathne", "ProLAd-ExpertSystem", "open");
    println(gitJsonResponse);
    println(e);


    //gitJsonResponse, e = githubConnector.getOrganizationProjects("wso2", "open");
    //println(gitJsonResponse);
    //println(e);
}

