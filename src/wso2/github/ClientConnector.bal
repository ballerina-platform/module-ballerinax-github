package src.wso2.github;

import ballerina.net.http;
import src.wso2.github.graphqlQueries as gq;
//import src.wso2.github.structTemplates as st;

@Description {value: "GitHub client connector"}
@Param {value: "accessToken:Access token"}
public connector ClientConnector (string accessToken) {

    endpoint <http:HttpClient> gitHubEndpoint {
        create http:HttpClient("https://api.github.com/graphql", {} );
    }
    http:HttpConnectorError e;

    @Description{ value : "Get all projects of a repository"}
    @Param{ value : "owner: Owner of the repository"}
    @Param{ value : "repository: Name of the repository"}
    @Param{value: "state: State of the repository (open, closed, all)"}
    @Return { value:"Array of projects" }
    action getRepositoryProjects (string owner, string repository, string state) (Project[], http:HttpConnectorError ) {
        http:OutRequest request = {};
        http:InResponse response = {};

        json query = {"variables":{"owner":owner,"repository":repository,"state":state},
                         "query": gq:GET_REPOSITORY_PROJECTS};
        constructRequestHeaders(request, query, accessToken);

        response, e = gitHubEndpoint.post("", request);

        json jsonResponse =  response.getJsonPayload();

        Project[] projectArray= [];
        var githubProjectsJson, err = (json[])jsonResponse["data"]["repositoryOwner"]["repository"]["projects"]["edges"];

        int i = 0;
        foreach projectJson in githubProjectsJson {
            var projectObject, _ = <Project>projectJson["node"];

            projectArray[i] = projectObject;
            i = i + 1;
        }

        return projectArray, e;
    }

    @Description{ value : "Get all projects of an organization"}
    @Param{ value : "organzation: Github organization name"}
    @Param{value: "state: State of the repository (open, closed, all)"}
    @Return { value:"Array of projects" }
    action getOrganizationProjects (string organization, string state) (Project[], http:HttpConnectorError ) {
        http:OutRequest request = {};
        http:InResponse response = {};

        json query = {"variables":{"organization":organization,"state":state},"query": gq:GET_ORGANIZATION_PROJECTS};
        constructRequestHeaders(request, query, accessToken);
        response, e = gitHubEndpoint.post("", request);

        json jsonResponse =  response.getJsonPayload();

        Project[] projectArray= [];
        var githubProjectsJson, err = (json[])jsonResponse["data"]["organization"]["projects"]["edges"];
        int i = 0;
        foreach projectJson in githubProjectsJson {
            var projectObject, _ = <Project>projectJson["node"];

            projectArray[i] = projectObject;
            i = i + 1;
        }

        return projectArray, e;
    }

    @Description{ value : "Get a single project"}
    @Param{ value : "organzation: Github organization name"}
    @Param{value: "repository: Name of the repository"}
    @Return { value:"A project object" }
    action getProject (string owner, string repository, int projectNumber) (Project, http:HttpConnectorError ) {
        http:OutRequest request = {};
        http:InResponse response = {};

        json query = {"variables":{"owner":owner,"repository":repository,"number":projectNumber},
                         "query": gq:GET_PROJECT};
        constructRequestHeaders(request, query, accessToken);
        response, e = gitHubEndpoint.post("", request);

        json jsonResponse =  response.getJsonPayload();

        var githubProjectJson, err = (json)jsonResponse["data"]["repositoryOwner"]["repository"]["project"];
        var projectObject, _ = <Project>githubProjectJson;

        return projectObject, e;
    }
}

@Description {value:"Construct the request headers"}
@Param {value:"request: The http request object"}
@Param {value:"query: GraphQL API query"}
@Param {value:"accessToken: GitHub access token"}
function constructRequestHeaders (http:OutRequest request, json query, string accessToken) {
    request.addHeader("Authorization", "Bearer " + accessToken);
    request.setJsonPayload(query);

}


//*************************************************
//*************************************************
//  Struct Templates
//*************************************************
// #TODO Move these structs to another package once https://github.com/ballerina-lang/ballerina/issues/4736 is fixed.
public struct Project {
    string id;
    int databaseId;
    string name;
    string body;
    int number;
    string createdAt;
    string closed;
    string closedAt;
    string updatedAt;
    string resourcePath;
    string state;
    string url;
    boolean viewerCanUpdate;
    Creator creator;
    Owner owner;
}

public struct Creator {
    string login;
    string resourcePath;
    string url;
    string avatarUrl;
}

public struct Owner {
    string id;
    string projectsResourcePath;
    string projectsUrl;
    boolean viewerCanCreateProjects;
}

public struct Error {
    string message;
}
//*************************************************
// End of structs
//*************************************************

