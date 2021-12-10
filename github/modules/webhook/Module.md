
## Overview
The GitHub connector Listener module allows you to listen to following events occur in GitHub. 
- `Ping`, `Fork`, `Push`, `Create`, `Watch`
- `Release`, `Issue`, `Label`, `Milestone`
- `Pull Request`, `Pull Request Review`, `Pull Request Review Comment`

This module supports [GitHub API](https://docs.github.com/en/graphql) v4 version and only allows to perform functions behalf of the currently logged in user.


## Prerequisites
Before using this connector in your Ballerina application, complete the following:

* Create account
* Obtain token -
To obtain a personal access token via which the connector can access the API, follow these [steps](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token)

* Configure the connector with obtained token

## Quickstart
To use the GitHub connector in your Ballerina application, update the  .bal file as follows:

### Step 1: Import the GitHub Webhook Ballerina library
First, import the ballerinax/github.webhook and ballerina/websub modules into the Ballerina project as follows.

```ballerina
    import ballerina/websub;
    import ballerinax/github.webhook as github;
```

### Step 2: Initialize the GitHub Webhook Listener
Initialize the Webhook Listener by providing the port number.

```ballerina
    listener github:Listener webhookListener = new (9090);
```

### Step 3: Annotate the service with websub:SubscriberServiceConfig
Annotate the service with websub:SubscriberServiceConfig by providing necessary properties as follows.

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

### Step 4: Provide remote functions corresponding to the events which you are interested on
The remote functions can be provided as follows.

```ballerina
    remote function onPush(github:PushEvent event) returns github:Acknowledgement? {
        log:printInfo("Received push-event-message ", eventPayload = event);
    }
```
### Step 5: Run the service 
Use `bal run` command to compile and run the Ballerina program.    

