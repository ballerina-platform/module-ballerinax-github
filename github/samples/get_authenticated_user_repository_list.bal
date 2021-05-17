import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getAuthenticatedUserRepositoryList()");

    int perPageCount = 10;

    var response = githubClient->getAuthenticatedUserRepositoryList(perPageCount);
    if(response is github:RepositoryList){
        log:printInfo(response.toBalString());
    }else {
        log:printInfo(response.message());
    }
}





