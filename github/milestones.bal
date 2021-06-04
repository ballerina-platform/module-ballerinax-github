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

isolated function getRepositoryMilestoneList(string repositoryOwnerName, string repositoryName, int perPageCount, 
                                             string accessToken, http:Client graphQlClient, string? nextPageCursor=()) 
                                             returns @tainted MilestoneList|error {
    string stringQuery = getFormulatedStringQueryForGetMilestoneListOfARepository(repositoryOwnerName, repositoryName,
                                                                                  perPageCount, nextPageCursor);
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
        if (gitData is map<json>) {
            var repository = gitData[GIT_REPOSITORY];
            if(repository is map<json>){
                var milestones = repository[GIT_MILESTONES];
                MilestoneListPayload|error milestoneListResponse = milestones.cloneWithType(MilestoneListPayload);
                
                if(milestoneListResponse is error){
                    return error(GITHUB_ERROR_CODE+"Error parsing milestone list response", message = "Error parsing milestone list response");
                }else {
                    MilestoneList milestoneList = {
                        milestones: milestoneListResponse.nodes,
                        pageInfo: milestoneListResponse.pageInfo,
                        totalCount: milestoneListResponse.totalCount
                    };
                    return milestoneList;
                }
            }

        }
    }
    error err = error(GITHUB_ERROR_CODE+ " Error parsing milestone list response", message = "Error parsing milestone list response");
    return err;
}

isolated function getRepositoryMilestone(string repositoryOwnerName, string repositoryName, int milestoneNumber, 
                                         string accessToken, http:Client graphQlClient) returns @tainted 
                                         Milestone|error {
    string stringQuery = getFormulatedStringQueryForGetAMilestone(repositoryOwnerName, repositoryName, milestoneNumber);
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
        if (gitData is map<json>) {
            var repository = gitData[GIT_REPOSITORY];
            if(repository is map<json>){
                var milestone = repository[GIT_MILESTONE];
                if (milestone is ()) {
                    error err = error(GITHUB_ERROR_CODE+string `: Could not resolve to a milestone with the number ${milestoneNumber}.`, message = string `: Could not resolve to a milestone with the number ${milestoneNumber}.`);
                    return err;
                }
                Milestone milestoneObj = check milestone.cloneWithType(Milestone);
                return milestoneObj;
            }

        }
    }
    error err = error(GITHUB_ERROR_CODE+ " Error parsing git repository milestone response", message = "Error parsing git repository milestone response");
    return err;
}
