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

package github;

import ballerina/io;
import ballerina/net.http;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Organization struct                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github organization"}
public struct Organization {
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
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                       End of Organization struct                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Repository struct                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github repository"}
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
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Repository struct                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              RepositoryList struct                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a list of repositories"}
public struct RepositoryList {
    private:
        string repositoryListQuery;
        PageInfo pageInfo;
        Repository[] nodes;
}
//*********************************************************************************************************************
// RepositoryList bound functions
//*********************************************************************************************************************
@Description {value:"Check if repository list next page is available"}
@Return {value:"boolean: Return true or false"}
public function <RepositoryList repositoryList> hasNextPage () returns (boolean) {
    return repositoryList.pageInfo.hasNextPage;
}

@Description {value:"Check if repository list previous page is available"}
@Return {value:"boolean: Return true or false"}
public function <RepositoryList repositoryList> hasPreviousPage () returns (boolean) {
    return repositoryList.pageInfo.hasPreviousPage;
}

@Description {value:"Get an array of repositories"}
@Return {value:"RepositoryList[]: Array of repositories"}
public function <RepositoryList repositoryList> getAllRepositories () returns (Repository[]) {
    return repositoryList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                         End of RepositoryList struct                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Project struct                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github project"}
public struct Project {
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
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of Project struct                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                 ProjectList struct                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a list of projects"}
public struct ProjectList {
    private:
        string listOwner;
        string projectListQuery;
        PageInfo pageInfo;
        Project[] nodes;
}
//*********************************************************************************************************************
// ProjectList bound functions
//*********************************************************************************************************************
@Description {value:"Check if project list next page is available"}
@Return {value:"boolean: Return true or false"}
public function <ProjectList projectList> hasNextPage () returns (boolean) {
    return projectList.pageInfo.hasNextPage;
}

@Description {value:"Check if project list previous page is available"}
@Return {value:"boolean: Return true or false"}
public function <ProjectList projectList> hasPreviousPage () returns (boolean) {
    return projectList.pageInfo.hasPreviousPage;
}

@Description {value:"Get an array of projects"}
@Return {value:"Project[]: Array of projects"}
public function <ProjectList projectList> getAllProjects () returns (Project[]) {
    return projectList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of ProjectList struct                                             //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              Column struct                                                        //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github Column"}
public struct Column {
    string id;
    string name;
    string columnQuery;
    string listOwner;
    private:
        CardList cards;
}
//*********************************************************************************************************************
// Column bound functions
//*********************************************************************************************************************
@Description {value:"Get a list of cards of a column"}
@Return {value:"CardList: A card list object"}
public function <Column column> getCardList () returns (CardList) {
    return column.cards;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              End of Column struct                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              ColumnList struct                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a list of columns of a project"}
public struct ColumnList {
    private:
        string listOwner;
        string columnListQuery;
        PageInfo pageInfo;
        Column[] nodes;
}
//*********************************************************************************************************************
// ColumnList bound functions
//*********************************************************************************************************************
@Description {value:"Check if column list next page is available"}
@Return {value:"boolean: Return true or false"}
public function <ColumnList columnList> hasNextPage () returns (boolean) {
    return columnList.pageInfo.hasNextPage;
}

@Description {value:"Check if column list previosu page is available"}
@Return {value:"boolean: Return true or false"}
public function <ColumnList columnList> hasPreviousPage () returns (boolean) {
    return columnList.pageInfo.hasPreviousPage;
}

@Description {value:"Get an array of all the columns"}
@Return {value:"Column[]: Column array"}
public function <ColumnList columnList> getAllColumns () returns (Column[]) {
    return columnList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                          End of ColumnList struct                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                   Card struct                                                     //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github card"}
public struct Card {
    string id;
    string note;
    string state;
    string createdAt;
    string updatedAt;
    string url;
    Creator creator;
    json column;
    json content;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               End of Card struct                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              CardList struct                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a list of cards of a column"}
public struct CardList {
    private:
        string columnId;
        string cardListQuery;
        string listOwner;
        PageInfo pageInfo;
        Card[] nodes;
}
//*********************************************************************************************************************
// CardList bound functions
//*********************************************************************************************************************
@Description {value:"Check if the card list next page is available"}
@Return {value:"boolean: Return true or false"}
public function <CardList cardList> hasNextPage () returns (boolean) {
    return cardList.pageInfo.hasNextPage;
}

@Description {value:"Check if the card list previous page is available"}
@Return {value:"boolean: Return true or false"}
public function <CardList cardList> hasPreviousPage () returns (boolean) {
    return cardList.pageInfo.hasPreviousPage;
}

@Description {value:"Get an array of all the cards"}
@Return {value:"Card[]: Array of cards"}
public function <CardList cardList> getAllCards () returns (Card[]) {
    return cardList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of CardList struct                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              PullRequest struct                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github pull request"}
public struct PullRequest {
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
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of PullRequest struct                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             PullRequestList struct                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a list of github pull requests"}
public struct PullRequestList {
    private:
        string pullRequestListQuery;
        PageInfo pageInfo;
        PullRequest[] nodes;
}
//*********************************************************************************************************************
// PullRequestList bound functions
//*********************************************************************************************************************
@Description {value:"Check if pull request list next page is available"}
@Return {value:"boolean: Return true or false"}
public function <PullRequestList pullRequestList> hasNextPage () returns (boolean) {
    return pullRequestList.pageInfo.hasNextPage;
}

@Description {value:"Check if pull request list previous page is avaiable"}
@Return {value:"boolean: Return ture or false"}
public function <PullRequestList pullRequestList> hasPreviousPage () returns (boolean) {
    return pullRequestList.pageInfo.hasPreviousPage;
}

@Description {value:"Get an array of all the pull requests"}
@Return {value:"PullRequest[]: PullRequest array"}
public function <PullRequestList pullRequestList> getAllPullRequests () returns (PullRequest[]) {
    return pullRequestList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                          End of PullRequestList struct                                            //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                Issue struct                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github issue"}
public struct Issue {
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
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              End of Issue struct                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                IssueList struct                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a list of github issues"}
public struct IssueList {
    private:
        string issueListQuery;
        PageInfo pageInfo;
        Issue[] nodes;
}
//*********************************************************************************************************************
// IssueList bound functions
//*********************************************************************************************************************
@Description {value:"Check if issue list next page is available"}
@Return {value:"boolean: Return true or false"}
public function <IssueList issueList> hasNextPage () returns (boolean) {
    return issueList.pageInfo.hasNextPage;
}

@Description {value:"Check if issue list previous page is avaiable"}
@Return {value:"boolean: Return ture or false"}
public function <IssueList issueList> hasPreviousPage () returns (boolean) {
    return issueList.pageInfo.hasPreviousPage;
}

@Description {value:"Get an array of all the issues"}
@Return {value:"Issue[]: Issue array"}
public function <IssueList issueList> getAllIssues () returns (Issue[]) {
    return issueList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of IssueList struct                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               Creator struct                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github Creator"}
public struct Creator {
    string login;
    string resourcePath;
    string url;
    string avatarUrl;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of Creator struct                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              ProjectOwner struct                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github project owner"}
public struct ProjectOwner {
    string id;
    string projectsResourcePath;
    string projectsUrl;
    string viewerCanCreateProjects;
    private:
        string __typename;
}
//*********************************************************************************************************************
// ProjectOwner bound functions
//*********************************************************************************************************************
@Description {value:"Get the type of the project owner"}
@Return {value:"string: Type of the owner"}
public function <ProjectOwner projectOwner> getOwnerType () returns (string) {
    return projectOwner.__typename;
}

@Description {value:"Set the type of the project owner"}
public function <ProjectOwner projectOwner> setOwnerType (string ownerType) {
    projectOwner.__typename = ownerType;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of ProjectOwner struct                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            RepositoryOwner struct                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github repository owner"}
public struct RepositoryOwner {
    string id;
    string login;
    string url;
    string avatarUrl;
    string resourcePath;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                          End RepositoryOwner struct                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               Content struct                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a content in a github card"}
public struct Content {
    string title;
    string url;
    string issueState;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Content struct                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                Language struct                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github language"}
public struct Language {
    string id;
    string name;
    string color;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of Language struct                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            GitConnectorError struct                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"GitHub Connector Error"}
public struct GitConnectorError {
    int statusCode;
    string[] message;
    string reasonPhrase;
    string server;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                         End of GitConnectorError struct                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                PageInfo struct                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github page information"}
struct PageInfo {
    boolean hasNextPage;
    boolean hasPreviousPage;
    string startCursor;
    string endCursor;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            End of PageInfo struct                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                 Label struct                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a github label"}
public struct Label {
    string id;
    string name;
    string description;
    string color;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of Label struct                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               LabelList struct                                                    //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@Description {value:"Represents a list of github labels"}
public struct LabelList {
    private:
        Label[] nodes;
}
//*********************************************************************************************************************
// LabelList bound functions
//*********************************************************************************************************************
@Description {value:"Get an array of labels"}
@Return {value:"Label[]: Label array"}
public function <LabelList labelList> getAllLabels () returns (Label[]) {
    return labelList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              End of LabelList struct                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

