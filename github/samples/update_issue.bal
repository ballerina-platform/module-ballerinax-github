import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> createIssue()");

    string repositoryOwnerName = "";
    string repositoryName = "";
    int issueNumber = 102;
    github:UpdateIssueInput updateRepositoryInput = {
        title: "Updated issue title"
    };

    var response = githubClient->updateIssue(updateRepositoryInput, repositoryOwnerName, repositoryName, issueNumber);

    if(response is github:Issue){
        log:printInfo(response.toBalString());
    }else {
        log:printError(response.message());
    }
}

