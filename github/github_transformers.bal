package github;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           GitHub Connector Transformers                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//********************************
// JSON --> ProjectList
//********************************
transformer <json source_json, ProjectList target_projectList> jsonToProjectList (string listOwner, string stringQuery) {
    target_projectList.listOwner = listOwner;
    target_projectList.projectListQuery = stringQuery;
    target_projectList.pageInfo =? <PageInfo>source_json.pageInfo;
    target_projectList.nodes = source_json.nodes.map(
                                                   function (json node) returns (Project) {
                                                       var project =? <Project> node;
                                                       return project;
                                                   });
}

//********************************
// JSON --> CardList
//********************************
transformer <json source_json, CardList target_cardList> jsonToCardList (string columnId, string listOwner, string stringQuery) {
    target_cardList.columnId = columnId;
    target_cardList.cardListQuery = stringQuery;
    target_cardList.listOwner = listOwner;
    target_cardList.pageInfo =? <PageInfo>source_json.pageInfo;
    target_cardList.nodes = source_json.nodes.map(
                                                function (json node) returns (Card) {
                                                    var card =? <Card> node;
                                                    return card;
                                                }); 
}

//********************************
// JSON --> Column
//********************************
transformer <json source_json, Column target_column> jsonToColumn (string listOwner, string stringQuery) {
    target_column.id = source_json.id.toString();
    target_column.name = source_json.name.toString();
    target_column.columnQuery = stringQuery;
    target_column.listOwner = listOwner;
    target_column.cards = <CardList, jsonToCardList(source_json.id.toString(), listOwner, stringQuery)>source_json.cards;
}

//********************************
// JSON --> ColumnList
//********************************
string tempQuery;   // TODO: Change this once issue https://github.com/ballerina-lang/ballerina/issues/5485 is fixed.
string tempOwner;
transformer <json source_json, ColumnList target_columnList> jsonToColumnList (string listOwner, string stringQuery) {
    tempQuery = stringQuery;
    tempOwner = listOwner;
    target_columnList.listOwner = listOwner;
    target_columnList.columnListQuery = stringQuery;
    target_columnList.pageInfo =? <PageInfo>source_json.pageInfo;
    target_columnList.nodes = source_json.nodes.map(
                                                   function (json node) returns (Column) {
                                                       var column = <Column, jsonToColumn(tempOwner, tempQuery)> node;
                                                       return column;
                                                   });
}


//********************************
// JSON --> RepositoryList
//********************************
transformer <json source_json, RepositoryList target_repositoryList> jsonToRepositoryList (string stringQuery) {
    target_repositoryList.repositoryListQuery = stringQuery;
    target_repositoryList.pageInfo =? <PageInfo>source_json.pageInfo;
    target_repositoryList.nodes = source_json.nodes.map(
                                                   function (json node) returns (Repository) {
                                                       var repository =? <Repository> node;
                                                       return repository;
                                                   });
}

//********************************
// JSON --> PullRequestList
//********************************
transformer <json source_json, PullRequestList target_pullRequestList> jsonToPullRequestList (string stringQuery) {
    target_pullRequestList.pullrequestListQuery = stringQuery;
    target_pullRequestList.pageInfo =? <PageInfo>source_json.pageInfo;
    target_pullRequestList.nodes = source_json.nodes.map(
                                                   function (json node) returns (PullRequest) {
                                                       var pullRequest =? <PullRequest> node;
                                                       return pullRequest;
                                                   });
}

//********************************
// JSON --> IssueList
//********************************
transformer <json source_json, IssueList target_issueList> jsonToIssueList (string stringQuery) {
    target_issueList.issueListQuery = stringQuery;
    target_issueList.pageInfo =? <PageInfo>source_json.pageInfo;
    target_issueList.nodes = source_json.nodes.map(
                                                   function (json node) returns (Issue) {
                                                       var issue =? <Issue> node;
                                                       return issue;
                                                   });
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Connector Transformers                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////