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

// import ballerina/io;

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
    // Project project = checkpanic sourceJson.cloneWithType(Project);
    Project project = {};
    json|error id = sourceJson.id;
    if (id is json) {
        project.id = id.toString();
    }
    json|error name = sourceJson.name;
    if (name is json) {
        project.name = name.toString();
    }
    json|error body = sourceJson.body;
    if (body is json) {
        project.body = body.toString();
    }
    var number = sourceJson.number;
    if (number is json) {
        int | error num = parseInt(number);
        if (num is int) {
            project.number = num;
        }
    }
    json|error createdAt = sourceJson.createdAt;
    if (createdAt is json) {
        project.createdAt = createdAt.toString();
    }
    json|error closedAt = sourceJson.closedAt;
    if (closedAt is json) {
        project.closedAt = closedAt.toString();
    }
    json|error updatedAt = sourceJson.updatedAt;
    if (updatedAt is json) {
        project.updatedAt = updatedAt.toString();
    }
    json|error resourcePath = sourceJson.resourcePath;
    if (resourcePath is json) {
        project.resourcePath = resourcePath.toString();
    }
    json|error state = sourceJson.state;
    if (state is json) {
        project.state = state.toString();
    }
    json|error url = sourceJson.url;
    if (url is json) {
        project.url = url.toString();
    }
    json|error viewerCanUpdate = sourceJson.viewerCanUpdate;
    if (viewerCanUpdate is json) {
        project.viewerCanUpdate = <boolean>viewerCanUpdate;
    }
    json|error creatorLogin = sourceJson.creator.login;
    if (creatorLogin is json) {
        project.creator.login = creatorLogin.toString();
    }
    json|error creatorResourcePath = sourceJson.creator.resourcePath;
    if (creatorResourcePath is json) {
        project.creator.resourcePath = creatorResourcePath.toString();
    }
    json|error creatorUrl = sourceJson.creator.url;
    if (creatorUrl is json) {
        project.creator.resourcePath = creatorUrl.toString();
    }
    json|error creatorAvatarUrl = sourceJson.creator.avatarUrl;
    if (creatorAvatarUrl is json) {
        project.creator.avatarUrl = creatorAvatarUrl.toString();
    }
    json|error ownerId = sourceJson.owner.id;
    if (ownerId is json) {
        project.creator.avatarUrl = ownerId.toString();
    }
    json|error ownerProjectResourcePath = sourceJson.owner.projectsResourcePath;
    if (ownerProjectResourcePath is json) {
        project.owner.projectsResourcePath = ownerProjectResourcePath.toString();
    }
    json|error ownerProjectsUrl = sourceJson.owner.projectsUrl;
    if (ownerProjectsUrl is json) {
        project.owner.projectsUrl = ownerProjectsUrl.toString();
    }
    json|error viewerCanCreateProject = sourceJson.owner.viewerCanCreateProjects;
    if (viewerCanCreateProject is json) {
        project.owner.viewerCanCreateProjects = viewerCanCreateProject.toString();
    }
    json|error ownerTypeName = sourceJson.owner.__typename;
    if (ownerTypeName is json) {
        project.owner.__typename = ownerTypeName.toString();
    }

    return project;
}

//********************************
// JSON --> ProjectList
//********************************
isolated function jsonToProjectList(json source_json, string listOwner, string stringQuery) returns (ProjectList) {
    ProjectList target_projectList = new;
    target_projectList.listOwner = listOwner;
    target_projectList.projectListQuery = stringQuery;
    json pageInfoJSON = checkpanic source_json.pageInfo;
    var value = pageInfoJSON.cloneWithType(PageInfo);
    if (value is PageInfo) {
        target_projectList.pageInfo = value;
    }
    json[] nodes = [];
    json nodes_filtered =  checkpanic source_json.nodes;
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
    json nodes_filtered = checkpanic source_json.pageInfo;
    var value = nodes_filtered.cloneWithType(PageInfo);
    if (value is PageInfo) {
        target_cardList.pageInfo = value;
    }
    nodes_filtered = checkpanic source_json.nodes;
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
    json|error id = source_json.id;
    if (id is json) {
        target_column.id = id.toString();
    }
    json|error name = source_json.name;
    if (name is json) {
        target_column.name = name.toString();
    }
    target_column.columnQuery = stringQuery;
    target_column.listOwner = listOwner;

    json cards = checkpanic source_json.cards;

    target_column.cards = jsonToCardList(cards, target_column.id, listOwner, stringQuery);
    return target_column;
}

//********************************
// JSON --> ColumnList
//********************************
isolated function jsonToColumnList(json source_json, string listOwner, string stringQuery) returns (ColumnList) {
    ColumnList target_columnList = new;
    target_columnList.listOwner = listOwner;
    target_columnList.columnListQuery = stringQuery;
    json nodes_filtered = checkpanic source_json.pageInfo;
    var value = nodes_filtered.cloneWithType(PageInfo);
    json[] nodes = [];
    if (value is PageInfo) {
        target_columnList.pageInfo = value;
    }
    nodes_filtered = checkpanic source_json.nodes;
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
    json nodes_filtered = checkpanic source_json.pageInfo;
    var value = nodes_filtered.cloneWithType(PageInfo);
    if (value is PageInfo) {
        target_repositoryList.pageInfo = value;
    }
    json[] nodes = [];
    nodes_filtered = checkpanic source_json.nodes;
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
    json nodes_filtered = checkpanic source_json.pageInfo;
    var value = nodes_filtered.cloneWithType(PageInfo);
    if (value is PageInfo) {
        target_pullRequestList.pageInfo = value;
    }
    nodes_filtered = checkpanic source_json.nodes;
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
    json nodes_filtered = checkpanic source_json.pageInfo;
    var pageInfo = nodes_filtered.cloneWithType(PageInfo);
    if (pageInfo is PageInfo) {
        target_branchList.pageInfo = pageInfo;
    }
    nodes_filtered = checkpanic source_json.nodes;
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
    json|error name = source_json.name;
    if (name is json) {
        target_branch.name = name.toString();
    }
    return target_branch;
}

//********************************
// JSON --> IssueList
//********************************
isolated function jsonToIssueList(json source_json, string stringQuery) returns (IssueList) {
    IssueList target_issueList = new;
    target_issueList.issueListQuery = stringQuery;
    json nodes_filtered = checkpanic source_json.pageInfo;
    var pageInfo = nodes_filtered.cloneWithType(PageInfo);
    if (pageInfo is PageInfo) {
        target_issueList.pageInfo = pageInfo;
    }
    nodes_filtered = checkpanic source_json.nodes;
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
    json|error id = source_json.id;
    if (id is json) {
        target_issue.id = id.toString();
    }
    // target_issue.id = source_json.id.toString();
    json|error title = source_json.title;
    if (title is json) {
        target_issue.title = title.toString();
    }
    // target_issue.title = source_json.title.toString();
    json|error bodyText = source_json.body;
    if (bodyText is json) {
        target_issue.bodyText = bodyText.toString();
    }
    // target_issue.bodyText = source_json.body.toString();
    json|error closedAt = source_json.closed_at;
    if (closedAt is json){
        target_issue.closedAt = closedAt.toString();
    }
    // target_issue.closedAt = source_json.closed_at.toString();
    json|error createdAt = source_json.created_at;
    if (createdAt is json){
        target_issue.createdAt = createdAt.toString();
    }
    // target_issue.createdAt = source_json.created_at.toString();
    json|error login = source_json.user.login;
    if (login is json){
        target_issue.author.login = login.toString();
    }
    // target_issue.author.login = source_json.user.login.toString();
    json|error url = source_json.user.url;
    if (url is json){
        target_issue.author.url = url.toString();
    }
    // target_issue.author.url = source_json.user.url.toString();
    json|error avatarUrl = source_json.user.avatar_url;
    if (avatarUrl is json){
        target_issue.author.avatarUrl = avatarUrl.toString();
    }
    // target_issue.author.avatarUrl = source_json.user.avatar_url.toString();
    var number = source_json.number;
    if (number is json) {
        int | error num = parseInt(number);
        if (num is int) {
            target_issue.number = num;
        }
    }
    json nodes_filtered = checkpanic source_json.labels;
    var result = nodes_filtered.cloneWithType(JsonArray);
    json[] labelList = [];
    if (result is json[]) {
        labelList = result;
    }

    int i = 0;
    foreach var label in labelList {
        Label singleLabel = {};
        json|error labelId = label.id;
        if (labelId is json) {
            singleLabel.id = labelId.toString();
        }
        json|error name = label.name;
        if (name is json) {
            singleLabel.name = name.toString();
        }
        json|error color = label.color;
        if (color is json) {
            singleLabel.color = color.toString();
        }
        target_issue.labels[i] = singleLabel;
        i = i + 1;
    }
    nodes_filtered = checkpanic source_json.assignees;
    var jsonValue = nodes_filtered.cloneWithType(JsonArray);
    json[] assigneeList = [];
    if (jsonValue is json[]) {
        assigneeList = jsonValue;
    }
    int j = 0;
    foreach var assignee in assigneeList {
        Assignee singleAssignee = {};
        json|error assigneeId = assignee.id;
        if (assigneeId is json) {
            singleAssignee.id = assigneeId.toString();
        }
        // singleAssignee.id = assignee.id.toString();
        json|error assigneeLogin = assignee.login;
        if (assigneeLogin is json) {
            singleAssignee.login = assigneeLogin.toString();
        }
        // singleAssignee.login = assignee.login.toString();
        json|error assigneeUrl = assignee.url;
        if (assigneeUrl is json) {
            singleAssignee.url = assigneeUrl.toString();
        }
        // singleAssignee.url = assignee.url.toString();
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
    json|error issueId =  source_json.id;
    if (issueId is json) {
        target_issue.id = issueId.toString();
    }
    // target_issue.id = source_json.id.toString();
    json|error issueTitle =  source_json.title;
    if (issueTitle is json) {
        target_issue.title = issueTitle.toString();
    }
    // target_issue.title = source_json.title.toString();
    json|error issueBodyText =  source_json.bodyText;
    if (issueBodyText is json) {
        target_issue.bodyText = issueBodyText.toString();
    }
    // target_issue.bodyText = source_json.bodyText.toString();
    json|error issueClosed =  source_json.closed;
    if (issueClosed is json) {
        target_issue.closed = issueClosed.toString();
    }
    // target_issue.closed = source_json.closed.toString();
    json|error issueClosedAt =  source_json.closedAt;
    if (issueClosedAt is json) {
        target_issue.closedAt = issueClosedAt.toString();
    }
    // target_issue.closedAt = source_json.closedAt.toString();
    json|error issueCreatedAt =  source_json.createdAt;
    if (issueCreatedAt is json) {
        target_issue.createdAt = issueCreatedAt.toString();
    }
    // target_issue.createdAt = source_json.createdAt.toString();
    json nodes_filtered = checkpanic source_json.author;
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
    nodes_filtered = checkpanic source_json.labels.nodes;
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
    json|error issueState = source_json.state;
    if (issueState is json) {
        target_issue.state = issueState.toString();    
    }
    // target_issue.state = source_json.state.toString();
    json|error issueUpdatedAt = source_json.updatedAt;
    if (issueUpdatedAt is json) {
        target_issue.updatedAt = issueUpdatedAt.toString();    
    }
    // target_issue.updatedAt = source_json.updatedAt.toString();
    json|error issueUrl = source_json.url;
    if (issueUrl is json) {
        target_issue.url = issueUrl.toString();    
    }
    // target_issue.url = source_json.url.toString();

    json[] assigneeList = [];
    nodes_filtered = checkpanic source_json.assignees.nodes;
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
    json|error repositoryId = source_json.id;
    if (repositoryId is json) {
        target_repository.id = repositoryId.toString();
    } 
    // target_repository.id = source_json.id.toString();
    json|error repositoryName = source_json.name;
    if (repositoryName is json) {
        target_repository.name = repositoryName.toString();
    }
    // target_repository.name = source_json.name.toString();
    json|error repositoryCreatedAt = source_json.createdAt;
    if (repositoryCreatedAt is json) {
        target_repository.createdAt = repositoryCreatedAt.toString();
    }
    // target_repository.createdAt = source_json.createdAt.toString();
    json|error repositoryUpdatedAt = source_json.updatedAt;
    if (repositoryUpdatedAt is json) {
        target_repository.updatedAt = repositoryUpdatedAt.toString();
    }
    // target_repository.updatedAt = source_json.updatedAt.toString();
    json|error repositoryDescription = source_json.description;
    if (repositoryDescription is json) {
        target_repository.description = repositoryDescription.toString();
    }
    // target_repository.description = source_json.description.toString();
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
    json|error repositoryHomePageUrl = source_json.homepageUrl;
    if (repositoryHomePageUrl is json) {
        target_repository.homepageUrl = repositoryHomePageUrl.toString();
    }
    // target_repository.homepageUrl = source_json.homepageUrl.toString();
    json|error repositoryLockReason = source_json.lockReason;
    if (repositoryLockReason is json) {
        target_repository.lockReason = repositoryLockReason.toString();
    }
    // target_repository.lockReason = source_json.lockReason.toString();
    json|error repositoryMirrorUrl = source_json.mirrorUrl;
    if (repositoryMirrorUrl is json) {
        target_repository.mirrorUrl = repositoryMirrorUrl.toString();
    }
    // target_repository.mirrorUrl = source_json.mirrorUrl.toString();
    json|error repositoryUrl = source_json.url;
    if (repositoryUrl is json) {
        target_repository.url = repositoryUrl.toString();
    }
    // target_repository.url = source_json.url.toString();
    json|error repositorySshUrl = source_json.sshUrl;
    if (repositorySshUrl is json) {
        target_repository.sshUrl = repositorySshUrl.toString();
    }
    // target_repository.sshUrl = source_json.sshUrl.toString();
    var owner = source_json.owner;
    if (owner is json) {
        if (owner == null) {
            target_repository.owner = {};
        } else {
            var result = owner.cloneWithType(RepositoryOwner);
            if (result is RepositoryOwner) {
                target_repository.owner = result;
            }
        }
    }
    var primaryLanguage = source_json.primaryLanguage;
    if (primaryLanguage is json) {
        if (primaryLanguage == null) {
            target_repository.primaryLanguage = {};
        } else {
            // json nodes_filtered = checkpanic source_json.primaryLanguage;
            var result = primaryLanguage.cloneWithType(Language);
            if (result is Language) {
                target_repository.primaryLanguage = result;
            }
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
    // pullRequest["baseRefName"] = response["deletions"].ref.toString();
    pullRequest["author"] = {};

    return pullRequest;
}

isolated function jsonToPullRequestReview(map<json> response) returns PullRequestReview {
    PullRequestReview pullRequestReview = {};

    pullRequestReview["id"] = <int>response["id"];
    pullRequestReview["node_id"] = response["node_id"].toString();
    pullRequestReview["body"] = response["body"].toString();
    pullRequestReview["state"] = response["state"].toString();
    pullRequestReview["html_url"] = response["html_url"].toString();
    pullRequestReview["pull_request_url"] = response["pull_request_url"].toString();
    pullRequestReview["submitted_at"] = response["submitted_at"].toString();
    pullRequestReview["commit_id"] = response["commit_id"].toString();
    pullRequestReview["author_association"] = response["author_association"].toString();
    pullRequestReview["user"] = jsonToUser(<map<json>>response["user"]);

    return pullRequestReview;
}

isolated function jsonToUser(map<json> response) returns Creator {
    Creator user = {
        login: response["login"].toString(),
        id: <int>response["id"],
        node_id: response["node_id"].toString(),
        avatar_url: response["avatar_url"].toString(),
        url: response["url"].toString(),
        html_url: response["html_url"].toString(),
        followers_url: response["followers_url"].toString(),
        following_url: response["following_url"].toString(),
        gists_url: response["gists_url"].toString(),
        starred_url: response["starred_url"].toString(),
        subscriptions_url: response["subscriptions_url"].toString(),
        organizations_url: response["organizations_url"].toString(),
        repos_url: response["repos_url"].toString(),
        events_url: response["events_url"].toString(),
        received_events_url: response["received_events_url"].toString(),
        'type: response["type"].toString(),
        site_admin: <boolean>response["site_admin"]
    };

    return user;
}

isolated function jsonToIssueFound(map<json> response) returns IssueFound {
    return {
        id: response["id"].toString(),
        url: response["url"].toString(),
        repository_url: response["repository_url"].toString(),
        labels_url: response["labels_url"].toString(),
        comments_url: response["comments_url"].toString(),
        events_url: response["events_url"].toString(),
        html_url: response["html_url"].toString(),
        number: <int>response["number"],
        state: response["state"].toString(),
        title: response["title"].toString(),
        body: response["body"].toString()
    };
}