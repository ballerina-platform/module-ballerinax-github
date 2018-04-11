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


// Endpoint URLs
@final string GIT_GRAPHQL_API_URL = "https://api.github.com/graphql";
@final string GIT_REST_API_URL = "https://api.github.com/";

// String constants
@final string GIT_CARDS = "cards";
@final string GIT_COLUMNS = "columns";
@final string GIT_DATA = "data";
@final string GIT_EDGES = "edges";
@final string GIT_END_CURSOR = "endCursor";
@final string GIT_END_CURSOR_CARD = "endCursorCard";
@final string GIT_END_CURSOR_COLUMN = "endCursorColumn";
@final string GIT_HAS_NEXT_PAGE = "hasNextPage";
@final string GIT_ISSUES = "issues";
@final string GIT_MESSAGE = "message";
@final string GIT_NAME = "name";
@final string GIT_NODE = "node";
@final string GIT_NODES = "nodes";
@final string GIT_ORGANIZATION = "organization";
@final string GIT_OWNER = "owner";
@final string GIT_PAGE_INFO = "pageInfo";
@final string GIT_PROJECT = "project";
@final string GIT_PROJECTS = "projects";
@final string GIT_PULL_REQUESTS = "pullRequests";
@final string GIT_REPOSITORIES = "repositories";
@final string GIT_REPOSITORY = "repository";
@final string GIT_REPOSITORY_OWNER = "repositoryOwner";
@final string GIT_START_CURSOR = "startCursor";

// Public constants
@final public string GIT_STATE_ALL_ISSUE = "[\"OPEN\",\"CLOSED\"]";
@final public string GIT_STATE_ALL_PULL_REQUEST = "[\"OPEN\",\"CLOSED\",\"MERGED\"]";
@final public string GIT_STATE_CLOSED = "[\"CLOSED\"]";
@final public string GIT_STATE_MERGED = "[\"MERGED\"]";
@final public string GIT_STATE_OPEN = "[\"OPEN\"]";

//Integer constants
@final int GIT_INDEX_ZERO = 0;
@final int GIT_INDEX_ONE = 1;
@final int GIT_INDEX_TWO = 2;
@final int GIT_MAX_RECORD_COUNT = 100;

//Errors
@final string GIT_ERRORS = "errors";
@final string GIT_ERROR_WHILE_RETRIEVING_DATA = "Error while retrieving data.";
@final string GIT_ERROR_WHILE_RETRIEVING_PAYLOAD = "Error while retrieving payload.";
@final string GIT_ERROR_WHILE_RETRIEVING_RESOURCE_PATH = "Error while retrieving project resource path.";

@final string GIT_PATH_SEPARATOR = "/";