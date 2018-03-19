package src.github;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           GitHub Connector Transformers                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//********************************
// JSON --> ProjectList
//********************************
transformer <json json_source, ProjectList projectList_target> jsonToProjectList (string query, string listOwner) {
    projectList_target.listOwner = listOwner;
    projectList_target.projectListQuery = query;
    projectList_target.pageInfo, _ = <PageInfo>json_source.pageInfo;
    projectList_target.nodes = json_source.nodes.map(
                                                   function (json node) (Project) {
                                                       var project, _ = <Project> node;
                                                       return project;
                                                   });
}
