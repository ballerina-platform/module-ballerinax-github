import ballerina/log;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: "<access_token>"
};

github:Client githubClient = new (gitHubConfig);

public function main() {
    log:printInfo("githubClient -> getUserId()");

    string username = "";

    var response = githubClient->getUserId(username);
    if(response is string){
       log:printInfo(response.toBalString());
    }else {
       log:printInfo(response.message());
    }
}

