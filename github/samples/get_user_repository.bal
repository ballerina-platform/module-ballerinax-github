import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getUserRepository()");

    string repositoryOwnerName = "";
    string repositoryName = "";

    var response = githubClient->getUserRepository(repositoryOwnerName, repositoryName);
    if(response is github:Repository){
        log:printInfo(response.toBalString());
    }else {
        log:printInfo(response.message());
    }
}



