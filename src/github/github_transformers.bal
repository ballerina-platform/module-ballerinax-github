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
// JSON --> ColumnList
//********************************
transformer <json source_json, ColumnList target_columnList> jsonToColumnList (string listOwner, string stringQuery) {
    target_columnList.listOwner = listOwner;
    target_columnList.columnListQuery = stringQuery;
    target_columnList.pageInfo, _ = <PageInfo>source_json.pageInfo;
    target_columnList.nodes = source_json.nodes.map(
                                                   function (json node) (Column) {
                                                       var column, _ = <Column> node;
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