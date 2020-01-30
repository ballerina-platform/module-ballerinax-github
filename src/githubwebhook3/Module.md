Registers a GitHub webhook.

# Module Overview

This module allows registering a [GitHub webhook](https://developer.github.com/webhooks/) programmatically, 
to subscribe to interested GitHub events.

The webhook callback is represented by a service that listens on a listener of type `githubwebhook3:Listener`.
The resources allowed in this service map to possible GitHub events (e.g., `onIssueCommentCreated`, 
`onIssueCommentEdited`, `onIssuesAssigned`, `onIssuesClosed`, etc.). 
The first parameter of each resource is the generic `websub:Notification` record. The second parameter of each 
resource is a `record`, mapping the `json` payload that is expected with each event (e.g., `githubwebhook3:IssueCommentEvent`, 
`githubwebhook3:IssuesEvent`, etc.).

This module supports the following functionalities:
- Programmatic subscription (requires a GitHub access token). Alternatively, a webhook can also be registered via the UI.
- Authenticated content distribution (If a webhook was registered specifying a secret, signature validation would 
be done for each content delivery request.)
- Data binding of the `json` payload for each event, to a `record` mapping the same
- Programmatic response to all content delivery requests - an appropriate response is sent for all content delivery 
requests, prior to dispatching them to the relevant resource.

## Compatibility
|                             |       Version               |
|:---------------------------:|:---------------------------:|
| Ballerina Language          | 1.1.x                     |

## Sample

First, import the `wso2/githubwebhook3` module into the Ballerina project.

```ballerina
import wso2/githubwebhook3;
```

**Obtaining the Access Token to run the Sample**

1. In your [GitHub profile settings](https://github.com/settings/profile), click **Developer settings**, and then click **Personal access tokens**.
2. Generate a new token with at least the `admin:repo_hook` scope for webhook-related functionality.

This access token needs to be specified when configuring the subscription parameters of the service annotation.
```ballerina
@websub:SubscriberServiceConfig {
   path: "/webhook",
   subscribeOnStartUp: true,
   target: [githubwebhook3:HUB, "https://github.com/<GH_USERNAME>/<GH_REPO_NAME>/events/*.json"],
   hubClientConfig: {
       auth: {
           authHandler: githubOAuth2Handler
       }
   },
   callback: "<CALLBACK_URL>"
}
```

Introducing a service as follows, with the value of the `subscribeOnStartUp` parameter set to `true` in the service annotation would result in 
a subscription request being sent to the `githubwebhook3:HUB` for the specified topic. If successful, GitHub would send a 
`ping` request that could be received by introducing an `onPing` resource.

Additionally, the following sample code also accepts notifications when an issue is opened (`onIssuesOpened`) and 
when the repository is starred (`onWatch`).

```ballerina
import ballerina/io;
import ballerina/websub;
import ballerina/http;
import ballerina/oauth2;
import wso2/githubwebhook3;

listener githubwebhook3:Listener githubListener = new(8080);

oauth2:OutboundOAuth2Provider githubOAuth2Provider = new({
    accessToken: "<GH_ACCESS_TOKEN>"
});
http:BearerAuthHandler githubOAuth2Handler = new(githubOAuth2Provider);

@websub:SubscriberServiceConfig {
   path: "/webhook",
   subscribeOnStartUp: true,
   target: [githubwebhook3:HUB, "https://github.com/<GH_USERNAME>/<GH_REPO_NAME>/events/*.json"],
   hubClientConfig: {
       auth: {
           authHandler: githubOAuth2Handler
       }
   },
   callback: "<CALLBACK_URL>"
}
service githubWebhook on githubListener {

    resource function onPing(websub:Notification notification, githubwebhook3:PingEvent event) {
        io:println("[onPing] Webhook Registered: ", event);
    }

    resource function onIssuesOpened(websub:Notification notification, githubwebhook3:IssuesEvent event) {
        io:println("[onIssuesOpened] Issue ID: ", event.issue.number);
    }

    resource function onWatch(websub:Notification notification, githubwebhook3:WatchEvent event) {
        io:println("[onWatch] Repository starred by: ", event.sender);
    }
}
```

Now, every time an issue is opened in the repository or when the repository is starred, a content delivery request 
will be received at the relevant resource.
