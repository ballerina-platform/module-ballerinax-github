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

import ballerina/io;
import ballerina/http;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Organization object                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a github organization
    F{{id}} - Organization identification number
    F{{login}} - Organization login name
    F{{name}} - Organizaition public profile name
    F{{email}} - Organization public email
    F{{description}} - Organization public profile description
    F{{location}} - Organization public profile location
    F{{resourcePath}} - HTTP path for the resource
    F{{projectsResourcePath}} - HTTP path for the organization projects
    F{{projectsUrl}} - HTTP URL listing organization projects
    F{{url}} - HTTP URL for the organization
    F{{websiteUrl}} - Organization public profile URL
    F{{avatarUrl}} - Organization public avatar URL
}
public type Organization {
    string id;
    string login;
    string name;
    string email;
    string description;
    string location;
    string resourcePath;
    string projectsResourcePath;
    string projectsUrl;
    string url;
    string websiteUrl;
    string avatarUrl;
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                       End of Organization object                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Repository object                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a github repository
    F{{id}} - Repository identification number
    F{{name}} - Repository name
    F{{createdAt}} - Date and time the repository was created
    F{{updatedAt}} - Date and time the repository was updated
    F{{description}} - Description of the repository
    F{{forkCount}} - Number of forks there are of this repository in the entire network
    F{{hasIssuesEnabled}} - Indicates if the repository has issues feature enabled
    F{{hasWikiEnabled}} - Indicates if the repository has wiki feature enabled
    F{{isArchived}} - Indicates if the repository is unmaintained
    F{{isFork}} - Identifies if the repository is a fork
    F{{isLocked}} - Indicates if the repository has been locked or not
    F{{isMirror}} - Identifies if the repository is a mirror
    F{{isPrivate}} - Identifies if the repository is private
    F{{homepageUrl}} - Repository URL
    F{{lockReason}} - Reason the repository has been locked
    F{{mirrorUrl}} - Repository original mirror URL
    F{{url}} - HTTP URL for this repository
    F{{sshUrl}} - SSH URL to clone this repository
    F{{owner}} - Owner of the repository
    F{{primaryLanguage}} - Primary language of the repository code
}
public type Repository {
    string id;
    string name;
    string createdAt;
    string updatedAt;
    string description;
    int forkCount;
    boolean hasIssuesEnabled;
    boolean hasWikiEnabled;
    boolean isArchived;
    boolean isFork;
    boolean isLocked;
    boolean isMirror;
    boolean isPrivate;
    string homepageUrl;
    string lockReason;
    string mirrorUrl;
    string url;
    string sshUrl;
    RepositoryOwner owner;
    Language primaryLanguage;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Repository object                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              RepositoryList object                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a list of repositories }
public type RepositoryList object {
    private {
        string repositoryListQuery;
        PageInfo pageInfo;
        Repository[] nodes;
    }

    documentation { Check if repository list next page is available
        R{{}} - Return true or false
    }
    public function hasNextPage () returns (boolean);

    documentation { Check if repository list previous page is available
        R{{}} - Return true or false
    }
    public function hasPreviousPage () returns (boolean);

    documentation { Get all the repositories in the repository list
        R{{}} - Array of Repository objects
    }
    public function getAllRepositories () returns (Repository[]);
};
//*********************************************************************************************************************
// RepositoryList bound functions
//*********************************************************************************************************************
public function RepositoryList::hasNextPage () returns (boolean) {
    return self.pageInfo.hasNextPage;
}

public function RepositoryList::hasPreviousPage () returns (boolean) {
    return self.pageInfo.hasPreviousPage;
}

public function RepositoryList::getAllRepositories () returns (Repository[]) {
    return self.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                         End of RepositoryList object                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Project object                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a github project
    F{{id}} - Project identification number
    F{{name}} - Project name
    F{{body}} - Project description body
    F{{number}} - Project number
    F{{createdAt}} - Date and time when the object was created
    F{{closed}} - Identifies whether the project is closed or not
    F{{closedAt}} - Date and time when the object was closed
    F{{updatedAt}} - Date and time when the object was last updated
    F{{resourcePath}} - HTTP path for this project
    F{{state}} - Identifies whether the project is open or closed
    F{{url}} - HTTP URL for this project
    F{{viewerCanUpdate}} - Identifies whether current viewer can update this object
    F{{creator}} - User who originally created the project
    F{{owner}} - Project owner (Repository or Organization)
}
public type Project {
    string id;
    string name;
    string body;
    int number;
    string createdAt;
    string closed;
    string closedAt;
    string updatedAt;
    string resourcePath;
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
@Description {value:"Represents a list of projects"}

public type ProjectList object {
    private {
        string listOwner;
        string projectListQuery;
        PageInfo pageInfo;
        Project[] nodes;
    }

    documentation { Check if project list next page is available
        R{{}} - Return true or false
    }
    public function hasNextPage () returns (boolean);

    documentation { Check if project list previous page is available
        R{{}} - Return true or false
    }
    public function hasPreviousPage () returns (boolean);

    documentation { Get all the projects in the project list
        R{{}} - Array of Project objects
    }
    public function getAllProjects () returns (Project[]);
};
//*********************************************************************************************************************
// ProjectList bound functions
//*********************************************************************************************************************
public function ProjectList::hasNextPage () returns (boolean) {
    return self.pageInfo.hasNextPage;
}

public function ProjectList::hasPreviousPage () returns (boolean) {
    return self.pageInfo.hasPreviousPage;
}

public function ProjectList::getAllProjects () returns (Project[]) {
    return self.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of ProjectList object                                             //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Column object                                                        //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a github Column
    F{{id}} - Column identification number
    F{{name}} - Column name
}
public type Column object {
    public {
        string id;
        string name;
    }

    private {
        string columnQuery;
        string listOwner;
        CardList cards;
    }

    documentation { Get a list of cards of a column
        R{{}} - Card list object
    }
    public function getCardList () returns (CardList);
};
//*********************************************************************************************************************
// Column bound functions
//*********************************************************************************************************************
public function Column::getCardList () returns (CardList) {
    return self.cards;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              End of Column object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              ColumnList object                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation {Represents a list of columns of a project}
public type ColumnList object {
    private {
        string listOwner;
        string columnListQuery;
        PageInfo pageInfo;
        Column[] nodes;
    }

    documentation { Check if column list next page is available
        R{{}} - Return true or false
    }
    public function hasNextPage () returns (boolean);

    documentation { Check if column list previosu page is available
        R{{}} - Return true or false
    }
    public function hasPreviousPage () returns (boolean);

    documentation { Get all the columns in the column list
        R{{}} - Array of column objects
    }
    public function getAllColumns () returns (Column[]);
};
//*********************************************************************************************************************
// ColumnList bound functions
//*********************************************************************************************************************
public function ColumnList::hasNextPage () returns (boolean) {
    return self.pageInfo.hasNextPage;
}

public function ColumnList::hasPreviousPage () returns (boolean) {
    return self.pageInfo.hasPreviousPage;
}

public function ColumnList::getAllColumns () returns (Column[]) {
    return self.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                          End of ColumnList object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                   Card object                                                     //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a github card
    F{{id}} - Card identifcation number
    F{{note}} - Note in the card
    F{{state}} - State of the card (CONTENT_ONLY, NOTE_ONLY, REDACTED)
    F{{createdAt}} - Date and time when the object was created
    F{{updatedAt}} - Date and time when the object was last updated
    F{{url}} - HTTP URL for this card
    F{{creator}} - User who created this card
    F{{column}} - Project column this card is associated under
    F{{content}} - Card content
}
public type Card {
    string id;
    string note;
    string state;
    string createdAt;
    string updatedAt;
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
documentation { Represents a list of cards of a column }
public type CardList object {
    private {
        string columnId;
        string cardListQuery;
        string listOwner;
        PageInfo pageInfo;
        Card[] nodes;
    }

    documentation { Check if the card list next page is available
        R{{}} - Return true or false
    }
    public function hasNextPage () returns (boolean);

    documentation { Check if the card list previous page is available
        R{{}} - Return true or false
    }
    public function hasPreviousPage () returns (boolean);

    documentation { Get all the cards in the card list
        R{{}} - Array of card objects
    }
    public function getAllCards () returns (Card[]);
};
//*********************************************************************************************************************
// CardList bound functions
//*********************************************************************************************************************
public function CardList::hasNextPage () returns (boolean) {
    return self.pageInfo.hasNextPage;
}

public function CardList::hasPreviousPage () returns (boolean) {
    return self.pageInfo.hasPreviousPage;
}

public function CardList::getAllCards () returns (Card[]) {
    return self.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of CardList object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              PullRequest object                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a github pull request
    F{{id}} - Pull request identification number
    F{{title}} - Pull request title
    F{{createdAt}} - Date and time when the object was created
    F{{updatedAt}} - Date and time when the object was last updated
    F{{closed}} - Identifies whether the pull request is closed or not
    F{{closedAt}} - Date and time when the object was closed
    F{{mergedAt}} - Date and time that the pull request was merged
    F{{state}} - State of the pull request (CLOSED, MERGED, OPEN)
    F{{number}} - Pull request number
    F{{url}} - HTTP URL for this pull request
    F{{body}} - Body of the Pull Request in Markdown format
    F{{changedFiles}} - Number of changed files in this pull request
    F{{additions}} - Number of additions in the pull request
    F{{deletions}} - Number of deletions in the pull request
    F{{resourcePath}} - HTTP path for the pull request
    F{{revertResourcePath}} - HTTP path for reverting the pull request
    F{{revertUrl}} - HTTP URL for reverting the pull request
    F{{author}} - User who created the pull rquest
    F{{headRefName}} - Name of the head Ref associated with the pull request
    F{{baseRefName}} - Name of the base Ref associated with the pull request
}
public type PullRequest {
    string id;
    string title;
    string createdAt;
    string updatedAt;
    boolean closed;
    string closedAt;
    string mergedAt;
    string state;
    int number;
    string url;
    string body;
    string changedFiles;
    int additions;
    int deletions;
    string resourcePath;
    string revertResourcePath;
    string revertUrl;
    Creator author;
    string headRefName;
    string baseRefName;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of PullRequest object                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             PullRequestList object                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a list of github pull requests }
public type PullRequestList object {
    private {
        string pullRequestListQuery;
        PageInfo pageInfo;
        PullRequest[] nodes;
    }

    documentation { Check if pull request list next page is available
        R{{}} - Return true or false
    }
    public function hasNextPage () returns (boolean);

    documentation { Check if pull request list previous page is avaiable
        R{{}} - Return true or false
    }
    public function hasPreviousPage () returns (boolean);

    documentation { Get all the pull requests in the pull request list
        R{{}} - Array of pull request objects
    }
    public function getAllPullRequests () returns (PullRequest[]);
};
//*********************************************************************************************************************
// PullRequestList bound functions
//*********************************************************************************************************************
public function PullRequestList::hasNextPage () returns (boolean) {
    return self.pageInfo.hasNextPage;
}

public function PullRequestList::hasPreviousPage () returns (boolean) {
    return self.pageInfo.hasPreviousPage;
}

public function PullRequestList::getAllPullRequests () returns (PullRequest[]) {
    return self.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                          End of PullRequestList object                                            //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                Issue object                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a github issue
    F{{id}} - Issue identificaion number
    F{{bodyText}} - Body of the issue in text format
    F{{closed}} - Identifies whether the issue is closed or not
    F{{closedAt}} - Date and time when the object was closed
    F{{createdAt}} - Date and time when the object was created
    F{{author}} - User who created the issue
    F{{labels}} - List of labels associated with the issue
    F{{number}} - Issue number
    F{{state}} - State of the issue (CLOSED, OPEN)
    F{{title}} - Issue title
    F{{updatedAt}} - Date and time when the object was updated
    F{{url}} - HTTP URL of the issue
    F{{assignees}} - List of users assigned to the issue
}
public type Issue {
    string id;
    string bodyText;
    string closed;
    string closedAt;
    string createdAt;
    Creator author;
    LabelList labels;
    int number;
    string state;
    string title;
    string updatedAt;
    string url;
    AssigneeList assignees;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              End of Issue object                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                IssueList object                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a list of github issues }
public type IssueList object {
    private {
        string issueListQuery;
        PageInfo pageInfo;
        Issue[] nodes;
    }

    documentation { Check if issue list next page is available
        R{{}} - Return true or false
    }
    public function hasNextPage () returns (boolean);

    documentation { Check if issue list previous page is avaiable
        R{{}} - Return true or false
    }
    public function hasPreviousPage () returns (boolean);

    documentation { Get all the issues in the issue list
        R{{}} - Array of issue objects
    }
    public function getAllIssues () returns (Issue[]);
};
//*********************************************************************************************************************
// IssueList bound functions
//*********************************************************************************************************************
public function IssueList::hasNextPage () returns (boolean) {
    return self.pageInfo.hasNextPage;
}

public function IssueList::hasPreviousPage () returns (boolean) {
    return self.pageInfo.hasPreviousPage;
}

public function IssueList::getAllIssues () returns (Issue[]) {
    return self.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of IssueList object                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               Creator object                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a github Creator
    F{{login}} - Username of the creator
    F{{resourcePath}} - HTTP path of the creator
    F{{url}} - HTTP URL of the creator
    F{{avatarUrl}} - HTTP URL of the public avatar of the creator
}
public type Creator {
    string login;
    string resourcePath;
    string url;
    string avatarUrl;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of Creator object                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              ProjectOwner object                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a github project owner
    F{{id}} - Project owner identification number
    F{{projectsResourcePath}} - HTTP path listing owner projects
    F{{projectsUrl}} - HTTP URL listing owner projects
    F{{viewerCanCreateProjects}} - Identifies whether the current viewer can create new projects on the owner
}
public type ProjectOwner object {
    public {
        string id;
        string projectsResourcePath;
        string projectsUrl;
        string viewerCanCreateProjects;
    }

    private {
        string __typename;
    }

    documentation { Get the type of the project owner
        R{{}} - Type of the owner (Repository or Organization)
    }
    public function getOwnerType () returns (string);

    documentation { Set the type of the project owner
        P{{ownerType}} - Type of the owner (Repository or Organization)
    }
    public function setOwnerType (string ownerType);
};
//*********************************************************************************************************************
// ProjectOwner bound functions
//*********************************************************************************************************************
public function ProjectOwner::getOwnerType () returns (string) {
    return self.__typename;
}

public function ProjectOwner::setOwnerType (string ownerType) {
    self.__typename = ownerType;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of ProjectOwner object                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            RepositoryOwner object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a github repository owner
    F{{id}} - Repository owner identification number
    F{{login}} - Username of the repository owner
    F{{url}} - HTTP URL of the owner
    F{{avatarUrl}} - HTTP URL of the public avatar of the repository owner
    F{{resourcePath}} - HTTP path of the repository owner recource
}
public type RepositoryOwner {
    string id;
    string login;
    string url;
    string avatarUrl;
    string resourcePath;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                          End RepositoryOwner object                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               Content object                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a content in a github card
    F{{title}} - Title of the card
    F{{url}} - HTTP URL for the content of the card
    F{{issueState}} - State of the issue (OPEN, CLOSED)
}
public type Content {
    string title;
    string url;
    string issueState;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Content object                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                Language object                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a github language
    F{{id}} - Language identification number
    F{{name}} - Name of the language
    F{{color}} - Color defined for the language
}
public type Language {
    string id;
    string name;
    string color;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of Language object                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            GitClientError object                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { GitHub Client Error
    F{{statusCode}} - HTTP status code
    F{{message}} - Error message
    F{{reasonPhrase}} - Reason for error
    F{{server}} - Server from which the message was received
}
public type GitClientError {
    int statusCode;
    string[] message;
    string reasonPhrase;
    string server;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                         End of GitClientError object                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                PageInfo object                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a github page information
    F{{hasNextPage}} - Identifies whether there is a next page of results
    F{{hasPreviousPage}} - Identifies whether there is a previous page of results
    F{{startCursor}} - Start cursor pointing to the begining of the current result set
    F{{endCursor}} - End cursor pointing to the end of the current result set
}
type PageInfo {
    boolean hasNextPage;
    boolean hasPreviousPage;
    string startCursor;
    string endCursor;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of PageInfo object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                 Label object                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a github label
    F{{id}} - Label identification number
    F{{name}} - Label name
    F{{description}} - Description of the label
    F{{color}} - Color of the label
}
public type Label {
    string id;
    string name;
    string description;
    string color;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of Label object                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               LabelList object                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a list of github labels }
public type LabelList object{
    private{
        Label[] nodes;
    }

    documentation { Get all labels from label list
        R{{}} - Array of label objects
    }
    public function getAllLabels () returns (Label[]);

    documentation { Set labels to the label list
        P{{labels}} - String array of labels
    }
    public function setLabels (string[] labels);
};
//*********************************************************************************************************************
// LabelList bound functions
//*********************************************************************************************************************
public function LabelList::getAllLabels () returns (Label[]) {
    return self.nodes;
}

public function LabelList::setLabels (string[] labels) {
    Label[] labelList;
    foreach i, label in labels {
        labelList[i] = {name:label};
    }
    self.nodes = labelList;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              End of LabelList object                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               AssigneeList object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a list of assignees to an issue }
public type AssigneeList object {
    private {
        Assignee[] nodes;
    }

    documentation { Get all assignees of the assignee list
        R{{}} - Array of assignee objects
    }
    public function getAllAssignees () returns (Assignee[]);

    documentation {
        P{{assignees}} - String array of github usernames
    }
    public function setAssignees (string[] assignees);
};
//*********************************************************************************************************************
// AssigneeList bound functions
//*********************************************************************************************************************
public function AssigneeList::getAllAssignees () returns (Assignee[]) {
    return self.nodes;
}

public function AssigneeList::setAssignees (string[] assignees) {
    Assignee[] assigneeList;
    foreach i, assignee in assignees {
        assigneeList[i] = {login:assignee};
    }
    self.nodes = assigneeList;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of AssigneeList object                                             //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               Assignee object                                                     //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
documentation { Represents a list of assignees to an issue
    F{{id}} - Assignee identification number
    F{{login}} - Username of the user
    F{{email}} - Email of the user
    F{{bio}} - Bio description of the user
    F{{url}} - HTTP URL of the user profile
}
public type Assignee {
    string id;
    string login;
    string email;
    string bio;
    string url;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of Assignee object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////