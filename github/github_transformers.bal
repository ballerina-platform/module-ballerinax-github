package github;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           GitHub Connector Transformers                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//********************************
// JSON --> ProjectList
//********************************
function jsonToProjectList (json source_json, string listOwner, string stringQuery) returns (ProjectList) {
    ProjectList target_projectList = {};
    target_projectList.listOwner = listOwner;
    target_projectList.projectListQuery = stringQuery;
    target_projectList.pageInfo =? <PageInfo>source_json.pageInfo;
    json[] nodes =? <json[]> source_json.nodes;
    foreach i, node in nodes {
        var project =? <Project> node;
        target_projectList.nodes[i] = project;
    }

    return target_projectList;
}

//********************************
// JSON --> CardList
//********************************
function jsonToCardList (json source_json, string columnId, string listOwner, string stringQuery) returns (CardList) {
    CardList target_cardList = {};
    target_cardList.columnId = columnId;
    target_cardList.cardListQuery = stringQuery;
    target_cardList.listOwner = listOwner;
    target_cardList.pageInfo =? <PageInfo>source_json.pageInfo;
    json[] nodes =? <json[]> source_json.nodes;
    foreach i, node in nodes {
        var card =? <Card> node;
        target_cardList.nodes[i] = card;
    }

    return target_cardList;
}
//********************************
// JSON --> Column
//********************************
function jsonToColumn (json source_json, string listOwner, string stringQuery) returns (Column) {
    Column target_column = {};
    target_column.id = source_json.id.toString();
    target_column.name = source_json.name.toString();
    target_column.columnQuery = stringQuery;
    target_column.listOwner = listOwner;
    target_column.cards = jsonToCardList(source_json.cards,source_json.id.toString(), listOwner, stringQuery);
    return target_column;
}
//********************************
// JSON --> ColumnList
//********************************
function jsonToColumnList (json source_json, string listOwner, string stringQuery) returns (ColumnList) {
    ColumnList target_columnList = {};
    target_columnList.listOwner = listOwner;
    target_columnList.columnListQuery = stringQuery;
    target_columnList.pageInfo =? <PageInfo>source_json.pageInfo;
    json[] nodes =? <json[]>source_json.nodes;
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
    RepositoryList target_repositoryList = {};
    target_repositoryList.repositoryListQuery = stringQuery;
    target_repositoryList.pageInfo =? <PageInfo>source_json.pageInfo;
    var nodes =? <json[]> source_json.nodes;
    foreach i, node in nodes {
        var repository =? <Repository> node;
        target_repositoryList.nodes[i] = repository;
    }

    return target_repositoryList;
}
//********************************
// JSON --> PullRequestList
//********************************
function jsonToPullRequestList (json source_json, string stringQuery) returns (PullRequestList) {
    PullRequestList target_pullRequestList = {};
    target_pullRequestList.pullRequestListQuery = stringQuery;
    target_pullRequestList.pageInfo =? <PageInfo>source_json.pageInfo;
    var nodes =? <json[]> source_json.nodes;
    foreach i, node in nodes {
        var pullRequest =? <PullRequest>node;
        target_pullRequestList.nodes[i] = pullRequest;
    }

    return target_pullRequestList;
}
//********************************
// JSON --> IssueList
//********************************
function jsonToIssueList (json source_json, string stringQuery) returns (IssueList) {
    IssueList target_issueList = {};
    target_issueList.issueListQuery = stringQuery;
    target_issueList.pageInfo =? <PageInfo>source_json.pageInfo;
    var nodes =? <json[]>source_json.nodes;
    foreach i, node in nodes {
        var issue =? <Issue> node;
        target_issueList.nodes[i] = issue;
    }

    return target_issueList;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Connector Transformers                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////