import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> deleteComment()");

    github:DeleteIssueCommentInput deleteIssueComment = {
        id: ""
    };
    var response = githubClient->deleteComment(deleteIssueComment);

    if(response is error){
        log:printError(response.message());
    }else {
        log:printInfo("Delete Success");
    }
}





