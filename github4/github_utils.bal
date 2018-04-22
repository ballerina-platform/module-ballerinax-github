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
import ballerina/util;

documentation { Construct the request by adding the payload and authorization tokens
    P{{request}} - HTTP request object
    P{{stringQuery}} - GraphQL API query
}
function constructRequest (http:Request request, json stringQuery) {
    request.setJsonPayload(stringQuery);
}

documentation { Validate the HTTP response and return payload or error
    P{{response}} - HTTP response object or HTTP connector error object
    P{{validateComponent}} - Component to check in the response
    R{{}} - JSON payload of the response
    R{{}} - Connector error
}
function getValidatedResponse (http:Response|http:HttpConnectorError response, string validateComponent)
                                                                                    returns json|GitClientError {

    match response {
        http:Response gitResponse => {

            var responsePayload = gitResponse.getJsonPayload();

            match responsePayload {
                json jsonPayload => {
                    string[] payLoadKeys = jsonPayload.getKeys();
                    //Check all the keys in the payload to see if an error object is returned.
                    foreach key in payLoadKeys {
                        if (GIT_ERRORS.equalsIgnoreCase(key)) {
                            string errors;
                            var errorList = check <json[]>jsonPayload[GIT_ERRORS];
                            foreach i, singleError in errorList {
                                string errorMessage = singleError[GIT_MESSAGE].toString();
                                errors += errorMessage;
                                if (i+1 != lengthof errorList) {
                                    errors += ",";
                                }
                            }
                            GitClientError gitClientError = {message:errors};
                            return gitClientError;
                        }

                        if (GIT_MESSAGE.equalsIgnoreCase(key)) {
                            GitClientError gitClientError = {message:jsonPayload[GIT_MESSAGE].toString()};
                            return gitClientError;
                        }
                    }

                    //If no error object is returned, then check if the response contains the requested data.
                    string[] keySet = jsonPayload[GIT_DATA].getKeys();
                    string keyInData = keySet[INDEX_ZERO];
                    if (null == jsonPayload[GIT_DATA][keyInData][validateComponent]) {
                        GitClientError gitClientError = {message:validateComponent + " is not available in the response"};
                        return gitClientError;
                    }
                    return jsonPayload;
                }
                http:PayloadError payloadError => {
                    GitClientError gitClientError = {message:payloadError.message, cause:payloadError.cause};
                    return gitClientError;
                }
            }
        }

        http:HttpConnectorError httpError => {
            GitClientError gitClientError = {message:httpError.message, cause:httpError.cause};
            return gitClientError;
        }
    }
}

documentation { Validate the REST HTTP response and return payload or error
    P{{response}} - HTTP response object or HTTP connector error object
    R{{}} - JSON payload of the response
    R{{}} - Connector error
}
function getValidatedRestResponse (http:Response|http:HttpConnectorError response) returns json|GitClientError {
    match response {
        http:Response httpResponse => {

            match httpResponse.getJsonPayload() {
                json jsonPayload => {
                    if (jsonPayload.message == null) {
                        return jsonPayload;
                    } else {
                        GitClientError gitClientError = {message:jsonPayload.message.toString()};
                        return gitClientError;
                    }
                }
                http:PayloadError payloadError => {
                    GitClientError connectorError = {message:payloadError.message, cause:payloadError.cause};
                    return connectorError;
                }
            }
        }

        http:HttpConnectorError httpError => {
            GitClientError clientError = {message:httpError.message, cause:httpError.cause};
            return clientError;
        }
    }
}

documentation { Get all columns of an organization project or repository project
    P{{ownerType}} - Repository or Organization
    P{{stringQuery}} - GraphQL API query to get the project board columns
    P{{githubClient}} - GitHub client object
    R{{}} - Column list object
    R{{}} - Connector error
}
function getProjectColumns (string ownerType, string stringQuery, http:Client githubClient)
                                                                            returns ColumnList|GitClientError {

    endpoint http:Client gitHubEndpoint = githubClient;

    GitClientError clientError = {};

    if (ownerType == "" || stringQuery == "") {
        return {message:"Owner type and query cannot be empty"};
    }

    http:Request request = new;
    var convertedQuery = stringToJson(stringQuery);
    match convertedQuery {
        json jsonQuery => {
        //Set headers and payload to the request
            constructRequest(request, jsonQuery);
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint -> post("", request = request);

    //Check for empty payloads and errors
    json|GitClientError validatedResponse = getValidatedResponse(response, GIT_PROJECT);

    match validatedResponse {
        json jsonValidateResponse => {
            var projectColumnsJson = jsonValidateResponse[GIT_DATA][ownerType][GIT_PROJECT][GIT_COLUMNS];
            var columnList = jsonToColumnList(projectColumnsJson, ownerType, stringQuery);

            return columnList;
        }

        GitClientError gitClientError => {
            return gitClientError;
        }
    }
}

documentation { Convert string representation of json object to json object
    P{{source}} - String representation of the json object
    R{{}} - Converted JSON object
    R{{}} - Connector error
}
function stringToJson (string source) returns json|GitClientError {
    var parsedValue = internal:parseJson(source);
    match parsedValue {
        json jsonValue => {
            return jsonValue;
        }
        error parsedError => {
            GitClientError clientError = {message:parsedError.message, cause:parsedError.cause};
            return clientError;
        }
    }
}