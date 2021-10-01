import ballerina/log;
import ballerinax/github;

github:ConnectionConfig gitHubConfig = {
    auth: {
        token: "authToken"
    }
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> updateComment()");

    string repositoryOwnerName = "";
    string repositoryName = "";
    int issueNumber = 10;
    var response = githubClient->getRepositoryIssue(repositoryOwnerName, repositoryName, issueNumber);
    if (response is github:Issue) {
        github:UpdateIssueCommentInput updateIssueComment = {
            id: response.id,
            body: "new comment added with addComment() UPDATED"
        };
        var response = githubClient->updateComment(updateIssueComment);

        if (response is error) {
            log:printError(response.message());
        } else {
            log:printInfo("Update Success");
        }
    } else {
        log:printError(response.message());
    }
}
