# Ballerina GitHub Connector

###### GitHub brings together the world's largest community of developers to discover, share, and build better software. From open source projects to private team repositories, GitHub is an all-in-one platform for collaborative development.

The Ballerina GitHub connector allow users to access the GitHub API through ballerina. This connector uses the GitHub GraphQL API v4.0

|Ballerina Version | Connector Version |
|------------------|-------------------|
|0.964.0 | 0.1 |

### Getting started

* Clone the repository by running the following command
```
git clone https://github.com/vlgunarathne/connector-github.git
```
* Import the package to your ballerina project.

##### Prerequisites
Download the ballerina version 0.964.0 [distribution](https://ballerinalang.org/downloads/).

### Working with GitHub Connector Actions

All the actions return `struct objects` and `github:GitConnectorError`. If the actions was a success, then the requested struct object will be returned while the `github:GitConnectorError` will be **null** and vice-versa.

##### Example
* Request 
```ballerina
    endpoint<github:GithubConnector> githubConnector {
        create github:GithubConnector(ACCESS_TOKEN);
    }
    
    ////Get a single repository
    github:Repository repository;
    repository, error = githubConnector.getRepository("vlgunarathne/connector-github");
    
```
* Response
```
{id:"MDEwOlJlcG9zaXRvcnkxMjIxNjUzMjM=", name:"connector-github", createdAt:"2018-02-20T06:59:38Z", updatedAt:"2018-03-14T13:51:03Z", description:"Ballerina GitHub Connector ", forkCount:1, hasIssuesEnabled:true, hasWikiEnabled:true, homepageUrl:"null", isArchived:false, isFork:false, isLocked:false, isMirror:false, isPrivate:false, license:"null", lockReason:"null", mirrorUrl:"null", url:"https://github.com/vlgunarathne/connector-github", sshUrl:"git@github.com:vlgunarathne/connector-github.git", owner:{id:"MDQ6VXNlcjE2MDY0Njk2", login:"vlgunarathne", url:"https://github.com/vlgunarathne", avatarUrl:"https://avatars2.githubusercontent.com/u/16064696?v=4", resourcePath:"/vlgunarathne"}, primaryLanguage:{id:"MDg6TGFuZ3VhZ2U2NTU=", name:"Ballerina", color:"#FF5000"}}
```

* Response struct
```ballerina
public struct Repository {
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
## Connector API

### getRepository()
Return a single repository.

###### Parameters
Name | Type | Description
-----|------|------------
name | string | Name of the organization and repository. (Eg: "organization/repository")

###### Returns
**github:Repository**

***

### getOrganization()
Return a single organization.

###### Parameters
Name | Type | Description
-----|------|------------
name | string | Name of the organization. (Eg: "organization")

###### Returns
**github:Organization**

***
## github:Repository

### getProjectList()
Return a list of projects in the repository.

###### Parameters
Name | Type | Description
-----|------|------------
state | string | The state of the project. (Eg: github:GIT_STATE_OPEN, github:GIT_STATE_CLOSED, github:GIT_STATE_ALL )

###### Returns
**github:ProjectList**

***
### getProject()
Return a single project of the repository.

###### Parameters
Name | Type | Description
-----|------|------------
projectNumber | int | The integral number of the project.

###### Returns
**github:Project**

***

### getIssueList()
Return a list of issues of the repository.

###### Parameters
Name | Type | Description
-----|------|------------
state | string | The state of the issue. (Eg: github:GIT_STATE_OPEN, github:GIT_STATE_CLOSED, github:GIT_STATE_ALL )

###### Returns
**github:IssueList**

***

### getIssue()
Return a single issue of the repository.

###### Parameters
Name | Type | Description
-----|------|------------
issueNumber | int | The integral number of the issue.

###### Returns
**github:Issue**

***

### getPullRequestList()
Return a list of pull requests of the repository.

###### Parameters
Name | Type | Description
-----|------|------------
state | string | The state of the pull request. (Eg: github:GIT_STATE_OPEN, github:GIT_STATE_CLOSED, github:GIT_STATE_MERGED, github:GIT_STATE_ALL)

###### Returns
**github:PullRequestList**

***