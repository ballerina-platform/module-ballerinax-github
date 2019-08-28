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

import ballerina/http;
import ballerina/io;
import ballerinax/java;

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
function getValidatedResponse(http:Response | error response, string validateComponent) returns json | error {

    if (response is http:Response) {
        var jsonPayload = response.getJsonPayload();
        if (jsonPayload is map<json>) {
            string[] payLoadKeys = jsonPayload.keys();
            //Check all the keys in the payload to see if an error is returned.
            foreach var key in payLoadKeys {
                if (GIT_ERRORS == key) {
                    var errorList =json[].constructFrom( <json>jsonPayload[GIT_ERRORS]);
                    if (errorList is json[]) {
                        int i = 0;
                        foreach var singleError in errorList {
                            string errorMessage = "";
                            if (singleError is map<json>) {
                                errorMessage =singleError[GIT_MESSAGE].toString();
                            }
                            error err = error(GITHUB_ERROR_CODE, message = errorMessage);
                            return <@untainted>err;
                        }
                    } else {
                        error err = error(GITHUB_ERROR_CODE,
                        message = "Error occurred while accessing the Json payload of the response.");
                        return err;
                    }
                }

                if (GIT_MESSAGE == key) {
                    error err = error(GITHUB_ERROR_CODE, message =jsonPayload[GIT_MESSAGE].toString());
                    return <@untainted>err;
                }
            }

            //If no error is returned, then check if the response contains the requested data.
            json gitData = jsonPayload[GIT_DATA];
            string[] keySet;
            if (gitData is map<json>) {
                keySet = gitData.keys();

                string keyInData = keySet[INDEX_ZERO];
                json val = gitData[keyInData];
                if (val is map<json> && val[validateComponent] != null) {
                    return <@untainted>jsonPayload;
                }
            }
            error err = error(GITHUB_ERROR_CODE,
            message = validateComponent + " is not available in the response");
            return err;
        } else {
            error err = error(GITHUB_ERROR_CODE,
            message = "Entity body is not json compatible since the received content-type is : null");
            return err;
        }
    } else {
        error err = error(GITHUB_ERROR_CODE, message = "HTTP Connector Error");
        return err;
    }
}

# Validate the REST HTTP response and return payload or error.
# + response - HTTP response object or HTTP Connector error
# + return - `json` payload of the response or Connector error
function getValidatedRestResponse(http:Response | error response) returns json | error {
    if (response is http:Response) {
        var payload = response.getJsonPayload();
        if (payload is map<json>) {
            if (payload["message"] == null) {
                return <@untainted>payload;
            } else {
                error err = error(GITHUB_ERROR_CODE, message =payload["message"].toString());
                return <@untainted>err;
            }
        } else {
            error err = error(GITHUB_ERROR_CODE,
            message = "Entity body is not json compatible since the received content-type is : null");
            return err;
        }
    } else {
        error err = error(GITHUB_ERROR_CODE, message = "HTTP Connector Error");
        return err;
    }
}

# Get all columns of an organization project or repository project.
# + ownerType - Repository or Organization
# + stringQuery - GraphQL API query to get the project board columns
# + githubClient - GitHub client object
# + return - Column list object or Connector error
function getProjectColumns(string ownerType, string stringQuery, http:Client githubClient) returns ColumnList | error {

    http:Client gitHubEndpoint = githubClient;

    if (ownerType == "" || stringQuery == "") {
        error err = error(GITHUB_ERROR_CODE, message = "Owner type and query cannot be empty");
        return err;
    }

    http:Request request = new;
    json jsonQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted>jsonQuery);

    // Make an HTTP POST request
    var response = gitHubEndpoint->post("", request);

    //Check for empty payloads and errors
    json jsonValidateResponse = check getValidatedResponse(response, GIT_PROJECT);
    if (jsonValidateResponse is map<json>) {
        var gitdata = jsonValidateResponse[GIT_DATA];
        if (gitdata is map<json>) {
            var ownerTypeData = gitdata[ownerType];
            if (ownerTypeData is map<json>) {
                var gitProject = ownerTypeData[GIT_PROJECT];
                if (gitProject is map<json>) {
                    var projectColumnsJson = gitProject[GIT_COLUMNS];
                    var columnList = jsonToColumnList(projectColumnsJson, ownerType, stringQuery);
                    return columnList;
                }
            }
        }
    }

    error err = error(GITHUB_ERROR_CODE, message = "Error parsing github project columns");
    return err;
}

# Convert string representation of JSON object to JSON object.
# + src - String representation of the JSON object
# + return - Converted `json` object or Connector error
function stringToJson(string src) returns json | error {
    io:StringReader reader = new (src);
    return <@untainted>reader.readJson();
}

# Split the given string using the given delimeter and return the string component of the given index.
# + receiver - The string to be split
# + delimeter - Delimeter used to split the string
# + index - Index of the string component which should be returned
# + return - String component
function split(string receiver, string delimeter, int index) returns string {
    handle receiverHandle = java:fromString(receiver);
    handle delimeterHandle = java:fromString(delimeter);
    handle resultArray = java_split(receiverHandle, delimeterHandle);
    string result = java:getArrayElement(resultArray, index).toString();
    return result;
}
function java_split(handle receiver, handle delimeter) returns handle = @java:Method {
    name: "split",
    class: "java.lang.String"
} external;
