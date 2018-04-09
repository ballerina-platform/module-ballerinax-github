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

@final string PAGE_INFO = "pageInfo {
        hasNextPage,
        hasPreviousPage,
        startCursor,
        endCursor
    }";

@final string CREATOR = "creator {
          login,
          resourcePath,
          url,
          avatarUrl
      }";

@final string PROJECT_OWNER = "owner {
          id,
          projectsResourcePath,
          projectsUrl,
          viewerCanCreateProjects,
          __typename
      }";

@final string REPOSITORY_OWNER = "owner {
          id,
          login,
          url,
          avatarUrl,
          resourcePath
      }";

@final string PROJECTS_NODES = "nodes {
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
        " + CREATOR + ",
        " + PROJECT_OWNER + "
    }";

@final string PRIMARY_LANGUAGE = "primaryLanguage {
          id,
          name,
          color
      }";

@final string AUTHOR = "author {
          login,
          resourcePath,
          url,
          avatarUrl
      }";

@final string COLUMN = "column {
        id,
        name,
        url
    }";

@final string EDITOR = "editor {
          login,
          resourcePath,
          url,
          avatarUrl,
      }";

@final string LABELS = "labels (first: 100){
          nodes {
            id,
            name,
            description,
            color
          }
      }";

@final string CONTENT = "content {
                ... on Issue { title, url, issueState:state}
                ... on PullRequest { title, url, prState:state}
            }";

@final public string GET_REPOSITORY_PROJECTS =
"query ($owner: String!, $repository: String!, $states:[ProjectState!], $recordCount: Int!){
	repository(owner:$owner, name:$repository){
    projects(first:$recordCount, states:$states){
      " + PAGE_INFO + ",
      " + PROJECTS_NODES + "
    }
  }
}";

@final public string GET_REPOSITORY_PROJECTS_NEXT_PAGE =
"query ($owner: String!, $repository: String!, $states:[ProjectState!], $endCursorProjects: String!, $recordCount: Int!){
	repository(owner:$owner, name:$repository){
    projects(first:$recordCount, states:$states, after:$endCursorProjects){
      " + PAGE_INFO + ",
      " + PROJECTS_NODES + "
    }
  }
}";

@final public string GET_ORGANIZATION_PROJECTS =
"query ($organization: String!, $states:[ProjectState!], $recordCount: Int!){
	organization(login:$organization) {
    projects(first:$recordCount, states:$states){
      " + PAGE_INFO + ",
      " + PROJECTS_NODES + "
    }
  }
}";

@final public string GET_ORGANIZATION_PROJECTS_NEXT_PAGE =
"query ($organization: String!, $states:[ProjectState!], $endCursorProjects:String!, $recordCount: Int!){
	organization(login:$organization) {
    projects(first:$recordCount, states:$states, after:$endCursorProjects){
      " + PAGE_INFO + ",
      " + PROJECTS_NODES + "
    }
  }
}";

@final public string GET_REPOSITORY_PROJECT =
"query ($owner: String!, $repository: String!, $number: Int!){
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
        " + CREATOR + ",
        " + PROJECT_OWNER + "
    }
  }
}";

@final public string GET_ORGANIZATION_PROJECT =
"query ($organization: String!, $number: Int!){
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
        " + CREATOR + ",
        " + PROJECT_OWNER + "
    }
  }
}";

@final public string GET_REPOSITORY =
"query ($owner: String!, $name: String!){
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
    " + REPOSITORY_OWNER + ",
    " + PRIMARY_LANGUAGE + "
  }
}";

@final public string GET_PULL_REQUESTS =
"query ($owner: String!, $name: String!, $states:[PullRequestState!], $recordCount: Int!){
	repository(owner:$owner, name:$name){
    pullRequests(first:$recordCount, states:$states) {
      " + PAGE_INFO + ",
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
        headRefName,
        baseRefName,
        " + AUTHOR + "
      }
    }
  }
}";

@final public string GET_PULL_REQUESTS_NEXT_PAGE =
"query ($owner: String!, $name: String!, $states:[PullRequestState!], $endCursorPullRequests: String!,
                                                                                                $recordCount: Int!){
	repository(owner:$owner, name:$name){
    pullRequests(first:$recordCount, states:$states, after: $endCursorPullRequests) {
      " + PAGE_INFO + ",
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
        headRefName,
        baseRefName,
        " + AUTHOR + "
      }
    }
  }
}";

@final public string GET_ORGANIZATION =
"query ($organization: String!) {
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

@final public string GET_REPOSITORY_PROJECT_COLUMNS =
"query ($owner: String!,$name:String!, $number: Int!, $recordCount: Int!){
  repository (owner:$owner, name:$name) {
    project (number : $number){
      columns (first:$recordCount){
        " + PAGE_INFO + ",
        nodes {
          id,
          name,
          cards (first:$recordCount){
            " + PAGE_INFO + ",
            nodes {
              id,
              note,
              " + CREATOR + ",
              state,
              createdAt,
              updatedAt,
              url,
              " + COLUMN + ",
              " + CONTENT + "
            }
          }
        }
      }
    }
  }
}";

@final public string GET_REPOSITORY_PROJECT_COLUMNS_NEXT_PAGE =
"query ($owner: String!,$name:String!, $number: Int!, $endCursorColumns: String!, $recordCount: Int!){
  repository (owner:$owner, name:$name) {
    project (number : $number){
      columns (first:$recordCount){
        " + PAGE_INFO + ",
        nodes {
          id,
          name,
          cards (first:$recordCount){
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
              " + COLUMN + ",
              " + CONTENT + "
            }
          }
        }
      }
    }
  }
}";

@final public string GET_REPOSITORY_PROJECT_CARDS_NEXT_PAGE =
"query ($owner: String!,$name:String!, $number: Int!, $endCursorCards: String!, $recordCount: Int!){
  repository (owner:$owner, name:$name) {
    project (number : $number){
      columns (first:$recordCount){
        " + PAGE_INFO + ",
        nodes {
          id,
          name,
          cards (first:$recordCount, after: $endCursorCards){
            " + PAGE_INFO + ",
            nodes {
              id,
              note,
              " + CREATOR + ",
              state,
              createdAt,
              updatedAt,
              url,
              " + COLUMN + ",
              " + CONTENT + "
            }
          }
        }
      }
    }
  }
}";

@final public string GET_ORGANIZATION_PROJECT_COLUMNS =
"query ($organization: String!, $number: Int!, $recordCount: Int!){
  organization (login:$organization) {
    project (number : $number) {
      columns (first:$recordCount) {
        " + PAGE_INFO + ",
        nodes {
          id,
          name,
          cards (first:$recordCount){
            " + PAGE_INFO + ",
            nodes {
              id,
              note,
              " + CREATOR + ",
              state,
              createdAt,
              updatedAt,
              url,
              " + COLUMN + ",
              " + CONTENT + "
            }
          }
        }
      }
    }
  }
}";

@final public string GET_ORGANIZATION_PROJECT_COLUMNS_NEXT_PAGE =
"query ($organization: String!, $number: Int!, $endCursorColumns: String!, $recordCount: Int!){
  organization (login:$organization) {
    project (number : $number) {
      columns (first:$recordCount, after: $endCursorColumns) {
        " + PAGE_INFO + ",
        nodes {
          id,
          name,
          cards (first:$recordCount){
            " + PAGE_INFO + ",
            nodes {
              id,
              note,
              " + CREATOR + ",
              state,
              createdAt,
              updatedAt,
              url,
              " + COLUMN + ",
              " + CONTENT + "
            }
          }
        }
      }
    }
  }
}";

@final public string GET_ORGANIZATION_PROJECT_CARDS_NEXT_PAGE =
"query ($organization: String!, $number: Int!, $endCursorCards: String!, $recordCount: Int!){
  organization (login:$organization) {
    project (number : $number) {
      columns (first:$recordCount) {
        " + PAGE_INFO + ",
        nodes {
          id,
          name,
          cards (first:$recordCount, after: $endCursorCards){
            " + PAGE_INFO + ",
            nodes {
              id,
              note,
              " + CREATOR + ",
              state,
              createdAt,
              updatedAt,
              url,
              " + COLUMN + ",
              " + CONTENT + "
            }
          }
        }
      }
    }
  }
}";

@final public string GET_ORGANIZATION_REPOSITORIES =
"query ($organization: String!, $recordCount: Int!) {
  organization (login:$organization) {
    repositories (first: $recordCount) {
      " + PAGE_INFO + ",
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
        " + REPOSITORY_OWNER + ",
        " + PRIMARY_LANGUAGE + "
      }
    }
  }
}";

@final public string GET_ORGANIZATION_REPOSITORIES_NEXT_PAGE =
"query ($organization: String!, $endCursorRepos: String!, $recordCount: Int!) {
  organization (login:$organization) {
    repositories (first: $recordCount, after: $endCursorRepos) {
      " + PAGE_INFO + ",
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
        " + REPOSITORY_OWNER + ",
        " + PRIMARY_LANGUAGE + "
      }
    }
  }
}";

@final public string GET_REPOSITORY_ISSUES =
"query ($owner:String!, $name:String!, $states:[IssueState!], $recordCount: Int!) {
  repository(owner:$owner, name: $name) {
    issues (first: $recordCount, states:$states) {
      " + PAGE_INFO + ",
      nodes {
        id,
        " + AUTHOR + ",
        bodyText,
        closed,
        closedAt,
        createdAt,
        " + EDITOR + ",
        " + LABELS + ",
        number,
        state,
        title,
        updatedAt,
        url
      }
    }
  }
}";

@final public string GET_REPOSITORY_ISSUES_NEXT_PAGE =
"query ($owner:String!, $name:String!, $states:[IssueState!], $endCursorIssues: String!, $recordCount: Int!) {
  repository(owner:$owner, name: $name) {
    issues (first: $recordCount, states:$states, after: $endCursorIssues) {
      " + PAGE_INFO + ",
      nodes {
        id,
        " + AUTHOR + ",
        bodyText,
        closed,
        closedAt,
        createdAt,
        " + EDITOR + ",
        " + LABELS + ",
        number,
        state,
        title,
        updatedAt,
        url
      }
    }
  }
}";


// String query templates

@final string TEMPLATE_GET_REPOSITORY = "{\"variables\":{\"owner\":\"%s\",\"name\":\"%s\"},\"query\":\""
                                       + GET_REPOSITORY + "\"}";

@final string TEMPLATE_GET_ORGANIZATION = "{\"variables\":{\"organization\":\"%s\"},\"query\":\""
                                         + GET_ORGANIZATION + "\"}";

@final string TEMPLATE_GET_ORGANIZATION_PROJECT_COLUMNS = "{\"variables\":{\"organization\":\"%s\",\"number\":%d,
                                        \"recordCount\":%d},\"query\":\"" + GET_ORGANIZATION_PROJECT_COLUMNS + "\"}";

@final string TEMPLATE_GET_REPOSITORY_PROJECT_COLUMNS = "{\"variables\":{\"owner\":\"%s\",\"name\":\"%s\",
                            \"number\":%d,\"recordCount\":%d},\"query\":\"" + GET_REPOSITORY_PROJECT_COLUMNS + "\"}";

@final string TEMPLATE_GET_ORGANIZATION_PROJECT = "{\"variables\":{\"organization\":\"%s\",\"number\":%d},
                                                                    \"query\":\"" + GET_ORGANIZATION_PROJECT + "\"}";

@final string TEMPLATE_GET_PULL_REQUESTS = "{\"variables\":{\"owner\":\"%s\",\"name\":\"%s\",\"states\":%s,
                                                        \"recordCount\":%d},\"query\":\"" + GET_PULL_REQUESTS + "\"}";

@final string TEMPLATE_GET_REPOSITORY_PROJECTS = "{\"variables\":{\"owner\":\"%s\",\"repository\":\"%s\",
                                    \"states\":%s,\"recordCount\":%d},\"query\":\"" + GET_REPOSITORY_PROJECTS + "\"}";

@final string TEMPLATE_GET_REPOSITORY_PROJECT = "{\"variables\":{\"owner\":\"%s\",\"repository\":\"%s\",
                                                        \"number\":%d},\"query\":\"" + GET_REPOSITORY_PROJECT + "\"}";

@final string TEMPLATE_GET_REPOSITORY_ISSUES = "{\"variables\":{\"owner\":\"%s\",\"name\":\"%s\",\"states\":%s,
                                                    \"recordCount\":%d},\"query\":\"" + GET_REPOSITORY_ISSUES + "\"}";

@final string TEMPLATE_GET_ORGANIZATION_PROJECTS = "{\"variables\":{\"organization\":\"%s\",\"states\":%s,
                                                \"recordCount\":%d},\"query\":\"" + GET_ORGANIZATION_PROJECTS + "\"}";

@final string TEMPLATE_GET_ORGANIZATION_REPOSITORIES = "{\"variables\":{\"organization\":\"%s\",
                                            \"recordCount\":%d},\"query\":\"" + GET_ORGANIZATION_REPOSITORIES + "\"}";








