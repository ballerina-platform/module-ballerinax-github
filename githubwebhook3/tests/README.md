# Ballerina GitHub Webhook - Tests

## Running tests

In order to run the tests, the user will need to have a GitHub Personal Access Token with the `admin:repo_hook` and `repo` scopes. The token can be obtained by visiting

**https://github.com/{profile} -> Settings -> Developer Settings -> Personal access tokens**

Specify the obtained token along with the topic and optionally the callback URL and secret in a `ballerina.conf` file in the project. Also include the username and repository name against which testing will be done.

```.conf
GITHUB_TOKEN="ACCESS_TOKEN"
GITHUB_TOPIC="GITHUB_TOPIC"
GITHUB_SECRET="GITHUB_SECRET"
GITHUB_CALLBACK="GITHUB_CALLBACK"
GITHUB_USERNAME="GITHUB_USERNAME"
GITHUB_REPO_NAME="GITHUB_REPO_NAME"
```

**Note: Webhooks already added with the same callback URL need to be removed, prior to running the tests, in order to trigger the `ping` notification**

```ballerina
@websub:SubscriberServiceConfig {
    path: "/webhook",
    subscribeOnStartUp: true,
    hub: githubwebhook3:HUB,
    topic: config:getAsString("GITHUB_TOPIC"), 
    secret: config:getAsString("GITHUB_SECRET"),
    callback: config:getAsString("GITHUB_CALLBACK"), // only needs to be specified if not http(s)://<HOST>:<PORT>/<path>
    subscriptionClientConfig: {
        auth: {
            scheme: http:OAUTH2,
            accessToken: config:getAsString("GITHUB_TOKEN")
        }
    }
}
```

Run tests :
```
ballerina test githubwebhook3
```
