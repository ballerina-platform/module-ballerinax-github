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

// mutation is in preview state
isolated function createLabel(CreateLabelInput createLabelInput, string accessToken, http:Client graphQlClient) 
                              returns @tainted error? {
    string stringQuery = getFormulatedStringQueryForCreateLabel(createLabelInput);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);

    _ = check getValidatedResponse(response);
}

isolated function getRepositoryLabel(string repositoryOwnerName, string repositoryName, string labelName, 
                                     string accessToken, http:Client graphQlClient) returns @tainted Label|error {
    string stringQuery = getFormulatedStringQueryForGetLabel(repositoryOwnerName, repositoryName, labelName);
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
            var viewer = gitData[GIT_REPOSITORY];
            if (viewer is map<json>) {
                var label = viewer[GIT_LABEL];
                if (label is ()) {
                    error err = error(GITHUB_ERROR_CODE+string `: No such label '${labelName}' exists.`, message = string `: No such label '${labelName}' exists.`);
                    return err;
                }
                Label labelObj = check label.cloneWithType(Label);
                return labelObj;
            }
        }
    }
    error err = error(GITHUB_ERROR_CODE+ " Error parsing git label response", message = "Error parsing git label response");
    return err;
}

isolated function getLabelsInIssue(string repositoryOwnerName, string repositoryName, int issueNumber, 
                                   int perPageCount, string accessToken, http:Client graphQlClient, 
                                   string? nextPageToken=()) returns @tainted LabelList|error {
    string stringQuery = getFormulatedStringQueryForGetAllLabelsForAIssue(repositoryOwnerName, repositoryName, 
                                                                          issueNumber, perPageCount, nextPageToken);
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
            var viewer = gitData[GIT_REPOSITORY];
            if (viewer is map<json>) {
                var issue = viewer[GIT_ISSUE];
                if(issue is map<json>){
                    var labels = issue[GIT_LABELS];
                    if(labels is map<json>){
                        LabelListPayload labelListResponse = check labels.cloneWithType(LabelListPayload);
                        LabelList labelList = {
                            labels: labelListResponse.nodes,
                            pageInfo: labelListResponse.pageInfo,
                            totalCount: labelListResponse.totalCount
                        };
                        return labelList;
                    }
                }
            }
        }
    }
    error err = error(GITHUB_ERROR_CODE+ "Error parsing git issue label list response", message = "Error parsing git issue label list response");
    return err;
}

isolated function addIssueLabels(AddIssueLabelsInput addIssueLabelsInput, string accessToken, 
                                       http:Client graphQlClient) returns @tainted LabelList|error {

    Issue issue = check getRepositoryIssue(addIssueLabelsInput.repositoryOwnerName, addIssueLabelsInput.repositoryName, 
                           addIssueLabelsInput.issueNumber, accessToken, graphQlClient);

    string[] labelIds = [];
    foreach string labelName in addIssueLabelsInput.labelNames {
        Label label = check getRepositoryLabel(addIssueLabelsInput.repositoryOwnerName, addIssueLabelsInput.repositoryName, labelName, accessToken, graphQlClient);
        labelIds.push(label.id);
    }
    
    AddLabelsToLabelableInput addLabelsToLabelableInput = {
        labelableId: issue.id,
        labelIds: labelIds
    };

    if (!(addIssueLabelsInput?.clientMutationId is ())) { 
        addLabelsToLabelableInput["clientMutationId"] = <string>addIssueLabelsInput?.clientMutationId;
    }

    string stringQuery = getFormulatedStringQueryForAddLabelsToLabelable(addLabelsToLabelableInput);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);

    json validatedResponse = check getValidatedResponse(response);

    if (validatedResponse is map<json>) {
        var gitData = validatedResponse[GIT_DATA];
        if (gitData is map<json>) {
            var addLableToLabelable = gitData[GIT_ADD_LABLE_TO_LABELABLE];
            if (addLableToLabelable is map<json>) {
                var labelable = addLableToLabelable[GIT_LABELABLE];
                if(labelable is map<json>){
                    var labels = labelable[GIT_LABELS];
                    if(labels is map<json>){
                        LabelListPayload labelListResponse = check labels.cloneWithType(LabelListPayload);
                        LabelList labelList = {
                            labels: labelListResponse.nodes,
                            pageInfo: labelListResponse.pageInfo,
                            totalCount: labelListResponse.totalCount
                        };
                        return labelList;
                    }
                }
            }
        }
    }

    error err = error(GITHUB_ERROR_CODE+ " Error parsing git label list response", message = "Error parsing git label list response");
    return err;
}

isolated function removeLabelFromLabelable(RemoveIssueLabelInput removeIssueLabelInput, 
                                           string accessToken, http:Client graphQlClient) returns @tainted error? {

    Issue issue = check getRepositoryIssue(removeIssueLabelInput.repositoryOwnerName, removeIssueLabelInput.repositoryName, 
                           removeIssueLabelInput.issueNumber, accessToken, graphQlClient);    

    string[] labelIds = [];
    foreach string labelName in removeIssueLabelInput.labelNames {
        Label label = check getRepositoryLabel(removeIssueLabelInput.repositoryOwnerName, removeIssueLabelInput.repositoryName, labelName, accessToken, graphQlClient);
        labelIds.push(label.id);
    }                                                                  

    RemoveLabelsFromLabelableInput removeLabelsFromLabelable = {
        labelableId: issue.id,
        labelIds: labelIds
    };

    if (!(removeIssueLabelInput?.clientMutationId is ())) { 
        removeLabelsFromLabelable["clientMutationId"] = <string>removeIssueLabelInput?.clientMutationId;
    }

    string stringQuery = getFormulatedStringQueryForRemoveLabelsFromLabelable(removeLabelsFromLabelable);
    http:Request request = new;
    setHeader(request, accessToken);
    json convertedQuery = check stringToJson(stringQuery);
    //Set headers and payload to the request
    constructRequest(request, <@untainted> convertedQuery);

    http:Response response = check graphQlClient->post(EMPTY_STRING, request);

    _ = check getValidatedResponse(response);

}
