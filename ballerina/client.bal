// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.org).
//
// WSO2 LLC. licenses this file to you under the Apache License,
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

import ballerina/data.jsondata;
import ballerina/http;

# GitHub's v3 REST API.
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://api.github.com") returns error? {
        http:ClientConfiguration httpClientConfig = {auth: config.auth, httpVersion: config.httpVersion, http1Settings: config.http1Settings, http2Settings: config.http2Settings, timeout: config.timeout, forwarded: config.forwarded, followRedirects: config.followRedirects, poolConfig: config.poolConfig, cache: config.cache, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, cookieConfig: config.cookieConfig, responseLimits: config.responseLimits, secureSocket: config.secureSocket, proxy: config.proxy, socketConfig: config.socketConfig, validation: config.validation, laxDataBinding: config.laxDataBinding};
        self.clientEp = check new (serviceUrl, httpClientConfig);
    }

    # GitHub API Root
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get .(map<string|string[]> headers = {}) returns Root|error {
        string resourcePath = string `/`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List global security advisories
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get advisories(map<string|string[]> headers = {}, *SecurityAdvisoriesListGlobalAdvisoriesQueries queries) returns GlobalAdvisory[]|error {
        string resourcePath = string `/advisories`;
        map<Encoding> queryParamEncoding = {"cwes": {style: FORM, explode: true}, "affects": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queries, queryParamEncoding);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a global security advisory
    #
    # + ghsaId - The GHSA (GitHub Security Advisory) identifier of the advisory
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get advisories/[string ghsaId](map<string|string[]> headers = {}) returns GlobalAdvisory|error {
        string resourcePath = string `/advisories/${getEncodedUri(ghsaId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get the authenticated app
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get app(map<string|string[]> headers = {}) returns Integration|error {
        string resourcePath = string `/app`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a GitHub App from a manifest
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post app\-manifests/[string code]/conversions(map<string|string[]> headers = {}) returns ManifestConversions|error {
        string resourcePath = string `/app-manifests/${getEncodedUri(code)}/conversions`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a webhook configuration for an app
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get app/hook/config(map<string|string[]> headers = {}) returns WebhookConfig|error {
        string resourcePath = string `/app/hook/config`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a webhook configuration for an app
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch app/hook/config(HookConfigBody payload, map<string|string[]> headers = {}) returns WebhookConfig|error {
        string resourcePath = string `/app/hook/config`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List deliveries for an app webhook
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get app/hook/deliveries(map<string|string[]> headers = {}, *AppsListWebhookDeliveriesQueries queries) returns HookDeliveryItem[]|error {
        string resourcePath = string `/app/hook/deliveries`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a delivery for an app webhook
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get app/hook/deliveries/[int deliveryId](map<string|string[]> headers = {}) returns HookDelivery|error {
        string resourcePath = string `/app/hook/deliveries/${getEncodedUri(deliveryId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Redeliver a delivery for an app webhook
    #
    # + headers - Headers to be sent with the request 
    # + return - Accepted 
    resource isolated function post app/hook/deliveries/[int deliveryId]/attempts(map<string|string[]> headers = {}) returns record {}|error {
        string resourcePath = string `/app/hook/deliveries/${getEncodedUri(deliveryId)}/attempts`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List installation requests for the authenticated app
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - List of integration installation requests 
    resource isolated function get app/installation\-requests(map<string|string[]> headers = {}, *AppsListInstallationRequestsForAuthenticatedAppQueries queries) returns IntegrationInstallationRequest[]|error? {
        string resourcePath = string `/app/installation-requests`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List installations for the authenticated app
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - The permissions the installation has are included under the `permissions` key 
    resource isolated function get app/installations(map<string|string[]> headers = {}, *AppsListInstallationsQueries queries) returns Installation[]|error {
        string resourcePath = string `/app/installations`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an installation for the authenticated app
    #
    # + installationId - The unique identifier of the installation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get app/installations/[int installationId](map<string|string[]> headers = {}) returns Installation|error {
        string resourcePath = string `/app/installations/${getEncodedUri(installationId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete an installation for the authenticated app
    #
    # + installationId - The unique identifier of the installation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete app/installations/[int installationId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/app/installations/${getEncodedUri(installationId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Create an installation access token for an app
    #
    # + installationId - The unique identifier of the installation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post app/installations/[int installationId]/access_tokens(InstallationIdAccessTokensBody payload, map<string|string[]> headers = {}) returns InstallationToken|error {
        string resourcePath = string `/app/installations/${getEncodedUri(installationId)}/access_tokens`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Suspend an app installation
    #
    # + installationId - The unique identifier of the installation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put app/installations/[int installationId]/suspended(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/app/installations/${getEncodedUri(installationId)}/suspended`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Unsuspend an app installation
    #
    # + installationId - The unique identifier of the installation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete app/installations/[int installationId]/suspended(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/app/installations/${getEncodedUri(installationId)}/suspended`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Delete an app authorization
    #
    # + clientId - The client ID of the GitHub app
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete applications/[string clientId]/grant(ClientIdGrantBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/applications/${getEncodedUri(clientId)}/grant`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # Check a token
    #
    # + clientId - The client ID of the GitHub app
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post applications/[string clientId]/token(ClientIdTokenBody payload, map<string|string[]> headers = {}) returns Authorization|error {
        string resourcePath = string `/applications/${getEncodedUri(clientId)}/token`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete an app token
    #
    # + clientId - The client ID of the GitHub app
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete applications/[string clientId]/token(ClientIdGrantBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/applications/${getEncodedUri(clientId)}/token`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # Reset a token
    #
    # + clientId - The client ID of the GitHub app
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch applications/[string clientId]/token(ClientIdTokenBody payload, map<string|string[]> headers = {}) returns Authorization|error {
        string resourcePath = string `/applications/${getEncodedUri(clientId)}/token`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Create a scoped access token
    #
    # + clientId - The client ID of the GitHub app
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post applications/[string clientId]/token/scoped(TokenScopedBody payload, map<string|string[]> headers = {}) returns Authorization|error {
        string resourcePath = string `/applications/${getEncodedUri(clientId)}/token/scoped`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get an app
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get apps/[string appSlug](map<string|string[]> headers = {}) returns Integration|error {
        string resourcePath = string `/apps/${getEncodedUri(appSlug)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an assignment
    #
    # + assignmentId - The unique identifier of the classroom assignment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get assignments/[int assignmentId](map<string|string[]> headers = {}) returns ClassroomAssignment|error {
        string resourcePath = string `/assignments/${getEncodedUri(assignmentId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List accepted assignments for an assignment
    #
    # + assignmentId - The unique identifier of the classroom assignment
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get assignments/[int assignmentId]/accepted_assignments(map<string|string[]> headers = {}, *ClassroomListAcceptedAssigmentsForAnAssignmentQueries queries) returns ClassroomAcceptedAssignment[]|error {
        string resourcePath = string `/assignments/${getEncodedUri(assignmentId)}/accepted_assignments`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get assignment grades
    #
    # + assignmentId - The unique identifier of the classroom assignment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get assignments/[int assignmentId]/grades(map<string|string[]> headers = {}) returns ClassroomAssignmentGrade[]|error {
        string resourcePath = string `/assignments/${getEncodedUri(assignmentId)}/grades`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List classrooms
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get classrooms(map<string|string[]> headers = {}, *ClassroomListClassroomsQueries queries) returns SimpleClassroom[]|error {
        string resourcePath = string `/classrooms`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a classroom
    #
    # + classroomId - The unique identifier of the classroom
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get classrooms/[int classroomId](map<string|string[]> headers = {}) returns Classroom|error {
        string resourcePath = string `/classrooms/${getEncodedUri(classroomId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List assignments for a classroom
    #
    # + classroomId - The unique identifier of the classroom
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get classrooms/[int classroomId]/assignments(map<string|string[]> headers = {}, *ClassroomListAssignmentsForAClassroomQueries queries) returns SimpleClassroomAssignment[]|error {
        string resourcePath = string `/classrooms/${getEncodedUri(classroomId)}/assignments`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get all codes of conduct
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get codes_of_conduct(map<string|string[]> headers = {}) returns CodeOfConduct[]|error? {
        string resourcePath = string `/codes_of_conduct`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a code of conduct
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get codes_of_conduct/[string 'key](map<string|string[]> headers = {}) returns CodeOfConduct|error? {
        string resourcePath = string `/codes_of_conduct/${getEncodedUri('key)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get emojis
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get emojis(map<string|string[]> headers = {}) returns record {|string...;|}|error? {
        string resourcePath = string `/emojis`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List Dependabot alerts for an enterprise
    #
    # + enterprise - The slug version of the enterprise name. You can also substitute this value with the enterprise id
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get enterprises/[string enterprise]/dependabot/alerts(map<string|string[]> headers = {}, *DependabotListAlertsForEnterpriseQueries queries) returns DependabotAlertWithRepository[]|error? {
        string resourcePath = string `/enterprises/${getEncodedUri(enterprise)}/dependabot/alerts`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List secret scanning alerts for an enterprise
    #
    # + enterprise - The slug version of the enterprise name. You can also substitute this value with the enterprise id
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get enterprises/[string enterprise]/secret\-scanning/alerts(map<string|string[]> headers = {}, *SecretScanningListAlertsForEnterpriseQueries queries) returns OrganizationSecretScanningAlert[]|error {
        string resourcePath = string `/enterprises/${getEncodedUri(enterprise)}/secret-scanning/alerts`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List public events
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get events(map<string|string[]> headers = {}, *ActivityListPublicEventsQueries queries) returns Event[]|error? {
        string resourcePath = string `/events`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get feeds
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get feeds(map<string|string[]> headers = {}) returns Feed|error {
        string resourcePath = string `/feeds`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List gists for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get gists(map<string|string[]> headers = {}, *GistsListQueries queries) returns BaseGist[]|error? {
        string resourcePath = string `/gists`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a gist
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post gists(GistsBody payload, map<string|string[]> headers = {}) returns GistSimple|error? {
        string resourcePath = string `/gists`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List public gists
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get gists/'public(map<string|string[]> headers = {}, *GistsListPublicQueries queries) returns BaseGist[]|error? {
        string resourcePath = string `/gists/public`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List starred gists
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get gists/starred(map<string|string[]> headers = {}, *GistsListStarredQueries queries) returns BaseGist[]|error? {
        string resourcePath = string `/gists/starred`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a gist
    #
    # + gistId - The unique identifier of the gist
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get gists/[string gistId](map<string|string[]> headers = {}) returns GistSimple|error? {
        string resourcePath = string `/gists/${getEncodedUri(gistId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a gist
    #
    # + gistId - The unique identifier of the gist
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete gists/[string gistId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/gists/${getEncodedUri(gistId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a gist
    #
    # + gistId - The unique identifier of the gist
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch gists/[string gistId](GistsgistIdBody payload, map<string|string[]> headers = {}) returns GistSimple|error {
        string resourcePath = string `/gists/${getEncodedUri(gistId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List gist comments
    #
    # + gistId - The unique identifier of the gist
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get gists/[string gistId]/comments(map<string|string[]> headers = {}, *GistsListCommentsQueries queries) returns GistComment[]|error? {
        string resourcePath = string `/gists/${getEncodedUri(gistId)}/comments`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a gist comment
    #
    # + gistId - The unique identifier of the gist
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post gists/[string gistId]/comments(GistIdCommentsBody payload, map<string|string[]> headers = {}) returns GistComment|error? {
        string resourcePath = string `/gists/${getEncodedUri(gistId)}/comments`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a gist comment
    #
    # + gistId - The unique identifier of the gist
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get gists/[string gistId]/comments/[int commentId](map<string|string[]> headers = {}) returns GistComment|error? {
        string resourcePath = string `/gists/${getEncodedUri(gistId)}/comments/${getEncodedUri(commentId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a gist comment
    #
    # + gistId - The unique identifier of the gist
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete gists/[string gistId]/comments/[int commentId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/gists/${getEncodedUri(gistId)}/comments/${getEncodedUri(commentId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a gist comment
    #
    # + gistId - The unique identifier of the gist
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch gists/[string gistId]/comments/[int commentId](GistIdCommentsBody payload, map<string|string[]> headers = {}) returns GistComment|error {
        string resourcePath = string `/gists/${getEncodedUri(gistId)}/comments/${getEncodedUri(commentId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List gist commits
    #
    # + gistId - The unique identifier of the gist
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get gists/[string gistId]/commits(map<string|string[]> headers = {}, *GistsListCommitsQueries queries) returns GistCommit[]|error? {
        string resourcePath = string `/gists/${getEncodedUri(gistId)}/commits`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List gist forks
    #
    # + gistId - The unique identifier of the gist
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get gists/[string gistId]/forks(map<string|string[]> headers = {}, *GistsListForksQueries queries) returns GistSimple[]|error? {
        string resourcePath = string `/gists/${getEncodedUri(gistId)}/forks`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Fork a gist
    #
    # + gistId - The unique identifier of the gist
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post gists/[string gistId]/forks(map<string|string[]> headers = {}) returns BaseGist|error? {
        string resourcePath = string `/gists/${getEncodedUri(gistId)}/forks`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Check if a gist is starred
    #
    # + gistId - The unique identifier of the gist
    # + headers - Headers to be sent with the request 
    # + return - Response if gist is starred 
    resource isolated function get gists/[string gistId]/star(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/gists/${getEncodedUri(gistId)}/star`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Star a gist
    #
    # + gistId - The unique identifier of the gist
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put gists/[string gistId]/star(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/gists/${getEncodedUri(gistId)}/star`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Unstar a gist
    #
    # + gistId - The unique identifier of the gist
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete gists/[string gistId]/star(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/gists/${getEncodedUri(gistId)}/star`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get a gist revision
    #
    # + gistId - The unique identifier of the gist
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get gists/[string gistId]/[string sha](map<string|string[]> headers = {}) returns GistSimple|error {
        string resourcePath = string `/gists/${getEncodedUri(gistId)}/${getEncodedUri(sha)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get all gitignore templates
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get gitignore/templates(map<string|string[]> headers = {}) returns string[]|error? {
        string resourcePath = string `/gitignore/templates`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a gitignore template
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get gitignore/templates/[string name](map<string|string[]> headers = {}) returns GitignoreTemplate|error? {
        string resourcePath = string `/gitignore/templates/${getEncodedUri(name)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List repositories accessible to the app installation
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get installation/repositories(map<string|string[]> headers = {}, *AppsListReposAccessibleToInstallationQueries queries) returns RepositoryResponse|error? {
        string resourcePath = string `/installation/repositories`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Revoke an installation access token
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete installation/token(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/installation/token`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List issues assigned to the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get issues(map<string|string[]> headers = {}, *IssuesListQueries queries) returns Issue[]|error? {
        string resourcePath = string `/issues`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get all commonly used licenses
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get licenses(map<string|string[]> headers = {}, *LicensesGetAllCommonlyUsedQueries queries) returns LicenseSimple[]|error? {
        string resourcePath = string `/licenses`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a license
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get licenses/[string license](map<string|string[]> headers = {}) returns License|error? {
        string resourcePath = string `/licenses/${getEncodedUri(license)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Render a Markdown document
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post markdown(MarkdownBody payload, map<string|string[]> headers = {}) returns string|error? {
        string resourcePath = string `/markdown`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Render a Markdown document in raw mode
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post markdown/raw(string payload, map<string|string[]> headers = {}) returns string|error? {
        string resourcePath = string `/markdown/raw`;
        http:Request request = new;
        request.setPayload(payload, "text/plain");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a subscription plan for an account
    #
    # + accountId - account_id parameter
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get marketplace_listing/accounts/[int accountId](map<string|string[]> headers = {}) returns MarketplacePurchase|error {
        string resourcePath = string `/marketplace_listing/accounts/${getEncodedUri(accountId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List plans
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get marketplace_listing/plans(map<string|string[]> headers = {}, *AppsListPlansQueries queries) returns MarketplaceListingPlan[]|error {
        string resourcePath = string `/marketplace_listing/plans`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List accounts for a plan
    #
    # + planId - The unique identifier of the plan
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get marketplace_listing/plans/[int planId]/accounts(map<string|string[]> headers = {}, *AppsListAccountsForPlanQueries queries) returns MarketplacePurchase[]|error {
        string resourcePath = string `/marketplace_listing/plans/${getEncodedUri(planId)}/accounts`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a subscription plan for an account (stubbed)
    #
    # + accountId - account_id parameter
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get marketplace_listing/stubbed/accounts/[int accountId](map<string|string[]> headers = {}) returns MarketplacePurchase|error {
        string resourcePath = string `/marketplace_listing/stubbed/accounts/${getEncodedUri(accountId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List plans (stubbed)
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get marketplace_listing/stubbed/plans(map<string|string[]> headers = {}, *AppsListPlansStubbedQueries queries) returns MarketplaceListingPlan[]|error {
        string resourcePath = string `/marketplace_listing/stubbed/plans`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List accounts for a plan (stubbed)
    #
    # + planId - The unique identifier of the plan
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get marketplace_listing/stubbed/plans/[int planId]/accounts(map<string|string[]> headers = {}, *AppsListAccountsForPlanStubbedQueries queries) returns MarketplacePurchase[]|error {
        string resourcePath = string `/marketplace_listing/stubbed/plans/${getEncodedUri(planId)}/accounts`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get GitHub meta information
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get meta(map<string|string[]> headers = {}) returns ApiOverview|error? {
        string resourcePath = string `/meta`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List public events for a network of repositories
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get networks/[string owner]/[string repo]/events(map<string|string[]> headers = {}, *ActivityListPublicEventsForRepoNetworkQueries queries) returns Event[]|error? {
        string resourcePath = string `/networks/${getEncodedUri(owner)}/${getEncodedUri(repo)}/events`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List notifications for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get notifications(map<string|string[]> headers = {}, *ActivityListNotificationsForAuthenticatedUserQueries queries) returns NotificationThread[]|error? {
        string resourcePath = string `/notifications`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Mark notifications as read
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put notifications(NotificationsBody payload, map<string|string[]> headers = {}) returns NotificationRead|error? {
        string resourcePath = string `/notifications`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Get a thread
    #
    # + threadId - The unique identifier of the notification thread. This corresponds to the value returned in the `id` field when you retrieve notifications (for example with the [`GET /notifications` operation](https://docs.github.com/rest/activity/notifications#list-notifications-for-the-authenticated-user))
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get notifications/threads/[int threadId](map<string|string[]> headers = {}) returns NotificationThread|error? {
        string resourcePath = string `/notifications/threads/${getEncodedUri(threadId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Mark a thread as read
    #
    # + threadId - The unique identifier of the notification thread. This corresponds to the value returned in the `id` field when you retrieve notifications (for example with the [`GET /notifications` operation](https://docs.github.com/rest/activity/notifications#list-notifications-for-the-authenticated-user))
    # + headers - Headers to be sent with the request 
    # + return - Reset Content 
    resource isolated function patch notifications/threads/[int threadId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/notifications/threads/${getEncodedUri(threadId)}`;
        http:Request request = new;
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Get a thread subscription for the authenticated user
    #
    # + threadId - The unique identifier of the notification thread. This corresponds to the value returned in the `id` field when you retrieve notifications (for example with the [`GET /notifications` operation](https://docs.github.com/rest/activity/notifications#list-notifications-for-the-authenticated-user))
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get notifications/threads/[int threadId]/subscription(map<string|string[]> headers = {}) returns ThreadSubscription|error? {
        string resourcePath = string `/notifications/threads/${getEncodedUri(threadId)}/subscription`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set a thread subscription
    #
    # + threadId - The unique identifier of the notification thread. This corresponds to the value returned in the `id` field when you retrieve notifications (for example with the [`GET /notifications` operation](https://docs.github.com/rest/activity/notifications#list-notifications-for-the-authenticated-user))
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put notifications/threads/[int threadId]/subscription(ThreadIdSubscriptionBody payload, map<string|string[]> headers = {}) returns ThreadSubscription|error? {
        string resourcePath = string `/notifications/threads/${getEncodedUri(threadId)}/subscription`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete a thread subscription
    #
    # + threadId - The unique identifier of the notification thread. This corresponds to the value returned in the `id` field when you retrieve notifications (for example with the [`GET /notifications` operation](https://docs.github.com/rest/activity/notifications#list-notifications-for-the-authenticated-user))
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete notifications/threads/[int threadId]/subscription(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/notifications/threads/${getEncodedUri(threadId)}/subscription`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get Octocat
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get octocat(map<string|string[]> headers = {}, *MetaGetOctocatQueries queries) returns http:Response|error {
        string resourcePath = string `/octocat`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List organizations
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get organizations(map<string|string[]> headers = {}, *OrgsListQueries queries) returns OrganizationSimple[]|error? {
        string resourcePath = string `/organizations`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org](map<string|string[]> headers = {}) returns OrganizationFull|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Accepted 
    resource isolated function delete orgs/[string org](map<string|string[]> headers = {}) returns record {}|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch orgs/[string org](OrgsorgBody payload, map<string|string[]> headers = {}) returns OrganizationFull|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Get GitHub Actions cache usage for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/cache/usage(map<string|string[]> headers = {}) returns ActionsCacheUsageOrgEnterprise|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/cache/usage`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List repositories with GitHub Actions cache usage for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/cache/usage\-by\-repository(map<string|string[]> headers = {}, *ActionsGetActionsCacheUsageByRepoForOrgQueries queries) returns ActionsCacheUsageByRepositoryResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/cache/usage-by-repository`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get the customization template for an OIDC subject claim for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - A JSON serialized template for OIDC subject claim customization 
    resource isolated function get orgs/[string org]/actions/oidc/customization/sub(map<string|string[]> headers = {}) returns OidcCustomSub|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/oidc/customization/sub`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set the customization template for an OIDC subject claim for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Empty response 
    resource isolated function put orgs/[string org]/actions/oidc/customization/sub(OidcCustomSub payload, map<string|string[]> headers = {}) returns EmptyObject|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/oidc/customization/sub`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Get GitHub Actions permissions for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/permissions(map<string|string[]> headers = {}) returns ActionsOrganizationPermissions|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set GitHub Actions permissions for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/permissions(ActionsPermissionsBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # List selected repositories enabled for GitHub Actions in an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/permissions/repositories(map<string|string[]> headers = {}, *ActionsListSelectedRepositoriesEnabledGithubActionsOrganizationQueries queries) returns RepositoryResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/repositories`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Set selected repositories enabled for GitHub Actions in an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/permissions/repositories(PermissionsRepositoriesBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/repositories`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Enable a selected repository for GitHub Actions in an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + repositoryId - The unique identifier of the repository
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/permissions/repositories/[int repositoryId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/repositories/${getEncodedUri(repositoryId)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Disable a selected repository for GitHub Actions in an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + repositoryId - The unique identifier of the repository
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/actions/permissions/repositories/[int repositoryId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/repositories/${getEncodedUri(repositoryId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get allowed actions and reusable workflows for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/permissions/selected\-actions(map<string|string[]> headers = {}) returns SelectedActions|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/selected-actions`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set allowed actions and reusable workflows for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/permissions/selected\-actions(SelectedActions payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/selected-actions`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Get default workflow permissions for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/permissions/workflow(map<string|string[]> headers = {}) returns ActionsGetDefaultWorkflowPermissions|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/workflow`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set default workflow permissions for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Success response 
    resource isolated function put orgs/[string org]/actions/permissions/workflow(ActionsSetDefaultWorkflowPermissions payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/workflow`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # List self-hosted runners for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/runners(map<string|string[]> headers = {}, *ActionsListSelfHostedRunnersForOrgQueries queries) returns RunnerResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List runner applications for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/runners/downloads(map<string|string[]> headers = {}) returns RunnerApplication[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/downloads`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create configuration for a just-in-time runner for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/actions/runners/generate\-jitconfig(RunnersGenerateJitconfigBody payload, map<string|string[]> headers = {}) returns JitConfig|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/generate-jitconfig`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Create a registration token for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/actions/runners/registration\-token(map<string|string[]> headers = {}) returns AuthenticationToken|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/registration-token`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Create a remove token for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/actions/runners/remove\-token(map<string|string[]> headers = {}) returns AuthenticationToken|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/remove-token`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a self-hosted runner for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + runnerId - Unique identifier of the self-hosted runner
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/runners/[int runnerId](map<string|string[]> headers = {}) returns Runner|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/${getEncodedUri(runnerId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a self-hosted runner from an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + runnerId - Unique identifier of the self-hosted runner
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/actions/runners/[int runnerId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/${getEncodedUri(runnerId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List labels for a self-hosted runner for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + runnerId - Unique identifier of the self-hosted runner
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/runners/[int runnerId]/labels(map<string|string[]> headers = {}) returns RunnerLabelResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/${getEncodedUri(runnerId)}/labels`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set custom labels for a self-hosted runner for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + runnerId - Unique identifier of the self-hosted runner
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/runners/[int runnerId]/labels(RunnerIdLabelsBody payload, map<string|string[]> headers = {}) returns RunnerLabelResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/${getEncodedUri(runnerId)}/labels`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Add custom labels to a self-hosted runner for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + runnerId - Unique identifier of the self-hosted runner
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/actions/runners/[int runnerId]/labels(RunnerIdLabelsBody1 payload, map<string|string[]> headers = {}) returns RunnerLabelResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/${getEncodedUri(runnerId)}/labels`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Remove all custom labels from a self-hosted runner for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + runnerId - Unique identifier of the self-hosted runner
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/actions/runners/[int runnerId]/labels(map<string|string[]> headers = {}) returns RunnerLabelResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/${getEncodedUri(runnerId)}/labels`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Remove a custom label from a self-hosted runner for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + runnerId - Unique identifier of the self-hosted runner
    # + name - The name of a self-hosted runner's custom label
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/actions/runners/[int runnerId]/labels/[string name](map<string|string[]> headers = {}) returns RunnerLabelResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/${getEncodedUri(runnerId)}/labels/${getEncodedUri(name)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List organization secrets
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/secrets(map<string|string[]> headers = {}, *ActionsListOrgSecretsQueries queries) returns OrganizationActionsSecretResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an organization public key
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/secrets/public\-key(map<string|string[]> headers = {}) returns ActionsPublicKey|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/public-key`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/secrets/[string secretName](map<string|string[]> headers = {}) returns OrganizationActionsSecret|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create or update an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response when creating a secret 
    resource isolated function put orgs/[string org]/actions/secrets/[string secretName](SecretssecretNameBody payload, map<string|string[]> headers = {}) returns EmptyObject|error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/${getEncodedUri(secretName)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/actions/secrets/[string secretName](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List selected repositories for an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/secrets/[string secretName]/repositories(map<string|string[]> headers = {}, *ActionsListSelectedReposForOrgSecretQueries queries) returns MinimalRepositoryResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/${getEncodedUri(secretName)}/repositories`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Set selected repositories for an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/secrets/[string secretName]/repositories(SecretNameRepositoriesBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/${getEncodedUri(secretName)}/repositories`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Add selected repository to an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - No Content when repository was added to the selected list 
    resource isolated function put orgs/[string org]/actions/secrets/[string secretName]/repositories/[int repositoryId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/${getEncodedUri(secretName)}/repositories/${getEncodedUri(repositoryId)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove selected repository from an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response when repository was removed from the selected list 
    resource isolated function delete orgs/[string org]/actions/secrets/[string secretName]/repositories/[int repositoryId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/${getEncodedUri(secretName)}/repositories/${getEncodedUri(repositoryId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List organization variables
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/variables(map<string|string[]> headers = {}, *ActionsListOrgVariablesQueries queries) returns OrganizationActionsVariableResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create an organization variable
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response when creating a variable 
    resource isolated function post orgs/[string org]/actions/variables(ActionsVariablesBody payload, map<string|string[]> headers = {}) returns EmptyObject|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get an organization variable
    #
    # + org - The organization name. The name is not case sensitive
    # + name - The name of the variable
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/variables/[string name](map<string|string[]> headers = {}) returns OrganizationActionsVariable|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables/${getEncodedUri(name)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete an organization variable
    #
    # + org - The organization name. The name is not case sensitive
    # + name - The name of the variable
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/actions/variables/[string name](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables/${getEncodedUri(name)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update an organization variable
    #
    # + org - The organization name. The name is not case sensitive
    # + name - The name of the variable
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch orgs/[string org]/actions/variables/[string name](VariablesnameBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables/${getEncodedUri(name)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List selected repositories for an organization variable
    #
    # + org - The organization name. The name is not case sensitive
    # + name - The name of the variable
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/variables/[string name]/repositories(map<string|string[]> headers = {}, *ActionsListSelectedReposForOrgVariableQueries queries) returns MinimalRepositoryResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables/${getEncodedUri(name)}/repositories`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Set selected repositories for an organization variable
    #
    # + org - The organization name. The name is not case sensitive
    # + name - The name of the variable
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/variables/[string name]/repositories(NameRepositoriesBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables/${getEncodedUri(name)}/repositories`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Add selected repository to an organization variable
    #
    # + org - The organization name. The name is not case sensitive
    # + name - The name of the variable
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/variables/[string name]/repositories/[int repositoryId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables/${getEncodedUri(name)}/repositories/${getEncodedUri(repositoryId)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove selected repository from an organization variable
    #
    # + org - The organization name. The name is not case sensitive
    # + name - The name of the variable
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/actions/variables/[string name]/repositories/[int repositoryId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables/${getEncodedUri(name)}/repositories/${getEncodedUri(repositoryId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List users blocked by an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/blocks(map<string|string[]> headers = {}, *OrgsListBlockedUsersQueries queries) returns SimpleUser[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/blocks`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Check if a user is blocked by an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - If the user is blocked 
    resource isolated function get orgs/[string org]/blocks/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/blocks/${getEncodedUri(username)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Block a user from an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/blocks/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/blocks/${getEncodedUri(username)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Unblock a user from an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/blocks/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/blocks/${getEncodedUri(username)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List secret scanning alerts for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/code\-scanning/alerts(map<string|string[]> headers = {}, *CodeScanningListAlertsForOrgQueries queries) returns CodeScanningOrganizationAlertItems[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/code-scanning/alerts`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List codespaces for the organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/codespaces(map<string|string[]> headers = {}, *CodespacesListInOrganizationQueries queries) returns CodespaceResponse|error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Manage access control for organization codespaces
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response when successfully modifying permissions 
    # 
    # # Deprecated
    @deprecated
    resource isolated function put orgs/[string org]/codespaces/access(CodespacesAccessBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/access`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Add users to Codespaces access for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response when successfully modifying permissions 
    # 
    # # Deprecated
    @deprecated
    resource isolated function post orgs/[string org]/codespaces/access/selected_users(AccessSelectedUsersBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/access/selected_users`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Remove users from Codespaces access for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response when successfully modifying permissions 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete orgs/[string org]/codespaces/access/selected_users(AccessSelectedUsersBody1 payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/access/selected_users`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # List organization secrets
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/codespaces/secrets(map<string|string[]> headers = {}, *CodespacesListOrgSecretsQueries queries) returns CodespacesOrgSecretResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an organization public key
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/codespaces/secrets/public\-key(map<string|string[]> headers = {}) returns CodespacesPublicKey|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/public-key`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/codespaces/secrets/[string secretName](map<string|string[]> headers = {}) returns CodespacesOrgSecret|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create or update an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response when creating a secret 
    resource isolated function put orgs/[string org]/codespaces/secrets/[string secretName](SecretssecretNameBody1 payload, map<string|string[]> headers = {}) returns EmptyObject|error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/${getEncodedUri(secretName)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/codespaces/secrets/[string secretName](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List selected repositories for an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/codespaces/secrets/[string secretName]/repositories(map<string|string[]> headers = {}, *CodespacesListSelectedReposForOrgSecretQueries queries) returns MinimalRepositoryResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/${getEncodedUri(secretName)}/repositories`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Set selected repositories for an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/codespaces/secrets/[string secretName]/repositories(SecretNameRepositoriesBody1 payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/${getEncodedUri(secretName)}/repositories`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Add selected repository to an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - No Content when repository was added to the selected list 
    resource isolated function put orgs/[string org]/codespaces/secrets/[string secretName]/repositories/[int repositoryId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/${getEncodedUri(secretName)}/repositories/${getEncodedUri(repositoryId)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove selected repository from an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response when repository was removed from the selected list 
    resource isolated function delete orgs/[string org]/codespaces/secrets/[string secretName]/repositories/[int repositoryId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/${getEncodedUri(secretName)}/repositories/${getEncodedUri(repositoryId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get Copilot for Business seat information and settings for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - OK 
    resource isolated function get orgs/[string org]/copilot/billing(map<string|string[]> headers = {}) returns CopilotOrganizationDetails|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/copilot/billing`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List all Copilot for Business seat assignments for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/copilot/billing/seats(map<string|string[]> headers = {}, *CopilotListCopilotSeatsQueries queries) returns CopilotSeatDetailsResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/copilot/billing/seats`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Add teams to the Copilot for Business subscription for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - OK 
    resource isolated function post orgs/[string org]/copilot/billing/selected_teams(BillingSelectedTeamsBody payload, map<string|string[]> headers = {}) returns CopilotSeatCreated|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/copilot/billing/selected_teams`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Remove teams from the Copilot for Business subscription for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - OK 
    resource isolated function delete orgs/[string org]/copilot/billing/selected_teams(BillingSelectedTeamsBody1 payload, map<string|string[]> headers = {}) returns CopilotSeatCancelled|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/copilot/billing/selected_teams`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # Add users to the Copilot for Business subscription for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - OK 
    resource isolated function post orgs/[string org]/copilot/billing/selected_users(BillingSelectedUsersBody payload, map<string|string[]> headers = {}) returns CopilotSeatCreated|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/copilot/billing/selected_users`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Remove users from the Copilot for Business subscription for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - OK 
    resource isolated function delete orgs/[string org]/copilot/billing/selected_users(BillingSelectedUsersBody1 payload, map<string|string[]> headers = {}) returns CopilotSeatCancelled|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/copilot/billing/selected_users`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # List Dependabot alerts for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/dependabot/alerts(map<string|string[]> headers = {}, *DependabotListAlertsForOrgQueries queries) returns DependabotAlertWithRepository[]|error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/alerts`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List organization secrets
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/dependabot/secrets(map<string|string[]> headers = {}, *DependabotListOrgSecretsQueries queries) returns OrganizationDependabotSecretResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an organization public key
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/dependabot/secrets/public\-key(map<string|string[]> headers = {}) returns DependabotPublicKey|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/public-key`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/dependabot/secrets/[string secretName](map<string|string[]> headers = {}) returns OrganizationDependabotSecret|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create or update an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response when creating a secret 
    resource isolated function put orgs/[string org]/dependabot/secrets/[string secretName](SecretssecretNameBody2 payload, map<string|string[]> headers = {}) returns EmptyObject|error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/${getEncodedUri(secretName)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/dependabot/secrets/[string secretName](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List selected repositories for an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/dependabot/secrets/[string secretName]/repositories(map<string|string[]> headers = {}, *DependabotListSelectedReposForOrgSecretQueries queries) returns MinimalRepositoryResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/${getEncodedUri(secretName)}/repositories`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Set selected repositories for an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/dependabot/secrets/[string secretName]/repositories(SecretNameRepositoriesBody2 payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/${getEncodedUri(secretName)}/repositories`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Add selected repository to an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - No Content when repository was added to the selected list 
    resource isolated function put orgs/[string org]/dependabot/secrets/[string secretName]/repositories/[int repositoryId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/${getEncodedUri(secretName)}/repositories/${getEncodedUri(repositoryId)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove selected repository from an organization secret
    #
    # + org - The organization name. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response when repository was removed from the selected list 
    resource isolated function delete orgs/[string org]/dependabot/secrets/[string secretName]/repositories/[int repositoryId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/${getEncodedUri(secretName)}/repositories/${getEncodedUri(repositoryId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get list of conflicting packages during Docker migration for organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/docker/conflicts(map<string|string[]> headers = {}) returns Package[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/docker/conflicts`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List public organization events
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/events(map<string|string[]> headers = {}, *ActivityListPublicOrgEventsQueries queries) returns Event[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/events`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List failed organization invitations
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/failed_invitations(map<string|string[]> headers = {}, *OrgsListFailedInvitationsQueries queries) returns OrganizationInvitation[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/failed_invitations`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List organization webhooks
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/hooks(map<string|string[]> headers = {}, *OrgsListWebhooksQueries queries) returns OrgHook[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create an organization webhook
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/hooks(OrgHooksBody payload, map<string|string[]> headers = {}) returns OrgHook|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get an organization webhook
    #
    # + org - The organization name. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/hooks/[int hookId](map<string|string[]> headers = {}) returns OrgHook|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hookId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete an organization webhook
    #
    # + org - The organization name. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/hooks/[int hookId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hookId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update an organization webhook
    #
    # + org - The organization name. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch orgs/[string org]/hooks/[int hookId](HookshookIdBody payload, map<string|string[]> headers = {}) returns OrgHook|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hookId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Get a webhook configuration for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/hooks/[int hookId]/config(map<string|string[]> headers = {}) returns WebhookConfig|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hookId)}/config`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a webhook configuration for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch orgs/[string org]/hooks/[int hookId]/config(HookConfigBody payload, map<string|string[]> headers = {}) returns WebhookConfig|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hookId)}/config`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List deliveries for an organization webhook
    #
    # + org - The organization name. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/hooks/[int hookId]/deliveries(map<string|string[]> headers = {}, *OrgsListWebhookDeliveriesQueries queries) returns HookDeliveryItem[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hookId)}/deliveries`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a webhook delivery for an organization webhook
    #
    # + org - The organization name. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/hooks/[int hookId]/deliveries/[int deliveryId](map<string|string[]> headers = {}) returns HookDelivery|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hookId)}/deliveries/${getEncodedUri(deliveryId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Redeliver a delivery for an organization webhook
    #
    # + org - The organization name. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Accepted 
    resource isolated function post orgs/[string org]/hooks/[int hookId]/deliveries/[int deliveryId]/attempts(map<string|string[]> headers = {}) returns record {}|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hookId)}/deliveries/${getEncodedUri(deliveryId)}/attempts`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Ping an organization webhook
    #
    # + org - The organization name. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/hooks/[int hookId]/pings(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hookId)}/pings`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get an organization installation for the authenticated app
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/installation(map<string|string[]> headers = {}) returns Installation|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/installation`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List app installations for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/installations(map<string|string[]> headers = {}, *OrgsListAppInstallationsQueries queries) returns InstallationResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/installations`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get interaction restrictions for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/interaction\-limits(map<string|string[]> headers = {}) returns InteractionLimitResponseAny|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/interaction-limits`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set interaction restrictions for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/interaction\-limits(InteractionLimit payload, map<string|string[]> headers = {}) returns InteractionLimitResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/interaction-limits`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove interaction restrictions for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/interaction\-limits(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/interaction-limits`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List pending organization invitations
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/invitations(map<string|string[]> headers = {}, *OrgsListPendingInvitationsQueries queries) returns OrganizationInvitation[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/invitations`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create an organization invitation
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/invitations(OrgInvitationsBody payload, map<string|string[]> headers = {}) returns OrganizationInvitation|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/invitations`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Cancel an organization invitation
    #
    # + org - The organization name. The name is not case sensitive
    # + invitationId - The unique identifier of the invitation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/invitations/[int invitationId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/invitations/${getEncodedUri(invitationId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List organization invitation teams
    #
    # + org - The organization name. The name is not case sensitive
    # + invitationId - The unique identifier of the invitation
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/invitations/[int invitationId]/teams(map<string|string[]> headers = {}, *OrgsListInvitationTeamsQueries queries) returns Team[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/invitations/${getEncodedUri(invitationId)}/teams`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List organization issues assigned to the authenticated user
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/issues(map<string|string[]> headers = {}, *IssuesListForOrgQueries queries) returns Issue[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/issues`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List organization members
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/members(map<string|string[]> headers = {}, *OrgsListMembersQueries queries) returns SimpleUser[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/members`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Check organization membership for a user
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response if requester is an organization member and user is a member 
    resource isolated function get orgs/[string org]/members/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/members/${getEncodedUri(username)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Remove an organization member
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/members/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/members/${getEncodedUri(username)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List codespaces for a user in organization
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/members/[string username]/codespaces(map<string|string[]> headers = {}, *CodespacesGetCodespacesForUserInOrgQueries queries) returns CodespaceResponse|error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/members/${getEncodedUri(username)}/codespaces`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a codespace from the organization
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + codespaceName - The name of the codespace
    # + headers - Headers to be sent with the request 
    # + return - Accepted 
    resource isolated function delete orgs/[string org]/members/[string username]/codespaces/[string codespaceName](map<string|string[]> headers = {}) returns record {}|error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/members/${getEncodedUri(username)}/codespaces/${getEncodedUri(codespaceName)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Stop a codespace for an organization user
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + codespaceName - The name of the codespace
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/members/[string username]/codespaces/[string codespaceName]/stop(map<string|string[]> headers = {}) returns Codespace|error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/members/${getEncodedUri(username)}/codespaces/${getEncodedUri(codespaceName)}/stop`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get Copilot for Business seat assignment details for a user
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - The user's GitHub Copilot seat details, including usage 
    resource isolated function get orgs/[string org]/members/[string username]/copilot(map<string|string[]> headers = {}) returns CopilotSeatDetails|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/members/${getEncodedUri(username)}/copilot`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get organization membership for a user
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/memberships/[string username](map<string|string[]> headers = {}) returns OrgMembership|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/memberships/${getEncodedUri(username)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set organization membership for a user
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/memberships/[string username](MembershipsusernameBody payload, map<string|string[]> headers = {}) returns OrgMembership|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/memberships/${getEncodedUri(username)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove organization membership for a user
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/memberships/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/memberships/${getEncodedUri(username)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List organization migrations
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/migrations(map<string|string[]> headers = {}, *MigrationsListForOrgQueries queries) returns Migration[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/migrations`;
        map<Encoding> queryParamEncoding = {"exclude": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queries, queryParamEncoding);
        return self.clientEp->get(resourcePath, headers);
    }

    # Start an organization migration
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/migrations(OrgMigrationsBody payload, map<string|string[]> headers = {}) returns Migration|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/migrations`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get an organization migration status
    #
    # + org - The organization name. The name is not case sensitive
    # + migrationId - The unique identifier of the migration
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - *   `pending`, which means the migration hasn't started yet. *   `exporting`, which means the migration is in progress. *   `exported`, which means the migration finished successfully. *   `failed`, which means the migration failed 
    resource isolated function get orgs/[string org]/migrations/[int migrationId](map<string|string[]> headers = {}, *MigrationsGetStatusForOrgQueries queries) returns Migration|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/migrations/${getEncodedUri(migrationId)}`;
        map<Encoding> queryParamEncoding = {"exclude": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queries, queryParamEncoding);
        return self.clientEp->get(resourcePath, headers);
    }

    # Download an organization migration archive
    #
    # + org - The organization name. The name is not case sensitive
    # + migrationId - The unique identifier of the migration
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/migrations/[int migrationId]/archive(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/migrations/${getEncodedUri(migrationId)}/archive`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete an organization migration archive
    #
    # + org - The organization name. The name is not case sensitive
    # + migrationId - The unique identifier of the migration
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/migrations/[int migrationId]/archive(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/migrations/${getEncodedUri(migrationId)}/archive`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Unlock an organization repository
    #
    # + org - The organization name. The name is not case sensitive
    # + migrationId - The unique identifier of the migration
    # + repoName - repo_name parameter
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/migrations/[int migrationId]/repos/[string repoName]/'lock(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/migrations/${getEncodedUri(migrationId)}/repos/${getEncodedUri(repoName)}/lock`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List repositories in an organization migration
    #
    # + org - The organization name. The name is not case sensitive
    # + migrationId - The unique identifier of the migration
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/migrations/[int migrationId]/repositories(map<string|string[]> headers = {}, *MigrationsListReposForOrgQueries queries) returns MinimalRepository[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/migrations/${getEncodedUri(migrationId)}/repositories`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List outside collaborators for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/outside_collaborators(map<string|string[]> headers = {}, *OrgsListOutsideCollaboratorsQueries queries) returns SimpleUser[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/outside_collaborators`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Convert an organization member to outside collaborator
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - User is getting converted asynchronously 
    resource isolated function put orgs/[string org]/outside_collaborators/[string username](OutsideCollaboratorsusernameBody payload, map<string|string[]> headers = {}) returns record {||}|error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/outside_collaborators/${getEncodedUri(username)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove outside collaborator from an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/outside_collaborators/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/outside_collaborators/${getEncodedUri(username)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List packages for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/packages(map<string|string[]> headers = {}, *PackagesListPackagesForOrganizationQueries queries) returns Package[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a package for an organization
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName](map<string|string[]> headers = {}) returns Package|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a package for an organization
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Restore a package for an organization
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName]/restore(map<string|string[]> headers = {}, *PackagesRestorePackageForOrgQueries queries) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}/restore`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List package versions for a package owned by an organization
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName]/versions(map<string|string[]> headers = {}, *PackagesGetAllPackageVersionsForPackageOwnedByOrgQueries queries) returns PackageVersion[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}/versions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a package version for an organization
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + org - The organization name. The name is not case sensitive
    # + packageVersionId - Unique identifier of the package version
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName]/versions/[int packageVersionId](map<string|string[]> headers = {}) returns PackageVersion|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}/versions/${getEncodedUri(packageVersionId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete package version for an organization
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + org - The organization name. The name is not case sensitive
    # + packageVersionId - Unique identifier of the package version
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName]/versions/[int packageVersionId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}/versions/${getEncodedUri(packageVersionId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Restore package version for an organization
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + org - The organization name. The name is not case sensitive
    # + packageVersionId - Unique identifier of the package version
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName]/versions/[int packageVersionId]/restore(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}/versions/${getEncodedUri(packageVersionId)}/restore`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List requests to access organization resources with fine-grained personal access tokens
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Internal Error 
    resource isolated function get orgs/[string org]/personal\-access\-token\-requests(map<string|string[]> headers = {}, *OrgsListPatGrantRequestsQueries queries) returns OrganizationProgrammaticAccessGrantRequest[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-token-requests`;
        map<Encoding> queryParamEncoding = {"owner": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queries, queryParamEncoding);
        return self.clientEp->get(resourcePath, headers);
    }

    # Review requests to access organization resources with fine-grained personal access tokens
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Internal Error 
    resource isolated function post orgs/[string org]/personal\-access\-token\-requests(OrgPersonalAccessTokenRequestsBody payload, map<string|string[]> headers = {}) returns record {}|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-token-requests`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Update the access a fine-grained personal access token has to organization resources
    #
    # + org - The organization name. The name is not case sensitive
    # + patId - The unique identifier of the fine-grained personal access token
    # + headers - Headers to be sent with the request 
    # + return - Internal Error 
    resource isolated function post orgs/[string org]/personal\-access\-token\-requests/[int patRequestId](PersonalAccessTokenRequestspatRequestIdBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-token-requests/${getEncodedUri(patRequestId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List repositories a fine-grained personal access token has access to
    #
    # + org - The organization name. The name is not case sensitive
    # + patId - Unique identifier of the fine-grained personal access token
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Internal Error 
    resource isolated function get orgs/[string org]/personal\-access\-token\-requests/[int patRequestId]/repositories(map<string|string[]> headers = {}, *OrgsListPatGrantRequestRepositoriesQueries queries) returns MinimalRepository[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-token-requests/${getEncodedUri(patRequestId)}/repositories`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List fine-grained personal access tokens with access to organization resources
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Internal Error 
    resource isolated function get orgs/[string org]/personal\-access\-tokens(map<string|string[]> headers = {}, *OrgsListPatGrantsQueries queries) returns OrganizationProgrammaticAccessGrant[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-tokens`;
        map<Encoding> queryParamEncoding = {"owner": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queries, queryParamEncoding);
        return self.clientEp->get(resourcePath, headers);
    }

    # Update the access to organization resources via fine-grained personal access tokens
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Internal Error 
    resource isolated function post orgs/[string org]/personal\-access\-tokens(OrgPersonalAccessTokensBody payload, map<string|string[]> headers = {}) returns record {}|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-tokens`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Update the access a fine-grained personal access token has to organization resources
    #
    # + org - The organization name. The name is not case sensitive
    # + patId - The unique identifier of the fine-grained personal access token
    # + headers - Headers to be sent with the request 
    # + return - Internal Error 
    resource isolated function post orgs/[string org]/personal\-access\-tokens/[int patId](PersonalAccessTokenspatIdBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-tokens/${getEncodedUri(patId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List repositories a fine-grained personal access token has access to
    #
    # + org - The organization name. The name is not case sensitive
    # + patId - Unique identifier of the fine-grained personal access token
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Internal Error 
    resource isolated function get orgs/[string org]/personal\-access\-tokens/[int patId]/repositories(map<string|string[]> headers = {}, *OrgsListPatGrantRepositoriesQueries queries) returns MinimalRepository[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-tokens/${getEncodedUri(patId)}/repositories`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List organization projects
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/projects(map<string|string[]> headers = {}, *ProjectsListForOrgQueries queries) returns Project[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/projects`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create an organization project
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/projects(OrgProjectsBody payload, map<string|string[]> headers = {}) returns Project|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/projects`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List public organization members
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/public_members(map<string|string[]> headers = {}, *OrgsListPublicMembersQueries queries) returns SimpleUser[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/public_members`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Check public organization membership for a user
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response if user is a public member 
    resource isolated function get orgs/[string org]/public_members/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/public_members/${getEncodedUri(username)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set public organization membership for the authenticated user
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/public_members/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/public_members/${getEncodedUri(username)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove public organization membership for the authenticated user
    #
    # + org - The organization name. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/public_members/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/public_members/${getEncodedUri(username)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List organization repositories
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/repos(map<string|string[]> headers = {}, *ReposListForOrgQueries queries) returns MinimalRepository[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/repos`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create an organization repository
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/repos(OrgReposBody payload, map<string|string[]> headers = {}) returns Repository|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/repos`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get all organization repository rulesets
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/rulesets(map<string|string[]> headers = {}, *ReposGetOrgRulesetsQueries queries) returns RepositoryRuleset[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/rulesets`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create an organization repository ruleset
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + payload - Request body 
    # + return - Response 
    resource isolated function post orgs/[string org]/rulesets(OrgRulesetsBody payload, map<string|string[]> headers = {}) returns RepositoryRuleset|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/rulesets`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List organization rule suites
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/rulesets/rule\-suites(map<string|string[]> headers = {}, *ReposGetOrgRuleSuitesQueries queries) returns RuleSuites|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/rulesets/rule-suites`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an organization rule suite
    #
    # + org - The organization name. The name is not case sensitive
    # + ruleSuiteId - The unique identifier of the rule suite result.
    # To get this ID, you can use [GET /repos/{owner}/{repo}/rulesets/rule-suites](https://docs.github.com/rest/repos/rule-suites#list-repository-rule-suites)
    # for repositories and [GET /orgs/{org}/rulesets/rule-suites](https://docs.github.com/rest/orgs/rule-suites#list-organization-rule-suites)
    # for organizations
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/rulesets/rule\-suites/[int ruleSuiteId](map<string|string[]> headers = {}) returns RuleSuite|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/rulesets/rule-suites/${getEncodedUri(ruleSuiteId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an organization repository ruleset
    #
    # + org - The organization name. The name is not case sensitive
    # + rulesetId - The ID of the ruleset
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/rulesets/[int rulesetId](map<string|string[]> headers = {}) returns RepositoryRuleset|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/rulesets/${getEncodedUri(rulesetId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update an organization repository ruleset
    #
    # + org - The organization name. The name is not case sensitive
    # + rulesetId - The ID of the ruleset
    # + headers - Headers to be sent with the request 
    # + payload - Request body 
    # + return - Response 
    resource isolated function put orgs/[string org]/rulesets/[int rulesetId](RulesetsrulesetIdBody payload, map<string|string[]> headers = {}) returns RepositoryRuleset|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/rulesets/${getEncodedUri(rulesetId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete an organization repository ruleset
    #
    # + org - The organization name. The name is not case sensitive
    # + rulesetId - The ID of the ruleset
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/rulesets/[int rulesetId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/rulesets/${getEncodedUri(rulesetId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List secret scanning alerts for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/secret\-scanning/alerts(map<string|string[]> headers = {}, *SecretScanningListAlertsForOrgQueries queries) returns OrganizationSecretScanningAlert[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/secret-scanning/alerts`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List repository security advisories for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/security\-advisories(map<string|string[]> headers = {}, *SecurityAdvisoriesListOrgRepositoryAdvisoriesQueries queries) returns RepositoryAdvisory[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/security-advisories`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List security manager teams
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/security\-managers(map<string|string[]> headers = {}) returns TeamSimple[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/security-managers`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Add a security manager team
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/security\-managers/teams/[string teamSlug](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/security-managers/teams/${getEncodedUri(teamSlug)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove a security manager team
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/security\-managers/teams/[string teamSlug](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/security-managers/teams/${getEncodedUri(teamSlug)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get GitHub Actions billing for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/settings/billing/actions(map<string|string[]> headers = {}) returns ActionsBillingUsage|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/settings/billing/actions`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get GitHub Packages billing for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/settings/billing/packages(map<string|string[]> headers = {}) returns PackagesBillingUsage|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/settings/billing/packages`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get shared storage billing for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/settings/billing/shared\-storage(map<string|string[]> headers = {}) returns CombinedBillingUsage|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/settings/billing/shared-storage`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List teams
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/teams(map<string|string[]> headers = {}, *TeamsListQueries queries) returns Team[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a team
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/teams(OrgTeamsBody payload, map<string|string[]> headers = {}) returns TeamFull|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a team by name
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string teamSlug](map<string|string[]> headers = {}) returns TeamFull|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a team
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string teamSlug](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a team
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + headers - Headers to be sent with the request 
    # + return - Response when the updated information already exists 
    resource isolated function patch orgs/[string org]/teams/[string teamSlug](TeamsteamSlugBody payload, map<string|string[]> headers = {}) returns TeamFull|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List discussions
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string teamSlug]/discussions(map<string|string[]> headers = {}, *TeamsListDiscussionsInOrgQueries queries) returns TeamDiscussion[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a discussion
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/teams/[string teamSlug]/discussions(TeamSlugDiscussionsBody payload, map<string|string[]> headers = {}) returns TeamDiscussion|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a discussion
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + discussionNumber - The number that identifies the discussion
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string teamSlug]/discussions/[int discussionNumber](map<string|string[]> headers = {}) returns TeamDiscussion|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions/${getEncodedUri(discussionNumber)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a discussion
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + discussionNumber - The number that identifies the discussion
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string teamSlug]/discussions/[int discussionNumber](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions/${getEncodedUri(discussionNumber)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a discussion
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + discussionNumber - The number that identifies the discussion
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch orgs/[string org]/teams/[string teamSlug]/discussions/[int discussionNumber](DiscussionsdiscussionNumberBody payload, map<string|string[]> headers = {}) returns TeamDiscussion|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions/${getEncodedUri(discussionNumber)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List discussion comments
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + discussionNumber - The number that identifies the discussion
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string teamSlug]/discussions/[int discussionNumber]/comments(map<string|string[]> headers = {}, *TeamsListDiscussionCommentsInOrgQueries queries) returns TeamDiscussionComment[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions/${getEncodedUri(discussionNumber)}/comments`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a discussion comment
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + discussionNumber - The number that identifies the discussion
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/teams/[string teamSlug]/discussions/[int discussionNumber]/comments(DiscussionNumberCommentsBody payload, map<string|string[]> headers = {}) returns TeamDiscussionComment|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions/${getEncodedUri(discussionNumber)}/comments`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a discussion comment
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + discussionNumber - The number that identifies the discussion
    # + commentNumber - The number that identifies the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string teamSlug]/discussions/[int discussionNumber]/comments/[int commentNumber](map<string|string[]> headers = {}) returns TeamDiscussionComment|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions/${getEncodedUri(discussionNumber)}/comments/${getEncodedUri(commentNumber)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a discussion comment
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + discussionNumber - The number that identifies the discussion
    # + commentNumber - The number that identifies the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string teamSlug]/discussions/[int discussionNumber]/comments/[int commentNumber](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions/${getEncodedUri(discussionNumber)}/comments/${getEncodedUri(commentNumber)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a discussion comment
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + discussionNumber - The number that identifies the discussion
    # + commentNumber - The number that identifies the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch orgs/[string org]/teams/[string teamSlug]/discussions/[int discussionNumber]/comments/[int commentNumber](DiscussionNumberCommentsBody payload, map<string|string[]> headers = {}) returns TeamDiscussionComment|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions/${getEncodedUri(discussionNumber)}/comments/${getEncodedUri(commentNumber)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List reactions for a team discussion comment
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + discussionNumber - The number that identifies the discussion
    # + commentNumber - The number that identifies the comment
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string teamSlug]/discussions/[int discussionNumber]/comments/[int commentNumber]/reactions(map<string|string[]> headers = {}, *ReactionsListForTeamDiscussionCommentInOrgQueries queries) returns Reaction[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions/${getEncodedUri(discussionNumber)}/comments/${getEncodedUri(commentNumber)}/reactions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create reaction for a team discussion comment
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + discussionNumber - The number that identifies the discussion
    # + commentNumber - The number that identifies the comment
    # + headers - Headers to be sent with the request 
    # + return - Response when the reaction type has already been added to this team discussion comment 
    resource isolated function post orgs/[string org]/teams/[string teamSlug]/discussions/[int discussionNumber]/comments/[int commentNumber]/reactions(CommentNumberReactionsBody payload, map<string|string[]> headers = {}) returns Reaction|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions/${getEncodedUri(discussionNumber)}/comments/${getEncodedUri(commentNumber)}/reactions`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete team discussion comment reaction
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + discussionNumber - The number that identifies the discussion
    # + commentNumber - The number that identifies the comment
    # + reactionId - The unique identifier of the reaction
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string teamSlug]/discussions/[int discussionNumber]/comments/[int commentNumber]/reactions/[int reactionId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions/${getEncodedUri(discussionNumber)}/comments/${getEncodedUri(commentNumber)}/reactions/${getEncodedUri(reactionId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List reactions for a team discussion
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + discussionNumber - The number that identifies the discussion
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string teamSlug]/discussions/[int discussionNumber]/reactions(map<string|string[]> headers = {}, *ReactionsListForTeamDiscussionInOrgQueries queries) returns Reaction[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions/${getEncodedUri(discussionNumber)}/reactions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create reaction for a team discussion
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + discussionNumber - The number that identifies the discussion
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post orgs/[string org]/teams/[string teamSlug]/discussions/[int discussionNumber]/reactions(DiscussionNumberReactionsBody payload, map<string|string[]> headers = {}) returns Reaction|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions/${getEncodedUri(discussionNumber)}/reactions`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete team discussion reaction
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + discussionNumber - The number that identifies the discussion
    # + reactionId - The unique identifier of the reaction
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string teamSlug]/discussions/[int discussionNumber]/reactions/[int reactionId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/discussions/${getEncodedUri(discussionNumber)}/reactions/${getEncodedUri(reactionId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List pending team invitations
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string teamSlug]/invitations(map<string|string[]> headers = {}, *TeamsListPendingInvitationsInOrgQueries queries) returns OrganizationInvitation[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/invitations`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List team members
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string teamSlug]/members(map<string|string[]> headers = {}, *TeamsListMembersInOrgQueries queries) returns SimpleUser[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/members`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get team membership for a user
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string teamSlug]/memberships/[string username](map<string|string[]> headers = {}) returns TeamMembership|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/memberships/${getEncodedUri(username)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Add or update team membership for a user
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/teams/[string teamSlug]/memberships/[string username](MembershipsusernameBody1 payload, map<string|string[]> headers = {}) returns TeamMembership|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/memberships/${getEncodedUri(username)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove team membership for a user
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string teamSlug]/memberships/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/memberships/${getEncodedUri(username)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List team projects
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string teamSlug]/projects(map<string|string[]> headers = {}, *TeamsListProjectsInOrgQueries queries) returns TeamProject[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/projects`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Check team permissions for a project
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + projectId - The unique identifier of the project
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string teamSlug]/projects/[int projectId](map<string|string[]> headers = {}) returns TeamProject|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/projects/${getEncodedUri(projectId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Add or update team project permissions
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + projectId - The unique identifier of the project
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/teams/[string teamSlug]/projects/[int projectId](ProjectsprojectIdBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/projects/${getEncodedUri(projectId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove a project from a team
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + projectId - The unique identifier of the project
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string teamSlug]/projects/[int projectId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/projects/${getEncodedUri(projectId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List team repositories
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string teamSlug]/repos(map<string|string[]> headers = {}, *TeamsListReposInOrgQueries queries) returns MinimalRepository[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/repos`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Check team permissions for a repository
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Alternative response with repository permissions 
    resource isolated function get orgs/[string org]/teams/[string teamSlug]/repos/[string owner]/[string repo](map<string|string[]> headers = {}) returns TeamRepository|error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Add or update team repository permissions
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put orgs/[string org]/teams/[string teamSlug]/repos/[string owner]/[string repo](OwnerrepoBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove a repository from a team
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string teamSlug]/repos/[string owner]/[string repo](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List child teams
    #
    # + org - The organization name. The name is not case sensitive
    # + teamSlug - The slug of the team name
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - if child teams exist 
    resource isolated function get orgs/[string org]/teams/[string teamSlug]/teams(map<string|string[]> headers = {}, *TeamsListChildInOrgQueries queries) returns Team[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(teamSlug)}/teams`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Enable or disable a security feature for an organization
    #
    # + org - The organization name. The name is not case sensitive
    # + securityProduct - The security feature to enable or disable
    # + enablement - The action to take.
    # `enable_all` means to enable the specified security feature for all repositories in the organization.
    # `disable_all` means to disable the specified security feature for all repositories in the organization
    # + headers - Headers to be sent with the request 
    # + return - Action started 
    resource isolated function post orgs/[string org]/["dependency_graph"|"dependabot_alerts"|"dependabot_security_updates"|"advanced_security"|"code_scanning_default_setup"|"secret_scanning"|"secret_scanning_push_protection" securityProduct]/["enable_all"|"disable_all" enablement](SecurityProductenablementBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/${getEncodedUri(securityProduct)}/${getEncodedUri(enablement)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a project card
    #
    # + cardId - The unique identifier of the card
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get projects/columns/cards/[int cardId](map<string|string[]> headers = {}) returns ProjectCard|error? {
        string resourcePath = string `/projects/columns/cards/${getEncodedUri(cardId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a project card
    #
    # + cardId - The unique identifier of the card
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete projects/columns/cards/[int cardId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/projects/columns/cards/${getEncodedUri(cardId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update an existing project card
    #
    # + cardId - The unique identifier of the card
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch projects/columns/cards/[int cardId](CardscardIdBody payload, map<string|string[]> headers = {}) returns ProjectCard|error? {
        string resourcePath = string `/projects/columns/cards/${getEncodedUri(cardId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Move a project card
    #
    # + cardId - The unique identifier of the card
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post projects/columns/cards/[int cardId]/moves(CardIdMovesBody payload, map<string|string[]> headers = {}) returns record {||}|error? {
        string resourcePath = string `/projects/columns/cards/${getEncodedUri(cardId)}/moves`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a project column
    #
    # + columnId - The unique identifier of the column
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get projects/columns/[int columnId](map<string|string[]> headers = {}) returns ProjectColumn|error? {
        string resourcePath = string `/projects/columns/${getEncodedUri(columnId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a project column
    #
    # + columnId - The unique identifier of the column
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete projects/columns/[int columnId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/projects/columns/${getEncodedUri(columnId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update an existing project column
    #
    # + columnId - The unique identifier of the column
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch projects/columns/[int columnId](ColumnscolumnIdBody payload, map<string|string[]> headers = {}) returns ProjectColumn|error? {
        string resourcePath = string `/projects/columns/${getEncodedUri(columnId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List project cards
    #
    # + columnId - The unique identifier of the column
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get projects/columns/[int columnId]/cards(map<string|string[]> headers = {}, *ProjectsListCardsQueries queries) returns ProjectCard[]|error? {
        string resourcePath = string `/projects/columns/${getEncodedUri(columnId)}/cards`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a project card
    #
    # + columnId - The unique identifier of the column
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post projects/columns/[int columnId]/cards(ColumnIdCardsBody payload, map<string|string[]> headers = {}) returns ProjectCard|error? {
        string resourcePath = string `/projects/columns/${getEncodedUri(columnId)}/cards`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Move a project column
    #
    # + columnId - The unique identifier of the column
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post projects/columns/[int columnId]/moves(ColumnIdMovesBody payload, map<string|string[]> headers = {}) returns record {||}|error? {
        string resourcePath = string `/projects/columns/${getEncodedUri(columnId)}/moves`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a project
    #
    # + projectId - The unique identifier of the project
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get projects/[int projectId](map<string|string[]> headers = {}) returns Project|error? {
        string resourcePath = string `/projects/${getEncodedUri(projectId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a project
    #
    # + projectId - The unique identifier of the project
    # + headers - Headers to be sent with the request 
    # + return - Delete Success 
    resource isolated function delete projects/[int projectId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/projects/${getEncodedUri(projectId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a project
    #
    # + projectId - The unique identifier of the project
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch projects/[int projectId](ProjectsprojectIdBody1 payload, map<string|string[]> headers = {}) returns Project|error? {
        string resourcePath = string `/projects/${getEncodedUri(projectId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List project collaborators
    #
    # + projectId - The unique identifier of the project
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get projects/[int projectId]/collaborators(map<string|string[]> headers = {}, *ProjectsListCollaboratorsQueries queries) returns SimpleUser[]|error? {
        string resourcePath = string `/projects/${getEncodedUri(projectId)}/collaborators`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Add project collaborator
    #
    # + projectId - The unique identifier of the project
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put projects/[int projectId]/collaborators/[string username](CollaboratorsusernameBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/projects/${getEncodedUri(projectId)}/collaborators/${getEncodedUri(username)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove user as a collaborator
    #
    # + projectId - The unique identifier of the project
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete projects/[int projectId]/collaborators/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/projects/${getEncodedUri(projectId)}/collaborators/${getEncodedUri(username)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get project permission for a user
    #
    # + projectId - The unique identifier of the project
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get projects/[int projectId]/collaborators/[string username]/permission(map<string|string[]> headers = {}) returns ProjectCollaboratorPermission|error? {
        string resourcePath = string `/projects/${getEncodedUri(projectId)}/collaborators/${getEncodedUri(username)}/permission`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List project columns
    #
    # + projectId - The unique identifier of the project
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get projects/[int projectId]/columns(map<string|string[]> headers = {}, *ProjectsListColumnsQueries queries) returns ProjectColumn[]|error? {
        string resourcePath = string `/projects/${getEncodedUri(projectId)}/columns`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a project column
    #
    # + projectId - The unique identifier of the project
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post projects/[int projectId]/columns(ColumnscolumnIdBody payload, map<string|string[]> headers = {}) returns ProjectColumn|error? {
        string resourcePath = string `/projects/${getEncodedUri(projectId)}/columns`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get rate limit status for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get rate_limit(map<string|string[]> headers = {}) returns RateLimitOverview|error? {
        string resourcePath = string `/rate_limit`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo](map<string|string[]> headers = {}) returns FullRepository|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo](OwnerrepoBody1 payload, map<string|string[]> headers = {}) returns FullRepository|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List artifacts for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/artifacts(map<string|string[]> headers = {}, *ActionsListArtifactsForRepoQueries queries) returns ArtifactResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/artifacts`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an artifact
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + artifactId - The unique identifier of the artifact
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/artifacts/[int artifactId](map<string|string[]> headers = {}) returns Artifact|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/artifacts/${getEncodedUri(artifactId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete an artifact
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + artifactId - The unique identifier of the artifact
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/artifacts/[int artifactId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/artifacts/${getEncodedUri(artifactId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Download an artifact
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + artifactId - The unique identifier of the artifact
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/artifacts/[int artifactId]/[string archiveFormat](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/artifacts/${getEncodedUri(artifactId)}/${getEncodedUri(archiveFormat)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get GitHub Actions cache usage for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/cache/usage(map<string|string[]> headers = {}) returns ActionsCacheUsageByRepository|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/cache/usage`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List GitHub Actions caches for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/caches(map<string|string[]> headers = {}, *ActionsGetActionsCacheListQueries queries) returns ActionsCacheList|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/caches`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete GitHub Actions caches for a repository (using a cache key)
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/caches(map<string|string[]> headers = {}, *ActionsDeleteActionsCacheByKeyQueries queries) returns ActionsCacheList|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/caches`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Delete a GitHub Actions cache for a repository (using a cache ID)
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + cacheId - The unique identifier of the GitHub Actions cache
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/caches/[int cacheId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/caches/${getEncodedUri(cacheId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get a job for a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + jobId - The unique identifier of the job
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/jobs/[int jobId](map<string|string[]> headers = {}) returns Job|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/jobs/${getEncodedUri(jobId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Download job logs for a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + jobId - The unique identifier of the job
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/jobs/[int jobId]/logs(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/jobs/${getEncodedUri(jobId)}/logs`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Re-run a job from a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + jobId - The unique identifier of the job
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/jobs/[int jobId]/rerun(JobIdRerunBody payload, map<string|string[]> headers = {}) returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/jobs/${getEncodedUri(jobId)}/rerun`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get the customization template for an OIDC subject claim for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Status response 
    resource isolated function get repos/[string owner]/[string repo]/actions/oidc/customization/sub(map<string|string[]> headers = {}) returns OidcCustomSubRepo|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/oidc/customization/sub`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set the customization template for an OIDC subject claim for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Empty response 
    resource isolated function put repos/[string owner]/[string repo]/actions/oidc/customization/sub(ActionsOIDCSubjectCustomizationForARepository payload, map<string|string[]> headers = {}) returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/oidc/customization/sub`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # List repository organization secrets
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/organization\-secrets(map<string|string[]> headers = {}, *ActionsListRepoOrganizationSecretsQueries queries) returns ActionsSecretResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/organization-secrets`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List repository organization variables
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/organization\-variables(map<string|string[]> headers = {}, *ActionsListRepoOrganizationVariablesQueries queries) returns ActionsVariableResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/organization-variables`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get GitHub Actions permissions for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/permissions(map<string|string[]> headers = {}) returns ActionsRepositoryPermissions|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set GitHub Actions permissions for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/actions/permissions(ActionsPermissionsBody1 payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Get the level of access for workflows outside of the repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/permissions/access(map<string|string[]> headers = {}) returns ActionsWorkflowAccessToRepository|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions/access`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set the level of access for workflows outside of the repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/actions/permissions/access(ActionsWorkflowAccessToRepository payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions/access`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Get allowed actions and reusable workflows for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/permissions/selected\-actions(map<string|string[]> headers = {}) returns SelectedActions|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions/selected-actions`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set allowed actions and reusable workflows for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/actions/permissions/selected\-actions(SelectedActions payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions/selected-actions`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Get default workflow permissions for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/permissions/workflow(map<string|string[]> headers = {}) returns ActionsGetDefaultWorkflowPermissions|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions/workflow`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set default workflow permissions for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Success response 
    resource isolated function put repos/[string owner]/[string repo]/actions/permissions/workflow(ActionsSetDefaultWorkflowPermissions payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions/workflow`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # List self-hosted runners for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runners(map<string|string[]> headers = {}, *ActionsListSelfHostedRunnersForRepoQueries queries) returns RunnerResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List runner applications for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runners/downloads(map<string|string[]> headers = {}) returns RunnerApplication[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/downloads`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create configuration for a just-in-time runner for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runners/generate\-jitconfig(RunnersGenerateJitconfigBody payload, map<string|string[]> headers = {}) returns JitConfig|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/generate-jitconfig`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Create a registration token for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runners/registration\-token(map<string|string[]> headers = {}) returns AuthenticationToken|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/registration-token`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Create a remove token for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runners/remove\-token(map<string|string[]> headers = {}) returns AuthenticationToken|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/remove-token`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a self-hosted runner for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runnerId - Unique identifier of the self-hosted runner
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runners/[int runnerId](map<string|string[]> headers = {}) returns Runner|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/${getEncodedUri(runnerId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a self-hosted runner from a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runnerId - Unique identifier of the self-hosted runner
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/runners/[int runnerId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/${getEncodedUri(runnerId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List labels for a self-hosted runner for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runnerId - Unique identifier of the self-hosted runner
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runners/[int runnerId]/labels(map<string|string[]> headers = {}) returns RunnerLabelResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/${getEncodedUri(runnerId)}/labels`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set custom labels for a self-hosted runner for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runnerId - Unique identifier of the self-hosted runner
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/actions/runners/[int runnerId]/labels(RunnerIdLabelsBody payload, map<string|string[]> headers = {}) returns RunnerLabelResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/${getEncodedUri(runnerId)}/labels`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Add custom labels to a self-hosted runner for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runnerId - Unique identifier of the self-hosted runner
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runners/[int runnerId]/labels(RunnerIdLabelsBody1 payload, map<string|string[]> headers = {}) returns RunnerLabelResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/${getEncodedUri(runnerId)}/labels`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Remove all custom labels from a self-hosted runner for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runnerId - Unique identifier of the self-hosted runner
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/runners/[int runnerId]/labels(map<string|string[]> headers = {}) returns RunnerLabelResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/${getEncodedUri(runnerId)}/labels`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Remove a custom label from a self-hosted runner for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runnerId - Unique identifier of the self-hosted runner
    # + name - The name of a self-hosted runner's custom label
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/runners/[int runnerId]/labels/[string name](map<string|string[]> headers = {}) returns RunnerLabelResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/${getEncodedUri(runnerId)}/labels/${getEncodedUri(name)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List workflow runs for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs(map<string|string[]> headers = {}, *ActionsListWorkflowRunsForRepoQueries queries) returns WorkflowRunResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int runId](map<string|string[]> headers = {}, *ActionsGetWorkflowRunQueries queries) returns WorkflowRun|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/runs/[int runId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get the review history for a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int runId]/approvals(map<string|string[]> headers = {}) returns EnvironmentApprovals[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/approvals`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Approve a workflow run for a fork pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runs/[int runId]/approve(map<string|string[]> headers = {}) returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/approve`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List workflow run artifacts
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int runId]/artifacts(map<string|string[]> headers = {}, *ActionsListWorkflowRunArtifactsQueries queries) returns ArtifactResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/artifacts`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a workflow run attempt
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + attemptNumber - The attempt number of the workflow run
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int runId]/attempts/[int attemptNumber](map<string|string[]> headers = {}, *ActionsGetWorkflowRunAttemptQueries queries) returns WorkflowRun|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/attempts/${getEncodedUri(attemptNumber)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List jobs for a workflow run attempt
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + attemptNumber - The attempt number of the workflow run
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int runId]/attempts/[int attemptNumber]/jobs(map<string|string[]> headers = {}, *ActionsListJobsForWorkflowRunAttemptQueries queries) returns JobResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/attempts/${getEncodedUri(attemptNumber)}/jobs`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Download workflow run attempt logs
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + attemptNumber - The attempt number of the workflow run
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int runId]/attempts/[int attemptNumber]/logs(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/attempts/${getEncodedUri(attemptNumber)}/logs`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Cancel a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runs/[int runId]/cancel(map<string|string[]> headers = {}) returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/cancel`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Review custom deployment protection rules for a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runs/[int runId]/deployment_protection_rule(RunIdDeploymentProtectionRuleBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/deployment_protection_rule`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Force cancel a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runs/[int runId]/force\-cancel(map<string|string[]> headers = {}) returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/force-cancel`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List jobs for a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int runId]/jobs(map<string|string[]> headers = {}, *ActionsListJobsForWorkflowRunQueries queries) returns JobResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/jobs`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Download workflow run logs
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int runId]/logs(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/logs`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete workflow run logs
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/runs/[int runId]/logs(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/logs`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get pending deployments for a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int runId]/pending_deployments(map<string|string[]> headers = {}) returns PendingDeployment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/pending_deployments`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Review pending deployments for a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runs/[int runId]/pending_deployments(RunIdPendingDeploymentsBody payload, map<string|string[]> headers = {}) returns Deployment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/pending_deployments`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Re-run a workflow
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runs/[int runId]/rerun(JobIdRerunBody payload, map<string|string[]> headers = {}) returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/rerun`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Re-run failed jobs from a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runs/[int runId]/rerun\-failed\-jobs(JobIdRerunBody payload, map<string|string[]> headers = {}) returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/rerun-failed-jobs`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get workflow run usage
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + runId - The unique identifier of the workflow run
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int runId]/timing(map<string|string[]> headers = {}) returns WorkflowRunUsage|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(runId)}/timing`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List repository secrets
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/secrets(map<string|string[]> headers = {}, *ActionsListRepoSecretsQueries queries) returns ActionsSecretResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/secrets`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a repository public key
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/secrets/public\-key(map<string|string[]> headers = {}) returns ActionsPublicKey|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/secrets/public-key`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/secrets/[string secretName](map<string|string[]> headers = {}) returns ActionsSecret|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create or update a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response when creating a secret 
    resource isolated function put repos/[string owner]/[string repo]/actions/secrets/[string secretName](SecretssecretNameBody3 payload, map<string|string[]> headers = {}) returns EmptyObject|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/secrets/${getEncodedUri(secretName)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/secrets/[string secretName](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List repository variables
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/variables(map<string|string[]> headers = {}, *ActionsListRepoVariablesQueries queries) returns ActionsVariableResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/variables`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a repository variable
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/variables(ActionsVariablesBody1 payload, map<string|string[]> headers = {}) returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/variables`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a repository variable
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + name - The name of the variable
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/variables/[string name](map<string|string[]> headers = {}) returns ActionsVariable|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/variables/${getEncodedUri(name)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a repository variable
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + name - The name of the variable
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/variables/[string name](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/variables/${getEncodedUri(name)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a repository variable
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + name - The name of the variable
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/actions/variables/[string name](VariablesnameBody1 payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/variables/${getEncodedUri(name)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List repository workflows
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/workflows(map<string|string[]> headers = {}, *ActionsListRepoWorkflowsQueries queries) returns WorkflowResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/workflows`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a workflow
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + workflowId - The ID of the workflow. You can also pass the workflow file name as a string
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/workflows/[workflowId workflowId](map<string|string[]> headers = {}) returns Workflow|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/workflows/${getEncodedUri(workflowId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Disable a workflow
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + workflowId - The ID of the workflow. You can also pass the workflow file name as a string
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/actions/workflows/[workflowId workflowId]/disable(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/workflows/${getEncodedUri(workflowId)}/disable`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Create a workflow dispatch event
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + workflowId - The ID of the workflow. You can also pass the workflow file name as a string
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/workflows/[workflowId workflowId]/dispatches(WorkflowIdDispatchesBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/workflows/${getEncodedUri(workflowId)}/dispatches`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Enable a workflow
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + workflowId - The ID of the workflow. You can also pass the workflow file name as a string
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/actions/workflows/[workflowId workflowId]/enable(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/workflows/${getEncodedUri(workflowId)}/enable`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # List workflow runs for a workflow
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + workflowId - The ID of the workflow. You can also pass the workflow file name as a string
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/workflows/[workflowId workflowId]/runs(map<string|string[]> headers = {}, *ActionsListWorkflowRunsQueries queries) returns WorkflowRunResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/workflows/${getEncodedUri(workflowId)}/runs`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get workflow usage
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + workflowId - The ID of the workflow. You can also pass the workflow file name as a string
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/workflows/[workflowId workflowId]/timing(map<string|string[]> headers = {}) returns WorkflowUsage|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/workflows/${getEncodedUri(workflowId)}/timing`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List repository activities
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/activity(map<string|string[]> headers = {}, *ReposListActivitiesQueries queries) returns Activity[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/activity`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List assignees
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/assignees(map<string|string[]> headers = {}, *IssuesListAssigneesQueries queries) returns SimpleUser[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/assignees`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Check if a user can be assigned
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - If the `assignee` can be assigned to issues in the repository, a `204` header with no content is returned 
    resource isolated function get repos/[string owner]/[string repo]/assignees/[string assignee](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/assignees/${getEncodedUri(assignee)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List all autolinks of a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/autolinks(map<string|string[]> headers = {}, *ReposListAutolinksQueries queries) returns Autolink[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/autolinks`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create an autolink reference for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - response 
    resource isolated function post repos/[string owner]/[string repo]/autolinks(RepoAutolinksBody payload, map<string|string[]> headers = {}) returns Autolink|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/autolinks`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get an autolink reference of a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + autolinkId - The unique identifier of the autolink
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/autolinks/[int autolinkId](map<string|string[]> headers = {}) returns Autolink|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/autolinks/${getEncodedUri(autolinkId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete an autolink reference from a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + autolinkId - The unique identifier of the autolink
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/autolinks/[int autolinkId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/autolinks/${getEncodedUri(autolinkId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Check if automated security fixes are enabled for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response if dependabot is enabled 
    resource isolated function get repos/[string owner]/[string repo]/automated\-security\-fixes(map<string|string[]> headers = {}) returns CheckAutomatedSecurityFixes|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/automated-security-fixes`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Enable automated security fixes
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/automated\-security\-fixes(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/automated-security-fixes`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Disable automated security fixes
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/automated\-security\-fixes(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/automated-security-fixes`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List branches
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches(map<string|string[]> headers = {}, *ReposListBranchesQueries queries) returns ShortBranch[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch](map<string|string[]> headers = {}) returns BranchWithProtection|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get branch protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection(map<string|string[]> headers = {}) returns BranchProtection|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update branch protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/branches/[string branch]/protection(BranchProtectionBody payload, map<string|string[]> headers = {}) returns ProtectedBranch|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete branch protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get admin branch protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/enforce_admins(map<string|string[]> headers = {}) returns ProtectedBranchAdminEnforced|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/enforce_admins`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set admin branch protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/branches/[string branch]/protection/enforce_admins(map<string|string[]> headers = {}) returns ProtectedBranchAdminEnforced|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/enforce_admins`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete admin branch protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/enforce_admins(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/enforce_admins`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get pull request review protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/required_pull_request_reviews(map<string|string[]> headers = {}) returns ProtectedBranchPullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_pull_request_reviews`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete pull request review protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/required_pull_request_reviews(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_pull_request_reviews`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update pull request review protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/branches/[string branch]/protection/required_pull_request_reviews(ProtectionRequiredPullRequestReviewsBody payload, map<string|string[]> headers = {}) returns ProtectedBranchPullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_pull_request_reviews`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Get commit signature protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/required_signatures(map<string|string[]> headers = {}) returns ProtectedBranchAdminEnforced|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_signatures`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create commit signature protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/branches/[string branch]/protection/required_signatures(map<string|string[]> headers = {}) returns ProtectedBranchAdminEnforced|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_signatures`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete commit signature protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/required_signatures(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_signatures`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get status checks protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/required_status_checks(map<string|string[]> headers = {}) returns StatusCheckPolicy|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_status_checks`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Remove status check protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/required_status_checks(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_status_checks`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update status check protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/branches/[string branch]/protection/required_status_checks(ProtectionRequiredStatusChecksBody payload, map<string|string[]> headers = {}) returns StatusCheckPolicy|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_status_checks`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Get all status check contexts
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/required_status_checks/contexts(map<string|string[]> headers = {}) returns string[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_status_checks/contexts`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set status check contexts
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/branches/[string branch]/protection/required_status_checks/contexts(RequiredStatusChecksContextsBody payload, map<string|string[]> headers = {}) returns string[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_status_checks/contexts`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Add status check contexts
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/branches/[string branch]/protection/required_status_checks/contexts(RequiredStatusChecksContextsBody1 payload, map<string|string[]> headers = {}) returns string[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_status_checks/contexts`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Remove status check contexts
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/required_status_checks/contexts(RequiredStatusChecksContextsBody2 payload, map<string|string[]> headers = {}) returns string[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_status_checks/contexts`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # Get access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions(map<string|string[]> headers = {}) returns BranchRestrictionPolicy|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get apps with access to the protected branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/apps(map<string|string[]> headers = {}) returns Integration[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/apps`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set app access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/apps(RestrictionsAppsBody payload, map<string|string[]> headers = {}) returns Integration[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/apps`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Add app access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/apps(RestrictionsAppsBody1 payload, map<string|string[]> headers = {}) returns Integration[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/apps`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Remove app access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/apps(RestrictionsAppsBody2 payload, map<string|string[]> headers = {}) returns Integration[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/apps`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # Get teams with access to the protected branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/teams(map<string|string[]> headers = {}) returns Team[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/teams`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set team access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/teams(RestrictionsTeamsBody payload, map<string|string[]> headers = {}) returns Team[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/teams`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Add team access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/teams(RestrictionsTeamsBody1 payload, map<string|string[]> headers = {}) returns Team[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/teams`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Remove team access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/teams(RestrictionsTeamsBody2 payload, map<string|string[]> headers = {}) returns Team[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/teams`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # Get users with access to the protected branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/users(map<string|string[]> headers = {}) returns SimpleUser[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/users`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set user access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/users(RestrictionsUsersBody payload, map<string|string[]> headers = {}) returns SimpleUser[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/users`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Add user access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/users(RestrictionsUsersBody1 payload, map<string|string[]> headers = {}) returns SimpleUser[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/users`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Remove user access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/users(RestrictionsUsersBody2 payload, map<string|string[]> headers = {}) returns SimpleUser[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/users`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # Rename a branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/branches/[string branch]/rename(BranchRenameBody payload, map<string|string[]> headers = {}) returns BranchWithProtection|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/rename`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Create a check run
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/check\-runs(RepoCheckRunsBody payload, map<string|string[]> headers = {}) returns CheckRun|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-runs`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a repository security advisory
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ghsaId - The GHSA (GitHub Security Advisory) identifier of the advisory
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/check\-runs/[int checkRunId](map<string|string[]> headers = {}) returns CheckRun|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-runs/${getEncodedUri(checkRunId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a repository security advisory
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ghsaId - The GHSA (GitHub Security Advisory) identifier of the advisory
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/check\-runs/[int checkRunId](CheckRunscheckRunIdBody payload, map<string|string[]> headers = {}) returns CheckRun|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-runs/${getEncodedUri(checkRunId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List check run annotations
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + checkRunId - The unique identifier of the check run
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/check\-runs/[int checkRunId]/annotations(map<string|string[]> headers = {}, *ChecksListAnnotationsQueries queries) returns CheckAnnotation[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-runs/${getEncodedUri(checkRunId)}/annotations`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Rerequest a check suite
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + checkSuiteId - The unique identifier of the check suite
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/check\-runs/[int checkRunId]/rerequest(map<string|string[]> headers = {}) returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-runs/${getEncodedUri(checkRunId)}/rerequest`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Create a check suite
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response when the suite already exists 
    resource isolated function post repos/[string owner]/[string repo]/check\-suites(RepoCheckSuitesBody payload, map<string|string[]> headers = {}) returns CheckSuite|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-suites`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Update repository preferences for check suites
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/check\-suites/preferences(CheckSuitesPreferencesBody payload, map<string|string[]> headers = {}) returns CheckSuitePreference|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-suites/preferences`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Get a repository security advisory
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ghsaId - The GHSA (GitHub Security Advisory) identifier of the advisory
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/check\-suites/[int checkSuiteId](map<string|string[]> headers = {}) returns CheckSuite|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-suites/${getEncodedUri(checkSuiteId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List check runs in a check suite
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + checkSuiteId - The unique identifier of the check suite
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/check\-suites/[int checkSuiteId]/check\-runs(map<string|string[]> headers = {}, *ChecksListForSuiteQueries queries) returns CheckRunResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-suites/${getEncodedUri(checkSuiteId)}/check-runs`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Rerequest a check suite
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + checkSuiteId - The unique identifier of the check suite
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/check\-suites/[int checkSuiteId]/rerequest(map<string|string[]> headers = {}) returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-suites/${getEncodedUri(checkSuiteId)}/rerequest`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List secret scanning alerts for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/alerts(map<string|string[]> headers = {}, *CodeScanningListAlertsForRepoQueries queries) returns CodeScanningAlertItems[]|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/alerts`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a secret scanning alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + alertNumber - The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the `number` field in the response from the `GET /repos/{owner}/{repo}/code-scanning/alerts` operation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/alerts/[AlertNumber alertNumber](map<string|string[]> headers = {}) returns CodeScanningAlert|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/alerts/${getEncodedUri(alertNumber)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a secret scanning alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + alertNumber - The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the `number` field in the response from the `GET /repos/{owner}/{repo}/code-scanning/alerts` operation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/code\-scanning/alerts/[AlertNumber alertNumber](AlertsalertNumberBody payload, map<string|string[]> headers = {}) returns CodeScanningAlert|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/alerts/${getEncodedUri(alertNumber)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List instances of a code scanning alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + alertNumber - The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the `number` field in the response from the `GET /repos/{owner}/{repo}/code-scanning/alerts` operation
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/alerts/[AlertNumber alertNumber]/instances(map<string|string[]> headers = {}, *CodeScanningListAlertInstancesQueries queries) returns CodeScanningAlertInstance[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/alerts/${getEncodedUri(alertNumber)}/instances`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List code scanning analyses for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/analyses(map<string|string[]> headers = {}, *CodeScanningListRecentAnalysesQueries queries) returns CodeScanningAnalysis[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/analyses`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a code scanning analysis for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + analysisId - The ID of the analysis, as returned from the `GET /repos/{owner}/{repo}/code-scanning/analyses` operation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/analyses/[int analysisId](map<string|string[]> headers = {}) returns CodeScanningAnalysis|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/analyses/${getEncodedUri(analysisId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a code scanning analysis from a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + analysisId - The ID of the analysis, as returned from the `GET /repos/{owner}/{repo}/code-scanning/analyses` operation
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/code\-scanning/analyses/[int analysisId](map<string|string[]> headers = {}, *CodeScanningDeleteAnalysisQueries queries) returns CodeScanningAnalysisDeletion|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/analyses/${getEncodedUri(analysisId)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List CodeQL databases for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/codeql/databases(map<string|string[]> headers = {}) returns CodeScanningCodeqlDatabase[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/codeql/databases`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a CodeQL database for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + language - The language of the CodeQL database
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/codeql/databases/[string language](map<string|string[]> headers = {}) returns CodeScanningCodeqlDatabase|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/codeql/databases/${getEncodedUri(language)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a code scanning default setup configuration
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/default\-setup(map<string|string[]> headers = {}) returns CodeScanningDefaultSetup|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/default-setup`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a code scanning default setup configuration
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/code\-scanning/default\-setup(CodeScanningDefaultSetupUpdate payload, map<string|string[]> headers = {}) returns EmptyObject|CodeScanningDefaultSetupUpdateResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/default-setup`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Upload an analysis as SARIF data
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/code\-scanning/sarifs(CodeScanningSarifsBody payload, map<string|string[]> headers = {}) returns CodeScanningSarifsReceipt|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/sarifs`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get information about a SARIF upload
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + sarifId - The SARIF ID obtained after uploading
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/sarifs/[string sarifId](map<string|string[]> headers = {}) returns CodeScanningSarifsStatus|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/sarifs/${getEncodedUri(sarifId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List CODEOWNERS errors
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/codeowners/errors(map<string|string[]> headers = {}, *ReposCodeownersErrorsQueries queries) returns CodeownersErrors|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codeowners/errors`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List codespaces in a repository for the authenticated user
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/codespaces(map<string|string[]> headers = {}, *CodespacesListInRepositoryForAuthenticatedUserQueries queries) returns CodespaceResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a codespace in a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response when the codespace was successfully created 
    resource isolated function post repos/[string owner]/[string repo]/codespaces(RepoCodespacesBody payload, map<string|string[]> headers = {}) returns Codespace|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List devcontainer configurations in a repository for the authenticated user
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/codespaces/devcontainers(map<string|string[]> headers = {}, *CodespacesListDevcontainersInRepositoryForAuthenticatedUserQueries queries) returns DevcontainersResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/devcontainers`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List available machine types for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/codespaces/machines(map<string|string[]> headers = {}, *CodespacesRepoMachinesForAuthenticatedUserQueries queries) returns CodespaceMachineResponse|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/machines`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get default attributes for a codespace
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response when a user is able to create codespaces from the repository 
    resource isolated function get repos/[string owner]/[string repo]/codespaces/'new(map<string|string[]> headers = {}, *CodespacesPreFlightWithRepoForAuthenticatedUserQueries queries) returns CodespaceDefaultResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/new`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Check if permissions defined by a devcontainer have been accepted by the authenticated user
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response when the permission check is successful 
    resource isolated function get repos/[string owner]/[string repo]/codespaces/permissions_check(map<string|string[]> headers = {}, *CodespacesCheckPermissionsForDevcontainerQueries queries) returns CodespacesPermissionsCheckForDevcontainer|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/permissions_check`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List repository secrets
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/codespaces/secrets(map<string|string[]> headers = {}, *CodespacesListRepoSecretsQueries queries) returns RepoCodespacesSecretResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/secrets`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a repository public key
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/codespaces/secrets/public\-key(map<string|string[]> headers = {}) returns CodespacesPublicKey|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/secrets/public-key`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/codespaces/secrets/[string secretName](map<string|string[]> headers = {}) returns RepoCodespacesSecret|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create or update a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response when creating a secret 
    resource isolated function put repos/[string owner]/[string repo]/codespaces/secrets/[string secretName](SecretssecretNameBody4 payload, map<string|string[]> headers = {}) returns EmptyObject|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/secrets/${getEncodedUri(secretName)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/codespaces/secrets/[string secretName](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List repository collaborators
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/collaborators(map<string|string[]> headers = {}, *ReposListCollaboratorsQueries queries) returns Collaborator[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/collaborators`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Check if a user is a repository collaborator
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response if user is a collaborator 
    resource isolated function get repos/[string owner]/[string repo]/collaborators/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/collaborators/${getEncodedUri(username)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Add a repository collaborator
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response when a new invitation is created 
    resource isolated function put repos/[string owner]/[string repo]/collaborators/[string username](CollaboratorsusernameBody1 payload, map<string|string[]> headers = {}) returns RepositoryInvitation|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/collaborators/${getEncodedUri(username)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove a repository collaborator
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - No Content when collaborator was removed from the repository 
    resource isolated function delete repos/[string owner]/[string repo]/collaborators/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/collaborators/${getEncodedUri(username)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get repository permissions for a user
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - if user has admin permissions 
    resource isolated function get repos/[string owner]/[string repo]/collaborators/[string username]/permission(map<string|string[]> headers = {}) returns RepositoryCollaboratorPermission|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/collaborators/${getEncodedUri(username)}/permission`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List commit comments for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/comments(map<string|string[]> headers = {}, *ReposListCommitCommentsForRepoQueries queries) returns CommitComment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/comments`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a commit comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/comments/[int commentId](map<string|string[]> headers = {}) returns CommitComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/comments/${getEncodedUri(commentId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a commit comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/comments/[int commentId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/comments/${getEncodedUri(commentId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a commit comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/comments/[int commentId](CommentscommentIdBody payload, map<string|string[]> headers = {}) returns CommitComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/comments/${getEncodedUri(commentId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List reactions for a commit comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/comments/[int commentId]/reactions(map<string|string[]> headers = {}, *ReactionsListForCommitCommentQueries queries) returns Reaction[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/comments/${getEncodedUri(commentId)}/reactions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create reaction for a commit comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Reaction exists 
    resource isolated function post repos/[string owner]/[string repo]/comments/[int commentId]/reactions(CommentIdReactionsBody payload, map<string|string[]> headers = {}) returns Reaction|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/comments/${getEncodedUri(commentId)}/reactions`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete a commit comment reaction
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + reactionId - The unique identifier of the reaction
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/comments/[int commentId]/reactions/[int reactionId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/comments/${getEncodedUri(commentId)}/reactions/${getEncodedUri(reactionId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List commits
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits(map<string|string[]> headers = {}, *ReposListCommitsQueries queries) returns Commit[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List branches for HEAD commit
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commitSha - The SHA of the commit
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string commitSha]/branches\-where\-head(map<string|string[]> headers = {}) returns BranchShort[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(commitSha)}/branches-where-head`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List commit comments
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commitSha - The SHA of the commit
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string commitSha]/comments(map<string|string[]> headers = {}, *ReposListCommentsForCommitQueries queries) returns CommitComment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(commitSha)}/comments`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a commit comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commitSha - The SHA of the commit
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/commits/[string commitSha]/comments(CommitShaCommentsBody payload, map<string|string[]> headers = {}) returns CommitComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(commitSha)}/comments`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List pull requests associated with a commit
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commitSha - The SHA of the commit
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string commitSha]/pulls(map<string|string[]> headers = {}, *ReposListPullRequestsAssociatedWithCommitQueries queries) returns PullRequestSimple[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(commitSha)}/pulls`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a commit
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string ref](map<string|string[]> headers = {}, *ReposGetCommitQueries queries) returns Commit|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(ref)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List check runs for a Git reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string ref]/check\-runs(map<string|string[]> headers = {}, *ChecksListForRefQueries queries) returns CheckRunResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(ref)}/check-runs`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List check suites for a Git reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string ref]/check\-suites(map<string|string[]> headers = {}, *ChecksListSuitesForRefQueries queries) returns CheckSuiteResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(ref)}/check-suites`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get the combined status for a specific reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string ref]/status(map<string|string[]> headers = {}, *ReposGetCombinedStatusForRefQueries queries) returns CombinedCommitStatus|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(ref)}/status`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List commit statuses for a reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string ref]/statuses(map<string|string[]> headers = {}, *ReposListCommitStatusesForRefQueries queries) returns Status[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(ref)}/statuses`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get community profile metrics
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/community/profile(map<string|string[]> headers = {}) returns CommunityProfile|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/community/profile`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Compare two commits
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + basehead - The base branch and head branch to compare. This parameter expects the format `BASE...HEAD`. Both must be branch names in `repo`. To compare with a branch that exists in a different repository in the same network as `repo`, the `basehead` parameter expects the format `USERNAME:BASE...USERNAME:HEAD`
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/compare/[string basehead](map<string|string[]> headers = {}, *ReposCompareCommitsQueries queries) returns CommitComparison|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/compare/${getEncodedUri(basehead)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get repository content
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + path - path parameter
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/contents/[string path](map<string|string[]> headers = {}, *ReposGetContentQueries queries) returns InlineResponse200|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/contents/${getEncodedUri(path)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create or update file contents
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + path - path parameter
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/contents/[string path](ContentspathBody payload, map<string|string[]> headers = {}) returns FileCommit|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/contents/${getEncodedUri(path)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete a file
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + path - path parameter
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/contents/[string path](ContentspathBody1 payload, map<string|string[]> headers = {}) returns FileCommit|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/contents/${getEncodedUri(path)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # List repository contributors
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - If repository contains content 
    resource isolated function get repos/[string owner]/[string repo]/contributors(map<string|string[]> headers = {}, *ReposListContributorsQueries queries) returns Contributor[]|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/contributors`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List Dependabot alerts for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/dependabot/alerts(map<string|string[]> headers = {}, *DependabotListAlertsForRepoQueries queries) returns DependabotAlert[]|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/alerts`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a Dependabot alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + alertNumber - The number that identifies a Dependabot alert in its repository.
    # You can find this at the end of the URL for a Dependabot alert within GitHub,
    # or in `number` fields in the response from the
    # `GET /repos/{owner}/{repo}/dependabot/alerts` operation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/dependabot/alerts/[AlertNumber alertNumber](map<string|string[]> headers = {}) returns DependabotAlert|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/alerts/${getEncodedUri(alertNumber)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a Dependabot alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + alertNumber - The number that identifies a Dependabot alert in its repository.
    # You can find this at the end of the URL for a Dependabot alert within GitHub,
    # or in `number` fields in the response from the
    # `GET /repos/{owner}/{repo}/dependabot/alerts` operation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/dependabot/alerts/[AlertNumber alertNumber](AlertsalertNumberBody1 payload, map<string|string[]> headers = {}) returns DependabotAlert|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/alerts/${getEncodedUri(alertNumber)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List repository secrets
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/dependabot/secrets(map<string|string[]> headers = {}, *DependabotListRepoSecretsQueries queries) returns DependabotSecretResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/secrets`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a repository public key
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/dependabot/secrets/public\-key(map<string|string[]> headers = {}) returns DependabotPublicKey|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/secrets/public-key`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/dependabot/secrets/[string secretName](map<string|string[]> headers = {}) returns DependabotSecret|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create or update a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response when creating a secret 
    resource isolated function put repos/[string owner]/[string repo]/dependabot/secrets/[string secretName](SecretssecretNameBody5 payload, map<string|string[]> headers = {}) returns EmptyObject|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/secrets/${getEncodedUri(secretName)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/dependabot/secrets/[string secretName](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get a diff of the dependencies between commits
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + basehead - The base and head Git revisions to compare. The Git revisions will be resolved to commit SHAs. Named revisions will be resolved to their corresponding HEAD commits, and an appropriate merge base will be determined. This parameter expects the format `{base}...{head}`
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/dependency\-graph/compare/[string basehead](map<string|string[]> headers = {}, *DependencyGraphDiffRangeQueries queries) returns DependencyGraphDiff|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependency-graph/compare/${getEncodedUri(basehead)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Export a software bill of materials (SBOM) for a repository.
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/dependency\-graph/sbom(map<string|string[]> headers = {}) returns DependencyGraphSpdxSbom|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependency-graph/sbom`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a snapshot of dependencies for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/dependency\-graph/snapshots(Snapshot payload, map<string|string[]> headers = {}) returns SnapshotResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependency-graph/snapshots`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List deployments
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/deployments(map<string|string[]> headers = {}, *ReposListDeploymentsQueries queries) returns Deployment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/deployments`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a deployment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/deployments(RepoDeploymentsBody payload, map<string|string[]> headers = {}) returns Deployment|MergedBranchResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/deployments`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a deployment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + deploymentId - deployment_id parameter
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/deployments/[int deploymentId](map<string|string[]> headers = {}) returns Deployment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/deployments/${getEncodedUri(deploymentId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a deployment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + deploymentId - deployment_id parameter
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/deployments/[int deploymentId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/deployments/${getEncodedUri(deploymentId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List deployment statuses
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + deploymentId - deployment_id parameter
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/deployments/[int deploymentId]/statuses(map<string|string[]> headers = {}, *ReposListDeploymentStatusesQueries queries) returns DeploymentStatus[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/deployments/${getEncodedUri(deploymentId)}/statuses`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a deployment status
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + deploymentId - deployment_id parameter
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/deployments/[int deploymentId]/statuses(DeploymentIdStatusesBody payload, map<string|string[]> headers = {}) returns DeploymentStatus|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/deployments/${getEncodedUri(deploymentId)}/statuses`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a deployment status
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + deploymentId - deployment_id parameter
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/deployments/[int deploymentId]/statuses/[int statusId](map<string|string[]> headers = {}) returns DeploymentStatus|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/deployments/${getEncodedUri(deploymentId)}/statuses/${getEncodedUri(statusId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a repository dispatch event
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/dispatches(RepoDispatchesBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dispatches`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List environments
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/environments(map<string|string[]> headers = {}, *ReposGetAllEnvironmentsQueries queries) returns EnvironmentResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an environment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + environmentName - The name of the environment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/environments/[string environmentName](map<string|string[]> headers = {}) returns Environment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environmentName)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create or update an environment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + environmentName - The name of the environment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/environments/[string environmentName](EnvironmentsenvironmentNameBody payload, map<string|string[]> headers = {}) returns Environment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environmentName)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete an environment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + environmentName - The name of the environment
    # + headers - Headers to be sent with the request 
    # + return - Default response 
    resource isolated function delete repos/[string owner]/[string repo]/environments/[string environmentName](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environmentName)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List deployment branch policies
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + environmentName - The name of the environment
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/environments/[string environmentName]/deployment\-branch\-policies(map<string|string[]> headers = {}, *ReposListDeploymentBranchPoliciesQueries queries) returns DeploymentBranchPolicyResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environmentName)}/deployment-branch-policies`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a deployment branch policy
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + environmentName - The name of the environment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/environments/[string environmentName]/deployment\-branch\-policies(DeploymentBranchPolicyNamePatternWithType payload, map<string|string[]> headers = {}) returns DeploymentBranchPolicy|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environmentName)}/deployment-branch-policies`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a deployment branch policy
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + environmentName - The name of the environment
    # + branchPolicyId - The unique identifier of the branch policy
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/environments/[string environmentName]/deployment\-branch\-policies/[int branchPolicyId](map<string|string[]> headers = {}) returns DeploymentBranchPolicy|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environmentName)}/deployment-branch-policies/${getEncodedUri(branchPolicyId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a deployment branch policy
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + environmentName - The name of the environment
    # + branchPolicyId - The unique identifier of the branch policy
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/environments/[string environmentName]/deployment\-branch\-policies/[int branchPolicyId](DeploymentBranchPolicyNamePattern payload, map<string|string[]> headers = {}) returns DeploymentBranchPolicy|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environmentName)}/deployment-branch-policies/${getEncodedUri(branchPolicyId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete a deployment branch policy
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + environmentName - The name of the environment
    # + branchPolicyId - The unique identifier of the branch policy
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/environments/[string environmentName]/deployment\-branch\-policies/[int branchPolicyId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environmentName)}/deployment-branch-policies/${getEncodedUri(branchPolicyId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get all deployment protection rules for an environment
    #
    # + environmentName - The name of the environment
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + owner - The account owner of the repository. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - List of deployment protection rules 
    resource isolated function get repos/[string owner]/[string repo]/environments/[string environmentName]/deployment_protection_rules(map<string|string[]> headers = {}) returns DeploymentProtectionRuleResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environmentName)}/deployment_protection_rules`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a custom deployment protection rule on an environment
    #
    # + environmentName - The name of the environment
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + owner - The account owner of the repository. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - The enabled custom deployment protection rule 
    resource isolated function post repos/[string owner]/[string repo]/environments/[string environmentName]/deployment_protection_rules(EnvironmentNameDeploymentProtectionRulesBody payload, map<string|string[]> headers = {}) returns DeploymentProtectionRule|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environmentName)}/deployment_protection_rules`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List custom deployment rule integrations available for an environment
    #
    # + environmentName - The name of the environment
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + owner - The account owner of the repository. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A list of custom deployment rule integrations available for this environment 
    resource isolated function get repos/[string owner]/[string repo]/environments/[string environmentName]/deployment_protection_rules/apps(map<string|string[]> headers = {}, *ReposListCustomDeploymentRuleIntegrationsQueries queries) returns CustomDeploymentRuleAppResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environmentName)}/deployment_protection_rules/apps`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a custom deployment protection rule
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + environmentName - The name of the environment
    # + protectionRuleId - The unique identifier of the protection rule
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/environments/[string environmentName]/deployment_protection_rules/[int protectionRuleId](map<string|string[]> headers = {}) returns DeploymentProtectionRule|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environmentName)}/deployment_protection_rules/${getEncodedUri(protectionRuleId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Disable a custom protection rule for an environment
    #
    # + environmentName - The name of the environment
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + owner - The account owner of the repository. The name is not case sensitive
    # + protectionRuleId - The unique identifier of the protection rule
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/environments/[string environmentName]/deployment_protection_rules/[int protectionRuleId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environmentName)}/deployment_protection_rules/${getEncodedUri(protectionRuleId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List repository events
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/events(map<string|string[]> headers = {}, *ActivityListRepoEventsQueries queries) returns Event[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/events`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List forks
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/forks(map<string|string[]> headers = {}, *ReposListForksQueries queries) returns MinimalRepository[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/forks`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a fork
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/forks(RepoForksBody payload, map<string|string[]> headers = {}) returns FullRepository|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/forks`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Create a blob
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/git/blobs(GitBlobsBody payload, map<string|string[]> headers = {}) returns ShortBlob|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/blobs`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a blob
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/git/blobs/[string fileSha](map<string|string[]> headers = {}) returns Blob|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/blobs/${getEncodedUri(fileSha)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a commit
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/git/commits(GitCommitsBody payload, map<string|string[]> headers = {}) returns GitCommit|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/commits`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a commit object
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commitSha - The SHA of the commit
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/git/commits/[string commitSha](map<string|string[]> headers = {}) returns GitCommit|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/commits/${getEncodedUri(commitSha)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List matching references
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/git/matching\-refs/[string ref](map<string|string[]> headers = {}) returns GitRef[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/matching-refs/${getEncodedUri(ref)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/git/ref/[string ref](map<string|string[]> headers = {}) returns GitRef|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/ref/${getEncodedUri(ref)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/git/refs(GitRefsBody payload, map<string|string[]> headers = {}) returns GitRef|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/refs`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete a reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/git/refs/[string ref](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/refs/${getEncodedUri(ref)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ref - The name of the reference to update (for example, `heads/featureA`). Can be a branch name (`heads/BRANCH_NAME`) or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/git/refs/[string ref](RefsrefBody payload, map<string|string[]> headers = {}) returns GitRef|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/refs/${getEncodedUri(ref)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Create a tag object
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/git/tags(GitTagsBody payload, map<string|string[]> headers = {}) returns GitTag|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/tags`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a tag
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/git/tags/[string tagSha](map<string|string[]> headers = {}) returns GitTag|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/tags/${getEncodedUri(tagSha)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a tree
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/git/trees(GitTreesBody payload, map<string|string[]> headers = {}) returns GitTree|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/trees`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a tree
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + treeSha - The SHA1 value or ref (branch or tag) name of the tree
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/git/trees/[string treeSha](map<string|string[]> headers = {}, *GitGetTreeQueries queries) returns GitTree|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/trees/${getEncodedUri(treeSha)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List repository webhooks
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/hooks(map<string|string[]> headers = {}, *ReposListWebhooksQueries queries) returns Hook[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/hooks(RepoHooksBody payload, map<string|string[]> headers = {}) returns Hook|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/hooks/[int hookId](map<string|string[]> headers = {}) returns Hook|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hookId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/hooks/[int hookId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hookId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/hooks/[int hookId](HookshookIdBody1 payload, map<string|string[]> headers = {}) returns Hook|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hookId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Get a webhook configuration for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/hooks/[int hookId]/config(map<string|string[]> headers = {}) returns WebhookConfig|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hookId)}/config`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a webhook configuration for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/hooks/[int hookId]/config(HookIdConfigBody payload, map<string|string[]> headers = {}) returns WebhookConfig|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hookId)}/config`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List deliveries for a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/hooks/[int hookId]/deliveries(map<string|string[]> headers = {}, *ReposListWebhookDeliveriesQueries queries) returns HookDeliveryItem[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hookId)}/deliveries`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a delivery for a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/hooks/[int hookId]/deliveries/[int deliveryId](map<string|string[]> headers = {}) returns HookDelivery|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hookId)}/deliveries/${getEncodedUri(deliveryId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Redeliver a delivery for a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Accepted 
    resource isolated function post repos/[string owner]/[string repo]/hooks/[int hookId]/deliveries/[int deliveryId]/attempts(map<string|string[]> headers = {}) returns record {}|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hookId)}/deliveries/${getEncodedUri(deliveryId)}/attempts`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Ping a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/hooks/[int hookId]/pings(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hookId)}/pings`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Test the push repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + hookId - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/hooks/[int hookId]/tests(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hookId)}/tests`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get an import status
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/'import(map<string|string[]> headers = {}) returns Import|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Start an import
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/'import(RepoImportBody payload, map<string|string[]> headers = {}) returns Import|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Cancel an import
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/'import(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update an import
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/'import(RepoImportBody1 payload, map<string|string[]> headers = {}) returns Import|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Get commit authors
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/'import/authors(map<string|string[]> headers = {}, *MigrationsGetCommitAuthorsQueries queries) returns PorterAuthor[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import/authors`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Map a commit author
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/'import/authors/[int authorId](AuthorsauthorIdBody payload, map<string|string[]> headers = {}) returns PorterAuthor|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import/authors/${getEncodedUri(authorId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Get large files
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/'import/large_files(map<string|string[]> headers = {}) returns PorterLargeFile[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import/large_files`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update Git LFS preference
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/'import/lfs(ImportLfsBody payload, map<string|string[]> headers = {}) returns Import|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import/lfs`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Get a repository installation for the authenticated app
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/installation(map<string|string[]> headers = {}) returns Installation|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/installation`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get interaction restrictions for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/interaction\-limits(map<string|string[]> headers = {}) returns InteractionLimitResponseAny|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/interaction-limits`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set interaction restrictions for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/interaction\-limits(InteractionLimit payload, map<string|string[]> headers = {}) returns InteractionLimitResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/interaction-limits`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove interaction restrictions for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/interaction\-limits(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/interaction-limits`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List repository invitations
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/invitations(map<string|string[]> headers = {}, *ReposListInvitationsQueries queries) returns RepositoryInvitation[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/invitations`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a repository invitation
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + invitationId - The unique identifier of the invitation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/invitations/[int invitationId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/invitations/${getEncodedUri(invitationId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a repository invitation
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + invitationId - The unique identifier of the invitation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/invitations/[int invitationId](InvitationsinvitationIdBody payload, map<string|string[]> headers = {}) returns RepositoryInvitation|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/invitations/${getEncodedUri(invitationId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List repository issues
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues(map<string|string[]> headers = {}, *IssuesListForRepoQueries queries) returns Issue[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/issues(RepoIssuesBody payload, map<string|string[]> headers = {}) returns Issue|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List issue comments for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/comments(map<string|string[]> headers = {}, *IssuesListCommentsForRepoQueries queries) returns IssueComment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/comments`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an issue comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/comments/[int commentId](map<string|string[]> headers = {}) returns IssueComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/comments/${getEncodedUri(commentId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete an issue comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/issues/comments/[int commentId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/comments/${getEncodedUri(commentId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update an issue comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/issues/comments/[int commentId](CommentscommentIdBody1 payload, map<string|string[]> headers = {}) returns IssueComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/comments/${getEncodedUri(commentId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List reactions for an issue comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/comments/[int commentId]/reactions(map<string|string[]> headers = {}, *ReactionsListForIssueCommentQueries queries) returns Reaction[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/comments/${getEncodedUri(commentId)}/reactions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create reaction for an issue comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Reaction exists 
    resource isolated function post repos/[string owner]/[string repo]/issues/comments/[int commentId]/reactions(CommentIdReactionsBody1 payload, map<string|string[]> headers = {}) returns Reaction|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/comments/${getEncodedUri(commentId)}/reactions`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete an issue comment reaction
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + reactionId - The unique identifier of the reaction
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/issues/comments/[int commentId]/reactions/[int reactionId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/comments/${getEncodedUri(commentId)}/reactions/${getEncodedUri(reactionId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List issue events for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/events(map<string|string[]> headers = {}, *IssuesListEventsForRepoQueries queries) returns IssueEvent[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/events`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an issue event
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/events/[int eventId](map<string|string[]> headers = {}) returns IssueEvent|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/events/${getEncodedUri(eventId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/[int issueNumber](map<string|string[]> headers = {}) returns Issue|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/issues/[int issueNumber](IssuesissueNumberBody payload, map<string|string[]> headers = {}) returns Issue|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Add assignees to an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/issues/[int issueNumber]/assignees(IssueNumberAssigneesBody payload, map<string|string[]> headers = {}) returns Issue|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/assignees`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Remove assignees from an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/issues/[int issueNumber]/assignees(IssueNumberAssigneesBody1 payload, map<string|string[]> headers = {}) returns Issue|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/assignees`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # Check if a user can be assigned to a issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + return - Response if `assignee` can be assigned to `issue_number` 
    resource isolated function get repos/[string owner]/[string repo]/issues/[int issueNumber]/assignees/[string assignee](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/assignees/${getEncodedUri(assignee)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List issue comments
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/[int issueNumber]/comments(map<string|string[]> headers = {}, *IssuesListCommentsQueries queries) returns IssueComment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/comments`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create an issue comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/issues/[int issueNumber]/comments(CommentscommentIdBody1 payload, map<string|string[]> headers = {}) returns IssueComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/comments`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List issue events
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/[int issueNumber]/events(map<string|string[]> headers = {}, *IssuesListEventsQueries queries) returns IssueEventForIssue[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/events`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List labels for an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/[int issueNumber]/labels(map<string|string[]> headers = {}, *IssuesListLabelsOnIssueQueries queries) returns Label[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/labels`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Set labels for an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/issues/[int issueNumber]/labels(IssueNumberLabelsBody payload, map<string|string[]> headers = {}) returns Label[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/labels`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Add labels to an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/issues/[int issueNumber]/labels(IssueNumberLabelsBody1 payload, map<string|string[]> headers = {}) returns Label[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/labels`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Remove all labels from an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/issues/[int issueNumber]/labels(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/labels`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Remove a label from an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/issues/[int issueNumber]/labels/[string name](map<string|string[]> headers = {}) returns Label[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/labels/${getEncodedUri(name)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Lock an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/issues/[int issueNumber]/'lock(IssueNumberLockBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/lock`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Unlock an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/issues/[int issueNumber]/'lock(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/lock`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List reactions for an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/[int issueNumber]/reactions(map<string|string[]> headers = {}, *ReactionsListForIssueQueries queries) returns Reaction[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/reactions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create reaction for an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/issues/[int issueNumber]/reactions(IssueNumberReactionsBody payload, map<string|string[]> headers = {}) returns Reaction|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/reactions`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete an issue reaction
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + reactionId - The unique identifier of the reaction
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/issues/[int issueNumber]/reactions/[int reactionId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/reactions/${getEncodedUri(reactionId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List timeline events for an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + issueNumber - The number that identifies the issue
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/[int issueNumber]/timeline(map<string|string[]> headers = {}, *IssuesListEventsForTimelineQueries queries) returns TimelineIssueEvents[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issueNumber)}/timeline`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List deploy keys
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/keys(map<string|string[]> headers = {}, *ReposListDeployKeysQueries queries) returns DeployKey[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/keys`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a deploy key
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/keys(RepoKeysBody payload, map<string|string[]> headers = {}) returns DeployKey|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/keys`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a deploy key
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + keyId - The unique identifier of the key
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/keys/[int keyId](map<string|string[]> headers = {}) returns DeployKey|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/keys/${getEncodedUri(keyId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a deploy key
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + keyId - The unique identifier of the key
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/keys/[int keyId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/keys/${getEncodedUri(keyId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List labels for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/labels(map<string|string[]> headers = {}, *IssuesListLabelsForRepoQueries queries) returns Label[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/labels`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a label
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/labels(RepoLabelsBody payload, map<string|string[]> headers = {}) returns Label|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/labels`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a label
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/labels/[string name](map<string|string[]> headers = {}) returns Label|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/labels/${getEncodedUri(name)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a label
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/labels/[string name](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/labels/${getEncodedUri(name)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a label
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/labels/[string name](LabelsnameBody payload, map<string|string[]> headers = {}) returns Label|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/labels/${getEncodedUri(name)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List repository languages
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/languages(map<string|string[]> headers = {}) returns Language|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/languages`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get the license for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/license(map<string|string[]> headers = {}) returns LicenseContent|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/license`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Sync a fork branch with the upstream repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - The branch has been successfully synced with the upstream repository 
    resource isolated function post repos/[string owner]/[string repo]/merge\-upstream(RepoMergeUpstreamBody payload, map<string|string[]> headers = {}) returns MergedUpstream|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/merge-upstream`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Merge a branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Successful Response (The resulting merge commit) 
    resource isolated function post repos/[string owner]/[string repo]/merges(RepoMergesBody payload, map<string|string[]> headers = {}) returns Commit|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/merges`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List milestones
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/milestones(map<string|string[]> headers = {}, *IssuesListMilestonesQueries queries) returns Milestone[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/milestones`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a milestone
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/milestones(RepoMilestonesBody payload, map<string|string[]> headers = {}) returns Milestone|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/milestones`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a milestone
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + milestoneNumber - The number that identifies the milestone
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/milestones/[int milestoneNumber](map<string|string[]> headers = {}) returns Milestone|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/milestones/${getEncodedUri(milestoneNumber)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a milestone
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + milestoneNumber - The number that identifies the milestone
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/milestones/[int milestoneNumber](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/milestones/${getEncodedUri(milestoneNumber)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a milestone
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + milestoneNumber - The number that identifies the milestone
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/milestones/[int milestoneNumber](MilestonesmilestoneNumberBody payload, map<string|string[]> headers = {}) returns Milestone|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/milestones/${getEncodedUri(milestoneNumber)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List labels for issues in a milestone
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + milestoneNumber - The number that identifies the milestone
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/milestones/[int milestoneNumber]/labels(map<string|string[]> headers = {}, *IssuesListLabelsForMilestoneQueries queries) returns Label[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/milestones/${getEncodedUri(milestoneNumber)}/labels`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List repository notifications for the authenticated user
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/notifications(map<string|string[]> headers = {}, *ActivityListRepoNotificationsForAuthenticatedUserQueries queries) returns NotificationThread[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/notifications`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Mark repository notifications as read
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/notifications(RepoNotificationsBody payload, map<string|string[]> headers = {}) returns NotificationRead|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/notifications`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Get a GitHub Pages site
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pages(map<string|string[]> headers = {}) returns Page|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update information about a GitHub Pages site
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/pages(RepoPagesBody payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Create a GitHub Pages site
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pages(RepoPagesBody1 payload, map<string|string[]> headers = {}) returns Page|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete a GitHub Pages site
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/pages(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List GitHub Pages builds
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pages/builds(map<string|string[]> headers = {}, *ReposListPagesBuildsQueries queries) returns PageBuild[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages/builds`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Request a GitHub Pages build
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pages/builds(map<string|string[]> headers = {}) returns PageBuildStatus|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages/builds`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get latest Pages build
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pages/builds/latest(map<string|string[]> headers = {}) returns PageBuild|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages/builds/latest`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get GitHub Pages build
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pages/builds/[int buildId](map<string|string[]> headers = {}) returns PageBuild|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages/builds/${getEncodedUri(buildId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a GitHub Pages deployment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pages/deployment(PagesDeploymentBody payload, map<string|string[]> headers = {}) returns PageDeployment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages/deployment`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a DNS health check for GitHub Pages
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pages/health(map<string|string[]> headers = {}) returns PagesHealthCheck|EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages/health`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Enable private vulnerability reporting for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - A header with no content is returned 
    resource isolated function put repos/[string owner]/[string repo]/private\-vulnerability\-reporting(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/private-vulnerability-reporting`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Disable private vulnerability reporting for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - A header with no content is returned 
    resource isolated function delete repos/[string owner]/[string repo]/private\-vulnerability\-reporting(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/private-vulnerability-reporting`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List repository projects
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/projects(map<string|string[]> headers = {}, *ProjectsListForRepoQueries queries) returns Project[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/projects`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a repository project
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/projects(OrgProjectsBody payload, map<string|string[]> headers = {}) returns Project|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/projects`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List pull requests
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls(map<string|string[]> headers = {}, *PullsListQueries queries) returns PullRequestSimple[]|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pulls(RepoPullsBody payload, map<string|string[]> headers = {}) returns PullRequest|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List review comments in a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/comments(map<string|string[]> headers = {}, *PullsListReviewCommentsForRepoQueries queries) returns PullRequestReviewComment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/comments`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a review comment for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/comments/[int commentId](map<string|string[]> headers = {}) returns PullRequestReviewComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/comments/${getEncodedUri(commentId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a review comment for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/pulls/comments/[int commentId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/comments/${getEncodedUri(commentId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a review comment for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/pulls/comments/[int commentId](CommentscommentIdBody2 payload, map<string|string[]> headers = {}) returns PullRequestReviewComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/comments/${getEncodedUri(commentId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List reactions for a pull request review comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/comments/[int commentId]/reactions(map<string|string[]> headers = {}, *ReactionsListForPullRequestReviewCommentQueries queries) returns Reaction[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/comments/${getEncodedUri(commentId)}/reactions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create reaction for a pull request review comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Reaction exists 
    resource isolated function post repos/[string owner]/[string repo]/pulls/comments/[int commentId]/reactions(CommentIdReactionsBody2 payload, map<string|string[]> headers = {}) returns Reaction|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/comments/${getEncodedUri(commentId)}/reactions`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete a pull request comment reaction
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + commentId - The unique identifier of the comment
    # + reactionId - The unique identifier of the reaction
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/pulls/comments/[int commentId]/reactions/[int reactionId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/comments/${getEncodedUri(commentId)}/reactions/${getEncodedUri(reactionId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + headers - Headers to be sent with the request 
    # + return - Pass the appropriate [media type](https://docs.github.com/rest/overview/media-types/#commits-commit-comparison-and-pull-requests) to fetch diff and patch formats 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pullNumber](map<string|string[]> headers = {}) returns PullRequest|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/pulls/[int pullNumber](PullspullNumberBody payload, map<string|string[]> headers = {}) returns PullRequest|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Create a codespace from a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + headers - Headers to be sent with the request 
    # + return - Response when the codespace was successfully created 
    resource isolated function post repos/[string owner]/[string repo]/pulls/[int pullNumber]/codespaces(PullNumberCodespacesBody payload, map<string|string[]> headers = {}) returns Codespace|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/codespaces`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List review comments on a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pullNumber]/comments(map<string|string[]> headers = {}, *PullsListReviewCommentsQueries queries) returns PullRequestReviewComment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/comments`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a review comment for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pulls/[int pullNumber]/comments(PullNumberCommentsBody payload, map<string|string[]> headers = {}) returns PullRequestReviewComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/comments`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Create a reply for a review comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + commentId - The unique identifier of the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pulls/[int pullNumber]/comments/[int commentId]/replies(CommentIdRepliesBody payload, map<string|string[]> headers = {}) returns PullRequestReviewComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/comments/${getEncodedUri(commentId)}/replies`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List commits on a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pullNumber]/commits(map<string|string[]> headers = {}, *PullsListCommitsQueries queries) returns Commit[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/commits`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List pull requests files
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pullNumber]/files(map<string|string[]> headers = {}, *PullsListFilesQueries queries) returns DiffEntry[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/files`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Check if a pull request has been merged
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + headers - Headers to be sent with the request 
    # + return - Response if pull request has been merged 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pullNumber]/merge(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/merge`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Merge a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + headers - Headers to be sent with the request 
    # + return - if merge was successful 
    resource isolated function put repos/[string owner]/[string repo]/pulls/[int pullNumber]/merge(PullNumberMergeBody payload, map<string|string[]> headers = {}) returns PullRequestMergeResult|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/merge`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Get all requested reviewers for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pullNumber]/requested_reviewers(map<string|string[]> headers = {}) returns PullRequestReviewRequest|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/requested_reviewers`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Request reviewers for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pulls/[int pullNumber]/requested_reviewers(PullNumberRequestedReviewersBody payload, map<string|string[]> headers = {}) returns PullRequestSimple|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/requested_reviewers`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Remove requested reviewers from a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/pulls/[int pullNumber]/requested_reviewers(PullNumberRequestedReviewersBody1 payload, map<string|string[]> headers = {}) returns PullRequestSimple|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/requested_reviewers`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # List reviews for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - The list of reviews returns in chronological order 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pullNumber]/reviews(map<string|string[]> headers = {}, *PullsListReviewsQueries queries) returns PullRequestReview[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/reviews`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a review for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pulls/[int pullNumber]/reviews(PullNumberReviewsBody payload, map<string|string[]> headers = {}) returns PullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/reviews`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a review for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + reviewId - The unique identifier of the review
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pullNumber]/reviews/[int reviewId](map<string|string[]> headers = {}) returns PullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/reviews/${getEncodedUri(reviewId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a review for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + reviewId - The unique identifier of the review
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/pulls/[int pullNumber]/reviews/[int reviewId](ReviewsreviewIdBody payload, map<string|string[]> headers = {}) returns PullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/reviews/${getEncodedUri(reviewId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete a pending review for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + reviewId - The unique identifier of the review
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/pulls/[int pullNumber]/reviews/[int reviewId](map<string|string[]> headers = {}) returns PullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/reviews/${getEncodedUri(reviewId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List comments for a pull request review
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + reviewId - The unique identifier of the review
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pullNumber]/reviews/[int reviewId]/comments(map<string|string[]> headers = {}, *PullsListCommentsForReviewQueries queries) returns ReviewComment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/reviews/${getEncodedUri(reviewId)}/comments`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Dismiss a review for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + reviewId - The unique identifier of the review
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/pulls/[int pullNumber]/reviews/[int reviewId]/dismissals(ReviewIdDismissalsBody payload, map<string|string[]> headers = {}) returns PullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/reviews/${getEncodedUri(reviewId)}/dismissals`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Submit a review for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + reviewId - The unique identifier of the review
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pulls/[int pullNumber]/reviews/[int reviewId]/events(ReviewIdEventsBody payload, map<string|string[]> headers = {}) returns PullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/reviews/${getEncodedUri(reviewId)}/events`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Update a pull request branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + pullNumber - The number that identifies the pull request
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/pulls/[int pullNumber]/update\-branch(PullNumberUpdateBranchBody payload, map<string|string[]> headers = {}) returns NotificationRead|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pullNumber)}/update-branch`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Get a repository README
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/readme(map<string|string[]> headers = {}, *ReposGetReadmeQueries queries) returns ContentFile|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/readme`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a repository README for a directory
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + dir - The alternate path to look for a README file
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/readme/[string dir](map<string|string[]> headers = {}, *ReposGetReadmeInDirectoryQueries queries) returns ContentFile|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/readme/${getEncodedUri(dir)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List releases
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/releases(map<string|string[]> headers = {}, *ReposListReleasesQueries queries) returns Release[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a release
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/releases(RepoReleasesBody payload, map<string|string[]> headers = {}) returns Release|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a release asset
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + assetId - The unique identifier of the asset
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/releases/assets/[int assetId](map<string|string[]> headers = {}) returns ReleaseAsset|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/assets/${getEncodedUri(assetId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a release asset
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + assetId - The unique identifier of the asset
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/releases/assets/[int assetId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/assets/${getEncodedUri(assetId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a release asset
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + assetId - The unique identifier of the asset
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/releases/assets/[int assetId](AssetsassetIdBody payload, map<string|string[]> headers = {}) returns ReleaseAsset|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/assets/${getEncodedUri(assetId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Generate release notes content for a release
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Name and body of generated release notes 
    resource isolated function post repos/[string owner]/[string repo]/releases/generate\-notes(ReleasesGenerateNotesBody payload, map<string|string[]> headers = {}) returns ReleaseNotesContent|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/generate-notes`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get the latest release
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/releases/latest(map<string|string[]> headers = {}) returns Release|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/latest`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a release by tag name
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + tag - tag parameter
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/releases/tags/[string tag](map<string|string[]> headers = {}) returns Release|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/tags/${getEncodedUri(tag)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a release
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + releaseId - The unique identifier of the release
    # + headers - Headers to be sent with the request 
    # + return - **Note:** This returns an `upload_url` key corresponding to the endpoint for uploading release assets. This key is a [hypermedia resource](https://docs.github.com/rest/overview/resources-in-the-rest-api#hypermedia) 
    resource isolated function get repos/[string owner]/[string repo]/releases/[int releaseId](map<string|string[]> headers = {}) returns Release|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(releaseId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a release
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + releaseId - The unique identifier of the release
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/releases/[int releaseId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(releaseId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a release
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + releaseId - The unique identifier of the release
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/releases/[int releaseId](ReleasesreleaseIdBody payload, map<string|string[]> headers = {}) returns Release|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(releaseId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List release assets
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + releaseId - The unique identifier of the release
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/releases/[int releaseId]/assets(map<string|string[]> headers = {}, *ReposListReleaseAssetsQueries queries) returns ReleaseAsset[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(releaseId)}/assets`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Upload a release asset
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + releaseId - The unique identifier of the release
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response for successful upload 
    resource isolated function post repos/[string owner]/[string repo]/releases/[int releaseId]/assets(byte[] payload, map<string|string[]> headers = {}, *ReposUploadReleaseAssetQueries queries) returns ReleaseAsset|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(releaseId)}/assets`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        http:Request request = new;
        request.setPayload(payload, "application/octet-stream");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List reactions for a release
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + releaseId - The unique identifier of the release
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/releases/[int releaseId]/reactions(map<string|string[]> headers = {}, *ReactionsListForReleaseQueries queries) returns Reaction[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(releaseId)}/reactions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create reaction for a release
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + releaseId - The unique identifier of the release
    # + headers - Headers to be sent with the request 
    # + return - Reaction exists 
    resource isolated function post repos/[string owner]/[string repo]/releases/[int releaseId]/reactions(ReleaseIdReactionsBody payload, map<string|string[]> headers = {}) returns Reaction|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(releaseId)}/reactions`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete a release reaction
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + releaseId - The unique identifier of the release
    # + reactionId - The unique identifier of the reaction
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/releases/[int releaseId]/reactions/[int reactionId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(releaseId)}/reactions/${getEncodedUri(reactionId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get rules for a branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql)
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/rules/branches/[string branch](map<string|string[]> headers = {}, *ReposGetBranchRulesQueries queries) returns RepositoryRuleDetailed[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rules/branches/${getEncodedUri(branch)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get all repository rulesets
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/rulesets(map<string|string[]> headers = {}, *ReposGetRepoRulesetsQueries queries) returns RepositoryRuleset[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rulesets`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a repository ruleset
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + payload - Request body 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/rulesets(RepoRulesetsBody payload, map<string|string[]> headers = {}) returns RepositoryRuleset|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rulesets`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List repository rule suites
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/rulesets/rule\-suites(map<string|string[]> headers = {}, *ReposGetRepoRuleSuitesQueries queries) returns RuleSuites|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rulesets/rule-suites`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a repository rule suite
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ruleSuiteId - The unique identifier of the rule suite result.
    # To get this ID, you can use [GET /repos/{owner}/{repo}/rulesets/rule-suites](https://docs.github.com/rest/repos/rule-suites#list-repository-rule-suites)
    # for repositories and [GET /orgs/{org}/rulesets/rule-suites](https://docs.github.com/rest/orgs/rule-suites#list-organization-rule-suites)
    # for organizations
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/rulesets/rule\-suites/[int ruleSuiteId](map<string|string[]> headers = {}) returns RuleSuite|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rulesets/rule-suites/${getEncodedUri(ruleSuiteId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a repository ruleset
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + rulesetId - The ID of the ruleset
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/rulesets/[int rulesetId](map<string|string[]> headers = {}, *ReposGetRepoRulesetQueries queries) returns RepositoryRuleset|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rulesets/${getEncodedUri(rulesetId)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a repository ruleset
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + rulesetId - The ID of the ruleset
    # + headers - Headers to be sent with the request 
    # + payload - Request body 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/rulesets/[int rulesetId](RulesetsrulesetIdBody1 payload, map<string|string[]> headers = {}) returns RepositoryRuleset|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rulesets/${getEncodedUri(rulesetId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete a repository ruleset
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + rulesetId - The ID of the ruleset
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/rulesets/[int rulesetId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rulesets/${getEncodedUri(rulesetId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List secret scanning alerts for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/secret\-scanning/alerts(map<string|string[]> headers = {}, *SecretScanningListAlertsForRepoQueries queries) returns SecretScanningAlert[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/secret-scanning/alerts`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a secret scanning alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + alertNumber - The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the `number` field in the response from the `GET /repos/{owner}/{repo}/code-scanning/alerts` operation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/secret\-scanning/alerts/[AlertNumber alertNumber](map<string|string[]> headers = {}) returns SecretScanningAlert|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/secret-scanning/alerts/${getEncodedUri(alertNumber)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a secret scanning alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + alertNumber - The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the `number` field in the response from the `GET /repos/{owner}/{repo}/code-scanning/alerts` operation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/secret\-scanning/alerts/[AlertNumber alertNumber](AlertsalertNumberBody2 payload, map<string|string[]> headers = {}) returns SecretScanningAlert|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/secret-scanning/alerts/${getEncodedUri(alertNumber)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List locations for a secret scanning alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + alertNumber - The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the `number` field in the response from the `GET /repos/{owner}/{repo}/code-scanning/alerts` operation
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/secret\-scanning/alerts/[AlertNumber alertNumber]/locations(map<string|string[]> headers = {}, *SecretScanningListLocationsForAlertQueries queries) returns SecretScanningLocation[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/secret-scanning/alerts/${getEncodedUri(alertNumber)}/locations`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List repository security advisories
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/security\-advisories(map<string|string[]> headers = {}, *SecurityAdvisoriesListRepositoryAdvisoriesQueries queries) returns RepositoryAdvisory[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/security-advisories`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a repository security advisory
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/security\-advisories(RepositoryAdvisoryCreate payload, map<string|string[]> headers = {}) returns RepositoryAdvisory|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/security-advisories`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Privately report a security vulnerability
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/security\-advisories/reports(PrivateVulnerabilityReportCreate payload, map<string|string[]> headers = {}) returns RepositoryAdvisory|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/security-advisories/reports`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a repository security advisory
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ghsaId - The GHSA (GitHub Security Advisory) identifier of the advisory
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/security\-advisories/[string ghsaId](map<string|string[]> headers = {}) returns RepositoryAdvisory|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/security-advisories/${getEncodedUri(ghsaId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a repository security advisory
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ghsaId - The GHSA (GitHub Security Advisory) identifier of the advisory
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/security\-advisories/[string ghsaId](RepositoryAdvisoryUpdate payload, map<string|string[]> headers = {}) returns RepositoryAdvisory|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/security-advisories/${getEncodedUri(ghsaId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Request a CVE for a repository security advisory
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + ghsaId - The GHSA (GitHub Security Advisory) identifier of the advisory
    # + headers - Headers to be sent with the request 
    # + return - Accepted 
    resource isolated function post repos/[string owner]/[string repo]/security\-advisories/[string ghsaId]/cve(map<string|string[]> headers = {}) returns record {}|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/security-advisories/${getEncodedUri(ghsaId)}/cve`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List stargazers
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/stargazers(map<string|string[]> headers = {}, *ActivityListStargazersForRepoQueries queries) returns StargazerResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/stargazers`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get the weekly commit activity
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Returns a weekly aggregate of the number of additions and deletions pushed to a repository 
    resource isolated function get repos/[string owner]/[string repo]/stats/code_frequency(map<string|string[]> headers = {}) returns CodeFrequencyStat[]|record {}|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/stats/code_frequency`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get the last year of commit activity
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/stats/commit_activity(map<string|string[]> headers = {}) returns CommitActivity[]|record {}|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/stats/commit_activity`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get all contributor commit activity
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/stats/contributors(map<string|string[]> headers = {}) returns ContributorActivity[]|record {}|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/stats/contributors`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get the weekly commit count
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - The array order is oldest week (index 0) to most recent week 
    resource isolated function get repos/[string owner]/[string repo]/stats/participation(map<string|string[]> headers = {}) returns ParticipationStats|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/stats/participation`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get the hourly commit count for each day
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - For example, `[2, 14, 25]` indicates that there were 25 total commits, during the 2:00pm hour on Tuesdays. All times are based on the time zone of individual commits 
    resource isolated function get repos/[string owner]/[string repo]/stats/punch_card(map<string|string[]> headers = {}) returns CodeFrequencyStat[]|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/stats/punch_card`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a commit status
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/statuses/[string sha](StatusesshaBody payload, map<string|string[]> headers = {}) returns Status|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/statuses/${getEncodedUri(sha)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List watchers
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/subscribers(map<string|string[]> headers = {}, *ActivityListWatchersForRepoQueries queries) returns SimpleUser[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/subscribers`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a repository subscription
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - if you subscribe to the repository 
    resource isolated function get repos/[string owner]/[string repo]/subscription(map<string|string[]> headers = {}) returns RepositorySubscription|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/subscription`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set a repository subscription
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/subscription(RepoSubscriptionBody payload, map<string|string[]> headers = {}) returns RepositorySubscription|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/subscription`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete a repository subscription
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/subscription(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/subscription`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List repository tags
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/tags(map<string|string[]> headers = {}, *ReposListTagsQueries queries) returns Tag[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/tags`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List tag protection states for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/tags/protection(map<string|string[]> headers = {}) returns TagProtection[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/tags/protection`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a tag protection state for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/tags/protection(TagsProtectionBody payload, map<string|string[]> headers = {}) returns TagProtection|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/tags/protection`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete a tag protection state for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + tagProtectionId - The unique identifier of the tag protection
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/tags/protection/[int tagProtectionId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/tags/protection/${getEncodedUri(tagProtectionId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Download a repository archive (tar)
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/tarball/[string ref](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/tarball/${getEncodedUri(ref)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List repository teams
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/teams(map<string|string[]> headers = {}, *ReposListTeamsQueries queries) returns Team[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/teams`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get all repository topics
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/topics(map<string|string[]> headers = {}, *ReposGetAllTopicsQueries queries) returns Topic|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/topics`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Replace all repository topics
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/topics(RepoTopicsBody payload, map<string|string[]> headers = {}) returns Topic|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/topics`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Get repository clones
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/traffic/clones(map<string|string[]> headers = {}, *ReposGetClonesQueries queries) returns CloneTraffic|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/traffic/clones`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get top referral paths
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/traffic/popular/paths(map<string|string[]> headers = {}) returns ContentTraffic[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/traffic/popular/paths`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get top referral sources
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/traffic/popular/referrers(map<string|string[]> headers = {}) returns ReferrerTraffic[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/traffic/popular/referrers`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get page views
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/traffic/views(map<string|string[]> headers = {}, *ReposGetViewsQueries queries) returns ViewTraffic|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/traffic/views`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Transfer a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/transfer(RepoTransferBody payload, map<string|string[]> headers = {}) returns MinimalRepository|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/transfer`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Check if vulnerability alerts are enabled for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response if repository is enabled with vulnerability alerts 
    resource isolated function get repos/[string owner]/[string repo]/vulnerability\-alerts(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/vulnerability-alerts`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Enable vulnerability alerts
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/vulnerability\-alerts(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/vulnerability-alerts`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Disable vulnerability alerts
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/vulnerability\-alerts(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/vulnerability-alerts`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Download a repository archive (zip)
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/zipball/[string ref](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/zipball/${getEncodedUri(ref)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a repository using a template
    #
    # + templateOwner - The account owner of the template repository. The name is not case sensitive
    # + templateRepo - The name of the template repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repos/[string templateOwner]/[string templateRepo]/generate(TemplateRepoGenerateBody payload, map<string|string[]> headers = {}) returns Repository|error {
        string resourcePath = string `/repos/${getEncodedUri(templateOwner)}/${getEncodedUri(templateRepo)}/generate`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List public repositories
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repositories(map<string|string[]> headers = {}, *ReposListPublicQueries queries) returns MinimalRepository[]|error? {
        string resourcePath = string `/repositories`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List environment secrets
    #
    # + repositoryId - The unique identifier of the repository
    # + environmentName - The name of the environment
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repositories/[int repositoryId]/environments/[string environmentName]/secrets(map<string|string[]> headers = {}, *ActionsListEnvironmentSecretsQueries queries) returns ActionsSecretResponse|error {
        string resourcePath = string `/repositories/${getEncodedUri(repositoryId)}/environments/${getEncodedUri(environmentName)}/secrets`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an environment public key
    #
    # + repositoryId - The unique identifier of the repository
    # + environmentName - The name of the environment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repositories/[int repositoryId]/environments/[string environmentName]/secrets/public\-key(map<string|string[]> headers = {}) returns ActionsPublicKey|error {
        string resourcePath = string `/repositories/${getEncodedUri(repositoryId)}/environments/${getEncodedUri(environmentName)}/secrets/public-key`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an environment secret
    #
    # + repositoryId - The unique identifier of the repository
    # + environmentName - The name of the environment
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repositories/[int repositoryId]/environments/[string environmentName]/secrets/[string secretName](map<string|string[]> headers = {}) returns ActionsSecret|error {
        string resourcePath = string `/repositories/${getEncodedUri(repositoryId)}/environments/${getEncodedUri(environmentName)}/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create or update an environment secret
    #
    # + repositoryId - The unique identifier of the repository
    # + environmentName - The name of the environment
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response when creating a secret 
    resource isolated function put repositories/[int repositoryId]/environments/[string environmentName]/secrets/[string secretName](SecretssecretNameBody6 payload, map<string|string[]> headers = {}) returns EmptyObject|error? {
        string resourcePath = string `/repositories/${getEncodedUri(repositoryId)}/environments/${getEncodedUri(environmentName)}/secrets/${getEncodedUri(secretName)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete an environment secret
    #
    # + repositoryId - The unique identifier of the repository
    # + environmentName - The name of the environment
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Default response 
    resource isolated function delete repositories/[int repositoryId]/environments/[string environmentName]/secrets/[string secretName](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repositories/${getEncodedUri(repositoryId)}/environments/${getEncodedUri(environmentName)}/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List environment variables
    #
    # + repositoryId - The unique identifier of the repository
    # + environmentName - The name of the environment
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get repositories/[int repositoryId]/environments/[string environmentName]/variables(map<string|string[]> headers = {}, *ActionsListEnvironmentVariablesQueries queries) returns ActionsVariableResponse|error {
        string resourcePath = string `/repositories/${getEncodedUri(repositoryId)}/environments/${getEncodedUri(environmentName)}/variables`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create an environment variable
    #
    # + repositoryId - The unique identifier of the repository
    # + environmentName - The name of the environment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post repositories/[int repositoryId]/environments/[string environmentName]/variables(ActionsVariablesBody1 payload, map<string|string[]> headers = {}) returns EmptyObject|error {
        string resourcePath = string `/repositories/${getEncodedUri(repositoryId)}/environments/${getEncodedUri(environmentName)}/variables`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get an environment variable
    #
    # + repositoryId - The unique identifier of the repository
    # + environmentName - The name of the environment
    # + name - The name of the variable
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get repositories/[int repositoryId]/environments/[string environmentName]/variables/[string name](map<string|string[]> headers = {}) returns ActionsVariable|error {
        string resourcePath = string `/repositories/${getEncodedUri(repositoryId)}/environments/${getEncodedUri(environmentName)}/variables/${getEncodedUri(name)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete an environment variable
    #
    # + repositoryId - The unique identifier of the repository
    # + name - The name of the variable
    # + environmentName - The name of the environment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete repositories/[int repositoryId]/environments/[string environmentName]/variables/[string name](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repositories/${getEncodedUri(repositoryId)}/environments/${getEncodedUri(environmentName)}/variables/${getEncodedUri(name)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update an environment variable
    #
    # + repositoryId - The unique identifier of the repository
    # + name - The name of the variable
    # + environmentName - The name of the environment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch repositories/[int repositoryId]/environments/[string environmentName]/variables/[string name](VariablesnameBody1 payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/repositories/${getEncodedUri(repositoryId)}/environments/${getEncodedUri(environmentName)}/variables/${getEncodedUri(name)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Search code
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get search/code(map<string|string[]> headers = {}, *SearchCodeQueries queries) returns CodeSearchResultItemResponse|error? {
        string resourcePath = string `/search/code`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Search commits
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get search/commits(map<string|string[]> headers = {}, *SearchCommitsQueries queries) returns CommitSearchResultItemResponse|error? {
        string resourcePath = string `/search/commits`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Search issues and pull requests
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get search/issues(map<string|string[]> headers = {}, *SearchIssuesAndPullRequestsQueries queries) returns IssueSearchResultItemResponse|error? {
        string resourcePath = string `/search/issues`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Search labels
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get search/labels(map<string|string[]> headers = {}, *SearchLabelsQueries queries) returns LabelSearchResultItemResponse|error? {
        string resourcePath = string `/search/labels`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Search repositories
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get search/repositories(map<string|string[]> headers = {}, *SearchReposQueries queries) returns RepoSearchResultItemResponse|error? {
        string resourcePath = string `/search/repositories`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Search topics
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get search/topics(map<string|string[]> headers = {}, *SearchTopicsQueries queries) returns TopicSearchResultItemResponse|error? {
        string resourcePath = string `/search/topics`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Search users
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get search/users(map<string|string[]> headers = {}, *SearchUsersQueries queries) returns UserSearchResultItemResponse|error? {
        string resourcePath = string `/search/users`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a team (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId](map<string|string[]> headers = {}) returns TeamFull|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a team (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete teams/[int teamId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a team (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + headers - Headers to be sent with the request 
    # + return - Response when the updated information already exists 
    # 
    # # Deprecated
    @deprecated
    resource isolated function patch teams/[int teamId](TeamsteamIdBody payload, map<string|string[]> headers = {}) returns TeamFull|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List discussions (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId]/discussions(map<string|string[]> headers = {}, *TeamsListDiscussionsLegacyQueries queries) returns TeamDiscussion[]|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/discussions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a discussion (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function post teams/[int teamId]/discussions(TeamSlugDiscussionsBody payload, map<string|string[]> headers = {}) returns TeamDiscussion|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/discussions`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a discussion (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + discussionNumber - The number that identifies the discussion
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId]/discussions/[int discussionNumber](map<string|string[]> headers = {}) returns TeamDiscussion|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/discussions/${getEncodedUri(discussionNumber)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a discussion (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + discussionNumber - The number that identifies the discussion
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete teams/[int teamId]/discussions/[int discussionNumber](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/discussions/${getEncodedUri(discussionNumber)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a discussion (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + discussionNumber - The number that identifies the discussion
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function patch teams/[int teamId]/discussions/[int discussionNumber](DiscussionsdiscussionNumberBody payload, map<string|string[]> headers = {}) returns TeamDiscussion|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/discussions/${getEncodedUri(discussionNumber)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List discussion comments (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + discussionNumber - The number that identifies the discussion
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId]/discussions/[int discussionNumber]/comments(map<string|string[]> headers = {}, *TeamsListDiscussionCommentsLegacyQueries queries) returns TeamDiscussionComment[]|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/discussions/${getEncodedUri(discussionNumber)}/comments`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a discussion comment (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + discussionNumber - The number that identifies the discussion
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function post teams/[int teamId]/discussions/[int discussionNumber]/comments(DiscussionNumberCommentsBody payload, map<string|string[]> headers = {}) returns TeamDiscussionComment|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/discussions/${getEncodedUri(discussionNumber)}/comments`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a discussion comment (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + discussionNumber - The number that identifies the discussion
    # + commentNumber - The number that identifies the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId]/discussions/[int discussionNumber]/comments/[int commentNumber](map<string|string[]> headers = {}) returns TeamDiscussionComment|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/discussions/${getEncodedUri(discussionNumber)}/comments/${getEncodedUri(commentNumber)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a discussion comment (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + discussionNumber - The number that identifies the discussion
    # + commentNumber - The number that identifies the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete teams/[int teamId]/discussions/[int discussionNumber]/comments/[int commentNumber](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/discussions/${getEncodedUri(discussionNumber)}/comments/${getEncodedUri(commentNumber)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a discussion comment (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + discussionNumber - The number that identifies the discussion
    # + commentNumber - The number that identifies the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function patch teams/[int teamId]/discussions/[int discussionNumber]/comments/[int commentNumber](DiscussionNumberCommentsBody payload, map<string|string[]> headers = {}) returns TeamDiscussionComment|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/discussions/${getEncodedUri(discussionNumber)}/comments/${getEncodedUri(commentNumber)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List reactions for a team discussion comment (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + discussionNumber - The number that identifies the discussion
    # + commentNumber - The number that identifies the comment
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId]/discussions/[int discussionNumber]/comments/[int commentNumber]/reactions(map<string|string[]> headers = {}, *ReactionsListForTeamDiscussionCommentLegacyQueries queries) returns Reaction[]|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/discussions/${getEncodedUri(discussionNumber)}/comments/${getEncodedUri(commentNumber)}/reactions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create reaction for a team discussion comment (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + discussionNumber - The number that identifies the discussion
    # + commentNumber - The number that identifies the comment
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function post teams/[int teamId]/discussions/[int discussionNumber]/comments/[int commentNumber]/reactions(CommentNumberReactionsBody payload, map<string|string[]> headers = {}) returns Reaction|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/discussions/${getEncodedUri(discussionNumber)}/comments/${getEncodedUri(commentNumber)}/reactions`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List reactions for a team discussion (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + discussionNumber - The number that identifies the discussion
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId]/discussions/[int discussionNumber]/reactions(map<string|string[]> headers = {}, *ReactionsListForTeamDiscussionLegacyQueries queries) returns Reaction[]|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/discussions/${getEncodedUri(discussionNumber)}/reactions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create reaction for a team discussion (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + discussionNumber - The number that identifies the discussion
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function post teams/[int teamId]/discussions/[int discussionNumber]/reactions(DiscussionNumberReactionsBody payload, map<string|string[]> headers = {}) returns Reaction|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/discussions/${getEncodedUri(discussionNumber)}/reactions`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List pending team invitations (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId]/invitations(map<string|string[]> headers = {}, *TeamsListPendingInvitationsLegacyQueries queries) returns OrganizationInvitation[]|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/invitations`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List team members (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId]/members(map<string|string[]> headers = {}, *TeamsListMembersLegacyQueries queries) returns SimpleUser[]|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/members`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get team member (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - if user is a member 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId]/members/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/members/${getEncodedUri(username)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Add team member (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function put teams/[int teamId]/members/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/members/${getEncodedUri(username)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove team member (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete teams/[int teamId]/members/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/members/${getEncodedUri(username)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get team membership for a user (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId]/memberships/[string username](map<string|string[]> headers = {}) returns TeamMembership|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/memberships/${getEncodedUri(username)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Add or update team membership for a user (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function put teams/[int teamId]/memberships/[string username](MembershipsusernameBody1 payload, map<string|string[]> headers = {}) returns TeamMembership|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/memberships/${getEncodedUri(username)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove team membership for a user (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete teams/[int teamId]/memberships/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/memberships/${getEncodedUri(username)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List team projects (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId]/projects(map<string|string[]> headers = {}, *TeamsListProjectsLegacyQueries queries) returns TeamProject[]|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/projects`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Check team permissions for a project (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + projectId - The unique identifier of the project
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId]/projects/[int projectId](map<string|string[]> headers = {}) returns TeamProject|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/projects/${getEncodedUri(projectId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Add or update team project permissions (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + projectId - The unique identifier of the project
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function put teams/[int teamId]/projects/[int projectId](ProjectsprojectIdBody2 payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/projects/${getEncodedUri(projectId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove a project from a team (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + projectId - The unique identifier of the project
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete teams/[int teamId]/projects/[int projectId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/projects/${getEncodedUri(projectId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List team repositories (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId]/repos(map<string|string[]> headers = {}, *TeamsListReposLegacyQueries queries) returns MinimalRepository[]|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/repos`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Check team permissions for a repository (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Alternative response with extra repository information 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId]/repos/[string owner]/[string repo](map<string|string[]> headers = {}) returns TeamRepository|error? {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Add or update team repository permissions (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function put teams/[int teamId]/repos/[string owner]/[string repo](OwnerrepoBody2 payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove a repository from a team (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete teams/[int teamId]/repos/[string owner]/[string repo](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List child teams (Legacy)
    #
    # + teamId - The unique identifier of the team
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - if child teams exist 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int teamId]/teams(map<string|string[]> headers = {}, *TeamsListChildLegacyQueries queries) returns Team[]|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}/teams`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get user(map<string|string[]> headers = {}) returns UserResponse|error? {
        string resourcePath = string `/user`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch user(UserBody payload, map<string|string[]> headers = {}) returns PrivateUser|error? {
        string resourcePath = string `/user`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List users blocked by the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/blocks(map<string|string[]> headers = {}, *UsersListBlockedByAuthenticatedUserQueries queries) returns SimpleUser[]|error? {
        string resourcePath = string `/user/blocks`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Check if a user is blocked by the authenticated user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - If the user is blocked 
    resource isolated function get user/blocks/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/blocks/${getEncodedUri(username)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Block a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put user/blocks/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/blocks/${getEncodedUri(username)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Unblock a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/blocks/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/blocks/${getEncodedUri(username)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List codespaces for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/codespaces(map<string|string[]> headers = {}, *CodespacesListForAuthenticatedUserQueries queries) returns CodespaceResponse|error? {
        string resourcePath = string `/user/codespaces`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a codespace for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + return - Response when the codespace was successfully created 
    resource isolated function post user/codespaces(UserCodespacesBody payload, map<string|string[]> headers = {}) returns Codespace|error {
        string resourcePath = string `/user/codespaces`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List secrets for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/codespaces/secrets(map<string|string[]> headers = {}, *CodespacesListSecretsForAuthenticatedUserQueries queries) returns CodespacesSecretResponse|error {
        string resourcePath = string `/user/codespaces/secrets`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get public key for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get user/codespaces/secrets/public\-key(map<string|string[]> headers = {}) returns CodespacesUserPublicKey|error {
        string resourcePath = string `/user/codespaces/secrets/public-key`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a secret for the authenticated user
    #
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get user/codespaces/secrets/[string secretName](map<string|string[]> headers = {}) returns CodespacesSecret|error {
        string resourcePath = string `/user/codespaces/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create or update a secret for the authenticated user
    #
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response after successfully creating a secret 
    resource isolated function put user/codespaces/secrets/[string secretName](SecretssecretNameBody7 payload, map<string|string[]> headers = {}) returns EmptyObject|error? {
        string resourcePath = string `/user/codespaces/secrets/${getEncodedUri(secretName)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Delete a secret for the authenticated user
    #
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/codespaces/secrets/[string secretName](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/codespaces/secrets/${getEncodedUri(secretName)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List selected repositories for a user secret
    #
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get user/codespaces/secrets/[string secretName]/repositories(map<string|string[]> headers = {}) returns MinimalRepositoryResponse|error {
        string resourcePath = string `/user/codespaces/secrets/${getEncodedUri(secretName)}/repositories`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set selected repositories for a user secret
    #
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - No Content when repositories were added to the selected list 
    resource isolated function put user/codespaces/secrets/[string secretName]/repositories(SecretNameRepositoriesBody3 payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/codespaces/secrets/${getEncodedUri(secretName)}/repositories`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Add a selected repository to a user secret
    #
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - No Content when repository was added to the selected list 
    resource isolated function put user/codespaces/secrets/[string secretName]/repositories/[int repositoryId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/codespaces/secrets/${getEncodedUri(secretName)}/repositories/${getEncodedUri(repositoryId)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove a selected repository from a user secret
    #
    # + secretName - The name of the secret
    # + headers - Headers to be sent with the request 
    # + return - No Content when repository was removed from the selected list 
    resource isolated function delete user/codespaces/secrets/[string secretName]/repositories/[int repositoryId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/codespaces/secrets/${getEncodedUri(secretName)}/repositories/${getEncodedUri(repositoryId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get a codespace for the authenticated user
    #
    # + codespaceName - The name of the codespace
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get user/codespaces/[string codespaceName](map<string|string[]> headers = {}) returns Codespace|error? {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespaceName)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a codespace for the authenticated user
    #
    # + codespaceName - The name of the codespace
    # + headers - Headers to be sent with the request 
    # + return - Accepted 
    resource isolated function delete user/codespaces/[string codespaceName](map<string|string[]> headers = {}) returns record {}|error? {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespaceName)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Update a codespace for the authenticated user
    #
    # + codespaceName - The name of the codespace
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch user/codespaces/[string codespaceName](CodespacescodespaceNameBody payload, map<string|string[]> headers = {}) returns Codespace|error {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespaceName)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Export a codespace for the authenticated user
    #
    # + codespaceName - The name of the codespace
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post user/codespaces/[string codespaceName]/exports(map<string|string[]> headers = {}) returns CodespaceExportDetails|error {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespaceName)}/exports`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get details about a codespace export
    #
    # + codespaceName - The name of the codespace
    # + exportId - The ID of the export operation, or `latest`. Currently only `latest` is currently supported
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get user/codespaces/[string codespaceName]/exports/[string exportId](map<string|string[]> headers = {}) returns CodespaceExportDetails|error {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespaceName)}/exports/${getEncodedUri(exportId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List machine types for a codespace
    #
    # + codespaceName - The name of the codespace
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get user/codespaces/[string codespaceName]/machines(map<string|string[]> headers = {}) returns CodespaceMachineResponse|error? {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespaceName)}/machines`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a repository from an unpublished codespace
    #
    # + codespaceName - The name of the codespace
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post user/codespaces/[string codespaceName]/publish(CodespaceNamePublishBody payload, map<string|string[]> headers = {}) returns CodespaceWithFullRepository|error {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespaceName)}/publish`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Start a codespace for the authenticated user
    #
    # + codespaceName - The name of the codespace
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post user/codespaces/[string codespaceName]/'start(map<string|string[]> headers = {}) returns Codespace|error? {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespaceName)}/start`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Stop a codespace for the authenticated user
    #
    # + codespaceName - The name of the codespace
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post user/codespaces/[string codespaceName]/stop(map<string|string[]> headers = {}) returns Codespace|error {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespaceName)}/stop`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get list of conflicting packages during Docker migration for authenticated-user
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get user/docker/conflicts(map<string|string[]> headers = {}) returns Package[]|error {
        string resourcePath = string `/user/docker/conflicts`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set primary email visibility for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch user/email/visibility(EmailVisibilityBody payload, map<string|string[]> headers = {}) returns Email[]|error? {
        string resourcePath = string `/user/email/visibility`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List email addresses for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/emails(map<string|string[]> headers = {}, *UsersListEmailsForAuthenticatedUserQueries queries) returns Email[]|error? {
        string resourcePath = string `/user/emails`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Add an email address for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post user/emails(UserEmailsBody payload, map<string|string[]> headers = {}) returns Email[]|error? {
        string resourcePath = string `/user/emails`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete an email address for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/emails(UserEmailsBody1 payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/emails`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # List followers of the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/followers(map<string|string[]> headers = {}, *UsersListFollowersForAuthenticatedUserQueries queries) returns SimpleUser[]|error? {
        string resourcePath = string `/user/followers`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List the people the authenticated user follows
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/following(map<string|string[]> headers = {}, *UsersListFollowedByAuthenticatedUserQueries queries) returns SimpleUser[]|error? {
        string resourcePath = string `/user/following`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Check if a person is followed by the authenticated user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - if the person is followed by the authenticated user 
    resource isolated function get user/following/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/following/${getEncodedUri(username)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Follow a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put user/following/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/following/${getEncodedUri(username)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Unfollow a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/following/[string username](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/following/${getEncodedUri(username)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List GPG keys for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/gpg_keys(map<string|string[]> headers = {}, *UsersListGpgKeysForAuthenticatedUserQueries queries) returns GpgKey[]|error? {
        string resourcePath = string `/user/gpg_keys`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a GPG key for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post user/gpg_keys(UserGpgKeysBody payload, map<string|string[]> headers = {}) returns GpgKey|error? {
        string resourcePath = string `/user/gpg_keys`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a GPG key for the authenticated user
    #
    # + gpgKeyId - The unique identifier of the GPG key
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get user/gpg_keys/[int gpgKeyId](map<string|string[]> headers = {}) returns GpgKey|error? {
        string resourcePath = string `/user/gpg_keys/${getEncodedUri(gpgKeyId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a GPG key for the authenticated user
    #
    # + gpgKeyId - The unique identifier of the GPG key
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/gpg_keys/[int gpgKeyId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/gpg_keys/${getEncodedUri(gpgKeyId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List app installations accessible to the user access token
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - You can find the permissions for the installation under the `permissions` key 
    resource isolated function get user/installations(map<string|string[]> headers = {}, *AppsListInstallationsForAuthenticatedUserQueries queries) returns InstallationResponse|error? {
        string resourcePath = string `/user/installations`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List repositories accessible to the user access token
    #
    # + installationId - The unique identifier of the installation
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - The access the user has to each repository is included in the hash under the `permissions` key 
    resource isolated function get user/installations/[int installationId]/repositories(map<string|string[]> headers = {}, *AppsListInstallationReposForAuthenticatedUserQueries queries) returns RepositoryResponse|error? {
        string resourcePath = string `/user/installations/${getEncodedUri(installationId)}/repositories`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Add a repository to an app installation
    #
    # + installationId - The unique identifier of the installation
    # + repositoryId - The unique identifier of the repository
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put user/installations/[int installationId]/repositories/[int repositoryId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/installations/${getEncodedUri(installationId)}/repositories/${getEncodedUri(repositoryId)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove a repository from an app installation
    #
    # + installationId - The unique identifier of the installation
    # + repositoryId - The unique identifier of the repository
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/installations/[int installationId]/repositories/[int repositoryId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/installations/${getEncodedUri(installationId)}/repositories/${getEncodedUri(repositoryId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get interaction restrictions for your public repositories
    #
    # + headers - Headers to be sent with the request 
    # + return - Default response 
    resource isolated function get user/interaction\-limits(map<string|string[]> headers = {}) returns InteractionLimitResponseAny|error? {
        string resourcePath = string `/user/interaction-limits`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Set interaction restrictions for your public repositories
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put user/interaction\-limits(InteractionLimit payload, map<string|string[]> headers = {}) returns InteractionLimitResponse|error {
        string resourcePath = string `/user/interaction-limits`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Remove interaction restrictions from your public repositories
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/interaction\-limits(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/interaction-limits`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List user account issues assigned to the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/issues(map<string|string[]> headers = {}, *IssuesListForAuthenticatedUserQueries queries) returns Issue[]|error? {
        string resourcePath = string `/user/issues`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List public SSH keys for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/keys(map<string|string[]> headers = {}, *UsersListPublicSshKeysForAuthenticatedUserQueries queries) returns Key[]|error? {
        string resourcePath = string `/user/keys`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a public SSH key for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post user/keys(UserKeysBody payload, map<string|string[]> headers = {}) returns Key|error? {
        string resourcePath = string `/user/keys`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a public SSH key for the authenticated user
    #
    # + keyId - The unique identifier of the key
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get user/keys/[int keyId](map<string|string[]> headers = {}) returns Key|error? {
        string resourcePath = string `/user/keys/${getEncodedUri(keyId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a public SSH key for the authenticated user
    #
    # + keyId - The unique identifier of the key
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/keys/[int keyId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/keys/${getEncodedUri(keyId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List subscriptions for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/marketplace_purchases(map<string|string[]> headers = {}, *AppsListSubscriptionsForAuthenticatedUserQueries queries) returns UserMarketplacePurchase[]|error? {
        string resourcePath = string `/user/marketplace_purchases`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List subscriptions for the authenticated user (stubbed)
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/marketplace_purchases/stubbed(map<string|string[]> headers = {}, *AppsListSubscriptionsForAuthenticatedUserStubbedQueries queries) returns UserMarketplacePurchase[]|error? {
        string resourcePath = string `/user/marketplace_purchases/stubbed`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List organization memberships for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/memberships/orgs(map<string|string[]> headers = {}, *OrgsListMembershipsForAuthenticatedUserQueries queries) returns OrgMembership[]|error? {
        string resourcePath = string `/user/memberships/orgs`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get an organization membership for the authenticated user
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get user/memberships/orgs/[string org](map<string|string[]> headers = {}) returns OrgMembership|error {
        string resourcePath = string `/user/memberships/orgs/${getEncodedUri(org)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update an organization membership for the authenticated user
    #
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch user/memberships/orgs/[string org](OrgsorgBody1 payload, map<string|string[]> headers = {}) returns OrgMembership|error {
        string resourcePath = string `/user/memberships/orgs/${getEncodedUri(org)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List user migrations
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/migrations(map<string|string[]> headers = {}, *MigrationsListForAuthenticatedUserQueries queries) returns Migration[]|error? {
        string resourcePath = string `/user/migrations`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Start a user migration
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post user/migrations(UserMigrationsBody payload, map<string|string[]> headers = {}) returns Migration|error? {
        string resourcePath = string `/user/migrations`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a user migration status
    #
    # + migrationId - The unique identifier of the migration
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/migrations/[int migrationId](map<string|string[]> headers = {}, *MigrationsGetStatusForAuthenticatedUserQueries queries) returns Migration|error? {
        string resourcePath = string `/user/migrations/${getEncodedUri(migrationId)}`;
        map<Encoding> queryParamEncoding = {"exclude": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queries, queryParamEncoding);
        return self.clientEp->get(resourcePath, headers);
    }

    # Download a user migration archive
    #
    # + migrationId - The unique identifier of the migration
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get user/migrations/[int migrationId]/archive(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/migrations/${getEncodedUri(migrationId)}/archive`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a user migration archive
    #
    # + migrationId - The unique identifier of the migration
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/migrations/[int migrationId]/archive(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/migrations/${getEncodedUri(migrationId)}/archive`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Unlock a user repository
    #
    # + migrationId - The unique identifier of the migration
    # + repoName - repo_name parameter
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/migrations/[int migrationId]/repos/[string repoName]/'lock(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/migrations/${getEncodedUri(migrationId)}/repos/${getEncodedUri(repoName)}/lock`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List repositories for a user migration
    #
    # + migrationId - The unique identifier of the migration
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/migrations/[int migrationId]/repositories(map<string|string[]> headers = {}, *MigrationsListReposForAuthenticatedUserQueries queries) returns MinimalRepository[]|error {
        string resourcePath = string `/user/migrations/${getEncodedUri(migrationId)}/repositories`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List organizations for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/orgs(map<string|string[]> headers = {}, *OrgsListForAuthenticatedUserQueries queries) returns OrganizationSimple[]|error? {
        string resourcePath = string `/user/orgs`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List packages for the authenticated user's namespace
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/packages(map<string|string[]> headers = {}, *PackagesListPackagesForAuthenticatedUserQueries queries) returns Package[]|error {
        string resourcePath = string `/user/packages`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a package for the authenticated user
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get user/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName](map<string|string[]> headers = {}) returns Package|error {
        string resourcePath = string `/user/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a package for the authenticated user
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Restore a package for the authenticated user
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function post user/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName]/restore(map<string|string[]> headers = {}, *PackagesRestorePackageForAuthenticatedUserQueries queries) returns error? {
        string resourcePath = string `/user/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}/restore`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List package versions for a package owned by the authenticated user
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName]/versions(map<string|string[]> headers = {}, *PackagesGetAllPackageVersionsForPackageOwnedByAuthenticatedUserQueries queries) returns PackageVersion[]|error {
        string resourcePath = string `/user/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}/versions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a package version for the authenticated user
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + packageVersionId - Unique identifier of the package version
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get user/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName]/versions/[int packageVersionId](map<string|string[]> headers = {}) returns PackageVersion|error {
        string resourcePath = string `/user/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}/versions/${getEncodedUri(packageVersionId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a package version for the authenticated user
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + packageVersionId - Unique identifier of the package version
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName]/versions/[int packageVersionId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}/versions/${getEncodedUri(packageVersionId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Restore a package version for the authenticated user
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + packageVersionId - Unique identifier of the package version
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post user/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName]/versions/[int packageVersionId]/restore(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}/versions/${getEncodedUri(packageVersionId)}/restore`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Create a user project
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post user/projects(UserProjectsBody payload, map<string|string[]> headers = {}) returns Project|error? {
        string resourcePath = string `/user/projects`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List public email addresses for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/public_emails(map<string|string[]> headers = {}, *UsersListPublicEmailsForAuthenticatedUserQueries queries) returns Email[]|error? {
        string resourcePath = string `/user/public_emails`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List repositories for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/repos(map<string|string[]> headers = {}, *ReposListForAuthenticatedUserQueries queries) returns Repository[]|error? {
        string resourcePath = string `/user/repos`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a repository for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post user/repos(UserReposBody payload, map<string|string[]> headers = {}) returns Repository|error? {
        string resourcePath = string `/user/repos`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List repository invitations for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/repository_invitations(map<string|string[]> headers = {}, *ReposListInvitationsForAuthenticatedUserQueries queries) returns RepositoryInvitation[]|error? {
        string resourcePath = string `/user/repository_invitations`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Decline a repository invitation
    #
    # + invitationId - The unique identifier of the invitation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/repository_invitations/[int invitationId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/repository_invitations/${getEncodedUri(invitationId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Accept a repository invitation
    #
    # + invitationId - The unique identifier of the invitation
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function patch user/repository_invitations/[int invitationId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/repository_invitations/${getEncodedUri(invitationId)}`;
        http:Request request = new;
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # List social accounts for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/social_accounts(map<string|string[]> headers = {}, *UsersListSocialAccountsForAuthenticatedUserQueries queries) returns SocialAccount[]|error? {
        string resourcePath = string `/user/social_accounts`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Add social accounts for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post user/social_accounts(UserSocialAccountsBody payload, map<string|string[]> headers = {}) returns SocialAccount[]|error? {
        string resourcePath = string `/user/social_accounts`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete social accounts for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/social_accounts(UserSocialAccountsBody1 payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/social_accounts`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # List SSH signing keys for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/ssh_signing_keys(map<string|string[]> headers = {}, *UsersListSshSigningKeysForAuthenticatedUserQueries queries) returns SshSigningKey[]|error? {
        string resourcePath = string `/user/ssh_signing_keys`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a SSH signing key for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post user/ssh_signing_keys(UserSshSigningKeysBody payload, map<string|string[]> headers = {}) returns SshSigningKey|error? {
        string resourcePath = string `/user/ssh_signing_keys`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get an SSH signing key for the authenticated user
    #
    # + sshSigningKeyId - The unique identifier of the SSH signing key
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get user/ssh_signing_keys/[int sshSigningKeyId](map<string|string[]> headers = {}) returns SshSigningKey|error? {
        string resourcePath = string `/user/ssh_signing_keys/${getEncodedUri(sshSigningKeyId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete an SSH signing key for the authenticated user
    #
    # + sshSigningKeyId - The unique identifier of the SSH signing key
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/ssh_signing_keys/[int sshSigningKeyId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/ssh_signing_keys/${getEncodedUri(sshSigningKeyId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List repositories starred by the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/starred(map<string|string[]> headers = {}, *ActivityListReposStarredByAuthenticatedUserQueries queries) returns Repository[]|error? {
        string resourcePath = string `/user/starred`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Check if a repository is starred by the authenticated user
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response if this repository is starred by you 
    resource isolated function get user/starred/[string owner]/[string repo](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/starred/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Star a repository for the authenticated user
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function put user/starred/[string owner]/[string repo](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/starred/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Unstar a repository for the authenticated user
    #
    # + owner - The account owner of the repository. The name is not case sensitive
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete user/starred/[string owner]/[string repo](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/user/starred/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # List repositories watched by the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/subscriptions(map<string|string[]> headers = {}, *ActivityListWatchedReposForAuthenticatedUserQueries queries) returns MinimalRepository[]|error? {
        string resourcePath = string `/user/subscriptions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List teams for the authenticated user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get user/teams(map<string|string[]> headers = {}, *TeamsListForAuthenticatedUserQueries queries) returns TeamFull[]|error? {
        string resourcePath = string `/user/teams`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List users
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users(map<string|string[]> headers = {}, *UsersListQueries queries) returns SimpleUser[]|error? {
        string resourcePath = string `/users`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username](map<string|string[]> headers = {}) returns UserResponse|error {
        string resourcePath = string `/users/${getEncodedUri(username)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get list of conflicting packages during Docker migration for user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/docker/conflicts(map<string|string[]> headers = {}) returns Package[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/docker/conflicts`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List events for the authenticated user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/events(map<string|string[]> headers = {}, *ActivityListEventsForAuthenticatedUserQueries queries) returns Event[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/events`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List organization events for the authenticated user
    #
    # + username - The handle for the GitHub user account
    # + org - The organization name. The name is not case sensitive
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/events/orgs/[string org](map<string|string[]> headers = {}, *ActivityListOrgEventsForAuthenticatedUserQueries queries) returns Event[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/events/orgs/${getEncodedUri(org)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List public events for a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/events/'public(map<string|string[]> headers = {}, *ActivityListPublicEventsForUserQueries queries) returns Event[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/events/public`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List followers of a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/followers(map<string|string[]> headers = {}, *UsersListFollowersForUserQueries queries) returns SimpleUser[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/followers`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List the people a user follows
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/following(map<string|string[]> headers = {}, *UsersListFollowingForUserQueries queries) returns SimpleUser[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/following`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Check if a user follows another user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - if the user follows the target user 
    resource isolated function get users/[string username]/following/[string targetUser](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/users/${getEncodedUri(username)}/following/${getEncodedUri(targetUser)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List gists for a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/gists(map<string|string[]> headers = {}, *GistsListForUserQueries queries) returns BaseGist[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/gists`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List GPG keys for a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/gpg_keys(map<string|string[]> headers = {}, *UsersListGpgKeysForUserQueries queries) returns GpgKey[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/gpg_keys`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get contextual information for a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/hovercard(map<string|string[]> headers = {}, *UsersGetContextForUserQueries queries) returns Hovercard|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/hovercard`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a user installation for the authenticated app
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/installation(map<string|string[]> headers = {}) returns Installation|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/installation`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List public keys for a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/keys(map<string|string[]> headers = {}, *UsersListPublicKeysForUserQueries queries) returns KeySimple[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/keys`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List organizations for a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/orgs(map<string|string[]> headers = {}, *OrgsListForUserQueries queries) returns OrganizationSimple[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/orgs`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List packages for a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/packages(map<string|string[]> headers = {}, *PackagesListPackagesForUserQueries queries) returns Package[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a package for a user
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName](map<string|string[]> headers = {}) returns Package|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a package for a user
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete users/[string username]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Restore a package for a user
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function post users/[string username]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName]/restore(map<string|string[]> headers = {}, *PackagesRestorePackageForUserQueries queries) returns error? {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}/restore`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List package versions for a package owned by a user
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName]/versions(map<string|string[]> headers = {}) returns PackageVersion[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}/versions`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a package version for a user
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + packageVersionId - Unique identifier of the package version
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName]/versions/[int packageVersionId](map<string|string[]> headers = {}) returns PackageVersion|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}/versions/${getEncodedUri(packageVersionId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete package version for a user
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + username - The handle for the GitHub user account
    # + packageVersionId - Unique identifier of the package version
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function delete users/[string username]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName]/versions/[int packageVersionId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}/versions/${getEncodedUri(packageVersionId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Restore package version for a user
    #
    # + packageType - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    # + packageName - The name of the package
    # + username - The handle for the GitHub user account
    # + packageVersionId - Unique identifier of the package version
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function post users/[string username]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType]/[string packageName]/versions/[int packageVersionId]/restore(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages/${getEncodedUri(packageType)}/${getEncodedUri(packageName)}/versions/${getEncodedUri(packageVersionId)}/restore`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List user projects
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/projects(map<string|string[]> headers = {}, *ProjectsListForUserQueries queries) returns Project[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/projects`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List events received by the authenticated user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/received_events(map<string|string[]> headers = {}, *ActivityListReceivedEventsForUserQueries queries) returns Event[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/received_events`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List public events received by a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/received_events/'public(map<string|string[]> headers = {}, *ActivityListReceivedPublicEventsForUserQueries queries) returns Event[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/received_events/public`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List repositories for a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/repos(map<string|string[]> headers = {}, *ReposListForUserQueries queries) returns MinimalRepository[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/repos`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get GitHub Actions billing for a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/settings/billing/actions(map<string|string[]> headers = {}) returns ActionsBillingUsage|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/settings/billing/actions`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get GitHub Packages billing for a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/settings/billing/packages(map<string|string[]> headers = {}) returns PackagesBillingUsage|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/settings/billing/packages`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get shared storage billing for a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/settings/billing/shared\-storage(map<string|string[]> headers = {}) returns CombinedBillingUsage|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/settings/billing/shared-storage`;
        return self.clientEp->get(resourcePath, headers);
    }

    # List social accounts for a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/social_accounts(map<string|string[]> headers = {}, *UsersListSocialAccountsForUserQueries queries) returns SocialAccount[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/social_accounts`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List SSH signing keys for a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/ssh_signing_keys(map<string|string[]> headers = {}, *UsersListSshSigningKeysForUserQueries queries) returns SshSigningKey[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/ssh_signing_keys`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List repositories starred by a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/starred(map<string|string[]> headers = {}, *ActivityListReposStarredByUserQueries queries) returns StarredRepositoryResponse|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/starred`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List repositories watched by a user
    #
    # + username - The handle for the GitHub user account
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Response 
    resource isolated function get users/[string username]/subscriptions(map<string|string[]> headers = {}, *ActivityListReposWatchedByUserQueries queries) returns MinimalRepository[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/subscriptions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get all API versions
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get versions(map<string|string[]> headers = {}) returns string[]|error {
        string resourcePath = string `/versions`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get the Zen of GitHub
    #
    # + headers - Headers to be sent with the request 
    # + return - Response 
    resource isolated function get zen(map<string|string[]> headers = {}) returns string|error {
        string resourcePath = string `/zen`;
        return self.clientEp->get(resourcePath, headers);
    }
}
