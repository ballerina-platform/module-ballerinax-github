# Ballerina GitHub Endpoint

###### GitHub brings together the world's largest community of developers to discover, share, and build better software. From open source projects to private team repositories, GitHub is an all-in-one platform for collaborative development.

The Ballerina GitHub endpoint allow users to access the GitHub API through ballerina. This endpoint uses the GitHub GraphQL API v4.0

|Ballerina Version | GitHub API Version |
|------------------| ------------------ |
|0.970.0-beta2-SNAPSHOT | v4 |

![Ballerina GitHub Endpoint Overview](./docs/resources/BallerinaGitHubEndpoint_Overview.jpg)

##### Prerequisites
Download the ballerina [distribution](https://ballerinalang.org/downloads/).

### Getting started

* Clone the repository by running the following command
```
git clone https://github.com/wso2-ballerina/package-github
```

* Initialize the ballerina project.
```
ballerina init
```

### Working with GitHub Endpoint Actions

All the actions return `objects` or `github4:GitClientError`. If the action was a success, then the requested object will be returned while the `github:GitClientError` will be **empty** and vice-versa.

##### Example
* Request 
```ballerina
    import wso2/github4;

    public function main (string[] args) {
        endpoint github4:Client githubClient {
            clientEndpointConfiguration: {
                auth:{
                    scheme:"oauth",
                    accessToken:config:getAsString("GITHUB_TOKEN")
                }
            }
        };
    
        github4:Repository repository = {};
        var repo = githubClient -> getRepository("wso2-ballerina/package-github");
        match repo {
            github4:Repository rep => {
                repository = rep;
            }
            github4:GitClientError err => {
                io:println(err);
            }
        }
    
        io:println(repository);
    }
    
```

* Response object
```ballerina
public type Repository {
    string id;
    string name;
    string createdAt;
    string updatedAt;
    string description;
    int forkCount;
    boolean hasIssuesEnabled;
    boolean hasWikiEnabled;
    string homepageUrl;
    boolean isArchived;
    boolean isFork;
    boolean isLocked;
    boolean isMirror;
    boolean isPrivate;
    string license;
    string lockReason;
    string mirrorUrl;
    string url;
    string sshUrl;
    RepositoryOwner owner;
    Language primaryLanguage;
}
```

***
