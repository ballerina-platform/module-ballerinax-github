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
                                returns @tainted Organization|Error {
    string stringQuery = getFormulatedStringQueryForGetAnOrganization(organizationName);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json org = graphQlData.get(GIT_ORGANIZATION);
        if (org is map<json>) {
            Organization|error organization = org.cloneWithType(Organization);
            return organization is Organization ? organization : error ClientError("GitHub Client Error", organization);
        }
        return error ClientError("GitHub Client Error", body = org);
    }
    return graphQlData;
}

isolated function getUserOrganizationList(string username, int perPageCount, string accessToken,
                                        http:Client graphQlClient, string? nextPageCursor = ())
                                        returns @tainted OrganizationList|Error {
    string stringQuery = getFormulatedStringQueryForGetUserOrganizationList(username, perPageCount, nextPageCursor);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json user = graphQlData.get(GIT_USER);
        if (user is map<json>) {
            json organizations = user.get(GIT_ORGANIZATIONS);
            if (organizations is map<json>) {
                OrganizationListPayload|error orgListResponse = organizations.cloneWithType(OrganizationListPayload);
                if orgListResponse is OrganizationListPayload {
                    OrganizationList organizationList = {
                        organizations: orgListResponse.nodes,
                        pageInfo: orgListResponse.pageInfo,
                        totalCount: orgListResponse.totalCount
                    };
                    return organizationList;
                }
                return error ClientError("GitHub Client Error", orgListResponse);
            }
            return error ClientError("GitHub Client Error", body = organizations);
        }
        return error ClientError("GitHub Client Error", body = user);
    }
    return graphQlData;
}

isolated function getOrganizationMembers(string organizationName, int perPageCount, string accessToken,
                                            http:Client graphQlClient, string? nextPageCursor = ())
                                            returns @tainted UserList|Error {
    string stringQuery = getFormulatedStringQueryForGetOrganizationMemberList(organizationName, perPageCount,
                                                                            nextPageCursor);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json org = graphQlData.get(GIT_ORGANIZATION);
        if (org is map<json>) {
            json members = org.get(GIT_MEMBERS_WITH_ROLE);
            if (members is map<json>) {
                UserListPayload|error userListResponse = members.cloneWithType(UserListPayload);
                if userListResponse is UserListPayload {
                    UserList userList = {
                        users: userListResponse.nodes,
                        pageInfo: userListResponse.pageInfo,
                        totalCount: userListResponse.totalCount
                    };
                    return userList;
                }
                return error ClientError("GitHub Client Error", userListResponse);
            }
            return error ClientError("GitHub Client Error", body = members);
        }
        return error ClientError("GitHub Client Error", body = org);
    }
    return graphQlData;
}
