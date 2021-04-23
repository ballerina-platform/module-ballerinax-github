import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> addComment()");

    string repositoryOwnerName = "";
    string repositoryName = "";
    int issueNumber = 10;
    var response = githubClient->getRepositoryIssue(repositoryOwnerName, repositoryName, issueNumber);
    if(response is github:Issue){
        AddCommentInput addCommentInput = {
            subjectId: response.id,
            body: "Comment Added by Ballerina GitHub connector!"
        };
        var response = githubClient->addComment(addCommentInput);

        if(response is github:IssueComment){
            log:printInfo(response.toBalString());
        }else {
            log:printError(response.message());
        }
    }else {
        log:printError(response.message());
    }

}



