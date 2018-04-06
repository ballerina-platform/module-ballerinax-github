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

package github4;

import ballerina/io;
import ballerina/http;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Organization object                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github organization"}
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
@Description {value:"Represents a github repository"}
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
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Repository object                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              RepositoryList object                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a list of repositories"}
public type RepositoryList object {
    private {
        string repositoryListQuery;
        PageInfo pageInfo;
        Repository[] nodes;
    }

    public function hasNextPage () returns (boolean);
    public function hasPreviousPage () returns (boolean);
    public function getAllRepositories () returns (Repository[]);
};
//*********************************************************************************************************************
// RepositoryList bound functions
//*********************************************************************************************************************
@Description {value:"Check if repository list next page is available"}
@Return {value:"boolean: Return true or false"}
public function RepositoryList::hasNextPage () returns (boolean) {
    return repositoryList.pageInfo.hasNextPage;
}

@Description {value:"Check if repository list previous page is available"}
@Return {value:"boolean: Return true or false"}
public function RepositoryList::hasPreviousPage () returns (boolean) {
    return repositoryList.pageInfo.hasPreviousPage;
}

@Description {value:"Get an array of repositories"}
@Return {value:"RepositoryList[]: Array of repositories"}
public function RepositoryList::getAllRepositories () returns (Repository[]) {
    return repositoryList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                         End of RepositoryList object                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Project object                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github project"}
public type Project {
    string id;
    int databaseId;
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

    public function hasNextPage () returns (boolean);
    public function hasPreviousPage () returns (boolean);
    public function getAllProjects () returns (Project[]);
};
//*********************************************************************************************************************
// ProjectList bound functions
//*********************************************************************************************************************
@Description {value:"Check if project list next page is available"}
@Return {value:"boolean: Return true or false"}
public function ProjectList::hasNextPage () returns (boolean) {
    return projectList.pageInfo.hasNextPage;
}

@Description {value:"Check if project list previous page is available"}
@Return {value:"boolean: Return true or false"}
public function ProjectList::hasPreviousPage () returns (boolean) {
    return projectList.pageInfo.hasPreviousPage;
}

@Description {value:"Get an array of projects"}
@Return {value:"Project[]: Array of projects"}
public function ProjectList::getAllProjects () returns (Project[]) {
    return projectList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of ProjectList object                                             //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Column object                                                        //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github Column"}
public type Column object {
    public {
        string id;
        string name;
        string columnQuery;
        string listOwner;
    }

    private {
        CardList cards;
    }

    public function getCardList () returns (CardList);
};
//*********************************************************************************************************************
// Column bound functions
//*********************************************************************************************************************
@Description {value:"Get a list of cards of a column"}
@Return {value:"CardList: A card list object"}
public function Column::getCardList () returns (CardList) {
    return column.cards;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              End of Column object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              ColumnList object                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a list of columns of a project"}
public type ColumnList object {
    private {
        string listOwner;
        string columnListQuery;
        PageInfo pageInfo;
        Column[] nodes;
    }

    public function hasNextPage () returns (boolean);
    public function hasPreviousPage () returns (boolean);
    public function getAllColumns () returns (Column[]);
};
//*********************************************************************************************************************
// ColumnList bound functions
//*********************************************************************************************************************
@Description {value:"Check if column list next page is available"}
@Return {value:"boolean: Return true or false"}
public function ColumnList::hasNextPage () returns (boolean) {
    return columnList.pageInfo.hasNextPage;
}

@Description {value:"Check if column list previosu page is available"}
@Return {value:"boolean: Return true or false"}
public function ColumnList::hasPreviousPage () returns (boolean) {
    return columnList.pageInfo.hasPreviousPage;
}

@Description {value:"Get an array of all the columns"}
@Return {value:"Column[]: Column array"}
public function ColumnList::getAllColumns () returns (Column[]) {
    return columnList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                          End of ColumnList object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                   Card object                                                     //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github card"}
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
@Description {value:"Represents a list of cards of a column"}
public type CardList object {
    private {
        string columnId;
        string cardListQuery;
        string listOwner;
        PageInfo pageInfo;
        Card[] nodes;
    }

    public function hasNextPage () returns (boolean);
    public function hasPreviousPage () returns (boolean);
    public function getAllCards () returns (Card[]);
};
//*********************************************************************************************************************
// CardList bound functions
//*********************************************************************************************************************
@Description {value:"Check if the card list next page is available"}
@Return {value:"boolean: Return true or false"}
public function CardList::hasNextPage () returns (boolean) {
    return cardList.pageInfo.hasNextPage;
}

@Description {value:"Check if the card list previous page is available"}
@Return {value:"boolean: Return true or false"}
public function CardList::hasPreviousPage () returns (boolean) {
    return cardList.pageInfo.hasPreviousPage;
}

@Description {value:"Get an array of all the cards"}
@Return {value:"Card[]: Array of cards"}
public function CardList::getAllCards () returns (Card[]) {
    return cardList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of CardList object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              PullRequest object                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github pull request"}
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
@Description {value:"Represents a list of github pull requests"}
public type PullRequestList object {
    private {
        string pullRequestListQuery;
        PageInfo pageInfo;
        PullRequest[] nodes;
    }
    
    public function hasNextPage () returns (boolean);
    public function hasPreviousPage () returns (boolean);
    public function getAllPullRequests () returns (PullRequest[]);
};
//*********************************************************************************************************************
// PullRequestList bound functions
//*********************************************************************************************************************
@Description {value:"Check if pull request list next page is available"}
@Return {value:"boolean: Return true or false"}
public function PullRequestList::hasNextPage () returns (boolean) {
    return pullRequestList.pageInfo.hasNextPage;
}

@Description {value:"Check if pull request list previous page is avaiable"}
@Return {value:"boolean: Return ture or false"}
public function PullRequestList::hasPreviousPage () returns (boolean) {
    return pullRequestList.pageInfo.hasPreviousPage;
}

@Description {value:"Get an array of all the pull requests"}
@Return {value:"PullRequest[]: PullRequest array"}
public function PullRequestList::getAllPullRequests () returns (PullRequest[]) {
    return pullRequestList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                          End of PullRequestList object                                            //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                Issue object                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github issue"}
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
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              End of Issue object                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                IssueList object                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a list of github issues"}
public type IssueList object {
    private {
        string issueListQuery;
        PageInfo pageInfo;
        Issue[] nodes;
    }

    public function hasNextPage () returns (boolean);
    public function hasPreviousPage () returns (boolean);
    public function getAllIssues () returns (Issue[]);
};
//*********************************************************************************************************************
// IssueList bound functions
//*********************************************************************************************************************
@Description {value:"Check if issue list next page is available"}
@Return {value:"boolean: Return true or false"}
public function IssueList::hasNextPage () returns (boolean) {
    return issueList.pageInfo.hasNextPage;
}

@Description {value:"Check if issue list previous page is avaiable"}
@Return {value:"boolean: Return ture or false"}
public function IssueList::hasPreviousPage () returns (boolean) {
    return issueList.pageInfo.hasPreviousPage;
}

@Description {value:"Get an array of all the issues"}
@Return {value:"Issue[]: Issue array"}
public function IssueList::getAllIssues () returns (Issue[]) {
    return issueList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of IssueList object                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               Creator object                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github Creator"}
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
@Description {value:"Represents a github project owner"}
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

    public function getOwnerType () returns (string);
    public function setOwnerType (string ownerType);
};
//*********************************************************************************************************************
// ProjectOwner bound functions
//*********************************************************************************************************************
@Description {value:"Get the type of the project owner"}
@Return {value:"string: Type of the owner"}
public function ProjectOwner::getOwnerType () returns (string) {
    return projectOwner.__typename;
}

@Description {value:"Set the type of the project owner"}
public function ProjectOwner::setOwnerType (string ownerType) {
    projectOwner.__typename = ownerType;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of ProjectOwner object                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            RepositoryOwner object                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github repository owner"}
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
@Description {value:"Represents a content in a github card"}
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
@Description {value:"Represents a github language"}
public type Language {
    string id;
    string name;
    string color;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of Language object                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            GitConnectorError object                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"GitHub Connector Error"}
public type GitConnectorError {
    int statusCode;
    string[] message;
    string reasonPhrase;
    string server;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                         End of GitConnectorError object                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                PageInfo object                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github page information"}
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
@Description {value:"Represents a github label"}
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
@Description {value:"Represents a list of github labels"}
public type LabelList object{
    private{
        Label[] nodes;
    }
};
//*********************************************************************************************************************
// LabelList bound functions
//*********************************************************************************************************************
@Description {value:"Get an array of labels"}
@Return {value:"Label[]: Label array"}
public function <LabelList labelList> getAllLabels () returns (Label[]) {
    return labelList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              End of LabelList object                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

