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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           GitHub Connector Transformers                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//********************************
// JSON --> ProjectList
//********************************
function jsonToProjectList(json source_json, string listOwner, string stringQuery) returns (ProjectList) {
    ProjectList target_projectList = new;
    target_projectList.listOwner = listOwner;
    target_projectList.projectListQuery = stringQuery;
    target_projectList.pageInfo = check <PageInfo>source_json.pageInfo;
    json[] nodes = check <json[]>source_json.nodes;
    foreach i, node in nodes {
        var project = check <Project>node;
        target_projectList.nodes[i] = project;
    }

    return target_projectList;
}

//********************************
// JSON --> CardList
//********************************
function jsonToCardList(json source_json, string columnId, string listOwner, string stringQuery) returns (CardList) {
    CardList target_cardList = new;
    target_cardList.columnId = columnId;
    target_cardList.cardListQuery = stringQuery;
    target_cardList.listOwner = listOwner;
    target_cardList.pageInfo = check <PageInfo>source_json.pageInfo;
    json[] nodes = check <json[]>source_json.nodes;
    foreach i, node in nodes {
        var card = check <Card>node;
        target_cardList.nodes[i] = card;
    }

    return target_cardList;
}

//********************************
// JSON --> Column
//********************************
function jsonToColumn(json source_json, string listOwner, string stringQuery) returns (Column) {
    Column target_column = new;
    target_column.id = source_json.id.toString();
    target_column.name = source_json.name.toString();
    target_column.columnQuery = stringQuery;
    target_column.listOwner = listOwner;
    target_column.cards = jsonToCardList(source_json.cards, source_json.id.toString(), listOwner, stringQuery);
    return target_column;
}

//********************************
// JSON --> ColumnList
//********************************
function jsonToColumnList(json source_json, string listOwner, string stringQuery) returns (ColumnList) {
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
function jsonToRepositoryList(json source_json, string stringQuery) returns (RepositoryList) {
    RepositoryList target_repositoryList = new;
    target_repositoryList.repositoryListQuery = stringQuery;
    target_repositoryList.pageInfo = check <PageInfo>source_json.pageInfo;
    var nodes = check <json[]>source_json.nodes;
    foreach i, node in nodes {
        var repository = jsonToRepository(node);
        target_repositoryList.nodes[i] = repository;
    }

    return target_repositoryList;
}

//********************************
// JSON --> PullRequestList
//********************************
function jsonToPullRequestList(json source_json, string stringQuery) returns (PullRequestList) {
    PullRequestList target_pullRequestList = new;
    target_pullRequestList.pullRequestListQuery = stringQuery;
    target_pullRequestList.pageInfo = check <PageInfo>source_json.pageInfo;
    var nodes = check <json[]>source_json.nodes;
    foreach i, node in nodes {
        var pullRequest = check <PullRequest>node;
        target_pullRequestList.nodes[i] = pullRequest;
    }

    return target_pullRequestList;
}

//********************************
// JSON --> IssueList
//********************************
function jsonToIssueList(json source_json, string stringQuery) returns (IssueList) {
    IssueList target_issueList = new;
    target_issueList.issueListQuery = stringQuery;
    target_issueList.pageInfo = check <PageInfo>source_json.pageInfo;
    var nodes = check <json[]>source_json.nodes;
    foreach i, node in nodes {
        var issue = jsonToIssue(node);
        target_issueList.nodes[i] = issue;
    }

    return target_issueList;
}

//********************************
// JSON --> REST Issue
//********************************
function restResponseJsonToIssue(json source_json) returns (Issue) {
    Issue target_issue;
    target_issue.id = source_json.id.toString();
    target_issue.title = source_json.title.toString();
    target_issue.bodyText = source_json.body.toString();
    target_issue.closedAt = source_json.closed_at.toString();
    target_issue.createdAt = source_json.created_at.toString();
    target_issue.author.login = source_json.user.login.toString();
    target_issue.author.url = source_json.user.url.toString();
    target_issue.author.avatarUrl = source_json.user.avatar_url.toString();
    string stringNumber = source_json.number.toString();
    int intNumber = check <int>stringNumber;
    target_issue.number = intNumber;

    json[] labelList = check <json[]>source_json.labels;
    foreach i, label in labelList {
        Label singleLabel;
        singleLabel.id = label.id.toString();
        singleLabel.name = label.name.toString();
        singleLabel.color = label.color.toString();
        target_issue.labels[i] = singleLabel;
    }

    json[] assigneeList = check <json[]>source_json.assignees;
    foreach i, assignee in assigneeList {
        Assignee singleAssignee;
        singleAssignee.id = assignee.id.toString();
        singleAssignee.login = assignee.login.toString();
        singleAssignee.url = assignee.url.toString();
        target_issue.assignees[i] = singleAssignee;
    }

    return target_issue;
}

//********************************
// JSON --> Issue
//********************************
function jsonToIssue(json source_json) returns (Issue) {
    Issue target_issue;
    target_issue.id = source_json.id.toString();
    target_issue.title = source_json.title.toString();
    target_issue.bodyText = source_json.bodyText.toString();
    target_issue.closed = source_json.closed.toString();
    target_issue.closedAt = source_json.closedAt.toString();
    target_issue.createdAt = source_json.createdAt.toString();
    target_issue.author = check <Creator>source_json.author;
    string stringNumber = source_json.number.toString();
    int intNumber = check <int>stringNumber;
    target_issue.number = intNumber;
    json[] labelList = check <json[]>source_json.labels.nodes;
    foreach i, label in labelList {
        target_issue.labels[i] = check <Label>label;
    }
    target_issue.state = source_json.state.toString();
    target_issue.updatedAt = source_json.updatedAt.toString();
    target_issue.url = source_json.url.toString();

    json[] assigneeList = check <json[]>source_json.assignees.nodes;
    foreach i, assignee in assigneeList {
        target_issue.assignees[i] = check <Assignee>assignee;
    }

    return target_issue;
}

//********************************
// JSON --> Repository
//********************************
function jsonToRepository(json source_json) returns (Repository) {
    Repository target_repository;
    target_repository.id = source_json.id.toString();
    target_repository.name = source_json.name.toString();
    target_repository.createdAt = source_json.createdAt.toString();
    target_repository.updatedAt = source_json.updatedAt.toString();
    target_repository.description = source_json.description.toString();
    string stringForkCount = source_json.forkCount.toString();
    int intForkCount = check <int>stringForkCount;
    target_repository.forkCount = intForkCount;

    string stringHasWikiEnabled = source_json.hasWikiEnabled.toString();
    boolean booleanHasWikiEnabled = <boolean>stringHasWikiEnabled;
    target_repository.hasWikiEnabled = booleanHasWikiEnabled;

    string stringHasIssuesEnabled = source_json.hasIssuesEnabled.toString();
    boolean booleanHasIssuesEnabled = <boolean>stringHasIssuesEnabled;
    target_repository.hasIssuesEnabled = booleanHasIssuesEnabled;

    string stringIsArchived = source_json.isArchived.toString();
    boolean booleanIsArchived = <boolean>stringIsArchived;
    target_repository.isArchived = booleanIsArchived;

    string stringIsFork = source_json.isFork.toString();
    boolean booleanIsFork = <boolean>stringIsFork;
    target_repository.isFork = booleanIsFork;

    string stringIsLocked = source_json.isLocked.toString();
    boolean booleanIsLocked = <boolean>stringIsLocked;
    target_repository.isLocked = booleanIsLocked;

    string stringIsMirror = source_json.isMirror.toString();
    boolean booleanIsMirror = <boolean>stringIsMirror;
    target_repository.isMirror = booleanIsMirror;

    string stringIsPrivate = source_json.isPrivate.toString();
    boolean booleanIsPrivate = <boolean>stringIsPrivate;
    target_repository.isPrivate = booleanIsPrivate;

    target_repository.homepageUrl = source_json.homepageUrl.toString();
    target_repository.lockReason = source_json.lockReason.toString();
    target_repository.mirrorUrl = source_json.mirrorUrl.toString();
    target_repository.url = source_json.url.toString();
    target_repository.sshUrl = source_json.sshUrl.toString();
    target_repository.owner = source_json.owner == null ? {} : check <RepositoryOwner>source_json.owner;
    target_repository.primaryLanguage = source_json.primaryLanguage == null ? {} : check <Language>source_json.
    primaryLanguage;

    return target_repository;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Connector Transformers                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////