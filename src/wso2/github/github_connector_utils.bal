package src.wso2.github;

import ballerina.net.http;

@Description {value:"Construct the request headers"}
@Param {value:"request: The http request object"}
@Param {value:"query: GraphQL API query"}
@Param {value:"accessToken: GitHub access token"}
function constructRequest (http:OutRequest request, json query, string accessToken) {
    gitAccessToken = accessToken;
    request.removeAllHeaders();
    request.addHeader("Authorization", "Bearer " + accessToken);
    request.setJsonPayload(query);

}

@Description {value:"Validate the http response"}
@Param {value:"http:InResponse: The http response object"}
@Param {value:"component:"}
@Return {value:"json: The JSON payload in the response"}
@Return {value:"GitConnectoError: GitConnectorError object"}
function validateResponse (http:InResponse response, string validateComponent) (json, GitConnectorError){
    GitConnectorError connectorError;
    json responsePayload;
    try {
        responsePayload = response.getJsonPayload();
        string[] payLoadKeys = responsePayload.getKeys();
        //Check all the keys in the payload to see if an error object is returned.
        foreach key in payLoadKeys {
            if (GIT_ERRORS.equalsIgnoreCase(key)){
                string[] errors = [];
                var errorList, _ = (json[])responsePayload[GIT_ERRORS];
                int i = 0;
                foreach singleError in errorList {
                    errors[i], _ = (string)singleError[GIT_MESSAGE];
                    i = i + 1;
                }
                connectorError = {message:errors, statusCode:response.statusCode, reasonPhrase:response.reasonPhrase, server:response.server};
                return null, connectorError;
            }
        }
        //If no error object is returned, then check if the response contains the requested data.
        string keyInData = responsePayload[GIT_DATA].getKeys()[GIT_INDEX_ZERO];
        if (null == responsePayload[GIT_DATA][keyInData][validateComponent]) {
            string[] errorMessage = [GIT_ERROR_WHILE_RETRIEVING_DATA];
            responsePayload = null;
            connectorError = {message:errorMessage, statusCode:response.statusCode, reasonPhrase:response.reasonPhrase, server:response.server};
        }


    } catch (error e) {
        string[] errorMessage = [GIT_ERROR_WHILE_RETRIEVING_PAYLOAD];
        responsePayload = null;
        connectorError = {message:errorMessage, statusCode:response.statusCode, reasonPhrase:response.reasonPhrase, server:response.server};
    }

    return responsePayload, connectorError;

}