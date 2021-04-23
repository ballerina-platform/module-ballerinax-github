import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getRepositoryIssue()");

    string repositoryOwnerName = "";
    string repositoryName = "";
    int issueNumber = 102;

    var response = githubClient->getRepositoryIssue(repositoryOwnerName, repositoryName, issueNumber);
    if(response is github:Issue){
        log:printInfo(response.toBalString());
    }else {
        log:printError(response.message());
    }
}
