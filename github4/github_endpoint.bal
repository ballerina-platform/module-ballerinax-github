//
// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//

import ballerina/http;

# GitHub Client object.
#
# + gitHubConnector - gitHubConnector Connector object
public type Client client object {

    public GitHubConnector gitHubConnector;

    public function __init(GitHubConfiguration gitHubConfig) {
        self.gitHubConnector = new(gitHubConfig);
    }

    # Creates a new issue in a repository.
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + issueTitle - Title of the issue
    # + issueContent - Details of the issue
    # + labelList - List of labels for the issue
    # + assigneeList - Users to be assigned to the issue
    # + return - Created issue object or Connector error
    remote function createIssue(string repositoryOwner, string repositoryName, string issueTitle, string issueContent,
    string[] labelList, string[] assigneeList) returns Issue|error {
        return self.gitHubConnector->createIssue(repositoryOwner, repositoryName, issueTitle, issueContent, labelList, assigneeList);
    }

    # Get the next page of the card list.
    # + cardList - Card list object
    # + return - Card list object of next page or Connector error
    remote function getCardListNextPage(CardList cardList) returns CardList|error {
        return self.gitHubConnector->getCardListNextPage(cardList);
    }

    # Get the next page of column list.
    # + columnList - Column list object
    # + return - Column list object of next page or Connector error
    remote function getColumnListNextPage(ColumnList columnList) returns ColumnList|error {
        return self.gitHubConnector->getColumnListNextPage(columnList);
    }

    # Get a list of issues of a repository.
    # + repository - Repository object or tuple (`repository owner`, `repository name`)
    # + state - State of the issue (`STATE_OPEN`, `STATE_CLOSED`, `STATE_ALL`)
    # + recordCount - Specify number of records in the list
    # + return - Issue list object or Connector error
    remote function getIssueList(Repository|(string, string) repository, string state, int recordCount)
    returns IssueList|error {
        return self.gitHubConnector->getIssueList(repository, state, recordCount);
    }

    # Get the next page of the issue list.
    # + issueList - Issue list object
    # + return - Issue list object of next page or Connector error
    remote function getIssueListNextPage(IssueList issueList) returns IssueList|error {
        return self.gitHubConnector->getIssueListNextPage(issueList);
    }

    # Get an organization.
    # + name - Name of the organization
    # + return - Organization object or Connector error
    remote function getOrganization(string name) returns Organization|error {
        return self.gitHubConnector->getOrganization(name);
    }

    # Get a single project of an organization.
    # + organization - Organization object or organization name
    # + projectNumber - The number of the project
    # + return - Project object or Connector error
    remote function getOrganizationProject(Organization|string organization, int projectNumber)
    returns Project|error {
        return self.gitHubConnector->getOrganizationProject(organization, projectNumber);
    }

    # Get all projects of an organization.
    # + organization - Organization object or organization name
    # + state - State of the project (`STATE_OPEN`, `STATE_CLOSED`, `STATE_ALL`)
    # + recordCount - Specify number of records in the list
    # + return - Project list object or Connector error
    remote function getOrganizationProjectList(Organization|string organization, string state, int recordCount)
    returns ProjectList|error {
        return self.gitHubConnector->getOrganizationProjectList(organization, state, recordCount);
    }

    # Get a list of repositories of an organization.
    # + organization - Organization object or organization name
    # + recordCount - Specify number of records in the list
    # + return - Repository list object or Connector error
    remote function getOrganizationRepositoryList(Organization|string organization, int recordCount)
    returns RepositoryList|error {
        return self.gitHubConnector->getOrganizationRepositoryList(organization, recordCount);
    }

    # Get all columns of a project board.
    # + project - Project object
    # + recordCount - Specify number of records in the list
    # + return - Column list object or Connector error
    remote function getProjectColumnList(Project project, int recordCount) returns ColumnList|error {
        return self.gitHubConnector->getProjectColumnList(project, recordCount);
    }

    # Gets the next page of a project list.
    # + projectList - Project list object
    # + return - Project list object of next page or Connector error
    remote function getProjectListNextPage(ProjectList projectList) returns ProjectList|error {
        return self.gitHubConnector->getProjectListNextPage(projectList);
    }

    # Get all pull requests of a repository.
    # + repository - Repository object or tuple `("repository owner", "repository name")`
    # + state - State of the pull request (STATE_OPEN, STATE_CLOSED, STATE_MERGED, STATE_ALL)
    # + recordCount - Specify number of records in the list
    # + return - Pull request list object or Connector error
    remote function getPullRequestList(Repository|(string, string) repository, string state, int recordCount)
    returns PullRequestList|error {
        return self.gitHubConnector->getPullRequestList(repository, state, recordCount);
    }

    # Get the next page of the pull request list.
    # + pullRequestList - Pull request list object
    # + return - Pull request list object of next page or Connector error
    remote function getPullRequestListNextPage(PullRequestList pullRequestList) returns PullRequestList|error {
        return self.gitHubConnector->getPullRequestListNextPage(pullRequestList);
    }

    # Get a repository of an owner.
    # + name - Name of the repository and its owner Format: ("owner/repository")
    # + return - Repository object or Connector error
    remote function getRepository(string name) returns Repository|error {
        return self.gitHubConnector->getRepository(name);
    }

    # Get the next page of a repository list.
    # + repositoryList - Repository list object
    # + return - Repository list object of next page or Connector error
    remote function getRepositoryListNextPage(RepositoryList repositoryList) returns RepositoryList|error {
        return self.gitHubConnector->getRepositoryListNextPage(repositoryList);
    }

    # Get a single project of a repository.
    # + repository - Repository object or tuple `("repository owner", "repository name")`
    # + projectNumber - Project identification number
    # + return - Project object or Connector error
    remote function getRepositoryProject(Repository|(string, string) repository, int projectNumber)
    returns Project|error {
    return self.gitHubConnector->getRepositoryProject(repository, projectNumber);
    }

    # Get all projects of a repository.
    # + repository - Repository object or tuple `("repository owner", "repository name")`
    # + state - State of the project (STATE_OPEN, STATE_CLOSED, STATE_ALL)
    # + recordCount - Specify number of records in the list
    # + return - Project list object or Connector error
    remote function getRepositoryProjectList(Repository|(string, string) repository, string state, int recordCount)
    returns ProjectList|error {
        return self.gitHubConnector->getRepositoryProjectList(repository, state, recordCount);
    }
};

# Represents the Github Client Connector Endpoint configuration.
# + clientConfig - HTTP client endpoint configuration
public type GitHubConfiguration record {
    http:ClientEndpointConfig clientConfig;
};