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
        http:ClientConfiguration httpClientConfig = {auth: config.auth, httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }
    # GitHub API Root
    #
    # + return - Response 
    resource isolated function get .() returns Root|error {
        string resourcePath = string `/`;
        Root response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List global security advisories
    #
    # + ghsa_id - If specified, only advisories with this GHSA (GitHub Security Advisory) identifier will be returned.
    # + 'type - If specified, only advisories of this type will be returned. By default, a request with no other parameters defined will only return reviewed advisories that are not malware.
    # + cve_id - If specified, only advisories with this CVE (Common Vulnerabilities and Exposures) identifier will be returned.
    # + ecosystem - If specified, only advisories for these ecosystems will be returned.
    # + severity - If specified, only advisories with these severities will be returned.
    # + cwes - If specified, only advisories with these Common Weakness Enumerations (CWEs) will be returned.
    # Example: `cwes=79,284,22` or `cwes[]=79&cwes[]=284&cwes[]=22`
    # + is_withdrawn - Whether to only return advisories that have been withdrawn.
    # + affects - If specified, only return advisories that affect any of `package` or `package@version`. A maximum of 1000 packages can be specified.
    # If the query parameter causes the URL to exceed the maximum URL length supported by your client, you must specify fewer packages.
    # Example: `affects=package1,package2@1.0.0,package3@^2.0.0` or `affects[]=package1&affects[]=package2@1.0.0`
    # + published - If specified, only return advisories that were published on a date or date range.
    # For more information on the syntax of the date range, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    # + updated - If specified, only return advisories that were updated on a date or date range.
    # For more information on the syntax of the date range, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    # + modified - If specified, only show advisories that were updated or published on a date or date range.
    # For more information on the syntax of the date range, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    # + before - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.
    # + after - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.
    # + direction - The direction to sort the results by.
    # + per_page - The number of results per page (max 100).
    # + sort - The property to sort the results by.
    # + return - Response 
    resource isolated function get advisories(string? ghsa_id = (), "reviewed"|"malware"|"unreviewed" 'type = "reviewed", string? cve_id = (), "actions"|"composer"|"erlang"|"go"|"maven"|"npm"|"nuget"|"other"|"pip"|"pub"|"rubygems"|"rust"? ecosystem = (), "unknown"|"low"|"medium"|"high"|"critical"? severity = (), Cwes? cwes = (), boolean? is_withdrawn = (), Affects? affects = (), string? published = (), string? updated = (), string? modified = (), string? before = (), string? after = (), "asc"|"desc" direction = "desc", int per_page = 30, "updated"|"published" sort = "published") returns GlobalAdvisory[]|error {
        string resourcePath = string `/advisories`;
        map<anydata> queryParam = {"ghsa_id": ghsa_id, "type": 'type, "cve_id": cve_id, "ecosystem": ecosystem, "severity": severity, "cwes": cwes, "is_withdrawn": is_withdrawn, "affects": affects, "published": published, "updated": updated, "modified": modified, "before": before, "after": after, "direction": direction, "per_page": per_page, "sort": sort};
        map<Encoding> queryParamEncoding = {"cwes": {style: FORM, explode: true}, "affects": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        GlobalAdvisory[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a global security advisory
    #
    # + ghsa_id - The GHSA (GitHub Security Advisory) identifier of the advisory.
    # + return - Response 
    resource isolated function get advisories/[string ghsa_id]() returns GlobalAdvisory|error {
        string resourcePath = string `/advisories/${getEncodedUri(ghsa_id)}`;
        GlobalAdvisory response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get the authenticated app
    #
    # + return - Response 
    resource isolated function get app() returns Integration|error {
        string resourcePath = string `/app`;
        Integration response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a GitHub App from a manifest
    #
    # + return - Response 
    resource isolated function post app\-manifests/[string code]/conversions() returns ManifestConversions|error {
        string resourcePath = string `/app-manifests/${getEncodedUri(code)}/conversions`;
        http:Request request = new;
        ManifestConversions response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a webhook configuration for an app
    #
    # + return - Response 
    resource isolated function get app/hook/config() returns WebhookConfig|error {
        string resourcePath = string `/app/hook/config`;
        WebhookConfig response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a webhook configuration for an app
    #
    # + return - Response 
    resource isolated function patch app/hook/config(Hook_config_body payload) returns WebhookConfig|error {
        string resourcePath = string `/app/hook/config`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        WebhookConfig response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List deliveries for an app webhook
    #
    # + per_page - The number of results per page (max 100).
    # + cursor - Used for pagination: the starting delivery from which the page of deliveries is fetched. Refer to the `link` header for the next and previous page cursors.
    # + return - Response 
    resource isolated function get app/hook/deliveries(int per_page = 30, string? cursor = (), boolean? redelivery = ()) returns HookDeliveryItem[]|error {
        string resourcePath = string `/app/hook/deliveries`;
        map<anydata> queryParam = {"per_page": per_page, "cursor": cursor, "redelivery": redelivery};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        HookDeliveryItem[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a delivery for an app webhook
    #
    # + return - Response 
    resource isolated function get app/hook/deliveries/[int delivery_id]() returns HookDelivery|error {
        string resourcePath = string `/app/hook/deliveries/${getEncodedUri(delivery_id)}`;
        HookDelivery response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Redeliver a delivery for an app webhook
    #
    # + return - Accepted 
    resource isolated function post app/hook/deliveries/[int delivery_id]/attempts() returns json|error {
        string resourcePath = string `/app/hook/deliveries/${getEncodedUri(delivery_id)}/attempts`;
        http:Request request = new;
        json response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List installation requests for the authenticated app
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - List of integration installation requests 
    resource isolated function get app/installation\-requests(int per_page = 30, int page = 1) returns IntegrationInstallationRequest[]|error {
        string resourcePath = string `/app/installation-requests`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        IntegrationInstallationRequest[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List installations for the authenticated app
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + return - The permissions the installation has are included under the `permissions` key. 
    resource isolated function get app/installations(int per_page = 30, int page = 1, string? since = (), string? outdated = ()) returns Installation[]|error {
        string resourcePath = string `/app/installations`;
        map<anydata> queryParam = {"per_page": per_page, "page": page, "since": since, "outdated": outdated};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Installation[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an installation for the authenticated app
    #
    # + installation_id - The unique identifier of the installation.
    # + return - Response 
    resource isolated function get app/installations/[int installation_id]() returns Installation|error {
        string resourcePath = string `/app/installations/${getEncodedUri(installation_id)}`;
        Installation response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete an installation for the authenticated app
    #
    # + installation_id - The unique identifier of the installation.
    # + return - Response 
    resource isolated function delete app/installations/[int installation_id]() returns http:Response|error {
        string resourcePath = string `/app/installations/${getEncodedUri(installation_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Create an installation access token for an app
    #
    # + installation_id - The unique identifier of the installation.
    # + return - Response 
    resource isolated function post app/installations/[int installation_id]/access_tokens(Installation_id_access_tokens_body payload) returns InstallationToken|error {
        string resourcePath = string `/app/installations/${getEncodedUri(installation_id)}/access_tokens`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        InstallationToken response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Suspend an app installation
    #
    # + installation_id - The unique identifier of the installation.
    # + return - Response 
    resource isolated function put app/installations/[int installation_id]/suspended() returns http:Response|error {
        string resourcePath = string `/app/installations/${getEncodedUri(installation_id)}/suspended`;
        http:Request request = new;
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Unsuspend an app installation
    #
    # + installation_id - The unique identifier of the installation.
    # + return - Response 
    resource isolated function delete app/installations/[int installation_id]/suspended() returns http:Response|error {
        string resourcePath = string `/app/installations/${getEncodedUri(installation_id)}/suspended`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Delete an app authorization
    #
    # + client_id - The client ID of the GitHub app.
    # + return - Response 
    resource isolated function delete applications/[string client_id]/grant(Client_id_grant_body payload) returns http:Response|error {
        string resourcePath = string `/applications/${getEncodedUri(client_id)}/grant`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->delete(resourcePath, request);
        return response;
    }
    # Check a token
    #
    # + client_id - The client ID of the GitHub app.
    # + return - Response 
    resource isolated function post applications/[string client_id]/token(Client_id_token_body payload) returns Authorization|error {
        string resourcePath = string `/applications/${getEncodedUri(client_id)}/token`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Authorization response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete an app token
    #
    # + client_id - The client ID of the GitHub app.
    # + return - Response 
    resource isolated function delete applications/[string client_id]/token(Client_id_token_body_1 payload) returns http:Response|error {
        string resourcePath = string `/applications/${getEncodedUri(client_id)}/token`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->delete(resourcePath, request);
        return response;
    }
    # Reset a token
    #
    # + client_id - The client ID of the GitHub app.
    # + return - Response 
    resource isolated function patch applications/[string client_id]/token(Client_id_token_body_2 payload) returns Authorization|error {
        string resourcePath = string `/applications/${getEncodedUri(client_id)}/token`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Authorization response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Create a scoped access token
    #
    # + client_id - The client ID of the GitHub app.
    # + return - Response 
    resource isolated function post applications/[string client_id]/token/scoped(Token_scoped_body payload) returns Authorization|error {
        string resourcePath = string `/applications/${getEncodedUri(client_id)}/token/scoped`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Authorization response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get an app
    #
    # + return - Response 
    resource isolated function get apps/[string app_slug]() returns Integration|error {
        string resourcePath = string `/apps/${getEncodedUri(app_slug)}`;
        Integration response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an assignment
    #
    # + assignment_id - The unique identifier of the classroom assignment.
    # + return - Response 
    resource isolated function get assignments/[int assignment_id]() returns ClassroomAssignment|error {
        string resourcePath = string `/assignments/${getEncodedUri(assignment_id)}`;
        ClassroomAssignment response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List accepted assignments for an assignment
    #
    # + assignment_id - The unique identifier of the classroom assignment.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get assignments/[int assignment_id]/accepted_assignments(int page = 1, int per_page = 30) returns ClassroomAcceptedAssignment[]|error {
        string resourcePath = string `/assignments/${getEncodedUri(assignment_id)}/accepted_assignments`;
        map<anydata> queryParam = {"page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ClassroomAcceptedAssignment[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get assignment grades
    #
    # + assignment_id - The unique identifier of the classroom assignment.
    # + return - Response 
    resource isolated function get assignments/[int assignment_id]/grades() returns ClassroomAssignmentGrade[]|error {
        string resourcePath = string `/assignments/${getEncodedUri(assignment_id)}/grades`;
        ClassroomAssignmentGrade[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List classrooms
    #
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get classrooms(int page = 1, int per_page = 30) returns SimpleClassroom[]|error {
        string resourcePath = string `/classrooms`;
        map<anydata> queryParam = {"page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleClassroom[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a classroom
    #
    # + classroom_id - The unique identifier of the classroom.
    # + return - Response 
    resource isolated function get classrooms/[int classroom_id]() returns Classroom|error {
        string resourcePath = string `/classrooms/${getEncodedUri(classroom_id)}`;
        Classroom response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List assignments for a classroom
    #
    # + classroom_id - The unique identifier of the classroom.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get classrooms/[int classroom_id]/assignments(int page = 1, int per_page = 30) returns SimpleClassroomAssignment[]|error {
        string resourcePath = string `/classrooms/${getEncodedUri(classroom_id)}/assignments`;
        map<anydata> queryParam = {"page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleClassroomAssignment[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get all codes of conduct
    #
    # + return - Response 
    resource isolated function get codes_of_conduct() returns CodeOfConduct[]|error? {
        string resourcePath = string `/codes_of_conduct`;
        CodeOfConduct[]? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a code of conduct
    #
    # + return - Response 
    resource isolated function get codes_of_conduct/[string 'key]() returns CodeOfConduct|error? {
        string resourcePath = string `/codes_of_conduct/${getEncodedUri('key)}`;
        CodeOfConduct? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get emojis
    #
    # + return - Response 
    resource isolated function get emojis() returns json|error? {
        string resourcePath = string `/emojis`;
        json? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List Dependabot alerts for an enterprise
    #
    # + enterprise - The slug version of the enterprise name. You can also substitute this value with the enterprise id.
    # + state - A comma-separated list of states. If specified, only alerts with these states will be returned.
    # Can be: `auto_dismissed`, `dismissed`, `fixed`, `open`
    # + severity - A comma-separated list of severities. If specified, only alerts with these severities will be returned.
    # Can be: `low`, `medium`, `high`, `critical`
    # + ecosystem - A comma-separated list of ecosystems. If specified, only alerts for these ecosystems will be returned.
    # Can be: `composer`, `go`, `maven`, `npm`, `nuget`, `pip`, `pub`, `rubygems`, `rust`
    # + package - A comma-separated list of package names. If specified, only alerts for these packages will be returned.
    # + scope - The scope of the vulnerable dependency. If specified, only alerts with this scope will be returned.
    # + sort - The property by which to sort the results.
    # `created` means when the alert was created.
    # `updated` means when the alert's state last changed.
    # + direction - The direction to sort the results by.
    # + before - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.
    # + after - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.
    # + first - **Deprecated**. The number of results per page (max 100), starting from the first matching result.
    # This parameter must not be used in combination with `last`.
    # Instead, use `per_page` in combination with `after` to fetch the first page of results.
    # + last - **Deprecated**. The number of results per page (max 100), starting from the last matching result.
    # This parameter must not be used in combination with `first`.
    # Instead, use `per_page` in combination with `before` to fetch the last page of results.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get enterprises/[string enterprise]/dependabot/alerts(string? state = (), string? severity = (), string? ecosystem = (), string? package = (), "development"|"runtime"? scope = (), "created"|"updated" sort = "created", "asc"|"desc" direction = "desc", string? before = (), string? after = (), int first = 30, int? last = (), int per_page = 30) returns DependabotAlertWithRepository[]|error {
        string resourcePath = string `/enterprises/${getEncodedUri(enterprise)}/dependabot/alerts`;
        map<anydata> queryParam = {"state": state, "severity": severity, "ecosystem": ecosystem, "package": package, "scope": scope, "sort": sort, "direction": direction, "before": before, "after": after, "first": first, "last": last, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        DependabotAlertWithRepository[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List secret scanning alerts for an enterprise
    #
    # + enterprise - The slug version of the enterprise name. You can also substitute this value with the enterprise id.
    # + state - Set to `open` or `resolved` to only list secret scanning alerts in a specific state.
    # + secret_type - A comma-separated list of secret types to return. By default all secret types are returned.
    # See "[Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns#supported-secrets-for-advanced-security)"
    # for a complete list of secret types.
    # + resolution - A comma-separated list of resolutions. Only secret scanning alerts with one of these resolutions are listed. Valid resolutions are `false_positive`, `wont_fix`, `revoked`, `pattern_edited`, `pattern_deleted` or `used_in_tests`.
    # + sort - The property to sort the results by. `created` means when the alert was created. `updated` means when the alert was updated or resolved.
    # + direction - The direction to sort the results by.
    # + per_page - The number of results per page (max 100).
    # + before - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.
    # + after - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.
    # + return - Response 
    resource isolated function get enterprises/[string enterprise]/secret\-scanning/alerts("open"|"resolved"? state = (), string? secret_type = (), string? resolution = (), "created"|"updated" sort = "created", "asc"|"desc" direction = "desc", int per_page = 30, string? before = (), string? after = ()) returns OrganizationSecretScanningAlert[]|error {
        string resourcePath = string `/enterprises/${getEncodedUri(enterprise)}/secret-scanning/alerts`;
        map<anydata> queryParam = {"state": state, "secret_type": secret_type, "resolution": resolution, "sort": sort, "direction": direction, "per_page": per_page, "before": before, "after": after};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrganizationSecretScanningAlert[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List public events
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get events(int per_page = 30, int page = 1) returns Event[]|error {
        string resourcePath = string `/events`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Event[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get feeds
    #
    # + return - Response 
    resource isolated function get feeds() returns Feed|error {
        string resourcePath = string `/feeds`;
        Feed response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List gists for the authenticated user
    #
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get gists(string? since = (), int per_page = 30, int page = 1) returns BaseGist[]|error {
        string resourcePath = string `/gists`;
        map<anydata> queryParam = {"since": since, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        BaseGist[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a gist
    #
    # + return - Response 
    resource isolated function post gists(Gists_body payload) returns GistSimple|error {
        string resourcePath = string `/gists`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        GistSimple response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List public gists
    #
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get gists/'public(string? since = (), int per_page = 30, int page = 1) returns BaseGist[]|error {
        string resourcePath = string `/gists/public`;
        map<anydata> queryParam = {"since": since, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        BaseGist[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List starred gists
    #
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get gists/starred(string? since = (), int per_page = 30, int page = 1) returns BaseGist[]|error {
        string resourcePath = string `/gists/starred`;
        map<anydata> queryParam = {"since": since, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        BaseGist[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a gist
    #
    # + gist_id - The unique identifier of the gist.
    # + return - Response 
    resource isolated function get gists/[string gist_id]() returns GistSimple|error? {
        string resourcePath = string `/gists/${getEncodedUri(gist_id)}`;
        GistSimple? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a gist
    #
    # + gist_id - The unique identifier of the gist.
    # + return - Response 
    resource isolated function delete gists/[string gist_id]() returns http:Response|error {
        string resourcePath = string `/gists/${getEncodedUri(gist_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update a gist
    #
    # + gist_id - The unique identifier of the gist.
    # + return - Response 
    resource isolated function patch gists/[string gist_id](Gists_gist_id_body payload) returns GistSimple|error {
        string resourcePath = string `/gists/${getEncodedUri(gist_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        GistSimple response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List gist comments
    #
    # + gist_id - The unique identifier of the gist.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get gists/[string gist_id]/comments(int per_page = 30, int page = 1) returns GistComment[]|error {
        string resourcePath = string `/gists/${getEncodedUri(gist_id)}/comments`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        GistComment[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a gist comment
    #
    # + gist_id - The unique identifier of the gist.
    # + return - Response 
    resource isolated function post gists/[string gist_id]/comments(Gist_id_comments_body payload) returns GistComment|error {
        string resourcePath = string `/gists/${getEncodedUri(gist_id)}/comments`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        GistComment response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a gist comment
    #
    # + gist_id - The unique identifier of the gist.
    # + comment_id - The unique identifier of the comment.
    # + return - Response 
    resource isolated function get gists/[string gist_id]/comments/[int comment_id]() returns GistComment|error {
        string resourcePath = string `/gists/${getEncodedUri(gist_id)}/comments/${getEncodedUri(comment_id)}`;
        GistComment response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a gist comment
    #
    # + gist_id - The unique identifier of the gist.
    # + comment_id - The unique identifier of the comment.
    # + return - Response 
    resource isolated function delete gists/[string gist_id]/comments/[int comment_id]() returns http:Response|error {
        string resourcePath = string `/gists/${getEncodedUri(gist_id)}/comments/${getEncodedUri(comment_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update a gist comment
    #
    # + gist_id - The unique identifier of the gist.
    # + comment_id - The unique identifier of the comment.
    # + return - Response 
    resource isolated function patch gists/[string gist_id]/comments/[int comment_id](Comments_comment_id_body payload) returns GistComment|error {
        string resourcePath = string `/gists/${getEncodedUri(gist_id)}/comments/${getEncodedUri(comment_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        GistComment response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List gist commits
    #
    # + gist_id - The unique identifier of the gist.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get gists/[string gist_id]/commits(int per_page = 30, int page = 1) returns GistCommit[]|error {
        string resourcePath = string `/gists/${getEncodedUri(gist_id)}/commits`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        GistCommit[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List gist forks
    #
    # + gist_id - The unique identifier of the gist.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get gists/[string gist_id]/forks(int per_page = 30, int page = 1) returns GistSimple[]|error {
        string resourcePath = string `/gists/${getEncodedUri(gist_id)}/forks`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        GistSimple[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Fork a gist
    #
    # + gist_id - The unique identifier of the gist.
    # + return - Response 
    resource isolated function post gists/[string gist_id]/forks() returns BaseGist|error {
        string resourcePath = string `/gists/${getEncodedUri(gist_id)}/forks`;
        http:Request request = new;
        BaseGist response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Check if a gist is starred
    #
    # + gist_id - The unique identifier of the gist.
    # + return - Response if gist is starred 
    resource isolated function get gists/[string gist_id]/star() returns http:Response|error {
        string resourcePath = string `/gists/${getEncodedUri(gist_id)}/star`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Star a gist
    #
    # + gist_id - The unique identifier of the gist.
    # + return - Response 
    resource isolated function put gists/[string gist_id]/star() returns http:Response|error {
        string resourcePath = string `/gists/${getEncodedUri(gist_id)}/star`;
        http:Request request = new;
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Unstar a gist
    #
    # + gist_id - The unique identifier of the gist.
    # + return - Response 
    resource isolated function delete gists/[string gist_id]/star() returns http:Response|error {
        string resourcePath = string `/gists/${getEncodedUri(gist_id)}/star`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Get a gist revision
    #
    # + gist_id - The unique identifier of the gist.
    # + return - Response 
    resource isolated function get gists/[string gist_id]/[string sha]() returns GistSimple|error {
        string resourcePath = string `/gists/${getEncodedUri(gist_id)}/${getEncodedUri(sha)}`;
        GistSimple response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get all gitignore templates
    #
    # + return - Response 
    resource isolated function get gitignore/templates() returns string[]|error? {
        string resourcePath = string `/gitignore/templates`;
        string[]? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a gitignore template
    #
    # + return - Response 
    resource isolated function get gitignore/templates/[string name]() returns GitignoreTemplate|error? {
        string resourcePath = string `/gitignore/templates/${getEncodedUri(name)}`;
        GitignoreTemplate? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List repositories accessible to the app installation
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get installation/repositories(int per_page = 30, int page = 1) returns RepositoryResponse|error {
        string resourcePath = string `/installation/repositories`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RepositoryResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Revoke an installation access token
    #
    # + return - Response 
    resource isolated function delete installation/token() returns error? {
        string resourcePath = string `/installation/token`;
        return self.clientEp->delete(resourcePath);
    }
    # List issues assigned to the authenticated user
    #
    # + filter - Indicates which sorts of issues to return. `assigned` means issues assigned to you. `created` means issues created by you. `mentioned` means issues mentioning you. `subscribed` means issues you're subscribed to updates for. `all` or `repos` means all issues you can see, regardless of participation or creation.
    # + state - Indicates the state of the issues to return.
    # + labels - A list of comma separated label names. Example: `bug,ui,@high`
    # + sort - What to sort results by.
    # + direction - The direction to sort the results by.
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get issues("assigned"|"created"|"mentioned"|"subscribed"|"repos"|"all" filter = "assigned", "open"|"closed"|"all" state = "open", string? labels = (), "created"|"updated"|"comments" sort = "created", "asc"|"desc" direction = "desc", string? since = (), boolean? collab = (), boolean? orgs = (), boolean? owned = (), boolean? pulls = (), int per_page = 30, int page = 1) returns Issue[]|error {
        string resourcePath = string `/issues`;
        map<anydata> queryParam = {"filter": filter, "state": state, "labels": labels, "sort": sort, "direction": direction, "since": since, "collab": collab, "orgs": orgs, "owned": owned, "pulls": pulls, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Issue[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get all commonly used licenses
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get licenses(boolean? featured = (), int per_page = 30, int page = 1) returns LicenseSimple[]|error? {
        string resourcePath = string `/licenses`;
        map<anydata> queryParam = {"featured": featured, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        LicenseSimple[]? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a license
    #
    # + return - Response 
    resource isolated function get licenses/[string license]() returns License|error? {
        string resourcePath = string `/licenses/${getEncodedUri(license)}`;
        License? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Render a Markdown document
    #
    # + return - Response 
    resource isolated function post markdown(Markdown_body payload) returns string|error? {
        string resourcePath = string `/markdown`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        string? response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Render a Markdown document in raw mode
    #
    # + return - Response 
    resource isolated function post markdown/raw(string payload) returns string|error? {
        string resourcePath = string `/markdown/raw`;
        http:Request request = new;
        request.setPayload(payload, "text/plain");
        string? response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a subscription plan for an account
    #
    # + account_id - account_id parameter
    # + return - Response 
    resource isolated function get marketplace_listing/accounts/[int account_id]() returns MarketplacePurchase|error {
        string resourcePath = string `/marketplace_listing/accounts/${getEncodedUri(account_id)}`;
        MarketplacePurchase response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List plans
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get marketplace_listing/plans(int per_page = 30, int page = 1) returns MarketplaceListingPlan[]|error {
        string resourcePath = string `/marketplace_listing/plans`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MarketplaceListingPlan[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List accounts for a plan
    #
    # + plan_id - The unique identifier of the plan.
    # + sort - The property to sort the results by.
    # + direction - To return the oldest accounts first, set to `asc`. Ignored without the `sort` parameter.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get marketplace_listing/plans/[int plan_id]/accounts("created"|"updated" sort = "created", "asc"|"desc"? direction = (), int per_page = 30, int page = 1) returns MarketplacePurchase[]|error {
        string resourcePath = string `/marketplace_listing/plans/${getEncodedUri(plan_id)}/accounts`;
        map<anydata> queryParam = {"sort": sort, "direction": direction, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MarketplacePurchase[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a subscription plan for an account (stubbed)
    #
    # + account_id - account_id parameter
    # + return - Response 
    resource isolated function get marketplace_listing/stubbed/accounts/[int account_id]() returns MarketplacePurchase|error {
        string resourcePath = string `/marketplace_listing/stubbed/accounts/${getEncodedUri(account_id)}`;
        MarketplacePurchase response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List plans (stubbed)
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get marketplace_listing/stubbed/plans(int per_page = 30, int page = 1) returns MarketplaceListingPlan[]|error {
        string resourcePath = string `/marketplace_listing/stubbed/plans`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MarketplaceListingPlan[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List accounts for a plan (stubbed)
    #
    # + plan_id - The unique identifier of the plan.
    # + sort - The property to sort the results by.
    # + direction - To return the oldest accounts first, set to `asc`. Ignored without the `sort` parameter.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get marketplace_listing/stubbed/plans/[int plan_id]/accounts("created"|"updated" sort = "created", "asc"|"desc"? direction = (), int per_page = 30, int page = 1) returns MarketplacePurchase[]|error {
        string resourcePath = string `/marketplace_listing/stubbed/plans/${getEncodedUri(plan_id)}/accounts`;
        map<anydata> queryParam = {"sort": sort, "direction": direction, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MarketplacePurchase[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get GitHub meta information
    #
    # + return - Response 
    resource isolated function get meta() returns ApiOverview|error? {
        string resourcePath = string `/meta`;
        ApiOverview? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List public events for a network of repositories
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get networks/[string owner]/[string repo]/events(int per_page = 30, int page = 1) returns Event[]|error {
        string resourcePath = string `/networks/${getEncodedUri(owner)}/${getEncodedUri(repo)}/events`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Event[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List notifications for the authenticated user
    #
    # + all - If `true`, show notifications marked as read.
    # + participating - If `true`, only shows notifications in which the user is directly participating or mentioned.
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + before - Only show notifications updated before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 50).
    # + return - Response 
    resource isolated function get notifications(boolean all = false, boolean participating = false, string? since = (), string? before = (), int page = 1, int per_page = 50) returns NotificationThread[]|error {
        string resourcePath = string `/notifications`;
        map<anydata> queryParam = {"all": all, "participating": participating, "since": since, "before": before, "page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        NotificationThread[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Mark notifications as read
    #
    # + return - Response 
    resource isolated function put notifications(Notifications_body payload) returns NotificationRead|error {
        string resourcePath = string `/notifications`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        NotificationRead response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Get a thread
    #
    # + thread_id - The unique identifier of the notification thread. This corresponds to the value returned in the `id` field when you retrieve notifications (for example with the [`GET /notifications` operation](https://docs.github.com/rest/activity/notifications#list-notifications-for-the-authenticated-user)).
    # + return - Response 
    resource isolated function get notifications/threads/[int thread_id]() returns NotificationThread|error {
        string resourcePath = string `/notifications/threads/${getEncodedUri(thread_id)}`;
        NotificationThread response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Mark a thread as read
    #
    # + thread_id - The unique identifier of the notification thread. This corresponds to the value returned in the `id` field when you retrieve notifications (for example with the [`GET /notifications` operation](https://docs.github.com/rest/activity/notifications#list-notifications-for-the-authenticated-user)).
    # + return - Reset Content 
    resource isolated function patch notifications/threads/[int thread_id]() returns http:Response|error {
        string resourcePath = string `/notifications/threads/${getEncodedUri(thread_id)}`;
        http:Request request = new;
        http:Response response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Get a thread subscription for the authenticated user
    #
    # + thread_id - The unique identifier of the notification thread. This corresponds to the value returned in the `id` field when you retrieve notifications (for example with the [`GET /notifications` operation](https://docs.github.com/rest/activity/notifications#list-notifications-for-the-authenticated-user)).
    # + return - Response 
    resource isolated function get notifications/threads/[int thread_id]/subscription() returns ThreadSubscription|error {
        string resourcePath = string `/notifications/threads/${getEncodedUri(thread_id)}/subscription`;
        ThreadSubscription response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set a thread subscription
    #
    # + thread_id - The unique identifier of the notification thread. This corresponds to the value returned in the `id` field when you retrieve notifications (for example with the [`GET /notifications` operation](https://docs.github.com/rest/activity/notifications#list-notifications-for-the-authenticated-user)).
    # + return - Response 
    resource isolated function put notifications/threads/[int thread_id]/subscription(Thread_id_subscription_body payload) returns ThreadSubscription|error {
        string resourcePath = string `/notifications/threads/${getEncodedUri(thread_id)}/subscription`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        ThreadSubscription response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete a thread subscription
    #
    # + thread_id - The unique identifier of the notification thread. This corresponds to the value returned in the `id` field when you retrieve notifications (for example with the [`GET /notifications` operation](https://docs.github.com/rest/activity/notifications#list-notifications-for-the-authenticated-user)).
    # + return - Response 
    resource isolated function delete notifications/threads/[int thread_id]/subscription() returns http:Response|error {
        string resourcePath = string `/notifications/threads/${getEncodedUri(thread_id)}/subscription`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Get Octocat
    #
    # + s - The words to show in Octocat's speech bubble
    # + return - Response 
    resource isolated function get octocat(string? s = ()) returns string|error {
        string resourcePath = string `/octocat`;
        map<anydata> queryParam = {"s": s};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        string response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List organizations
    #
    # + since - An organization ID. Only return organizations with an ID greater than this ID.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get organizations(int? since = (), int per_page = 30) returns OrganizationSimple[]|error? {
        string resourcePath = string `/organizations`;
        map<anydata> queryParam = {"since": since, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrganizationSimple[]? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]() returns OrganizationFull|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}`;
        OrganizationFull response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Accepted 
    resource isolated function delete orgs/[string org]() returns json|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}`;
        json response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function patch orgs/[string org](Orgs_org_body payload) returns OrganizationFull|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        OrganizationFull response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Get GitHub Actions cache usage for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/cache/usage() returns ActionsCacheUsageOrgEnterprise|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/cache/usage`;
        ActionsCacheUsageOrgEnterprise response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List repositories with GitHub Actions cache usage for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/cache/usage\-by\-repository(int per_page = 30, int page = 1) returns ActionsCacheUsageByRepositoryResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/cache/usage-by-repository`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ActionsCacheUsageByRepositoryResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get the customization template for an OIDC subject claim for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - A JSON serialized template for OIDC subject claim customization 
    resource isolated function get orgs/[string org]/actions/oidc/customization/sub() returns OidcCustomSub|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/oidc/customization/sub`;
        OidcCustomSub response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set the customization template for an OIDC subject claim for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Empty response 
    resource isolated function put orgs/[string org]/actions/oidc/customization/sub(OidcCustomSub payload) returns EmptyObject|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/oidc/customization/sub`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Get GitHub Actions permissions for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/permissions() returns ActionsOrganizationPermissions|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions`;
        ActionsOrganizationPermissions response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set GitHub Actions permissions for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/permissions(Actions_permissions_body payload) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request);
    }
    # List selected repositories enabled for GitHub Actions in an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/permissions/repositories(int per_page = 30, int page = 1) returns RepositoryResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/repositories`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RepositoryResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set selected repositories enabled for GitHub Actions in an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/permissions/repositories(Permissions_repositories_body payload) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/repositories`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request);
    }
    # Enable a selected repository for GitHub Actions in an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + repository_id - The unique identifier of the repository.
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/permissions/repositories/[int repository_id]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/repositories/${getEncodedUri(repository_id)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request);
    }
    # Disable a selected repository for GitHub Actions in an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + repository_id - The unique identifier of the repository.
    # + return - Response 
    resource isolated function delete orgs/[string org]/actions/permissions/repositories/[int repository_id]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/repositories/${getEncodedUri(repository_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Get allowed actions and reusable workflows for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/permissions/selected\-actions() returns SelectedActions|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/selected-actions`;
        SelectedActions response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set allowed actions and reusable workflows for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/permissions/selected\-actions(SelectedActions payload) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/selected-actions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request);
    }
    # Get default workflow permissions for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/permissions/workflow() returns ActionsGetDefaultWorkflowPermissions|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/workflow`;
        ActionsGetDefaultWorkflowPermissions response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set default workflow permissions for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Success response 
    resource isolated function put orgs/[string org]/actions/permissions/workflow(ActionsSetDefaultWorkflowPermissions payload) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/permissions/workflow`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request);
    }
    # List self-hosted runners for an organization
    #
    # + name - The name of a self-hosted runner.
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/runners(string? name = (), int per_page = 30, int page = 1) returns RunnerResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners`;
        map<anydata> queryParam = {"name": name, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RunnerResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List runner applications for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/runners/downloads() returns RunnerApplication[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/downloads`;
        RunnerApplication[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create configuration for a just-in-time runner for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function post orgs/[string org]/actions/runners/generate\-jitconfig(Runners_generatejitconfig_body payload) returns JitConfig|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/generate-jitconfig`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        JitConfig response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Create a registration token for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function post orgs/[string org]/actions/runners/registration\-token() returns AuthenticationToken|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/registration-token`;
        http:Request request = new;
        AuthenticationToken response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Create a remove token for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function post orgs/[string org]/actions/runners/remove\-token() returns AuthenticationToken|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/remove-token`;
        http:Request request = new;
        AuthenticationToken response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a self-hosted runner for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + runner_id - Unique identifier of the self-hosted runner.
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/runners/[int runner_id]() returns Runner|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/${getEncodedUri(runner_id)}`;
        Runner response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a self-hosted runner from an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + runner_id - Unique identifier of the self-hosted runner.
    # + return - Response 
    resource isolated function delete orgs/[string org]/actions/runners/[int runner_id]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/${getEncodedUri(runner_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List labels for a self-hosted runner for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + runner_id - Unique identifier of the self-hosted runner.
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/runners/[int runner_id]/labels() returns RunnerLabelResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/${getEncodedUri(runner_id)}/labels`;
        RunnerLabelResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set custom labels for a self-hosted runner for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + runner_id - Unique identifier of the self-hosted runner.
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/runners/[int runner_id]/labels(Runner_id_labels_body payload) returns RunnerLabelResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/${getEncodedUri(runner_id)}/labels`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RunnerLabelResponse response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Add custom labels to a self-hosted runner for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + runner_id - Unique identifier of the self-hosted runner.
    # + return - Response 
    resource isolated function post orgs/[string org]/actions/runners/[int runner_id]/labels(Runner_id_labels_body_1 payload) returns RunnerLabelResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/${getEncodedUri(runner_id)}/labels`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RunnerLabelResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Remove all custom labels from a self-hosted runner for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + runner_id - Unique identifier of the self-hosted runner.
    # + return - Response 
    resource isolated function delete orgs/[string org]/actions/runners/[int runner_id]/labels() returns RunnerLabelResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/${getEncodedUri(runner_id)}/labels`;
        RunnerLabelResponse response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Remove a custom label from a self-hosted runner for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + runner_id - Unique identifier of the self-hosted runner.
    # + name - The name of a self-hosted runner's custom label.
    # + return - Response 
    resource isolated function delete orgs/[string org]/actions/runners/[int runner_id]/labels/[string name]() returns RunnerLabelResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/runners/${getEncodedUri(runner_id)}/labels/${getEncodedUri(name)}`;
        RunnerLabelResponse response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List organization secrets
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/secrets(int per_page = 30, int page = 1) returns OrganizationActionsSecretResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrganizationActionsSecretResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an organization public key
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/secrets/public\-key() returns ActionsPublicKey|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/public-key`;
        ActionsPublicKey response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/secrets/[string secret_name]() returns OrganizationActionsSecret|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/${getEncodedUri(secret_name)}`;
        OrganizationActionsSecret response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create or update an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response when creating a secret 
    resource isolated function put orgs/[string org]/actions/secrets/[string secret_name](Secrets_secret_name_body payload) returns EmptyObject|error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/${getEncodedUri(secret_name)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject? response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function delete orgs/[string org]/actions/secrets/[string secret_name]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/${getEncodedUri(secret_name)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List selected repositories for an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/secrets/[string secret_name]/repositories(int page = 1, int per_page = 30) returns MinimalRepositoryResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/${getEncodedUri(secret_name)}/repositories`;
        map<anydata> queryParam = {"page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepositoryResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set selected repositories for an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/secrets/[string secret_name]/repositories(Secret_name_repositories_body payload) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/${getEncodedUri(secret_name)}/repositories`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request);
    }
    # Add selected repository to an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - No Content when repository was added to the selected list 
    resource isolated function put orgs/[string org]/actions/secrets/[string secret_name]/repositories/[int repository_id]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/${getEncodedUri(secret_name)}/repositories/${getEncodedUri(repository_id)}`;
        http:Request request = new;
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove selected repository from an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response when repository was removed from the selected list 
    resource isolated function delete orgs/[string org]/actions/secrets/[string secret_name]/repositories/[int repository_id]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/secrets/${getEncodedUri(secret_name)}/repositories/${getEncodedUri(repository_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List organization variables
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 30).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/variables(int per_page = 10, int page = 1) returns OrganizationActionsVariableResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrganizationActionsVariableResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create an organization variable
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response when creating a variable 
    resource isolated function post orgs/[string org]/actions/variables(Actions_variables_body payload) returns EmptyObject|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get an organization variable
    #
    # + org - The organization name. The name is not case sensitive.
    # + name - The name of the variable.
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/variables/[string name]() returns OrganizationActionsVariable|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables/${getEncodedUri(name)}`;
        OrganizationActionsVariable response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete an organization variable
    #
    # + org - The organization name. The name is not case sensitive.
    # + name - The name of the variable.
    # + return - Response 
    resource isolated function delete orgs/[string org]/actions/variables/[string name]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables/${getEncodedUri(name)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Update an organization variable
    #
    # + org - The organization name. The name is not case sensitive.
    # + name - The name of the variable.
    # + return - Response 
    resource isolated function patch orgs/[string org]/actions/variables/[string name](Variables_name_body payload) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables/${getEncodedUri(name)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request);
    }
    # List selected repositories for an organization variable
    #
    # + org - The organization name. The name is not case sensitive.
    # + name - The name of the variable.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get orgs/[string org]/actions/variables/[string name]/repositories(int page = 1, int per_page = 30) returns MinimalRepositoryResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables/${getEncodedUri(name)}/repositories`;
        map<anydata> queryParam = {"page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepositoryResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set selected repositories for an organization variable
    #
    # + org - The organization name. The name is not case sensitive.
    # + name - The name of the variable.
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/variables/[string name]/repositories(Name_repositories_body payload) returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables/${getEncodedUri(name)}/repositories`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Add selected repository to an organization variable
    #
    # + org - The organization name. The name is not case sensitive.
    # + name - The name of the variable.
    # + return - Response 
    resource isolated function put orgs/[string org]/actions/variables/[string name]/repositories/[int repository_id]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables/${getEncodedUri(name)}/repositories/${getEncodedUri(repository_id)}`;
        http:Request request = new;
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove selected repository from an organization variable
    #
    # + org - The organization name. The name is not case sensitive.
    # + name - The name of the variable.
    # + return - Response 
    resource isolated function delete orgs/[string org]/actions/variables/[string name]/repositories/[int repository_id]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/actions/variables/${getEncodedUri(name)}/repositories/${getEncodedUri(repository_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List users blocked by an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/blocks(int per_page = 30, int page = 1) returns SimpleUser[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/blocks`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleUser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Check if a user is blocked by an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - If the user is blocked 
    resource isolated function get orgs/[string org]/blocks/[string username]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/blocks/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Block a user from an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function put orgs/[string org]/blocks/[string username]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/blocks/${getEncodedUri(username)}`;
        http:Request request = new;
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Unblock a user from an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function delete orgs/[string org]/blocks/[string username]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/blocks/${getEncodedUri(username)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List code scanning alerts for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + tool_name - The name of a code scanning tool. Only results by this tool will be listed. You can specify the tool by using either `tool_name` or `tool_guid`, but not both.
    # + tool_guid - The GUID of a code scanning tool. Only results by this tool will be listed. Note that some code scanning tools may not include a GUID in their analysis data. You can specify the tool by using either `tool_guid` or `tool_name`, but not both.
    # + before - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.
    # + after - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + direction - The direction to sort the results by.
    # + state - If specified, only code scanning alerts with this state will be returned.
    # + sort - The property by which to sort the results.
    # + severity - If specified, only code scanning alerts with this severity will be returned.
    # + return - Response 
    resource isolated function get orgs/[string org]/code\-scanning/alerts(CodeScanningAnalysisToolName? tool_name = (), CodeScanningAnalysisToolGuid? tool_guid = (), string? before = (), string? after = (), int page = 1, int per_page = 30, "asc"|"desc" direction = "desc", CodeScanningAlertStateQuery? state = (), "created"|"updated" sort = "created", CodeScanningAlertSeverity? severity = ()) returns CodeScanningOrganizationAlertItems[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/code-scanning/alerts`;
        map<anydata> queryParam = {"tool_name": tool_name, "tool_guid": tool_guid, "before": before, "after": after, "page": page, "per_page": per_page, "direction": direction, "state": state, "sort": sort, "severity": severity};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodeScanningOrganizationAlertItems[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List codespaces for the organization
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/codespaces(int per_page = 30, int page = 1) returns CodespaceResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodespaceResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Manage access control for organization codespaces
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response when successfully modifying permissions. 
    # 
    # # Deprecated
    @deprecated
    resource isolated function put orgs/[string org]/codespaces/access(Codespaces_access_body payload) returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/access`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Add users to Codespaces access for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response when successfully modifying permissions. 
    # 
    # # Deprecated
    @deprecated
    resource isolated function post orgs/[string org]/codespaces/access/selected_users(Access_selected_users_body payload) returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/access/selected_users`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Remove users from Codespaces access for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response when successfully modifying permissions. 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete orgs/[string org]/codespaces/access/selected_users(Access_selected_users_body_1 payload) returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/access/selected_users`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->delete(resourcePath, request);
        return response;
    }
    # List organization secrets
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/codespaces/secrets(int per_page = 30, int page = 1) returns CodespacesOrgSecretResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodespacesOrgSecretResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an organization public key
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/codespaces/secrets/public\-key() returns CodespacesPublicKey|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/public-key`;
        CodespacesPublicKey response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function get orgs/[string org]/codespaces/secrets/[string secret_name]() returns CodespacesOrgSecret|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/${getEncodedUri(secret_name)}`;
        CodespacesOrgSecret response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create or update an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response when creating a secret 
    resource isolated function put orgs/[string org]/codespaces/secrets/[string secret_name](Secrets_secret_name_body_1 payload) returns EmptyObject|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/${getEncodedUri(secret_name)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function delete orgs/[string org]/codespaces/secrets/[string secret_name]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/${getEncodedUri(secret_name)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List selected repositories for an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get orgs/[string org]/codespaces/secrets/[string secret_name]/repositories(int page = 1, int per_page = 30) returns MinimalRepositoryResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/${getEncodedUri(secret_name)}/repositories`;
        map<anydata> queryParam = {"page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepositoryResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set selected repositories for an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function put orgs/[string org]/codespaces/secrets/[string secret_name]/repositories(Secret_name_repositories_body_1 payload) returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/${getEncodedUri(secret_name)}/repositories`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Add selected repository to an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - No Content when repository was added to the selected list 
    resource isolated function put orgs/[string org]/codespaces/secrets/[string secret_name]/repositories/[int repository_id]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/${getEncodedUri(secret_name)}/repositories/${getEncodedUri(repository_id)}`;
        http:Request request = new;
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove selected repository from an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response when repository was removed from the selected list 
    resource isolated function delete orgs/[string org]/codespaces/secrets/[string secret_name]/repositories/[int repository_id]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/codespaces/secrets/${getEncodedUri(secret_name)}/repositories/${getEncodedUri(repository_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Get Copilot for Business seat information and settings for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - OK 
    resource isolated function get orgs/[string org]/copilot/billing() returns CopilotOrganizationDetails|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/copilot/billing`;
        CopilotOrganizationDetails response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List all Copilot for Business seat assignments for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get orgs/[string org]/copilot/billing/seats(int page = 1, int per_page = 50) returns CopilotSeatDetailsResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/copilot/billing/seats`;
        map<anydata> queryParam = {"page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CopilotSeatDetailsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add teams to the Copilot for Business subscription for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - OK 
    resource isolated function post orgs/[string org]/copilot/billing/selected_teams(Billing_selected_teams_body payload) returns CopilotSeatCreated|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/copilot/billing/selected_teams`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CopilotSeatCreated response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Remove teams from the Copilot for Business subscription for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - OK 
    resource isolated function delete orgs/[string org]/copilot/billing/selected_teams(Billing_selected_teams_body_1 payload) returns CopilotSeatCancelled|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/copilot/billing/selected_teams`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CopilotSeatCancelled response = check self.clientEp->delete(resourcePath, request);
        return response;
    }
    # Add users to the Copilot for Business subscription for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - OK 
    resource isolated function post orgs/[string org]/copilot/billing/selected_users(Billing_selected_users_body payload) returns CopilotSeatCreated|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/copilot/billing/selected_users`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CopilotSeatCreated response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Remove users from the Copilot for Business subscription for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - OK 
    resource isolated function delete orgs/[string org]/copilot/billing/selected_users(Billing_selected_users_body_1 payload) returns CopilotSeatCancelled|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/copilot/billing/selected_users`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CopilotSeatCancelled response = check self.clientEp->delete(resourcePath, request);
        return response;
    }
    # List Dependabot alerts for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + state - A comma-separated list of states. If specified, only alerts with these states will be returned.
    # Can be: `auto_dismissed`, `dismissed`, `fixed`, `open`
    # + severity - A comma-separated list of severities. If specified, only alerts with these severities will be returned.
    # Can be: `low`, `medium`, `high`, `critical`
    # + ecosystem - A comma-separated list of ecosystems. If specified, only alerts for these ecosystems will be returned.
    # Can be: `composer`, `go`, `maven`, `npm`, `nuget`, `pip`, `pub`, `rubygems`, `rust`
    # + package - A comma-separated list of package names. If specified, only alerts for these packages will be returned.
    # + scope - The scope of the vulnerable dependency. If specified, only alerts with this scope will be returned.
    # + sort - The property by which to sort the results.
    # `created` means when the alert was created.
    # `updated` means when the alert's state last changed.
    # + direction - The direction to sort the results by.
    # + before - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.
    # + after - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.
    # + first - **Deprecated**. The number of results per page (max 100), starting from the first matching result.
    # This parameter must not be used in combination with `last`.
    # Instead, use `per_page` in combination with `after` to fetch the first page of results.
    # + last - **Deprecated**. The number of results per page (max 100), starting from the last matching result.
    # This parameter must not be used in combination with `first`.
    # Instead, use `per_page` in combination with `before` to fetch the last page of results.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get orgs/[string org]/dependabot/alerts(string? state = (), string? severity = (), string? ecosystem = (), string? package = (), "development"|"runtime"? scope = (), "created"|"updated" sort = "created", "asc"|"desc" direction = "desc", string? before = (), string? after = (), int first = 30, int? last = (), int per_page = 30) returns DependabotAlertWithRepository[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/alerts`;
        map<anydata> queryParam = {"state": state, "severity": severity, "ecosystem": ecosystem, "package": package, "scope": scope, "sort": sort, "direction": direction, "before": before, "after": after, "first": first, "last": last, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        DependabotAlertWithRepository[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List organization secrets
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/dependabot/secrets(int per_page = 30, int page = 1) returns OrganizationDependabotSecretResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrganizationDependabotSecretResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an organization public key
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/dependabot/secrets/public\-key() returns DependabotPublicKey|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/public-key`;
        DependabotPublicKey response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function get orgs/[string org]/dependabot/secrets/[string secret_name]() returns OrganizationDependabotSecret|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/${getEncodedUri(secret_name)}`;
        OrganizationDependabotSecret response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create or update an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response when creating a secret 
    resource isolated function put orgs/[string org]/dependabot/secrets/[string secret_name](Secrets_secret_name_body_2 payload) returns EmptyObject|error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/${getEncodedUri(secret_name)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject? response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function delete orgs/[string org]/dependabot/secrets/[string secret_name]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/${getEncodedUri(secret_name)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List selected repositories for an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get orgs/[string org]/dependabot/secrets/[string secret_name]/repositories(int page = 1, int per_page = 30) returns MinimalRepositoryResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/${getEncodedUri(secret_name)}/repositories`;
        map<anydata> queryParam = {"page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepositoryResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set selected repositories for an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function put orgs/[string org]/dependabot/secrets/[string secret_name]/repositories(Secret_name_repositories_body_2 payload) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/${getEncodedUri(secret_name)}/repositories`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request);
    }
    # Add selected repository to an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - No Content when repository was added to the selected list 
    resource isolated function put orgs/[string org]/dependabot/secrets/[string secret_name]/repositories/[int repository_id]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/${getEncodedUri(secret_name)}/repositories/${getEncodedUri(repository_id)}`;
        http:Request request = new;
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove selected repository from an organization secret
    #
    # + org - The organization name. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response when repository was removed from the selected list 
    resource isolated function delete orgs/[string org]/dependabot/secrets/[string secret_name]/repositories/[int repository_id]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/dependabot/secrets/${getEncodedUri(secret_name)}/repositories/${getEncodedUri(repository_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Get list of conflicting packages during Docker migration for organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/docker/conflicts() returns Package[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/docker/conflicts`;
        Package[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List public organization events
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/events(int per_page = 30, int page = 1) returns Event[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/events`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Event[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List failed organization invitations
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/failed_invitations(int per_page = 30, int page = 1) returns OrganizationInvitation[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/failed_invitations`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrganizationInvitation[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List organization webhooks
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/hooks(int per_page = 30, int page = 1) returns OrgHook[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrgHook[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create an organization webhook
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function post orgs/[string org]/hooks(Org_hooks_body payload) returns OrgHook|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        OrgHook response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get an organization webhook
    #
    # + org - The organization name. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Response 
    resource isolated function get orgs/[string org]/hooks/[int hook_id]() returns OrgHook|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hook_id)}`;
        OrgHook response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete an organization webhook
    #
    # + org - The organization name. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Response 
    resource isolated function delete orgs/[string org]/hooks/[int hook_id]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hook_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update an organization webhook
    #
    # + org - The organization name. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Response 
    resource isolated function patch orgs/[string org]/hooks/[int hook_id](Hooks_hook_id_body payload) returns OrgHook|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hook_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        OrgHook response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Get a webhook configuration for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Response 
    resource isolated function get orgs/[string org]/hooks/[int hook_id]/config() returns WebhookConfig|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hook_id)}/config`;
        WebhookConfig response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a webhook configuration for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Response 
    resource isolated function patch orgs/[string org]/hooks/[int hook_id]/config(Hook_id_config_body payload) returns WebhookConfig|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hook_id)}/config`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        WebhookConfig response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List deliveries for an organization webhook
    #
    # + org - The organization name. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + per_page - The number of results per page (max 100).
    # + cursor - Used for pagination: the starting delivery from which the page of deliveries is fetched. Refer to the `link` header for the next and previous page cursors.
    # + return - Response 
    resource isolated function get orgs/[string org]/hooks/[int hook_id]/deliveries(int per_page = 30, string? cursor = (), boolean? redelivery = ()) returns HookDeliveryItem[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hook_id)}/deliveries`;
        map<anydata> queryParam = {"per_page": per_page, "cursor": cursor, "redelivery": redelivery};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        HookDeliveryItem[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a webhook delivery for an organization webhook
    #
    # + org - The organization name. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Response 
    resource isolated function get orgs/[string org]/hooks/[int hook_id]/deliveries/[int delivery_id]() returns HookDelivery|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hook_id)}/deliveries/${getEncodedUri(delivery_id)}`;
        HookDelivery response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Redeliver a delivery for an organization webhook
    #
    # + org - The organization name. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Accepted 
    resource isolated function post orgs/[string org]/hooks/[int hook_id]/deliveries/[int delivery_id]/attempts() returns json|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hook_id)}/deliveries/${getEncodedUri(delivery_id)}/attempts`;
        http:Request request = new;
        json response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Ping an organization webhook
    #
    # + org - The organization name. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Response 
    resource isolated function post orgs/[string org]/hooks/[int hook_id]/pings() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/hooks/${getEncodedUri(hook_id)}/pings`;
        http:Request request = new;
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get an organization installation for the authenticated app
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/installation() returns Installation|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/installation`;
        Installation response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List app installations for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/installations(int per_page = 30, int page = 1) returns InstallationResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/installations`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        InstallationResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get interaction restrictions for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/interaction\-limits() returns InteractionLimitResponseAny|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/interaction-limits`;
        InteractionLimitResponseAny response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set interaction restrictions for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function put orgs/[string org]/interaction\-limits(InteractionLimit payload) returns InteractionLimitResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/interaction-limits`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        InteractionLimitResponse response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove interaction restrictions for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function delete orgs/[string org]/interaction\-limits() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/interaction-limits`;
        return self.clientEp->delete(resourcePath);
    }
    # List pending organization invitations
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + role - Filter invitations by their member role.
    # + invitation_source - Filter invitations by their invitation source.
    # + return - Response 
    resource isolated function get orgs/[string org]/invitations(int per_page = 30, int page = 1, "all"|"admin"|"direct_member"|"billing_manager"|"hiring_manager" role = "all", "all"|"member"|"scim" invitation_source = "all") returns OrganizationInvitation[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/invitations`;
        map<anydata> queryParam = {"per_page": per_page, "page": page, "role": role, "invitation_source": invitation_source};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrganizationInvitation[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create an organization invitation
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function post orgs/[string org]/invitations(Org_invitations_body payload) returns OrganizationInvitation|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/invitations`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        OrganizationInvitation response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Cancel an organization invitation
    #
    # + org - The organization name. The name is not case sensitive.
    # + invitation_id - The unique identifier of the invitation.
    # + return - Response 
    resource isolated function delete orgs/[string org]/invitations/[int invitation_id]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/invitations/${getEncodedUri(invitation_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List organization invitation teams
    #
    # + org - The organization name. The name is not case sensitive.
    # + invitation_id - The unique identifier of the invitation.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/invitations/[int invitation_id]/teams(int per_page = 30, int page = 1) returns Team[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/invitations/${getEncodedUri(invitation_id)}/teams`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Team[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List organization issues assigned to the authenticated user
    #
    # + org - The organization name. The name is not case sensitive.
    # + filter - Indicates which sorts of issues to return. `assigned` means issues assigned to you. `created` means issues created by you. `mentioned` means issues mentioning you. `subscribed` means issues you're subscribed to updates for. `all` or `repos` means all issues you can see, regardless of participation or creation.
    # + state - Indicates the state of the issues to return.
    # + labels - A list of comma separated label names. Example: `bug,ui,@high`
    # + sort - What to sort results by.
    # + direction - The direction to sort the results by.
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/issues("assigned"|"created"|"mentioned"|"subscribed"|"repos"|"all" filter = "assigned", "open"|"closed"|"all" state = "open", string? labels = (), "created"|"updated"|"comments" sort = "created", "asc"|"desc" direction = "desc", string? since = (), int per_page = 30, int page = 1) returns Issue[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/issues`;
        map<anydata> queryParam = {"filter": filter, "state": state, "labels": labels, "sort": sort, "direction": direction, "since": since, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Issue[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List organization members
    #
    # + org - The organization name. The name is not case sensitive.
    # + filter - Filter members returned in the list. `2fa_disabled` means that only members without [two-factor authentication](https://github.com/blog/1614-two-factor-authentication) enabled will be returned. This options is only available for organization owners.
    # + role - Filter members returned by their role.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/members("2fa_disabled"|"all" filter = "all", "all"|"admin"|"member" role = "all", int per_page = 30, int page = 1) returns SimpleUser[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/members`;
        map<anydata> queryParam = {"filter": filter, "role": role, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleUser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Check organization membership for a user
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - Response if requester is an organization member and user is a member 
    resource isolated function get orgs/[string org]/members/[string username]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/members/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Remove an organization member
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function delete orgs/[string org]/members/[string username]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/members/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List codespaces for a user in organization
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function get orgs/[string org]/members/[string username]/codespaces(int per_page = 30, int page = 1) returns CodespaceResponse|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/members/${getEncodedUri(username)}/codespaces`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodespaceResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a codespace from the organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + codespace_name - The name of the codespace.
    # + return - Accepted 
    resource isolated function delete orgs/[string org]/members/[string username]/codespaces/[string codespace_name]() returns json|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/members/${getEncodedUri(username)}/codespaces/${getEncodedUri(codespace_name)}`;
        json response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Stop a codespace for an organization user
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + codespace_name - The name of the codespace.
    # + return - Response 
    resource isolated function post orgs/[string org]/members/[string username]/codespaces/[string codespace_name]/stop() returns Codespace|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/members/${getEncodedUri(username)}/codespaces/${getEncodedUri(codespace_name)}/stop`;
        http:Request request = new;
        Codespace response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get Copilot for Business seat assignment details for a user
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - The user's GitHub Copilot seat details, including usage. 
    resource isolated function get orgs/[string org]/members/[string username]/copilot() returns CopilotSeatDetails|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/members/${getEncodedUri(username)}/copilot`;
        CopilotSeatDetails response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get organization membership for a user
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function get orgs/[string org]/memberships/[string username]() returns OrgMembership|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/memberships/${getEncodedUri(username)}`;
        OrgMembership response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set organization membership for a user
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function put orgs/[string org]/memberships/[string username](Memberships_username_body payload) returns OrgMembership|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/memberships/${getEncodedUri(username)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        OrgMembership response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove organization membership for a user
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function delete orgs/[string org]/memberships/[string username]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/memberships/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List organization migrations
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + exclude - Exclude attributes from the API response to improve performance
    # + return - Response 
    resource isolated function get orgs/[string org]/migrations(int per_page = 30, int page = 1, ("repositories")[]? exclude = ()) returns Migration[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/migrations`;
        map<anydata> queryParam = {"per_page": per_page, "page": page, "exclude": exclude};
        map<Encoding> queryParamEncoding = {"exclude": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Migration[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Start an organization migration
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function post orgs/[string org]/migrations(Org_migrations_body payload) returns Migration|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/migrations`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Migration response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get an organization migration status
    #
    # + org - The organization name. The name is not case sensitive.
    # + migration_id - The unique identifier of the migration.
    # + exclude - Exclude attributes from the API response to improve performance
    # + return - *   `pending`, which means the migration hasn't started yet. *   `exporting`, which means the migration is in progress. *   `exported`, which means the migration finished successfully. *   `failed`, which means the migration failed. 
    resource isolated function get orgs/[string org]/migrations/[int migration_id](("repositories")[]? exclude = ()) returns Migration|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/migrations/${getEncodedUri(migration_id)}`;
        map<anydata> queryParam = {"exclude": exclude};
        map<Encoding> queryParamEncoding = {"exclude": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Migration response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Download an organization migration archive
    #
    # + org - The organization name. The name is not case sensitive.
    # + migration_id - The unique identifier of the migration.
    # + return - Response 
    resource isolated function get orgs/[string org]/migrations/[int migration_id]/archive() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/migrations/${getEncodedUri(migration_id)}/archive`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete an organization migration archive
    #
    # + org - The organization name. The name is not case sensitive.
    # + migration_id - The unique identifier of the migration.
    # + return - Response 
    resource isolated function delete orgs/[string org]/migrations/[int migration_id]/archive() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/migrations/${getEncodedUri(migration_id)}/archive`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Unlock an organization repository
    #
    # + org - The organization name. The name is not case sensitive.
    # + migration_id - The unique identifier of the migration.
    # + repo_name - repo_name parameter
    # + return - Response 
    resource isolated function delete orgs/[string org]/migrations/[int migration_id]/repos/[string repo_name]/'lock() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/migrations/${getEncodedUri(migration_id)}/repos/${getEncodedUri(repo_name)}/lock`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List repositories in an organization migration
    #
    # + org - The organization name. The name is not case sensitive.
    # + migration_id - The unique identifier of the migration.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/migrations/[int migration_id]/repositories(int per_page = 30, int page = 1) returns MinimalRepository[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/migrations/${getEncodedUri(migration_id)}/repositories`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepository[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List outside collaborators for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + filter - Filter the list of outside collaborators. `2fa_disabled` means that only outside collaborators without [two-factor authentication](https://github.com/blog/1614-two-factor-authentication) enabled will be returned.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/outside_collaborators("2fa_disabled"|"all" filter = "all", int per_page = 30, int page = 1) returns SimpleUser[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/outside_collaborators`;
        map<anydata> queryParam = {"filter": filter, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleUser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Convert an organization member to outside collaborator
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - User is getting converted asynchronously 
    resource isolated function put orgs/[string org]/outside_collaborators/[string username](Outside_collaborators_username_body payload) returns json|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/outside_collaborators/${getEncodedUri(username)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        json response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove outside collaborator from an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function delete orgs/[string org]/outside_collaborators/[string username]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/outside_collaborators/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List packages for an organization
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + org - The organization name. The name is not case sensitive.
    # + visibility - The selected visibility of the packages.  This parameter is optional and only filters an existing result set.
    # The `internal` visibility is only supported for GitHub Packages registries that allow for granular permissions. For other ecosystems `internal` is synonymous with `private`.
    # For the list of GitHub Packages registries that support granular permissions, see "[About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages#granular-permissions-for-userorganization-scoped-packages)."
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get orgs/[string org]/packages("npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type, "public"|"private"|"internal"? visibility = (), int page = 1, int per_page = 30) returns Package[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages`;
        map<anydata> queryParam = {"package_type": package_type, "visibility": visibility, "page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Package[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a package for an organization
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]() returns Package|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}`;
        Package response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a package for an organization
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function delete orgs/[string org]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Restore a package for an organization
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + org - The organization name. The name is not case sensitive.
    # + token - package token
    # + return - Response 
    resource isolated function post orgs/[string org]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]/restore(string? token = ()) returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}/restore`;
        map<anydata> queryParam = {"token": token};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        http:Request request = new;
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List package versions for a package owned by an organization
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + org - The organization name. The name is not case sensitive.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + state - The state of the package, either active or deleted.
    # + return - Response 
    resource isolated function get orgs/[string org]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]/versions(int page = 1, int per_page = 30, "active"|"deleted" state = "active") returns PackageVersion[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}/versions`;
        map<anydata> queryParam = {"page": page, "per_page": per_page, "state": state};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        PackageVersion[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a package version for an organization
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + org - The organization name. The name is not case sensitive.
    # + package_version_id - Unique identifier of the package version.
    # + return - Response 
    resource isolated function get orgs/[string org]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]/versions/[int package_version_id]() returns PackageVersion|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}/versions/${getEncodedUri(package_version_id)}`;
        PackageVersion response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete package version for an organization
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + org - The organization name. The name is not case sensitive.
    # + package_version_id - Unique identifier of the package version.
    # + return - Response 
    resource isolated function delete orgs/[string org]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]/versions/[int package_version_id]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}/versions/${getEncodedUri(package_version_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Restore package version for an organization
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + org - The organization name. The name is not case sensitive.
    # + package_version_id - Unique identifier of the package version.
    # + return - Response 
    resource isolated function post orgs/[string org]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]/versions/[int package_version_id]/restore() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}/versions/${getEncodedUri(package_version_id)}/restore`;
        http:Request request = new;
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List requests to access organization resources with fine-grained personal access tokens
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + sort - The property by which to sort the results.
    # + direction - The direction to sort the results by.
    # + owner - A list of owner usernames to use to filter the results.
    # + repository - The name of the repository to use to filter the results.
    # + permission - The permission to use to filter the results.
    # + last_used_before - Only show fine-grained personal access tokens used before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + last_used_after - Only show fine-grained personal access tokens used after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + return - Internal Error 
    resource isolated function get orgs/[string org]/personal\-access\-token\-requests(int per_page = 30, int page = 1, "created_at" sort = "created_at", "asc"|"desc" direction = "desc", string[]? owner = (), string? repository = (), string? permission = (), string? last_used_before = (), string? last_used_after = ()) returns OrganizationProgrammaticAccessGrantRequest[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-token-requests`;
        map<anydata> queryParam = {"per_page": per_page, "page": page, "sort": sort, "direction": direction, "owner": owner, "repository": repository, "permission": permission, "last_used_before": last_used_before, "last_used_after": last_used_after};
        map<Encoding> queryParamEncoding = {"owner": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        OrganizationProgrammaticAccessGrantRequest[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Review requests to access organization resources with fine-grained personal access tokens
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Internal Error 
    resource isolated function post orgs/[string org]/personal\-access\-token\-requests(Org_personalaccesstokenrequests_body payload) returns json|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-token-requests`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        json response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Review a request to access organization resources with a fine-grained personal access token
    #
    # + org - The organization name. The name is not case sensitive.
    # + pat_request_id - Unique identifier of the request for access via fine-grained personal access token.
    # + return - Internal Error 
    resource isolated function post orgs/[string org]/personal\-access\-token\-requests/[int pat_request_id](Personalaccesstokenrequests_pat_request_id_body payload) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-token-requests/${getEncodedUri(pat_request_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request);
    }
    # List repositories requested to be accessed by a fine-grained personal access token
    #
    # + org - The organization name. The name is not case sensitive.
    # + pat_request_id - Unique identifier of the request for access via fine-grained personal access token.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Internal Error 
    resource isolated function get orgs/[string org]/personal\-access\-token\-requests/[int pat_request_id]/repositories(int per_page = 30, int page = 1) returns MinimalRepository[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-token-requests/${getEncodedUri(pat_request_id)}/repositories`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepository[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List fine-grained personal access tokens with access to organization resources
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + sort - The property by which to sort the results.
    # + direction - The direction to sort the results by.
    # + owner - A list of owner usernames to use to filter the results.
    # + repository - The name of the repository to use to filter the results.
    # + permission - The permission to use to filter the results.
    # + last_used_before - Only show fine-grained personal access tokens used before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + last_used_after - Only show fine-grained personal access tokens used after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + return - Internal Error 
    resource isolated function get orgs/[string org]/personal\-access\-tokens(int per_page = 30, int page = 1, "created_at" sort = "created_at", "asc"|"desc" direction = "desc", string[]? owner = (), string? repository = (), string? permission = (), string? last_used_before = (), string? last_used_after = ()) returns OrganizationProgrammaticAccessGrant[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-tokens`;
        map<anydata> queryParam = {"per_page": per_page, "page": page, "sort": sort, "direction": direction, "owner": owner, "repository": repository, "permission": permission, "last_used_before": last_used_before, "last_used_after": last_used_after};
        map<Encoding> queryParamEncoding = {"owner": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        OrganizationProgrammaticAccessGrant[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update the access to organization resources via fine-grained personal access tokens
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Internal Error 
    resource isolated function post orgs/[string org]/personal\-access\-tokens(Org_personalaccesstokens_body payload) returns json|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-tokens`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        json response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Update the access a fine-grained personal access token has to organization resources
    #
    # + org - The organization name. The name is not case sensitive.
    # + pat_id - The unique identifier of the fine-grained personal access token.
    # + return - Internal Error 
    resource isolated function post orgs/[string org]/personal\-access\-tokens/[int pat_id](Personalaccesstokens_pat_id_body payload) returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-tokens/${getEncodedUri(pat_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List repositories a fine-grained personal access token has access to
    #
    # + org - The organization name. The name is not case sensitive.
    # + pat_id - Unique identifier of the fine-grained personal access token.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Internal Error 
    resource isolated function get orgs/[string org]/personal\-access\-tokens/[int pat_id]/repositories(int per_page = 30, int page = 1) returns MinimalRepository[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/personal-access-tokens/${getEncodedUri(pat_id)}/repositories`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepository[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List organization projects
    #
    # + org - The organization name. The name is not case sensitive.
    # + state - Indicates the state of the projects to return.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/projects("open"|"closed"|"all" state = "open", int per_page = 30, int page = 1) returns Project[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/projects`;
        map<anydata> queryParam = {"state": state, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Project[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create an organization project
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function post orgs/[string org]/projects(Org_projects_body payload) returns Project|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/projects`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Project response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List public organization members
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/public_members(int per_page = 30, int page = 1) returns SimpleUser[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/public_members`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleUser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Check public organization membership for a user
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - Response if user is a public member 
    resource isolated function get orgs/[string org]/public_members/[string username]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/public_members/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set public organization membership for the authenticated user
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function put orgs/[string org]/public_members/[string username]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/public_members/${getEncodedUri(username)}`;
        http:Request request = new;
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove public organization membership for the authenticated user
    #
    # + org - The organization name. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function delete orgs/[string org]/public_members/[string username]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/public_members/${getEncodedUri(username)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List organization repositories
    #
    # + org - The organization name. The name is not case sensitive.
    # + 'type - Specifies the types of repositories you want returned.
    # + sort - The property to sort the results by.
    # + direction - The order to sort by. Default: `asc` when using `full_name`, otherwise `desc`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/repos("all"|"public"|"private"|"forks"|"sources"|"member" 'type = "all", "created"|"updated"|"pushed"|"full_name" sort = "created", "asc"|"desc"? direction = (), int per_page = 30, int page = 1) returns MinimalRepository[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/repos`;
        map<anydata> queryParam = {"type": 'type, "sort": sort, "direction": direction, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepository[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create an organization repository
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function post orgs/[string org]/repos(Org_repos_body payload) returns Repository|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/repos`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Repository response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get all organization repository rulesets
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/rulesets(int per_page = 30, int page = 1) returns RepositoryRuleset[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/rulesets`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RepositoryRuleset[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create an organization repository ruleset
    #
    # + org - The organization name. The name is not case sensitive.
    # + payload - Request body
    # + return - Response 
    resource isolated function post orgs/[string org]/rulesets(Org_rulesets_body payload) returns RepositoryRuleset|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/rulesets`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RepositoryRuleset response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List organization rule suites
    #
    # + org - The organization name. The name is not case sensitive.
    # + repository_name - The name of the repository to filter on. When specified, only rule evaluations from this repository will be returned.
    # + time_period - The time period to filter by.
    # For example, `day` will filter for rule suites that occurred in the past 24 hours, and `week` will filter for insights that occurred in the past 7 days (168 hours).
    # + actor_name - The handle for the GitHub user account to filter on. When specified, only rule evaluations triggered by this actor will be returned.
    # + rule_suite_result - The rule results to filter on. When specified, only suites with this result will be returned.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/rulesets/rule\-suites(int? repository_name = (), "hour"|"day"|"week"|"month" time_period = "day", string? actor_name = (), "pass"|"fail"|"bypass"|"all" rule_suite_result = "all", int per_page = 30, int page = 1) returns RuleSuites|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/rulesets/rule-suites`;
        map<anydata> queryParam = {"repository_name": repository_name, "time_period": time_period, "actor_name": actor_name, "rule_suite_result": rule_suite_result, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RuleSuites response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an organization rule suite
    #
    # + org - The organization name. The name is not case sensitive.
    # + rule_suite_id - The unique identifier of the rule suite result.
    # To get this ID, you can use [GET /repos/{owner}/{repo}/rulesets/rule-suites](https://docs.github.com/rest/repos/rule-suites#list-repository-rule-suites)
    # for repositories and [GET /orgs/{org}/rulesets/rule-suites](https://docs.github.com/rest/orgs/rule-suites#list-organization-rule-suites)
    # for organizations.
    # + return - Response 
    resource isolated function get orgs/[string org]/rulesets/rule\-suites/[int rule_suite_id]() returns RuleSuite|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/rulesets/rule-suites/${getEncodedUri(rule_suite_id)}`;
        RuleSuite response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an organization repository ruleset
    #
    # + org - The organization name. The name is not case sensitive.
    # + ruleset_id - The ID of the ruleset.
    # + return - Response 
    resource isolated function get orgs/[string org]/rulesets/[int ruleset_id]() returns RepositoryRuleset|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/rulesets/${getEncodedUri(ruleset_id)}`;
        RepositoryRuleset response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update an organization repository ruleset
    #
    # + org - The organization name. The name is not case sensitive.
    # + ruleset_id - The ID of the ruleset.
    # + payload - Request body
    # + return - Response 
    resource isolated function put orgs/[string org]/rulesets/[int ruleset_id](Rulesets_ruleset_id_body payload) returns RepositoryRuleset|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/rulesets/${getEncodedUri(ruleset_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RepositoryRuleset response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete an organization repository ruleset
    #
    # + org - The organization name. The name is not case sensitive.
    # + ruleset_id - The ID of the ruleset.
    # + return - Response 
    resource isolated function delete orgs/[string org]/rulesets/[int ruleset_id]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/rulesets/${getEncodedUri(ruleset_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List secret scanning alerts for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + state - Set to `open` or `resolved` to only list secret scanning alerts in a specific state.
    # + secret_type - A comma-separated list of secret types to return. By default all secret types are returned.
    # See "[Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns#supported-secrets-for-advanced-security)"
    # for a complete list of secret types.
    # + resolution - A comma-separated list of resolutions. Only secret scanning alerts with one of these resolutions are listed. Valid resolutions are `false_positive`, `wont_fix`, `revoked`, `pattern_edited`, `pattern_deleted` or `used_in_tests`.
    # + sort - The property to sort the results by. `created` means when the alert was created. `updated` means when the alert was updated or resolved.
    # + direction - The direction to sort the results by.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + before - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for events before this cursor. To receive an initial cursor on your first request, include an empty "before" query string.
    # + after - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for events after this cursor.  To receive an initial cursor on your first request, include an empty "after" query string.
    # + return - Response 
    resource isolated function get orgs/[string org]/secret\-scanning/alerts("open"|"resolved"? state = (), string? secret_type = (), string? resolution = (), "created"|"updated" sort = "created", "asc"|"desc" direction = "desc", int page = 1, int per_page = 30, string? before = (), string? after = ()) returns OrganizationSecretScanningAlert[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/secret-scanning/alerts`;
        map<anydata> queryParam = {"state": state, "secret_type": secret_type, "resolution": resolution, "sort": sort, "direction": direction, "page": page, "per_page": per_page, "before": before, "after": after};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrganizationSecretScanningAlert[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List repository security advisories for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + direction - The direction to sort the results by.
    # + sort - The property to sort the results by.
    # + before - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.
    # + after - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.
    # + per_page - The number of advisories to return per page.
    # + state - Filter by the state of the repository advisories. Only advisories of this state will be returned.
    # + return - Response 
    resource isolated function get orgs/[string org]/security\-advisories("asc"|"desc" direction = "desc", "created"|"updated"|"published" sort = "created", string? before = (), string? after = (), int per_page = 30, "triage"|"draft"|"published"|"closed"? state = ()) returns RepositoryAdvisory[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/security-advisories`;
        map<anydata> queryParam = {"direction": direction, "sort": sort, "before": before, "after": after, "per_page": per_page, "state": state};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RepositoryAdvisory[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List security manager teams
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/security\-managers() returns TeamSimple[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/security-managers`;
        TeamSimple[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add a security manager team
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + return - Response 
    resource isolated function put orgs/[string org]/security\-managers/teams/[string team_slug]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/security-managers/teams/${getEncodedUri(team_slug)}`;
        http:Request request = new;
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove a security manager team
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + return - Response 
    resource isolated function delete orgs/[string org]/security\-managers/teams/[string team_slug]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/security-managers/teams/${getEncodedUri(team_slug)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Get GitHub Actions billing for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/settings/billing/actions() returns ActionsBillingUsage|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/settings/billing/actions`;
        ActionsBillingUsage response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get GitHub Packages billing for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/settings/billing/packages() returns PackagesBillingUsage|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/settings/billing/packages`;
        PackagesBillingUsage response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get shared storage billing for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get orgs/[string org]/settings/billing/shared\-storage() returns CombinedBillingUsage|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/settings/billing/shared-storage`;
        CombinedBillingUsage response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List teams
    #
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/teams(int per_page = 30, int page = 1) returns Team[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Team[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a team
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function post orgs/[string org]/teams(Org_teams_body payload) returns TeamFull|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TeamFull response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a team by name
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string team_slug]() returns TeamFull|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}`;
        TeamFull response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a team
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string team_slug]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Update a team
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + return - Response when the updated information already exists 
    resource isolated function patch orgs/[string org]/teams/[string team_slug](Teams_team_slug_body payload) returns TeamFull|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TeamFull response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List discussions
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + direction - The direction to sort the results by.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + pinned - Pinned discussions only filter
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string team_slug]/discussions("asc"|"desc" direction = "desc", int per_page = 30, int page = 1, string? pinned = ()) returns TeamDiscussion[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions`;
        map<anydata> queryParam = {"direction": direction, "per_page": per_page, "page": page, "pinned": pinned};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        TeamDiscussion[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a discussion
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + return - Response 
    resource isolated function post orgs/[string org]/teams/[string team_slug]/discussions(Team_slug_discussions_body payload) returns TeamDiscussion|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TeamDiscussion response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a discussion
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + discussion_number - The number that identifies the discussion.
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string team_slug]/discussions/[int discussion_number]() returns TeamDiscussion|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions/${getEncodedUri(discussion_number)}`;
        TeamDiscussion response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a discussion
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + discussion_number - The number that identifies the discussion.
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string team_slug]/discussions/[int discussion_number]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions/${getEncodedUri(discussion_number)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Update a discussion
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + discussion_number - The number that identifies the discussion.
    # + return - Response 
    resource isolated function patch orgs/[string org]/teams/[string team_slug]/discussions/[int discussion_number](Discussions_discussion_number_body payload) returns TeamDiscussion|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions/${getEncodedUri(discussion_number)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TeamDiscussion response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List discussion comments
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + discussion_number - The number that identifies the discussion.
    # + direction - The direction to sort the results by.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string team_slug]/discussions/[int discussion_number]/comments("asc"|"desc" direction = "desc", int per_page = 30, int page = 1) returns TeamDiscussionComment[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions/${getEncodedUri(discussion_number)}/comments`;
        map<anydata> queryParam = {"direction": direction, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        TeamDiscussionComment[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a discussion comment
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + discussion_number - The number that identifies the discussion.
    # + return - Response 
    resource isolated function post orgs/[string org]/teams/[string team_slug]/discussions/[int discussion_number]/comments(Discussion_number_comments_body payload) returns TeamDiscussionComment|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions/${getEncodedUri(discussion_number)}/comments`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TeamDiscussionComment response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a discussion comment
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + discussion_number - The number that identifies the discussion.
    # + comment_number - The number that identifies the comment.
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string team_slug]/discussions/[int discussion_number]/comments/[int comment_number]() returns TeamDiscussionComment|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions/${getEncodedUri(discussion_number)}/comments/${getEncodedUri(comment_number)}`;
        TeamDiscussionComment response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a discussion comment
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + discussion_number - The number that identifies the discussion.
    # + comment_number - The number that identifies the comment.
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string team_slug]/discussions/[int discussion_number]/comments/[int comment_number]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions/${getEncodedUri(discussion_number)}/comments/${getEncodedUri(comment_number)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Update a discussion comment
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + discussion_number - The number that identifies the discussion.
    # + comment_number - The number that identifies the comment.
    # + return - Response 
    resource isolated function patch orgs/[string org]/teams/[string team_slug]/discussions/[int discussion_number]/comments/[int comment_number](Comments_comment_number_body payload) returns TeamDiscussionComment|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions/${getEncodedUri(discussion_number)}/comments/${getEncodedUri(comment_number)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TeamDiscussionComment response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List reactions for a team discussion comment
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + discussion_number - The number that identifies the discussion.
    # + comment_number - The number that identifies the comment.
    # + content - Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to a team discussion comment.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string team_slug]/discussions/[int discussion_number]/comments/[int comment_number]/reactions("+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes"? content = (), int per_page = 30, int page = 1) returns Reaction[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions/${getEncodedUri(discussion_number)}/comments/${getEncodedUri(comment_number)}/reactions`;
        map<anydata> queryParam = {"content": content, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Reaction[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create reaction for a team discussion comment
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + discussion_number - The number that identifies the discussion.
    # + comment_number - The number that identifies the comment.
    # + return - Response when the reaction type has already been added to this team discussion comment 
    resource isolated function post orgs/[string org]/teams/[string team_slug]/discussions/[int discussion_number]/comments/[int comment_number]/reactions(Comment_number_reactions_body payload) returns Reaction|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions/${getEncodedUri(discussion_number)}/comments/${getEncodedUri(comment_number)}/reactions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Reaction response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete team discussion comment reaction
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + discussion_number - The number that identifies the discussion.
    # + comment_number - The number that identifies the comment.
    # + reaction_id - The unique identifier of the reaction.
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string team_slug]/discussions/[int discussion_number]/comments/[int comment_number]/reactions/[int reaction_id]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions/${getEncodedUri(discussion_number)}/comments/${getEncodedUri(comment_number)}/reactions/${getEncodedUri(reaction_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List reactions for a team discussion
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + discussion_number - The number that identifies the discussion.
    # + content - Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to a team discussion.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string team_slug]/discussions/[int discussion_number]/reactions("+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes"? content = (), int per_page = 30, int page = 1) returns Reaction[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions/${getEncodedUri(discussion_number)}/reactions`;
        map<anydata> queryParam = {"content": content, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Reaction[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create reaction for a team discussion
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + discussion_number - The number that identifies the discussion.
    # + return - Response 
    resource isolated function post orgs/[string org]/teams/[string team_slug]/discussions/[int discussion_number]/reactions(Discussion_number_reactions_body payload) returns Reaction|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions/${getEncodedUri(discussion_number)}/reactions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Reaction response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete team discussion reaction
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + discussion_number - The number that identifies the discussion.
    # + reaction_id - The unique identifier of the reaction.
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string team_slug]/discussions/[int discussion_number]/reactions/[int reaction_id]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/discussions/${getEncodedUri(discussion_number)}/reactions/${getEncodedUri(reaction_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List pending team invitations
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string team_slug]/invitations(int per_page = 30, int page = 1) returns OrganizationInvitation[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/invitations`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrganizationInvitation[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List team members
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + role - Filters members returned by their role in the team.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string team_slug]/members("member"|"maintainer"|"all" role = "all", int per_page = 30, int page = 1) returns SimpleUser[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/members`;
        map<anydata> queryParam = {"role": role, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleUser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get team membership for a user
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string team_slug]/memberships/[string username]() returns TeamMembership|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/memberships/${getEncodedUri(username)}`;
        TeamMembership response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add or update team membership for a user
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function put orgs/[string org]/teams/[string team_slug]/memberships/[string username](Memberships_username_body_1 payload) returns TeamMembership|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/memberships/${getEncodedUri(username)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TeamMembership response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove team membership for a user
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string team_slug]/memberships/[string username]() returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/memberships/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List team projects
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string team_slug]/projects(int per_page = 30, int page = 1) returns TeamProject[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/projects`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        TeamProject[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Check team permissions for a project
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + project_id - The unique identifier of the project.
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string team_slug]/projects/[int project_id]() returns TeamProject|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/projects/${getEncodedUri(project_id)}`;
        TeamProject response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add or update team project permissions
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + project_id - The unique identifier of the project.
    # + return - Response 
    resource isolated function put orgs/[string org]/teams/[string team_slug]/projects/[int project_id](Projects_project_id_body payload) returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/projects/${getEncodedUri(project_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove a project from a team
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + project_id - The unique identifier of the project.
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string team_slug]/projects/[int project_id]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/projects/${getEncodedUri(project_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List team repositories
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get orgs/[string org]/teams/[string team_slug]/repos(int per_page = 30, int page = 1) returns MinimalRepository[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/repos`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepository[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Check team permissions for a repository
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Alternative response with repository permissions 
    resource isolated function get orgs/[string org]/teams/[string team_slug]/repos/[string owner]/[string repo]() returns TeamRepository|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        TeamRepository response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add or update team repository permissions
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function put orgs/[string org]/teams/[string team_slug]/repos/[string owner]/[string repo](Owner_repo_body payload) returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request);
    }
    # Remove a repository from a team
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function delete orgs/[string org]/teams/[string team_slug]/repos/[string owner]/[string repo]() returns error? {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List child teams
    #
    # + org - The organization name. The name is not case sensitive.
    # + team_slug - The slug of the team name.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - if child teams exist 
    resource isolated function get orgs/[string org]/teams/[string team_slug]/teams(int per_page = 30, int page = 1) returns Team[]|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/teams/${getEncodedUri(team_slug)}/teams`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Team[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Enable or disable a security feature for an organization
    #
    # + org - The organization name. The name is not case sensitive.
    # + security_product - The security feature to enable or disable.
    # + enablement - The action to take.
    # `enable_all` means to enable the specified security feature for all repositories in the organization.
    # `disable_all` means to disable the specified security feature for all repositories in the organization.
    # + return - Action started 
    resource isolated function post orgs/[string org]/["dependency_graph"|"dependabot_alerts"|"dependabot_security_updates"|"advanced_security"|"code_scanning_default_setup"|"secret_scanning"|"secret_scanning_push_protection" security_product]/["enable_all"|"disable_all" enablement](Security_product_enablement_body payload) returns http:Response|error {
        string resourcePath = string `/orgs/${getEncodedUri(org)}/${getEncodedUri(security_product)}/${getEncodedUri(enablement)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a project card
    #
    # + card_id - The unique identifier of the card.
    # + return - Response 
    resource isolated function get projects/columns/cards/[int card_id]() returns ProjectCard|error {
        string resourcePath = string `/projects/columns/cards/${getEncodedUri(card_id)}`;
        ProjectCard response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a project card
    #
    # + card_id - The unique identifier of the card.
    # + return - Response 
    resource isolated function delete projects/columns/cards/[int card_id]() returns http:Response|error {
        string resourcePath = string `/projects/columns/cards/${getEncodedUri(card_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update an existing project card
    #
    # + card_id - The unique identifier of the card.
    # + return - Response 
    resource isolated function patch projects/columns/cards/[int card_id](Cards_card_id_body payload) returns ProjectCard|error {
        string resourcePath = string `/projects/columns/cards/${getEncodedUri(card_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        ProjectCard response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Move a project card
    #
    # + card_id - The unique identifier of the card.
    # + return - Response 
    resource isolated function post projects/columns/cards/[int card_id]/moves(Card_id_moves_body payload) returns json|error {
        string resourcePath = string `/projects/columns/cards/${getEncodedUri(card_id)}/moves`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        json response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a project column
    #
    # + column_id - The unique identifier of the column.
    # + return - Response 
    resource isolated function get projects/columns/[int column_id]() returns ProjectColumn|error {
        string resourcePath = string `/projects/columns/${getEncodedUri(column_id)}`;
        ProjectColumn response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a project column
    #
    # + column_id - The unique identifier of the column.
    # + return - Response 
    resource isolated function delete projects/columns/[int column_id]() returns http:Response|error {
        string resourcePath = string `/projects/columns/${getEncodedUri(column_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update an existing project column
    #
    # + column_id - The unique identifier of the column.
    # + return - Response 
    resource isolated function patch projects/columns/[int column_id](Columns_column_id_body payload) returns ProjectColumn|error {
        string resourcePath = string `/projects/columns/${getEncodedUri(column_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        ProjectColumn response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List project cards
    #
    # + column_id - The unique identifier of the column.
    # + archived_state - Filters the project cards that are returned by the card's state.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get projects/columns/[int column_id]/cards("all"|"archived"|"not_archived" archived_state = "not_archived", int per_page = 30, int page = 1) returns ProjectCard[]|error {
        string resourcePath = string `/projects/columns/${getEncodedUri(column_id)}/cards`;
        map<anydata> queryParam = {"archived_state": archived_state, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ProjectCard[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a project card
    #
    # + column_id - The unique identifier of the column.
    # + return - Response 
    resource isolated function post projects/columns/[int column_id]/cards(Column_id_cards_body payload) returns ProjectCard|error {
        string resourcePath = string `/projects/columns/${getEncodedUri(column_id)}/cards`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        ProjectCard response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Move a project column
    #
    # + column_id - The unique identifier of the column.
    # + return - Response 
    resource isolated function post projects/columns/[int column_id]/moves(Column_id_moves_body payload) returns json|error {
        string resourcePath = string `/projects/columns/${getEncodedUri(column_id)}/moves`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        json response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a project
    #
    # + project_id - The unique identifier of the project.
    # + return - Response 
    resource isolated function get projects/[int project_id]() returns Project|error {
        string resourcePath = string `/projects/${getEncodedUri(project_id)}`;
        Project response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a project
    #
    # + project_id - The unique identifier of the project.
    # + return - Delete Success 
    resource isolated function delete projects/[int project_id]() returns http:Response|error {
        string resourcePath = string `/projects/${getEncodedUri(project_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update a project
    #
    # + project_id - The unique identifier of the project.
    # + return - Response 
    resource isolated function patch projects/[int project_id](Projects_project_id_body_1 payload) returns Project|error {
        string resourcePath = string `/projects/${getEncodedUri(project_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Project response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List project collaborators
    #
    # + project_id - The unique identifier of the project.
    # + affiliation - Filters the collaborators by their affiliation. `outside` means outside collaborators of a project that are not a member of the project's organization. `direct` means collaborators with permissions to a project, regardless of organization membership status. `all` means all collaborators the authenticated user can see.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get projects/[int project_id]/collaborators("outside"|"direct"|"all" affiliation = "all", int per_page = 30, int page = 1) returns SimpleUser[]|error {
        string resourcePath = string `/projects/${getEncodedUri(project_id)}/collaborators`;
        map<anydata> queryParam = {"affiliation": affiliation, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleUser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add project collaborator
    #
    # + project_id - The unique identifier of the project.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function put projects/[int project_id]/collaborators/[string username](Collaborators_username_body payload) returns http:Response|error {
        string resourcePath = string `/projects/${getEncodedUri(project_id)}/collaborators/${getEncodedUri(username)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove user as a collaborator
    #
    # + project_id - The unique identifier of the project.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function delete projects/[int project_id]/collaborators/[string username]() returns http:Response|error {
        string resourcePath = string `/projects/${getEncodedUri(project_id)}/collaborators/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Get project permission for a user
    #
    # + project_id - The unique identifier of the project.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function get projects/[int project_id]/collaborators/[string username]/permission() returns ProjectCollaboratorPermission|error {
        string resourcePath = string `/projects/${getEncodedUri(project_id)}/collaborators/${getEncodedUri(username)}/permission`;
        ProjectCollaboratorPermission response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List project columns
    #
    # + project_id - The unique identifier of the project.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get projects/[int project_id]/columns(int per_page = 30, int page = 1) returns ProjectColumn[]|error {
        string resourcePath = string `/projects/${getEncodedUri(project_id)}/columns`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ProjectColumn[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a project column
    #
    # + project_id - The unique identifier of the project.
    # + return - Response 
    resource isolated function post projects/[int project_id]/columns(Project_id_columns_body payload) returns ProjectColumn|error {
        string resourcePath = string `/projects/${getEncodedUri(project_id)}/columns`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        ProjectColumn response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get rate limit status for the authenticated user
    #
    # + return - Response 
    resource isolated function get rate_limit() returns RateLimitOverview|error {
        string resourcePath = string `/rate_limit`;
        RateLimitOverview response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]() returns FullRepository|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        FullRepository response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo](Owner_repo_body_1 payload) returns FullRepository|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        FullRepository response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List artifacts for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + name - The name field of an artifact. When specified, only artifacts with this name will be returned.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/artifacts(int per_page = 30, int page = 1, string? name = ()) returns ArtifactResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/artifacts`;
        map<anydata> queryParam = {"per_page": per_page, "page": page, "name": name};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ArtifactResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an artifact
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + artifact_id - The unique identifier of the artifact.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/artifacts/[int artifact_id]() returns Artifact|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/artifacts/${getEncodedUri(artifact_id)}`;
        Artifact response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete an artifact
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + artifact_id - The unique identifier of the artifact.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/artifacts/[int artifact_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/artifacts/${getEncodedUri(artifact_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Download an artifact
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + artifact_id - The unique identifier of the artifact.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/artifacts/[int artifact_id]/[string archive_format]() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/artifacts/${getEncodedUri(artifact_id)}/${getEncodedUri(archive_format)}`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get GitHub Actions cache usage for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/cache/usage() returns ActionsCacheUsageByRepository|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/cache/usage`;
        ActionsCacheUsageByRepository response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List GitHub Actions caches for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + ref - The full Git reference for narrowing down the cache. The `ref` for a branch should be formatted as `refs/heads/<branch name>`. To reference a pull request use `refs/pull/<number>/merge`.
    # + 'key - An explicit key or prefix for identifying the cache
    # + sort - The property to sort the results by. `created_at` means when the cache was created. `last_accessed_at` means when the cache was last accessed. `size_in_bytes` is the size of the cache in bytes.
    # + direction - The direction to sort the results by.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/caches(int per_page = 30, int page = 1, string? ref = (), string? 'key = (), "created_at"|"last_accessed_at"|"size_in_bytes" sort = "last_accessed_at", "asc"|"desc" direction = "desc") returns ActionsCacheList|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/caches`;
        map<anydata> queryParam = {"per_page": per_page, "page": page, "ref": ref, "key": 'key, "sort": sort, "direction": direction};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ActionsCacheList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete GitHub Actions caches for a repository (using a cache key)
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + 'key - A key for identifying the cache.
    # + ref - The full Git reference for narrowing down the cache. The `ref` for a branch should be formatted as `refs/heads/<branch name>`. To reference a pull request use `refs/pull/<number>/merge`.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/caches(string 'key, string? ref = ()) returns ActionsCacheList|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/caches`;
        map<anydata> queryParam = {"key": 'key, "ref": ref};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ActionsCacheList response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Delete a GitHub Actions cache for a repository (using a cache ID)
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + cache_id - The unique identifier of the GitHub Actions cache.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/caches/[int cache_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/caches/${getEncodedUri(cache_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Get a job for a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + job_id - The unique identifier of the job.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/jobs/[int job_id]() returns Job|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/jobs/${getEncodedUri(job_id)}`;
        Job response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Download job logs for a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + job_id - The unique identifier of the job.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/jobs/[int job_id]/logs() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/jobs/${getEncodedUri(job_id)}/logs`;
        return self.clientEp->get(resourcePath);
    }
    # Re-run a job from a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + job_id - The unique identifier of the job.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/jobs/[int job_id]/rerun(Job_id_rerun_body payload) returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/jobs/${getEncodedUri(job_id)}/rerun`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get the customization template for an OIDC subject claim for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Status response 
    resource isolated function get repos/[string owner]/[string repo]/actions/oidc/customization/sub() returns OidcCustomSubRepo|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/oidc/customization/sub`;
        OidcCustomSubRepo response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set the customization template for an OIDC subject claim for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Empty response 
    resource isolated function put repos/[string owner]/[string repo]/actions/oidc/customization/sub(ActionsOidcSubjectCustomizationForARepository payload) returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/oidc/customization/sub`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # List repository organization secrets
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/organization\-secrets(int per_page = 30, int page = 1) returns ActionsSecretResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/organization-secrets`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ActionsSecretResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List repository organization variables
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 30).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/organization\-variables(int per_page = 10, int page = 1) returns ActionsVariableResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/organization-variables`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ActionsVariableResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get GitHub Actions permissions for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/permissions() returns ActionsRepositoryPermissions|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions`;
        ActionsRepositoryPermissions response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set GitHub Actions permissions for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/actions/permissions(Actions_permissions_body_1 payload) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request);
    }
    # Get the level of access for workflows outside of the repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/permissions/access() returns ActionsWorkflowAccessToRepository|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions/access`;
        ActionsWorkflowAccessToRepository response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set the level of access for workflows outside of the repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/actions/permissions/access(ActionsWorkflowAccessToRepository payload) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions/access`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request);
    }
    # Get allowed actions and reusable workflows for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/permissions/selected\-actions() returns SelectedActions|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions/selected-actions`;
        SelectedActions response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set allowed actions and reusable workflows for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/actions/permissions/selected\-actions(SelectedActions payload) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions/selected-actions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request);
    }
    # Get default workflow permissions for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/permissions/workflow() returns ActionsGetDefaultWorkflowPermissions|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions/workflow`;
        ActionsGetDefaultWorkflowPermissions response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set default workflow permissions for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Success response 
    resource isolated function put repos/[string owner]/[string repo]/actions/permissions/workflow(ActionsSetDefaultWorkflowPermissions payload) returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/permissions/workflow`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # List self-hosted runners for a repository
    #
    # + name - The name of a self-hosted runner.
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runners(string? name = (), int per_page = 30, int page = 1) returns RunnerResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners`;
        map<anydata> queryParam = {"name": name, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RunnerResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List runner applications for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runners/downloads() returns RunnerApplication[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/downloads`;
        RunnerApplication[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create configuration for a just-in-time runner for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runners/generate\-jitconfig(Runners_generatejitconfig_body_1 payload) returns JitConfig|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/generate-jitconfig`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        JitConfig response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Create a registration token for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runners/registration\-token() returns AuthenticationToken|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/registration-token`;
        http:Request request = new;
        AuthenticationToken response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Create a remove token for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runners/remove\-token() returns AuthenticationToken|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/remove-token`;
        http:Request request = new;
        AuthenticationToken response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a self-hosted runner for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + runner_id - Unique identifier of the self-hosted runner.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runners/[int runner_id]() returns Runner|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/${getEncodedUri(runner_id)}`;
        Runner response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a self-hosted runner from a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + runner_id - Unique identifier of the self-hosted runner.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/runners/[int runner_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/${getEncodedUri(runner_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List labels for a self-hosted runner for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + runner_id - Unique identifier of the self-hosted runner.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runners/[int runner_id]/labels() returns RunnerLabelResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/${getEncodedUri(runner_id)}/labels`;
        RunnerLabelResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set custom labels for a self-hosted runner for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + runner_id - Unique identifier of the self-hosted runner.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/actions/runners/[int runner_id]/labels(Runner_id_labels_body_2 payload) returns RunnerLabelResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/${getEncodedUri(runner_id)}/labels`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RunnerLabelResponse response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Add custom labels to a self-hosted runner for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + runner_id - Unique identifier of the self-hosted runner.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runners/[int runner_id]/labels(Runner_id_labels_body_3 payload) returns RunnerLabelResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/${getEncodedUri(runner_id)}/labels`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RunnerLabelResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Remove all custom labels from a self-hosted runner for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + runner_id - Unique identifier of the self-hosted runner.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/runners/[int runner_id]/labels() returns RunnerLabelResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/${getEncodedUri(runner_id)}/labels`;
        RunnerLabelResponse response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Remove a custom label from a self-hosted runner for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + runner_id - Unique identifier of the self-hosted runner.
    # + name - The name of a self-hosted runner's custom label.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/runners/[int runner_id]/labels/[string name]() returns RunnerLabelResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runners/${getEncodedUri(runner_id)}/labels/${getEncodedUri(name)}`;
        RunnerLabelResponse response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List workflow runs for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + actor - Returns someone's workflow runs. Use the login for the user who created the `push` associated with the check suite or workflow run.
    # + branch - Returns workflow runs associated with a branch. Use the name of the branch of the `push`.
    # + event - Returns workflow run triggered by the event you specify. For example, `push`, `pull_request` or `issue`. For more information, see "[Events that trigger workflows](https://docs.github.com/actions/automating-your-workflow-with-github-actions/events-that-trigger-workflows)."
    # + status - Returns workflow runs with the check run `status` or `conclusion` that you specify. For example, a conclusion can be `success` or a status can be `in_progress`. Only GitHub can set a status of `waiting` or `requested`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + created - Returns workflow runs created within the given date-time range. For more information on the syntax, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    # + exclude_pull_requests - If `true` pull requests are omitted from the response (empty array).
    # + check_suite_id - Returns workflow runs with the `check_suite_id` that you specify.
    # + head_sha - Only returns workflow runs that are associated with the specified `head_sha`.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs(string? actor = (), string? branch = (), string? event = (), "completed"|"action_required"|"cancelled"|"failure"|"neutral"|"skipped"|"stale"|"success"|"timed_out"|"in_progress"|"queued"|"requested"|"waiting"|"pending"? status = (), int per_page = 30, int page = 1, string? created = (), boolean exclude_pull_requests = false, int? check_suite_id = (), string? head_sha = ()) returns WorkflowRunResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs`;
        map<anydata> queryParam = {"actor": actor, "branch": branch, "event": event, "status": status, "per_page": per_page, "page": page, "created": created, "exclude_pull_requests": exclude_pull_requests, "check_suite_id": check_suite_id, "head_sha": head_sha};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        WorkflowRunResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + exclude_pull_requests - If `true` pull requests are omitted from the response (empty array).
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int run_id](boolean exclude_pull_requests = false) returns WorkflowRun|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}`;
        map<anydata> queryParam = {"exclude_pull_requests": exclude_pull_requests};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        WorkflowRun response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/runs/[int run_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Get the review history for a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int run_id]/approvals() returns EnvironmentApprovals[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/approvals`;
        EnvironmentApprovals[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Approve a workflow run for a fork pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runs/[int run_id]/approve() returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/approve`;
        http:Request request = new;
        EmptyObject response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List workflow run artifacts
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + name - The name field of an artifact. When specified, only artifacts with this name will be returned.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int run_id]/artifacts(int per_page = 30, int page = 1, string? name = ()) returns ArtifactResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/artifacts`;
        map<anydata> queryParam = {"per_page": per_page, "page": page, "name": name};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ArtifactResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a workflow run attempt
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + attempt_number - The attempt number of the workflow run.
    # + exclude_pull_requests - If `true` pull requests are omitted from the response (empty array).
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int run_id]/attempts/[int attempt_number](boolean exclude_pull_requests = false) returns WorkflowRun|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/attempts/${getEncodedUri(attempt_number)}`;
        map<anydata> queryParam = {"exclude_pull_requests": exclude_pull_requests};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        WorkflowRun response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List jobs for a workflow run attempt
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + attempt_number - The attempt number of the workflow run.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int run_id]/attempts/[int attempt_number]/jobs(int per_page = 30, int page = 1) returns JobResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/attempts/${getEncodedUri(attempt_number)}/jobs`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        JobResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Download workflow run attempt logs
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + attempt_number - The attempt number of the workflow run.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int run_id]/attempts/[int attempt_number]/logs() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/attempts/${getEncodedUri(attempt_number)}/logs`;
        return self.clientEp->get(resourcePath);
    }
    # Cancel a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runs/[int run_id]/cancel() returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/cancel`;
        http:Request request = new;
        EmptyObject response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Review custom deployment protection rules for a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runs/[int run_id]/deployment_protection_rule(Run_id_deployment_protection_rule_body payload) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/deployment_protection_rule`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request);
    }
    # Force cancel a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runs/[int run_id]/force\-cancel() returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/force-cancel`;
        http:Request request = new;
        EmptyObject response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List jobs for a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + filter - Filters jobs by their `completed_at` timestamp. `latest` returns jobs from the most recent execution of the workflow run. `all` returns all jobs for a workflow run, including from old executions of the workflow run.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int run_id]/jobs("latest"|"all" filter = "latest", int per_page = 30, int page = 1) returns JobResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/jobs`;
        map<anydata> queryParam = {"filter": filter, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        JobResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Download workflow run logs
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int run_id]/logs() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/logs`;
        return self.clientEp->get(resourcePath);
    }
    # Delete workflow run logs
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/runs/[int run_id]/logs() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/logs`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Get pending deployments for a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int run_id]/pending_deployments() returns PendingDeployment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/pending_deployments`;
        PendingDeployment[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Review pending deployments for a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runs/[int run_id]/pending_deployments(Run_id_pending_deployments_body payload) returns Deployment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/pending_deployments`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Deployment[] response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Re-run a workflow
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runs/[int run_id]/rerun(Run_id_rerun_body payload) returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/rerun`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Re-run failed jobs from a workflow run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/runs/[int run_id]/rerun\-failed\-jobs(Run_id_rerunfailedjobs_body payload) returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/rerun-failed-jobs`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get workflow run usage
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + run_id - The unique identifier of the workflow run.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/runs/[int run_id]/timing() returns WorkflowRunUsage|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/runs/${getEncodedUri(run_id)}/timing`;
        WorkflowRunUsage response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List repository secrets
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/secrets(int per_page = 30, int page = 1) returns ActionsSecretResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/secrets`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ActionsSecretResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a repository public key
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/secrets/public\-key() returns ActionsPublicKey|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/secrets/public-key`;
        ActionsPublicKey response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/secrets/[string secret_name]() returns ActionsSecret|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/secrets/${getEncodedUri(secret_name)}`;
        ActionsSecret response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create or update a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response when creating a secret 
    resource isolated function put repos/[string owner]/[string repo]/actions/secrets/[string secret_name](Secrets_secret_name_body_3 payload) returns EmptyObject|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/secrets/${getEncodedUri(secret_name)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject? response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/secrets/[string secret_name]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/secrets/${getEncodedUri(secret_name)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List repository variables
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 30).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/variables(int per_page = 10, int page = 1) returns ActionsVariableResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/variables`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ActionsVariableResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a repository variable
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/variables(Actions_variables_body_1 payload) returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/variables`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a repository variable
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + name - The name of the variable.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/variables/[string name]() returns ActionsVariable|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/variables/${getEncodedUri(name)}`;
        ActionsVariable response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a repository variable
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + name - The name of the variable.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/actions/variables/[string name]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/variables/${getEncodedUri(name)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Update a repository variable
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + name - The name of the variable.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/actions/variables/[string name](Variables_name_body_1 payload) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/variables/${getEncodedUri(name)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request);
    }
    # List repository workflows
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/workflows(int per_page = 30, int page = 1) returns WorkflowResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/workflows`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        WorkflowResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a workflow
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + workflow_id - The ID of the workflow. You can also pass the workflow file name as a string.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/workflows/[Workflow_id workflow_id]() returns Workflow|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/workflows/${getEncodedUri(workflow_id)}`;
        Workflow response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Disable a workflow
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + workflow_id - The ID of the workflow. You can also pass the workflow file name as a string.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/actions/workflows/[Workflow_id workflow_id]/disable() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/workflows/${getEncodedUri(workflow_id)}/disable`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request);
    }
    # Create a workflow dispatch event
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + workflow_id - The ID of the workflow. You can also pass the workflow file name as a string.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/actions/workflows/[Workflow_id workflow_id]/dispatches(Workflow_id_dispatches_body payload) returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/workflows/${getEncodedUri(workflow_id)}/dispatches`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request);
    }
    # Enable a workflow
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + workflow_id - The ID of the workflow. You can also pass the workflow file name as a string.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/actions/workflows/[Workflow_id workflow_id]/enable() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/workflows/${getEncodedUri(workflow_id)}/enable`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request);
    }
    # List workflow runs for a workflow
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + workflow_id - The ID of the workflow. You can also pass the workflow file name as a string.
    # + actor - Returns someone's workflow runs. Use the login for the user who created the `push` associated with the check suite or workflow run.
    # + branch - Returns workflow runs associated with a branch. Use the name of the branch of the `push`.
    # + event - Returns workflow run triggered by the event you specify. For example, `push`, `pull_request` or `issue`. For more information, see "[Events that trigger workflows](https://docs.github.com/actions/automating-your-workflow-with-github-actions/events-that-trigger-workflows)."
    # + status - Returns workflow runs with the check run `status` or `conclusion` that you specify. For example, a conclusion can be `success` or a status can be `in_progress`. Only GitHub can set a status of `waiting` or `requested`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + created - Returns workflow runs created within the given date-time range. For more information on the syntax, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    # + exclude_pull_requests - If `true` pull requests are omitted from the response (empty array).
    # + check_suite_id - Returns workflow runs with the `check_suite_id` that you specify.
    # + head_sha - Only returns workflow runs that are associated with the specified `head_sha`.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/workflows/[Workflow_id workflow_id]/runs(string? actor = (), string? branch = (), string? event = (), "completed"|"action_required"|"cancelled"|"failure"|"neutral"|"skipped"|"stale"|"success"|"timed_out"|"in_progress"|"queued"|"requested"|"waiting"|"pending"? status = (), int per_page = 30, int page = 1, string? created = (), boolean exclude_pull_requests = false, int? check_suite_id = (), string? head_sha = ()) returns WorkflowRunResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/workflows/${getEncodedUri(workflow_id)}/runs`;
        map<anydata> queryParam = {"actor": actor, "branch": branch, "event": event, "status": status, "per_page": per_page, "page": page, "created": created, "exclude_pull_requests": exclude_pull_requests, "check_suite_id": check_suite_id, "head_sha": head_sha};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        WorkflowRunResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get workflow usage
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + workflow_id - The ID of the workflow. You can also pass the workflow file name as a string.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/actions/workflows/[Workflow_id workflow_id]/timing() returns WorkflowUsage|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/actions/workflows/${getEncodedUri(workflow_id)}/timing`;
        WorkflowUsage response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List repository activities
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + direction - The direction to sort the results by.
    # + per_page - The number of results per page (max 100).
    # + before - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.
    # + after - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.
    # + ref - The Git reference for the activities you want to list.
    # The `ref` for a branch can be formatted either as `refs/heads/BRANCH_NAME` or `BRANCH_NAME`, where `BRANCH_NAME` is the name of your branch.
    # + actor - The GitHub username to use to filter by the actor who performed the activity.
    # + time_period - The time period to filter by.
    # For example, `day` will filter for activity that occurred in the past 24 hours, and `week` will filter for activity that occurred in the past 7 days (168 hours).
    # + activity_type - The activity type to filter by.
    # For example, you can choose to filter by "force_push", to see all force pushes to the repository.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/activity("asc"|"desc" direction = "desc", int per_page = 30, string? before = (), string? after = (), string? ref = (), string? actor = (), "day"|"week"|"month"|"quarter"|"year"? time_period = (), "push"|"force_push"|"branch_creation"|"branch_deletion"|"pr_merge"|"merge_queue_merge"? activity_type = ()) returns Activity[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/activity`;
        map<anydata> queryParam = {"direction": direction, "per_page": per_page, "before": before, "after": after, "ref": ref, "actor": actor, "time_period": time_period, "activity_type": activity_type};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Activity[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List assignees
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/assignees(int per_page = 30, int page = 1) returns SimpleUser[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/assignees`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleUser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Check if a user can be assigned
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - If the `assignee` can be assigned to issues in the repository, a `204` header with no content is returned. 
    resource isolated function get repos/[string owner]/[string repo]/assignees/[string assignee]() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/assignees/${getEncodedUri(assignee)}`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List all autolinks of a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/autolinks(int page = 1) returns Autolink[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/autolinks`;
        map<anydata> queryParam = {"page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Autolink[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create an autolink reference for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - response 
    resource isolated function post repos/[string owner]/[string repo]/autolinks(Repo_autolinks_body payload) returns Autolink|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/autolinks`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Autolink response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get an autolink reference of a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + autolink_id - The unique identifier of the autolink.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/autolinks/[int autolink_id]() returns Autolink|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/autolinks/${getEncodedUri(autolink_id)}`;
        Autolink response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete an autolink reference from a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + autolink_id - The unique identifier of the autolink.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/autolinks/[int autolink_id]() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/autolinks/${getEncodedUri(autolink_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Check if automated security fixes are enabled for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response if dependabot is enabled 
    resource isolated function get repos/[string owner]/[string repo]/automated\-security\-fixes() returns CheckAutomatedSecurityFixes|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/automated-security-fixes`;
        CheckAutomatedSecurityFixes response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Enable automated security fixes
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/automated\-security\-fixes() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/automated-security-fixes`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request);
    }
    # Disable automated security fixes
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/automated\-security\-fixes() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/automated-security-fixes`;
        return self.clientEp->delete(resourcePath);
    }
    # List branches
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + protected - Setting to `true` returns only protected branches. When set to `false`, only unprotected branches are returned. Omitting this parameter returns all branches.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches(boolean? protected = (), int per_page = 30, int page = 1) returns ShortBranch[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches`;
        map<anydata> queryParam = {"protected": protected, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ShortBranch[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]() returns BranchWithProtection|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}`;
        BranchWithProtection response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get branch protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection() returns BranchProtection|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection`;
        BranchProtection response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update branch protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/branches/[string branch]/protection(Branch_protection_body payload) returns ProtectedBranch|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        ProtectedBranch response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete branch protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Get admin branch protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/enforce_admins() returns ProtectedBranchAdminEnforced|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/enforce_admins`;
        ProtectedBranchAdminEnforced response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set admin branch protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/branches/[string branch]/protection/enforce_admins() returns ProtectedBranchAdminEnforced|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/enforce_admins`;
        http:Request request = new;
        ProtectedBranchAdminEnforced response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete admin branch protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/enforce_admins() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/enforce_admins`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Get pull request review protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/required_pull_request_reviews() returns ProtectedBranchPullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_pull_request_reviews`;
        ProtectedBranchPullRequestReview response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete pull request review protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/required_pull_request_reviews() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_pull_request_reviews`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update pull request review protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/branches/[string branch]/protection/required_pull_request_reviews(Protection_required_pull_request_reviews_body payload) returns ProtectedBranchPullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_pull_request_reviews`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        ProtectedBranchPullRequestReview response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Get commit signature protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/required_signatures() returns ProtectedBranchAdminEnforced|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_signatures`;
        ProtectedBranchAdminEnforced response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create commit signature protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/branches/[string branch]/protection/required_signatures() returns ProtectedBranchAdminEnforced|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_signatures`;
        http:Request request = new;
        ProtectedBranchAdminEnforced response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete commit signature protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/required_signatures() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_signatures`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Get status checks protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/required_status_checks() returns StatusCheckPolicy|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_status_checks`;
        StatusCheckPolicy response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Remove status check protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/required_status_checks() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_status_checks`;
        return self.clientEp->delete(resourcePath);
    }
    # Update status check protection
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/branches/[string branch]/protection/required_status_checks(Protection_required_status_checks_body payload) returns StatusCheckPolicy|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_status_checks`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        StatusCheckPolicy response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Get all status check contexts
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/required_status_checks/contexts() returns string[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_status_checks/contexts`;
        string[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set status check contexts
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/branches/[string branch]/protection/required_status_checks/contexts(Required_status_checks_contexts_body payload) returns string[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_status_checks/contexts`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        string[] response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Add status check contexts
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/branches/[string branch]/protection/required_status_checks/contexts(Required_status_checks_contexts_body_1 payload) returns string[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_status_checks/contexts`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        string[] response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Remove status check contexts
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/required_status_checks/contexts(Required_status_checks_contexts_body_2 payload) returns string[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/required_status_checks/contexts`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        string[] response = check self.clientEp->delete(resourcePath, request);
        return response;
    }
    # Get access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions() returns BranchRestrictionPolicy|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions`;
        BranchRestrictionPolicy response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions`;
        return self.clientEp->delete(resourcePath);
    }
    # Get apps with access to the protected branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/apps() returns Integration[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/apps`;
        Integration[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set app access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/apps(Restrictions_apps_body payload) returns Integration[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/apps`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Integration[] response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Add app access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/apps(Restrictions_apps_body_1 payload) returns Integration[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/apps`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Integration[] response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Remove app access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/apps(Restrictions_apps_body_2 payload) returns Integration[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/apps`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Integration[] response = check self.clientEp->delete(resourcePath, request);
        return response;
    }
    # Get teams with access to the protected branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/teams() returns Team[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/teams`;
        Team[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set team access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/teams(Restrictions_teams_body payload) returns Team[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/teams`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Team[] response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Add team access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/teams(Restrictions_teams_body_1 payload) returns Team[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/teams`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Team[] response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Remove team access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/teams(Restrictions_teams_body_2 payload) returns Team[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/teams`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Team[] response = check self.clientEp->delete(resourcePath, request);
        return response;
    }
    # Get users with access to the protected branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/users() returns SimpleUser[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/users`;
        SimpleUser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set user access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/users(Restrictions_users_body payload) returns SimpleUser[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/users`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        SimpleUser[] response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Add user access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/users(Restrictions_users_body_1 payload) returns SimpleUser[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/users`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        SimpleUser[] response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Remove user access restrictions
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/branches/[string branch]/protection/restrictions/users(Restrictions_users_body_2 payload) returns SimpleUser[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/protection/restrictions/users`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        SimpleUser[] response = check self.clientEp->delete(resourcePath, request);
        return response;
    }
    # Rename a branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/branches/[string branch]/rename(Branch_rename_body payload) returns BranchWithProtection|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/branches/${getEncodedUri(branch)}/rename`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        BranchWithProtection response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Create a check run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/check\-runs(Repo_checkruns_body payload) returns CheckRun|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-runs`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CheckRun response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a check run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + check_run_id - The unique identifier of the check run.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/check\-runs/[int check_run_id]() returns CheckRun|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-runs/${getEncodedUri(check_run_id)}`;
        CheckRun response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a check run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + check_run_id - The unique identifier of the check run.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/check\-runs/[int check_run_id](Checkruns_check_run_id_body payload) returns CheckRun|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-runs/${getEncodedUri(check_run_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CheckRun response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List check run annotations
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + check_run_id - The unique identifier of the check run.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/check\-runs/[int check_run_id]/annotations(int per_page = 30, int page = 1) returns CheckAnnotation[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-runs/${getEncodedUri(check_run_id)}/annotations`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CheckAnnotation[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Rerequest a check run
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + check_run_id - The unique identifier of the check run.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/check\-runs/[int check_run_id]/rerequest() returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-runs/${getEncodedUri(check_run_id)}/rerequest`;
        http:Request request = new;
        EmptyObject response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Create a check suite
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response when the suite already exists 
    resource isolated function post repos/[string owner]/[string repo]/check\-suites(Repo_checksuites_body payload) returns CheckSuite|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-suites`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CheckSuite response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Update repository preferences for check suites
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/check\-suites/preferences(Checksuites_preferences_body payload) returns CheckSuitePreference|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-suites/preferences`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CheckSuitePreference response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Get a check suite
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + check_suite_id - The unique identifier of the check suite.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/check\-suites/[int check_suite_id]() returns CheckSuite|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-suites/${getEncodedUri(check_suite_id)}`;
        CheckSuite response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List check runs in a check suite
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + check_suite_id - The unique identifier of the check suite.
    # + check_name - Returns check runs with the specified `name`.
    # + status - Returns check runs with the specified `status`.
    # + filter - Filters check runs by their `completed_at` timestamp. `latest` returns the most recent check runs.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/check\-suites/[int check_suite_id]/check\-runs(string? check_name = (), "queued"|"in_progress"|"completed"? status = (), "latest"|"all" filter = "latest", int per_page = 30, int page = 1) returns CheckRunResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-suites/${getEncodedUri(check_suite_id)}/check-runs`;
        map<anydata> queryParam = {"check_name": check_name, "status": status, "filter": filter, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CheckRunResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Rerequest a check suite
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + check_suite_id - The unique identifier of the check suite.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/check\-suites/[int check_suite_id]/rerequest() returns EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/check-suites/${getEncodedUri(check_suite_id)}/rerequest`;
        http:Request request = new;
        EmptyObject response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List code scanning alerts for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + tool_name - The name of a code scanning tool. Only results by this tool will be listed. You can specify the tool by using either `tool_name` or `tool_guid`, but not both.
    # + tool_guid - The GUID of a code scanning tool. Only results by this tool will be listed. Note that some code scanning tools may not include a GUID in their analysis data. You can specify the tool by using either `tool_guid` or `tool_name`, but not both.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + ref - The Git reference for the results you want to list. The `ref` for a branch can be formatted either as `refs/heads/<branch name>` or simply `<branch name>`. To reference a pull request use `refs/pull/<number>/merge`.
    # + direction - The direction to sort the results by.
    # + sort - The property by which to sort the results.
    # + state - If specified, only code scanning alerts with this state will be returned.
    # + severity - If specified, only code scanning alerts with this severity will be returned.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/alerts(CodeScanningAnalysisToolName? tool_name = (), CodeScanningAnalysisToolGuid? tool_guid = (), int page = 1, int per_page = 30, CodeScanningRef? ref = (), "asc"|"desc" direction = "desc", "created"|"updated" sort = "created", CodeScanningAlertStateQuery? state = (), CodeScanningAlertSeverity? severity = ()) returns CodeScanningAlertItems[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/alerts`;
        map<anydata> queryParam = {"tool_name": tool_name, "tool_guid": tool_guid, "page": page, "per_page": per_page, "ref": ref, "direction": direction, "sort": sort, "state": state, "severity": severity};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodeScanningAlertItems[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a code scanning alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + alert_number - The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the `number` field in the response from the `GET /repos/{owner}/{repo}/code-scanning/alerts` operation.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/alerts/[AlertNumber alert_number]() returns CodeScanningAlert|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/alerts/${getEncodedUri(alert_number)}`;
        CodeScanningAlert response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a code scanning alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + alert_number - The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the `number` field in the response from the `GET /repos/{owner}/{repo}/code-scanning/alerts` operation.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/code\-scanning/alerts/[AlertNumber alert_number](Alerts_alert_number_body payload) returns CodeScanningAlert|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/alerts/${getEncodedUri(alert_number)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CodeScanningAlert response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List instances of a code scanning alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + alert_number - The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the `number` field in the response from the `GET /repos/{owner}/{repo}/code-scanning/alerts` operation.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + ref - The Git reference for the results you want to list. The `ref` for a branch can be formatted either as `refs/heads/<branch name>` or simply `<branch name>`. To reference a pull request use `refs/pull/<number>/merge`.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/alerts/[AlertNumber alert_number]/instances(int page = 1, int per_page = 30, CodeScanningRef? ref = ()) returns CodeScanningAlertInstance[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/alerts/${getEncodedUri(alert_number)}/instances`;
        map<anydata> queryParam = {"page": page, "per_page": per_page, "ref": ref};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodeScanningAlertInstance[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List code scanning analyses for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + tool_name - The name of a code scanning tool. Only results by this tool will be listed. You can specify the tool by using either `tool_name` or `tool_guid`, but not both.
    # + tool_guid - The GUID of a code scanning tool. Only results by this tool will be listed. Note that some code scanning tools may not include a GUID in their analysis data. You can specify the tool by using either `tool_guid` or `tool_name`, but not both.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + ref - The Git reference for the analyses you want to list. The `ref` for a branch can be formatted either as `refs/heads/<branch name>` or simply `<branch name>`. To reference a pull request use `refs/pull/<number>/merge`.
    # + sarif_id - Filter analyses belonging to the same SARIF upload.
    # + direction - The direction to sort the results by.
    # + sort - The property by which to sort the results.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/analyses(CodeScanningAnalysisToolName? tool_name = (), CodeScanningAnalysisToolGuid? tool_guid = (), int page = 1, int per_page = 30, CodeScanningRef? ref = (), CodeScanningAnalysisSarifId? sarif_id = (), "asc"|"desc" direction = "desc", "created" sort = "created") returns CodeScanningAnalysis[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/analyses`;
        map<anydata> queryParam = {"tool_name": tool_name, "tool_guid": tool_guid, "page": page, "per_page": per_page, "ref": ref, "sarif_id": sarif_id, "direction": direction, "sort": sort};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodeScanningAnalysis[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a code scanning analysis for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + analysis_id - The ID of the analysis, as returned from the `GET /repos/{owner}/{repo}/code-scanning/analyses` operation.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/analyses/[int analysis_id]() returns CodeScanningAnalysis|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/analyses/${getEncodedUri(analysis_id)}`;
        CodeScanningAnalysis response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a code scanning analysis from a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + analysis_id - The ID of the analysis, as returned from the `GET /repos/{owner}/{repo}/code-scanning/analyses` operation.
    # + confirm_delete - Allow deletion if the specified analysis is the last in a set. If you attempt to delete the final analysis in a set without setting this parameter to `true`, you'll get a 400 response with the message: `Analysis is last of its type and deletion may result in the loss of historical alert data. Please specify confirm_delete.`
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/code\-scanning/analyses/[int analysis_id](string? confirm_delete = ()) returns CodeScanningAnalysisDeletion|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/analyses/${getEncodedUri(analysis_id)}`;
        map<anydata> queryParam = {"confirm_delete": confirm_delete};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodeScanningAnalysisDeletion response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List CodeQL databases for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/codeql/databases() returns CodeScanningCodeqlDatabase[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/codeql/databases`;
        CodeScanningCodeqlDatabase[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a CodeQL database for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + language - The language of the CodeQL database.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/codeql/databases/[string language]() returns CodeScanningCodeqlDatabase|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/codeql/databases/${getEncodedUri(language)}`;
        CodeScanningCodeqlDatabase response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a code scanning default setup configuration
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/default\-setup() returns CodeScanningDefaultSetup|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/default-setup`;
        CodeScanningDefaultSetup response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a code scanning default setup configuration
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/code\-scanning/default\-setup(CodeScanningDefaultSetupUpdate payload) returns EmptyObject|CodeScanningDefaultSetupUpdateResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/default-setup`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject|CodeScanningDefaultSetupUpdateResponse response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Upload an analysis as SARIF data
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/code\-scanning/sarifs(Codescanning_sarifs_body payload) returns CodeScanningSarifsReceipt|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/sarifs`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CodeScanningSarifsReceipt response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get information about a SARIF upload
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + sarif_id - The SARIF ID obtained after uploading.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/code\-scanning/sarifs/[string sarif_id]() returns CodeScanningSarifsStatus|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/code-scanning/sarifs/${getEncodedUri(sarif_id)}`;
        CodeScanningSarifsStatus response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List CODEOWNERS errors
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ref - A branch, tag or commit name used to determine which version of the CODEOWNERS file to use. Default: the repository's default branch (e.g. `main`)
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/codeowners/errors(string? ref = ()) returns CodeownersErrors|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codeowners/errors`;
        map<anydata> queryParam = {"ref": ref};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodeownersErrors response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List codespaces in a repository for the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/codespaces(int per_page = 30, int page = 1) returns CodespaceResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodespaceResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a codespace in a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response when the codespace was successfully created 
    resource isolated function post repos/[string owner]/[string repo]/codespaces(Repo_codespaces_body payload) returns Codespace|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Codespace response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List devcontainer configurations in a repository for the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/codespaces/devcontainers(int per_page = 30, int page = 1) returns DevcontainersResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/devcontainers`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        DevcontainersResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List available machine types for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + location - The location to check for available machines. Assigned by IP if not provided.
    # + client_ip - IP for location auto-detection when proxying a request
    # + ref - The branch or commit to check for prebuild availability and devcontainer restrictions.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/codespaces/machines(string? location = (), string? client_ip = (), string? ref = ()) returns CodespaceMachineResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/machines`;
        map<anydata> queryParam = {"location": location, "client_ip": client_ip, "ref": ref};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodespaceMachineResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get default attributes for a codespace
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ref - The branch or commit to check for a default devcontainer path. If not specified, the default branch will be checked.
    # + client_ip - An alternative IP for default location auto-detection, such as when proxying a request.
    # + return - Response when a user is able to create codespaces from the repository. 
    resource isolated function get repos/[string owner]/[string repo]/codespaces/'new(string? ref = (), string? client_ip = ()) returns CodespaceDefaultResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/new`;
        map<anydata> queryParam = {"ref": ref, "client_ip": client_ip};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodespaceDefaultResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Check if permissions defined by a devcontainer have been accepted by the authenticated user
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ref - The git reference that points to the location of the devcontainer configuration to use for the permission check. The value of `ref` will typically be a branch name (`heads/BRANCH_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation.
    # + devcontainer_path - Path to the devcontainer.json configuration to use for the permission check.
    # + return - Response when the permission check is successful 
    resource isolated function get repos/[string owner]/[string repo]/codespaces/permissions_check(string ref, string devcontainer_path) returns CodespacesPermissionsCheckForDevcontainer|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/permissions_check`;
        map<anydata> queryParam = {"ref": ref, "devcontainer_path": devcontainer_path};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodespacesPermissionsCheckForDevcontainer response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List repository secrets
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/codespaces/secrets(int per_page = 30, int page = 1) returns RepoCodespacesSecretResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/secrets`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RepoCodespacesSecretResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a repository public key
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/codespaces/secrets/public\-key() returns CodespacesPublicKey|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/secrets/public-key`;
        CodespacesPublicKey response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/codespaces/secrets/[string secret_name]() returns RepoCodespacesSecret|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/secrets/${getEncodedUri(secret_name)}`;
        RepoCodespacesSecret response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create or update a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response when creating a secret 
    resource isolated function put repos/[string owner]/[string repo]/codespaces/secrets/[string secret_name](Secrets_secret_name_body_4 payload) returns EmptyObject|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/secrets/${getEncodedUri(secret_name)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject? response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/codespaces/secrets/[string secret_name]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/codespaces/secrets/${getEncodedUri(secret_name)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List repository collaborators
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + affiliation - Filter collaborators returned by their affiliation. `outside` means all outside collaborators of an organization-owned repository. `direct` means all collaborators with permissions to an organization-owned repository, regardless of organization membership status. `all` means all collaborators the authenticated user can see.
    # + permission - Filter collaborators by the permissions they have on the repository. If not specified, all collaborators will be returned.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/collaborators("outside"|"direct"|"all" affiliation = "all", "pull"|"triage"|"push"|"maintain"|"admin"? permission = (), int per_page = 30, int page = 1) returns Collaborator[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/collaborators`;
        map<anydata> queryParam = {"affiliation": affiliation, "permission": permission, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Collaborator[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Check if a user is a repository collaborator
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - Response if user is a collaborator 
    resource isolated function get repos/[string owner]/[string repo]/collaborators/[string username]() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/collaborators/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add a repository collaborator
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - Response when a new invitation is created 
    resource isolated function put repos/[string owner]/[string repo]/collaborators/[string username](Collaborators_username_body_1 payload) returns RepositoryInvitation|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/collaborators/${getEncodedUri(username)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RepositoryInvitation response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove a repository collaborator
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - No Content when collaborator was removed from the repository. 
    resource isolated function delete repos/[string owner]/[string repo]/collaborators/[string username]() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/collaborators/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Get repository permissions for a user
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + username - The handle for the GitHub user account.
    # + return - if user has admin permissions 
    resource isolated function get repos/[string owner]/[string repo]/collaborators/[string username]/permission() returns RepositoryCollaboratorPermission|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/collaborators/${getEncodedUri(username)}/permission`;
        RepositoryCollaboratorPermission response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List commit comments for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/comments(int per_page = 30, int page = 1) returns CommitComment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/comments`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CommitComment[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a commit comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/comments/[int comment_id]() returns CommitComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/comments/${getEncodedUri(comment_id)}`;
        CommitComment response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a commit comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/comments/[int comment_id]() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/comments/${getEncodedUri(comment_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update a commit comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/comments/[int comment_id](Comments_comment_id_body_1 payload) returns CommitComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/comments/${getEncodedUri(comment_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CommitComment response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List reactions for a commit comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + content - Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to a commit comment.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/comments/[int comment_id]/reactions("+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes"? content = (), int per_page = 30, int page = 1) returns Reaction[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/comments/${getEncodedUri(comment_id)}/reactions`;
        map<anydata> queryParam = {"content": content, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Reaction[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create reaction for a commit comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + return - Reaction exists 
    resource isolated function post repos/[string owner]/[string repo]/comments/[int comment_id]/reactions(Comment_id_reactions_body payload) returns Reaction|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/comments/${getEncodedUri(comment_id)}/reactions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Reaction response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete a commit comment reaction
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + reaction_id - The unique identifier of the reaction.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/comments/[int comment_id]/reactions/[int reaction_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/comments/${getEncodedUri(comment_id)}/reactions/${getEncodedUri(reaction_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List commits
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + sha - SHA or branch to start listing commits from. Default: the repository’s default branch (usually `main`).
    # + path - Only commits containing this file path will be returned.
    # + author - GitHub username or email address to use to filter by commit author.
    # + committer - GitHub username or email address to use to filter by commit committer.
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + until - Only commits before this date will be returned. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits(string? sha = (), string? path = (), string? author = (), string? committer = (), string? since = (), string? until = (), int per_page = 30, int page = 1) returns Commit[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits`;
        map<anydata> queryParam = {"sha": sha, "path": path, "author": author, "committer": committer, "since": since, "until": until, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Commit[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List branches for HEAD commit
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + commit_sha - The SHA of the commit.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string commit_sha]/branches\-where\-head() returns BranchShort[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(commit_sha)}/branches-where-head`;
        BranchShort[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List commit comments
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + commit_sha - The SHA of the commit.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string commit_sha]/comments(int per_page = 30, int page = 1) returns CommitComment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(commit_sha)}/comments`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CommitComment[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a commit comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + commit_sha - The SHA of the commit.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/commits/[string commit_sha]/comments(Commit_sha_comments_body payload) returns CommitComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(commit_sha)}/comments`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CommitComment response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List pull requests associated with a commit
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + commit_sha - The SHA of the commit.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string commit_sha]/pulls(int per_page = 30, int page = 1) returns PullRequestSimple[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(commit_sha)}/pulls`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        PullRequestSimple[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a commit
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string ref](int page = 1, int per_page = 30) returns Commit|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(ref)}`;
        map<anydata> queryParam = {"page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Commit response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List check runs for a Git reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation.
    # + check_name - Returns check runs with the specified `name`.
    # + status - Returns check runs with the specified `status`.
    # + filter - Filters check runs by their `completed_at` timestamp. `latest` returns the most recent check runs.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string ref]/check\-runs(string? check_name = (), "queued"|"in_progress"|"completed"? status = (), "latest"|"all" filter = "latest", int per_page = 30, int page = 1, int? app_id = ()) returns CheckRunResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(ref)}/check-runs`;
        map<anydata> queryParam = {"check_name": check_name, "status": status, "filter": filter, "per_page": per_page, "page": page, "app_id": app_id};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CheckRunResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List check suites for a Git reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation.
    # + app_id - Filters check suites by GitHub App `id`.
    # + check_name - Returns check runs with the specified `name`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string ref]/check\-suites(int? app_id = (), string? check_name = (), int per_page = 30, int page = 1) returns CheckSuiteResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(ref)}/check-suites`;
        map<anydata> queryParam = {"app_id": app_id, "check_name": check_name, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CheckSuiteResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get the combined status for a specific reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string ref]/status(int per_page = 30, int page = 1) returns CombinedCommitStatus|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(ref)}/status`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CombinedCommitStatus response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List commit statuses for a reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/commits/[string ref]/statuses(int per_page = 30, int page = 1) returns Status[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/commits/${getEncodedUri(ref)}/statuses`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Status[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get community profile metrics
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/community/profile() returns CommunityProfile|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/community/profile`;
        CommunityProfile response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Compare two commits
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + basehead - The base branch and head branch to compare. This parameter expects the format `BASE...HEAD`. Both must be branch names in `repo`. To compare with a branch that exists in a different repository in the same network as `repo`, the `basehead` parameter expects the format `USERNAME:BASE...USERNAME:HEAD`.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/compare/[string basehead](int page = 1, int per_page = 30) returns CommitComparison|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/compare/${getEncodedUri(basehead)}`;
        map<anydata> queryParam = {"page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CommitComparison response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get repository content
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + path - path parameter
    # + ref - The name of the commit/branch/tag. Default: the repository’s default branch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/contents/[string path](string? ref = ()) returns ContentTree[]|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/contents/${getEncodedUri(path)}`;
        map<anydata> queryParam = {"ref": ref};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ContentTree[]|ContentTree? response = check self.clientEp->get(resourcePath);
        if response is ContentTree[] {
            return response;
        } else if response is ContentTree {
            return [response];
        }
        return ();
    }
    # Create or update file contents
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + path - path parameter
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/contents/[string path](Contents_path_body payload) returns FileCommit|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/contents/${getEncodedUri(path)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        FileCommit response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete a file
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + path - path parameter
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/contents/[string path](Contents_path_body_1 payload) returns FileCommit|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/contents/${getEncodedUri(path)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        FileCommit response = check self.clientEp->delete(resourcePath, request);
        return response;
    }
    # List repository contributors
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + anon - Set to `1` or `true` to include anonymous contributors in results.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - If repository contains content 
    resource isolated function get repos/[string owner]/[string repo]/contributors(string? anon = (), int per_page = 30, int page = 1) returns Contributor[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/contributors`;
        map<anydata> queryParam = {"anon": anon, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Contributor[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List Dependabot alerts for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + state - A comma-separated list of states. If specified, only alerts with these states will be returned.
    # Can be: `auto_dismissed`, `dismissed`, `fixed`, `open`
    # + severity - A comma-separated list of severities. If specified, only alerts with these severities will be returned.
    # Can be: `low`, `medium`, `high`, `critical`
    # + ecosystem - A comma-separated list of ecosystems. If specified, only alerts for these ecosystems will be returned.
    # Can be: `composer`, `go`, `maven`, `npm`, `nuget`, `pip`, `pub`, `rubygems`, `rust`
    # + package - A comma-separated list of package names. If specified, only alerts for these packages will be returned.
    # + manifest - A comma-separated list of full manifest paths. If specified, only alerts for these manifests will be returned.
    # + scope - The scope of the vulnerable dependency. If specified, only alerts with this scope will be returned.
    # + sort - The property by which to sort the results.
    # `created` means when the alert was created.
    # `updated` means when the alert's state last changed.
    # + direction - The direction to sort the results by.
    # + page - **Deprecated**. Page number of the results to fetch. Use cursor-based pagination with `before` or `after` instead.
    # + per_page - The number of results per page (max 100).
    # + before - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.
    # + after - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.
    # + first - **Deprecated**. The number of results per page (max 100), starting from the first matching result.
    # This parameter must not be used in combination with `last`.
    # Instead, use `per_page` in combination with `after` to fetch the first page of results.
    # + last - **Deprecated**. The number of results per page (max 100), starting from the last matching result.
    # This parameter must not be used in combination with `first`.
    # Instead, use `per_page` in combination with `before` to fetch the last page of results.
    # # Deprecated parameters
    # + page -
    # + per_page -
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/dependabot/alerts(string? state = (), string? severity = (), string? ecosystem = (), string? package = (), string? manifest = (), "development"|"runtime"? scope = (), "created"|"updated" sort = "created", "asc"|"desc" direction = "desc", @deprecated int page = 1, @deprecated int per_page = 30, string? before = (), string? after = (), int first = 30, int? last = ()) returns DependabotAlert[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/alerts`;
        map<anydata> queryParam = {"state": state, "severity": severity, "ecosystem": ecosystem, "package": package, "manifest": manifest, "scope": scope, "sort": sort, "direction": direction, "page": page, "per_page": per_page, "before": before, "after": after, "first": first, "last": last};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        DependabotAlert[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a Dependabot alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + alert_number - The number that identifies a Dependabot alert in its repository.
    # You can find this at the end of the URL for a Dependabot alert within GitHub,
    # or in `number` fields in the response from the
    # `GET /repos/{owner}/{repo}/dependabot/alerts` operation.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/dependabot/alerts/[AlertNumber alert_number]() returns DependabotAlert|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/alerts/${getEncodedUri(alert_number)}`;
        DependabotAlert response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a Dependabot alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + alert_number - The number that identifies a Dependabot alert in its repository.
    # You can find this at the end of the URL for a Dependabot alert within GitHub,
    # or in `number` fields in the response from the
    # `GET /repos/{owner}/{repo}/dependabot/alerts` operation.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/dependabot/alerts/[AlertNumber alert_number](Alerts_alert_number_body_1 payload) returns DependabotAlert|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/alerts/${getEncodedUri(alert_number)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        DependabotAlert response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List repository secrets
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/dependabot/secrets(int per_page = 30, int page = 1) returns DependabotSecretResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/secrets`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        DependabotSecretResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a repository public key
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/dependabot/secrets/public\-key() returns DependabotPublicKey|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/secrets/public-key`;
        DependabotPublicKey response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/dependabot/secrets/[string secret_name]() returns DependabotSecret|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/secrets/${getEncodedUri(secret_name)}`;
        DependabotSecret response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create or update a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response when creating a secret 
    resource isolated function put repos/[string owner]/[string repo]/dependabot/secrets/[string secret_name](Secrets_secret_name_body_5 payload) returns EmptyObject|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/secrets/${getEncodedUri(secret_name)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject? response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete a repository secret
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/dependabot/secrets/[string secret_name]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependabot/secrets/${getEncodedUri(secret_name)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Get a diff of the dependencies between commits
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + basehead - The base and head Git revisions to compare. The Git revisions will be resolved to commit SHAs. Named revisions will be resolved to their corresponding HEAD commits, and an appropriate merge base will be determined. This parameter expects the format `{base}...{head}`.
    # + name - The full path, relative to the repository root, of the dependency manifest file.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/dependency\-graph/compare/[string basehead](string? name = ()) returns DependencyGraphDiff|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependency-graph/compare/${getEncodedUri(basehead)}`;
        map<anydata> queryParam = {"name": name};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        DependencyGraphDiff response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Export a software bill of materials (SBOM) for a repository.
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/dependency\-graph/sbom() returns DependencyGraphSpdxSbom|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependency-graph/sbom`;
        DependencyGraphSpdxSbom response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a snapshot of dependencies for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/dependency\-graph/snapshots(Snapshot payload) returns SnapshotResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dependency-graph/snapshots`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        SnapshotResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List deployments
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + sha - The SHA recorded at creation time.
    # + ref - The name of the ref. This can be a branch, tag, or SHA.
    # + task - The name of the task for the deployment (e.g., `deploy` or `deploy:migrations`).
    # + environment - The name of the environment that was deployed to (e.g., `staging` or `production`).
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/deployments(string sha = "none", string ref = "none", string task = "none", string environment = "none", int per_page = 30, int page = 1) returns Deployment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/deployments`;
        map<anydata> queryParam = {"sha": sha, "ref": ref, "task": task, "environment": environment, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Deployment[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a deployment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/deployments(Repo_deployments_body payload) returns MergedBranchResponse|Deployment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/deployments`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        MergedBranchResponse|Deployment response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a deployment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + deployment_id - deployment_id parameter
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/deployments/[int deployment_id]() returns Deployment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/deployments/${getEncodedUri(deployment_id)}`;
        Deployment response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a deployment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + deployment_id - deployment_id parameter
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/deployments/[int deployment_id]() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/deployments/${getEncodedUri(deployment_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List deployment statuses
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + deployment_id - deployment_id parameter
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/deployments/[int deployment_id]/statuses(int per_page = 30, int page = 1) returns DeploymentStatus[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/deployments/${getEncodedUri(deployment_id)}/statuses`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        DeploymentStatus[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a deployment status
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + deployment_id - deployment_id parameter
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/deployments/[int deployment_id]/statuses(Deployment_id_statuses_body payload) returns DeploymentStatus|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/deployments/${getEncodedUri(deployment_id)}/statuses`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        DeploymentStatus response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a deployment status
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + deployment_id - deployment_id parameter
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/deployments/[int deployment_id]/statuses/[int status_id]() returns DeploymentStatus|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/deployments/${getEncodedUri(deployment_id)}/statuses/${getEncodedUri(status_id)}`;
        DeploymentStatus response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a repository dispatch event
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/dispatches(Repo_dispatches_body payload) returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/dispatches`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List environments
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/environments(int per_page = 30, int page = 1) returns EnvironmentResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        EnvironmentResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an environment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + environment_name - The name of the environment.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/environments/[string environment_name]() returns Environment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environment_name)}`;
        Environment response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create or update an environment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + environment_name - The name of the environment.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/environments/[string environment_name](Environments_environment_name_body payload) returns Environment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environment_name)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Environment response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete an environment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + environment_name - The name of the environment.
    # + return - Default response 
    resource isolated function delete repos/[string owner]/[string repo]/environments/[string environment_name]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environment_name)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List deployment branch policies
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + environment_name - The name of the environment.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/environments/[string environment_name]/deployment\-branch\-policies(int per_page = 30, int page = 1) returns DeploymentBranchPolicyResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environment_name)}/deployment-branch-policies`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        DeploymentBranchPolicyResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a deployment branch policy
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + environment_name - The name of the environment.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/environments/[string environment_name]/deployment\-branch\-policies(DeploymentBranchPolicyNamePatternWithType payload) returns DeploymentBranchPolicy|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environment_name)}/deployment-branch-policies`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        DeploymentBranchPolicy? response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a deployment branch policy
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + environment_name - The name of the environment.
    # + branch_policy_id - The unique identifier of the branch policy.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/environments/[string environment_name]/deployment\-branch\-policies/[int branch_policy_id]() returns DeploymentBranchPolicy|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environment_name)}/deployment-branch-policies/${getEncodedUri(branch_policy_id)}`;
        DeploymentBranchPolicy response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a deployment branch policy
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + environment_name - The name of the environment.
    # + branch_policy_id - The unique identifier of the branch policy.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/environments/[string environment_name]/deployment\-branch\-policies/[int branch_policy_id](DeploymentBranchPolicyNamePattern payload) returns DeploymentBranchPolicy|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environment_name)}/deployment-branch-policies/${getEncodedUri(branch_policy_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        DeploymentBranchPolicy response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete a deployment branch policy
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + environment_name - The name of the environment.
    # + branch_policy_id - The unique identifier of the branch policy.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/environments/[string environment_name]/deployment\-branch\-policies/[int branch_policy_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environment_name)}/deployment-branch-policies/${getEncodedUri(branch_policy_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Get all deployment protection rules for an environment
    #
    # + environment_name - The name of the environment.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + return - List of deployment protection rules 
    resource isolated function get repos/[string owner]/[string repo]/environments/[string environment_name]/deployment_protection_rules() returns DeploymentProtectionRuleResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environment_name)}/deployment_protection_rules`;
        DeploymentProtectionRuleResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a custom deployment protection rule on an environment
    #
    # + environment_name - The name of the environment.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + return - The enabled custom deployment protection rule 
    resource isolated function post repos/[string owner]/[string repo]/environments/[string environment_name]/deployment_protection_rules(Environment_name_deployment_protection_rules_body payload) returns DeploymentProtectionRule|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environment_name)}/deployment_protection_rules`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        DeploymentProtectionRule response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List custom deployment rule integrations available for an environment
    #
    # + environment_name - The name of the environment.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + return - A list of custom deployment rule integrations available for this environment. 
    resource isolated function get repos/[string owner]/[string repo]/environments/[string environment_name]/deployment_protection_rules/apps(int page = 1, int per_page = 30) returns CustomDeploymentRuleAppResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environment_name)}/deployment_protection_rules/apps`;
        map<anydata> queryParam = {"page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CustomDeploymentRuleAppResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a custom deployment protection rule
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + environment_name - The name of the environment.
    # + protection_rule_id - The unique identifier of the protection rule.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/environments/[string environment_name]/deployment_protection_rules/[int protection_rule_id]() returns DeploymentProtectionRule|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environment_name)}/deployment_protection_rules/${getEncodedUri(protection_rule_id)}`;
        DeploymentProtectionRule response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Disable a custom protection rule for an environment
    #
    # + environment_name - The name of the environment.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + protection_rule_id - The unique identifier of the protection rule.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/environments/[string environment_name]/deployment_protection_rules/[int protection_rule_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/environments/${getEncodedUri(environment_name)}/deployment_protection_rules/${getEncodedUri(protection_rule_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List repository events
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/events(int per_page = 30, int page = 1) returns Event[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/events`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Event[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List forks
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + sort - The sort order. `stargazers` will sort by star count.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/forks("newest"|"oldest"|"stargazers"|"watchers" sort = "newest", int per_page = 30, int page = 1) returns MinimalRepository[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/forks`;
        map<anydata> queryParam = {"sort": sort, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepository[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a fork
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/forks(Repo_forks_body payload) returns FullRepository|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/forks`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        FullRepository response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Create a blob
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/git/blobs(Git_blobs_body payload) returns ShortBlob|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/blobs`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        ShortBlob response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a blob
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/git/blobs/[string file_sha]() returns Blob|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/blobs/${getEncodedUri(file_sha)}`;
        Blob response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a commit
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/git/commits(Git_commits_body payload) returns GitCommit|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/commits`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        GitCommit response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a commit object
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + commit_sha - The SHA of the commit.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/git/commits/[string commit_sha]() returns GitCommit|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/commits/${getEncodedUri(commit_sha)}`;
        GitCommit response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List matching references
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/git/matching\-refs/[string ref]() returns GitRef[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/matching-refs/${getEncodedUri(ref)}`;
        GitRef[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/git/ref/[string ref]() returns GitRef|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/ref/${getEncodedUri(ref)}`;
        GitRef response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/git/refs(Git_refs_body payload) returns GitRef|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/refs`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        GitRef response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete a reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ref - The commit reference. Can be a commit SHA, branch name (`heads/BRANCH_NAME`), or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/git/refs/[string ref]() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/refs/${getEncodedUri(ref)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update a reference
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ref - The name of the reference to update (for example, `heads/featureA`). Can be a branch name (`heads/BRANCH_NAME`) or tag name (`tags/TAG_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/git/refs/[string ref](Refs_ref_body payload) returns GitRef|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/refs/${getEncodedUri(ref)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        GitRef response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Create a tag object
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/git/tags(Git_tags_body payload) returns GitTag|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/tags`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        GitTag response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a tag
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/git/tags/[string tag_sha]() returns GitTag|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/tags/${getEncodedUri(tag_sha)}`;
        GitTag response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a tree
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/git/trees(Git_trees_body payload) returns GitTree|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/trees`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        GitTree response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a tree
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + tree_sha - The SHA1 value or ref (branch or tag) name of the tree.
    # + recursive - Setting this parameter to any value returns the objects or subtrees referenced by the tree specified in `:tree_sha`. For example, setting `recursive` to any of the following will enable returning objects or subtrees: `0`, `1`, `"true"`, and `"false"`. Omit this parameter to prevent recursively returning objects or subtrees.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/git/trees/[string tree_sha](string? recursive = ()) returns GitTree|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/git/trees/${getEncodedUri(tree_sha)}`;
        map<anydata> queryParam = {"recursive": recursive};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        GitTree response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List repository webhooks
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/hooks(int per_page = 30, int page = 1) returns Hook[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Hook[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/hooks(Repo_hooks_body payload) returns Hook|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Hook response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/hooks/[int hook_id]() returns Hook|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hook_id)}`;
        Hook response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/hooks/[int hook_id]() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hook_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/hooks/[int hook_id](Hooks_hook_id_body_1 payload) returns Hook|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hook_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Hook response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Get a webhook configuration for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/hooks/[int hook_id]/config() returns WebhookConfig|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hook_id)}/config`;
        WebhookConfig response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a webhook configuration for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/hooks/[int hook_id]/config(Hook_id_config_body_1 payload) returns WebhookConfig|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hook_id)}/config`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        WebhookConfig response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List deliveries for a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + per_page - The number of results per page (max 100).
    # + cursor - Used for pagination: the starting delivery from which the page of deliveries is fetched. Refer to the `link` header for the next and previous page cursors.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/hooks/[int hook_id]/deliveries(int per_page = 30, string? cursor = (), boolean? redelivery = ()) returns HookDeliveryItem[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hook_id)}/deliveries`;
        map<anydata> queryParam = {"per_page": per_page, "cursor": cursor, "redelivery": redelivery};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        HookDeliveryItem[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a delivery for a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/hooks/[int hook_id]/deliveries/[int delivery_id]() returns HookDelivery|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hook_id)}/deliveries/${getEncodedUri(delivery_id)}`;
        HookDelivery response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Redeliver a delivery for a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Accepted 
    resource isolated function post repos/[string owner]/[string repo]/hooks/[int hook_id]/deliveries/[int delivery_id]/attempts() returns json|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hook_id)}/deliveries/${getEncodedUri(delivery_id)}/attempts`;
        http:Request request = new;
        json response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Ping a repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/hooks/[int hook_id]/pings() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hook_id)}/pings`;
        http:Request request = new;
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Test the push repository webhook
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + hook_id - The unique identifier of the hook. You can find this value in the `X-GitHub-Hook-ID` header of a webhook delivery.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/hooks/[int hook_id]/tests() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/hooks/${getEncodedUri(hook_id)}/tests`;
        http:Request request = new;
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get an import status
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/'import() returns Import|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import`;
        Import response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Start an import
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/'import(Repo_import_body payload) returns Import|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Import response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Cancel an import
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/'import() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update an import
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/'import(Repo_import_body_1 payload) returns Import|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Import response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Get commit authors
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + since - A user ID. Only return users with an ID greater than this ID.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/'import/authors(int? since = ()) returns PorterAuthor[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import/authors`;
        map<anydata> queryParam = {"since": since};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        PorterAuthor[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Map a commit author
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/'import/authors/[int author_id](Authors_author_id_body payload) returns PorterAuthor|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import/authors/${getEncodedUri(author_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        PorterAuthor response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Get large files
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/'import/large_files() returns PorterLargeFile[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import/large_files`;
        PorterLargeFile[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update Git LFS preference
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/'import/lfs(Import_lfs_body payload) returns Import|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/import/lfs`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Import response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Get a repository installation for the authenticated app
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/installation() returns Installation|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/installation`;
        Installation response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get interaction restrictions for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/interaction\-limits() returns InteractionLimitResponseAny|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/interaction-limits`;
        InteractionLimitResponseAny response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set interaction restrictions for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/interaction\-limits(InteractionLimit payload) returns InteractionLimitResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/interaction-limits`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        InteractionLimitResponse response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove interaction restrictions for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/interaction\-limits() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/interaction-limits`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List repository invitations
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/invitations(int per_page = 30, int page = 1) returns RepositoryInvitation[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/invitations`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RepositoryInvitation[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a repository invitation
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + invitation_id - The unique identifier of the invitation.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/invitations/[int invitation_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/invitations/${getEncodedUri(invitation_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Update a repository invitation
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + invitation_id - The unique identifier of the invitation.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/invitations/[int invitation_id](Invitations_invitation_id_body payload) returns RepositoryInvitation|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/invitations/${getEncodedUri(invitation_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RepositoryInvitation response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List repository issues
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + milestone - If an `integer` is passed, it should refer to a milestone by its `number` field. If the string `*` is passed, issues with any milestone are accepted. If the string `none` is passed, issues without milestones are returned.
    # + state - Indicates the state of the issues to return.
    # + assignee - Can be the name of a user. Pass in `none` for issues with no assigned user, and `*` for issues assigned to any user.
    # + creator - The user that created the issue.
    # + mentioned - A user that's mentioned in the issue.
    # + labels - A list of comma separated label names. Example: `bug,ui,@high`
    # + sort - What to sort results by.
    # + direction - The direction to sort the results by.
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues(string? milestone = (), "open"|"closed"|"all" state = "open", string? assignee = (), string? creator = (), string? mentioned = (), string? labels = (), "created"|"updated"|"comments" sort = "created", "asc"|"desc" direction = "desc", string? since = (), int per_page = 30, int page = 1) returns Issue[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues`;
        map<anydata> queryParam = {"milestone": milestone, "state": state, "assignee": assignee, "creator": creator, "mentioned": mentioned, "labels": labels, "sort": sort, "direction": direction, "since": since, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Issue[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/issues(Repo_issues_body payload) returns Issue|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Issue response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List issue comments for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + sort - The property to sort the results by.
    # + direction - Either `asc` or `desc`. Ignored without the `sort` parameter.
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/comments("created"|"updated" sort = "created", "asc"|"desc"? direction = (), string? since = (), int per_page = 30, int page = 1) returns IssueComment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/comments`;
        map<anydata> queryParam = {"sort": sort, "direction": direction, "since": since, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        IssueComment[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an issue comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/comments/[int comment_id]() returns IssueComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/comments/${getEncodedUri(comment_id)}`;
        IssueComment response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete an issue comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/issues/comments/[int comment_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/comments/${getEncodedUri(comment_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Update an issue comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/issues/comments/[int comment_id](Comments_comment_id_body_2 payload) returns IssueComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/comments/${getEncodedUri(comment_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        IssueComment response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List reactions for an issue comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + content - Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to an issue comment.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/comments/[int comment_id]/reactions("+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes"? content = (), int per_page = 30, int page = 1) returns Reaction[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/comments/${getEncodedUri(comment_id)}/reactions`;
        map<anydata> queryParam = {"content": content, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Reaction[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create reaction for an issue comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + return - Reaction exists 
    resource isolated function post repos/[string owner]/[string repo]/issues/comments/[int comment_id]/reactions(Comment_id_reactions_body_1 payload) returns Reaction|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/comments/${getEncodedUri(comment_id)}/reactions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Reaction response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete an issue comment reaction
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + reaction_id - The unique identifier of the reaction.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/issues/comments/[int comment_id]/reactions/[int reaction_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/comments/${getEncodedUri(comment_id)}/reactions/${getEncodedUri(reaction_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List issue events for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/events(int per_page = 30, int page = 1) returns IssueEvent[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/events`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        IssueEvent[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an issue event
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/events/[int event_id]() returns IssueEvent|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/events/${getEncodedUri(event_id)}`;
        IssueEvent response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/[int issue_number]() returns Issue|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}`;
        Issue? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/issues/[int issue_number](Issues_issue_number_body payload) returns Issue|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Issue response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Add assignees to an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/issues/[int issue_number]/assignees(Issue_number_assignees_body payload) returns Issue|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/assignees`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Issue response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Remove assignees from an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/issues/[int issue_number]/assignees(Issue_number_assignees_body_1 payload) returns Issue|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/assignees`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Issue response = check self.clientEp->delete(resourcePath, request);
        return response;
    }
    # Check if a user can be assigned to a issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + return - Response if `assignee` can be assigned to `issue_number` 
    resource isolated function get repos/[string owner]/[string repo]/issues/[int issue_number]/assignees/[string assignee]() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/assignees/${getEncodedUri(assignee)}`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List issue comments
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/[int issue_number]/comments(string? since = (), int per_page = 30, int page = 1) returns IssueComment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/comments`;
        map<anydata> queryParam = {"since": since, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        IssueComment[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create an issue comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/issues/[int issue_number]/comments(Issue_number_comments_body payload) returns IssueComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/comments`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        IssueComment response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List issue events
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/[int issue_number]/events(int per_page = 30, int page = 1) returns IssueEventForIssue[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/events`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        IssueEventForIssue[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List labels for an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/[int issue_number]/labels(int per_page = 30, int page = 1) returns Label[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/labels`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Label[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set labels for an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/issues/[int issue_number]/labels(Issue_number_labels_body payload) returns Label[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/labels`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Label[] response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Add labels to an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/issues/[int issue_number]/labels(Issue_number_labels_body_1 payload) returns Label[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/labels`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Label[] response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Remove all labels from an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/issues/[int issue_number]/labels() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/labels`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Remove a label from an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/issues/[int issue_number]/labels/[string name]() returns Label[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/labels/${getEncodedUri(name)}`;
        Label[] response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Lock an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/issues/[int issue_number]/'lock(Issue_number_lock_body payload) returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/lock`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Unlock an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/issues/[int issue_number]/'lock() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/lock`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List reactions for an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + content - Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to an issue.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/[int issue_number]/reactions("+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes"? content = (), int per_page = 30, int page = 1) returns Reaction[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/reactions`;
        map<anydata> queryParam = {"content": content, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Reaction[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create reaction for an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/issues/[int issue_number]/reactions(Issue_number_reactions_body payload) returns Reaction|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/reactions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Reaction response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete an issue reaction
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + reaction_id - The unique identifier of the reaction.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/issues/[int issue_number]/reactions/[int reaction_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/reactions/${getEncodedUri(reaction_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List timeline events for an issue
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + issue_number - The number that identifies the issue.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/issues/[int issue_number]/timeline(int per_page = 30, int page = 1) returns TimelineIssueEvents[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/issues/${getEncodedUri(issue_number)}/timeline`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        TimelineIssueEvents[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List deploy keys
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/keys(int per_page = 30, int page = 1) returns DeployKey[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/keys`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        DeployKey[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a deploy key
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/keys(Repo_keys_body payload) returns DeployKey|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/keys`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        DeployKey response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a deploy key
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + key_id - The unique identifier of the key.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/keys/[int key_id]() returns DeployKey|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/keys/${getEncodedUri(key_id)}`;
        DeployKey response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a deploy key
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + key_id - The unique identifier of the key.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/keys/[int key_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/keys/${getEncodedUri(key_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List labels for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/labels(int per_page = 30, int page = 1) returns Label[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/labels`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Label[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a label
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/labels(Repo_labels_body payload) returns Label|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/labels`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Label response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a label
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/labels/[string name]() returns Label|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/labels/${getEncodedUri(name)}`;
        Label response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a label
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/labels/[string name]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/labels/${getEncodedUri(name)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Update a label
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/labels/[string name](Labels_name_body payload) returns Label|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/labels/${getEncodedUri(name)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Label response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List repository languages
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/languages() returns Language|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/languages`;
        Language response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get the license for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/license() returns LicenseContent|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/license`;
        LicenseContent response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Sync a fork branch with the upstream repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - The branch has been successfully synced with the upstream repository 
    resource isolated function post repos/[string owner]/[string repo]/merge\-upstream(Repo_mergeupstream_body payload) returns MergedUpstream|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/merge-upstream`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        MergedUpstream response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Merge a branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Successful Response (The resulting merge commit) 
    resource isolated function post repos/[string owner]/[string repo]/merges(Repo_merges_body payload) returns Commit|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/merges`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Commit response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List milestones
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + state - The state of the milestone. Either `open`, `closed`, or `all`.
    # + sort - What to sort results by. Either `due_on` or `completeness`.
    # + direction - The direction of the sort. Either `asc` or `desc`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/milestones("open"|"closed"|"all" state = "open", "due_on"|"completeness" sort = "due_on", "asc"|"desc" direction = "asc", int per_page = 30, int page = 1) returns Milestone[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/milestones`;
        map<anydata> queryParam = {"state": state, "sort": sort, "direction": direction, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Milestone[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a milestone
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/milestones(Repo_milestones_body payload) returns Milestone|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/milestones`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Milestone response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a milestone
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + milestone_number - The number that identifies the milestone.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/milestones/[int milestone_number]() returns Milestone|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/milestones/${getEncodedUri(milestone_number)}`;
        Milestone response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a milestone
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + milestone_number - The number that identifies the milestone.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/milestones/[int milestone_number]() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/milestones/${getEncodedUri(milestone_number)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update a milestone
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + milestone_number - The number that identifies the milestone.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/milestones/[int milestone_number](Milestones_milestone_number_body payload) returns Milestone|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/milestones/${getEncodedUri(milestone_number)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Milestone response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List labels for issues in a milestone
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + milestone_number - The number that identifies the milestone.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/milestones/[int milestone_number]/labels(int per_page = 30, int page = 1) returns Label[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/milestones/${getEncodedUri(milestone_number)}/labels`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Label[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List repository notifications for the authenticated user
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + all - If `true`, show notifications marked as read.
    # + participating - If `true`, only shows notifications in which the user is directly participating or mentioned.
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + before - Only show notifications updated before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/notifications(boolean all = false, boolean participating = false, string? since = (), string? before = (), int per_page = 30, int page = 1) returns NotificationThread[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/notifications`;
        map<anydata> queryParam = {"all": all, "participating": participating, "since": since, "before": before, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        NotificationThread[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Mark repository notifications as read
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/notifications(Repo_notifications_body payload) returns NotificationRead|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/notifications`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        NotificationRead? response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Get a GitHub Pages site
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pages() returns Page|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages`;
        Page response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update information about a GitHub Pages site
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/pages(Repo_pages_body payload) returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Create a GitHub Pages site
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pages(Repo_pages_body_1 payload) returns Page|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Page response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete a GitHub Pages site
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/pages() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List GitHub Pages builds
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pages/builds(int per_page = 30, int page = 1) returns PageBuild[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages/builds`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        PageBuild[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Request a GitHub Pages build
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pages/builds() returns PageBuildStatus|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages/builds`;
        http:Request request = new;
        PageBuildStatus response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get latest Pages build
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pages/builds/latest() returns PageBuild|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages/builds/latest`;
        PageBuild response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get GitHub Pages build
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pages/builds/[int build_id]() returns PageBuild|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages/builds/${getEncodedUri(build_id)}`;
        PageBuild response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a GitHub Pages deployment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pages/deployment(Pages_deployment_body payload) returns PageDeployment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages/deployment`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        PageDeployment response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a DNS health check for GitHub Pages
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pages/health() returns PagesHealthCheck|EmptyObject|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pages/health`;
        PagesHealthCheck|EmptyObject response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Enable private vulnerability reporting for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - A header with no content is returned. 
    resource isolated function put repos/[string owner]/[string repo]/private\-vulnerability\-reporting() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/private-vulnerability-reporting`;
        http:Request request = new;
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Disable private vulnerability reporting for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - A header with no content is returned. 
    resource isolated function delete repos/[string owner]/[string repo]/private\-vulnerability\-reporting() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/private-vulnerability-reporting`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List repository projects
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + state - Indicates the state of the projects to return.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/projects("open"|"closed"|"all" state = "open", int per_page = 30, int page = 1) returns Project[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/projects`;
        map<anydata> queryParam = {"state": state, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Project[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a repository project
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/projects(Repo_projects_body payload) returns Project|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/projects`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Project response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List pull requests
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + state - Either `open`, `closed`, or `all` to filter by state.
    # + head - Filter pulls by head user or head organization and branch name in the format of `user:ref-name` or `organization:ref-name`. For example: `github:new-script-format` or `octocat:test-branch`.
    # + base - Filter pulls by base branch name. Example: `gh-pages`.
    # + sort - What to sort results by. `popularity` will sort by the number of comments. `long-running` will sort by date created and will limit the results to pull requests that have been open for more than a month and have had activity within the past month.
    # + direction - The direction of the sort. Default: `desc` when sort is `created` or sort is not specified, otherwise `asc`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls("open"|"closed"|"all" state = "open", string? head = (), string? base = (), "created"|"updated"|"popularity"|"long-running" sort = "created", "asc"|"desc"? direction = (), int per_page = 30, int page = 1) returns PullRequestSimple[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls`;
        map<anydata> queryParam = {"state": state, "head": head, "base": base, "sort": sort, "direction": direction, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        PullRequestSimple[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pulls(Repo_pulls_body payload) returns PullRequest|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        PullRequest response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List review comments in a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + direction - The direction to sort results. Ignored without `sort` parameter.
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/comments("created"|"updated"|"created_at"? sort = (), "asc"|"desc"? direction = (), string? since = (), int per_page = 30, int page = 1) returns PullRequestReviewComment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/comments`;
        map<anydata> queryParam = {"sort": sort, "direction": direction, "since": since, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        PullRequestReviewComment[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a review comment for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/comments/[int comment_id]() returns PullRequestReviewComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/comments/${getEncodedUri(comment_id)}`;
        PullRequestReviewComment response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a review comment for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/pulls/comments/[int comment_id]() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/comments/${getEncodedUri(comment_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update a review comment for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/pulls/comments/[int comment_id](Comments_comment_id_body_3 payload) returns PullRequestReviewComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/comments/${getEncodedUri(comment_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        PullRequestReviewComment response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List reactions for a pull request review comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + content - Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to a pull request review comment.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/comments/[int comment_id]/reactions("+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes"? content = (), int per_page = 30, int page = 1) returns Reaction[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/comments/${getEncodedUri(comment_id)}/reactions`;
        map<anydata> queryParam = {"content": content, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Reaction[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create reaction for a pull request review comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + return - Reaction exists 
    resource isolated function post repos/[string owner]/[string repo]/pulls/comments/[int comment_id]/reactions(Comment_id_reactions_body_2 payload) returns Reaction|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/comments/${getEncodedUri(comment_id)}/reactions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Reaction response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete a pull request comment reaction
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + comment_id - The unique identifier of the comment.
    # + reaction_id - The unique identifier of the reaction.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/pulls/comments/[int comment_id]/reactions/[int reaction_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/comments/${getEncodedUri(comment_id)}/reactions/${getEncodedUri(reaction_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Get a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + return - Pass the appropriate [media type](https://docs.github.com/rest/overview/media-types/#commits-commit-comparison-and-pull-requests) to fetch diff and patch formats. 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pull_number]() returns PullRequest|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}`;
        PullRequest response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/pulls/[int pull_number](Pulls_pull_number_body payload) returns PullRequest|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        PullRequest response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Create a codespace from a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + return - Response when the codespace was successfully created 
    resource isolated function post repos/[string owner]/[string repo]/pulls/[int pull_number]/codespaces(Pull_number_codespaces_body payload) returns Codespace|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/codespaces`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Codespace response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List review comments on a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + sort - The property to sort the results by.
    # + direction - The direction to sort results. Ignored without `sort` parameter.
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pull_number]/comments("created"|"updated" sort = "created", "asc"|"desc"? direction = (), string? since = (), int per_page = 30, int page = 1) returns PullRequestReviewComment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/comments`;
        map<anydata> queryParam = {"sort": sort, "direction": direction, "since": since, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        PullRequestReviewComment[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a review comment for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pulls/[int pull_number]/comments(Pull_number_comments_body payload) returns PullRequestReviewComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/comments`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        PullRequestReviewComment response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Create a reply for a review comment
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + comment_id - The unique identifier of the comment.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pulls/[int pull_number]/comments/[int comment_id]/replies(Comment_id_replies_body payload) returns PullRequestReviewComment|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/comments/${getEncodedUri(comment_id)}/replies`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        PullRequestReviewComment response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List commits on a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pull_number]/commits(int per_page = 30, int page = 1) returns Commit[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/commits`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Commit[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List pull requests files
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pull_number]/files(int per_page = 30, int page = 1) returns DiffEntry[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/files`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        DiffEntry[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Check if a pull request has been merged
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + return - Response if pull request has been merged 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pull_number]/merge() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/merge`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Merge a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + return - if merge was successful 
    resource isolated function put repos/[string owner]/[string repo]/pulls/[int pull_number]/merge(Pull_number_merge_body payload) returns PullRequestMergeResult|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/merge`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        PullRequestMergeResult response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Get all requested reviewers for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pull_number]/requested_reviewers() returns PullRequestReviewRequest|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/requested_reviewers`;
        PullRequestReviewRequest response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Request reviewers for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pulls/[int pull_number]/requested_reviewers(Pull_number_requested_reviewers_body payload) returns PullRequestSimple|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/requested_reviewers`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        PullRequestSimple response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Remove requested reviewers from a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/pulls/[int pull_number]/requested_reviewers(Pull_number_requested_reviewers_body_1 payload) returns PullRequestSimple|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/requested_reviewers`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        PullRequestSimple response = check self.clientEp->delete(resourcePath, request);
        return response;
    }
    # List reviews for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - The list of reviews returns in chronological order. 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pull_number]/reviews(int per_page = 30, int page = 1) returns PullRequestReview[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/reviews`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        PullRequestReview[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a review for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pulls/[int pull_number]/reviews(Pull_number_reviews_body payload) returns PullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/reviews`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        PullRequestReview response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a review for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + review_id - The unique identifier of the review.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pull_number]/reviews/[int review_id]() returns PullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/reviews/${getEncodedUri(review_id)}`;
        PullRequestReview response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a review for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + review_id - The unique identifier of the review.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/pulls/[int pull_number]/reviews/[int review_id](Reviews_review_id_body payload) returns PullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/reviews/${getEncodedUri(review_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        PullRequestReview response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete a pending review for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + review_id - The unique identifier of the review.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/pulls/[int pull_number]/reviews/[int review_id]() returns PullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/reviews/${getEncodedUri(review_id)}`;
        PullRequestReview response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List comments for a pull request review
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + review_id - The unique identifier of the review.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/pulls/[int pull_number]/reviews/[int review_id]/comments(int per_page = 30, int page = 1) returns ReviewComment[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/reviews/${getEncodedUri(review_id)}/comments`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ReviewComment[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Dismiss a review for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + review_id - The unique identifier of the review.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/pulls/[int pull_number]/reviews/[int review_id]/dismissals(Review_id_dismissals_body payload) returns PullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/reviews/${getEncodedUri(review_id)}/dismissals`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        PullRequestReview response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Submit a review for a pull request
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + review_id - The unique identifier of the review.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/pulls/[int pull_number]/reviews/[int review_id]/events(Review_id_events_body payload) returns PullRequestReview|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/reviews/${getEncodedUri(review_id)}/events`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        PullRequestReview response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Update a pull request branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + pull_number - The number that identifies the pull request.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/pulls/[int pull_number]/update\-branch(Pull_number_updatebranch_body payload) returns NotificationRead|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/pulls/${getEncodedUri(pull_number)}/update-branch`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        NotificationRead response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Get a repository README
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ref - The name of the commit/branch/tag. Default: the repository’s default branch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/readme(string? ref = ()) returns ContentFile|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/readme`;
        map<anydata> queryParam = {"ref": ref};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ContentFile response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a repository README for a directory
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + dir - The alternate path to look for a README file
    # + ref - The name of the commit/branch/tag. Default: the repository’s default branch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/readme/[string dir](string? ref = ()) returns ContentFile|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/readme/${getEncodedUri(dir)}`;
        map<anydata> queryParam = {"ref": ref};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ContentFile response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List releases
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/releases(int per_page = 30, int page = 1) returns Release[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Release[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a release
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/releases(Repo_releases_body payload) returns Release|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Release response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a release asset
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + asset_id - The unique identifier of the asset.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/releases/assets/[int asset_id]() returns ReleaseAsset|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/assets/${getEncodedUri(asset_id)}`;
        ReleaseAsset? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a release asset
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + asset_id - The unique identifier of the asset.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/releases/assets/[int asset_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/assets/${getEncodedUri(asset_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Update a release asset
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + asset_id - The unique identifier of the asset.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/releases/assets/[int asset_id](Assets_asset_id_body payload) returns ReleaseAsset|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/assets/${getEncodedUri(asset_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        ReleaseAsset response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Generate release notes content for a release
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Name and body of generated release notes 
    resource isolated function post repos/[string owner]/[string repo]/releases/generate\-notes(Releases_generatenotes_body payload) returns ReleaseNotesContent|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/generate-notes`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        ReleaseNotesContent response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get the latest release
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/releases/latest() returns Release|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/latest`;
        Release response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a release by tag name
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + tag - tag parameter
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/releases/tags/[string tag]() returns Release|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/tags/${getEncodedUri(tag)}`;
        Release response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a release
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + release_id - The unique identifier of the release.
    # + return - **Note:** This returns an `upload_url` key corresponding to the endpoint for uploading release assets. This key is a [hypermedia resource](https://docs.github.com/rest/overview/resources-in-the-rest-api#hypermedia). 
    resource isolated function get repos/[string owner]/[string repo]/releases/[int release_id]() returns Release|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(release_id)}`;
        Release response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a release
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + release_id - The unique identifier of the release.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/releases/[int release_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(release_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Update a release
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + release_id - The unique identifier of the release.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/releases/[int release_id](Releases_release_id_body payload) returns Release|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(release_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Release response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List release assets
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + release_id - The unique identifier of the release.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/releases/[int release_id]/assets(int per_page = 30, int page = 1) returns ReleaseAsset[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(release_id)}/assets`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ReleaseAsset[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Upload a release asset
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + release_id - The unique identifier of the release.
    # + return - Response for successful upload 
    resource isolated function post repos/[string owner]/[string repo]/releases/[int release_id]/assets(string name, byte[] payload, string? label = ()) returns ReleaseAsset|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(release_id)}/assets`;
        map<anydata> queryParam = {"name": name, "label": label};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        http:Request request = new;
        request.setPayload(payload, "application/octet-stream");
        ReleaseAsset response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List reactions for a release
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + release_id - The unique identifier of the release.
    # + content - Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to a release.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/releases/[int release_id]/reactions("+1"|"laugh"|"heart"|"hooray"|"rocket"|"eyes"? content = (), int per_page = 30, int page = 1) returns Reaction[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(release_id)}/reactions`;
        map<anydata> queryParam = {"content": content, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Reaction[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create reaction for a release
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + release_id - The unique identifier of the release.
    # + return - Reaction exists 
    resource isolated function post repos/[string owner]/[string repo]/releases/[int release_id]/reactions(Release_id_reactions_body payload) returns Reaction|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(release_id)}/reactions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Reaction response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete a release reaction
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + release_id - The unique identifier of the release.
    # + reaction_id - The unique identifier of the reaction.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/releases/[int release_id]/reactions/[int reaction_id]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/releases/${getEncodedUri(release_id)}/reactions/${getEncodedUri(reaction_id)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Get rules for a branch
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + branch - The name of the branch. Cannot contain wildcard characters. To use wildcard characters in branch names, use [the GraphQL API](https://docs.github.com/graphql).
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/rules/branches/[string branch](int per_page = 30, int page = 1) returns RepositoryRuleDetailed[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rules/branches/${getEncodedUri(branch)}`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RepositoryRuleDetailed[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get all repository rulesets
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + includes_parents - Include rulesets configured at higher levels that apply to this repository
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/rulesets(int per_page = 30, int page = 1, boolean includes_parents = true) returns RepositoryRuleset[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rulesets`;
        map<anydata> queryParam = {"per_page": per_page, "page": page, "includes_parents": includes_parents};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RepositoryRuleset[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a repository ruleset
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + payload - Request body
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/rulesets(Repo_rulesets_body payload) returns RepositoryRuleset|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rulesets`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RepositoryRuleset response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List repository rule suites
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ref - The name of the ref. Cannot contain wildcard characters. When specified, only rule evaluations triggered for this ref will be returned.
    # + time_period - The time period to filter by.
    # For example, `day` will filter for rule suites that occurred in the past 24 hours, and `week` will filter for insights that occurred in the past 7 days (168 hours).
    # + actor_name - The handle for the GitHub user account to filter on. When specified, only rule evaluations triggered by this actor will be returned.
    # + rule_suite_result - The rule results to filter on. When specified, only suites with this result will be returned.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/rulesets/rule\-suites(string? ref = (), "hour"|"day"|"week"|"month" time_period = "day", string? actor_name = (), "pass"|"fail"|"bypass"|"all" rule_suite_result = "all", int per_page = 30, int page = 1) returns RuleSuites|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rulesets/rule-suites`;
        map<anydata> queryParam = {"ref": ref, "time_period": time_period, "actor_name": actor_name, "rule_suite_result": rule_suite_result, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RuleSuites response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a repository rule suite
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + rule_suite_id - The unique identifier of the rule suite result.
    # To get this ID, you can use [GET /repos/{owner}/{repo}/rulesets/rule-suites](https://docs.github.com/rest/repos/rule-suites#list-repository-rule-suites)
    # for repositories and [GET /orgs/{org}/rulesets/rule-suites](https://docs.github.com/rest/orgs/rule-suites#list-organization-rule-suites)
    # for organizations.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/rulesets/rule\-suites/[int rule_suite_id]() returns RuleSuite|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rulesets/rule-suites/${getEncodedUri(rule_suite_id)}`;
        RuleSuite response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a repository ruleset
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ruleset_id - The ID of the ruleset.
    # + includes_parents - Include rulesets configured at higher levels that apply to this repository
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/rulesets/[int ruleset_id](boolean includes_parents = true) returns RepositoryRuleset|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rulesets/${getEncodedUri(ruleset_id)}`;
        map<anydata> queryParam = {"includes_parents": includes_parents};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RepositoryRuleset response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a repository ruleset
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ruleset_id - The ID of the ruleset.
    # + payload - Request body
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/rulesets/[int ruleset_id](Rulesets_ruleset_id_body_1 payload) returns RepositoryRuleset|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rulesets/${getEncodedUri(ruleset_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RepositoryRuleset response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete a repository ruleset
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ruleset_id - The ID of the ruleset.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/rulesets/[int ruleset_id]() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/rulesets/${getEncodedUri(ruleset_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List secret scanning alerts for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + state - Set to `open` or `resolved` to only list secret scanning alerts in a specific state.
    # + secret_type - A comma-separated list of secret types to return. By default all secret types are returned.
    # See "[Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns#supported-secrets-for-advanced-security)"
    # for a complete list of secret types.
    # + resolution - A comma-separated list of resolutions. Only secret scanning alerts with one of these resolutions are listed. Valid resolutions are `false_positive`, `wont_fix`, `revoked`, `pattern_edited`, `pattern_deleted` or `used_in_tests`.
    # + sort - The property to sort the results by. `created` means when the alert was created. `updated` means when the alert was updated or resolved.
    # + direction - The direction to sort the results by.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + before - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for events before this cursor. To receive an initial cursor on your first request, include an empty "before" query string.
    # + after - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for events after this cursor.  To receive an initial cursor on your first request, include an empty "after" query string.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/secret\-scanning/alerts("open"|"resolved"? state = (), string? secret_type = (), string? resolution = (), "created"|"updated" sort = "created", "asc"|"desc" direction = "desc", int page = 1, int per_page = 30, string? before = (), string? after = ()) returns SecretScanningAlert[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/secret-scanning/alerts`;
        map<anydata> queryParam = {"state": state, "secret_type": secret_type, "resolution": resolution, "sort": sort, "direction": direction, "page": page, "per_page": per_page, "before": before, "after": after};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SecretScanningAlert[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a secret scanning alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + alert_number - The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the `number` field in the response from the `GET /repos/{owner}/{repo}/code-scanning/alerts` operation.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/secret\-scanning/alerts/[AlertNumber alert_number]() returns SecretScanningAlert|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/secret-scanning/alerts/${getEncodedUri(alert_number)}`;
        SecretScanningAlert response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a secret scanning alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + alert_number - The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the `number` field in the response from the `GET /repos/{owner}/{repo}/code-scanning/alerts` operation.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/secret\-scanning/alerts/[AlertNumber alert_number](Alerts_alert_number_body_2 payload) returns SecretScanningAlert|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/secret-scanning/alerts/${getEncodedUri(alert_number)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        SecretScanningAlert response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List locations for a secret scanning alert
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + alert_number - The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the `number` field in the response from the `GET /repos/{owner}/{repo}/code-scanning/alerts` operation.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/secret\-scanning/alerts/[AlertNumber alert_number]/locations(int page = 1, int per_page = 30) returns SecretScanningLocation[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/secret-scanning/alerts/${getEncodedUri(alert_number)}/locations`;
        map<anydata> queryParam = {"page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SecretScanningLocation[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List repository security advisories
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + direction - The direction to sort the results by.
    # + sort - The property to sort the results by.
    # + before - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.
    # + after - A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.
    # + per_page - Number of advisories to return per page.
    # + state - Filter by state of the repository advisories. Only advisories of this state will be returned.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/security\-advisories("asc"|"desc" direction = "desc", "created"|"updated"|"published" sort = "created", string? before = (), string? after = (), int per_page = 30, "triage"|"draft"|"published"|"closed"? state = ()) returns RepositoryAdvisory[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/security-advisories`;
        map<anydata> queryParam = {"direction": direction, "sort": sort, "before": before, "after": after, "per_page": per_page, "state": state};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RepositoryAdvisory[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a repository security advisory
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/security\-advisories(RepositoryAdvisoryCreate payload) returns RepositoryAdvisory|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/security-advisories`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RepositoryAdvisory response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Privately report a security vulnerability
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/security\-advisories/reports(PrivateVulnerabilityReportCreate payload) returns RepositoryAdvisory|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/security-advisories/reports`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RepositoryAdvisory response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a repository security advisory
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ghsa_id - The GHSA (GitHub Security Advisory) identifier of the advisory.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/security\-advisories/[string ghsa_id]() returns RepositoryAdvisory|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/security-advisories/${getEncodedUri(ghsa_id)}`;
        RepositoryAdvisory response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a repository security advisory
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ghsa_id - The GHSA (GitHub Security Advisory) identifier of the advisory.
    # + return - Response 
    resource isolated function patch repos/[string owner]/[string repo]/security\-advisories/[string ghsa_id](RepositoryAdvisoryUpdate payload) returns RepositoryAdvisory|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/security-advisories/${getEncodedUri(ghsa_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RepositoryAdvisory response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Request a CVE for a repository security advisory
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + ghsa_id - The GHSA (GitHub Security Advisory) identifier of the advisory.
    # + return - Accepted 
    resource isolated function post repos/[string owner]/[string repo]/security\-advisories/[string ghsa_id]/cve() returns json|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/security-advisories/${getEncodedUri(ghsa_id)}/cve`;
        http:Request request = new;
        json response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List stargazers
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/stargazers(int per_page = 30, int page = 1) returns StargazerResponse|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/stargazers`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        StargazerResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get the weekly commit activity
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Returns a weekly aggregate of the number of additions and deletions pushed to a repository. 
    resource isolated function get repos/[string owner]/[string repo]/stats/code_frequency() returns json|CodeFrequencyStat[]|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/stats/code_frequency`;
        json|CodeFrequencyStat[]? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get the last year of commit activity
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/stats/commit_activity() returns json|CommitActivity[]|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/stats/commit_activity`;
        json|CommitActivity[]? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get all contributor commit activity
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/stats/contributors() returns json|ContributorActivity[]|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/stats/contributors`;
        json|ContributorActivity[]? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get the weekly commit count
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - The array order is oldest week (index 0) to most recent week. 
    resource isolated function get repos/[string owner]/[string repo]/stats/participation() returns ParticipationStats|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/stats/participation`;
        ParticipationStats response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get the hourly commit count for each day
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - For example, `[2, 14, 25]` indicates that there were 25 total commits, during the 2:00pm hour on Tuesdays. All times are based on the time zone of individual commits. 
    resource isolated function get repos/[string owner]/[string repo]/stats/punch_card() returns CodeFrequencyStat[]|error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/stats/punch_card`;
        CodeFrequencyStat[]? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a commit status
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/statuses/[string sha](Statuses_sha_body payload) returns Status|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/statuses/${getEncodedUri(sha)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Status response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List watchers
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/subscribers(int per_page = 30, int page = 1) returns SimpleUser[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/subscribers`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleUser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a repository subscription
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - if you subscribe to the repository 
    resource isolated function get repos/[string owner]/[string repo]/subscription() returns RepositorySubscription|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/subscription`;
        RepositorySubscription response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set a repository subscription
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/subscription(Repo_subscription_body payload) returns RepositorySubscription|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/subscription`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RepositorySubscription response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete a repository subscription
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/subscription() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/subscription`;
        return self.clientEp->delete(resourcePath);
    }
    # List repository tags
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/tags(int per_page = 30, int page = 1) returns Tag[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/tags`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Tag[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List tag protection states for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/tags/protection() returns TagProtection[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/tags/protection`;
        TagProtection[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a tag protection state for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/tags/protection(Tags_protection_body payload) returns TagProtection|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/tags/protection`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TagProtection response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete a tag protection state for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + tag_protection_id - The unique identifier of the tag protection.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/tags/protection/[int tag_protection_id]() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/tags/protection/${getEncodedUri(tag_protection_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Download a repository archive (tar)
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/tarball/[string ref]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/tarball/${getEncodedUri(ref)}`;
        return self.clientEp->get(resourcePath);
    }
    # List repository teams
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/teams(int per_page = 30, int page = 1) returns Team[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/teams`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Team[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get all repository topics
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/topics(int page = 1, int per_page = 30) returns Topic|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/topics`;
        map<anydata> queryParam = {"page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Topic response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Replace all repository topics
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/topics(Repo_topics_body payload) returns Topic|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/topics`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Topic response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Get repository clones
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per - The time frame to display results for.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/traffic/clones("day"|"week" per = "day") returns CloneTraffic|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/traffic/clones`;
        map<anydata> queryParam = {"per": per};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CloneTraffic response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get top referral paths
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/traffic/popular/paths() returns ContentTraffic[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/traffic/popular/paths`;
        ContentTraffic[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get top referral sources
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/traffic/popular/referrers() returns ReferrerTraffic[]|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/traffic/popular/referrers`;
        ReferrerTraffic[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get page views
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + per - The time frame to display results for.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/traffic/views("day"|"week" per = "day") returns ViewTraffic|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/traffic/views`;
        map<anydata> queryParam = {"per": per};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ViewTraffic response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Transfer a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string owner]/[string repo]/transfer(Repo_transfer_body payload) returns MinimalRepository|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/transfer`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        MinimalRepository response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Check if vulnerability alerts are enabled for a repository
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response if repository is enabled with vulnerability alerts 
    resource isolated function get repos/[string owner]/[string repo]/vulnerability\-alerts() returns http:Response|error {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/vulnerability-alerts`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Enable vulnerability alerts
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function put repos/[string owner]/[string repo]/vulnerability\-alerts() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/vulnerability-alerts`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request);
    }
    # Disable vulnerability alerts
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function delete repos/[string owner]/[string repo]/vulnerability\-alerts() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/vulnerability-alerts`;
        return self.clientEp->delete(resourcePath);
    }
    # Download a repository archive (zip)
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function get repos/[string owner]/[string repo]/zipball/[string ref]() returns error? {
        string resourcePath = string `/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}/zipball/${getEncodedUri(ref)}`;
        return self.clientEp->get(resourcePath);
    }
    # Create a repository using a template
    #
    # + template_owner - The account owner of the template repository. The name is not case sensitive.
    # + template_repo - The name of the template repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function post repos/[string template_owner]/[string template_repo]/generate(Template_repo_generate_body payload) returns Repository|error {
        string resourcePath = string `/repos/${getEncodedUri(template_owner)}/${getEncodedUri(template_repo)}/generate`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Repository response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List public repositories
    #
    # + since - A repository ID. Only return repositories with an ID greater than this ID.
    # + return - Response 
    resource isolated function get repositories(int? since = ()) returns MinimalRepository[]|error? {
        string resourcePath = string `/repositories`;
        map<anydata> queryParam = {"since": since};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepository[]? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List environment secrets
    #
    # + repository_id - The unique identifier of the repository.
    # + environment_name - The name of the environment.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repositories/[int repository_id]/environments/[string environment_name]/secrets(int per_page = 30, int page = 1) returns ActionsSecretResponse|error {
        string resourcePath = string `/repositories/${getEncodedUri(repository_id)}/environments/${getEncodedUri(environment_name)}/secrets`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ActionsSecretResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an environment public key
    #
    # + repository_id - The unique identifier of the repository.
    # + environment_name - The name of the environment.
    # + return - Response 
    resource isolated function get repositories/[int repository_id]/environments/[string environment_name]/secrets/public\-key() returns ActionsPublicKey|error {
        string resourcePath = string `/repositories/${getEncodedUri(repository_id)}/environments/${getEncodedUri(environment_name)}/secrets/public-key`;
        ActionsPublicKey response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an environment secret
    #
    # + repository_id - The unique identifier of the repository.
    # + environment_name - The name of the environment.
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function get repositories/[int repository_id]/environments/[string environment_name]/secrets/[string secret_name]() returns ActionsSecret|error {
        string resourcePath = string `/repositories/${getEncodedUri(repository_id)}/environments/${getEncodedUri(environment_name)}/secrets/${getEncodedUri(secret_name)}`;
        ActionsSecret response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create or update an environment secret
    #
    # + repository_id - The unique identifier of the repository.
    # + environment_name - The name of the environment.
    # + secret_name - The name of the secret.
    # + return - Response when creating a secret 
    resource isolated function put repositories/[int repository_id]/environments/[string environment_name]/secrets/[string secret_name](Secrets_secret_name_body_6 payload) returns EmptyObject|error? {
        string resourcePath = string `/repositories/${getEncodedUri(repository_id)}/environments/${getEncodedUri(environment_name)}/secrets/${getEncodedUri(secret_name)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject? response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete an environment secret
    #
    # + repository_id - The unique identifier of the repository.
    # + environment_name - The name of the environment.
    # + secret_name - The name of the secret.
    # + return - Default response 
    resource isolated function delete repositories/[int repository_id]/environments/[string environment_name]/secrets/[string secret_name]() returns error? {
        string resourcePath = string `/repositories/${getEncodedUri(repository_id)}/environments/${getEncodedUri(environment_name)}/secrets/${getEncodedUri(secret_name)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List environment variables
    #
    # + repository_id - The unique identifier of the repository.
    # + environment_name - The name of the environment.
    # + per_page - The number of results per page (max 30).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get repositories/[int repository_id]/environments/[string environment_name]/variables(int per_page = 10, int page = 1) returns ActionsVariableResponse|error {
        string resourcePath = string `/repositories/${getEncodedUri(repository_id)}/environments/${getEncodedUri(environment_name)}/variables`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ActionsVariableResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create an environment variable
    #
    # + repository_id - The unique identifier of the repository.
    # + environment_name - The name of the environment.
    # + return - Response 
    resource isolated function post repositories/[int repository_id]/environments/[string environment_name]/variables(Environment_name_variables_body payload) returns EmptyObject|error {
        string resourcePath = string `/repositories/${getEncodedUri(repository_id)}/environments/${getEncodedUri(environment_name)}/variables`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get an environment variable
    #
    # + repository_id - The unique identifier of the repository.
    # + environment_name - The name of the environment.
    # + name - The name of the variable.
    # + return - Response 
    resource isolated function get repositories/[int repository_id]/environments/[string environment_name]/variables/[string name]() returns ActionsVariable|error {
        string resourcePath = string `/repositories/${getEncodedUri(repository_id)}/environments/${getEncodedUri(environment_name)}/variables/${getEncodedUri(name)}`;
        ActionsVariable response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete an environment variable
    #
    # + repository_id - The unique identifier of the repository.
    # + name - The name of the variable.
    # + environment_name - The name of the environment.
    # + return - Response 
    resource isolated function delete repositories/[int repository_id]/environments/[string environment_name]/variables/[string name]() returns error? {
        string resourcePath = string `/repositories/${getEncodedUri(repository_id)}/environments/${getEncodedUri(environment_name)}/variables/${getEncodedUri(name)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Update an environment variable
    #
    # + repository_id - The unique identifier of the repository.
    # + name - The name of the variable.
    # + environment_name - The name of the environment.
    # + return - Response 
    resource isolated function patch repositories/[int repository_id]/environments/[string environment_name]/variables/[string name](Variables_name_body_2 payload) returns error? {
        string resourcePath = string `/repositories/${getEncodedUri(repository_id)}/environments/${getEncodedUri(environment_name)}/variables/${getEncodedUri(name)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request);
    }
    # Search code
    #
    # + q - The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching code](https://docs.github.com/search-github/searching-on-github/searching-code)" for a detailed list of qualifiers.
    # + sort - **This field is deprecated.** Sorts the results of your query. Can only be `indexed`, which indicates how recently a file has been indexed by the GitHub search infrastructure. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    # + 'order - **This field is deprecated.** Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`. 
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # # Deprecated parameters
    # + sort -
    # + 'order -
    # + return - Response 
    resource isolated function get search/code(string q, @deprecated "indexed"? sort = (), @deprecated "desc"|"asc" 'order = "desc", int per_page = 30, int page = 1) returns CodeSearchResultItemResponse|error {
        string resourcePath = string `/search/code`;
        map<anydata> queryParam = {"q": q, "sort": sort, "order": 'order, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodeSearchResultItemResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Search commits
    #
    # + q - The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching commits](https://docs.github.com/search-github/searching-on-github/searching-commits)" for a detailed list of qualifiers.
    # + sort - Sorts the results of your query by `author-date` or `committer-date`. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    # + 'order - Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get search/commits(string q, "author-date"|"committer-date"? sort = (), "desc"|"asc" 'order = "desc", int per_page = 30, int page = 1) returns CommitSearchResultItemResponse|error? {
        string resourcePath = string `/search/commits`;
        map<anydata> queryParam = {"q": q, "sort": sort, "order": 'order, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CommitSearchResultItemResponse? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Search issues and pull requests
    #
    # + q - The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching issues and pull requests](https://docs.github.com/search-github/searching-on-github/searching-issues-and-pull-requests)" for a detailed list of qualifiers.
    # + sort - Sorts the results of your query by the number of `comments`, `reactions`, `reactions-+1`, `reactions--1`, `reactions-smile`, `reactions-thinking_face`, `reactions-heart`, `reactions-tada`, or `interactions`. You can also sort results by how recently the items were `created` or `updated`, Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    # + 'order - Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get search/issues(string q, "comments"|"reactions"|"reactions-+1"|"reactions--1"|"reactions-smile"|"reactions-thinking_face"|"reactions-heart"|"reactions-tada"|"interactions"|"created"|"updated"? sort = (), "desc"|"asc" 'order = "desc", int per_page = 30, int page = 1) returns IssueSearchResultItemResponse|error {
        string resourcePath = string `/search/issues`;
        map<anydata> queryParam = {"q": q, "sort": sort, "order": 'order, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        IssueSearchResultItemResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Search labels
    #
    # + repository_id - The id of the repository.
    # + q - The search keywords. This endpoint does not accept qualifiers in the query. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query).
    # + sort - Sorts the results of your query by when the label was `created` or `updated`. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    # + 'order - Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get search/labels(int repository_id, string q, "created"|"updated"? sort = (), "desc"|"asc" 'order = "desc", int per_page = 30, int page = 1) returns LabelSearchResultItemResponse|error {
        string resourcePath = string `/search/labels`;
        map<anydata> queryParam = {"repository_id": repository_id, "q": q, "sort": sort, "order": 'order, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        LabelSearchResultItemResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Search repositories
    #
    # + q - The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching for repositories](https://docs.github.com/articles/searching-for-repositories/)" for a detailed list of qualifiers.
    # + sort - Sorts the results of your query by number of `stars`, `forks`, or `help-wanted-issues` or how recently the items were `updated`. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    # + 'order - Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get search/repositories(string q, "stars"|"forks"|"help-wanted-issues"|"updated"? sort = (), "desc"|"asc" 'order = "desc", int per_page = 30, int page = 1) returns RepoSearchResultItemResponse|error? {
        string resourcePath = string `/search/repositories`;
        map<anydata> queryParam = {"q": q, "sort": sort, "order": 'order, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RepoSearchResultItemResponse? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Search topics
    #
    # + q - The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query).
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get search/topics(string q, int per_page = 30, int page = 1) returns TopicSearchResultItemResponse|error? {
        string resourcePath = string `/search/topics`;
        map<anydata> queryParam = {"q": q, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        TopicSearchResultItemResponse? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Search users
    #
    # + q - The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching users](https://docs.github.com/search-github/searching-on-github/searching-users)" for a detailed list of qualifiers.
    # + sort - Sorts the results of your query by number of `followers` or `repositories`, or when the person `joined` GitHub. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    # + 'order - Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get search/users(string q, "followers"|"repositories"|"joined"? sort = (), "desc"|"asc" 'order = "desc", int per_page = 30, int page = 1) returns UserSearchResultItemResponse|error {
        string resourcePath = string `/search/users`;
        map<anydata> queryParam = {"q": q, "sort": sort, "order": 'order, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        UserSearchResultItemResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a team (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]() returns TeamFull|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}`;
        TeamFull response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a team (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete teams/[int team_id]() returns http:Response|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update a team (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + return - Response when the updated information already exists 
    # 
    # # Deprecated
    @deprecated
    resource isolated function patch teams/[int team_id](Teams_team_id_body payload) returns TeamFull|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TeamFull response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List discussions (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + direction - The direction to sort the results by.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]/discussions("asc"|"desc" direction = "desc", int per_page = 30, int page = 1) returns TeamDiscussion[]|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/discussions`;
        map<anydata> queryParam = {"direction": direction, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        TeamDiscussion[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a discussion (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function post teams/[int team_id]/discussions(Team_id_discussions_body payload) returns TeamDiscussion|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/discussions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TeamDiscussion response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a discussion (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + discussion_number - The number that identifies the discussion.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]/discussions/[int discussion_number]() returns TeamDiscussion|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/discussions/${getEncodedUri(discussion_number)}`;
        TeamDiscussion response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a discussion (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + discussion_number - The number that identifies the discussion.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete teams/[int team_id]/discussions/[int discussion_number]() returns error? {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/discussions/${getEncodedUri(discussion_number)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Update a discussion (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + discussion_number - The number that identifies the discussion.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function patch teams/[int team_id]/discussions/[int discussion_number](Discussions_discussion_number_body_1 payload) returns TeamDiscussion|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/discussions/${getEncodedUri(discussion_number)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TeamDiscussion response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List discussion comments (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + discussion_number - The number that identifies the discussion.
    # + direction - The direction to sort the results by.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]/discussions/[int discussion_number]/comments("asc"|"desc" direction = "desc", int per_page = 30, int page = 1) returns TeamDiscussionComment[]|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/discussions/${getEncodedUri(discussion_number)}/comments`;
        map<anydata> queryParam = {"direction": direction, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        TeamDiscussionComment[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a discussion comment (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + discussion_number - The number that identifies the discussion.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function post teams/[int team_id]/discussions/[int discussion_number]/comments(Discussion_number_comments_body_1 payload) returns TeamDiscussionComment|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/discussions/${getEncodedUri(discussion_number)}/comments`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TeamDiscussionComment response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a discussion comment (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + discussion_number - The number that identifies the discussion.
    # + comment_number - The number that identifies the comment.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]/discussions/[int discussion_number]/comments/[int comment_number]() returns TeamDiscussionComment|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/discussions/${getEncodedUri(discussion_number)}/comments/${getEncodedUri(comment_number)}`;
        TeamDiscussionComment response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a discussion comment (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + discussion_number - The number that identifies the discussion.
    # + comment_number - The number that identifies the comment.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete teams/[int team_id]/discussions/[int discussion_number]/comments/[int comment_number]() returns error? {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/discussions/${getEncodedUri(discussion_number)}/comments/${getEncodedUri(comment_number)}`;
        return self.clientEp->delete(resourcePath);
    }
    # Update a discussion comment (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + discussion_number - The number that identifies the discussion.
    # + comment_number - The number that identifies the comment.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function patch teams/[int team_id]/discussions/[int discussion_number]/comments/[int comment_number](Comments_comment_number_body_1 payload) returns TeamDiscussionComment|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/discussions/${getEncodedUri(discussion_number)}/comments/${getEncodedUri(comment_number)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TeamDiscussionComment response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List reactions for a team discussion comment (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + discussion_number - The number that identifies the discussion.
    # + comment_number - The number that identifies the comment.
    # + content - Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to a team discussion comment.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]/discussions/[int discussion_number]/comments/[int comment_number]/reactions("+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes"? content = (), int per_page = 30, int page = 1) returns Reaction[]|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/discussions/${getEncodedUri(discussion_number)}/comments/${getEncodedUri(comment_number)}/reactions`;
        map<anydata> queryParam = {"content": content, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Reaction[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create reaction for a team discussion comment (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + discussion_number - The number that identifies the discussion.
    # + comment_number - The number that identifies the comment.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function post teams/[int team_id]/discussions/[int discussion_number]/comments/[int comment_number]/reactions(Comment_number_reactions_body_1 payload) returns Reaction|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/discussions/${getEncodedUri(discussion_number)}/comments/${getEncodedUri(comment_number)}/reactions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Reaction response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List reactions for a team discussion (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + discussion_number - The number that identifies the discussion.
    # + content - Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to a team discussion.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]/discussions/[int discussion_number]/reactions("+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes"? content = (), int per_page = 30, int page = 1) returns Reaction[]|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/discussions/${getEncodedUri(discussion_number)}/reactions`;
        map<anydata> queryParam = {"content": content, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Reaction[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create reaction for a team discussion (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + discussion_number - The number that identifies the discussion.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function post teams/[int team_id]/discussions/[int discussion_number]/reactions(Discussion_number_reactions_body_1 payload) returns Reaction|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/discussions/${getEncodedUri(discussion_number)}/reactions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Reaction response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List pending team invitations (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]/invitations(int per_page = 30, int page = 1) returns OrganizationInvitation[]|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/invitations`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrganizationInvitation[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List team members (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + role - Filters members returned by their role in the team.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]/members("member"|"maintainer"|"all" role = "all", int per_page = 30, int page = 1) returns SimpleUser[]|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/members`;
        map<anydata> queryParam = {"role": role, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleUser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get team member (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + username - The handle for the GitHub user account.
    # + return - if user is a member 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]/members/[string username]() returns http:Response|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/members/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add team member (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function put teams/[int team_id]/members/[string username]() returns http:Response|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/members/${getEncodedUri(username)}`;
        http:Request request = new;
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove team member (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete teams/[int team_id]/members/[string username]() returns http:Response|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/members/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Get team membership for a user (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]/memberships/[string username]() returns TeamMembership|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/memberships/${getEncodedUri(username)}`;
        TeamMembership response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add or update team membership for a user (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function put teams/[int team_id]/memberships/[string username](Memberships_username_body_2 payload) returns TeamMembership|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/memberships/${getEncodedUri(username)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TeamMembership response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove team membership for a user (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete teams/[int team_id]/memberships/[string username]() returns http:Response|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/memberships/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List team projects (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]/projects(int per_page = 30, int page = 1) returns TeamProject[]|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/projects`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        TeamProject[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Check team permissions for a project (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + project_id - The unique identifier of the project.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]/projects/[int project_id]() returns TeamProject|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/projects/${getEncodedUri(project_id)}`;
        TeamProject response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add or update team project permissions (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + project_id - The unique identifier of the project.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function put teams/[int team_id]/projects/[int project_id](Projects_project_id_body_2 payload) returns http:Response|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/projects/${getEncodedUri(project_id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove a project from a team (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + project_id - The unique identifier of the project.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete teams/[int team_id]/projects/[int project_id]() returns http:Response|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/projects/${getEncodedUri(project_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List team repositories (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]/repos(int per_page = 30, int page = 1) returns MinimalRepository[]|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/repos`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepository[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Check team permissions for a repository (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Alternative response with extra repository information 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]/repos/[string owner]/[string repo]() returns TeamRepository|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        TeamRepository response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add or update team repository permissions (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function put teams/[int team_id]/repos/[string owner]/[string repo](Owner_repo_body_2 payload) returns http:Response|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove a repository from a team (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    # 
    # # Deprecated
    @deprecated
    resource isolated function delete teams/[int team_id]/repos/[string owner]/[string repo]() returns error? {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/repos/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List child teams (Legacy)
    #
    # + team_id - The unique identifier of the team.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - if child teams exist 
    # 
    # # Deprecated
    @deprecated
    resource isolated function get teams/[int team_id]/teams(int per_page = 30, int page = 1) returns Team[]|error {
        string resourcePath = string `/teams/${getEncodedUri(team_id)}/teams`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Team[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get the authenticated user
    #
    # + return - Response 
    resource isolated function get user() returns UserResponse|error {
        string resourcePath = string `/user`;
        UserResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update the authenticated user
    #
    # + return - Response 
    resource isolated function patch user(User_body payload) returns PrivateUser|error {
        string resourcePath = string `/user`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        PrivateUser response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List users blocked by the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/blocks(int per_page = 30, int page = 1) returns SimpleUser[]|error {
        string resourcePath = string `/user/blocks`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleUser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Check if a user is blocked by the authenticated user
    #
    # + username - The handle for the GitHub user account.
    # + return - If the user is blocked 
    resource isolated function get user/blocks/[string username]() returns http:Response|error {
        string resourcePath = string `/user/blocks/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Block a user
    #
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function put user/blocks/[string username]() returns http:Response|error {
        string resourcePath = string `/user/blocks/${getEncodedUri(username)}`;
        http:Request request = new;
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Unblock a user
    #
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function delete user/blocks/[string username]() returns http:Response|error {
        string resourcePath = string `/user/blocks/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List codespaces for the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + repository_id - ID of the Repository to filter on
    # + return - Response 
    resource isolated function get user/codespaces(int per_page = 30, int page = 1, int? repository_id = ()) returns CodespaceResponse|error {
        string resourcePath = string `/user/codespaces`;
        map<anydata> queryParam = {"per_page": per_page, "page": page, "repository_id": repository_id};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodespaceResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a codespace for the authenticated user
    #
    # + return - Response when the codespace was successfully created 
    resource isolated function post user/codespaces(User_codespaces_body payload) returns Codespace|error {
        string resourcePath = string `/user/codespaces`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Codespace response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List secrets for the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/codespaces/secrets(int per_page = 30, int page = 1) returns CodespacesSecretResponse|error {
        string resourcePath = string `/user/codespaces/secrets`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CodespacesSecretResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get public key for the authenticated user
    #
    # + return - Response 
    resource isolated function get user/codespaces/secrets/public\-key() returns CodespacesUserPublicKey|error {
        string resourcePath = string `/user/codespaces/secrets/public-key`;
        CodespacesUserPublicKey response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a secret for the authenticated user
    #
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function get user/codespaces/secrets/[string secret_name]() returns CodespacesSecret|error {
        string resourcePath = string `/user/codespaces/secrets/${getEncodedUri(secret_name)}`;
        CodespacesSecret response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create or update a secret for the authenticated user
    #
    # + secret_name - The name of the secret.
    # + return - Response after successfully creating a secret 
    resource isolated function put user/codespaces/secrets/[string secret_name](Secrets_secret_name_body_7 payload) returns EmptyObject|error {
        string resourcePath = string `/user/codespaces/secrets/${getEncodedUri(secret_name)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        EmptyObject response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete a secret for the authenticated user
    #
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function delete user/codespaces/secrets/[string secret_name]() returns error? {
        string resourcePath = string `/user/codespaces/secrets/${getEncodedUri(secret_name)}`;
        return self.clientEp->delete(resourcePath);
    }
    # List selected repositories for a user secret
    #
    # + secret_name - The name of the secret.
    # + return - Response 
    resource isolated function get user/codespaces/secrets/[string secret_name]/repositories() returns MinimalRepositoryResponse|error {
        string resourcePath = string `/user/codespaces/secrets/${getEncodedUri(secret_name)}/repositories`;
        MinimalRepositoryResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set selected repositories for a user secret
    #
    # + secret_name - The name of the secret.
    # + return - No Content when repositories were added to the selected list 
    resource isolated function put user/codespaces/secrets/[string secret_name]/repositories(Secret_name_repositories_body_3 payload) returns http:Response|error {
        string resourcePath = string `/user/codespaces/secrets/${getEncodedUri(secret_name)}/repositories`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Add a selected repository to a user secret
    #
    # + secret_name - The name of the secret.
    # + return - No Content when repository was added to the selected list 
    resource isolated function put user/codespaces/secrets/[string secret_name]/repositories/[int repository_id]() returns http:Response|error {
        string resourcePath = string `/user/codespaces/secrets/${getEncodedUri(secret_name)}/repositories/${getEncodedUri(repository_id)}`;
        http:Request request = new;
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove a selected repository from a user secret
    #
    # + secret_name - The name of the secret.
    # + return - No Content when repository was removed from the selected list 
    resource isolated function delete user/codespaces/secrets/[string secret_name]/repositories/[int repository_id]() returns http:Response|error {
        string resourcePath = string `/user/codespaces/secrets/${getEncodedUri(secret_name)}/repositories/${getEncodedUri(repository_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Get a codespace for the authenticated user
    #
    # + codespace_name - The name of the codespace.
    # + return - Response 
    resource isolated function get user/codespaces/[string codespace_name]() returns Codespace|error {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespace_name)}`;
        Codespace response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a codespace for the authenticated user
    #
    # + codespace_name - The name of the codespace.
    # + return - Accepted 
    resource isolated function delete user/codespaces/[string codespace_name]() returns json|error {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespace_name)}`;
        json response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update a codespace for the authenticated user
    #
    # + codespace_name - The name of the codespace.
    # + return - Response 
    resource isolated function patch user/codespaces/[string codespace_name](Codespaces_codespace_name_body payload) returns Codespace|error {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespace_name)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Codespace response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Export a codespace for the authenticated user
    #
    # + codespace_name - The name of the codespace.
    # + return - Response 
    resource isolated function post user/codespaces/[string codespace_name]/exports() returns CodespaceExportDetails|error {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespace_name)}/exports`;
        http:Request request = new;
        CodespaceExportDetails response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get details about a codespace export
    #
    # + codespace_name - The name of the codespace.
    # + export_id - The ID of the export operation, or `latest`. Currently only `latest` is currently supported.
    # + return - Response 
    resource isolated function get user/codespaces/[string codespace_name]/exports/[string export_id]() returns CodespaceExportDetails|error {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespace_name)}/exports/${getEncodedUri(export_id)}`;
        CodespaceExportDetails response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List machine types for a codespace
    #
    # + codespace_name - The name of the codespace.
    # + return - Response 
    resource isolated function get user/codespaces/[string codespace_name]/machines() returns CodespaceMachineResponse|error {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespace_name)}/machines`;
        CodespaceMachineResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a repository from an unpublished codespace
    #
    # + codespace_name - The name of the codespace.
    # + return - Response 
    resource isolated function post user/codespaces/[string codespace_name]/publish(Codespace_name_publish_body payload) returns CodespaceWithFullRepository|error {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespace_name)}/publish`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CodespaceWithFullRepository response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Start a codespace for the authenticated user
    #
    # + codespace_name - The name of the codespace.
    # + return - Response 
    resource isolated function post user/codespaces/[string codespace_name]/'start() returns Codespace|error {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespace_name)}/start`;
        http:Request request = new;
        Codespace response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Stop a codespace for the authenticated user
    #
    # + codespace_name - The name of the codespace.
    # + return - Response 
    resource isolated function post user/codespaces/[string codespace_name]/stop() returns Codespace|error {
        string resourcePath = string `/user/codespaces/${getEncodedUri(codespace_name)}/stop`;
        http:Request request = new;
        Codespace response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get list of conflicting packages during Docker migration for authenticated-user
    #
    # + return - Response 
    resource isolated function get user/docker/conflicts() returns Package[]|error {
        string resourcePath = string `/user/docker/conflicts`;
        Package[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set primary email visibility for the authenticated user
    #
    # + return - Response 
    resource isolated function patch user/email/visibility(Email_visibility_body payload) returns Email[]|error {
        string resourcePath = string `/user/email/visibility`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Email[] response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List email addresses for the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/emails(int per_page = 30, int page = 1) returns Email[]|error {
        string resourcePath = string `/user/emails`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Email[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add an email address for the authenticated user
    #
    # + return - Response 
    resource isolated function post user/emails(User_emails_body payload) returns Email[]|error {
        string resourcePath = string `/user/emails`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Email[] response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete an email address for the authenticated user
    #
    # + return - Response 
    resource isolated function delete user/emails(User_emails_body_1 payload) returns http:Response|error {
        string resourcePath = string `/user/emails`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->delete(resourcePath, request);
        return response;
    }
    # List followers of the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/followers(int per_page = 30, int page = 1) returns SimpleUser[]|error {
        string resourcePath = string `/user/followers`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleUser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List the people the authenticated user follows
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/following(int per_page = 30, int page = 1) returns SimpleUser[]|error {
        string resourcePath = string `/user/following`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleUser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Check if a person is followed by the authenticated user
    #
    # + username - The handle for the GitHub user account.
    # + return - if the person is followed by the authenticated user 
    resource isolated function get user/following/[string username]() returns http:Response|error {
        string resourcePath = string `/user/following/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Follow a user
    #
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function put user/following/[string username]() returns http:Response|error {
        string resourcePath = string `/user/following/${getEncodedUri(username)}`;
        http:Request request = new;
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Unfollow a user
    #
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function delete user/following/[string username]() returns http:Response|error {
        string resourcePath = string `/user/following/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List GPG keys for the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/gpg_keys(int per_page = 30, int page = 1) returns GpgKey[]|error {
        string resourcePath = string `/user/gpg_keys`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        GpgKey[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a GPG key for the authenticated user
    #
    # + return - Response 
    resource isolated function post user/gpg_keys(User_gpg_keys_body payload) returns GpgKey|error {
        string resourcePath = string `/user/gpg_keys`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        GpgKey response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a GPG key for the authenticated user
    #
    # + gpg_key_id - The unique identifier of the GPG key.
    # + return - Response 
    resource isolated function get user/gpg_keys/[int gpg_key_id]() returns GpgKey|error {
        string resourcePath = string `/user/gpg_keys/${getEncodedUri(gpg_key_id)}`;
        GpgKey response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a GPG key for the authenticated user
    #
    # + gpg_key_id - The unique identifier of the GPG key.
    # + return - Response 
    resource isolated function delete user/gpg_keys/[int gpg_key_id]() returns http:Response|error {
        string resourcePath = string `/user/gpg_keys/${getEncodedUri(gpg_key_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List app installations accessible to the user access token
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - You can find the permissions for the installation under the `permissions` key. 
    resource isolated function get user/installations(int per_page = 30, int page = 1) returns InstallationResponse|error {
        string resourcePath = string `/user/installations`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        InstallationResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List repositories accessible to the user access token
    #
    # + installation_id - The unique identifier of the installation.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - The access the user has to each repository is included in the hash under the `permissions` key. 
    resource isolated function get user/installations/[int installation_id]/repositories(int per_page = 30, int page = 1) returns RepositoryResponse|error? {
        string resourcePath = string `/user/installations/${getEncodedUri(installation_id)}/repositories`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RepositoryResponse? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add a repository to an app installation
    #
    # + installation_id - The unique identifier of the installation.
    # + repository_id - The unique identifier of the repository.
    # + return - Response 
    resource isolated function put user/installations/[int installation_id]/repositories/[int repository_id]() returns http:Response|error {
        string resourcePath = string `/user/installations/${getEncodedUri(installation_id)}/repositories/${getEncodedUri(repository_id)}`;
        http:Request request = new;
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove a repository from an app installation
    #
    # + installation_id - The unique identifier of the installation.
    # + repository_id - The unique identifier of the repository.
    # + return - Response 
    resource isolated function delete user/installations/[int installation_id]/repositories/[int repository_id]() returns http:Response|error {
        string resourcePath = string `/user/installations/${getEncodedUri(installation_id)}/repositories/${getEncodedUri(repository_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Get interaction restrictions for your public repositories
    #
    # + return - Default response 
    resource isolated function get user/interaction\-limits() returns InteractionLimitResponseAny|error? {
        string resourcePath = string `/user/interaction-limits`;
        InteractionLimitResponseAny? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Set interaction restrictions for your public repositories
    #
    # + return - Response 
    resource isolated function put user/interaction\-limits(InteractionLimit payload) returns InteractionLimitResponse|error {
        string resourcePath = string `/user/interaction-limits`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        InteractionLimitResponse response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Remove interaction restrictions from your public repositories
    #
    # + return - Response 
    resource isolated function delete user/interaction\-limits() returns error? {
        string resourcePath = string `/user/interaction-limits`;
        return self.clientEp->delete(resourcePath);
    }
    # List user account issues assigned to the authenticated user
    #
    # + filter - Indicates which sorts of issues to return. `assigned` means issues assigned to you. `created` means issues created by you. `mentioned` means issues mentioning you. `subscribed` means issues you're subscribed to updates for. `all` or `repos` means all issues you can see, regardless of participation or creation.
    # + state - Indicates the state of the issues to return.
    # + labels - A list of comma separated label names. Example: `bug,ui,@high`
    # + sort - What to sort results by.
    # + direction - The direction to sort the results by.
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/issues("assigned"|"created"|"mentioned"|"subscribed"|"repos"|"all" filter = "assigned", "open"|"closed"|"all" state = "open", string? labels = (), "created"|"updated"|"comments" sort = "created", "asc"|"desc" direction = "desc", string? since = (), int per_page = 30, int page = 1) returns Issue[]|error? {
        string resourcePath = string `/user/issues`;
        map<anydata> queryParam = {"filter": filter, "state": state, "labels": labels, "sort": sort, "direction": direction, "since": since, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Issue[]? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List public SSH keys for the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/keys(int per_page = 30, int page = 1) returns Key[]|error {
        string resourcePath = string `/user/keys`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Key[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a public SSH key for the authenticated user
    #
    # + return - Response 
    resource isolated function post user/keys(User_keys_body payload) returns Key|error {
        string resourcePath = string `/user/keys`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Key response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a public SSH key for the authenticated user
    #
    # + key_id - The unique identifier of the key.
    # + return - Response 
    resource isolated function get user/keys/[int key_id]() returns Key|error {
        string resourcePath = string `/user/keys/${getEncodedUri(key_id)}`;
        Key response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a public SSH key for the authenticated user
    #
    # + key_id - The unique identifier of the key.
    # + return - Response 
    resource isolated function delete user/keys/[int key_id]() returns http:Response|error {
        string resourcePath = string `/user/keys/${getEncodedUri(key_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List subscriptions for the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/marketplace_purchases(int per_page = 30, int page = 1) returns UserMarketplacePurchase[]|error {
        string resourcePath = string `/user/marketplace_purchases`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        UserMarketplacePurchase[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List subscriptions for the authenticated user (stubbed)
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/marketplace_purchases/stubbed(int per_page = 30, int page = 1) returns UserMarketplacePurchase[]|error {
        string resourcePath = string `/user/marketplace_purchases/stubbed`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        UserMarketplacePurchase[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List organization memberships for the authenticated user
    #
    # + state - Indicates the state of the memberships to return. If not specified, the API returns both active and pending memberships.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/memberships/orgs("active"|"pending"? state = (), int per_page = 30, int page = 1) returns OrgMembership[]|error {
        string resourcePath = string `/user/memberships/orgs`;
        map<anydata> queryParam = {"state": state, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrgMembership[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get an organization membership for the authenticated user
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function get user/memberships/orgs/[string org]() returns OrgMembership|error {
        string resourcePath = string `/user/memberships/orgs/${getEncodedUri(org)}`;
        OrgMembership response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update an organization membership for the authenticated user
    #
    # + org - The organization name. The name is not case sensitive.
    # + return - Response 
    resource isolated function patch user/memberships/orgs/[string org](Orgs_org_body_1 payload) returns OrgMembership|error {
        string resourcePath = string `/user/memberships/orgs/${getEncodedUri(org)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        OrgMembership response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # List user migrations
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/migrations(int per_page = 30, int page = 1) returns Migration[]|error {
        string resourcePath = string `/user/migrations`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Migration[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Start a user migration
    #
    # + return - Response 
    resource isolated function post user/migrations(User_migrations_body payload) returns Migration|error {
        string resourcePath = string `/user/migrations`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Migration response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a user migration status
    #
    # + migration_id - The unique identifier of the migration.
    # + return - Response 
    resource isolated function get user/migrations/[int migration_id](string[]? exclude = ()) returns Migration|error {
        string resourcePath = string `/user/migrations/${getEncodedUri(migration_id)}`;
        map<anydata> queryParam = {"exclude": exclude};
        map<Encoding> queryParamEncoding = {"exclude": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Migration response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Download a user migration archive
    #
    # + migration_id - The unique identifier of the migration.
    # + return - Response 
    resource isolated function get user/migrations/[int migration_id]/archive() returns http:Response|error {
        string resourcePath = string `/user/migrations/${getEncodedUri(migration_id)}/archive`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a user migration archive
    #
    # + migration_id - The unique identifier of the migration.
    # + return - Response 
    resource isolated function delete user/migrations/[int migration_id]/archive() returns http:Response|error {
        string resourcePath = string `/user/migrations/${getEncodedUri(migration_id)}/archive`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Unlock a user repository
    #
    # + migration_id - The unique identifier of the migration.
    # + repo_name - repo_name parameter
    # + return - Response 
    resource isolated function delete user/migrations/[int migration_id]/repos/[string repo_name]/'lock() returns http:Response|error {
        string resourcePath = string `/user/migrations/${getEncodedUri(migration_id)}/repos/${getEncodedUri(repo_name)}/lock`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List repositories for a user migration
    #
    # + migration_id - The unique identifier of the migration.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/migrations/[int migration_id]/repositories(int per_page = 30, int page = 1) returns MinimalRepository[]|error {
        string resourcePath = string `/user/migrations/${getEncodedUri(migration_id)}/repositories`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepository[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List organizations for the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/orgs(int per_page = 30, int page = 1) returns OrganizationSimple[]|error {
        string resourcePath = string `/user/orgs`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrganizationSimple[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List packages for the authenticated user's namespace
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + visibility - The selected visibility of the packages.  This parameter is optional and only filters an existing result set.
    # The `internal` visibility is only supported for GitHub Packages registries that allow for granular permissions. For other ecosystems `internal` is synonymous with `private`.
    # For the list of GitHub Packages registries that support granular permissions, see "[About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages#granular-permissions-for-userorganization-scoped-packages)."
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get user/packages("npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type, "public"|"private"|"internal"? visibility = (), int page = 1, int per_page = 30) returns Package[]|error {
        string resourcePath = string `/user/packages`;
        map<anydata> queryParam = {"package_type": package_type, "visibility": visibility, "page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Package[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a package for the authenticated user
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + return - Response 
    resource isolated function get user/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]() returns Package|error {
        string resourcePath = string `/user/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}`;
        Package response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a package for the authenticated user
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + return - Response 
    resource isolated function delete user/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]() returns http:Response|error {
        string resourcePath = string `/user/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Restore a package for the authenticated user
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + token - package token
    # + return - Response 
    resource isolated function post user/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]/restore(string? token = ()) returns http:Response|error {
        string resourcePath = string `/user/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}/restore`;
        map<anydata> queryParam = {"token": token};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        http:Request request = new;
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List package versions for a package owned by the authenticated user
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + state - The state of the package, either active or deleted.
    # + return - Response 
    resource isolated function get user/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]/versions(int page = 1, int per_page = 30, "active"|"deleted" state = "active") returns PackageVersion[]|error {
        string resourcePath = string `/user/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}/versions`;
        map<anydata> queryParam = {"page": page, "per_page": per_page, "state": state};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        PackageVersion[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a package version for the authenticated user
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + package_version_id - Unique identifier of the package version.
    # + return - Response 
    resource isolated function get user/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]/versions/[int package_version_id]() returns PackageVersion|error {
        string resourcePath = string `/user/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}/versions/${getEncodedUri(package_version_id)}`;
        PackageVersion response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a package version for the authenticated user
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + package_version_id - Unique identifier of the package version.
    # + return - Response 
    resource isolated function delete user/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]/versions/[int package_version_id]() returns http:Response|error {
        string resourcePath = string `/user/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}/versions/${getEncodedUri(package_version_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Restore a package version for the authenticated user
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + package_version_id - Unique identifier of the package version.
    # + return - Response 
    resource isolated function post user/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]/versions/[int package_version_id]/restore() returns http:Response|error {
        string resourcePath = string `/user/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}/versions/${getEncodedUri(package_version_id)}/restore`;
        http:Request request = new;
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Create a user project
    #
    # + return - Response 
    resource isolated function post user/projects(User_projects_body payload) returns Project|error {
        string resourcePath = string `/user/projects`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Project response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List public email addresses for the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/public_emails(int per_page = 30, int page = 1) returns Email[]|error {
        string resourcePath = string `/user/public_emails`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Email[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List repositories for the authenticated user
    #
    # + visibility - Limit results to repositories with the specified visibility.
    # + affiliation - Comma-separated list of values. Can include:  
    # * `owner`: Repositories that are owned by the authenticated user.  
    # * `collaborator`: Repositories that the user has been added to as a collaborator.  
    # * `organization_member`: Repositories that the user has access to through being a member of an organization. This includes every repository on every team that the user is on.
    # + 'type - Limit results to repositories of the specified type. Will cause a `422` error if used in the same request as **visibility** or **affiliation**.
    # + sort - The property to sort the results by.
    # + direction - The order to sort by. Default: `asc` when using `full_name`, otherwise `desc`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + since - Only show repositories updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + before - Only show repositories updated before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + return - Response 
    resource isolated function get user/repos("all"|"public"|"private"? visibility = "all", string? affiliation = "owner,collaborator,organization_member", "all"|"owner"|"public"|"private"|"member"? 'type = "all", "created"|"updated"|"pushed"|"full_name"? sort = "full_name", "asc"|"desc"? direction = (), int per_page = 30, int page = 1, string? since = (), string? before = ()) returns Repository[]|error {
        string resourcePath = string `/user/repos`;
        map<anydata> queryParam = {"visibility": visibility, "affiliation": affiliation, "type": 'type, "sort": sort, "direction": direction, "per_page": per_page, "page": page, "since": since, "before": before};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Repository[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a repository for the authenticated user
    #
    # + return - Response 
    resource isolated function post user/repos(User_repos_body payload) returns Repository|error {
        string resourcePath = string `/user/repos`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Repository response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List repository invitations for the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/repository_invitations(int per_page = 30, int page = 1) returns RepositoryInvitation[]|error {
        string resourcePath = string `/user/repository_invitations`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        RepositoryInvitation[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Decline a repository invitation
    #
    # + invitation_id - The unique identifier of the invitation.
    # + return - Response 
    resource isolated function delete user/repository_invitations/[int invitation_id]() returns http:Response|error {
        string resourcePath = string `/user/repository_invitations/${getEncodedUri(invitation_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Accept a repository invitation
    #
    # + invitation_id - The unique identifier of the invitation.
    # + return - Response 
    resource isolated function patch user/repository_invitations/[int invitation_id]() returns error? {
        string resourcePath = string `/user/repository_invitations/${getEncodedUri(invitation_id)}`;
        http:Request request = new;
        return self.clientEp->patch(resourcePath, request);
    }
    # List social accounts for the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/social_accounts(int per_page = 30, int page = 1) returns SocialAccount[]|error {
        string resourcePath = string `/user/social_accounts`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SocialAccount[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add social accounts for the authenticated user
    #
    # + return - Response 
    resource isolated function post user/social_accounts(User_social_accounts_body payload) returns SocialAccount[]|error {
        string resourcePath = string `/user/social_accounts`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        SocialAccount[] response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete social accounts for the authenticated user
    #
    # + return - Response 
    resource isolated function delete user/social_accounts(User_social_accounts_body_1 payload) returns http:Response|error {
        string resourcePath = string `/user/social_accounts`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->delete(resourcePath, request);
        return response;
    }
    # List SSH signing keys for the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/ssh_signing_keys(int per_page = 30, int page = 1) returns SshSigningKey[]|error {
        string resourcePath = string `/user/ssh_signing_keys`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SshSigningKey[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a SSH signing key for the authenticated user
    #
    # + return - Response 
    resource isolated function post user/ssh_signing_keys(User_ssh_signing_keys_body payload) returns SshSigningKey|error {
        string resourcePath = string `/user/ssh_signing_keys`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        SshSigningKey response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get an SSH signing key for the authenticated user
    #
    # + ssh_signing_key_id - The unique identifier of the SSH signing key.
    # + return - Response 
    resource isolated function get user/ssh_signing_keys/[int ssh_signing_key_id]() returns SshSigningKey|error {
        string resourcePath = string `/user/ssh_signing_keys/${getEncodedUri(ssh_signing_key_id)}`;
        SshSigningKey response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete an SSH signing key for the authenticated user
    #
    # + ssh_signing_key_id - The unique identifier of the SSH signing key.
    # + return - Response 
    resource isolated function delete user/ssh_signing_keys/[int ssh_signing_key_id]() returns http:Response|error {
        string resourcePath = string `/user/ssh_signing_keys/${getEncodedUri(ssh_signing_key_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List repositories starred by the authenticated user
    #
    # + sort - The property to sort the results by. `created` means when the repository was starred. `updated` means when the repository was last pushed to.
    # + direction - The direction to sort the results by.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/starred("created"|"updated" sort = "created", "asc"|"desc" direction = "desc", int per_page = 30, int page = 1) returns Repository[]|error {
        string resourcePath = string `/user/starred`;
        map<anydata> queryParam = {"sort": sort, "direction": direction, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Repository[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Check if a repository is starred by the authenticated user
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response if this repository is starred by you 
    resource isolated function get user/starred/[string owner]/[string repo]() returns http:Response|error {
        string resourcePath = string `/user/starred/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Star a repository for the authenticated user
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function put user/starred/[string owner]/[string repo]() returns error? {
        string resourcePath = string `/user/starred/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        http:Request request = new;
        return self.clientEp->put(resourcePath, request);
    }
    # Unstar a repository for the authenticated user
    #
    # + owner - The account owner of the repository. The name is not case sensitive.
    # + repo - The name of the repository without the `.git` extension. The name is not case sensitive.
    # + return - Response 
    resource isolated function delete user/starred/[string owner]/[string repo]() returns http:Response|error {
        string resourcePath = string `/user/starred/${getEncodedUri(owner)}/${getEncodedUri(repo)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # List repositories watched by the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/subscriptions(int per_page = 30, int page = 1) returns MinimalRepository[]|error {
        string resourcePath = string `/user/subscriptions`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepository[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List teams for the authenticated user
    #
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get user/teams(int per_page = 30, int page = 1) returns TeamFull[]|error {
        string resourcePath = string `/user/teams`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        TeamFull[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List users
    #
    # + since - A user ID. Only return users with an ID greater than this ID.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get users(int? since = (), int per_page = 30) returns SimpleUser[]|error? {
        string resourcePath = string `/users`;
        map<anydata> queryParam = {"since": since, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleUser[]? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a user
    #
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function get users/[string username]() returns UserResponse|error {
        string resourcePath = string `/users/${getEncodedUri(username)}`;
        UserResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get list of conflicting packages during Docker migration for user
    #
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function get users/[string username]/docker/conflicts() returns Package[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/docker/conflicts`;
        Package[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List events for the authenticated user
    #
    # + username - The handle for the GitHub user account.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/events(int per_page = 30, int page = 1) returns Event[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/events`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Event[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List organization events for the authenticated user
    #
    # + username - The handle for the GitHub user account.
    # + org - The organization name. The name is not case sensitive.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/events/orgs/[string org](int per_page = 30, int page = 1) returns Event[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/events/orgs/${getEncodedUri(org)}`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Event[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List public events for a user
    #
    # + username - The handle for the GitHub user account.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/events/'public(int per_page = 30, int page = 1) returns Event[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/events/public`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Event[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List followers of a user
    #
    # + username - The handle for the GitHub user account.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/followers(int per_page = 30, int page = 1) returns SimpleUser[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/followers`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleUser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List the people a user follows
    #
    # + username - The handle for the GitHub user account.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/following(int per_page = 30, int page = 1) returns SimpleUser[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/following`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SimpleUser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Check if a user follows another user
    #
    # + username - The handle for the GitHub user account.
    # + return - if the user follows the target user 
    resource isolated function get users/[string username]/following/[string target_user]() returns http:Response|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/following/${getEncodedUri(target_user)}`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List gists for a user
    #
    # + username - The handle for the GitHub user account.
    # + since - Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/gists(string? since = (), int per_page = 30, int page = 1) returns BaseGist[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/gists`;
        map<anydata> queryParam = {"since": since, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        BaseGist[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List GPG keys for a user
    #
    # + username - The handle for the GitHub user account.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/gpg_keys(int per_page = 30, int page = 1) returns GpgKey[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/gpg_keys`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        GpgKey[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get contextual information for a user
    #
    # + username - The handle for the GitHub user account.
    # + subject_type - Identifies which additional information you'd like to receive about the person's hovercard. Can be `organization`, `repository`, `issue`, `pull_request`. **Required** when using `subject_id`.
    # + subject_id - Uses the ID for the `subject_type` you specified. **Required** when using `subject_type`.
    # + return - Response 
    resource isolated function get users/[string username]/hovercard("organization"|"repository"|"issue"|"pull_request"? subject_type = (), string? subject_id = ()) returns Hovercard|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/hovercard`;
        map<anydata> queryParam = {"subject_type": subject_type, "subject_id": subject_id};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Hovercard response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a user installation for the authenticated app
    #
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function get users/[string username]/installation() returns Installation|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/installation`;
        Installation response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List public keys for a user
    #
    # + username - The handle for the GitHub user account.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/keys(int per_page = 30, int page = 1) returns KeySimple[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/keys`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        KeySimple[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List organizations for a user
    #
    # + username - The handle for the GitHub user account.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/orgs(int per_page = 30, int page = 1) returns OrganizationSimple[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/orgs`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrganizationSimple[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List packages for a user
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + visibility - The selected visibility of the packages.  This parameter is optional and only filters an existing result set.
    # The `internal` visibility is only supported for GitHub Packages registries that allow for granular permissions. For other ecosystems `internal` is synonymous with `private`.
    # For the list of GitHub Packages registries that support granular permissions, see "[About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages#granular-permissions-for-userorganization-scoped-packages)."
    # + username - The handle for the GitHub user account.
    # + page - Page number of the results to fetch.
    # + per_page - The number of results per page (max 100).
    # + return - Response 
    resource isolated function get users/[string username]/packages("npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type, "public"|"private"|"internal"? visibility = (), int page = 1, int per_page = 30) returns Package[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages`;
        map<anydata> queryParam = {"package_type": package_type, "visibility": visibility, "page": page, "per_page": per_page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Package[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a package for a user
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function get users/[string username]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]() returns Package|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}`;
        Package response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a package for a user
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function delete users/[string username]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]() returns http:Response|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Restore a package for a user
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + username - The handle for the GitHub user account.
    # + token - package token
    # + return - Response 
    resource isolated function post users/[string username]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]/restore(string? token = ()) returns http:Response|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}/restore`;
        map<anydata> queryParam = {"token": token};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        http:Request request = new;
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List package versions for a package owned by a user
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function get users/[string username]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]/versions() returns PackageVersion[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}/versions`;
        PackageVersion[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a package version for a user
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + package_version_id - Unique identifier of the package version.
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function get users/[string username]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]/versions/[int package_version_id]() returns PackageVersion|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}/versions/${getEncodedUri(package_version_id)}`;
        PackageVersion response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete package version for a user
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + username - The handle for the GitHub user account.
    # + package_version_id - Unique identifier of the package version.
    # + return - Response 
    resource isolated function delete users/[string username]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]/versions/[int package_version_id]() returns http:Response|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}/versions/${getEncodedUri(package_version_id)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Restore package version for a user
    #
    # + package_type - The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    # + package_name - The name of the package.
    # + username - The handle for the GitHub user account.
    # + package_version_id - Unique identifier of the package version.
    # + return - Response 
    resource isolated function post users/[string username]/packages/["npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type]/[string package_name]/versions/[int package_version_id]/restore() returns http:Response|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/packages/${getEncodedUri(package_type)}/${getEncodedUri(package_name)}/versions/${getEncodedUri(package_version_id)}/restore`;
        http:Request request = new;
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List user projects
    #
    # + username - The handle for the GitHub user account.
    # + state - Indicates the state of the projects to return.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/projects("open"|"closed"|"all" state = "open", int per_page = 30, int page = 1) returns Project[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/projects`;
        map<anydata> queryParam = {"state": state, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Project[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List events received by the authenticated user
    #
    # + username - The handle for the GitHub user account.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/received_events(int per_page = 30, int page = 1) returns Event[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/received_events`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Event[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List public events received by a user
    #
    # + username - The handle for the GitHub user account.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/received_events/'public(int per_page = 30, int page = 1) returns Event[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/received_events/public`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Event[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List repositories for a user
    #
    # + username - The handle for the GitHub user account.
    # + 'type - Limit results to repositories of the specified type.
    # + sort - The property to sort the results by.
    # + direction - The order to sort by. Default: `asc` when using `full_name`, otherwise `desc`.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/repos("all"|"owner"|"member" 'type = "owner", "created"|"updated"|"pushed"|"full_name" sort = "full_name", "asc"|"desc"? direction = (), int per_page = 30, int page = 1) returns MinimalRepository[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/repos`;
        map<anydata> queryParam = {"type": 'type, "sort": sort, "direction": direction, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepository[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get GitHub Actions billing for a user
    #
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function get users/[string username]/settings/billing/actions() returns ActionsBillingUsage|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/settings/billing/actions`;
        ActionsBillingUsage response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get GitHub Packages billing for a user
    #
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function get users/[string username]/settings/billing/packages() returns PackagesBillingUsage|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/settings/billing/packages`;
        PackagesBillingUsage response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get shared storage billing for a user
    #
    # + username - The handle for the GitHub user account.
    # + return - Response 
    resource isolated function get users/[string username]/settings/billing/shared\-storage() returns CombinedBillingUsage|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/settings/billing/shared-storage`;
        CombinedBillingUsage response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List social accounts for a user
    #
    # + username - The handle for the GitHub user account.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/social_accounts(int per_page = 30, int page = 1) returns SocialAccount[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/social_accounts`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SocialAccount[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List SSH signing keys for a user
    #
    # + username - The handle for the GitHub user account.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/ssh_signing_keys(int per_page = 30, int page = 1) returns SshSigningKey[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/ssh_signing_keys`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SshSigningKey[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List repositories starred by a user
    #
    # + username - The handle for the GitHub user account.
    # + sort - The property to sort the results by. `created` means when the repository was starred. `updated` means when the repository was last pushed to.
    # + direction - The direction to sort the results by.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/starred("created"|"updated" sort = "created", "asc"|"desc" direction = "desc", int per_page = 30, int page = 1) returns StarredRepositoryResponse|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/starred`;
        map<anydata> queryParam = {"sort": sort, "direction": direction, "per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        StarredRepositoryResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List repositories watched by a user
    #
    # + username - The handle for the GitHub user account.
    # + per_page - The number of results per page (max 100).
    # + page - Page number of the results to fetch.
    # + return - Response 
    resource isolated function get users/[string username]/subscriptions(int per_page = 30, int page = 1) returns MinimalRepository[]|error {
        string resourcePath = string `/users/${getEncodedUri(username)}/subscriptions`;
        map<anydata> queryParam = {"per_page": per_page, "page": page};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MinimalRepository[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get all API versions
    #
    # + return - Response 
    resource isolated function get versions() returns string[]|error {
        string resourcePath = string `/versions`;
        string[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get the Zen of GitHub
    #
    # + return - Response 
    resource isolated function get zen() returns string|error {
        string resourcePath = string `/zen`;
        string response = check self.clientEp->get(resourcePath);
        return response;
    }
}
