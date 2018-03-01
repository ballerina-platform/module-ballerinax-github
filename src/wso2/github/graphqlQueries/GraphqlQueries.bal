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

package src.wso2.github.graphqlQueries;

public const string GET_REPOSITORY_PROJECTS = "query ($owner: String!, $repository: String!, $states:[ProjectState!]){
	repository(owner:$owner, name:$repository){
    projects(first:100, states:$states){
      pageInfo {
        hasNextPage,
        startCursor,
        endCursor
      },
      nodes {
        id,
        databaseId,
        name,
        body,
        number,
        createdAt,
        updatedAt,
        closed,
        closedAt,
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

}";

public const string GET_REPOSITORY_PROJECTS_NEXT_PAGE = "query ($owner: String!, $repository: String!, $states:[ProjectState!], $endCursor: String!){
	repository(owner:$owner, name:$repository){
    projects(first:100, states:$states, after:$endCursor){
      pageInfo {
        hasNextPage,
        startCursor,
        endCursor
      },
      nodes {
        id,
        databaseId,
        name,
        body,
        number,
        createdAt,
        updatedAt,
        closed,
        closedAt,
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

}";

public const string GET_ORGANIZATION_PROJECTS = "query ($organization: String!, $states:[ProjectState!]){
	organization(login:$organization) {
    projects(first:100, states:$states){
      pageInfo {
        hasNextPage,
        startCursor,
        endCursor
      },
      nodes {
        id,
        databaseId,
        name,
        body,
        number,
        createdAt,
        updatedAt,
        closed,
        closedAt,
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
}";

public const string GET_ORGANIZATION_PROJECTS_NEXT_PAGE = "query ($organization: String!, $states:[ProjectState!], $endCursor:String!){
	organization(login:$organization) {
    projects(first:100, states:$states, after:$endCursor){
      pageInfo {
        hasNextPage,
        startCursor,
        endCursor
      },
      nodes {
        id,
        databaseId,
        name,
        body,
        number,
        createdAt,
        updatedAt,
        closed,
        closedAt,
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
}";

public const string GET_REPOSITORY_PROJECT = "query ($owner: String!, $repository: String!, $number: Int!){
	repository(owner:$owner, name:$repository) {
    project(number:$number) {
        id,
        databaseId,
        name,
        body,
        number,
        createdAt,
        updatedAt,
        closed,
        closedAt,
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
}";

public const string GET_PROJECT_CARDS = "query ($organization: String!, $number: Int!){
  organization (login: $organization) {

    project (number : $number) {
      name,

      columns (first:100){
        totalCount,

        edges {
          node {
            id,
            name,
            cards (first:100){
              edges {
                node {
                  id,
                  note,
                  creator {
                    url,
                    login,
                    resourcePath,
                    avatarUrl
                  },
                  state,
                  createdAt,
                  updatedAt,
                  url,
                  column {
                    id,
                    name,
                  }
                  content {
                    ... on Issue {
                        title
                    }
                    ... on PullRequest {
                      title
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
 }";

public const string GET_REPOSITORY = "query ($owner: String!, $name: String!){
	repository (owner:$owner, name:$name) {
    id,
    name,
    owner {
      id,
      login,
      url,
      avatarUrl
    },
    nameWithOwner,
    createdAt,
    updatedAt,
    description,
    homepageUrl,
    primaryLanguage {
      id,
      name,
      color
    },
    languages (first:100){
      nodes {
        id,
        name,
        color
      }
    },
    url
  }
}";


