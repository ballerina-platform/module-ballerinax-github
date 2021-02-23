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

isolated function parseInt(json input) returns int | error {
    if (input is int | float | decimal | string) {
        return <int>input;
    }
    error e = error("incompatible type");
    return e;
}

isolated function parseBoolean(json input) returns boolean | error {
    if (input is string) {
        if (input == "true") {
            return true;
        } else if (input == "false") {
            return false;
        }
    } else if (input is boolean) {
        return <boolean>input;
    }
    error e = error("incompatible type");
    return e;
}


//********************************
// JSON --> Project
//********************************
isolated function jsonToProject(json sourceJson) returns Project | error {
    Project project = {};
    project.id = <string>sourceJson.id;
    project.name = <string>sourceJson.name;
    project.body = <string>sourceJson.body;
    project.number = check parseInt(check sourceJson.number);
    project.createdAt = <string>sourceJson.createdAt;
    project.closed = (sourceJson.closed is boolean) ? sourceJson.closed.toString() : "";
    project.closedAt = (sourceJson.closedAt is string) ? (<string>sourceJson.closedAt) : "";
    project.updatedAt = (sourceJson.updatedAt is string) ? (<string>sourceJson.updatedAt) : "";
    project.resourcePath = <string>sourceJson.resourcePath;
    project.state = <string>sourceJson.state;
    project.url = <string>sourceJson.url;
    project.resourcePath = <string>sourceJson.resourcePath;
    project.viewerCanUpdate = <boolean>sourceJson.viewerCanUpdate;
    project.creator.login = <string>sourceJson.creator.login;
    project.creator.resourcePath = <string>sourceJson.creator.resourcePath;
    project.creator.url = <string>sourceJson.creator.url;
    project.creator.avatarUrl = <string>sourceJson.creator.avatarUrl;
    project.owner.id = <string>sourceJson.owner.id;
    project.owner.projectsResourcePath = <string>sourceJson.owner.projectsResourcePath;
    project.owner.projectsUrl = <string>sourceJson.owner.projectsUrl;
    project.owner.viewerCanCreateProjects = (sourceJson.owner.viewerCanCreateProjects is boolean) ?
    sourceJson.owner.viewerCanCreateProjects.toString() : "";
    project.owner.__typename = <string>sourceJson.owner.__typename;
    return project;
}

//********************************
// JSON --> ProjectList
//********************************
isolated function jsonToProjectList(json source_json, string listOwner, string stringQuery) returns (ProjectList) {
    ProjectList target_projectList = new;
    target_projectList.listOwner = listOwner;
    target_projectList.projectListQuery = stringQuery;
    json pageInfoJSON = <json>source_json.pageInfo;
    var value = pageInfoJSON.cloneWithType(PageInfo);
    if (value is PageInfo) {
        target_projectList.pageInfo = value;
    }
    json[] nodes = [];
    json nodes_filtered = <json>source_json.nodes;
    var result = nodes_filtered.cloneWithType(JsonArray);

    if (result is json[]) {
        nodes = result;
    }
    int i = 0;
    foreach var node in nodes {
        var project = jsonToProject(node);
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
isolated function jsonToCardList(json source_json, string columnId, string listOwner, string stringQuery) returns (CardList) {
    CardList target_cardList = {};
    target_cardList.columnId = columnId;
    target_cardList.cardListQuery = stringQuery;
    target_cardList.listOwner = listOwner;
    json nodes_filtered = <json>source_json.pageInfo;
    var value = nodes_filtered.cloneWithType(PageInfo);
    if (value is PageInfo) {
        target_cardList.pageInfo = value;
    }
    nodes_filtered = <json>source_json.nodes;
    var result = nodes_filtered.cloneWithType(JsonArray);
    json[] nodes = [];
    if (result is json[]) {
        nodes = result;
    }
    int i = 0;
    foreach var node in nodes {
        var json_node = <json>node;
        var card = json_node.cloneWithType(Card);
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
isolated function jsonToColumn(json source_json, string listOwner, string stringQuery) returns Column {
    Column target_column = new;
    target_column.id = source_json.id.toString();
    target_column.name = source_json.name.toString();
    target_column.columnQuery = stringQuery;
    target_column.listOwner = listOwner;
    target_column.cards = jsonToCardList(<json>source_json.cards, source_json.id.toString(), listOwner, stringQuery);
    return target_column;
}

//********************************
// JSON --> ColumnList
//********************************
isolated function jsonToColumnList(json source_json, string listOwner, string stringQuery) returns (ColumnList) {
    ColumnList target_columnList = new;
    target_columnList.listOwner = listOwner;
    target_columnList.columnListQuery = stringQuery;
    json nodes_filtered = <json>source_json.pageInfo;
    var value = nodes_filtered.cloneWithType(PageInfo);
    json[] nodes = [];
    if (value is PageInfo) {
        target_columnList.pageInfo = value;
    }
    nodes_filtered = <json>source_json.nodes;
    var result = nodes_filtered.cloneWithType(JsonArray);
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
isolated function jsonToRepositoryList(json source_json, string stringQuery) returns (RepositoryList) {
    RepositoryList target_repositoryList = new;
    target_repositoryList.repositoryListQuery = stringQuery;
    json nodes_filtered = <json>source_json.pageInfo;
    var value = nodes_filtered.cloneWithType(PageInfo);
    if (value is PageInfo) {
        target_repositoryList.pageInfo = value;
    }
    json[] nodes = [];
    nodes_filtered = <json>source_json.nodes;
    var result = nodes_filtered.cloneWithType(JsonArray);
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
isolated function jsonToPullRequestList(json source_json, string stringQuery) returns (PullRequestList) {
    PullRequestList target_pullRequestList = new;
    target_pullRequestList.pullRequestListQuery = stringQuery;
    json nodes_filtered = <json>source_json.pageInfo;
    var value = nodes_filtered.cloneWithType(PageInfo);
    if (value is PageInfo) {
        target_pullRequestList.pageInfo = value;
    }
    nodes_filtered = <json>source_json.nodes;
    var result = nodes_filtered.cloneWithType(JsonArray);
    json[] nodes = [];
    if (result is json[]) {
        nodes = result;
    }
    int i = 0;
    foreach var node in nodes {
        var json_node = <json>node;
        var pullRequest = json_node.cloneWithType(PullRequest);
        if (pullRequest is PullRequest) {
            target_pullRequestList.nodes[i] = pullRequest;
        }
        i = i + 1;
    }

    return target_pullRequestList;
}

//********************************
// JSON --> BranchList
//********************************
isolated function jsonToBranchList(json source_json, string stringQuery) returns (BranchList) {
    BranchList target_branchList = new;
    target_branchList.branchListQuery = stringQuery;
    json nodes_filtered = <json>source_json.pageInfo;
    var pageInfo = nodes_filtered.cloneWithType(PageInfo);
    if (pageInfo is PageInfo) {
        target_branchList.pageInfo = pageInfo;
    }
    nodes_filtered = <json>source_json.nodes;
    var result = nodes_filtered.cloneWithType(JsonArray);
    json[] nodes = [];
    if (result is json[]) {
        nodes = result;
    }
    int i = 0;
    foreach var node in nodes {
        var branch = jsonToBranch(node);
        target_branchList.nodes[i] = branch;
        i = i + 1;
    }
    return target_branchList;
}

//********************************
// JSON --> Branch
//********************************
isolated function jsonToBranch(json source_json) returns (Branch) {
    Branch target_branch = {};
    target_branch.name = source_json.name.toString();
    return target_branch;
}

//********************************
// JSON --> IssueList
//********************************
isolated function jsonToIssueList(json source_json, string stringQuery) returns (IssueList) {
    IssueList target_issueList = new;
    target_issueList.issueListQuery = stringQuery;
    json nodes_filtered = <json>source_json.pageInfo;
    var pageInfo = nodes_filtered.cloneWithType(PageInfo);
    if (pageInfo is PageInfo) {
        target_issueList.pageInfo = pageInfo;
    }
    nodes_filtered = <json>source_json.nodes;
    var result = nodes_filtered.cloneWithType(JsonArray);
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
isolated function restResponseJsonToIssue(json source_json) returns (Issue) {
    Issue target_issue = {};
    target_issue.id = source_json.id.toString();
    target_issue.title = source_json.title.toString();
    target_issue.bodyText = source_json.body.toString();
    target_issue.closedAt = source_json.closed_at.toString();
    target_issue.createdAt = source_json.created_at.toString();
    target_issue.author.login = source_json.user.login.toString();
    target_issue.author.url = source_json.user.url.toString();
    target_issue.author.avatarUrl = source_json.user.avatar_url.toString();
    var number = source_json.number;
    if (number is json) {
        int | error num = parseInt(number);
        if (num is int) {
            target_issue.number = num;
        }
    }
    json nodes_filtered = <json>source_json.labels;
    var result = nodes_filtered.cloneWithType(JsonArray);
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
    nodes_filtered = <json>source_json.assignees;
    var jsonValue = nodes_filtered.cloneWithType(JsonArray);
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
isolated function jsonToIssue(json source_json) returns (Issue) {
    Issue target_issue = {};
    target_issue.id = source_json.id.toString();
    target_issue.title = source_json.title.toString();
    target_issue.bodyText = source_json.bodyText.toString();
    target_issue.closed = source_json.closed.toString();
    target_issue.closedAt = source_json.closedAt.toString();
    target_issue.createdAt = source_json.createdAt.toString();
    json nodes_filtered = <json>source_json.author;
    var value = nodes_filtered.cloneWithType(Creator);
    if (value is Creator) {
        target_issue.author = value;
    }

    var num = source_json.number;
    if (num is json) {
        var number = parseInt(num);
        if (number is int) {
            target_issue.number = number;
        }
    }

    json[] labelList = [];
    nodes_filtered = <json>source_json.labels.nodes;
    var jsonValue = nodes_filtered.cloneWithType(JsonArray);
    if (jsonValue is json[]) {
        labelList = jsonValue;
    }
    int i = 0;
    foreach var label in labelList {
        json json_filtered = <json>label;
        var labelValue = json_filtered.cloneWithType(Label);
        if (labelValue is Label) {
            target_issue.labels[i] = labelValue;
        }
        i = i + 1;
    }
    target_issue.state = source_json.state.toString();
    target_issue.updatedAt = source_json.updatedAt.toString();
    target_issue.url = source_json.url.toString();

    json[] assigneeList = [];
    nodes_filtered = <json>source_json.assignees.nodes;
    var jsonVal = nodes_filtered.cloneWithType(JsonArray);
    if (jsonVal is json[]) {
        assigneeList = jsonVal;
    }
    int j = 0;
    foreach var assignee in assigneeList {
        nodes_filtered = <json>assignee;
        var assigneeValue = nodes_filtered.cloneWithType(Assignee);
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
isolated function jsonToRepository(json source_json) returns (Repository) {
    Repository target_repository = {};
    target_repository.id = source_json.id.toString();
    target_repository.name = source_json.name.toString();
    target_repository.createdAt = source_json.createdAt.toString();
    target_repository.updatedAt = source_json.updatedAt.toString();
    target_repository.description = source_json.description.toString();
    var jsonforkCount = source_json.forkCount;
    if (jsonforkCount is json) {
        var forkCount = parseInt(jsonforkCount);
        if (forkCount is int) {
            target_repository.forkCount = forkCount;
        }
    }

    var wikiEnabled = source_json.hasWikiEnabled;
    if (wikiEnabled is json) {
        var booleanHasWikiEnabled = parseBoolean(wikiEnabled);
        if (booleanHasWikiEnabled is boolean) {
            target_repository.hasWikiEnabled = booleanHasWikiEnabled;
        }
    }

    var issuesEnabled = source_json.hasIssuesEnabled;
    if (issuesEnabled is json) {
        var booleanHasIssuesEnabled = parseBoolean(issuesEnabled);
        if (booleanHasIssuesEnabled is boolean) {
            target_repository.hasIssuesEnabled = booleanHasIssuesEnabled;
        }
    }

    var isArchived = source_json.isArchived;
    if (isArchived is json) {
        var booleanIsArchived = parseBoolean(isArchived);
        if (booleanIsArchived is boolean) {
            target_repository.isArchived = booleanIsArchived;
        }
    }

    var isForksFork = source_json.isForksFork;
    if (isForksFork is json) {
        var booleanIsFork = parseBoolean(isForksFork);
        if (booleanIsFork is boolean) {
            target_repository.isFork = booleanIsFork;
        }
    }

    var isLocked = source_json.isLocked;
    if (isLocked is json) {
        var booleanIsLocked = parseBoolean(isLocked);
        if (booleanIsLocked is boolean) {
            target_repository.isLocked = booleanIsLocked;
        }
    }

    var isMirror = source_json.isMirror;
    if (isMirror is json) {
        var booleanIsMirror = parseBoolean(isMirror);
        if (booleanIsMirror is boolean) {
            target_repository.isMirror = booleanIsMirror;
        }
    }

    var isPrivate = source_json.isPrivate;
    if (isPrivate is json) {
        var booleanIsPrivate = parseBoolean(isPrivate);
        if (booleanIsPrivate is boolean) {
            target_repository.isPrivate = booleanIsPrivate;
        }
    }

    target_repository.homepageUrl = source_json.homepageUrl.toString();
    target_repository.lockReason = source_json.lockReason.toString();
    target_repository.mirrorUrl = source_json.mirrorUrl.toString();
    target_repository.url = source_json.url.toString();
    target_repository.sshUrl = source_json.sshUrl.toString();
    if (source_json.owner == null) {
        target_repository.owner = {};
    } else {
        var owner = source_json.owner;
        if (owner is json) {
            var result = owner.cloneWithType(RepositoryOwner);
            if (result is RepositoryOwner) {
                target_repository.owner = result;
            }
        }
    }
    if (source_json.primaryLanguage == null) {
        target_repository.primaryLanguage = {};
    } else {
        json nodes_filtered = <json>source_json.primaryLanguage;
        var result = nodes_filtered.cloneWithType(Language);
        if (result is Language) {
            target_repository.primaryLanguage = result;
        }
    }
    var count = source_json.stargazers.totalCount;
    if (count is json) {
        var stargazerCount = parseInt(count);
        if (stargazerCount is int) {
            target_repository.stargazerCount = stargazerCount;
        }
    }
    return target_repository;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Connector Transformers                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

isolated function jsonToOrganization(map<json> response) returns Organization {
    Organization organization = {};
    organization.id = response["id"].toString();
    organization.login = response["login"].toString();
    organization.name = response["name"].toString();
    organization.email = response["email"].toString();
    organization.description = response["description"].toString();
    organization.location = response["location"].toString();
    organization.resourcePath = response["resourcePath"].toString();
    organization.projectsResourcePath = response["projectsResourcePath"].toString();
    organization.projectsUrl = response["projectsUrl"].toString();
    organization.url = response["avatarUrl"].toString();
    organization.websiteUrl = response["websiteUrl"].toString();
    organization.avatarUrl = response["avatarUrl"].toString();
    return organization;
}

# Convert json to User.
# 
# + response - Json response
# + return - User record on success else an error
isolated function restResponseJsonToUser(json response) returns User|error {
    User|error res = response.cloneWithType(User);
    if (res is User) {
        return res;
    } else {
        return error(ERR_USER, res);
    }
}

isolated function jsonToPullRequest(map<json> response) returns PullRequest {
    PullRequest pullRequest = {};

    pullRequest["id"] = response["id"].toString();
    pullRequest["title"] = response["title"].toString();
    pullRequest["createdAt"] = response["created_at"].toString();
    pullRequest["updatedAt"] = response["updated_at"].toString();
    pullRequest["closed"] = false;
    pullRequest["closedAt"] = response["closed_at"].toString();
    pullRequest["mergedAt"] = response["merged_at"].toString();
    pullRequest["state"] = response["state"].toString();
    pullRequest["number"] = <int>response["number"];
    pullRequest["url"] = response["url"].toString();
    pullRequest["body"] = response["body"].toString();
    pullRequest["changedFiles"] = response["changed_files"] is ()? 0 : <int>response["changed_files"];
    pullRequest["additions"] = response["additions"] is ()? 0 : <int>response["additions"];
    pullRequest["deletions"] = response["deletions"] is ()? 0 : <int>response["deletions"];
    pullRequest["resourcePath"] = "";
    pullRequest["revertResourcePath"] = "";
    pullRequest["revertUrl"] = "";
    json|error pullRequestRef = response["head"].ref;
    if (pullRequestRef is json) {
        pullRequest["headRefName"] = pullRequestRef.toString();    
    }
    // pullRequest["headRefName"] = response["head"].ref.toString();
    json|error pullRequestBaseRefName = response["base"].ref;
    if (pullRequestBaseRefName is json) {
        pullRequest["baseRefName"] = pullRequestBaseRefName.toString();    
    }

    pullRequest["author"] = {
        login: response["user"].login.toString(),
        id: <int>response["user"].id,
        node_id: response["user"].node_id.toString(),
        avatar_url: response["user"].avatar_url.toString(),
        url: response["user"].url.toString(),
        html_url: response["user"].html_url.toString(),
        followers_url: response["user"].followers_url.toString(),
        following_url: response["user"].following_url.toString(),
        gists_url: response["user"].gists_url.toString(),
        starred_url: response["user"].starred_url.toString(),
        subscriptions_url: response["user"].subscriptions_url.toString(),
        organizations_url: response["user"].organizations_url.toString(),
        repos_url: response["user"].repos_url.toString(),
        events_url: response["user"].events_url.toString(),
        received_events_url: response["user"].received_events_url.toString(),
        'type: response["user"].'type.toString(),
        site_admin: <boolean>response["user"].site_admin
    };

    return pullRequest;
}
