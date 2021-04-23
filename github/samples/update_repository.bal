import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> updateRepository()");

    string repositoryOwnerName = "";
    string repositoryName = "";

    github:UpdateRepositoryInput updateRepositoryInput = {
        description: "New Updated Description"
    };
    var response = githubClient->updateRepository(updateRepositoryInput, repositoryOwnerName, repositoryName);

    if(response is error){
        log:printError(response.message());
    }else {
        log:printInfo("Successfully updated");
    }
}


