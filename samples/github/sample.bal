package samples.github;

import ballerina.net.http;
import src.github;
import ballerina.io;

public function main (string[] args) {
    github:GitHubConnector githubConnector = { accessToken: getAccessToken()};
    io:println("Starting samples...");

    github:GitConnectorError e;


    //Get a single organization
    // github:Organization organization;
    // organization, e = githubConnector.getOrganization("wso2");
    // io:println(organization);
    // io:println(e);

    ////Get a list of projects of an organization
    //github:ProjectList responseProjectList;
    //responseProjectList, e = organization.getProjectList(github:GIT_STATE_OPEN);
    //io:println(lengthof responseProjectList.getAllProjects());
    //io:println(e);
    //io:println("=========================================================");

     //Get Organization Project
    //  github:Project singleProject;
    //  singleProject, e = organization.getProject(1);
    //  io:println(singleProject);
    //  io:print("Error : ");io:println(e);

    //Get project column list
    // github:ColumnList columnList;
    // columnList, e = singleProject.getColumnList();
    // io:println(columnList);
    // io:println(e);

    //Get a single repository
    github:Repository repo;
    repo, e= githubConnector.getRepository("wso2/product-is");
    io:println(repo);
    io:println(e);
    io:println("=========================================================");

    // //Get a all the repositories of Organization
    // github:RepositoryList repoList;
    // repoList, e = organization.getRepositoryList();
    // io:println(repoList);
    // io:println(e);

    // repoList, e = repoList.nextPage();
    // io:println(repoList);
    // io:println(e);
    ////Get a list of projects of a repository
    //github:ProjectList responseProjectList;
    //responseProjectList, e = repo.getProjectList(github:GIT_STATE_OPEN);
    //io:println(responseProjectList);
    //io:println(e);
    //io:println("=========================================================");
    //
    //responseProjectList, e = responseProjectList.nextPage();
    //io:println(responseProjectList);
    //io:println(e);

    // //Get a list of pull requests in a repository
    // github:PullRequestList prList;
    // prList, e = repo.getPullRequestList(github:GIT_STATE_OPEN);
    // io:println(prList);
    // io:println(e);
    // io:println("=========================================================");

    // prList, e = prList.nextPage();
    // io:println(prList);
    // io:println(e);
    ////Get Repository Project
    //github:Project singleProject;
    //singleProject, e = repo.getProject(1);
    //io:println(singleProject);
    //io:print("Error : ");io:println(e);
    //io:println("=========================================================");

    ////Get a list of issues of a repository
    //github:IssueList issueList;
    //issueList, e = repo.getIssueList(github:GIT_STATE_CLOSED);
    //io:println(issueList);
    //io:println(e);

    //github:ColumnList columnList;
    //columnList, e = singleProject.getColumnList();
    //io:println(columnList);
    ////columnList, e = columnList.nextPage();
    //
    //github:Column cl = columnList.getAllColumns()[0];
    //
    //github:CardList cd = cl.getCardList();
    //boolean hasNext = true;
    //while (hasNext) {
    //    foreach card in cd.getAllCards() {
    //        io:println(card.note);
    //        io:println(card.content);
    //        io:println("=========================");
    //    }
    //    hasNext = cd.hasNextPage();
    //    cd, e = cd.nextPage();
    //}
    //cd, e = cd.nextPage();


}


