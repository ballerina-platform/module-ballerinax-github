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

    github:CreateIssueInput createIssueInput = {
        title: "This is the Issue Title"
    };

    var response = githubClient->createIssue(createIssueInput, repositoryOwnerName, repositoryName);

    if(response is github:Issue){
        log:printInfo(response.toBalString());
    }else {
        log:printError(response.message());
    }
}
