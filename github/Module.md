
## Overview

This GitHub connector client module provides capability to perform operations on major resource types such as `Repositories`, `Issues`, `Pull Requests`, `Projects` etc.

This module supports [GitHub API](https://docs.github.com/en/graphql) v4 version and only allows to perform functions behalf of the currently logged in user.

## Prerequisites
Before using this connector in your Ballerina application, complete the following:

* Create account
* Obtain token
Follow the [steps](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token)  to obtain a Personal Access Token in order to access the API.

* Configure the connector with obtained token

## Quickstart

To use the GitHub connector in your Ballerina application, update the .bal file as follows:

### Step 1: Import connector
First, import the ballerinax/github module into the Ballerina project.
```ballerina
import ballerinax/github;
```
### Step 2: Create a new connector instance
You can now make the connection configuration using the OAuth2 refresh token grant config.
```ballerina

    github:Configuration config = {
        token: accessToken
    };

    github:Client githubClient = new (config);

```
### Step 3: Invoke connector operation
- Get All Open Pull Requests In A Repository
```ballerina
    github:PullRequestList response = check githubClient->getRepositoryPullRequestList(<GitHub_Username>, <GitHub_Repository_Name>, github:PULL_REQUEST_OPEN, <Per_Page_Count>);
```
- Use `bal run` command to compile and run the Ballerina program.    


**[You can find a list of samples here](https://github.com/ballerina-platform/module-ballerinax-github/tree/master/github/samples)**
