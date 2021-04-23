import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getOrganizationRepositoryList()");

    string organizationName = "";
    int perPageCount = 10;

    var response = githubClient->getUserRepositoryList(organizationName, perPageCount);
    if(response is github:RepositoryList){
        log:printInfo(response.toBalString());
    }else {
        log:printInfo(response.message());
    }
}





