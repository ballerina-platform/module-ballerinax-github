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

import ballerina/mime;
import ballerina/http;
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
    GitClientError clientError = {};
    json responsePayload;

    match response {
        http:Response gitResponse => {
            try {
                var jsonPayload = gitResponse.getJsonPayload();

                match jsonPayload {
                    json jsonData => {
                        responsePayload = jsonData;
                    }
                    http:PayloadError payloadError => {
                        clientError = {message:payloadError.message};
                        return clientError;
                    }
                }
                string[] payLoadKeys = responsePayload.getKeys() ?: [];
                //Check all the keys in the payload to see if an error object is returned.
                foreach key in payLoadKeys {
                    if (GIT_ERRORS.equalsIgnoreCase(key)) {
                        string errors;
                        var errorList = check <json[]>responsePayload[GIT_ERRORS];
                        foreach i, singleError in errorList {
                            string errorMessage = singleError[GIT_MESSAGE].toString() ?: "Payload has errors";
                            errors += errorMessage;
                            if (i+1 != lengthof errorList) {
                                errors += ",";
                            }
                        }
                        clientError = {message:errors, statusCode:gitResponse.statusCode,
                                             reasonPhrase:gitResponse.reasonPhrase, server:gitResponse.server};
                        return clientError;
                    }
                }

                //If no error object is returned, then check if the response contains the requested data.
                string[] keySet = responsePayload[GIT_DATA].getKeys() ?: [];
                string keyInData = keySet[GIT_INDEX_ZERO];
                if (null == responsePayload[GIT_DATA][keyInData][validateComponent]) {
                    responsePayload = null;
                    clientError = {message:GIT_ERROR_WHILE_RETRIEVING_DATA, statusCode:gitResponse.statusCode,
                                         reasonPhrase:gitResponse.reasonPhrase, server:gitResponse.server};
                    return clientError;
                }

            } catch (error e) {
                responsePayload = null;
                clientError = {message:GIT_ERROR_WHILE_RETRIEVING_PAYLOAD, statusCode:gitResponse.statusCode,
                                     reasonPhrase:gitResponse.reasonPhrase, server:gitResponse.server};
                return clientError;
            }
        }

        http:HttpConnectorError httpError => {
            clientError = {message:httpError.message, statusCode:httpError.statusCode};
            return clientError;
        }
    }

    return responsePayload;

}

documentation { Get all columns of an organization project or repository project
    P{{ownerType}} - Repository or Organization
    P{{gitQuery}} - GraphQL API query to get the project board columns
    P{{githubClient}} - GitHub client object
    R{{}} - Column list object
    R{{}} - Connector error
}
function getProjectColumns (string ownerType, string gitQuery, http:Client githubClient)
                                                                            returns ColumnList|GitClientError {

    endpoint http:Client gitHubEndpoint = githubClient;

    GitClientError clientError = {};

    if (ownerType == null || ownerType == "" || gitQuery == null || gitQuery == "") {
        clientError = {message:"Owner type and query cannot be null"};
        return clientError;
    }

    http:Request request = new;
    var convertedQuery = stringToJson(gitQuery);
    match convertedQuery {
        json jsonQuery => {
        //Set headers and payload to the request
            constructRequest(request, jsonQuery);
        }

        GitClientError gitConError => {
            return gitConError;
        }
    }

    // Make an HTTP POST request
    var response = gitHubEndpoint -> post("", request);

    //Check for empty payloads and errors
    json|GitClientError validatedResponse = getValidatedResponse(response, GIT_PROJECT);

    match validatedResponse {
        json jsonValidateResponse => {
            var projectColumnsJson = jsonValidateResponse[GIT_DATA][ownerType][GIT_PROJECT][GIT_COLUMNS];
            var columnList = jsonToColumnList(projectColumnsJson, ownerType, gitQuery);

            return columnList;
        }

        GitClientError gitConError => {
            return gitConError;
        }
    }
}

documentation { Convert string representation of json object to json object
    P{{source}} - String representation of the json object
    R{{}} - Converted JSON object
    R{{}} - Connector error
}
function stringToJson (string source) returns json|GitClientError {
    GitClientError clientError = {};
    var parsedValue = util:parseJson(source);
    match parsedValue {
        json jsonValue => {
            return jsonValue;
        }
        error parsedError => {
            clientError = {message:parsedError.message};
            return clientError;
        }
    }
}