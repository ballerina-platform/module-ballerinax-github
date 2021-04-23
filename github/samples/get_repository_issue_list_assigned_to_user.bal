import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getRepositoryIssueListAssignedToUser()");

    string repositoryOwnerName = "";
    string repositoryName = "";
    string issueAssigneeName = "";
    int perPageCount = 10;

    var response = githubClient->getRepositoryIssueListAssignedToUser(repositoryOwnerName, repositoryName, issueAssigneeName, perPageCount);
    if(response is github:IssueList){
        log:printInfo(response.toBalString());
    }else {
        log:printInfo(response.message());
    }
}
