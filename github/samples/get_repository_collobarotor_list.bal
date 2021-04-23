import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getRepositoryCollobaratorList()");

    int perPageCount = 10;
    string repositoryOwnerName = "";
    string repositoryName = "";

    var response = githubClient->getRepositoryCollobaratorList(repositoryOwnerName, repositoryName, perPageCount);
    if(response is github:CollaboratorList){
        log:printInfo(response.toBalString());
    }else {
        log:printInfo(response.message());
    }
}







