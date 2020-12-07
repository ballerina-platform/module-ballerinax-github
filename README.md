[![Build Status](https://travis-ci.org/ballerina-platform/module-github.svg?branch=master)](https://travis-ci.org/ballerina-platform/module-github)

# Ballerina GitHub Endpoint

###### GitHub brings together the world's largest community of developers to discover, share, and build better software. From open source projects to private team repositories, GitHub is an all-in-one platform for collaborative development.

GitHub connector provides a Ballerina API to access the GitHub GraphQL API. 
The connector has built-in support to handle OAuth2.0, provides auto completion and type conversions. The following 
sections explains how to use Ballerina GitHub connector. You can refer the [GitHub GraphQL API v4.0]
(https://developer.github.com/v4/) to learn more about the API. 

| Ballerina Version | GitHub API Version |
|-------------------|--------------------|
| Swan Lake Preview7| v4                 |

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

***
