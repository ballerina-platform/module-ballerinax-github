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

import ballerina/http;
import ballerina/internal;
import ballerina/mime;

# Construct the request by adding the payload and authorization tokens.
# + request - HTTP request object
# + stringQuery - GraphQL API query
function constructRequest(http:Request request, json stringQuery) {
    request.setJsonPayload(stringQuery);
}

# Validate the HTTP response and return payload or error.
# + response - HTTP response object or HTTP Connector error
# + validateComponent - Component to check in the response
# + return - `json` payload of the response or Connector error
function getValidatedResponse(http:Response|error response, string validateComponent) returns json|error {

    match response {
        http:Response gitResponse => {

            var responsePayload = gitResponse.getJsonPayload();

            match responsePayload {
                json jsonPayload => {
                    string[] payLoadKeys = jsonPayload.getKeys();
                    //Check all the keys in the payload to see if an error is returned.
                    foreach key in payLoadKeys {
                        if (GIT_ERRORS.equalsIgnoreCase(key)) {
                            string errors;
                            var errorList = check <json[]>jsonPayload[GIT_ERRORS];
                            foreach i, singleError in errorList {
                                string errorMessage = singleError[GIT_MESSAGE].toString();
                                errors += errorMessage;
                                if (i + 1 != lengthof errorList) {
                                    errors += ",";
                                }
                            }
                            error err = { message: errors };
                            return err;
                        }

                        if (GIT_MESSAGE.equalsIgnoreCase(key)) {
                            error err = { message: jsonPayload[GIT_MESSAGE].toString() };
                            return err;
                        }
                    }

                    //If no error is returned, then check if the response contains the requested data.
                    string[] keySet = jsonPayload[GIT_DATA].getKeys();
                    string keyInData = keySet[INDEX_ZERO];
                    if (null == jsonPayload[GIT_DATA][keyInData][validateComponent]) {
                        error err = { message: validateComponent +
                            " is not available in the response" };
                        return err;
                    }
                    return jsonPayload;
                }
                error err => {
                    return err;
                }
            }
        }

        error err => {
            return err;
        }
    }
}

# Validate the REST HTTP response and return payload or error.
# + response - HTTP response object or HTTP Connector error
# + return - `json` payload of the response or Connector error
function getValidatedRestResponse(http:Response|error response) returns json|error {
    match response {
        http:Response httpResponse => {

            match httpResponse.getJsonPayload() {
                json jsonPayload => {
                    if (jsonPayload.message == null) {
                        return jsonPayload;
                    } else {
                        error err = { message: jsonPayload.message.toString() };
                        return err;
                    }
                }
                error err => {
                    return err;
                }
            }
        }

        error err => {
            return err;
        }
    }
}

# Get all columns of an organization project or repository project.
# + ownerType - Repository or Organization
# + stringQuery - GraphQL API query to get the project board columns
# + githubClient - GitHub client object
# + return - Column list object or Connector error
function getProjectColumns(string ownerType, string stringQuery, http:Client githubClient)
             returns ColumnList|error {

    endpoint http:Client gitHubEndpoint = githubClient;

    if (ownerType == "" || stringQuery == "") {
        return { message: "Owner type and query cannot be empty" };
    }

    http:Request request = new;
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
            //Set headers and payload to the request
            constructRequest(request, jsonQuery);
        }

        error err => {
            return err;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint->post("", request);

    //Check for empty payloads and errors
    json|error validatedResponse = getValidatedResponse(response, GIT_PROJECT);

    match validatedResponse {
        json jsonValidateResponse => {
            var projectColumnsJson = jsonValidateResponse[GIT_DATA][ownerType][GIT_PROJECT][GIT_COLUMNS];
            var columnList = jsonToColumnList(projectColumnsJson, ownerType, stringQuery);

            return columnList;
        }

        error err => {
            return err;
        }
    }
}

# Convert string representation of JSON object to JSON object.
# + source - String representation of the JSON object
# + return - Converted `json` object or Connector error
function stringToJson(string source) returns json|error {
    var parsedValue = internal:parseJson(source);
    match parsedValue {
        json jsonValue => {
            return jsonValue;
        }
        error parsedError => {
            return parsedError;
        }
    }
}