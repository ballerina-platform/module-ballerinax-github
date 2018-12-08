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
    var value = PageInfo.convert(source_json.pageInfo);
    if (value is PageInfo) {
        target_projectList.pageInfo = value;
    }
    json[] nodes = [];
    var result = json[].convert(source_json.nodes);
    if (result is json[]) {
        nodes = result;
    }
    int i = 0;
    foreach var node in nodes {
        var project = Project.convert(node);
        if (project is Project) {
            target_projectList.nodes[i] = project;
        }
        i = i + 1;
    }

    return target_projectList;
}

//********************************
// JSON --> CardList
//********************************
function jsonToCardList(json source_json, string columnId, string listOwner, string stringQuery) returns (CardList) {
    CardList target_cardList = {};
    target_cardList.columnId = columnId;
    target_cardList.cardListQuery = stringQuery;
    target_cardList.listOwner = listOwner;
    var value = PageInfo.convert(source_json.pageInfo);
    if (value is PageInfo) {
        target_cardList.pageInfo = value;
    }
    var result = json[].convert(source_json.nodes);
    json[] nodes = [];
    if (result is json[]) {
        nodes = result;
    }
    int i = 0;
    foreach var node in nodes {
        var card = Card.convert(node);
        if (card is Card) {
            target_cardList.nodes[i] = card;
        }
        i = i + 1;
    }

    return target_cardList;
}

//********************************
// JSON --> Column
//********************************
function jsonToColumn(json source_json, string listOwner, string stringQuery) returns Column {
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
    var value = PageInfo.convert(source_json.pageInfo);
    json[] nodes = [];
    if (value is PageInfo) {
        target_columnList.pageInfo = value;
    }
    var result = json[].convert(source_json.nodes);
    if (result is json[]) {
        nodes = result;
    }
    int i = 0;
    foreach var node in nodes {
        var column = jsonToColumn(node, listOwner, stringQuery);
        target_columnList.nodes[i] = column;
        i = i + 1;
    }

    return target_columnList;
}

//********************************
// JSON --> RepositoryList
//********************************
function jsonToRepositoryList(json source_json, string stringQuery) returns (RepositoryList) {
    RepositoryList target_repositoryList = new;
    target_repositoryList.repositoryListQuery = stringQuery;
    var value = PageInfo.convert(source_json.pageInfo);
    if (value is PageInfo) {
        target_repositoryList.pageInfo = value;
    }
    json[] nodes = [];
    var result = json[].convert(source_json.nodes);
    if (result is json[]) {
        nodes = result;
    }
    int i = 0;
    foreach var node in nodes {
        var repository = jsonToRepository(node);
        target_repositoryList.nodes[i] = repository;
        i = i + 1;
    }

    return target_repositoryList;
}

//********************************
// JSON --> PullRequestList
//********************************
function jsonToPullRequestList(json source_json, string stringQuery) returns (PullRequestList) {
    PullRequestList target_pullRequestList = new;
    target_pullRequestList.pullRequestListQuery = stringQuery;
    var value = PageInfo.convert(source_json.pageInfo);
    if (value is PageInfo) {
        target_pullRequestList.pageInfo = value;
    }
    var result = json[].convert(source_json.nodes);
    json[] nodes = [];
    if (result is json[]) {
        nodes = result;
    }
    int i = 0;
    foreach var node in nodes {
        var pullRequest = PullRequest.convert(node);
        if (pullRequest is PullRequest) {
            target_pullRequestList.nodes[i] = pullRequest;
        }
        i = i + 1;
    }

    return target_pullRequestList;
}

//********************************
// JSON --> IssueList
//********************************
function jsonToIssueList(json source_json, string stringQuery) returns (IssueList) {
    IssueList target_issueList = new;
    target_issueList.issueListQuery = stringQuery;
    var value = PageInfo.convert(source_json.pageInfo);
    if (value is PageInfo) {
        target_issueList.pageInfo = value;
    }
    var result = json[].convert(source_json.nodes);
    json[] nodes = [];
    if (result is json[]) {
        nodes = result;
    }
    int i = 0;
    foreach var node in nodes {
        var issue = jsonToIssue(node);
        target_issueList.nodes[i] = issue;
        i = i + 1;
    }
    return target_issueList;
}

//********************************
// JSON --> REST Issue
//********************************
function restResponseJsonToIssue(json source_json) returns (Issue) {
    Issue target_issue = {};
    target_issue.id = source_json.id.toString();
    target_issue.title = source_json.title.toString();
    target_issue.bodyText = source_json.body.toString();
    target_issue.closedAt = source_json.closed_at.toString();
    target_issue.convertdAt = source_json.convertd_at.toString();
    target_issue.author.login = source_json.user.login.toString();
    target_issue.author.url = source_json.user.url.toString();
    target_issue.author.avatarUrl = source_json.user.avatar_url.toString();
    string stringNumber = source_json.number.toString();
    var value = int.convert(stringNumber);
    int intNumber = 0;
    if (value is int) {
        intNumber = value;
    }
    target_issue.number = intNumber;
    var result = json[].convert(source_json.labels);
    json[] labelList = [];
    if (result is json[]) {
        labelList = result;
    }

    int i = 0;
    foreach var label in labelList {
        Label singleLabel = {};
        singleLabel.id = label.id.toString();
        singleLabel.name = label.name.toString();
        singleLabel.color = label.color.toString();
        target_issue.labels[i] = singleLabel;
        i = i + 1;
    }
    var jsonValue = json[].convert(source_json.assignees);
    json[] assigneeList = [];
    if (jsonValue is json[]) {
        assigneeList = jsonValue;
    }
    int j = 0;
    foreach var assignee in assigneeList {
        Assignee singleAssignee = {};
        singleAssignee.id = assignee.id.toString();
        singleAssignee.login = assignee.login.toString();
        singleAssignee.url = assignee.url.toString();
        target_issue.assignees[j] = singleAssignee;
        j = j + 1;
    }

    return target_issue;
}

//********************************
// JSON --> Issue
//********************************
function jsonToIssue(json source_json) returns (Issue) {
    Issue target_issue = {};
    target_issue.id = source_json.id.toString();
    target_issue.title = source_json.title.toString();
    target_issue.bodyText = source_json.bodyText.toString();
    target_issue.closed = source_json.closed.toString();
    target_issue.closedAt = source_json.closedAt.toString();
    target_issue.convertdAt = source_json.convertdAt.toString();
    var creatorValue = Creator.convert(source_json.author);
    if (creatorValue is Creator) {
        target_issue.author = creatorValue;
    }
    string stringNumber = source_json.number.toString();
    var intNumber = int.convert(stringNumber);
    if (intNumber is int) {
        target_issue.number = intNumber;
    }
    json[] labelList = [];
    var jsonValue = json[].convert(source_json.labels.nodes);
    if (jsonValue is json[]) {
        labelList = jsonValue;
    }
    int i = 0;
    foreach var label in labelList {
        var labelValue = Label.convert(label);
        if (labelValue is Label) {
            target_issue.labels[i] = labelValue;
        }
        i = i + 1;
    }
    target_issue.state = source_json.state.toString();
    target_issue.updatedAt = source_json.updatedAt.toString();
    target_issue.url = source_json.url.toString();

    json[] assigneeList = [];
    var jsonVal = json[].convert(source_json.assignees.nodes);
    if (jsonVal is json[]) {
        assigneeList = jsonVal;
    }
    int j = 0;
    foreach var assignee in assigneeList {
        var assigneeValue = Assignee.convert(assignee);
        if (assigneeValue is Assignee) {
            target_issue.assignees[j] = assigneeValue;
        }
        j = j + 1;
    }

    return target_issue;
}

//********************************
// JSON --> Repository
//********************************
function jsonToRepository(json source_json) returns (Repository) {
    Repository target_repository = {};
    target_repository.id = source_json.id.toString();
    target_repository.name = source_json.name.toString();
    target_repository.convertdAt = source_json.convertdAt.toString();
    target_repository.updatedAt = source_json.updatedAt.toString();
    target_repository.description = source_json.description.toString();
    string stringForkCount = source_json.forkCount.toString();
    var intNumber = int.convert(stringForkCount);
    if (intNumber is int) {
        target_repository.forkCount = intNumber;
    }

    string stringHasWikiEnabled = source_json.hasWikiEnabled.toString();
    //boolean booleanHasWikiEnabled = false;
    boolean booleanHasWikiEnabled = boolean.convert(stringHasWikiEnabled);
    target_repository.hasWikiEnabled = booleanHasWikiEnabled;

    string stringHasIssuesEnabled = source_json.hasIssuesEnabled.toString();
    boolean booleanHasIssuesEnabled = boolean.convert(stringHasIssuesEnabled);
    target_repository.hasIssuesEnabled = booleanHasIssuesEnabled;

    string stringIsArchived = source_json.isArchived.toString();
    boolean booleanIsArchived = boolean.convert(stringIsArchived);
    target_repository.isArchived = booleanIsArchived;

    string stringIsFork = source_json.isFork.toString();
    boolean booleanIsFork = boolean.convert(stringIsFork);
    target_repository.isFork = booleanIsFork;

    string stringIsLocked = source_json.isLocked.toString();
    boolean booleanIsLocked = boolean.convert(stringIsLocked);
    target_repository.isLocked = booleanIsLocked;

    string stringIsMirror = source_json.isMirror.toString();
    boolean booleanIsMirror = boolean.convert(stringIsMirror);
    target_repository.isMirror = booleanIsMirror;

    string stringIsPrivate = source_json.isPrivate.toString();
    boolean booleanIsPrivate = boolean.convert(stringIsPrivate);
    target_repository.isPrivate = booleanIsPrivate;

    target_repository.homepageUrl = source_json.homepageUrl.toString();
    target_repository.lockReason = source_json.lockReason.toString();
    target_repository.mirrorUrl = source_json.mirrorUrl.toString();
    target_repository.url = source_json.url.toString();
    target_repository.sshUrl = source_json.sshUrl.toString();
    if (source_json.owner == null) {
        target_repository.owner = {};
    } else {
        var result = RepositoryOwner.convert(source_json.owner);
        if (result is RepositoryOwner) {
            target_repository.owner = result;
        }
    }
    if (source_json.primaryLanguage == null) {
        target_repository.primaryLanguage = {};
    } else {
        var result = Language.convert(source_json.primaryLanguage);
        if (result is Language) {
            target_repository.primaryLanguage = result;
        }
    }
    var intNum = int.convert(source_json.stargazers.totalCount);
    int stargazerCount = 0;
    if (intNum is int) {
        stargazerCount = intNum;
    }
    target_repository.stargazerCount = stargazerCount;
    return target_repository;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Connector Transformers                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
