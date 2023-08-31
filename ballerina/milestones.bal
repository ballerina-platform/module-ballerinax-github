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

isolated function getMilestones(string repositoryOwnerName, string repositoryName, int perPageCount, string accessToken,
        http:Client graphQlClient, string? nextPageCursor = ()) returns MilestoneList|Error {
    string stringQuery = getFormulatedStringQueryForGetMilestones(repositoryOwnerName, repositoryName,
            perPageCount, nextPageCursor);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repository = graphQlData.get(GIT_REPOSITORY);
        if repository is map<json> {
            json milestones = repository.get(GIT_MILESTONES);
            if milestones is map<json> {
                MilestoneListPayload|error milestoneListResponse = milestones.cloneWithType(MilestoneListPayload);
                if milestoneListResponse is MilestoneListPayload {
                    MilestoneList milestoneList = {
                        milestones: milestoneListResponse.nodes,
                        pageInfo: milestoneListResponse.pageInfo,
                        totalCount: milestoneListResponse.totalCount
                    };
                    return milestoneList;
                }
                return error ClientError("GitHub Client Error", milestoneListResponse);
            }
            return error ClientError("GitHub Client Error", body = milestones);
        }
        return error ClientError("GitHub Client Error", body = repository);
    }
    return graphQlData;
}

isolated function getMilestone(string repositoryOwnerName, string repositoryName, int milestoneNumber,
        string accessToken, http:Client graphQlClient) returns Milestone|Error {
    string stringQuery = getFormulatedStringQueryForGetAMilestone(repositoryOwnerName, repositoryName, milestoneNumber);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repository = graphQlData.get(GIT_REPOSITORY);
        if repository is map<json> {
            json milestone = repository.get(GIT_MILESTONE);
            if milestone is map<json> {
                Milestone|error milestoneObj = milestone.cloneWithType(Milestone);
                return milestoneObj is Milestone ? milestoneObj : error ClientError("GitHub Client Error", milestoneObj);
            }
            return error ClientError("GitHub Client Error", body = milestone);
        }
        return error ClientError("GitHub Client Error", body = repository);
    }
    return graphQlData;
}
