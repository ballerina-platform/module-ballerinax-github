# Ballerina GitHub Webhook - Tests

### Prerequisites

- Download and install [Ballerina](https://ballerinalang.org/downloads/).
- Install [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) and setup the [ngrok](https://developer.bigcommerce.com/api-docs/getting-started/webhooks/setting-up-webhooks).
- Obtaining the Access Token to run the Sample
    - In your [GitHub profile settings](https://github.com/settings/profile), click **Developer settings**, and then click **Personal access tokens**.
    - Generate a new token with at least the `admin:repo_hook` scope for webhook-related functionality.

> Need to be start the `ngork` with `webhook:Listener` service port by using the command `./ngrok http 8080`
    
## Running tests

Specifies the obtained token, topic, callback URL and optionally the secret in a `ballerina.conf` file in the project. Also, include the username and repository name, which will be used for testing.

```.conf
GITHUB_TOKEN="ACCESS_TOKEN"
GITHUB_TOPIC="GITHUB_TOPIC"
GITHUB_SECRET="GITHUB_SECRET"
GITHUB_CALLBACK="GITHUB_CALLBACK"
GITHUB_USERNAME="GITHUB_USERNAME"
GITHUB_REPO_NAME="GITHUB_REPO_NAME"
```

**Note:** Prior to running the tests, Webhooks that are already added with the same callback URL need to be removed, in order to trigger the `ping` notification.

Assign the values for the accessToken, topic, callback URL and secret inside the constructed endpoint in main_test.bal using either of the way following ways.
```ballerina
oauth2:DirectTokenConfig oauth2Config = {
    accessToken: config:getAsString("GITHUB_TOKEN")
};
oauth2:OutboundOAuth2Provider oauth2Provider = new(oauth2Config);
http:BearerAuthHandler bearerHandler = new(oauth2Provider);
@websub:SubscriberServiceConfig {
    path: "/github",
    subscribeOnStartUp: true,
    target: [HUB, config:getAsString("GITHUB_TOPIC")],
    secret: config:getAsString("GITHUB_SECRET"),
    callback: config:getAsString("GITHUB_CALLBACK"),
    hubClientConfig: {
        auth: {
            authHandler: bearerHandler
        }
    }
}
```

Execute the below command to run the tests:
```
ballerina test github.webhook
```
