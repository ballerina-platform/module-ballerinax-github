import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getRepositoryMilestoneList()");

    string repositoryOwnerName = "";
    string repositoryName = "";
    int perPageCount = 10;

    var response = githubClient->getRepositoryMilestoneList(repositoryOwnerName, repositoryName, perPageCount);
     if(response is github:MilestoneList){
         log:printInfo(response.toBalString());
     }else {
         log:printError(response.message());
     }
}

