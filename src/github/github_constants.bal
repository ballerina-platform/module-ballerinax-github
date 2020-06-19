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

// Endpoint URLs
final string GIT_GRAPHQL_API_URL = "https://api.github.com/graphql";
final string GIT_REST_API_URL = "https://api.github.com/";

// String constants
final string GIT_CARDS = "cards";
final string GIT_COLUMNS = "columns";
final string GIT_DATA = "data";
final string GIT_EDGES = "edges";
final string GIT_END_CURSOR = "endCursor";
final string GIT_END_CURSOR_CARD = "endCursorCard";
final string GIT_END_CURSOR_COLUMN = "endCursorColumn";
final string GIT_ERRORS = "errors";
final string GIT_HAS_NEXT_PAGE = "hasNextPage";
final string GIT_REFS = "refs";
final string GIT_ISSUES = "issues";
final string GIT_MESSAGE = "message";
final string GIT_NAME = "name";
final string GIT_NODE = "node";
final string GIT_NODES = "nodes";
final string GIT_ORGANIZATION = "organization";
final string GIT_OWNER = "owner";
final string GIT_PAGE_INFO = "pageInfo";
final string GIT_PROJECT = "project";
final string GIT_PROJECTS = "projects";
final string GIT_PULL_REQUESTS = "pullRequests";
final string GIT_QUERY = "query";
final string GIT_REPOS = "repos";
final string GIT_REPOSITORIES = "repositories";
final string GIT_REPOSITORY = "repository";
final string GIT_REPOSITORY_OWNER = "repositoryOwner";
final string GIT_START_CURSOR = "startCursor";

// Error Codes
final string GITHUB_ERROR_CODE = "(ballerinax/github)GithubError";

// Public constants
# Pull request state open, closed and merged
public const string PULL_REQUEST_STATE_ALL = "[\"OPEN\",\"CLOSED\",\"MERGED\"]";
# Closed state
public const string STATE_CLOSED = "[\"CLOSED\"]";
# Merged state
public const string STATE_MERGED = "[\"MERGED\"]";
# Open state
public const string STATE_OPEN = "[\"OPEN\"]";
# State open and closed
public const string STATE_ALL = "[\"OPEN\",\"CLOSED\"]";

// Integer constants
final int INDEX_ZERO = 0;
final int INDEX_ONE = 1;
final int INDEX_TWO = 2;
final int MAX_RECORD_COUNT = 100;

// Utility constants
final string PATH_SEPARATOR = "/";
final string EMPTY_STRING = "";

// GraphQL queries

final string PAGE_INFO = "    pageInfo {\n" +
"        hasNextPage,\n" +
"        hasPreviousPage,\n" +
"        startCursor,\n" +
"        endCursor\n" +
"    }";

final string CREATOR = "    creator {\n" +
"        login,\n" +
"        resourcePath,\n" +
"        url,\n" +
"        avatarUrl\n" +
"    }";

final string PROJECT_OWNER = "    owner {\n" +
"        id,\n" +
"        projectsResourcePath,\n" +
"        projectsUrl,\n" +
"        viewerCanCreateProjects,\n" +
"        __typename\n" +
"    }";

final string REPOSITORY_OWNER = "    owner {\n" +
"        id,\n" +
"        login,\n" +
"        url,\n" +
"        avatarUrl,\n" +
"        resourcePath\n" +
"    }";

final string PROJECTS_NODES = "    nodes {\n" +
"        id,\n" +
"        databaseId,\n" +
"        name,\n" +
"        body,\n" +
"        number,\n" +
"        createdAt,\n" +
"        updatedAt,\n" +
"        closed,\n" +
"        closedAt,\n" +
"        resourcePath,\n" +
"        state,\n" +
"        url,\n" +
"        viewerCanUpdate,\n" +
"        " + CREATOR + ",\n" +
"        " + PROJECT_OWNER + "\n" +
"    }";

final string PRIMARY_LANGUAGE = "    primaryLanguage {\n" +
"        id,\n" +
"        name,\n" +
"        color\n" +
"    }";

final string AUTHOR = "    author {\n" +
"        login,\n" +
"        resourcePath,\n" +
"        url,\n" +
"        avatarUrl\n" +
"    }";

final string COLUMN = "    column {\n" +
"        id,\n" +
"        name,\n" +
"        url\n" +
"    }";

final string EDITOR = "    editor {\n" +
"        login,\n" +
"        resourcePath,\n" +
"        url,\n" +
"        avatarUrl,\n" +
"    }";

final string LABELS = "    labels (first: 100) {\n" +
"        nodes {\n" +
"            id,\n" +
"            name,\n" +
"            description,\n" +
"            color\n" +
"        }\n" +
"    }";

final string CONTENT = "    content {\n" +
"        ... on Issue { title, url, issueState:state}\n" +
"        ... on PullRequest { title, url, prState:state}\n" +
"    }";

final string GET_REPOSITORY_PROJECTS = "query ($owner: String!, $repository: String!, $states:[ProjectState!], $recordCount: Int!) {\n" +
"        repository(owner:$owner, name:$repository) {\n" +
"        projects(first:$recordCount, states:$states, orderBy:{field:NAME, direction:ASC}) {\n" +
"        " + PAGE_INFO + ",\n" +
"        " + PROJECTS_NODES + "\n" +
"    }\n" +
"  }\n" +
"}";

final string GET_REPOSITORY_PROJECTS_NEXT_PAGE = "query ($owner: String!, $repository: String!, $states:[ProjectState!], $endCursorProjects: String!,\n" +
"    $recordCount: Int!) {\n" +
"        repository(owner:$owner, name:$repository) {\n" +
"            projects(first:$recordCount, states:$states, after:$endCursorProjects,\n" +
"            orderBy:{field:NAME, direction:ASC}) {\n" +
"            " + PAGE_INFO + ",\n" +
"            " + PROJECTS_NODES + "\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_ORGANIZATION_PROJECTS = "query ($organization: String!, $states:[ProjectState!], $recordCount: Int!) {\n" +
"        organization(login:$organization) {\n" +
"            projects(first:$recordCount, states:$states, orderBy:{field:NAME, direction:ASC}) {\n" +
"            " + PAGE_INFO + ",\n" +
"            " + PROJECTS_NODES + "\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_ORGANIZATION_PROJECTS_NEXT_PAGE = "query ($organization: String!, $states:[ProjectState!], $endCursorProjects:String!, $recordCount: Int!) {\n" +
"        organization(login:$organization) {\n" +
"            projects(first:$recordCount, states:$states, after:$endCursorProjects,\n" +
"            orderBy:{field:NAME, direction:ASC}) {\n" +
"            " + PAGE_INFO + ",\n" +
"            " + PROJECTS_NODES + "\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_REPOSITORY_PROJECT = "query ($owner: String!, $repository: String!, $number: Int!) {\n" +
"        repository(owner:$owner, name:$repository) {\n" +
"            project(number:$number) {\n" +
"                id,\n" +
"                databaseId,\n" +
"                name,\n" +
"                body,\n" +
"                number,\n" +
"                createdAt,\n" +
"                updatedAt,\n" +
"                closed,\n" +
"                closedAt,\n" +
"                resourcePath,\n" +
"                state,\n" +
"                url,\n" +
"                viewerCanUpdate,\n" +
"                " + CREATOR + ",\n" +
"                " + PROJECT_OWNER + "\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_ORGANIZATION_PROJECT = "query ($organization: String!, $number: Int!) {\n" +
"        organization(login:$organization) {\n" +
"            project(number:$number) {\n" +
"                id,\n" +
"                databaseId,\n" +
"                name,\n" +
"                body,\n" +
"                number,\n" +
"                createdAt,\n" +
"                updatedAt,\n" +
"                closed,\n" +
"                closedAt,\n" +
"                resourcePath,\n" +
"                state,\n" +
"                url,\n" +
"                viewerCanUpdate,\n" +
"                " + CREATOR + "," +
"                " + PROJECT_OWNER + 
"            }\n" +
"        }\n" +
"    }";

final string GET_REPOSITORY = "query ($owner: String!, $name: String!) {\n" +
"        repository(owner:$owner, name:$name) {\n" +
"            id,\n" +
"            name,\n" +
"            createdAt,\n" +
"            updatedAt,\n" +
"            description,\n" +
"            forkCount,\n" +
"            hasIssuesEnabled,\n" +
"            hasWikiEnabled,\n" +
"            homepageUrl,\n" +
"            isArchived,\n" +
"            isFork,\n" +
"            isLocked,\n" +
"            isMirror,\n" +
"            isPrivate,\n" +
"            lockReason,\n" +
"            mirrorUrl,\n" +
"            url,\n" +
"            sshUrl,\n" +
"            " + REPOSITORY_OWNER + "," +
"            " + PRIMARY_LANGUAGE + "," +
"            stargazers {\n" +
"                totalCount\n" +
"           }\n" +
"        }\n" +
"    }";

final string GET_PULL_REQUESTS = "query ($owner: String!, $name: String!, $states:[PullRequestState!], $recordCount: Int!) {\n" +
"        repository(owner:$owner, name:$name) {\n" +
"            pullRequests(first:$recordCount, states:$states, orderBy:{field:CREATED_AT, direction:DESC}) {\n" +
"            " + PAGE_INFO + "," +
"                nodes {\n" +
"                    id,\n" +
"                    title,\n" +
"                    createdAt,\n" +
"                    updatedAt,\n" +
"                    closed,\n" +
"                    closedAt,\n" +
"                    mergedAt,\n" +
"                    state,\n" +
"                    number,\n" +
"                    url,\n" +
"                    body,\n" +
"                    changedFiles,\n" +
"                    additions,\n" +
"                    deletions,\n" +
"                    resourcePath,\n" +
"                    revertResourcePath,\n" +
"                    revertUrl,\n" +
"                    headRefName,\n" +
"                    baseRefName,\n" +
"                    " + AUTHOR + 
"                }\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_PULL_REQUESTS_NEXT_PAGE = "query ($owner: String!, $name: String!, $states:[PullRequestState!], $endCursorPullRequests: String!,\n" +
"    $recordCount: Int!) {\n" +
"        repository(owner:$owner, name:$name) {\n" +
"            pullRequests(first:$recordCount, states:$states, after: $endCursorPullRequests,\n" +
"            orderBy:{field:CREATED_AT, direction:DESC}) {\n" +
"            " + PAGE_INFO + ",\n" +
"                nodes {\n" +
"                    id,\n" +
"                    title,\n" +
"                    createdAt,\n" +
"                    updatedAt,\n" +
"                    closed,\n" +
"                    closedAt,\n" +
"                    mergedAt,\n" +
"                    state,\n" +
"                    number,\n" +
"                    url,\n" +
"                    body,\n" +
"                    changedFiles,\n" +
"                    additions,\n" +
"                    deletions,\n" +
"                    resourcePath,\n" +
"                    revertResourcePath,\n" +
"                    revertUrl,\n" +
"                    headRefName,\n" +
"                    baseRefName,\n" +
"                    " + AUTHOR + "\n" +
"                }\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_ORGANIZATION = "query ($organization: String!) {\n" +
"        organization(login:$organization) {\n" +
"            avatarUrl,\n" +
"            description,\n" +
"            email,\n" +
"            id,\n" +
"            location,\n" +
"            login,\n" +
"            name,\n" +
"            projectsResourcePath,\n" +
"            projectsUrl,\n" +
"            resourcePath,\n" +
"            url,\n" +
"            websiteUrl\n" +
"        }\n" +
"    }";

final string GET_REPOSITORY_PROJECT_COLUMNS = "query ($owner: String!,$name:String!, $number: Int!, $recordCount: Int!) {\n" +
"        repository (owner:$owner, name:$name) {\n" +
"            project (number : $number) {\n" +
"                columns (first:$recordCount) {\n" +
"                " + PAGE_INFO + ",\n" +
"                    nodes {\n" +
"                        id,\n" +
"                        name,\n" +
"                        cards (first:$recordCount) {\n" +
"                        " + PAGE_INFO + ",\n" +
"                            nodes {\n" +
"                                id,\n" +
"                                note,\n" +
"                                " + CREATOR + ",\n" +
"                                state,\n" +
"                                createdAt,\n" +
"                                updatedAt,\n" +
"                                url,\n" +
"                                " + COLUMN + ",\n" +
"                                " + CONTENT + "\n" +
"                            }\n" +
"                        }\n" +
"                    }\n" +
"                }\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_REPOSITORY_PROJECT_COLUMNS_NEXT_PAGE = "query ($owner: String!,$name:String!, $number: Int!, $endCursorColumns: String!, $recordCount: Int!) {\n" +
"        repository (owner:$owner, name:$name) {\n" +
"            project (number : $number) {\n" +
"                columns (first:$recordCount) {\n" +
"                " + PAGE_INFO + ",\n" +
"                    nodes {\n" +
"                        id,\n" +
"                        name,\n" +
"                        cards (first:$recordCount) {\n" +
"                            pageInfo {\n" +
"                                hasNextPage,\n" +
"                                hasPreviousPage,\n" +
"                                startCursor,\n" +
"                                endCursor\n" +
"                            },\n" +
"                            nodes {\n" +
"                                id,\n" +
"                                note,\n" +
"                                creator {\n" +
"                                    login,\n" +
"                                    resourcePath,\n" +
"                                    url,\n" +
"                                    avatarUrl\n" +
"                                },\n" +
"                                state,\n" +
"                                createdAt,\n" +
"                                updatedAt,\n" +
"                                url,\n" +
"                                " + COLUMN + ",\n" +
"                                " + CONTENT + "\n" +
"                            }\n" +
"                        }\n" +
"                    }\n" +
"                }\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_REPOSITORY_PROJECT_CARDS_NEXT_PAGE = "query ($owner: String!,$name:String!, $number: Int!, $endCursorCards: String!, $recordCount: Int!) {\n" +
"        repository (owner:$owner, name:$name) {\n" +
"            project (number : $number) {\n" +
"                columns (first:$recordCount) {\n" +
PAGE_INFO + ",\n" +
"                    nodes {\n" +
"                        id,\n" +
"                        name,\n" +
"                        cards (first:$recordCount, after: $endCursorCards) {\n" +
"                        " + PAGE_INFO + ",\n" +
"                            nodes {\n" +
"                                id,\n" +
"                                note,\n" +
"                                " + CREATOR + ",\n" +
"                                state,\n" +
"                                createdAt,\n" +
"                                updatedAt,\n" +
"                                url,\n" +
"                                " + COLUMN + ",\n" +
"                                " + CONTENT + "\n" +
"                            }\n" +
"                        }\n" +
"                    }\n" +
"                }\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_ORGANIZATION_PROJECT_COLUMNS = "";

final string GET_ORGANIZATION_PROJECT_COLUMNS_NEXT_PAGE = "query ($organization: String!, $number: Int!, $endCursorColumns: String!, $recordCount: Int!) {\n" +
"        organization (login:$organization) {\n" +
"            project (number : $number) {\n" +
"                columns (first:$recordCount, after: $endCursorColumns) {\n" +
"                " + PAGE_INFO + ",\n" +
"                    nodes {\n" +
"                        id,\n" +
"                        name,\n" +
"                        cards (first:$recordCount) {\n" +
"                            \" + PAGE_INFO + \",\n" +
"                            nodes {\n" +
"                                id,\n" +
"                                note,\n" +
"                                \" + CREATOR + \",\n" +
"                                state,\n" +
"                                createdAt,\n" +
"                                updatedAt,\n" +
"                                url,\n" +
"                                " + COLUMN + ",\n" +
"                                " + CONTENT + "\n" +
"                            }\n" +
"                        }\n" +
"                    }\n" +
"                }\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_ORGANIZATION_PROJECT_CARDS_NEXT_PAGE = "query ($organization: String!, $number: Int!, $endCursorCards: String!, $recordCount: Int!) {\n" +
"        organization (login:$organization) {\n" +
"            project (number : $number) {\n" +
"                columns (first:$recordCount) {\n" +
"                " + PAGE_INFO + ",\n" +
"                    nodes {\n" +
"                        id,\n" +
"                        name,\n" +
"                        cards (first:$recordCount, after: $endCursorCards) {\n" +
"                        " + PAGE_INFO + ",\n" +
"                            nodes {\n" +
"                                id,\n" +
"                                note,\n" +
"                                " + CREATOR + ",\n" +
"                                state,\n" +
"                                createdAt,\n" +
"                                updatedAt,\n" +
"                                url,\n" +
"                                " + COLUMN + ",\n" +
"                                " + CONTENT + "\n" +
"                            }\n" +
"                        }\n" +
"                    }\n" +
"                }\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_USER_REPOSITORIES = "query ($owner: String!, $recordCount: Int!) {\n" +
"        user (login:$owner) {\n" +
"            repositories (first: $recordCount, orderBy:{field:NAME, direction:ASC}) {\n" +
"                    " + PAGE_INFO + ",\n" +
"                nodes {\n" +
"                    id,\n" +
"                    name,\n" +
"                    createdAt,\n" +
"                    updatedAt,\n" +
"                    description,\n" +
"                    forkCount,\n" +
"                    hasIssuesEnabled,\n" +
"                    hasWikiEnabled,\n" +
"                    homepageUrl,\n" +
"                    isArchived,\n" +
"                    isFork,\n" +
"                    isLocked,\n" +
"                    isMirror,\n" +
"                    isPrivate,\n" +
"                    lockReason,\n" +
"                    mirrorUrl,\n" +
"                    url,\n" +
"                    sshUrl,\n" +
"                    " + REPOSITORY_OWNER + ",\n" +
"                    " + PRIMARY_LANGUAGE + "\n" +
"                }\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_ORGANIZATION_REPOSITORIES = "query ($organization: String!, $recordCount: Int!) {\n" +
"        organization (login:$organization) {\n" +
"            repositories (first: $recordCount, orderBy:{field:NAME, direction:ASC}) {\n" +
"            " + PAGE_INFO + ",\n" +
"                nodes {\n" +
"                    id,\n" +
"                    name,\n" +
"                    createdAt,\n" +
"                    updatedAt,\n" +
"                    description,\n" +
"                    forkCount,\n" +
"                    hasIssuesEnabled,\n" +
"                    hasWikiEnabled,\n" +
"                    homepageUrl,\n" +
"                    isArchived,\n" +
"                    isFork,\n" +
"                    isLocked,\n" +
"                    isMirror,\n" +
"                    isPrivate,\n" +
"                    lockReason,\n" +
"                    mirrorUrl,\n" +
"                    url,\n" +
"                    sshUrl,\n" +
"                    " + REPOSITORY_OWNER + ",\n" +
"                    " + PRIMARY_LANGUAGE + "\n" +
"                }\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_ORGANIZATION_REPOSITORIES_NEXT_PAGE = "query ($organization: String!, $endCursorRepos: String!, $recordCount: Int!) {\n" +
"        organization (login:$organization) {\n" +
"            repositories (first: $recordCount, after: $endCursorRepos, orderBy:{field:NAME, direction:ASC}) {\n" +
"                " + PAGE_INFO + ",\n" +
"                nodes {\n" +
"                    id,\n" +
"                    name,\n" +
"                    createdAt,\n" +
"                    updatedAt,\n" +
"                    description,\n" +
"                    forkCount,\n" +
"                    hasIssuesEnabled,\n" +
"                    hasWikiEnabled,\n" +
"                    homepageUrl,\n" +
"                    isArchived,\n" +
"                    isFork,\n" +
"                    isLocked,\n" +
"                    isMirror,\n" +
"                    isPrivate,\n" +
"                    lockReason,\n" +
"                    mirrorUrl,\n" +
"                    url,\n" +
"                    sshUrl,\n" +
"                    " + REPOSITORY_OWNER + ",\n" +
"                    " + PRIMARY_LANGUAGE + "\n" +
"                }\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_REPOSITORY_BRANCHES = "query ($owner:String!, $name:String!, $recordCount: Int!) {\n" +
"        repository(owner:$owner, name: $name) {\n" +
"            refs(first: $recordCount, refPrefix: \\\"refs/heads/\\\") {\n" +
"                " + PAGE_INFO + ",\n" +
"                nodes {\n" +
"                    name\n" +
"                }\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_REPOSITORY_ISSUES = "query ($owner:String!, $name:String!, $states:[IssueState!], $recordCount: Int!) {\n" +
"        repository(owner:$owner, name: $name) {\n" +
"            issues (first: $recordCount, states:$states, orderBy:{field:CREATED_AT, direction:DESC}) {\n" +
"                " + PAGE_INFO + ",\n" +
"                nodes {\n" +
"                    id,\n" +
"                    " + AUTHOR + ",\n" +
"                    bodyText,\n" +
"                    closed,\n" +
"                    closedAt,\n" +
"                    createdAt,\n" +
"                    " + EDITOR + ",\n" +
"                    " + LABELS + ",\n" +
"                    number,\n" +
"                    state,\n" +
"                    title,\n" +
"                    updatedAt,\n" +
"                    url,\n" +
"                    assignees (first: 100) {\n" +
"                        nodes {\n" +
"                            id,\n" +
"                            login,\n" +
"                            email,\n" +
"                            bio,\n" +
"                            url\n" +
"                        }\n" +
"                    }\n" +
"                }\n" +
"            }\n" +
"        }\n" +
"    }";

final string GET_REPOSITORY_ISSUES_NEXT_PAGE = "query ($owner:String!, $name:String!, $states:[IssueState!], $endCursorIssues: String!, $recordCount: Int!) {\n" +
"        repository(owner:$owner, name: $name) {\n" +
"            issues (first: $recordCount, states:$states, after: $endCursorIssues,\n" +
"            orderBy:{field:CREATED_AT, direction:DESC}) {\n" +
"                " + PAGE_INFO + ",\n" +
"                nodes {\n" +
"                    id,\n" +
"                    " + AUTHOR + ",\n" +
"                    bodyText,\n" +
"                    closed,\n" +
"                    closedAt,\n" +
"                    createdAt,\n" +
"                    " + EDITOR + ",\n" +
"                    " + LABELS + ",\n" +
"                    number,\n" +
"                    state,\n" +
"                    title,\n" +
"                    updatedAt,\n" +
"                    url,\n" +
"                    assignees (first: 100) {\n" +
"                        nodes {\n" +
"                            id,\n" +
"                            login,\n" +
"                            email,\n" +
"                            bio,\n" +
"                            url\n" +
"                        }\n" +
"                    }\n" +
"                }\n" +
"            }\n" +
"        }\n" +
"    }";

// String query templates

final string TEMPLATE_GET_REPOSITORY = "{\"variables\":{\"owner\":\"%s\",\"name\":\"%s\"},\"query\":\""
    + GET_REPOSITORY + "\"}";

final string TEMPLATE_GET_ORGANIZATION = "{\"variables\":{\"organization\":\"%s\"},\"query\":\""
    + GET_ORGANIZATION + "\"}";

final string TEMPLATE_GET_ORGANIZATION_PROJECT_COLUMNS = "{\"variables\":{\"organization\":\"%s\",\"number\":%d," + 
                                        "\"recordCount\":%d},\"query\":\"" + GET_ORGANIZATION_PROJECT_COLUMNS + "\"}";

final string TEMPLATE_GET_REPOSITORY_PROJECT_COLUMNS = "{\"variables\":{\"owner\":\"%s\",\"name\":\"%s\", " +
                            "\"number\":%d,\"recordCount\":%d},\"query\":\"" + GET_REPOSITORY_PROJECT_COLUMNS + "\"}";

final string TEMPLATE_GET_ORGANIZATION_PROJECT = "{\"variables\":{\"organization\":\"%s\",\"number\":%d}, " +
                                                                    "\"query\":\"" + GET_ORGANIZATION_PROJECT + "\"}";

final string TEMPLATE_GET_PULL_REQUESTS = "{\"variables\":{\"owner\":\"%s\",\"name\":\"%s\",\"states\":%s, " +
                                                        "\"recordCount\":%d},\"query\":\"" + GET_PULL_REQUESTS + "\"}";

final string TEMPLATE_GET_REPOSITORY_PROJECTS = "{\"variables\":{\"owner\":\"%s\",\"repository\":\"%s\", " +
                                    "\"states\":%s,\"recordCount\":%d},\"query\":\"" + GET_REPOSITORY_PROJECTS + "\"}";

final string TEMPLATE_GET_REPOSITORY_PROJECT = "{\"variables\":{\"owner\":\"%s\",\"repository\":\"%s\", " +
                                                        "\"number\":%d},\"query\":\"" + GET_REPOSITORY_PROJECT + "\"}";

final string TEMPLATE_GET_REPOSITORY_BRANCHES = "{\"variables\":{\"owner\":\"%s\",\"name\":\"%s\", " +
                                                    "\"recordCount\":%d},\"query\":\"" + GET_REPOSITORY_BRANCHES + "\"}";

final string TEMPLATE_GET_REPOSITORY_ISSUES = "{\"variables\":{\"owner\":\"%s\",\"name\":\"%s\",\"states\":%s, " +
                                                    "\"recordCount\":%d},\"query\":\"" + GET_REPOSITORY_ISSUES + "\"}";

final string TEMPLATE_GET_ORGANIZATION_PROJECTS = "{\"variables\":{\"organization\":\"%s\",\"states\":%s, " +
                                                "\"recordCount\":%d},\"query\":\"" + GET_ORGANIZATION_PROJECTS + "\"}";

final string TEMPLATE_GET_ORGANIZATION_REPOSITORIES = "{\"variables\":{\"organization\":\"%s\", " +
                                            "\"recordCount\":%d},\"query\":\"" + GET_ORGANIZATION_REPOSITORIES + "\"}";

final string TEMPLATE_GET_USER_REPOSITORIES = "{\"variables\":{\"owner\":\"%s\", " +
                                            "\"recordCount\":%d},\"query\":\"" + GET_USER_REPOSITORIES + "\"}";
