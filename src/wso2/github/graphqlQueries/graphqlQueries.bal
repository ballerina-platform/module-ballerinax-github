package src.wso2.github.graphqlQueries;

public const string GET_REPOSITORY_PROJECTS = "query ($owner: String!, $repository: String!, $states:[ProjectState!]){

 repositoryOwner(login: $owner) {
   id,
   url,
   login,
   repository(name: $repository){
     name,
    url,

	 projects(first: 100, states: $states) {
    edges {
      node {
        id,
        databaseId,
        name,
        body,
        number,
        createdAt,
        closed,
        closedAt,
        updatedAt,
        resourcePath,
        state,
        url,

        viewerCanUpdate,
        creator {
          login,
          resourcePath,
          url,
          avatarUrl
        }
        owner {
          id,
          projectsResourcePath,
          projectsUrl,
          viewerCanCreateProjects
        }

      }
    }
  }
   }
 }
}";

public const string GET_ORGANIZATION_PROJECTS = "query ($organization: String!, $states:[ProjectState!]){
 organization (login: $organization){
  id,
  description,
  email,
  	 projects(first: 100, states: $states) {
    edges {
      node {
        id,
        databaseId,
        name,
        body,
        number,
        createdAt,
        closed,
        closedAt,
        updatedAt,
        resourcePath,
        state,
        url,

        viewerCanUpdate,
        creator {
          login,
          resourcePath,
          url,
          avatarUrl
        }
        owner {
          id,
          projectsResourcePath,
          projectsUrl,
          viewerCanCreateProjects
        }

      }
    }
  }
}
}";

public const string GET_PROJECT = "query ($owner: String!, $repository: String!, $number: Int!){

 repositoryOwner(login: $owner) {
   id,
   url,
   login,
   repository(name: $repository){
     name,
    url,
    project (number : $number) {
      id,
      name,
      state,
      body,
      closed,
      closedAt,
      createdAt,
      creator {
        url,
        login,
        resourcePath,
        avatarUrl
      },
      owner {
        id,
        projectsResourcePath,
        projectsUrl,
        viewerCanCreateProjects
      }
			databaseId,
      number,
      updatedAt,
      resourcePath,
      url,
      viewerCanUpdate,

    }

  }
   }
 }";

