// Copyright (c) 2021, WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
// 
// WSO2 LLC. licenses this file to you under the Apache License,
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

final string USER = "       anyPinnableItems,  \n" +
                        "       avatarUrl,         \n" +
                        "       bio,               \n" +
                        "       bioHTML,           \n" +
                        "       company,           \n" +
                        "       companyHTML,       \n" +
                        "       createdAt,         \n" +
                        "       databaseId,        \n" +
                        "       email,             \n" +
                        "       hasSponsorsListing,\n" +
                        "       id,                \n" +
                        "       isBountyHunter, \n" +
                        "       isCampusExpert, \n" +
                        "       isDeveloperProgramMember, \n" +
                        "       isEmployee, \n" +
                        "       isGitHubStar, \n" +
                        "       isSiteAdmin, \n" +
                        "       isViewer, \n" +
                        "       location,          \n" +
                        "       login,             \n" +
                        "       projectsUrl, \n" +
                        "       resourcePath, \n" +
                        "       twitterUsername, \n" +
                        "       updatedAt, \n" +
                        "       url,               \n" +
                        "       websiteUrl, \n" +
                        "       name              \n";

final string OWNER = "owner{\n" +
                    "   id,\n" +
                    "   login,\n" +
                    "   resourcePath,\n" +
                    "   url,\n" +
                    "   avatarUrl\n" +
                    "},\n";

final string HEAD_REPOSITORY_OWNER = "headRepositoryOwner{\n" +
                    "   id,\n" +
                    "   login,\n" +
                    "   resourcePath,\n" +
                    "   url,\n" +
                    "   avatarUrl\n" +
                    "},\n";

final string Author = "author{\n" +
                    "   login,\n" +
                    "   resourcePath,\n" +
                    "   url,\n" +
                    "   avatarUrl\n" +
                    "},\n";

final string Editor = "editor{\n" +
                    "   login,\n" +
                    "   resourcePath,\n" +
                    "   url,\n" +
                    "   avatarUrl\n" +
                    "},\n";

final string Creator = "creator{\n" +
                    "   login,\n" +
                    "   resourcePath,\n" +
                    "   url,\n" +
                    "   avatarUrl\n" +
                    "},\n";

final string MergedBy = "mergedBy{\n" +
                        "   login,\n" +
                        "   resourcePath,\n" +
                        "   url,\n" +
                        "   avatarUrl\n" +
                        "},\n";

final string PAGE_INFO_AND_TOTAL_COUNT = "           pageInfo{          \n" +
                                            "             startCursor,     \n" +
                                            "             endCursor,       \n" +
                                            "             hasNextPage,\n" +
                                            "             hasPreviousPage,\n" +
                                            "           },                  \n" +
                                            "           totalCount\n";

final string CONTEXTS_FIELDS = "contexts { \n" +
                            "     state\n" +
                            "     targetUrl\n" +
                            "     description\n" +
                            "     context\n" +
                            "}\n";

final string STATUS = "status { \n" +
                            "state\n" +
                            CONTEXTS_FIELDS +
                    " }\n";

final string COMMIT = "commit { \n" +
                    "     commitUrl\n" +
                    "     oid\n" +
                            STATUS +
                    " }\n";

final string LANGUAGE_FIELDS = "color\n" +
                                    "id\n" +
                                    "name\n";
final string REPOSITORY_FIELDS = "       createdAt\n" +
                                            "       databaseId\n" +
                                            "       deleteBranchOnMerge\n" +
                                            "       description\n" +
                                            "       descriptionHTML\n" +
                                            "       diskUsage\n" +
                                            "       forkCount\n" +
                                            "       hasIssuesEnabled\n" +
                                            "       hasProjectsEnabled\n" +
                                            "       hasWikiEnabled\n" +
                                            "       homepageUrl\n" +
                                            "       id\n" +
                                            "       isArchived\n" +
                                            "       isBlankIssuesEnabled\n" +
                                            "       isDisabled\n" +
                                            "       isEmpty\n" +
                                            "       isFork\n" +
                                            "       isInOrganization\n" +
                                            "       isLocked\n" +
                                            "       isMirror\n" +
                                            "       isPrivate\n" +
                                            "       isSecurityPolicyEnabled\n" +
                                            "       isTemplate\n" +
                                            "       isUserConfigurationRepository\n" +
                                            "       mergeCommitAllowed\n" +
                                            "       mirrorUrl\n" +
                                            "       name\n" +
                                            "       nameWithOwner\n" +
                                                    OWNER +
                                            "       projectsUrl\n" +
                                            "       pushedAt\n" +
                                            "       rebaseMergeAllowed\n" +
                                            "       resourcePath\n" +
                                            "       securityPolicyUrl\n" +
                                            "       sshUrl\n" +
                                            "       stargazerCount\n" +
                                            "       tempCloneToken\n" +
                                            "       updatedAt\n" +
                                            "       url\n" +
                                            "       viewerCanAdminister\n" +
                                            "       viewerCanCreateProjects\n" +
                                            "       viewerCanSubscribe\n";

final string ISSUE_FIELDS = Author +
                                            "              body,\n" +
                                            "              bodyHTML,\n" +
                                            "              bodyResourcePath,\n" +
                                            "              bodyText,\n" +
                                            "              bodyUrl,\n" +
                                            "              closed,\n" +
                                            "              closedAt,\n" +
                                            "              createdAt,\n" +
                                            "              createdViaEmail,\n" +
                                            "              databaseId,\n" +
                                                                Editor +
                                            "              id,\n" +
                                            "              isPinned,\n" +
                                            "              isReadByViewer,\n" +
                                            "              lastEditedAt,\n" +
                                            "              locked,\n" +
                                            "              number,\n" +
                                            "              publishedAt,\n" +
                                            "              resourcePath,\n" +
                                            "              state,\n" +
                                            "              title,\n" +
                                            "              updatedAt,\n" +
                                            "              url,\n" +
                                            "              viewerDidAuthor,\n";
                                            
final string SEARCH_ISSUE_FIELDS = ISSUE_FIELDS + SEARCH_ISSUE_LABEL_FIELDS;

final string SEARCH_ISSUE_LABEL_FIELDS =    "              labels (first: $perPageCountForLabels) {\n" +
                                            "                 nodes{\n" +
                                                                LABEL_FIELDS +
                                            "                \n}," +
                                            "                 totalCount,\n"+
                                            "              },\n";

final string ISSUE_COMMENT_FIELDS = Author +
                                            "              body,\n" +
                                            "              bodyHTML,\n" +
                                            "              bodyText,\n" +
                                            "              createdAt,\n" +
                                            "              databaseId,\n" +
                                                                Editor +
                                            "              id,\n" +
                                            "              isMinimized,\n" +
                                            "              lastEditedAt,\n" +
                                            "              minimizedReason,\n" +
                                            "              publishedAt,\n" +
                                            "              url,\n" +
                                            "              viewerCanDelete,\n" +
                                            "              viewerCanUpdate,\n" +
                                            "              viewerDidAuthor,\n";

final string LABEL_FIELDS = "                     id,\n" +
                                        "                     name,\n" +
                                        "                     color,\n" +
                                        "                     description,\n" +
                                        "                     createdAt,\n" +
                                        "                     updatedAt,\n" +
                                        "                     isDefault,\n" +
                                        "                     url\n";

final string MILESTONE_FIELDS = "                     id,\n" +
                                        "                     number,\n" +
                                        "                     closed,\n" +
                                        "                     closedAt,\n" +
                                        "                     createdAt,\n" +
                                                                Creator +
                                        "                     description,\n" +
                                        "                     dueOn,\n" +
                                        "                     progressPercentage,\n" +
                                        "                     resourcePath,\n" +
                                        "                     title,\n" +
                                        "                     updatedAt\n";

final string REF_FIELDS = "id,\n" +
                                        "name,\n" +
                                        "prefix,\n";

final string PULL_REQUEST_FIELDS = "                     id,\n" +
                                        "                     additions,\n" +
                                                                Author +
                                        "                     baseRef{\n" +
                                                                    REF_FIELDS +
                                        "                     }" +
                                        "                     baseRefName,\n" +
                                        "                     body,\n" +
                                        "                     bodyHTML,\n" +
                                        "                     bodyText,\n" +
                                        "                     changedFiles,\n" +
                                        "                     checksResourcePath,\n" +
                                        "                     checksUrl\n" +
                                        "                     closed,\n" +
                                        "                     closedAt,\n" +
                                        "                     createdAt,\n" +
                                        "                     createdViaEmail,\n" +
                                        "                     databaseId,\n" +
                                        "                     deletions,\n" +
                                                                Editor +
                                        "                     headRef{\n" +
                                                                    REF_FIELDS +
                                        "                     }" +
                                        "                     headRefName,\n" +
                                                                HEAD_REPOSITORY_OWNER +
                                        "                     isDraft\n" +
                                        "                     lastEditedAt,\n" +
                                        "                     locked,\n" +
                                        "                     merged,\n" +
                                                                MergedBy +
                                        "                     number,\n" +
                                        "                     publishedAt,\n" +
                                        "                     resourcePath,\n" +
                                        "                     revertUrl,\n" +
                                        "                     state,\n" +
                                        "                     title,\n" +
                                        "                     updatedAt,\n" +
                                        "                     url,\n";

final string SEARCH_PULL_REQUEST__FIELDS = PULL_REQUEST_FIELDS +
                                        SEARCH_ISSUE_LABEL_FIELDS +
                                        CLOSING_ISSUE_REFERENCES +
                                        PULL_REQUEST_REVIEWS;

final string PULL_REQUEST_REVIEWS =     "        reviews(first: 10) {\n" +
                                        "               nodes {,\n" +
                                        "               author {,\n" +
                                        "                       login,\n" +
                                        "                       url,\n" +
                                        "               },\n" +
                                        "               body,\n" +
                                        "               bodyHTML,\n" +
                                        "               bodyText,\n" +
                                        "               createdAt,\n" +
                                        "               state,\n" +
                                        "               url,\n" +
                                        "               id,\n" +
                                        "               lastEditedAt,\n" +
                                        "               publishedAt,\n" +
                                        "       },\n" +
                                        "       pageInfo {,\n" +
                                        "               endCursor,\n" +
                                        "               hasNextPage,\n" +
                                        "               hasPreviousPage,\n" +
                                        "               startCursor,\n" +
                                        "       },\n" +
                                        "       totalCount,\n" +
                                        "}";

final string CLOSING_ISSUE_REFERENCES = "               closingIssuesReferences(first: $perPageCountForRelatedIssues) {\n" +
                                        "                       nodes {\n" +
                                        "                               id\n" +
                                        "                               url\n" +
                                        "                               createdAt\n" +
                                        "                               number\n" +
                                        "                               state\n" +
                                                                        SEARCH_ISSUE_ASSIGNEE_FIELDS +
                                        "                       }\n" +
                                        "               }\n";

final string SEARCH_ISSUE_ASSIGNEE_FIELDS =  "                assignees(first: $perPageCountForAssignees) {\n" +
                                        "                       edges {\n" +
                                        "                               node {\n" +
                                        "                                       email\n" +
                                        "                                       login\n" +
                                        "                                       name\n" +
                                        "                                       url\n" +
                                        "                               }\n" +
                                        "                       }\n" +
                                        "               }\n";

final string SEARCH_COUNT = "codeCount,\n" +
                            "discussionCount,\n" +
                            "issueCount,\n" +
                            "repositoryCount,\n" +
                            "userCount,\n" +
                            "wikiCount,\n";

final string REPOSITORY_ENTRY_FIELDS = "name,\n"+
                                        "type,\n" +
                                        "object {,\n" +
                                        "   ... on Blob {" +
                                        "           byteSize,\n" +
                                        "           text,\n" +
                                        "           isBinary,\n" +
                                        "       }\n" +
                                        "}";

final string GET_AUTHENTICATED_USER_QUERY = "query { \n" +
                                            "    viewer {              \n" +
                                                USER +
                                            "    }                     \n" +
                                            "}";

final string GET_USER = "query($userName: String!){\n" +
                        "  user(login: $userName){\n" +
                                USER +
                        "  }\n" +
                        "}";

final string GET_REPOSIOTRY = "query($owner: String!, $name: String!) {   \n" +
                            "    repository(owner:$owner, name:$name) { \n" +
                                REPOSITORY_FIELDS +
                            "    }\n" +
                            "}";

final string GET_LANGUAGE_LIST = "query($owner: String!, $name: String!, $perPageCount: Int!, $lastPageCursor: String) { \n" +
                                "    repository(owner:$owner, name:$name) { \n" +
                                "      languages(first:$perPageCount, after:$lastPageCursor) { \n" +
                                "          nodes{ \n" +
                                                LANGUAGE_FIELDS +
                                "          }\n" +
                                            PAGE_INFO_AND_TOTAL_COUNT +
                                "      }\n" +
                                "    }\n" +
                                "}";

final string GET_LAST_COMMIT = "query($owner: String!, $name: String!, $pullRequestNumber: Int!) { \n" +
                                        "   repository(owner:$owner, name:$name) { \n" +
                                        "       pullRequest(number:$pullRequestNumber) { \n" +
                                        "           commits(last: 1) { \n" +
                                        "               nodes { \n" +
                                                            COMMIT +
                                        "               }\n" +
                                        "           }\n" +
                                        "       }\n" +
                                        "    }\n" +
                                        "}";

final string GET_REPOSITORY_LIST_FOR_AUTHENTICATED_USER = "query($perPageCount: Int!, $lastPageCursor: String) { \n" +
                                                        "    viewer {                    \n" +
                                                        "       repositories(first:$perPageCount, after:$lastPageCursor){ \n" +
                                                        "           nodes{               \n" +
                                                                        REPOSITORY_FIELDS +
                                                        "           }                     \n" +
                                                                    PAGE_INFO_AND_TOTAL_COUNT +
                                                        "       }                         \n" +
                                                        "    }                            \n" +
                                                        "}";

final string GET_REPOSITORY_LIST_FOR_USER = "query($username: String!, $perPageCount: Int!, $lastPageCursor: String) { \n" +
                                            "    user(login: $username) {                    \n" +
                                            "       repositories(first:$perPageCount, after:$lastPageCursor){ \n" +
                                            "           nodes{               \n" +
                                                            REPOSITORY_FIELDS +
                                            "           }                     \n" +
                                                        PAGE_INFO_AND_TOTAL_COUNT +
                                            "       }                         \n" +
                                            "    }                            \n" +
                                            "}";

final string GET_REPOSITORY_LIST_FOR_ORGANIZATION = "query($organizationName: String!, $perPageCount: Int!, $lastPageCursor: String) { \n" +
                                                    "    organization(login: $organizationName) {                    \n" +
                                                    "       repositories(first:$perPageCount, after:$lastPageCursor){ \n" +
                                                    "           nodes{               \n" +
                                                                REPOSITORY_FIELDS +
                                                    "           }                     \n" +
                                                                PAGE_INFO_AND_TOTAL_COUNT +
                                                    "       }                         \n" +
                                                    "    }                            \n" +
                                                    "}";

final string LIST_COLLOBORATORS = "query($username: String!, $repositoryName: String!, $perPageCount: Int!, $lastPageCursor: String){ \n" +
                                "  repository(owner: $username, name: $repositoryName){\n" +
                                "      collaborators(first: $perPageCount, after: $lastPageCursor){ \n" +
                                "          nodes{ \n" +
                                                USER +
                                "          },\n" +
                                            PAGE_INFO_AND_TOTAL_COUNT +
                                "     }\n" +
                                "  }\n" +
                                "}";

final string GET_BRANCH_LIST = "query($username: String!, $repositoryName: String!, $perPageCount: Int!, $lastPageCursor: String){\n" +
                                "  repository(owner: $username, name: $repositoryName){\n" +
                                "    refs(first:$perPageCount, after: $lastPageCursor, refPrefix: \\\"refs/heads/\\\"){\n" +
                                "        nodes{\n" +
                                "            name,\n" +
                                "            id\n" +
                                "            prefix" +
                                "        },\n" +
                                        PAGE_INFO_AND_TOTAL_COUNT +
                                "    }\n" +
                                "  }\n" +
                                "}";

final string GET_ISSUE_LIST_ASSIGNED_TO_USER = "query($owner:String!, $name:String!, $assignee: String!, $perPageCount: Int!, $lastPageCursor: String){\n" +
                                            "  repository(owner: $owner, name: $name){\n" +
                                            "      issues(first: $perPageCount, after: $lastPageCursor, filterBy:{assignee:$assignee}){\n" +
                                            "          nodes{\n" +
                                                            ISSUE_FIELDS +
                                            "          },\n" +
                                                        PAGE_INFO_AND_TOTAL_COUNT +
                                            "      }\n" +
                                            "  }\n" +
                                            "}";

final string GET_ISSUE_LIST = "query($owner:String!, $name:String!, $perPageCount: Int!, $issueFilters:IssueFilters, $lastPageCursor: String){\n" +
                                            "  repository(owner: $owner, name: $name){\n" +
                                            "      issues(first: $perPageCount, after: $lastPageCursor, filterBy: $issueFilters){\n" +
                                            "          nodes{\n" +
                                                            ISSUE_FIELDS +
                                            "          },\n" +
                                                        PAGE_INFO_AND_TOTAL_COUNT +
                                            "      }\n" +
                                            "  }\n" +
                                            "}";

final string GET_ISSUE = "query($owner:String!, $name:String!, $issueNumber: Int!, $perPageCountForLabels: Int){\n" +
                                            "  repository(owner: $owner, name: $name){\n" +
                                            "      issue(number: $issueNumber){\n" +
                                                        SEARCH_ISSUE_FIELDS +
                                            "      }\n" +
                                            "  }\n" +
                                            "}";

final string GET_COMMENT_ISSUE_COMMENT_LIST = "query($username: String!, $repositoryName: String!, $issueNumber: Int!, $perPageCount: Int!, $lastPageCursor: String){\n" +
                                            "     repository(owner: $username, name: $repositoryName){\n" +
                                            "         issue(number: $issueNumber){\n" +
                                            "             comments(first:$perPageCount, after: $lastPageCursor){\n" +
                                            "                 nodes{\n" +
                                                                    ISSUE_COMMENT_FIELDS +
                                            "                 },\n" +
                                                                PAGE_INFO_AND_TOTAL_COUNT +
                                            "             }\n" +
                                            "         }\n" +
                                            "     }\n" +
                                            "}";

// Labels

final string GET_A_REPOSITORY_LABEL = "query($username: String!, $repositoryName: String!, $labelName: String!){\n" +
                                    "     repository(owner: $username, name: $repositoryName){\n" +
                                    "         label(name: $labelName){\n" +
                                                    LABEL_FIELDS +
                                    "         }\n" +
                                    "     }\n" +
                                    "}";

final string GET_ALL_LABELS_FOR_A_ISSUE = "query($username:String!, $repositoryName: String!, $issueNumber: Int!, $perPageCount: Int!, $lastPageCursor: String){\n" +
                                        "     repository(owner: $username, name: $repositoryName){\n" +
                                        "         issue(number: $issueNumber){\n" +
                                        "             labels(first: $perPageCount, after: $lastPageCursor){\n" +
                                        "                 nodes{\n" +
                                                                LABEL_FIELDS +
                                        "                 }," +
                                        "                 totalCount,\n" +
                                        "                 pageInfo{\n" +
                                        "                     startCursor,endCursor, hasNextPage, hasPreviousPage\n" +
                                        "                 }\n" +
                                        "             }\n" +
                                        "         }\n" +
                                        "     }" +
                                        "}";

final string LIST_MILESTONES = "query($username: String!, $repositoryName: String!, $perPageCount: Int!, $lastPageCursor: String){\n" +
                                "  repository(owner: $username, name: $repositoryName){\n" +
                                "    milestones(first: $perPageCount, after: $lastPageCursor){\n" +
                                "        nodes{\n" +
                                            MILESTONE_FIELDS +
                                "        },\n" +
                                        PAGE_INFO_AND_TOTAL_COUNT +
                                "    }\n" +
                                "  }\n" +
                                "}";

final string GET_A_MILESTONE = "query($username: String!, $repositoryName: String!, $milestoneNumber: Int!){\n" +
                                "  repository(owner: $username, name: $repositoryName){\n" +
                                "    milestone(number: $milestoneNumber){\n" +
                                        MILESTONE_FIELDS +
                                "    }\n" +
                                "  }\n" +
                                "}";

// Pull Requests

final string GET_A_PULL_REQUEST = "query($username: String!, $repositoryName: String!, $pullRequestNumber: Int!) {\n" +
"        repository(owner:$username, name:$repositoryName) {\n" +
"            pullRequest(number:$pullRequestNumber) {\n" +
                PULL_REQUEST_FIELDS +
"            }\n" +
"        }\n" +
"    }";

final string GET_PULL_REQUESTS_LIST = "query ($owner: String!, $name: String!, $states:[PullRequestState!], $perPageCount: Int!, $lastPageCursor: String) {\n" +
"        repository(owner:$owner, name:$name) {\n" +
"            pullRequests(first: $perPageCount, after: $lastPageCursor states:$states, orderBy:{field:CREATED_AT, direction:DESC}) {\n" +
"                nodes {\n" +
                    PULL_REQUEST_FIELDS +
"                }\n" +
                PAGE_INFO_AND_TOTAL_COUNT +
"            }\n" +
"        }\n" +
"    }";

final string AUTHOR = "    author {\n" +
"        login,\n" +
"        resourcePath,\n" +
"        url,\n" +
"        avatarUrl\n" +
"    }";

final string PAGE_INFO = "    pageInfo {\n" +
"        hasNextPage,\n" +
"        hasPreviousPage,\n" +
"        startCursor,\n" +
"        endCursor\n" +
"    }";

final string PULL_REQUEST_REVIEW_FIELDS = AUTHOR +
                                            "body,\n" +
                                            "createdAt,\n" +
                                            "id,\n" +
                                            "lastEditedAt,\n" +
                                            "url,\n" +
                                            "state,\n" +
                                            "publishedAt,\n";

final string PULL_REQUEST_REVIEW_LIST = "query($username: String!, $repositoryName: String!, $pullRequestNumber: Int!, $perPageCount: Int!, $lastPageCursor: String){\n" +
                                        " repository(owner: $username, name: $repositoryName){\n" +
                                        "   pullRequest(number: $pullRequestNumber){\n" +
                                        "       reviews(first: $perPageCount, after: $lastPageCursor){\n" +
                                        "           nodes{\n" +
                                                        PULL_REQUEST_REVIEW_FIELDS +
                                        "           },\n" +
                                                    PAGE_INFO_AND_TOTAL_COUNT +
                                        "       }" +
                                        "   }" +
                                        " }" +
                                        "}";

final string PROJECT_FIELDS = "id,\n" +
                            "name,\n" +
                            "body,\n" +
                            "closed,\n" +
                            "closedAt,\n" +
                            "createdAt,\n" +
                            Creator +
                            "databaseId,\n" +
                            "number,\n" +
                            "updatedAt,\n" +
                            "url,\n";

final string GET_ORGANIZATION_PROJECT_LIST = "query ($organization: String!, $states:[ProjectState!], $perPageCount: Int!, $lastPageCursor: String) {\n" +
"        organization(login:$organization) {\n" +
"            projects(first:$perPageCount, after:$lastPageCursor, states:$states, orderBy:{field:NAME, direction:ASC}) {\n" +
"               nodes{\n" +
                    PROJECT_FIELDS +
"               }\n" +
                PAGE_INFO_AND_TOTAL_COUNT +
"            }\n" +
"        }\n" +
"    }";

final string GET_REPOSITORY_PROJECT_LIST = "query ($owner: String!, $repository: String!, $states:[ProjectState!], $perPageCount: Int!, $lastPageCursor: String) {\n" +
"        repository(owner:$owner, name:$repository) {\n" +
"           projects(first:$perPageCount, after:$lastPageCursor, states:$states, orderBy:{field:NAME, direction:ASC}) {\n" +
"               nodes{\n" +
                    PROJECT_FIELDS +
"               }\n" +
                PAGE_INFO_AND_TOTAL_COUNT +
"           }\n" +
"       }\n" +
"}";

final string GET_USER_PROJECT = "query($username: String!, $projectNumber: Int!){\n" +
                            "    user(login: $username){\n" +
                            "        project(number: $projectNumber){\n" +
                                        PROJECT_FIELDS +
                            "        }\n" +
                            "    }\n" +
                            "}";

final string GET_USER_PROJECT_LIST = "query($username: String!, $perPageCount: Int!, $lastPageCursor: String){\n" +
                            "    user(login: $username){\n" +
                            "        projects(first: $perPageCount, after: $lastPageCursor){\n" +
                            "            nodes{\n" +
                                            PROJECT_FIELDS +
                            "            },\n" +
                                        PAGE_INFO_AND_TOTAL_COUNT +
                            "        }\n" +
                            "    }\n" +
                            "}";

final string ORGANIZATION_FILEDS = "avatarUrl,\n" +
                                    "description,\n" +
                                    "email,\n" +
                                    "id,\n" +
                                    "location,\n" +
                                    "login,\n" +
                                    "name,\n" +
                                    "projectsResourcePath,\n" +
                                    "projectsUrl,\n" +
                                    "resourcePath,\n" +
                                    "url,\n" +
                                    "websiteUrl,\n";

final string GET_ORG = "query ($organization: String!) {\n" +
"        organization(login:$organization) {\n" +
            ORGANIZATION_FILEDS +
"        }\n" +
"    }";

final string GET_ORGANIZATION_MEMBERS_LIST = "query($organizationName: String!, $perPageCount: Int!, $lastPageCursor: String){\n" +
                                            "  organization(login: $organizationName){\n" +
                                            "      membersWithRole(first: $perPageCount, after: $lastPageCursor){\n" +
                                            "          nodes{\n" +
                                                            USER +
                                            "          },\n" +
                                                        PAGE_INFO_AND_TOTAL_COUNT +
                                            "      }\n" +
                                            "  }\n" +
                                            "}";

final string GET_USER_ORGANIZATION_LIST = "query($username: String!, $perPageCount: Int!, $lastPageCursor: String){\n" +
                                        "  user(login: $username){\n" +
                                        "     organizations(first: $perPageCount, after: $lastPageCursor){\n" +
                                        "         nodes{\n" +
                                                        ORGANIZATION_FILEDS +
                                        "         }," +
                                                    PAGE_INFO_AND_TOTAL_COUNT +
                                        "     }\n" +
                                        "  }\n" +
                                        "}";

final string GET_REPOSITORY_ID = "query($repositoryOwnerName: String!, $repositoryName: String!){\n" +
                                "  repository(owner: $repositoryOwnerName, name: $repositoryName){\n" +
                                "      id,\n" +
                                "  }\n" +
                                "}";

final string GET_PULL_REQUEST_ID = "query($repositoryOwnerName: String!, $repositoryName: String!, $pullRequestNumber: Int!){\n" +
                                "  repository(owner: $repositoryOwnerName, name: $repositoryName){\n" +
                                "      pullRequest(number: $pullRequestNumber){\n" +
                                "          id\n" +
                                "      }\n" +
                                "  }\n" +
                                "}";

final string GET_ISSUE_ID = "query($repositoryOwnerName: String!, $repositoryName: String!, $issueNumber: Int!){\n" +
                                "  repository(owner: $repositoryOwnerName, name: $repositoryName){\n" +
                                "      issue(number: $issueNumber){\n" +
                                "          id\n" +
                                "      }\n" +
                                "  }\n" +
                                "}";

final string GET_PROJECT_ID = "query($repositoryOwnerName: String!, $repositoryName: String!, $projectNumber: Int!){\n" +
                                "  repository(owner: $repositoryOwnerName, name: $repositoryName){\n" +
                                "      project(number: $projectNumber){\n" +
                                "          id\n" +
                                "      }\n" +
                                "  }\n" +
                                "}";

final string GET_USER_OWNER_ID = "query($userName: String!){\n" +
                                "  user(login: $userName){\n" +
                                "     id\n" +
                                "  }\n" +
                                "}";

final string SEARCH = "query ($searchQuery: String!, $searchType: SearchType!, $perPageCount: Int, $lastPageCursor: String, $perPageCountForLabels: Int," +
                      "$perPageCountForAssignees: Int, $perPageCountForRelatedIssues: Int) {\n" +
                        "   search(query: $searchQuery, type: $searchType, first: $perPageCount, after: $lastPageCursor) {\n" +
                                SEARCH_COUNT +
                                PAGE_INFO +
                        "       nodes{\n" +
                        //
                        "           ... on Issue {\n" +
                                        SEARCH_ISSUE_FIELDS +
                        "           }\n" +
                        "           ... on Organization {\n" +
                                        ORGANIZATION_FILEDS +
                        "           }\n" +
                        "           ... on PullRequest {\n" +
                                        SEARCH_PULL_REQUEST__FIELDS +
                        "           }\n" +
                        "           ... on Repository {\n" +
                                        REPOSITORY_FIELDS +
                        "           }\n" +
                        "           ... on User {\n" +
                                        USER +
                        "           }\n" +
                        "       }\n" +
                        "   }\n" +
                        "}";

// Repository content
final string GET_REPOSITORY_CONTENT = "query($owner:String!, $name:String!, $expr: String!){\n" +
                                "       repository(owner: $owner, name: $name){\n" +
                                "               object(expression: $expr){\n" +
                                "                       ... on Tree {\n" +
                                "                               entries {\n"+
                                                                        REPOSITORY_ENTRY_FIELDS +
                                "                               }\n" +
                                "                       }\n" +
                                "               }\n" +
                                "       }\n" +
                                "}";