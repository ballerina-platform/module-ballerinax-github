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


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Organization object                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

# Represents a github organization.
# + id - Organization identification number
# + login - Organization login name
# + name - Organizaition public profile name
# + email - Organization public email
# + description - Organization public profile description
# + location - Organization public profile location
# + resourcePath - HTTP path for the resource
# + projectsResourcePath - HTTP path for the organization projects
# + projectsUrl - HTTP URL listing organization projects
# + url - HTTP URL for the organization
# + websiteUrl - Organization public profile URL
# + avatarUrl - Organization public avatar URL
public type Organization record {
    string id;
    string login;
    string name;
    string email;
    string? description;
    string? location;
    string? resourcePath;
    string? projectsResourcePath;
    string? projectsUrl;
    string? url;
    string? websiteUrl;
    string? avatarUrl;
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                       End of Organization object                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Repository object                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a github repository.
# + id - Repository identification number
# + name - Repository name
# + createdAt - Date and time the repository was created
# + updatedAt - Date and time the repository was updated
# + description - Description of the repository
# + forkCount - Number of forks there are of this repository in the entire network
# + hasIssuesEnabled - Indicates if the repository has issues feature enabled
# + hasWikiEnabled - Indicates if the repository has wiki feature enabled
# + isArchived - Indicates if the repository is unmaintained
# + isFork - Identifies if the repository is a fork
# + isLocked - Indicates if the repository has been locked or not
# + isMirror - Identifies if the repository is a mirror
# + isPrivate - Identifies if the repository is private
# + homepageUrl - Repository URL
# + lockReason - Reason the repository has been locked
# + mirrorUrl - Repository original mirror URL
# + url - HTTP URL for this repository
# + sshUrl - SSH URL to clone this repository
# + owner - Owner of the repository
# + primaryLanguage - Primary language of the repository code
public type Repository record {
    string id;
    string name;
    string createdAt;
    string? updatedAt;
    string? description;
    int? forkCount;
    boolean hasIssuesEnabled;
    boolean hasWikiEnabled;
    boolean isArchived;
    boolean isFork;
    boolean isLocked;
    boolean isMirror;
    boolean isPrivate;
    string? homepageUrl;
    string? lockReason;
    string? mirrorUrl;
    string? url;
    string? sshUrl;
    RepositoryOwner owner;
    Language primaryLanguage;
    int? stargazerCount;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Repository object                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              RepositoryList object                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a list of repositories
public type RepositoryList object {
    string repositoryListQuery;
    PageInfo pageInfo;
    Repository[] nodes;

    # Check if repository list next page is available.
    # + return - Return true or false
    public function hasNextPage() returns (boolean);

    # Check if repository list previous page is available.
    # + return - Return true or false
    public function hasPreviousPage() returns (boolean);

    # Get all the repositories in the repository list.
    # + return - Array of Repository objects
    public function getAllRepositories() returns (Repository[]);
};
//*********************************************************************************************************************
// RepositoryList bound functions
//*********************************************************************************************************************
function RepositoryList::hasNextPage() returns (boolean) {
    return self.pageInfo.hasNextPage;
}

function RepositoryList::hasPreviousPage() returns (boolean) {
    return self.pageInfo.hasPreviousPage;
}

function RepositoryList::getAllRepositories() returns (Repository[]) {
    return self.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                         End of RepositoryList object                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Project object                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a github project.
# + id - Project identification number
# + name - Project name
# + body - Project description body
# + number - Project number
# + createdAt - Date and time when the object was created
# + closed - Identifies whether the project is closed or not
# + closedAt - Date and time when the object was closed
# + updatedAt - Date and time when the object was last updated
# + resourcePath - HTTP path for this project
# + state - Identifies whether the project is open or closed
# + url - HTTP URL for this project
# + viewerCanUpdate - Identifies whether current viewer can update this object
# + creator - User who originally created the project
# + owner - Project owner (Repository or Organization)
public type Project record {
    string id;
    string name;
    string body;
    int number;
    string createdAt;
    string? closed;
    string? closedAt;
    string? updatedAt;
    string? resourcePath;
    string state;
    string url;
    boolean viewerCanUpdate;
    Creator creator;
    ProjectOwner owner;
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of Project object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                 ProjectList object                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

# Represents a list of projects
public type ProjectList object {
    string listOwner;
    string projectListQuery;
    PageInfo pageInfo;
    Project[] nodes;

    # Check if project list next page is available.
    # + return - Return true or false
    public function hasNextPage() returns (boolean);

    # Check if project list previous page is available.
    # + return - Return true or false
    public function hasPreviousPage() returns (boolean);

    # Get all the projects in the project list.
    # + return - Array of Project objects
    public function getAllProjects() returns (Project[]);
};
//*********************************************************************************************************************
// ProjectList bound functions
//*********************************************************************************************************************
function ProjectList::hasNextPage() returns (boolean) {
    return self.pageInfo.hasNextPage;
}

function ProjectList::hasPreviousPage() returns (boolean) {
    return self.pageInfo.hasPreviousPage;
}

function ProjectList::getAllProjects() returns (Project[]) {
    return self.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of ProjectList object                                             //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Column object                                                        //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a github Column.
# + id - Column identification number
# + name - Column name
public type Column object {
    public string id;
    public string name;
    string columnQuery;
    string listOwner;
    CardList cards;

    # Get a list of cards of a column.
    # + return - Card list object
    public function getCardList() returns (CardList);
};
//*********************************************************************************************************************
// Column bound functions
//*********************************************************************************************************************
function Column::getCardList() returns (CardList) {
    return self.cards;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              End of Column object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              ColumnList object                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#Represents a list of columns of a project
public type ColumnList object {
    string listOwner;
    string columnListQuery;
    PageInfo pageInfo;
    Column[] nodes;

    # Check if column list next page is available.
    # + return - Return true or false
    public function hasNextPage() returns (boolean);

    # Check if column list previosu page is available.
    # + return - Return true or false
    public function hasPreviousPage() returns (boolean);

    # Get all the columns in the column list.
    # + return - Array of column objects
    public function getAllColumns() returns (Column[]);
};
//*********************************************************************************************************************
// ColumnList bound functions
//*********************************************************************************************************************
function ColumnList::hasNextPage() returns (boolean) {
    return self.pageInfo.hasNextPage;
}

function ColumnList::hasPreviousPage() returns (boolean) {
    return self.pageInfo.hasPreviousPage;
}

function ColumnList::getAllColumns() returns (Column[]) {
    return self.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                          End of ColumnList object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                   Card object                                                     //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a github card.
# + id - Card identifcation number
# + note - Note in the card
# + state - State of the card (CONTENT_ONLY, NOTE_ONLY, REDACTED)
# + createdAt - Date and time when the object was created
# + updatedAt - Date and time when the object was last updated
# + url - HTTP URL for this card
# + creator - User who created this card
# + column - Project column this card is associated under
# + content - Card content
public type Card record {
    string id;
    string? note;
    string state;
    string createdAt;
    string? updatedAt;
    string url;
    Creator creator;
    json column;
    json content;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               End of Card object                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              CardList object                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a list of cards of a column
public type CardList object {
    string columnId;
    string cardListQuery;
    string listOwner;
    PageInfo pageInfo;
    Card[] nodes;

    # Check if the card list next page is available.
    # + return - Return true or false
    public function hasNextPage() returns (boolean);

    # Check if the card list previous page is available.
    # + return - Return true or false
    public function hasPreviousPage() returns (boolean);

    # Get all the cards in the card list.
    # + return - Array of card objects
    public function getAllCards() returns (Card[]);
};
//*********************************************************************************************************************
// CardList bound functions
//*********************************************************************************************************************
function CardList::hasNextPage() returns (boolean) {
    return self.pageInfo.hasNextPage;
}

function CardList::hasPreviousPage() returns (boolean) {
    return self.pageInfo.hasPreviousPage;
}

function CardList::getAllCards() returns (Card[]) {
    return self.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of CardList object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              PullRequest object                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a github pull request.
# + id - Pull request identification number
# + title - Pull request title
# + createdAt - Date and time when the object was created
# + updatedAt - Date and time when the object was last updated
# + closed - Identifies whether the pull request is closed or not
# + closedAt - Date and time when the object was closed
# + mergedAt - Date and time that the pull request was merged
# + state - State of the pull request (CLOSED, MERGED, OPEN)
# + number - Pull request number
# + url - HTTP URL for this pull request
# + body - Body of the Pull Request in Markdown format
# + changedFiles - Number of changed files in this pull request
# + additions - Number of additions in the pull request
# + deletions - Number of deletions in the pull request
# + resourcePath - HTTP path for the pull request
# + revertResourcePath - HTTP path for reverting the pull request
# + revertUrl - HTTP URL for reverting the pull request
# + author - User who created the pull rquest
# + headRefName - Name of the head Ref associated with the pull request
# + baseRefName - Name of the base Ref associated with the pull request\
public type PullRequest record {
    string id;
    string title;
    string createdAt;
    string? updatedAt;
    boolean closed;
    string? closedAt;
    string? mergedAt;
    string state;
    int number;
    string url;
    string? body;
    string changedFiles;
    int additions;
    int deletions;
    string? resourcePath;
    string? revertResourcePath;
    string? revertUrl;
    Creator author;
    string? headRefName;
    string? baseRefName;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of PullRequest object                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             PullRequestList object                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a list of github pull requests
public type PullRequestList object {
    string pullRequestListQuery;
    PageInfo pageInfo;
    PullRequest[] nodes;

    # Check if pull request list next page is available.
    # + return - Return true or false
    public function hasNextPage() returns (boolean);

    # Check if pull request list previous page is avaiable.
    # + return - Return true or false
    public function hasPreviousPage() returns (boolean);

    # Get all the pull requests in the pull request list.
    # + return - Array of pull request objects
    public function getAllPullRequests() returns (PullRequest[]);
};
//*********************************************************************************************************************
// PullRequestList bound functions
//*********************************************************************************************************************
function PullRequestList::hasNextPage() returns (boolean) {
    return self.pageInfo.hasNextPage;
}

function PullRequestList::hasPreviousPage() returns (boolean) {
    return self.pageInfo.hasPreviousPage;
}

function PullRequestList::getAllPullRequests() returns (PullRequest[]) {
    return self.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                          End of PullRequestList object                                            //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                Issue object                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a github issue.
# + id - Issue identificaion number
# + bodyText - Body of the issue in text format
# + closed - Identifies whether the issue is closed or not
# + closedAt - Date and time when the object was closed
# + createdAt - Date and time when the object was created
# + author - User who created the issue
# + labels - List of labels associated with the issue
# + number - Issue number
# + state - State of the issue (CLOSED, OPEN)
# + title - Issue title
# + updatedAt - Date and time when the object was updated
# + url - HTTP URL of the issue
# + assignees - List of users assigned to the issue
public type Issue record {
    string id;
    string? bodyText;
    string? closed;
    string? closedAt;
    string createdAt;
    Creator author;
    Label[] labels;
    int number;
    string state;
    string title;
    string? updatedAt;
    string url;
    Assignee[] assignees;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              End of Issue object                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                IssueList object                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a list of github issues
public type IssueList object {
    string issueListQuery;
    PageInfo pageInfo;
    Issue[] nodes;

    # Check if issue list next page is available.
    # + return - Return true or false
    public function hasNextPage() returns (boolean);

    # Check if issue list previous page is avaiable.
    # + return - Return true or false
    public function hasPreviousPage() returns (boolean);

    # Get all the issues in the issue list.
    # + return - Array of issue objects
    public function getAllIssues() returns (Issue[]);
};
//*********************************************************************************************************************
// IssueList bound functions
//*********************************************************************************************************************
function IssueList::hasNextPage() returns (boolean) {
    return self.pageInfo.hasNextPage;
}

function IssueList::hasPreviousPage() returns (boolean) {
    return self.pageInfo.hasPreviousPage;
}

function IssueList::getAllIssues() returns (Issue[]) {
    return self.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of IssueList object                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               Creator object                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a github Creator.
# + login - Username of the creator
# + resourcePath - HTTP path of the creator
# + url - HTTP URL of the creator
# + avatarUrl - HTTP URL of the public avatar of the creator
public type Creator record {
    string login;
    string? resourcePath;
    string? url;
    string? avatarUrl;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of Creator object                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              ProjectOwner object                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a github project owner.
# + id - Project owner identification number
# + projectsResourcePath - HTTP path listing owner projects
# + projectsUrl - HTTP URL listing owner projects
# + viewerCanCreateProjects - Identifies whether the current viewer can create new projects on the owner
public type ProjectOwner object {
    public string id;
    public string projectsResourcePath;
    public string projectsUrl;
    public string viewerCanCreateProjects;
    private string __typename;

    # Get the type of the project owner.
    # + return - Type of the owner (Repository or Organization)
    public function getOwnerType() returns (string);

    # Set the type of the project owner.
    # + ownerType - Type of the owner (Repository or Organization)
    public function setOwnerType(string ownerType);
};
//*********************************************************************************************************************
// ProjectOwner bound functions
//*********************************************************************************************************************
function ProjectOwner::getOwnerType() returns (string) {
    return self.__typename;
}

function ProjectOwner::setOwnerType(string ownerType) {
    self.__typename = ownerType;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of ProjectOwner object                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            RepositoryOwner object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a github repository owner.
# + id - Repository owner identification number
# + login - Username of the repository owner
# + url - HTTP URL of the owner
# + avatarUrl - HTTP URL of the public avatar of the repository owner
# + resourcePath - HTTP path of the repository owner recource
public type RepositoryOwner record {
    string id;
    string login;
    string url;
    string? avatarUrl;
    string? resourcePath;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                          End RepositoryOwner object                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               Content object                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a content in a github card.
# + title - Title of the card
# + url - HTTP URL for the content of the card
# + issueState - State of the issue (OPEN, CLOSED)
public type Content record {
    string? title;
    string? url;
    string? issueState;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Content object                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                Language object                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a github language.
# + id - Language identification number
# + name - Name of the language
# + color - Color defined for the language
public type Language record {
    string id;
    string? name;
    string? color;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of Language object                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            GitClientError object                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# GitHub Client Error.
# + message - Error message
# + cause - Error object
public type GitClientError record {
    string message;
    error? cause;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                         End of GitClientError object                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                PageInfo object                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a github page information.
# + hasNextPage - Identifies whether there is a next page of results
# + hasPreviousPage - Identifies whether there is a previous page of results
# + startCursor - Start cursor pointing to the begining of the current result set
# + endCursor - End cursor pointing to the end of the current result set
type PageInfo record {
    boolean hasNextPage;
    boolean hasPreviousPage;
    string? startCursor;
    string? endCursor;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of PageInfo object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                 Label object                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a github label.
# + id - Label identification number
# + name - Label name
# + description - Description of the label
# + color - Color of the label
public type Label record {
    string id;
    string name;
    string? description;
    string? color;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of Label object                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               Assignee object                                                     //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Represents a list of assignees to an issue.
# + id - Assignee identification number
# + login - Username of the user
# + email - Email of the user
# + bio - Bio description of the user
# + url - HTTP URL of the user profile
public type Assignee record {
    string id;
    string login;
    string email;
    string? bio;
    string? url;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of Assignee object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////