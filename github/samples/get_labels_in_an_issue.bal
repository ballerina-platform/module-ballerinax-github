import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getLabelsInIssue()");

    string repositoryOwnerName = "";
    string repositoryName = "";
    int issueNumber = 23;
    int perPageCount = 10;
    var response = githubClient->getLabelsInIssue(repositoryOwnerName, repositoryName, createdIssueNumber, perPageCount);
    if(response is github:LabelList){
        log:printInfo(response.toBalString());
    }else {
        log:printError(response.message());
    }
}

