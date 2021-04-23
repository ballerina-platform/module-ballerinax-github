import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getAuthenticatedUser()");
    var response = githubClient->getAuthenticatedUser();
    if(response is github:User){
       log:printInfo(response.toBalString());
    }else {
       log:printInfo(response.message());
    }
}

