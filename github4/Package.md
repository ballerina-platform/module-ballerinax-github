# GitHub Connector

Allows connecting to GitHub GraphQL API. 

GitHub connector provides a Ballerina API to access the GitHub GraphQL API. 
The connector has built-in support to handle OAuth2.0, provides auto completion and type conversions. The following 
sections explains how to use Ballerina GitHub4 connector. You can refer the [GitHub GraphQL API v4.0]
(https://developer.github.com/v4/) to learn more about the API. 

### Compatibility

|Ballerina Language Version | GitHub API Version |
|------------------| ------------------ |
|0.970.0-beta10-SNAPSHOT | v4 |


### Getting started
1) Refer [Getting Started](https://ballerina.io/learn/getting-started/) to download Ballerina and install tools.

2) To use the GitHub connector, you will need provide the following.
    -   GitHub OAuth access token
    
    Visit [here](https://developer.github.com/v4/guides/forming-calls/#authenticating-with-graphql) for more information on obtaining OAuth2 credentials.
    
3) Create a new Ballerina project by executing the following command
    ```bash
       <PROJECT_ROOT_DIRECTORY>$ ballerina init
    ```
4) Import the package to your ballerina project.
    
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