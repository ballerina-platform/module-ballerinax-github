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

package src.github;

//TODO Implement a QueryBuilder to programatically develop the queries
public const string GET_REPOSITORY_PROJECTS = "query ($owner: String!, $repository: String!, $states:[ProjectState!]){
	repository(owner:$owner, name:$repository){
    projects(first:1, states:$states){
      pageInfo {
        hasNextPage,
        hasPreviousPage,
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
          viewerCanCreateProjects,
          __typename
        }
      }
    }
  }

  }";

public const string GET_REPOSITORY_PROJECTS_NEXT_PAGE = "query ($owner: String!, $repository: String!, $states:[ProjectState!], $endCursorProjects: String!){
	repository(owner:$owner, name:$repository){
    projects(first:1, states:$states, after:$endCursorProjects){
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
          viewerCanCreateProjects,
          __typename
        }
      }
    }
  }

  }";

public const string GET_ORGANIZATION_PROJECTS = "query ($organization: String!, $states:[ProjectState!]){
	organization(login:$organization) {
    projects(first:1, states:$states){
      pageInfo {
        hasNextPage,
        hasPreviousPage,
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
          viewerCanCreateProjects,
          __typename
        }
      }
    }
  }
  }";

public const string GET_ORGANIZATION_PROJECTS_NEXT_PAGE = "query ($organization: String!, $states:[ProjectState!], $endCursorProjects:String!){
	organization(login:$organization) {
    projects(first:1, states:$states, after:$endCursorProjects){
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
          viewerCanCreateProjects,
          __typename
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
          viewerCanCreateProjects,
          __typename
        }
    }
  }
  }";

public const string GET_ORGANIZATION_PROJECT = "query ($organization: String!, $number: Int!){
	organization(login:$organization) {
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
          viewerCanCreateProjects,
          __typename
        }
    }
  }
  }";

public const string GET_REPOSITORY = "query ($owner: String!, $name: String!){
	repository(owner:$owner, name:$name){
    id,
    name,
    createdAt,
    updatedAt,
    description,
    forkCount,
    hasIssuesEnabled,
    hasWikiEnabled,
    homepageUrl,
    isArchived,
    isFork,
    isLocked,
    isMirror,
    isPrivate,
    license,
    lockReason,
    mirrorUrl,
    url,
    sshUrl,
    owner {
      id,
      login,
      url,
      avatarUrl,
      resourcePath
    },
    primaryLanguage {
      id,
      name,
      color
    }
  }
  }";

public const string GET_PULL_REQUESTS = "query ($owner: String!, $name: String!, $states:[PullRequestState!]){
	repository(owner:$owner, name:$name){
    pullRequests(first:1, states:$states) {
      pageInfo{
        hasNextPage,
        hasPreviousPage,
        startCursor,
        endCursor
      },
      nodes {
        id,
        title,
        createdAt,
        updatedAt,
        closed,
        closedAt,
        mergedAt,
        state,
        number,
        url,
        body,
        changedFiles,
        additions,
        deletions,
        resourcePath,
        revertResourcePath,
        revertUrl,
        author {
          login,
          resourcePath,
          url,
          avatarUrl
        },
        headRefName,
        baseRefName
      }
    }
  }
  }";

public const string GET_PULL_REQUESTS_NEXT_PAGE = "query ($owner: String!, $name: String!, $states:[PullRequestState!], $endCursorPullRequests: String!){
	repository(owner:$owner, name:$name){
    pullRequests(first:1, states:$states, after: $endCursorPullRequests) {
      pageInfo{
        hasNextPage,
        hasPreviousPage,
        startCursor,
        endCursor
      },
      nodes {
        id,
        title,
        createdAt,
        updatedAt,
        closed,
        closedAt,
        mergedAt,
        state,
        number,
        url,
        body,
        changedFiles,
        additions,
        deletions,
        resourcePath,
        revertResourcePath,
        revertUrl,
        author {
          login,
          resourcePath,
          url,
          avatarUrl
        },
        headRefName,
        baseRefName
      }
    }
  }
  }";

public const string GET_ORGANIZATION = "query ($organization: String!) {
  organization(login:$organization) {
    avatarUrl,
    description,
    email,
    id,
    location,
    login,
    name,
    projectsResourcePath,
    projectsUrl,
    resourcePath,
    url,
    websiteUrl
  }
  }";
public const string GET_REPOSITORY_PROJECT_COLUMNS = "query ($owner: String!,$name:String!, $number: Int!){
  repository (owner:$owner, name:$name) {
    project (number : $number){
      columns (first:1){
        pageInfo {
          hasNextPage,
          hasPreviousPage,
          startCursor,
          endCursor
        }
        nodes {
          id,
          name,
          cards (first:1){
            pageInfo {
              hasNextPage,
              hasPreviousPage,
              startCursor,
              endCursor
            },
            nodes {
              id,
              note,
              creator {
                login,
                resourcePath,
                url,
                avatarUrl
              },
              state,
              createdAt,
              updatedAt,
              url,
              column {
                id,
                name,
                url
              },
              content {
                ... on Issue { title, url, issueState:state}
                ... on PullRequest { title, url, prState:state}
              }
            }
          }
        }
      }
    }
  }
  }";

public const string GET_REPOSITORY_PROJECT_COLUMNS_NEXT_PAGE = "query ($owner: String!,$name:String!, $number: Int!, $endCursorColumns: String!){
  repository (owner:$owner, name:$name) {
    project (number : $number){
      columns (first:1){
        pageInfo {
          hasNextPage,
          hasPreviousPage,
          startCursor,
          endCursor
        }
        nodes {
          id,
          name,
          cards (first:1){
            pageInfo {
              hasNextPage,
              hasPreviousPage,
              startCursor,
              endCursor
            },
            nodes {
              id,
              note,
              creator {
                login,
                resourcePath,
                url,
                avatarUrl
              },
              state,
              createdAt,
              updatedAt,
              url,
              column {
                id,
                name,
                url
              },
              content {
                ... on Issue { title, url, issueState:state}
                ... on PullRequest { title, url, prState:state}
              }
            }
          }
        }
      }
    }
  }
  }";

public const string GET_REPOSITORY_PROJECT_CARDS_NEXT_PAGE = "query ($owner: String!,$name:String!, $number: Int!, $endCursorCards: String!){
  repository (owner:$owner, name:$name) {
    project (number : $number){
      columns (first:1){
        pageInfo {
          hasNextPage,
          hasPreviousPage,
          startCursor,
          endCursor
        }
        nodes {
          id,
          name,
          cards (first:1, after: $endCursorCards){
            pageInfo {
              hasNextPage,
              hasPreviousPage,
              startCursor,
              endCursor
            },
            nodes {
              id,
              note,
              creator {
                login,
                resourcePath,
                url,
                avatarUrl
              },
              state,
              createdAt,
              updatedAt,
              url,
              column {
                id,
                name,
                url
              },
              content {
                ... on Issue { title, url, issueState:state}
                ... on PullRequest { title, url, prState:state}
              }
            }
          }
        }
      }
    }
  }
 }";

public const string GET_ORGANIZATION_PROJECT_COLUMNS = "query ($organization: String!, $number: Int!){
  organization (login:$organization) {
    project (number : $number) {
      columns (first:1) {
        pageInfo {
          hasNextPage,
          hasPreviousPage,
          startCursor,
          endCursor
        }
        nodes {
          id,
          name,
          cards (first:1){
            pageInfo {
              hasNextPage,
              hasPreviousPage,
              startCursor,
              endCursor
            },
            nodes {
              id,
              note,
              creator {
                login,
                resourcePath,
                url,
                avatarUrl
              },
              state,
              createdAt,
              updatedAt,
              url,
              column {
                id,
                name,
                url
              },
              content {
                ... on Issue { title, url, issueState:state}
                ... on PullRequest { title, url, prState:state}
              }
            }
          }
        }
      }
    }
  }
 }";

public const string GET_ORGANIZATION_PROJECT_COLUMNS_NEXT_PAGE = "query ($organization: String!, $number: Int!, $endCursorColumns: String!){
  organization (login:$organization) {
    project (number : $number) {
      columns (first:1, after: $endCursorColumns) {
        pageInfo {
          hasNextPage,
          hasPreviousPage,
          startCursor,
          endCursor
        }
        nodes {
          id,
          name,
          cards (first:1){
            pageInfo {
              hasNextPage,
              hasPreviousPage,
              startCursor,
              endCursor
            },
            nodes {
              id,
              note,
              creator {
                login,
                resourcePath,
                url,
                avatarUrl
              },
              state,
              createdAt,
              updatedAt,
              url,
              column {
                id,
                name,
                url
              },
              content {
                ... on Issue { title, url, issueState:state}
                ... on PullRequest { title, url, prState:state}
              }
            }
          }
        }
      }
    }
  }
 }";

public const string GET_ORGANIZATION_PROJECT_CARDS_NEXT_PAGE = "query ($organization: String!, $number: Int!, $endCursorCards: String!){
  organization (login:$organization) {
    project (number : $number) {
      columns (first:1) {
        pageInfo {
          hasNextPage,
          hasPreviousPage,
          startCursor,
          endCursor
        }
        nodes {
          id,
          name,
          cards (first:1, after: $endCursorCards){
            pageInfo {
              hasNextPage,
              hasPreviousPage,
              startCursor,
              endCursor
            },
            nodes {
              id,
              note,
              creator {
                login,
                resourcePath,
                url,
                avatarUrl
              },
              state,
              createdAt,
              updatedAt,
              url,
              column {
                id,
                name,
                url
              },
              content {
                ... on Issue { title, url, issueState:state}
                ... on PullRequest { title, url, prState:state}
              }
            }
          }
        }
      }
    }
  }
 }";

public const string GET_ORGANIZATION_REPOSITORIES = "query ($organization: String!) {
  organization (login:$organization) {
    repositories (first: 1) {
      pageInfo {
        hasNextPage,
        hasPreviousPage,
        startCursor,
        endCursor
      }
      nodes {
    id,
    name,
    createdAt,
    updatedAt,
    description,
    forkCount,
    hasIssuesEnabled,
    hasWikiEnabled,
    homepageUrl,
    isArchived,
    isFork,
    isLocked,
    isMirror,
    isPrivate,
    license,
    lockReason,
    mirrorUrl,
    url,
    sshUrl,
    owner {
      id,
      login,
      url,
      avatarUrl,
      resourcePath
    },
    primaryLanguage {
      id,
      name,
      color
    }
      }
    }
  }
  }";

public const string GET_ORGANIZATION_REPOSITORIES_NEXT_PAGE = "query ($organization: String!, $endCursorRepos: String!) {
  organization (login:$organization) {
    repositories (first: 1, after: $endCursorRepos) {
      pageInfo {
        hasNextPage,
        hasPreviousPage,
        startCursor,
        endCursor
      }
      nodes {
    id,
    name,
    createdAt,
    updatedAt,
    description,
    forkCount,
    hasIssuesEnabled,
    hasWikiEnabled,
    homepageUrl,
    isArchived,
    isFork,
    isLocked,
    isMirror,
    isPrivate,
    license,
    lockReason,
    mirrorUrl,
    url,
    sshUrl,
    owner {
      id,
      login,
      url,
      avatarUrl,
      resourcePath
    },
    primaryLanguage {
      id,
      name,
      color
    }
      }
    }
  }
  }";

public const string GET_REPOSITORY_ISSUES = "query ($owner:String!, $name:String!, $states:[IssueState!]) {
  repository(owner:$owner, name: $name) {
    issues (first: 1, states:$states) {
      pageInfo {
        hasNextPage,
        hasPreviousPage,
        startCursor,
        endCursor
      }
      nodes {
        id,
        author {
          login,
          resourcePath,
          url,
          avatarUrl
        },
        bodyText,
        closed,
        closedAt,
        createdAt,
        editor {
          login,
          resourcePath,
          url,
          avatarUrl,
        },
        labels (first: 1){
          nodes {
            id,
            name,
            description,
            color
          }
        },
        number,
        state,
        title,
        updatedAt,
        url
      }
    }
  }
  }";

public const string GET_REPOSITORY_ISSUES_NEXT_PAGE = "query ($owner:String!, $name:String!, $states:[IssueState!], $endCursorIssues: String!) {
  repository(owner:$owner, name: $name) {
    issues (first: 1, states:$states, after: $endCursorIssues) {
      pageInfo {
        hasNextPage,
        hasPreviousPage,
        startCursor,
        endCursor
      }
      nodes {
        id,
        author {
          login,
          resourcePath,
          url,
          avatarUrl
        },
        bodyText,
        closed,
        closedAt,
        createdAt,
        editor {
          login,
          resourcePath,
          url,
          avatarUrl,
        },
        labels (first: 1){
          nodes {
            id,
            name,
            description,
            color
          }
        },
        number,
        state,
        title,
        updatedAt,
        url
      }
    }
  }
  }";