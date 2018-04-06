# Ballerina GitHub Connector - GitHub API v4

###### GitHub brings together the world's largest community of developers to discover, share, and build better software. From open source projects to private team repositories, GitHub is an all-in-one platform for collaborative development.

The Ballerina GitHub connector allow users to access the GitHub API through ballerina. This connector uses the GitHub GraphQL API v4.0

|Ballerina Version | Connector Version | GitHub API Version |
|------------------|-------------------| ------------------ |
|0.970.0-alpha1-SNAPSHOT | 0.970.0-alpha1-SNAPSHOT | v4

![Ballerina GitHub Connector Overview](BallerinaGitHubConnector_Overview.jpg)

### Getting started

* Clone the repository by running the following command
```
git clone https://github.com/wso2-ballerina/package-github
```
* Import the package to your ballerina project.

##### Prerequisites
Download the ballerina [distribution](https://ballerinalang.org/downloads/).

### Working with GitHub Connector Actions

All the actions return `objects` or `github4:GitConnectorError`. If the action was a success, then the requested object will be returned while the `github4:GitConnectorError` will be **null** and vice-versa.

##### Example
* Request 
```ballerina
    import github4;

    public function main (string[] args) {
        endpoint github4:GitHubEndpoint githubEP {
            accessToken:"<ACCESS_TOKEN>",
            clientEndpointConfiguration: {}
        };
    
        github4:Repository repository = {};
        var repo = githubEP -> getRepository("wso2-ballerina/package-github");
        match repo {
            github4:Repository rep => {
                repository = rep;
            }
            github4:GitConnectorError err => {
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