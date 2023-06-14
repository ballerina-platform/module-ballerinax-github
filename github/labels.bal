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

isolated function getLabel(string repositoryOwnerName, string repositoryName, string labelName,
                                    string accessToken, http:Client graphQlClient) returns Label|Error {
    string stringQuery = getFormulatedStringQueryForGetLabel(repositoryOwnerName, repositoryName, labelName);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repository = graphQlData.get(GIT_REPOSITORY);
        if repository is map<json> {
            json label = repository.get(GIT_LABEL);
            if label is map<json> {
                Label|error labelObj = label.cloneWithType(Label);
                return labelObj is Label ? labelObj : error ClientError("GitHub Client Error", labelObj);
            }
            return error ClientError("GitHub Client Error", body = label);
        }
        return error ClientError("GitHub Client Error", body = repository);
    }
    return graphQlData;
}

isolated function getLabels(string repositoryOwnerName, string repositoryName, int issueNumber,
                                    int perPageCount, string accessToken, http:Client graphQlClient,
                                    string? nextPageToken = ()) returns LabelList|Error {
    string stringQuery = getFormulatedStringQueryForGetAllLabelsForAIssue(repositoryOwnerName, repositoryName,
            issueNumber, perPageCount, nextPageToken);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json repository = graphQlData.get(GIT_REPOSITORY);
        if repository is map<json> {
            json issue = repository.get(GIT_ISSUE);
            if issue is map<json> {
                json labels = issue.get(GIT_LABELS);
                if labels is map<json> {
                    LabelListPayload|error labelListResponse = labels.cloneWithType(LabelListPayload);
                    if labelListResponse is LabelListPayload {
                        LabelList labelList = {
                            labels: labelListResponse.nodes,
                            pageInfo: labelListResponse.pageInfo,
                            totalCount: labelListResponse.totalCount
                        };
                        return labelList;
                    }
                    return error ClientError("GitHub Client Error", labelListResponse);
                }
                return error ClientError("GitHub Client Error", body = labels);
            }
            return error ClientError("GitHub Client Error", body = issue);
        }
        return error ClientError("GitHub Client Error", body = repository);
    }
    return graphQlData;
}

isolated function addLabels(AddLabelsInput addLabelsInput, string accessToken,
                                        http:Client graphQlClient) returns LabelList|Error {

    Issue issue = check getIssue(addLabelsInput.repositoryOwnerName, addLabelsInput.repositoryName,
                            addLabelsInput.issueNumber, accessToken, graphQlClient);

    string[] labelIds = [];
    foreach string labelName in addLabelsInput.labelNames {
        Label label = check getLabel(addLabelsInput.repositoryOwnerName, addLabelsInput.repositoryName, 
                labelName, accessToken, graphQlClient);
        labelIds.push(label.id);
    }

    AddLabelsToLabelableInput addLabelsToLabelableInput = {
        labelableId: issue.id,
        labelIds: labelIds
    };

    if !(addLabelsInput?.clientMutationId is ()) {
        addLabelsToLabelableInput["clientMutationId"] = <string>addLabelsInput?.clientMutationId;
    }

    string stringQuery = getFormulatedStringQueryForAddLabelsToLabelable(addLabelsToLabelableInput);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);

    if graphQlData is map<json> {
        json addLableToLabelable = graphQlData.get(GIT_ADD_LABLE_TO_LABELABLE);
        if addLableToLabelable is map<json> {
            json labelable = addLableToLabelable.get(GIT_LABELABLE);
            if labelable is map<json> {
                json labels = labelable.get(GIT_LABELS);
                if labels is map<json> {
                    LabelListPayload|error labelListResponse = labels.cloneWithType(LabelListPayload);
                    if labelListResponse is LabelListPayload {
                        LabelList labelList = {
                            labels: labelListResponse.nodes,
                            pageInfo: labelListResponse.pageInfo,
                            totalCount: labelListResponse.totalCount
                        };
                        return labelList;
                    }
                    return error ClientError("GitHub Client Error", labelListResponse);
                }
                return error ClientError("GitHub Client Error", body = labels);
            }
            return error ClientError("GitHub Client Error", body = labelable);
        }
        return error ClientError("GitHub Client Error", body = addLableToLabelable);
    }
    return graphQlData;
}

isolated function removeLabel(RemoveIssueLabelInput removeIssueLabelInput,
                                            string accessToken, http:Client graphQlClient) returns Error? {

    Issue issue = check getIssue(removeIssueLabelInput.repositoryOwnerName, removeIssueLabelInput.repositoryName,
                            removeIssueLabelInput.issueNumber, accessToken, graphQlClient);

    string[] labelIds = [];
    foreach string labelName in removeIssueLabelInput.labelNames {
        Label label = check getLabel(removeIssueLabelInput.repositoryOwnerName, removeIssueLabelInput.repositoryName,
                labelName, accessToken, graphQlClient);
        labelIds.push(label.id);
    }

    RemoveLabelsFromLabelableInput removeLabelsFromLabelable = {
        labelableId: issue.id,
        labelIds: labelIds
    };

    if !(removeIssueLabelInput?.clientMutationId is ()) {
        removeLabelsFromLabelable["clientMutationId"] = <string>removeIssueLabelInput?.clientMutationId;
    }

    string stringQuery = getFormulatedStringQueryForRemoveLabelsFromLabelable(removeLabelsFromLabelable);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);
    if graphQlData is Error {
        return graphQlData;
    }
    return;
}
