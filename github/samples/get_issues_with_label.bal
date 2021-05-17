import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getIssuesWithLabel()");

    string repositoryOwnerName = "";
    string repositoryName = "";
    int perPageCount = 10;
    string label = "bug";

    var response = githubClient->getIssuesWithLabel(repositoryOwnerName, repositoryName, label, perPageCount);
    if(response is github:IssueList){
       log:printInfo(response.toBalString());
    }else {
       log:printError(response.message());
    }
}


