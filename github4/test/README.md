# Ballerina GitHub Endpoint - Tests

###### GitHub brings together the world's largest community of developers to discover, share, and build better software. From open source projects to private team repositories, GitHub is an all-in-one platform for collaborative development.

The Ballerina GitHub endpoint allow users to access the GitHub API through ballerina. This endpoint uses the GitHub GraphQL API v4.0

|Ballerina Version | GitHub API Version |
|------------------| ------------------ |
|0.970.0-rc1       | v4                 |

## Running tests

Initialize a ballerina project
```
ballerina init
```

All the tests inside this package will make HTTP calls to the GitHub GraphQL API v4. If the HTTP call fails, then so will the test case.

In order to run the tests, the user will need to have a GitHub Personal Access Token. The token can be obtained by visiting

**https://github.com/{profile} -> Settings -> Developer Settings -> Personal access tokens**

and provide the obtained token to the client endpoint configuration by adding the following field to the `ballerina.conf`
> GITHUB_TOKEN="ACCESS_TOKEN"


```ballerina
endpoint Client githubClient {
    clientConfig: {
        auth:{
            scheme:"oauth",
            accessToken:config:getAsString("GITHUB_TOKEN")
        }
    }
};
```

Run tests :
```
ballerina test github4 --config ballerina.conf
```