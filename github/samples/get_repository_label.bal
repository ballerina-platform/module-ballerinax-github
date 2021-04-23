import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getRepositoryLabel()");

    string repositoryOwnerName = "";
    string repositoryName = "";
    string labelName = "bug";

    var response = githubClient->getRepositoryLabel(repositoryOwnerName, repositoryName, labelName);
    if(response is github:Label){
        log:printInfo(response.toBalString());
    }else {
        log:printError(response.message());
    }
}
