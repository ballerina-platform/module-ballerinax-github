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
import ballerina/java;
import ballerina/stringutils;

# Construct the request by adding the payload and authorization tokens.
# + request - HTTP request object
# + stringQuery - GraphQL API query
isolated function constructRequest(http:Request request, json stringQuery) {
    request.setJsonPayload(stringQuery);
}

# Validate the HTTP response and return payload or error.
# + response - HTTP response object or HTTP Connector error
# + validateComponent - Component to check in the response
# + return - `json` payload of the response or Connector error
isolated function getValidatedResponse(http:Response|http:PayloadType|error response, string validateComponent) returns @tainted json | error {

    if (response is http:Response) {
        var jsonPayload = response.getJsonPayload();
        if (jsonPayload is json) {
            string[] payLoadKeys = [];
            map<json> mapJsonPayload = <map<json>> jsonPayload;
            payLoadKeys = mapJsonPayload.keys();
            //Check all the keys in the payload to see if an error is returned.
            foreach var key in payLoadKeys {
                if (stringutils:equalsIgnoreCase(GIT_ERRORS, key)) {
                    var errorList = mapJsonPayload[GIT_ERRORS];
                    if (errorList is json[]) {
                        int i = 0;
                        foreach var singleError in errorList {
                            map<json> mapSingleerror = <map<json>> singleError;
                            string errorMessage = mapSingleerror[GIT_MESSAGE].toString();
                            error err = error(GITHUB_ERROR_CODE, message = errorMessage);
                            return err;
                        }
                    } else {
                        error err = error(GITHUB_ERROR_CODE,
                        message = "Error occurred while accessing the Json payload of the response.");
                        return err;
                    }
                }

                if (stringutils:equalsIgnoreCase(GIT_MESSAGE, key)) {

                    error err = error(GITHUB_ERROR_CODE, message = mapJsonPayload[GIT_MESSAGE].toString());
                    return err;
                }
            }

            //If no error is returned, then check if the response contains the requested data.
            string[] keySet = [];
            var data = mapJsonPayload[GIT_DATA];
            if (data is map<json>) {
                keySet = data.keys();
            }
            map<json> mapJsondata = <map<json>> data;
            string keyInData = keySet[INDEX_ZERO];
            map<json> output = <map<json>> mapJsondata[keyInData];
            if (output[validateComponent] == null) {
                error err = error(GITHUB_ERROR_CODE,
                message =  validateComponent + " is not available in the response");
                return err;
            }
            return jsonPayload;
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
isolated function getValidatedRestResponse(http:Response|http:PayloadType|error response) returns json | error {
    if (response is http:Response) {
        var payload = response.getJsonPayload();
        if (payload is json) {
            map<json> mapPayload = <map<json>> payload;
            if (mapPayload["message"] == null) {
                return <@untainted>payload;
            } else {
                error err = error(GITHUB_ERROR_CODE, message = mapPayload["message"].toString());
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
function getProjectColumns(string ownerType, string stringQuery, http:Client githubClient, string accessToken) returns
@tainted ColumnList | error {

    http:Client gitHubEndpoint = githubClient;

    if (ownerType == "" || stringQuery == "") {
        error err = error(GITHUB_ERROR_CODE, message = "Owner type and query cannot be empty");
        return err;
    }

    http:Request request = new;
    setHeader(request, accessToken);
    json jsonQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted>jsonQuery);

    // Make an HTTP POST request
    var response = gitHubEndpoint->post("", request);

    //Check for empty payloads and errors
    json jsonValidateResponse = check getValidatedResponse(response, GIT_PROJECT);
    map<json> mapJsonValidateResponse = <map<json>> jsonValidateResponse;
    map<json> data = <map<json>> mapJsonValidateResponse[GIT_DATA];
    map<json> mapJsonownerType = <map<json>> data[ownerType];
    map<json> gitPoject = <map<json>> mapJsonownerType[GIT_PROJECT];
    json projectColumnsJson = <map<json>> gitPoject[GIT_COLUMNS];
    return jsonToColumnList(projectColumnsJson, ownerType, stringQuery);
}

isolated function setHeader(http:Request request, string accessToken){
    request.setHeader("Authorization", "token " + accessToken);
}

# Convert string representation of JSON object to JSON object.
# + src - String representation of the JSON object
# + return - Converted `json` object or Connector error
isolated function stringToJson(string src) returns json | error {
    return src.fromJsonString();
}

# Split the given string using the given delimeter and return the string component of the given index.
# + receiver - The string to be split
# + delimeter - Delimeter used to split the string
# + index - Index of the string component which should be returned
# + return - String component
isolated function split(string receiver, string delimeter, int index) returns string {
    string[] resultArray = stringutils:split(receiver, delimeter);
    return resultArray[index];
}

function java_split(handle receiver, handle delimeter) returns handle = @java:Method {
    name: "split",
    'class: "java.lang.String"
} external;

