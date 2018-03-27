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

package github;

// Stated in alphabetical order


//String constants
const string GIT_API_URL = "https://api.github.com/graphql";
const string GIT_CARDS = "cards";
const string GIT_COLUMNS = "columns";
const string GIT_DATA = "data";
const string GIT_EDGES = "edges";
const string GIT_END_CURSOR = "endCursor";
const string GIT_END_CURSOR_CARD = "endCursorCard";
const string GIT_END_CURSOR_COLUMN = "endCursorColumn";
const string GIT_HAS_NEXT_PAGE = "hasNextPage";
const string GIT_ISSUES = "issues";
const string GIT_MESSAGE = "message";
const string GIT_NAME = "name";
const string GIT_NODE = "node";
const string GIT_NODES = "nodes";
const string GIT_NUMBER = "number";
const string GIT_ORGANIZATION = "organization";
const string GIT_OWNER = "owner";
const string GIT_PAGE_INFO = "pageInfo";
const string GIT_PROJECT = "project";
const string GIT_PROJECTS = "projects";
const string GIT_PULL_REQUESTS = "pullRequests";
const string GIT_QUERY = "query";
const string GIT_RECORD_COUNT = "recordCount";
const string GIT_REPOSITORIES = "repositories";
const string GIT_REPOSITORY = "repository";
const string GIT_REPOSITORY_OWNER = "repositoryOwner";
const string GIT_START_CURSOR = "startCursor";
const string GIT_STATES = "states";
const string GIT_VARIABLES = "variables";

// Public constants
public const string GIT_STATE_ALL_ISSUE = "[\"OPEN\",\"CLOSED\"]";
public const string GIT_STATE_ALL_PULL_REQUEST = "[\"OPEN\",\"CLOSED\",\"MERGED\"]";
public const string GIT_STATE_CLOSED = "[\"CLOSED\"]";
public const string GIT_STATE_MERGED = "[\"MERGED\"]";
public const string GIT_STATE_OPEN = "[\"OPEN\"]";

//Integer constants
const int GIT_INDEX_ZERO = 0;
const int GIT_INDEX_ONE = 1;
const int GIT_INDEX_TWO = 2;
const int GIT_MAX_RECORD_COUNT = 100;

//Errors
const string GIT_ERRORS = "errors";
const string GIT_ERROR_WHILE_RETRIEVING_DATA = "Error while retrieving data.";
const string GIT_ERROR_WHILE_RETRIEVING_PAYLOAD = "Error while retrieving payload.";
const string GIT_ERROR_WHILE_RETRIEVING_RESOURCE_PATH = "Error while retrieving project resource path.";

const string GIT_PATH_SEPARATOR = "/";