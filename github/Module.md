Registers a GitHub webhook.

# Module Overview

This module allows programmatically registering a [GitHub webhook](https://developer.github.com/webhooks/), 
to subscribe to GitHub events one is interested in.

The webhook callback is represented by a service that listens on a listener of type `github:WebhookListener`.
The resources allowed in this service map to possible GitHub events (e.g., `onIssueCommentCreated`, 
`onIssueCommentEdited`, `onIssuesAssigned`, `onIssuesClosed`, etc.). 
The first parameter of each resource is the generic `websub:Notification` record. The second parameter of each 
resource is a `record` mapping the `json` payload that is expected for each event (e.g., `github:IssueCommentEvent`, 
`github:IssuesEvent`, etc.).

This module supports the following functionality:
- Programmatic subscription (requires a GitHub access token), alternatively a webhook can also be registered via the UI
- Authenticated content distribution (if a webhook was registered specifying a secret, signature validation would 
be done for each content delivery request)
- Data binding of the `json` payload for each event to a `record` mapping the same
- Programmatic response to all content delivery requests - an appropriate response is sent for all content delivery 
requests, prior to dispatching them to the relevant resource

## Compatibility
|                             |       Version               |
|:---------------------------:|:---------------------------:|
| Ballerina Language          | 0.990.0                     |

## Sample

First, import the `wso2/github` module into the Ballerina project.

```ballerina
import wso2/github;
```

**Obtaining the Access Token to Run the Sample**

1. In your [GitHub profile settings](https://github.com/settings/profile), go to **Developer settings -> Personal access tokens**.
2. Generate a new token with at least the `admin:repo_hook` scope for webhook related functionality.

This access token needs to be specified when specifying the subscription parameters as the service annotation.
```ballerina
@websub:SubscriberServiceConfig {
   path:"/webhook",
   subscribeOnStartUp: true,
   hub: github:HUB,
   topic: "https://github.com/<GH_USERNAME>/<GH_REPO_NAME>/events/*.json", // for all events
   secret: "<SECRET>",
   subscriptionClientConfig: {
        auth: {
            scheme:http:OAUTH2,
            accessToken:"<GH_ACCESS_TOKEN>"
        }
   }
}
```

Introducing a service as follows, with `subscribeOnStartUp` set to `true` in the service annotation, would result in 
a subscription request being sent to the `github:HUB`, for the specified topic. If successful, GitHub would send a 
`ping` request, that could be received by introducing an `onPing` resource.

Additionally, the following sample code also accepts notifications when an issue is opened (`onIssuesOpened`) and 
when the repository is starred (`onWatch`).

```ballerina
import ballerina/http;
import ballerina/io;
import ballerina/websub;
import wso2/github;

listener github:WebhookListener githubListener = new(8080);

@websub:SubscriberServiceConfig {
   path:"/webhook",
   subscribeOnStartUp: true,
   hub: github:HUB,
   topic: "https://github.com/<GH_USERNAME>/<GH_REPO_NAME>/events/*.json", // for all events
   secret: "<SECRET>",
   callback: "<CALLBACK_URL>", // only needs to be specified if not http(s)://<HOST>:<PORT>/<path>
   subscriptionClientConfig: {
        auth: {
            scheme:http:OAUTH2,
            accessToken:"<GH_ACCESS_TOKEN>"
        }
   }
}
service githubWebhook on githubListener {

    resource function onPing(websub:Notification notification, github:PingEvent event) {
        io:println("[onPing] Webhook Registered: ", event);
    }

    resource function onIssuesOpened(websub:Notification notification, github:IssuesEvent event) {
        io:println("[onIssuesOpened] Issue ID: ", event.issue.number);
    }

    resource function onWatch(websub:Notification notification, github:WatchEvent event) {
        io:println("[onWatch] Repository starred by: ", event.sender);
    }
}
```

Now, every time an issue is opened in the repository or when the repository is starred, a content delivery request 
will be received at the relevant resources.
