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

endpoint http:ClientEndpoint gitHTTPClient {
      targets: [{uri: GIT_API_URL}]
};

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
//*********************************************************************************************************************
// Project bound functions
//*********************************************************************************************************************
@Description {value:"Get all columns of a project"}
@Return {value:"ColumnList: Column list object"}
@Return {value:"GitConnectorError: Error"}
public function <Project project> getColumnList (int recordCount) returns ColumnList|GitConnectorError {
    
    GitConnectorError connectorError = {};

    if (project == null) {
        connectorError = {message:["Project cannot be null"]};
        return connectorError;
    }

    if (recordCount > GIT_MAX_RECORD_COUNT) {
        connectorError = {message:["Maximum record count limited to " + GIT_MAX_RECORD_COUNT]};
        return connectorError;
    }
    string projectOwnerType = project.owner.getOwnerType();
    if (projectOwnerType.equalsIgnoreCase(GIT_ORGANIZATION) && project.resourcePath != null) {
        string organization = project.resourcePath.split(GIT_PATH_SEPARATOR)[GIT_INDEX_TWO];
        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization}}",
            "{{GIT_NUMBER}}":{{project.number}},"{{GIT_RECORD_COUNT}}":{{recordCount}}},"{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECT_COLUMNS}}"}`;
        return getProjectColumns(GIT_ORGANIZATION, stringQuery);

    } else if (projectOwnerType.equalsIgnoreCase(GIT_REPOSITORY) && project.resourcePath != null) {
        string ownerName = project.resourcePath.split(GIT_PATH_SEPARATOR)[GIT_INDEX_ONE];
        string repositoryName = project.resourcePath.split(GIT_PATH_SEPARATOR)[GIT_INDEX_TWO];

        string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{ownerName}}"
        ,"{{GIT_NAME}}":"{{repositoryName}}","{{GIT_NUMBER}}":{{project.number}},"{{GIT_RECORD_COUNT}}":{{recordCount}}}
        ,"{{GIT_QUERY}}":"{{GET_REPOSITORY_PROJECT_COLUMNS}}"}`;
        return getProjectColumns(GIT_REPOSITORY, stringQuery);
    }
    connectorError.message = ["No records found"];
    return connectorError;
}

@Description {value:"Get all columns of an organization project or repository project"}
@Param {value:"ownerType: Repository or Organization"}
@Param {value:"gitQuery: Graphql query"}
@Return {value:"ColumnList: Column list object"}
@Return {value:"GitConnectorError: Error"}
function getProjectColumns (string ownerType, string gitQuery) returns ColumnList|GitConnectorError {
    
    GitConnectorError connectorError = {};

    if (ownerType == null || ownerType == "" || gitQuery == null || gitQuery == "") {
        connectorError = {message:["Owner type and query cannot be null"]};
        return connectorError;
    }

    http:Request request = {};
    var convertedQuery = stringToJson(gitQuery);
    match convertedQuery {
        json jsonQuery => {
            //Set headers and payload to the request
            constructRequest(request, jsonQuery, gitAccessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }
    
    // Make an HTTP POST request
    var response = gitHTTPClient -> post("", request);

    //Check for empty payloads and errors
    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_PROJECT);

    match validatedResponse {
        json jsonValidateResponse => {
            var projectColumnsJson = jsonValidateResponse[GIT_DATA][ownerType][GIT_PROJECT][GIT_COLUMNS];
            var columnList = <ColumnList, jsonToColumnList(ownerType, gitQuery)>projectColumnsJson;

            return columnList;
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }
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

@Description {value: "Gets the next page of a project list"}
@Return {value: "ProjectList: Project list"}
public function <ProjectList projectList> nextPage () returns ProjectList|GitConnectorError {
    
    if (projectList.hasNextPage()) {

        http:Request request = {};
        json dataQuery;
        var convertedQuery = stringToJson(projectList.projectListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorProjects = projectList.pageInfo.endCursor;
                if (projectList.listOwner.equalsIgnoreCase(GIT_ORGANIZATION)) {
                    jsonQuery["query"] = GET_ORGANIZATION_PROJECTS_NEXT_PAGE;
                }else if (projectList.listOwner.equalsIgnoreCase(GIT_REPOSITORY)) {
                    jsonQuery["query"] = GET_REPOSITORY_PROJECTS_NEXT_PAGE;
                }
                dataQuery = jsonQuery;
                //Set headers and payload to the request
                constructRequest(request, jsonQuery, gitAccessToken);
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }

        // Make an HTTP POST request
        var response = gitHTTPClient -> post("", request);

        //Check for empty payloads and errors
        json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_PROJECTS);
        
        match validatedResponse {
            json jsonValidatedResponse => {
                var projectsJson = jsonValidatedResponse[GIT_DATA][projectList.listOwner][GIT_PROJECTS];
                var projList = <ProjectList, jsonToProjectList(projectList.listOwner, dataQuery.toString())>projectsJson;

                return projList;
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }  
    }

    GitConnectorError connectorError = {message:["Project list has no next page"]};

    return connectorError;
}

@Description {value:"Get an array of repositories"}
@Return {value:"RepositoryList[]: Array of repositories"}
public function <ProjectList projectList> getAllProjects () returns (Project[]) {
    return projectList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             End of ProjectList struct                                             //
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

@Description {value:"Get the next page of a repository list"}
@Return {value:"RepositoryList: Repository list"}
@Return {value:"GitConnectorError: Error"}
public function <RepositoryList repositoryList> nextPage () returns RepositoryList|GitConnectorError {
    
    if (repositoryList.hasNextPage()) {

        http:Request request = {};
        var convertedQuery = stringToJson(repositoryList.repositoryListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorRepos = repositoryList.pageInfo.endCursor;
                jsonQuery["query"] = GET_ORGANIZATION_REPOSITORIES_NEXT_PAGE;
                //Set headers and payload to the request
                constructRequest(request, jsonQuery, gitAccessToken);
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }

        // Make an HTTP POST request
        var response = gitHTTPClient -> post("", request);

        //Check for empty payloads and errors
        json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_REPOSITORIES);
        
        match validatedResponse {
            json jsonValidatedResponse => {
                var repositoriesJson = jsonValidatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_REPOSITORIES];
                var repoList = <RepositoryList, jsonToRepositoryList(repositoryList.repositoryListQuery)>repositoriesJson;

                return repoList;
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }         
    }
    GitConnectorError connectorError = {message:["Repository list has no next page"]};

    return connectorError;
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
//*********************************************************************************************************************
// Repository bound functions
//*********************************************************************************************************************
@Description {value:"Get all pull requests of a repository"}
@Param {value:"state: State of the repository (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_MERGED, GIT_STATE_ALL)"}
@Return {value:"PullRequest[]: Array of pull requests"}
@Return {value:"GitConnectorError: Error"}
public function <Repository repository> getPullRequestList (int recordCount, string state) returns PullRequestList|GitConnectorError {
    
    GitConnectorError connectorError = {};

    if (repository == null || state == "" || state == null) {
        connectorError = {message:["Repository and state cannot be null."]};
        return connectorError;
    }

    if (recordCount > GIT_MAX_RECORD_COUNT) {
        connectorError = {message:["Maximum record count limited to " + GIT_MAX_RECORD_COUNT]};
        return connectorError;
    }

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}"
    ,"{{GIT_NAME}}":"{{repository.name}}","{{GIT_STATES}}":{{state}},"{{GIT_RECORD_COUNT}}":{{recordCount}}},
    "{{GIT_QUERY}}":"{{GET_PULL_REQUESTS}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            //Set headers and payload to the request
            constructRequest(request, jsonQuery, gitAccessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }
    
    // Make an HTTP POST request
    var response = gitHTTPClient -> post("", request);

    //Check for empty payloads and errors
    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_PULL_REQUESTS);
    
    match validatedResponse {
            json jsonValidatedResponse => {
                var githubPullRequestsJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PULL_REQUESTS];
                var pullRequestList = <PullRequestList, jsonToPullRequestList(stringQuery)>githubPullRequestsJson;

                return pullRequestList;
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
    }
}

@Description {value:"Get all projects of a repository"}
@Param {value:"state: State of the repository (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_ALL)"}
@Return {value:"Project[]: Array of projects"}
@Return {value:"GitConnectorError: Error"}
public function <Repository repository> getProjectList (int recordCount, string state) returns ProjectList|GitConnectorError {
    
    GitConnectorError connectorError = {};

    if (repository == null || state == null) {
        connectorError = {message:["Repository and state cannot be null"]};
        return connectorError;
    }

    if (recordCount > GIT_MAX_RECORD_COUNT) {
        connectorError = {message:["Maximum record count limited to " + GIT_MAX_RECORD_COUNT]};
        return connectorError;
    }

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}",
        "{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_STATES}}":{{state}},"{{GIT_RECORD_COUNT}}":{{recordCount}}}
        ,"{{GIT_QUERY}}":"{{GET_REPOSITORY_PROJECTS}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            //Set headers and payload to the request
            constructRequest(request, jsonQuery, gitAccessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }
    
    // Make an HTTP POST request
    var response = gitHTTPClient -> post("", request);

    //Check for empty payloads and errors
    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_PROJECTS);

    match validatedResponse {
            json jsonValidatedResponse => {
                var githubProjectsJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECTS];
                var projectList = <ProjectList, jsonToProjectList(GIT_REPOSITORY, stringQuery)>githubProjectsJson;

                return projectList;
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
    }
}

@Description {value:"Get a single project of a repository."}
@Param {value:"projectNumber: The number of the project"}
@Return {value:"Project object"}
@Return {value:"GitConnectorError: Error"}
public function <Repository repository> getProject (int projectNumber) returns Project|GitConnectorError {
    
    GitConnectorError connectorError = {};

    if (repository == null || projectNumber <= 0) {
        connectorError = {message:["Repository cannot be null and project number should be positive integer."]};
        return connectorError;
    }

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}"
    ,"{{GIT_REPOSITORY}}":"{{repository.name}}","{{GIT_NUMBER}}":{{projectNumber}}}
    ,"{{GIT_QUERY}}":"{{GET_REPOSITORY_PROJECT}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            //Set headers and payload to the request
            constructRequest(request, jsonQuery, gitAccessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }

    // Make an HTTP POST request
    var response = gitHTTPClient -> post("", request);

    //Check for empty payloads and errors
    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_PROJECT);
    
    match validatedResponse {
            json jsonValidatedResponse => {
                var githubProjectJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PROJECT];
                var singleProject =? <Project>githubProjectJson;

                return singleProject;
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
    }
}

@Description {value:"Get a list of issues of a repository."}
@Param {value:"state: State of the issue (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_ALL)"}
@Return {value:"IssueList: Issue list object"}
@Return {value:"GitConnectorError: Error"}
public function <Repository repository> getIssueList (int recordCount, string state) returns IssueList|GitConnectorError {

    GitConnectorError connectorError = {};

    if (repository == null) {
        connectorError = {message:["Repository cannot be null"]};
        return connectorError;
    }

    if (recordCount > GIT_MAX_RECORD_COUNT) {
        connectorError = {message:["Maximum record count limited to " + GIT_MAX_RECORD_COUNT]};
        return connectorError;
    }
    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_OWNER}}":"{{repository.owner.login}}"
    ,"{{GIT_NAME}}":"{{repository.name}}","{{GIT_STATES}}":{{state}},"{{GIT_RECORD_COUNT}}":{{recordCount}}},
    "{{GIT_QUERY}}":"{{GET_REPOSITORY_ISSUES}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
        //Set headers and payload to the request
            constructRequest(request, jsonQuery, gitAccessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }

    // Make an HTTP POST request
    var response = gitHTTPClient -> post("", request);

    //Check for empty payloads and errors
    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_ISSUES);
    
    match validatedResponse {
            json jsonValidatedResponse => {
                var githubIssuesJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_ISSUES];
                var issueList = <IssueList, jsonToIssueList(stringQuery)>githubIssuesJson;
                
                return issueList;
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Repository struct                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
//*********************************************************************************************************************
// Organization bound functions
//*********************************************************************************************************************
@Description {value:"Get all projects of an organization."}
@Param {value:"state: State of the project (GIT_STATE_OPEN, GIT_STATE_CLOSED, GIT_STATE_ALL)"}
@Return {value:"Project[]: Array of projects"}
@Return {value:"GitConnectorError: Error"}
public function <Organization organization> getProjectList (int recordCount, string state) returns ProjectList|GitConnectorError {
    
    GitConnectorError connectorError = {};

    if (organization == null || state == null) {
        connectorError = {message:["Organization and state cannot be null."]};
        return connectorError;
    }

    if (recordCount > GIT_MAX_RECORD_COUNT) {
        connectorError = {message:["Maximum record count limited to " + GIT_MAX_RECORD_COUNT]};
        return connectorError;
    }

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization.login}}"
    ,"{{GIT_STATES}}":{{state}},"{{GIT_RECORD_COUNT}}":{{recordCount}}},"{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECTS}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            //Set headers and payload to the request
            constructRequest(request, jsonQuery, gitAccessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }
    
    // Make an HTTP POST request
    var response = gitHTTPClient -> post("", request);

    //Check for empty payloads and errors
    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_PROJECTS);
    
    match validatedResponse {
            json jsonValidatedResponse => {
                var githubProjectsJson = jsonValidatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_PROJECTS];
                var projectList = <ProjectList, jsonToProjectList(GIT_ORGANIZATION, stringQuery)>githubProjectsJson;

                return projectList;
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
	}
}

@Description {value:"Get a single project of an organization."}
@Param {value:"projectNumber: The number of the project"}
@Return {value:"Project object"}
@Return {value:"GitConnectorError: Error"}
public function <Organization organization> getProject (int projectNumber) returns Project|GitConnectorError {
    
    GitConnectorError connectorError = {};

    if (organization == null || projectNumber <= 0) {
        connectorError = {message:["Organization cannot be null and project number should be positive integer."]};
        return connectorError;
    }


    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization.login}}",
    "{{GIT_NUMBER}}":{{projectNumber}}},"{{GIT_QUERY}}":"{{GET_ORGANIZATION_PROJECT}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            //Set headers and payload to the request
            constructRequest(request, jsonQuery, gitAccessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }
    
    // Make an HTTP POST request
    var response = gitHTTPClient -> post("", request);

    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_PROJECT);
    
    match validatedResponse {
            json jsonValidatedResponse => {
                var githubProjectJson = jsonValidatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_PROJECT];
                var singleProject =? <Project>githubProjectJson;

                return singleProject;
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
	}
}

@Description {value:"Get a list of repositories of an organization."}
@Return {value:"RepositoryList: Repository list object"}
@Return {value:"GitConnectorError: Error"}
public function <Organization organization> getRepositoryList (int recordCount) returns RepositoryList|GitConnectorError {
    
    GitConnectorError connectorError = {};

    if (organization == null) {
        connectorError = {message:["Organization cannot be null."]};
        return connectorError;
    }

    if (recordCount > GIT_MAX_RECORD_COUNT) {
        connectorError = {message:["Maximum record count limited to " + GIT_MAX_RECORD_COUNT]};
        return connectorError;
    }

    string stringQuery = string `{"{{GIT_VARIABLES}}":{"{{GIT_ORGANIZATION}}":"{{organization.login}}",
    "{{GIT_RECORD_COUNT}}":{{recordCount}}},"{{GIT_QUERY}}":"{{GET_ORGANIZATION_REPOSITORIES}}"}`;

    http:Request request = {};
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
        //Set headers and payload to the request
            constructRequest(request, jsonQuery, gitAccessToken);
        }

        GitConnectorError gitConError => {
            return gitConError;
        }
    }
    
    // Make an HTTP POST request
    var response = gitHTTPClient -> post("", request);

    //Check for empty payloads and errors
    json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_REPOSITORIES);
    
    match validatedResponse {
            json jsonValidatedResponse => {
                var githubRepositoriesJson = jsonValidatedResponse[GIT_DATA][GIT_ORGANIZATION][GIT_REPOSITORIES];
                var repositoryList = <RepositoryList, jsonToRepositoryList(stringQuery)>githubRepositoriesJson;

                return repositoryList;
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                       End of Organization struct                                                  //
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

@Description {value:"Get the next page of the card list"}
@Return {value:"CardList: Card list object"}
@Return {value:"GitConnectorError: Error"}
public function <CardList cardList> nextPage () returns CardList|GitConnectorError {
    
    if (cardList.hasNextPage()) {
        var cardListColumnId = cardList.columnId;
        var convertedQuery = stringToJson(cardList.cardListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorCards = cardList.pageInfo.endCursor;

                if (cardList.listOwner.equalsIgnoreCase(GIT_ORGANIZATION)) {
                    jsonQuery["query"] = GET_ORGANIZATION_PROJECT_CARDS_NEXT_PAGE;
                    ColumnList|GitConnectorError columnList = getProjectColumns(GIT_ORGANIZATION, jsonQuery.toString());
                    match columnList {
                        ColumnList colList => {
                            foreach column in colList.getAllColumns() {
                                if (column.id == cardListColumnId) {
                                    return column.getCardList();
                                }
                            }
                        }

                        GitConnectorError gitConError => {
                            return gitConError;
                        }
                    }

                } else if (cardList.listOwner.equalsIgnoreCase(GIT_REPOSITORY)) {
                    jsonQuery["query"] = GET_REPOSITORY_PROJECT_CARDS_NEXT_PAGE;
                    ColumnList|GitConnectorError columnList = getProjectColumns(GIT_REPOSITORY, jsonQuery.toString());
                    match columnList {
                        ColumnList colList => {
                            foreach column in colList.getAllColumns() {
                                if (column.id == cardListColumnId) {
                                    return column.getCardList();
                                }
                            }
                        }

                        GitConnectorError gitConError => {
                            return gitConError;
                        }
                    }
                }
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }

    }
    GitConnectorError connectorError = {message:["Card list has no next page"]};

    return connectorError;
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

@Description {value:"Get the next page of column list"}
@Return {value:"ColumList: Column list object"}
@Return {value:"GitConnectorError: Error"}
public function <ColumnList columnList> nextPage () returns ColumnList|GitConnectorError {
    
    if (columnList.hasNextPage()) {
        var convertedQuery = stringToJson(columnList.columnListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorColumns = columnList.pageInfo.endCursor;
                if (columnList.listOwner.equalsIgnoreCase(GIT_ORGANIZATION)) {
                    jsonQuery["query"] = GET_ORGANIZATION_PROJECT_COLUMNS_NEXT_PAGE;

                    return getProjectColumns(GIT_ORGANIZATION, jsonQuery.toString());
                } else if (columnList.listOwner.equalsIgnoreCase(GIT_REPOSITORY)) {
                    jsonQuery["query"] = GET_REPOSITORY_PROJECT_COLUMNS_NEXT_PAGE;

                    return getProjectColumns(GIT_REPOSITORY, jsonQuery.toString());
                }
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }

    }
    GitConnectorError connectorError = {message:["Column list has no next page"]};

    return connectorError;
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
    Creator editor;
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

@Description {value:"Get the next page of the pull request list"}
@Return {value:"PullRequestList: PullRequest list object"}
@Return {value:"GitConnectorError: Error"}
public function <IssueList issueList> nextPage () returns IssueList|GitConnectorError {
    
    if (issueList.hasNextPage()) {
        http:Request request = {};
        var convertedQuery = stringToJson(issueList.issueListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorIssues = issueList.pageInfo.endCursor;
                jsonQuery["query"] = GET_REPOSITORY_ISSUES_NEXT_PAGE;
                //Set headers and payload to the request
                constructRequest(request, jsonQuery, gitAccessToken);
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }
        
        // Make an HTTP POST request
        var response = gitHTTPClient -> post("", request);

        //Check for empty payloads and errors
        json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_ISSUES);
        match validatedResponse {
            json jsonValidatedResponse => {
                var repositoryIssuesJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_ISSUES];
                var issuesList = <IssueList, jsonToIssueList(issueList.issueListQuery)>repositoryIssuesJson;

                return issuesList;
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
	    }

    }
    GitConnectorError connectorError = {message:["Pull request list has no next page"]};

    return connectorError;

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
        string pullrequestListQuery;
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

@Description {value:"Get the next page of the pull request list"}
@Return {value:"PullRequestList: PullRequest list object"}
@Return {value:"GitConnectorError: Error"}
public function <PullRequestList pullRequestList> nextPage () returns PullRequestList|GitConnectorError {
    
    if (pullRequestList.hasNextPage()) {

        http:Request request = {};
        var convertedQuery = stringToJson(pullRequestList.pullrequestListQuery);
        match convertedQuery {
            json jsonQuery => {
                jsonQuery.variables.endCursorPullRequests = pullRequestList.pageInfo.endCursor;
                jsonQuery["query"] = GET_PULL_REQUESTS_NEXT_PAGE;
                //Set headers and payload to the request
                constructRequest(request, jsonQuery, gitAccessToken);
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
        }
        
        // Make an HTTP POST request
        var response = gitHTTPClient -> post("", request);

        //Check for empty payloads and errors
        json|GitConnectorError validatedResponse = getValidatedResponse(response, GIT_PULL_REQUESTS);
        
        match validatedResponse {
            json jsonValidatedResponse => {
                var projectColumnsJson = jsonValidatedResponse[GIT_DATA][GIT_REPOSITORY][GIT_PULL_REQUESTS];
                var prList = <PullRequestList, jsonToPullRequestList(pullRequestList.pullrequestListQuery)>projectColumnsJson;

                return prList;
            }

            GitConnectorError gitConError => {
                return gitConError;
            }
	    }

    }
    GitConnectorError connectorError = {message:["Pull request list has no next page"]};

    return connectorError;

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
@Return {value:"Lebel[]: Label array"}
public function <LabelList labelList> getAllLabels () returns (Label[]) {
    return labelList.nodes;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                              End of LabelList struct                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

