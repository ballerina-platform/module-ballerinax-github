package src.github;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           GitHub Connector Transformers                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//********************************
// JSON --> ProjectList
//********************************
transformer <json source_json, ProjectList target_projectList> jsonToProjectList (string listOwner, string stringQuery) {
    target_projectList.listOwner = listOwner;
    target_projectList.projectListQuery = stringQuery;
    target_projectList.pageInfo, _ = <PageInfo>source_json.pageInfo;
    target_projectList.nodes = source_json.nodes.map(
                                                   function (json node) (Project) {
                                                       var project, _ = <Project> node;
                                                       return project;
                                                   });
}

//********************************
// JSON --> CardList
//********************************
transformer <json source_json, CardList target_cardList> jsonToCardList (string columnId, string stringQuery) {
    target_cardList.columnId = columnId;
    target_cardList.cardListQuery = stringQuery;
    target_cardList.pageInfo, _ = <PageInfo>source_json.pageInfo;
    target_cardList.nodes = source_json.nodes.map(
                                                function (json node) (Card) {
                                                    var card, _ = <Card> node;
                                                    return card;
                                                }); 
}

//********************************
// JSON --> Column
//********************************
transformer <json source_json, Column target_column> jsonToColumn (string stringQuery) {
    target_column.id = source_json.id.toString();
    target_column.name = source_json.name.toString();
    target_column.columnQuery = stringQuery;
    target_column.cards = <CardList, jsonToCardList(source_json.id.toString(),"")>source_json.cards;
}

//********************************
// JSON --> ColumnList
//********************************
transformer <json source_json, ColumnList target_columnList> jsonToColumnList (string listOwner, string stringQuery) {
    target_columnList.listOwner = listOwner;
    target_columnList.columnListQuery = stringQuery;
    target_columnList.pageInfo, _ = <PageInfo>source_json.pageInfo;
    target_columnList.nodes = source_json.nodes.map(
                                                   function (json node) (Column) {
                                                       var column = <Column, jsonToColumn(stringQuery)> node;
                                                       return column;
                                                   });
}


//********************************
// JSON --> RepositoryList
//********************************
transformer <json source_json, RepositoryList target_repositoryList> jsonToRepositoryList (string stringQuery) {
    target_repositoryList.repositoryListQuery = stringQuery;
    target_repositoryList.pageInfo, _ = <PageInfo>source_json.pageInfo;
    target_repositoryList.nodes = source_json.nodes.map(
                                                   function (json node) (Repository) {
                                                       var repository, _ = <Repository> node;
                                                       return repository;
                                                   });
}

//********************************
// JSON --> PullRequestList
//********************************
transformer <json source_json, PullRequestList target_pullRequestList> jsonToPullRequestList (string stringQuery) {
    target_pullRequestList.pullrequestListQuery = stringQuery;
    target_pullRequestList.pageInfo, _ = <PageInfo>source_json.pageInfo;
    target_pullRequestList.nodes = source_json.nodes.map(
                                                   function (json node) (PullRequest) {
                                                       var pullRequest, _ = <PullRequest> node;
                                                       return pullRequest;
                                                   });
}

//********************************
// JSON --> IssueList
//********************************
transformer <json source_json, IssueList target_issueList> jsonToIssueList (string stringQuery) {
    target_issueList.issueListQuery = stringQuery;
    target_issueList.pageInfo, _ = <PageInfo>source_json.pageInfo;
    target_issueList.nodes = source_json.nodes.map(
                                                   function (json node) (Issue) {
                                                       var issue, _ = <Issue> node;
                                                       return issue;
                                                   });
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           End of Connector Transformers                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////