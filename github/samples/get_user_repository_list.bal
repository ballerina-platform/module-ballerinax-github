import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getUserRepositoryList()");

    string repositoryOwnerName = "";
    string repositoryName = "";
    int perPageCount = 10;

    var response = githubClient->getUserRepositoryList(repositoryOwnerName, repositoryName, perPageCount);
    if(response is github:RepositoryList){
        log:printInfo(response.toBalString());
    }else {
        log:printInfo(response.message());
    }
}




