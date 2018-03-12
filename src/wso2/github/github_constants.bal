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

package src.wso2.github;

// Stated in alphabetical order

//Constant related to graphql queries

//String constants
public const string GIT_API_URL = "https://api.github.com/graphql"; //TODO move this to a config file
public const string GIT_CARDS = "cards";
public const string GIT_COLUMNS = "columns";
public const string GIT_DATA = "data";
public const string GIT_EDGES = "edges";
public const string GIT_END_CURSOR = "endCursor";
public const string GIT_END_CURSOR_CARD = "endCursorCard";
public const string GIT_END_CURSOR_COLUMN = "endCursorColumn";
public const string GIT_HAS_NEXT_PAGE = "hasNextPage";
public const string GIT_MESSAGE = "message";
public const string GIT_NAME = "name";
public const string GIT_NODE = "node";
public const string GIT_NODES = "nodes";
public const string GIT_NUMBER = "number";
public const string GIT_ORGANIZATION = "organization";
public const string GIT_OWNER = "owner";
public const string GIT_PAGE_INFO = "pageInfo";
public const string GIT_PROJECT = "project";
public const string GIT_PROJECTS = "projects";
public const string GIT_PULL_REQUESTS = "pullRequests";
public const string GIT_QUERY = "query";
public const string GIT_REPOSITORY = "repository";
public const string GIT_REPOSITORY_OWNER = "repositoryOwner";
public const string GIT_START_CURSOR = "startCursor";
public const string GIT_STATES = "states";
public const string GIT_STATE_ALL_ISSUE = "[\"OPEN\",\"CLOSED\"]";
public const string GIT_STATE_ALL_PULL_REQUEST = "[\"OPEN\",\"CLOSED\",\"MERGED\"]";
public const string GIT_STATE_CLOSED = "[\"CLOSED\"]";
public const string GIT_STATE_MERGED = "[\"MERGED\"]";
public const string GIT_STATE_OPEN = "[\"OPEN\"]";
public const string GIT_VARIABLES = "variables";


//Integer constants
public const int GIT_INDEX_ZERO = 0;
public const int GIT_INDEX_ONE = 1;
public const int GIT_INDEX_TWO = 2;

//Errors
public const string GIT_ERRORS = "errors";
public const string GIT_ERROR_WHILE_RETRIEVING_DATA = "Error while retrieving data.";
public const string GIT_ERROR_WHILE_RETRIEVING_PAYLOAD = "Error while retrieving payload.";
public const string GIT_ERROR_WHILE_RETRIEVING_RESOURCE_PATH = "Error while retrieving project resource path.";

public const string GIT_PATH_SEPARATOR = "/";