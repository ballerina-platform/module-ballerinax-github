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

![Ballerina GitHub Endpoint Overview](./docs/resources/BallerinaGitHubEndpoint_Overview.jpg)

## Connector Overview

Github Ballerina Connector is used to connect with the GithHub to perform operations exposed by GitHub GraphQL and REST API. Also it provides easy integration with GitHub webhooks

The connector has built-in support to handle OAuth2.0, provides auto completion and type conversions. The following
sections explains how to use Ballerina GitHub connector. You can refer the [GitHub GraphQL API v4.0](https://developer.github.com/v4/), [GitHub REST API v3.0](https://docs.github.com/en/rest) and [GitHub Webhooks](https://developer.github.com/webhooks/) to learn more about the APIs.

# Prerequisites

* GitHub Account

* Ballerina SL Alpha2 Installed
  Ballerina Swan Lake Alpha2 Version is required.

* [Personal Access Token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) or [GitHub OAuth App token](https://docs.github.com/en/developers/apps/creating-an-oauth-app).

# Supported Versions & Limitations

## Supported Versions

|                                   | Version               |
|:---------------------------------:|:---------------------:|
| GitHub REST API                   | v3                    |
| GitHub GraphQL API                | v4                    |
| Ballerina Language                | Swan Lake Alpha 2     |
| Java Development Kit (JDK)        | 11                    |

## Limitations
--



# Quickstart(s)

**Add project configurations file**

Add the project configuration file by creating a `Config.toml` file under the root path of the project structure.
This file should have following configurations. Add the tokens obtained in the previous step to the `Config.toml` file.

#### For client operations
```
[ballerinax.github]
accessToken = "<access_token>"
testUserName = "<>"
testRepositoryName = "<>"
testIssueAssignee = "<>"
testResourcePath = "<>"
testOrganizationName = "<>"
```

#### For listener operations
```
[ballerinax.github.webhook]
accessToken = "<access_token>"
githubTopic = "<topic_to_subscribe>"
githubSecret = "<github_secret>"
githubCallback = "<webhook_callback_url>"
testUserName = "<github_username>"
testRepositoryName = "<github_repository>"
testIssueAssignee = "<github_issue_assignee>"
testResourcePath = "<github_resource_path>"
testOrganizationName = "<github_organization_name>"
```

## Get Issue List.

In an occation when we need to obtain the list of isssues associated with a repository, we can use the `getIssues`

### Step 1: Import the GitHub ballerina library.
First, import the ballerinax/github module into a ballerina project.
```ballerina
    import ballerinax/github;
```

### Step 2: Initialize the GitHub client.
You can now make the connection configuration using the personal access token or the obtained oAuth app token.

```ballerina
    configurable string accessToken = ?;

    github:GitHubConfiguration config = {
        token: accessToken
    };

    github:Client githubClient = new (config);

    int recordCount = 10;
    string repositoryOwner = "";
    string repositoryName = "";
    
    var issueList = githubClient->getIssueList([repositoryOwner, repositoryName], github:STATE_OPEN, recordCount);
    if (issueList is github:IssueList) {
        log:print(string `Issue List: ${issueList.getAllIssues().length()} Issues found`);
    } else {
        log:printError("Error: "+ issueList.toString());
    }
```

### Step 3: Initializa the required parameters
Initialize variables with suitable values which needs to be passed as arguments to the client remote function.

```ballerina
    int recordCount = 10; // number of issues per page.
    string repositoryOwner = "";
    string repositoryName = "";
```

### Step 4: Invoke the client remote function and obtain the results.

```ballerina
    var issueList = githubClient->getIssueList([repositoryOwner, repositoryName], github:STATE_OPEN, recordCount);
    if (issueList is github:IssueList) {
        log:print(string `Issue List: ${issueList.getAllIssues().length()} Issues found`);
    } else {
        log:printError("Error: "+ issueList.toString());
    }
```


# Samples

Samples are available at : https://github.com/ballerina-platform/module-ballerinax-github/samples

## GitHub Client Operations

* ### [Create Gist](https://github.com/ballerina-platform/module-ballerinax-github/samples/create_gist.bal)
* ### [Create Issue](https://github.com/ballerina-platform/module-ballerinax-github/samples/create_issue.bal)
* ### [Create Pull Request Review](https://github.com/ballerina-platform/module-ballerinax-github/samples/create_pull_request_review.bal)
* ### [Create Pull Request Review Comment](https://github.com/ballerina-platform/module-ballerinax-github/samples/create_pull_request_review_comment.bal)
* ### [Create Pull Request](https://github.com/ballerina-platform/module-ballerinax-github/samples/create_pull_request.bal)
* ### [Delete Branch](https://github.com/ballerina-platform/module-ballerinax-github/samples/delete_branch.bal)
* ### [Get Branch List](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_branch_list.bal)
* ### [Get Project Card List Next Page](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_cardlist_nextpage.bal)
* ### [Get Project Column List](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_project_column_list.bal)
* ### [Get Project Column List Next Page](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_columnlist_nextpage.bal)
* ### [Get Issue List](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_issue_list.bal)
* ### [Get An Issue](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_issue.bal)
* ### [Get Issue List Next Page](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_issuelist_nextpage.bal)
* ### [Get Organization Project](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_organization_project.bal)
* ### [Get Organization Project List](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_organization_projectlist.bal)
* ### [Get Organization Repository List](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_organization_repository_list.bal)
* ### [Get Organization Repository List Next Page](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_repository_list_next_page.bal)
* ### [Get Organization User Membership](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_organization_user_membership.bal)
* ### [Get an Organization](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_organization.bal)
* ### [Get Project List Next Page](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_project_list_next_page.bal)
* ### [Get Pull Request List](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_pull_request_list.bal)
* ### [Get Pull Request List Next Page](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_pull_request_list_next_page.bal)
* ### [Get Repository Project List](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_repository_project_list.bal)
* ### [Get A Repository Project](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_repository_project.bal)
* ### [Get Repository](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_repository.bal)
* ### [Get User Repository List](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_user_repository_list.bal)
* ### [Get An User](https://github.com/ballerina-platform/module-ballerinax-github/samples/get_user.bal)
* ### [Update An Issue](https://github.com/ballerina-platform/module-ballerinax-github/samples/update_issue.bal)
* ### [Update A Pull Request](https://github.com/ballerina-platform/module-ballerinax-github/samples/update_pull_request.bal)


## GitHub Webhook Operations








***