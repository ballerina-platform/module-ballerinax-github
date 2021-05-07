# Ballerina GitHub Endpoint

[![Build Status](https://travis-ci.org/ballerina-platform/module-ballerinax-github.svg?branch=master)](https://travis-ci.org/ballerina-platform/module-ballerinax-github)

Connects to GitHub using Ballerina.

# Introduction

## What is GitHub?

[GitHub](https://github.com/) brings together the world's largest community of developers to discover, share, and build better software. From open source projects to private team repositories, GitHub is an all-in-one platform for collaborative development.

## Key Features of GitHub

- Collaboration
- Integrated issue and bug tracking
- Code review
- Project management
- Team management
- Documentation
- Track and assign tasks
- Propose changes

![Ballerina GitHub Endpoint Overview](../docs/resources/BallerinaGitHubEndpoint_Overview.jpg)

## Connector Overview

Github Ballerina Connector is used to connect with the GitHub to perform operations exposed by GitHub GraphQL. Also, it provides easy integration with GitHub webhooks

The connector provides auto completion and type conversions. The following
sections explains how to use Ballerina GitHub connector. You can refer the [GitHub GraphQL API v4.0](https://developer.github.com/v4/) and [GitHub Webhooks](https://developer.github.com/webhooks/) to learn more about the APIs.

# Prerequisites

* GitHub Account

* Ballerina Swan Lake Alpha5 Installed

* [Personal Access Token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) or [GitHub OAuth App token](https://docs.github.com/en/developers/apps/creating-an-oauth-app).

# Supported Versions & Limitations

## Supported Versions

|                                   | Version               |
|:---------------------------------:|:---------------------:|
| GitHub GraphQL API                | v4                    |
| Ballerina Language                | Swan Lake Alpha 5     |
| Java Development Kit (JDK)        | 11                    |

# Quickstart(s)

## Client Side Operation Example: Get Issue List.

In an occasion when we need to obtain the list of issues associated with a repository, we can use the `getIssues`

### Step 1: Import the GitHub ballerina library.
First, import the `ballerinax/github` module into a ballerina project.
```ballerina
    import ballerinax/github;
```

### Step 2: Initialize the GitHub client.
You can now make the connection configuration using the personal access token, or the obtained oAuth app token.

```ballerina
    configurable string accessToken = ?;

    github:Configuration config = {
        token: accessToken
    };

    github:Client githubClient = new (config);

```

### Step 3: Initialize the required parameters
Initialize variables with suitable values which needs to be passed as arguments to the client remote function.

```ballerina
    int recordCount = 10; // number of issues per page.
    string repositoryOwner = "";
    string repositoryName = "";
```

### Step 4: Invoke the client remote function and obtain the results.

```ballerina
    var issueList = githubClient->getRepositoryIssueList(repositoryOwner, repositoryName, [github:ISSUE_OPEN], recordCount);
    if (issueList is github:IssueList) {
        log:printInfo(string `Issue List: ${issueList.nodes.length()} Issues found`);
    } else {
        log:printError("Error: "+ issueList.toString());
    }
```


## Listener Side Operation Example: On one or more commits are pushed to a repository branch or tag.

### Step 1: Import the GitHub Webhook ballerina library.
First, import the `ballerinax/github.webhook` module and `ballerina/websub` module into a ballerina project.
```ballerina
    import ballerina/websub;
    import ballerinax/github.webhook as github;
```

### Step 2: Initialize the GitHub Webhook Listener.
Initialize the Webhook Listener by providing the port number.

```ballerina
    listener github:Listener webhookListener = new (9090);
```

### Step 3: Annotate the service with websub:SubscriberServiceConfig.
Annotate the service with `websub:SubscriberServiceConfig` providing necessary properties.

```ballerina
@websub:SubscriberServiceConfig {
    target: [github:HUB, githubTopic],
    secret: githubSecret,
    callback: githubCallback,
    httpConfig: {
        auth: {
            token: accessToken
        }
    }
}
service /subscriber on webhookListener {
   
}
```

### Step 4: Provide remote functions corresponding to the events which you are interested on.

```ballerina
    remote function onPush(github:PushEvent event) returns github:Acknowledgement? {
        log:printInfo("Received push-event-message ", eventPayload = event);
    }
```
