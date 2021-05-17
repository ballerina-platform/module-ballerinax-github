import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getRepositoryIssueCommentList()");

    string repositoryOwnerName = "";
    string repositoryName = "";
    int issueNumber = 102;
    int perPageCount = 10;

    var response = githubClient->getRepositoryIssueCommentList(repositoryOwnerName, repositoryName, issueNumber, perPageCount);
    if(response is github:IssueCommentList){
        log:printInfo(response.toBalString());
    }else {
        log:printError(response.message());
    }
}

