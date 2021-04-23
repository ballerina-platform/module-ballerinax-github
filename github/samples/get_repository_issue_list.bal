import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getRepositoryIssueList()");

    string repositoryOwnerName = "";
    string repositoryName = "";
    github:IssueState[] issueStates = [github:ISSUE_OPEN];
    int perPageCount = 10;

    var response = githubClient->getRepositoryIssueList(repositoryOwnerName, repositoryName, issueStates, perPageCount);
    if(response is github:IssueList){
        log:printInfo(response.toBalString());
    }else {
        log:printInfo(response.message());
    }
}

