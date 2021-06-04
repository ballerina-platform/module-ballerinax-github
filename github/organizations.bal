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

isolated function getOrganization(string organizationName, string accessToken, http:Client graphQlClient) 
                                  returns @tainted Organization|error {
    string stringQuery = getFormulatedStringQueryForGetAnOrganization(organizationName);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);

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
    error err = error(GITHUB_ERROR_CODE+" Error parsing organization response", message = "Error parsing organization response");
    return err;
}

isolated function getOrganizationOwnerId(string organizationName, string accessToken, http:Client graphQlClient) 
                                         returns @tainted string|error {
    string stringQuery = getFormulatedStringQueryForGetOrganizationOwnerId(organizationName);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);

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
    error err = error(GITHUB_ERROR_CODE+" Error parsing organization response", message = "Error parsing organization response");
    return err;
}

isolated function getUserOrganizationList(string username, int perPageCount, string accessToken, 
                                          http:Client graphQlClient, string? nextPageCursor=()) 
                                          returns @tainted OrganizationList|error {
    string stringQuery = getFormulatedStringQueryForGetUserOrganizationList(username, perPageCount, nextPageCursor);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json validatedResponse = check getValidatedResponse(response);

    if (validatedResponse is map<json>) {
        var gitData = validatedResponse[GIT_DATA];
        if(gitData is map<json>){
            var user = gitData[GIT_USER];
            if(user is map<json>){
                var organizations = user[GIT_ORGANIZATIONS];
                OrganizationListPayload organizationListResponse = check organizations.cloneWithType(OrganizationListPayload);
                OrganizationList organizationList = {
                    organizations: organizationListResponse.nodes,
                    pageInfo: organizationListResponse.pageInfo,
                    totalCount: organizationListResponse.totalCount
                };
                return organizationList;
            }
        }

    }
    error err = error(GITHUB_ERROR_CODE+ " Error parsing organization users response", message = "Error parsing organization users response");
    return err;
}

isolated function getOrganizationMemberList(string organizationName, int perPageCount, string accessToken, 
                                            http:Client graphQlClient, string? nextPageCursor=()) 
                                            returns @tainted UserList|error {
    string stringQuery = getFormulatedStringQueryForGetOrganizationMemberList(organizationName, perPageCount, 
                                                                              nextPageCursor);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);

    //Check for empty payloads and errors
    json validatedResponse = check getValidatedResponse(response);

    if (validatedResponse is map<json>) {
        var gitData = validatedResponse[GIT_DATA];
        if(gitData is map<json>){
            var org = gitData[GIT_ORGANIZATION];
            if(org is map<json>){
                var members = org[GIT_MEMBERS_WITH_ROLE];
                UserListPayload userListResponse = check members.cloneWithType(UserListPayload);
                UserList userList = {
                    users: userListResponse.nodes,
                    pageInfo: userListResponse.pageInfo,
                    totalCount: userListResponse.totalCount
                };
                return userList;
            }
        }

    }
    error err = error(GITHUB_ERROR_CODE+ " Error organization user response", message = "Error organization user response");
    return err;
}
