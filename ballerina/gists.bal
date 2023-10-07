// Copyright (c) 2023, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

isolated function starGist(StarGistInput starGistInput, string accessToken, http:Client 
        graphQlClient) returns Error? {
    string gistId = check getGistId(starGistInput.gistOwnerName, starGistInput.gistName,
                accessToken, graphQlClient);

    AddStarInput addStarInput = {
        starrableId: gistId
    };

    if !(starGistInput?.clientMutationId is ()) {
        addStarInput["clientMutationId"] = <string>starGistInput?.clientMutationId;
    }

    string stringQuery = getFormulatedStringQueryForAddStar(addStarInput);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);
    if graphQlData is Error {
        return graphQlData;
    }
    return;
}

isolated function unstarGist(UnstarGistInput unstarGistInput, string accessToken, http:Client 
        graphQlClient) returns Error? {
    string gistId = check getGistId(unstarGistInput.gistOwnerName, unstarGistInput.gistName, 
                accessToken, graphQlClient);

    RemoveStarInput removeStarInput = {
        starrableId: gistId
    };

    if !(unstarGistInput?.clientMutationId is ()) {
        removeStarInput["clientMutationId"] = <string>unstarGistInput?.clientMutationId;
    }

    string stringQuery = getFormulatedStringQueryForRemoveStar(removeStarInput);
    map<json>|Error graphQlData = getGraphQlData(graphQlClient, accessToken, stringQuery);
    if graphQlData is Error {
        return graphQlData;
    }
    return;
}
