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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           GitHub Connector Transformers                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//********************************
// JSON --> ProjectList
//********************************
function jsonToProjectList (json source_json, string listOwner, string stringQuery) returns (ProjectList) {
    ProjectList target_projectList = new;
    target_projectList.listOwner = listOwner;
    target_projectList.projectListQuery = stringQuery;
    target_projectList.pageInfo = check <PageInfo>source_json.pageInfo;
    json[] nodes = check <json[]> source_json.nodes;
    foreach i, node in nodes {
        var project = check <Project> node;
        target_projectList.nodes[i] = project;
    }

    return target_projectList;
}

//********************************
// JSON --> CardList
//********************************
function jsonToCardList (json source_json, string columnId, string listOwner, string stringQuery) returns (CardList) {
    CardList target_cardList = new;
    target_cardList.columnId = columnId;
    target_cardList.cardListQuery = stringQuery;
    target_cardList.listOwner = listOwner;
    target_cardList.pageInfo = check <PageInfo>source_json.pageInfo;
    json[] nodes = check <json[]> source_json.nodes;
    foreach i, node in nodes {
        var card = check <Card> node;
        target_cardList.nodes[i] = card;
    }

    return target_cardList;
}
//********************************
// JSON --> Column
//********************************
function jsonToColumn (json source_json, string listOwner, string stringQuery) returns (Column) {
    Column target_column = new;
    target_column.id = source_json.id.toString() ?: "";
    target_column.name = source_json.name.toString() ?: "";
    target_column.columnQuery = stringQuery;
    target_column.listOwner = listOwner;
    target_column.cards = jsonToCardList(source_json.cards, source_json.id.toString() ?: "", listOwner, stringQuery);
    return target_column;
}
//********************************
// JSON --> ColumnList
//********************************
function jsonToColumnList (json source_json, string listOwner, string stringQuery) returns (ColumnList) {
    ColumnList target_columnList = new;
    target_columnList.listOwner = listOwner;
    target_columnList.columnListQuery = stringQuery;
    target_columnList.pageInfo = check <PageInfo>source_json.pageInfo;
    json[] nodes = check <json[]>source_json.nodes;
    foreach i, node in nodes {
        var column = jsonToColumn(node, listOwner, stringQuery);
        target_columnList.nodes[i] = column;
    }

    return target_columnList;
}

//********************************
// JSON --> RepositoryList
//********************************
function jsonToRepositoryList (json source_json, string stringQuery) returns (RepositoryList) {
    RepositoryList target_repositoryList = new;
    target_repositoryList.repositoryListQuery = stringQuery;
    target_repositoryList.pageInfo = check <PageInfo>source_json.pageInfo;
    var nodes = check <json[]> source_json.nodes;
    foreach i, node in nodes {
        var repository = check <Repository> node;
        target_repositoryList.nodes[i] = repository;
    }

    return target_repositoryList;
}
//********************************
// JSON --> PullRequestList
//********************************
function jsonToPullRequestList (json source_json, string stringQuery) returns (PullRequestList) {
    PullRequestList target_pullRequestList = new;
    target_pullRequestList.pullRequestListQuery = stringQuery;
    target_pullRequestList.pageInfo = check <PageInfo>source_json.pageInfo;
    var nodes = check <json[]> source_json.nodes;
    foreach i, node in nodes {
        var pullRequest = check <PullRequest>node;
        target_pullRequestList.nodes[i] = pullRequest;
    }

    return target_pullRequestList;
}
//********************************
// JSON --> IssueList
//********************************
function jsonToIssueList (json source_json, string stringQuery) returns (IssueList) {
    IssueList target_issueList = new;
    target_issueList.issueListQuery = stringQuery;
    target_issueList.pageInfo = check <PageInfo>source_json.pageInfo;
    var nodes = check <json[]>source_json.nodes;
    foreach i, node in nodes {
        var issue = check <Issue> node;
        target_issueList.nodes[i] = issue;
    }

    return target_issueList;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Connector Transformers                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////