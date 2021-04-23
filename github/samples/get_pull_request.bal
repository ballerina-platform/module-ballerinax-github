import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getPullRequest()");

    string repositoryOwnerName = "";
    string repositoryName = "";
    int pullRequestNumber = 105;

     var response = githubClient->getPullRequest(repositoryOwnerName, repositoryName, pullRequestNumber);
     if(response is github:PullRequest){
         log:printInfo(response.toBalString());
     }else {
         log:printError(response.message());
     }
}

