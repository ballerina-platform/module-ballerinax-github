[![Build Status](https://travis-ci.org/ballerina-platform/module-ballerinax-github.svg?branch=master)](https://travis-ci.org/ballerina-platform/module-ballerinax-github)

# Ballerina GitHub Endpoint

###### GitHub brings together the world's largest community of developers to discover, share, and build better software. From open source projects to private team repositories, GitHub is an all-in-one platform for collaborative development.

GitHub connector provides Ballerina APIs to access
- GitHub GraphQL API
- Ballerina API to access the Github Webhook

The connector has built-in support to handle OAuth2.0, provides auto completion and type conversions. The following 
sections explains how to use Ballerina GitHub connector. You can refer the [GitHub GraphQL API v4.0](https://developer.github.com/v4/) and [GitHub Webhooks](https://developer.github.com/webhooks/) to learn more about the APIs. 

| Ballerina Version  | GitHub API Version |
|--------------------|--------------------|
| Swan Lake Preview 8|        v4          |

![Ballerina GitHub Endpoint Overview](./docs/resources/BallerinaGitHubEndpoint_Overview.jpg)

##### Prerequisites
Download the ballerina [distribution](https://ballerinalang.org/downloads/).

### Getting started

* Clone the repository by running the following command
```shell
git clone https://github.com/ballerina-platform/module-github
```

* Initialize the ballerina project.
```shell
ballerina init
```

### Working with GitHub Endpoint Actions

All the actions return a `record` or an `object`, or an `error`. If the action was a success, then the requested `object` or `record` will be returned while the `error` will be **empty** and vice-versa.

##### Example
* Request

```ballerina
import ballerina/config;
import ballerina/http;
import ballerina/io;
import ballerinax/github;

github:GitHubConfiguration gitHubConfig = {
    accessToken: "access_token"
};
 
github:Client githubClient = new (gitHubConfig);

public function main() {
    github:Repository|error result = githubClient->getRepository("ballerina-platform/module-github");
    if (result is github:Repository) {
        io:println("Repository ballerina-platform/module-github: ", result);
    } else {
        io:println("Error occurred on getRepository(): ", result);
    }
}
```

* The type descriptor of the `record` that will be returned on success
```ballerina
public type Repository record {
    string id = "";
    string name = "";
    string createdAt = "";
    string updatedAt = "";
    string description = "";
    int forkCount = 0;
    boolean hasIssuesEnabled = false;
    boolean hasWikiEnabled = false;
    boolean isArchived = false;
    boolean isFork = false;
    boolean isLocked = false;
    boolean isMirror = false;
    boolean isPrivate = false;
    string homepageUrl = "";
    string lockReason = "";
    string mirrorUrl = "";
    string url = "";
    string sshUrl = "";
    RepositoryOwner owner = {};
    Language primaryLanguage = {};
    int stargazerCount = 0;
}
```

### Working with GitHub Webhook

This module allows registering a [GitHub webhook](https://developer.github.com/webhooks/) programmatically, 
to subscribe to interested GitHub events.

The webhook callback is represented by a service that listens on a listener of type `webhook:Listener`.
The resources allowed in this service map to possible GitHub events (e.g., `onIssueCommentCreated`, 
`onIssueCommentEdited`, `onIssuesAssigned`, `onIssuesClosed`, etc.). 
The first parameter of each resource is the generic `websub:Notification` record. The second parameter of each 
resource is a `record`, mapping the `json` payload that is expected with each event (e.g., `webhook:IssueCommentEvent`, 
`webhook:IssuesEvent`, etc.).

The following sections provide you details on how to use the `webhook`.

- [Compatibility](#compatibility)
- [Feature Overview](#feature-overview)
- [Getting Started](#getting-started)
- [Sample](#sample)

## Compatibility
| Ballerina Language Version|
|:--------------------------|
|    Swan Lake Preview 8    |

## Feature Overview

This module supports the following functionalities:
- Programmatic subscription (requires a GitHub access token). Alternatively, a webhook can also be registered via the UI.
- Authenticated content distribution (If a webhook was registered specifying a secret, signature validation would 
be done for each content delivery request.)
- Data binding of the `json` payload for each event, to a `record` mapping the same
- Programmatic response to all content delivery requests - an appropriate response is sent for all content delivery 
requests, prior to dispatching them to the relevant resource.

# Getting Started

### Prerequisites

- Download and install [Ballerina](https://ballerinalang.org/downloads/).
- Install [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) and setup the [ngrok](https://developer.bigcommerce.com/api-docs/getting-started/webhooks/setting-up-webhooks).
- Obtaining the Access Token to run the Sample
    - In your [GitHub profile settings](https://github.com/settings/profile), click **Developer settings**, and then click **Personal access tokens**.
    - Generate a new token with at least the `admin:repo_hook` scope for webhook-related functionality.

> Need to be start the `ngork` with `webhook:Listener` service port by using the command `./ngrok http 8080`

### Sample

Access token, callback URL(eg: `http://1c9b0ff10cea.ngrok.io/webhook`), username and repository name need to be specified when configuring the subscription parameters of the service annotation.
```ballerina
oauth2:OutboundOAuth2Provider githubOAuth2Provider = new ({
    accessToken: "<GH_ACCESS_TOKEN>"
});
http:BearerAuthHandler githubOAuth2Handler = new (githubOAuth2Provider);

@websub:SubscriberServiceConfig {
    subscribeOnStartUp: true,
    target: [webhook:HUB, config:getAsString("TOPIC_GITHUB")],
    secret: config:getAsString("SECRET_GITHUB"),
    callback: config:getAsString("CALLBACK_GITHUB"),
    hubClientConfig: {
        auth: {
            authHandler: githubOAuth2Handler
        }
    }
}
```

Introducing a service as follows, with the value of the `subscribeOnStartUp` parameter set to `true` in the service annotation would result in 
a subscription request being sent to the `webhook:HUB` for the specified topic. If successful, GitHub would send a 
`ping` request that could be received by introducing an `onPing` resource.

The following sample code also accepts notifications when an issue is opened (`onIssuesOpened`) and when the repository is starred (`onWatch`).

```ballerina
import ballerina/http;
import ballerina/io;
import ballerina/oauth2;
import ballerina/websub;
import ballerinax/github.webhook;

listener webhook:Listener githubListener = new (8080);

oauth2:OutboundOAuth2Provider githubOAuth2Provider = new ({
    accessToken: "<GH_ACCESS_TOKEN>"
});
http:BearerAuthHandler githubOAuth2Handler = new (githubOAuth2Provider);

@websub:SubscriberServiceConfig {
    subscribeOnStartUp: true,
    target: [webhook:HUB, config:getAsString("TOPIC_GITHUB")],
    secret: config:getAsString("SECRET_GITHUB"),
    callback: config:getAsString("CALLBACK_GITHUB"),
    hubClientConfig: {
        auth: {
            authHandler: githubOAuth2Handler
        }
    }
}
service websub:SubscriberService /github on githubListener {
    
    remote function onPing(websub:Notification notification, webhook:PingEvent event) {
        io:println("[onPing] Webhook Registered: ", event);
    }

    remote function onIssuesOpened(websub:Notification notification, webhook:IssuesEvent event) {
        io:println("[onIssuesOpened] Issue ID: ", event.issue.number);
    }

    remote function onWatch(websub:Notification notification, webhook:WatchEvent event) {
        io:println("[onWatch] Repository starred by: ", event.sender);
    }
}
```

***
