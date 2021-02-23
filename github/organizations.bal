// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

isolated function getOrganization(string organizationName, string accessToken, http:Client graphQlClient) returns Organization|error {
    string stringQuery = getFormulatedStringQueryForGetAnOrganization(organizationName);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    var response = graphQlClient->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json validatedResponse = check getValidatedResponse(response);

    if (validatedResponse is map<json>) {
        var gitData = validatedResponse[GIT_DATA];
        if(gitData is map<json>){
            var org = gitData[GIT_ORGANIZATION];
            Organization organization = check org.cloneWithType(Organization);
            return organization;
        }

    }
    error err = error(GITHUB_ERROR_CODE, message = "Error parsing user project response");
    return err;
}

isolated function getOrganizationOwnerId(string organizationName, string accessToken, http:Client graphQlClient) returns string|error {
    string stringQuery = getFormulatedStringQueryForGetOrganizationOwnerId(organizationName);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    var response = graphQlClient->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json validatedResponse = check getValidatedResponse(response);

    if (validatedResponse is map<json>) {
        var gitData = validatedResponse[GIT_DATA];
        if(gitData is map<json>){
            var org = gitData[GIT_ORGANIZATION];
            if(org is map<json>){
                json orgOwnerId = org[GIT_ID];
                return orgOwnerId.toBalString();
            }
        }

    }
    error err = error(GITHUB_ERROR_CODE, message = "Error parsing org response");
    return err;
}

isolated function getUserOrganizationList(string username, int perPageCount, string accessToken, http:Client graphQlClient, string? nextPageCursor=()) returns OrganizationList|error {
    string stringQuery = getFormulatedStringQueryForGetUserOrganizationList(username, perPageCount, nextPageCursor);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    var response = graphQlClient->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json validatedResponse = check getValidatedResponse(response);

    if (validatedResponse is map<json>) {
        var gitData = validatedResponse[GIT_DATA];
        if(gitData is map<json>){
            var user = gitData[GIT_USER];
            if(user is map<json>){
                var organizations = user[GIT_ORGANIZATIONS];
                OrganizationList organizationList = check organizations.cloneWithType(OrganizationList);
                return organizationList;
            }
        }

    }
    error err = error(GITHUB_ERROR_CODE, message = "Error parsing user project response");
    return err;
}

isolated function getOrganizationMemberList(string organizationName, int perPageCount, string accessToken, http:Client graphQlClient, string? nextPageCursor=()) returns UserList|error {
    string stringQuery = getFormulatedStringQueryForGetOrganizationMemberList(organizationName, perPageCount, nextPageCursor);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    var response = graphQlClient->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json validatedResponse = check getValidatedResponse(response);

    if (validatedResponse is map<json>) {
        var gitData = validatedResponse[GIT_DATA];
        if(gitData is map<json>){
            var org = gitData[GIT_ORGANIZATION];
            if(org is map<json>){
                var members = org[GIT_MEMBERS_WITH_ROLE];
                UserList userList = check members.cloneWithType(UserList);
                return userList;
            }
        }

    }
    error err = error(GITHUB_ERROR_CODE, message = "Error parsing user project response");
    return err;
}
