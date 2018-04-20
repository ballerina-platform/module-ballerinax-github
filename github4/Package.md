# Ballerina GitHub Endpoint - GitHub API v4

###### GitHub brings together the world's largest community of developers to discover, share, and build better software. From open source projects to private team repositories, GitHub is an all-in-one platform for collaborative development.

The Ballerina GitHub endpoint allow users to access the GitHub API through ballerina. This endpoint uses the GitHub GraphQL API v4.0

### Compatibility

|Ballerina Language Version | GitHub API Version |
|------------------| ------------------ |
|0.970.0-beta2-SNAPSHOT | v4 |

![Ballerina GitHub Endpoint Overview](./resources/BallerinaGitHubEndpoint_Overview.jpg)

> Visit the [package-github](https://github.com/wso2-ballerina/package-github) repository for the source code.

##### Prerequisites
Refer [Getting Started](https://ballerina.io/learn/getting-started/) to download Ballerina and install tools.

### Getting started

* Create a new Ballerina project
```bash
ballerina init
```

* Import the package to your ballerina project.
```ballerina
import wso2/github4;
```
This will download the github4 artifacts from the central repository to your local repository.



### Working with GitHub Endpoint Actions

All the actions return **objects** or **github4:GitClientError**. If the action was a success, then the requested object will be returned while the **github4:GitClientError** will be **empty** and vice-versa.

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
***