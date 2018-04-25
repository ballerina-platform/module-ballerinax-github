Connects to the GitHub GraphQL API from Ballerina.

# Package Overview

This package provides a Ballerina API to access the GitHub GraphQL API. It has built-in support for operations related to projects, pull requests, and issues. It handles OAuth2.0 and provides auto completion and type conversions. The following sections explain how to use the Ballerina GitHub4 connector. Visit [GitHub GraphQL API v4.0](https://developer.github.com/v4/) to learn more about the API.

**Project Operations**

The `wso2/github4` package covers most of the project-related operations including columns and cards. It returns the information in structs that can be easily accessed.

**Pull Request Operations**

This package can retrieve pull requests from GitHub GraphQL. It returns comprehensive data structures for various data segments returned by the GraphQL API.

**Issues Operations**

The `wso2/github4` package has support for creating and listing issues.


## Compatibility
|                                 |       Version                  |
|  :---------------------------:  |  :---------------------------: |
|  Ballerina Language Version     |   0.970.0-beta15               |
|  GitHub API Version             |   V4                           |

## Sample

First, import the `wso2/github4` package into the Ballerina project.

```ballerina
import wso2/github4;
```

**Obtaining the Access Token to Run the Sample**

1. In your [GitHub profile settings](https://github.com/settings/profile), go to **Developer settings -> Personal access tokens**.
2. Generate a new token to access the GitHub API.

You can now enter the access token in the HTTP client config.
```ballerina
endpoint github4:Client githubEP {
    clientConfig: {
        auth:{
            scheme:"oauth",
            accessToken:config:getAsString("GITHUB_TOKEN")
        }
    }
};
```

The `getRepository` function gets a GitHub repository by passing the name of the repository and its owner in the format of "owner/repository".
```ballerina
var repo = githubEP -> getRepository("wso2-ballerina/package-github");
```

The response from `getRepository` is either a `Repository` object (if the request was successful) or a `GitClientError` (if the request was unsuccessful). The `match` operation can be used to handle the response if an error occurs.
```ballerina
match repo {
    github4:Repository repository => io:println(repository);
    github4:GitClientError err => io:println(err);
}
```

The `getIssueList` function gets a list of issues for a given repository by providing the `Repository` object, state of the issue, and the number of records to read.

```ballerina
github4:Repository issueRepository = {owner:{login:"wso2"}, name:"carbon-apimgt"};
var issues = githubEP -> getIssueList(issueRepository, STATE_CLOSED, recordCount);
```

The response from `getIssueList` is either an `IssueList` object (if the request was successful) or a `GitClientError` (if the request was unsuccessful).

```ballerina
match issues {
    github4:IssueList issueList => io:println(issueList);
    github4:GitClientError err => io:println(err);
}
```

The `createIssue` function creates a new issue in a given repository.

```ballerina
var createdIssue = githubEP -> createIssue (repositoryOwner, repositoryName, issueTitle, issueContent, labelList, assigneeList);
```

It returns the created `Issue` object if successful or `GitClientError` if unsuccessful.

```ballerina
match createdIssue {
    github4:Issue issue => io:println(issue);
    github4:	GitClientError err => io:println(err);
}
```
