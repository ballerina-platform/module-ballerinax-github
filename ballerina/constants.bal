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

// String constants
final string GIT_CARDS = "cards";
final string GIT_COLUMNS = "columns";
final string GIT_COMMIT = "commit";
final string GIT_COMMITS = "commits";
final string GIT_DATA = "data";
final string GIT_EDGES = "edges";
final string GIT_END_CURSOR = "endCursor";
final string GIT_END_CURSOR_CARD = "endCursorCard";
final string GIT_END_CURSOR_COLUMN = "endCursorColumn";
final string GIT_ERRORS = "errors";
final string GIT_HAS_NEXT_PAGE = "hasNextPage";
final string GIT_REFS = "refs";
final string GIT_ISSUES = "issues";
final string GIT_ISSUE = "issue";
final string GIT_PULLS = "pulls";
final string GIT_COMMENTS = "comments";
final string GIT_REVIEWS = "reviews";
final string GIT_EVENTS = "events";
final string GIT = "git";
final string GIT_GISTS = "gists";
final string GIT_ORGS = "orgs";
final string GIT_MEMBERSHIPS = "memberships";
final string GIT_MESSAGE = "message";
final string GIT_NAME = "name";
final string GIT_NODE = "node";
final string GIT_NODES = "nodes";
final string GIT_ORGANIZATION = "organization";
final string GIT_ORGANIZATIONS = "organizations";
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
final string GIT_USER = "user";
final string GIT_USERS = "users";
final string GIT_BRANCH_REF_PREFIX = "refs/heads/";
final string GIT_LOGIN = "login";
final string GIT_VIEWER = "viewer";
final string AUTHORIZATION_HEADER = "Authorization";
final string TOKEN = "token ";
final string GIT_COLLABORATORS = "collaborators";
final string GIT_CREATE_ISSUE = "createIssue";
final string GIT_UPDATE_ISSUE = "updateIssue";
final string GIT_ADD_COMMENT = "addComment";
final string GIT_COMMENT_EDGE = "commentEdge";
final string GIT_LABEL = "label";
final string GIT_LABELS = "labels";
final string GIT_LABELABLE = "labelable";
final string GIT_LANGUAGES = "languages";
final string GIT_ADD_LABLE_TO_LABELABLE = "addLabelsToLabelable";
final string GIT_MILESTONES = "milestones";
final string GIT_MILESTONE = "milestone";
final string GIT_PULL_REQUEST = "pullRequest";
final string GIT_MEMBERS_WITH_ROLE = "membersWithRole";
final string GIT_CREATE_PULL_REQUESTS = "createPullRequest";
final string GIT_UPDATE_PULL_REQUESTS = "updatePullRequest";
final string GIT_CREATE_PROJECT = "createProject";
final string GIT_UPDATE_PROJECT = "updateProject";
final string GIT_ID = "id";
final string GIT_ADD_PULL_REQUEST_REVIEW = "addPullRequestReview";
final string GIT_PULL_REQUEST_REVIEW = "pullRequestReview";
final string GIT_SEARCH = "search";
final string GIT_CODE_COUNT = "codeCount";
final string GIT_DISCUSSION_COUNT = "discussionCount";
final string GIT_ISSUE_COUNT = "issueCount";
final string GIT_REPO_COUNT = "repositoryCount";
final string GIT_USER_COUNT = "userCount";
final string GIT_WIKI_COUNT = "wikiCount";
final string GIT_OBJECT = "object";
final string GIT_ENTRIES = "entries";

// Error Codes
final string GITHUB_ERROR_CODE = "(ballerinax/github)GithubError";
final string ERR_USER = "Error occurred while constructing User record.";

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
