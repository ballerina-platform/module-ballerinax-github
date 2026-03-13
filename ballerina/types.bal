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

import ballerina/constraint;
import ballerina/data.jsondata;
import ballerina/http;

public type ReposownerrepobranchesbranchprotectionrestrictionsappsreposownerrepobranchesbranchprotectionrestrictionsappsOneOf12 string[];

public type SecurityAndAnalysis record {
    # Settings for secret scanning push protection on the repository.
    @jsondata:Name {value: "secret_scanning_push_protection"}
    SecurityAndAnalysisSecretScanningPushProtection secretScanningPushProtection?;
    # Settings for Dependabot security updates on the repository.
    @jsondata:Name {value: "dependabot_security_updates"}
    SecurityAndAnalysisDependabotSecurityUpdates dependabotSecurityUpdates?;
    # Settings for secret scanning on the repository.
    @jsondata:Name {value: "secret_scanning"}
    SecurityAndAnalysisSecretScanningPushProtection secretScanning?;
    # Settings for GitHub Advanced Security on the repository.
    @jsondata:Name {value: "advanced_security"}
    SecurityAndAnalysisAdvancedSecurity advancedSecurity?;
};

# Authentication Token
public type AuthenticationToken record {
    # Describe whether all repositories have been selected or there's a selection involved
    @jsondata:Name {value: "repository_selection"}
    "all"|"selected" repositorySelection?;
    # The single file path this token grants access to.
    @jsondata:Name {value: "single_file"}
    string? singleFile?;
    # The time this token expires
    @jsondata:Name {value: "expires_at"}
    string expiresAt;
    # The repositories this token has access to
    Repository[] repositories?;
    # The permissions granted to this authentication token.
    record {} permissions?;
    # The token used for authentication
    string token;
};

public type TeamPermissions record {
    # Whether the team has pull (read) access to the repository.
    boolean pull;
    # Whether the team has maintain access to the repository.
    boolean maintain;
    # Whether the team has admin access to the repository.
    boolean admin;
    # Whether the team has triage access to the repository.
    boolean triage;
    # Whether the team has push (write) access to the repository.
    boolean push;
};

public type DependencyGraphSpdxSbomSbomCreationInfo record {
    # The date and time the SPDX document was created
    string created;
    # The tools that were used to generate the SPDX document
    string[] creators;
};

# Code Search Result Item
public type CodeSearchResultItem record {
    # Line numbers in the file where the search match was found.
    @jsondata:Name {value: "line_numbers"}
    string[] lineNumbers?;
    # The programming language of the file.
    string? language?;
    # The repository containing the matched file.
    MinimalRepository repository;
    # The SHA hash of the file blob.
    string sha;
    # The API URL for this file.
    string url;
    # The size of the file in bytes.
    @jsondata:Name {value: "file_size"}
    int fileSize?;
    # The timestamp when the file was last modified.
    @jsondata:Name {value: "last_modified_at"}
    string lastModifiedAt?;
    # The path to the file within the repository.
    string path;
    # The relevance score of this search result.
    decimal score;
    # The HTML URL to view the file on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Text fragments showing where the search terms matched.
    @jsondata:Name {value: "text_matches"}
    SearchResultTextMatches textMatches?;
    # The name of the file.
    string name;
    # The Git API URL for the file blob.
    @jsondata:Name {value: "git_url"}
    string gitUrl;
};

public type LabelsOneOf1 string;

# Represents the Queries record for the operation: reactions/list-for-issue
public type ReactionsListForIssueQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to an issue
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content?;
};

public type TopicSearchResultItemTopicRelation record {
    # The name of the related topic.
    string name?;
    # The unique identifier of the topic relation.
    int id?;
    # The unique identifier of the related topic.
    @jsondata:Name {value: "topic_id"}
    int topicId?;
    # The type of relationship between topics.
    @jsondata:Name {value: "relation_type"}
    string relationType?;
};

# Minimal Repository
public type MinimalRepositoryResponse record {
    # The list of minimal repository objects returned.
    MinimalRepository[] repositories;
    # The total number of repositories in the response.
    @jsondata:Name {value: "total_count"}
    int totalCount;
};

# Information about the seat breakdown and policies set for an organization with a Copilot for Business subscription
public type CopilotOrganizationDetails record {
    # Breakdown of Copilot seat usage across the organization.
    CopilotSeatBreakdown seat_breakdown;
    # The organization policy for allowing or disallowing Copilot to make suggestions that match public code.
    "allow"|"block"|"unconfigured"|"unknown" public_code_suggestions;
    # The organization policy for allowing or disallowing organization members to use Copilot Chat within their editor.
    "enabled"|"disabled"|"unconfigured" copilot_chat?;
    # The mode of assigning new seats.
    "assign_all"|"assign_selected"|"disabled"|"unconfigured" seat_management_setting;
};

public type StarredRepositoryResponseStarredRepositoryResponseAnyOf12 Repository[];

# Removed from Project Issue Event
public type RemovedFromProjectIssueEvent record {
    # The user who triggered the removed-from-project event.
    SimpleUser actor;
    # The API URL of the commit associated with this event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The GitHub App that performed this event, if any.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The timestamp when this event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of this issue event.
    int id;
    # The type of event that occurred on the issue.
    string event;
    # The SHA of the commit associated with this event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # The API URL for this issue event.
    string url;
    # The project card from which the issue was removed.
    @jsondata:Name {value: "project_card"}
    RemovedFromProjectIssueEventProjectCard projectCard?;
    # The global node ID of this issue event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# A GitHub App that is providing a custom deployment protection rule
public type CustomDeploymentRuleApp record {
    # The URL for the endpoint to get details about the app
    @jsondata:Name {value: "integration_url"}
    string integrationUrl;
    # The unique identifier of the deployment protection rule integration
    int id;
    # The slugified name of the deployment protection rule integration
    string slug;
    # The node ID for the deployment protection rule integration
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type UsercodespacessecretssecretNameSelectedRepositoryIds SelectedRepositoryIdsAnyOf1|SelectedRepositoryIdsSelectedRepositoryIdsAnyOf12;

# The status of a commit
public type Status record {
    # The user who created this commit status.
    NullableSimpleUser? creator;
    # The avatar URL of the status creator.
    @jsondata:Name {value: "avatar_url"}
    string? avatarUrl;
    # The timestamp when this status was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The URL associated with this status for details.
    @jsondata:Name {value: "target_url"}
    string? targetUrl;
    # A label identifying the service that set this status.
    string context;
    # A short description of the status.
    string? description;
    # The timestamp when this status was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of this commit status.
    int id;
    # The state of the commit status (e.g., success, failure).
    string state;
    # The API URL for this commit status.
    string url;
    # The global node ID of this commit status.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Api Overview
public type ApiOverview record {
    # SSH key fingerprints used to verify GitHub's host keys.
    @jsondata:Name {value: "ssh_key_fingerprints"}
    ApiOverviewSshKeyFingerprints sshKeyFingerprints?;
    # IP ranges used by GitHub's source importer service.
    string[] importer?;
    # Indicates whether password authentication is verifiable.
    @jsondata:Name {value: "verifiable_password_authentication"}
    boolean verifiablePasswordAuthentication;
    # Domain names used by various GitHub services.
    ApiOverviewDomains domains?;
    # IP ranges used by GitHub Packages.
    string[] packages?;
    # IP ranges used by the GitHub Enterprise importer.
    @jsondata:Name {value: "github_enterprise_importer"}
    string[] githubEnterpriseImporter?;
    # Public SSH keys used by GitHub.
    @jsondata:Name {value: "ssh_keys"}
    string[] sshKeys?;
    # IP ranges used for Git operations on GitHub.
    string[] git?;
    # IP ranges used by GitHub Pages.
    string[] pages?;
    # IP ranges used by GitHub's web interface.
    string[] web?;
    # IP ranges used by GitHub's API.
    string[] api?;
    # IP ranges used by GitHub webhooks.
    string[] hooks?;
    # IP ranges used by GitHub Actions.
    string[] actions?;
    # IP ranges used by Dependabot.
    string[] dependabot?;
};

# Represents the Queries record for the operation: activity/list-watchers-for-repo
public type ActivityListWatchersForRepoQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type BillingSelectedUsersBody record {
    # The usernames of the organization members to be granted access to GitHub Copilot
    @jsondata:Name {value: "selected_usernames"}
    string[] selectedUsernames;
};

public type UserKeysBody record {
    # A descriptive name for the new key
    string title?;
    # The public SSH key to add to your GitHub account
    @constraint:String {pattern: re `^ssh-(rsa|dss|ed25519) |^ecdsa-sha2-nistp(256|384|521) `}
    string 'key;
};

# Review Requested Issue Event
public type ReviewRequestedIssueEvent record {
    # The user who requested the review.
    SimpleUser actor;
    # The API URL of the commit associated with this event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The team requested to review the pull request.
    @jsondata:Name {value: "requested_team"}
    Team requestedTeam?;
    # The GitHub App that performed this event, if any.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The user who made the review request.
    @jsondata:Name {value: "review_requester"}
    SimpleUser reviewRequester;
    # The timestamp when this event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The user requested to review the pull request.
    @jsondata:Name {value: "requested_reviewer"}
    SimpleUser requestedReviewer?;
    # The unique identifier of this issue event.
    int id;
    # The type of event that occurred on the issue.
    string event;
    # The SHA of the commit associated with this event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # The API URL for this issue event.
    string url;
    # The global node ID of this issue event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type UseremailsuseremailsOneOf112 string[];

public type RepositoryRulesetConditionsRepositoryNameTargetRepositoryName record {
    # Array of repository names or patterns to include. One of these patterns must match for the condition to pass. Also accepts ~ALL to include all repositories
    string[] include?;
    # Whether renaming of target repositories is prevented
    boolean protected?;
    # Array of repository names or patterns to exclude. The condition will not pass if any of these patterns match
    string[] exclude?;
};

# Represents the Queries record for the operation: repos/get-org-rule-suites
public type ReposGetOrgRuleSuitesQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The handle for the GitHub user account to filter on. When specified, only rule evaluations triggered by this actor will be returned
    @http:Query {name: "actor_name"}
    string actorName?;
    # Page number of the results to fetch
    int page = 1;
    # The name of the repository to filter on. When specified, only rule evaluations from this repository will be returned
    @http:Query {name: "repository_name"}
    int repositoryName?;
    # The time period to filter by.
    # 
    # For example, day will filter for rule suites that occurred in the past 24 hours, and week will filter for insights that occurred in the past 7 days (168 hours)
    @http:Query {name: "time_period"}
    "hour"|"day"|"week"|"month" timePeriod = "day";
    # The rule results to filter on. When specified, only suites with this result will be returned
    @http:Query {name: "rule_suite_result"}
    "pass"|"fail"|"bypass"|"all" ruleSuiteResult = "all";
};

public type RateLimitOverviewResources record {
    # Rate limit information for core API requests.
    RateLimit core;
    # Rate limit information for SCIM API requests.
    RateLimit scim?;
    # Rate limit information for search API requests.
    RateLimit search;
    # Rate limit information for source import API requests.
    @jsondata:Name {value: "source_import"}
    RateLimit sourceImport?;
    # Rate limit information for Actions runner registration requests.
    @jsondata:Name {value: "actions_runner_registration"}
    RateLimit actionsRunnerRegistration?;
    # Rate limit information for GraphQL API requests.
    RateLimit graphql?;
    # Rate limit information for code scanning upload requests.
    @jsondata:Name {value: "code_scanning_upload"}
    RateLimit codeScanningUpload?;
    # Rate limit information for integration manifest API requests.
    @jsondata:Name {value: "integration_manifest"}
    RateLimit integrationManifest?;
    # Rate limit information for code search API requests.
    @jsondata:Name {value: "code_search"}
    RateLimit codeSearch?;
    # Rate limit information for dependency snapshot API requests.
    @jsondata:Name {value: "dependency_snapshots"}
    RateLimit dependencySnapshots?;
};

# Represents the Queries record for the operation: activity/list-received-events-for-user
public type ActivityListReceivedEventsForUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# A GitHub repository view for Classroom
public type SimpleClassroomRepository record {
    # Whether the repository is private
    boolean 'private;
    # The full, globally unique name of the repository
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The URL to view the repository on GitHub.com
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The default branch for the repository
    @jsondata:Name {value: "default_branch"}
    string defaultBranch;
    # A unique identifier of the repository
    int id;
    # The GraphQL identifier of the repository
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents the Queries record for the operation: orgs/list-pat-grant-requests
public type OrgsListPatGrantRequestsQueries record {
    # A list of owner usernames to use to filter the results
    @constraint:Array {maxLength: 10}
    string[] owner?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Only show fine-grained personal access tokens used before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    @http:Query {name: "last_used_before"}
    string lastUsedBefore?;
    # Only show fine-grained personal access tokens used after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    @http:Query {name: "last_used_after"}
    string lastUsedAfter?;
    # The permission to use to filter the results
    string permission?;
    # Page number of the results to fetch
    int page = 1;
    # The property by which to sort the results
    "created_at" sort = "created_at";
    # The name of the repository to use to filter the results
    string repository?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# User Search Result Item
public type UserSearchResultItemResponse record {
    # The total number of users matching the search query.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # Indicates whether the search results may be incomplete.
    @jsondata:Name {value: "incomplete_results"}
    boolean incompleteResults;
    # The list of user search result items.
    UserSearchResultItem[] items;
};

public type RepoCheckSuitesBody record {
    # The sha of the head commit
    @jsondata:Name {value: "head_sha"}
    string headSha;
};

# An artifact
public type ArtifactResponse record {
    # The total number of artifacts available.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of artifact objects returned.
    Artifact[] artifacts;
};

@constraint:Array {minLength: 1}
public type ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf11234 ReposownerrepoissuesissueNumberlabelsLabels[];

# The name of the status checks
public type ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsreposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf112 string[];

public type RepositoryAdvisoryCreateVulnerabilities record {|
    # The package affected by this vulnerability.
    RepositoryAdvisoryCreatePackage package;
    # The functions in the package that are affected
    @jsondata:Name {value: "vulnerable_functions"}
    string[]? vulnerableFunctions?;
    # The range of the package versions affected by the vulnerability
    @jsondata:Name {value: "vulnerable_version_range"}
    string? vulnerableVersionRange?;
    # The package version(s) that resolve the vulnerability
    @jsondata:Name {value: "patched_versions"}
    string? patchedVersions?;
|};

public type RepoPullsBody record {
    # The name of the branch where your changes are implemented. For cross-repository pull requests in the same network, namespace head with a user like this: username:branch
    string head;
    # An issue in the repository to convert to a pull request. The issue title, body, and comments will become the title, body, and comments on the new pull request. Required unless title is specified
    int issue?;
    # The name of the repository where the changes in the pull request were made. This field is required for cross-repository pull requests if both repositories are owned by the same organization
    @jsondata:Name {value: "head_repo"}
    string headRepo?;
    # Indicates whether the pull request is a draft. See "[Draft Pull Requests](https://docs.github.com/articles/about-pull-requests#draft-pull-requests)" in the GitHub Help documentation to learn more
    boolean draft?;
    # Indicates whether [maintainers can modify](https://docs.github.com/articles/allowing-changes-to-a-pull-request-branch-created-from-a-fork/) the pull request
    @jsondata:Name {value: "maintainer_can_modify"}
    boolean maintainerCanModify?;
    # The title of the new pull request. Required unless issue is specified
    string title?;
    # The contents of the pull request
    string body?;
    # The name of the branch you want the changes pulled into. This should be an existing branch on the current repository. You cannot submit a pull request to one repository that requests a merge to a base of another repository
    string base;
};

# Code of Conduct Simple
public type NullableCodeOfConductSimple record {
    # The HTML URL to view the code of conduct on GitHub.
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    # The name of the code of conduct.
    string name;
    # The API URL for this code of conduct.
    string url;
    # The unique key identifying this code of conduct.
    string 'key;
};

# Key/value pairs to provide settings for this webhook
public type ReposownerrepohooksConfig record {
    # The media type used to serialize payloads sent to this webhook.
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    # Determines whether SSL verification is performed for webhook deliveries.
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    # The digest algorithm used to sign webhook payloads.
    string digest?;
    # The secret used to sign webhook payloads for verification.
    WebhookConfigSecret secret?;
    # The URL to which webhook payloads will be delivered.
    WebhookConfigUrl url?;
    # The token used for authentication with the webhook endpoint.
    string token?;
};

# View Traffic
public type ViewTraffic record {
    # The total number of views for the repository.
    int count;
    # The number of unique visitors who viewed the repository.
    int uniques;
    # A list of daily view traffic breakdown objects.
    Traffic[] views;
};

# Represents the Queries record for the operation: dependabot/list-alerts-for-enterprise
public type DependabotListAlertsForEnterpriseQueries record {
    # A comma-separated list of severities. If specified, only alerts with these severities will be returned.
    # 
    # Can be: low, medium, high, critical
    string severity?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # A comma-separated list of package names. If specified, only alerts for these packages will be returned
    string package?;
    # A comma-separated list of ecosystems. If specified, only alerts for these ecosystems will be returned.
    # 
    # Can be: composer, go, maven, npm, nuget, pip, pub, rubygems, rust
    string ecosystem?;
    # **Deprecated**. The number of results per page (max 100), starting from the last matching result.
    # This parameter must not be used in combination with first.
    # Instead, use per_page in combination with before to fetch the last page of results
    @constraint:Int {minValue: 1, maxValue: 100}
    int last?;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor
    string before?;
    # The scope of the vulnerable dependency. If specified, only alerts with this scope will be returned
    "development"|"runtime" scope?;
    # A comma-separated list of states. If specified, only alerts with these states will be returned.
    # 
    # Can be: auto_dismissed, dismissed, fixed, open
    string state?;
    # The property by which to sort the results.
    # created means when the alert was created.
    # updated means when the alert's state last changed
    "created"|"updated" sort = "created";
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor
    string after?;
    # **Deprecated**. The number of results per page (max 100), starting from the first matching result.
    # This parameter must not be used in combination with last.
    # Instead, use per_page in combination with after to fetch the first page of results
    @constraint:Int {minValue: 1, maxValue: 100}
    int first = 30;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# Represents the Queries record for the operation: meta/get-octocat
public type MetaGetOctocatQueries record {
    # The words to show in Octocat's speech bubble
    string s?;
};

# A description of the machine powering a codespace
public type CodespaceMachineResponse record {
    # The total number of available codespace machines.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of machine types available for codeapces.
    CodespaceMachine[] machines;
};

# Commit Comparison
public type CommitComparison record {
    # The base commit used as the starting point for comparison.
    @jsondata:Name {value: "base_commit"}
    Commit baseCommit;
    # Number of commits the head is behind the base.
    @jsondata:Name {value: "behind_by"}
    int behindBy;
    # The URL to view the diff between the two commits.
    @jsondata:Name {value: "diff_url"}
    string diffUrl;
    # Number of commits the head is ahead of the base.
    @jsondata:Name {value: "ahead_by"}
    int aheadBy;
    # The common ancestor commit of the two compared commits.
    @jsondata:Name {value: "merge_base_commit"}
    Commit mergeBaseCommit;
    # The API URL for this commit comparison.
    string url;
    # The total number of commits between the two references.
    @jsondata:Name {value: "total_commits"}
    int totalCommits;
    # The URL to download the patch for this comparison.
    @jsondata:Name {value: "patch_url"}
    string patchUrl;
    # The HTML URL to view the comparison on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The list of commits between the base and head.
    Commit[] commits;
    # The list of files changed between the two commits.
    DiffEntry[] files?;
    # The permanent URL for this commit comparison.
    @jsondata:Name {value: "permalink_url"}
    string permalinkUrl;
    # The relationship status between the base and head commits.
    "diverged"|"ahead"|"behind"|"identical" status;
};

# Represents the Queries record for the operation: users/list-ssh-signing-keys-for-authenticated-user
public type UsersListSshSigningKeysForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type ContentDirectoryInner record {
    # The path to the content item within the repository.
    string path;
    # The size of the content item in bytes.
    int size;
    # Hypermedia links related to this content item.
    @jsondata:Name {value: "_links"}
    ContentDirectoryInnerLinks links;
    # The HTML URL to view this content item on GitHub.
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    # The name of the file or directory.
    string name;
    # The URL to download the raw content of the file.
    @jsondata:Name {value: "download_url"}
    string? downloadUrl;
    # The type of content item (file, dir, symlink, or submodule).
    "dir"|"file"|"submodule"|"symlink" 'type;
    # The Git API URL for this content item's blob or tree.
    @jsondata:Name {value: "git_url"}
    string? gitUrl;
    # The SHA hash of this content item.
    string sha;
    # The Base64-encoded content of the file, if applicable.
    string content?;
    # The API URL for this content item.
    string url;
};

# Details of a deployment branch or tag policy
public type DeploymentBranchPolicy record {
    # The name pattern that branches or tags must match in order to deploy to the environment
    string name?;
    # The unique identifier of the branch or tag policy
    int id?;
    # Whether this rule targets a branch or tag
    "branch"|"tag" 'type?;
    # The global node ID of the deployment branch or tag policy.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# A team's access to a project
public type TeamProject record {
    # The API URL to list the project's columns.
    @jsondata:Name {value: "columns_url"}
    string columnsUrl;
    # The user who created this project.
    SimpleUser creator;
    # Whether the project is private or not. Only present when owner is an organization
    boolean 'private?;
    # The organization permission for this project. Only present when owner is an organization
    @jsondata:Name {value: "organization_permission"}
    string organizationPermission?;
    # The timestamp when this project was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The description or body text of the project.
    string? body;
    # The API URL for this project.
    string url;
    # The API URL of the project's owner.
    @jsondata:Name {value: "owner_url"}
    string ownerUrl;
    # The project number within the owner's namespace.
    int number;
    # The timestamp when this project was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The team's permissions for this project.
    TeamProjectPermissions permissions;
    # The HTML URL to view this project on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The name of the project.
    string name;
    # The unique identifier of this project.
    int id;
    # The current state of the project (open or closed).
    string state;
    # The global node ID of this project.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents the Queries record for the operation: repos/list-commits
public type ReposListCommitsQueries record {
    # Only commits containing this file path will be returned
    string path?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # GitHub username or email address to use to filter by commit committer
    string committer?;
    # GitHub username or email address to use to filter by commit author
    string author?;
    # Only commits before this date will be returned. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string until?;
    # Page number of the results to fetch
    int page = 1;
    # SHA or branch to start listing commits from. Default: the repository’s default branch (usually main)
    string sha?;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

public type ReviewsreviewIdBody record {
    # The body text of the pull request review
    string body;
};

# The head branch of the pull request
public type PullRequestSimpleHead record {
    # The branch name of the head ref.
    string ref;
    # The repository containing the head branch.
    Repository repo;
    # The label identifying the head in user:branch format.
    string label;
    # The SHA of the head commit.
    string sha;
    # The user associated with the head branch.
    NullableSimpleUser? user;
};

# Marketplace Listing Plan
public type MarketplaceListingPlan record {
    # Indicates whether this plan offers a free trial period.
    @jsondata:Name {value: "has_free_trial"}
    boolean hasFreeTrial;
    # The API URL to list accounts subscribed to this plan.
    @jsondata:Name {value: "accounts_url"}
    string accountsUrl;
    # A description of the Marketplace listing plan.
    string description;
    # The API URL for this Marketplace listing plan.
    string url;
    # The name of the unit for per-unit pricing plans.
    @jsondata:Name {value: "unit_name"}
    string? unitName;
    # The unique plan number for this Marketplace listing.
    int number;
    # The yearly price of the plan in US cents.
    @jsondata:Name {value: "yearly_price_in_cents"}
    int yearlyPriceInCents;
    # The name of the Marketplace listing plan.
    string name;
    # The unique identifier of this Marketplace listing plan.
    int id;
    # The monthly price of the plan in US cents.
    @jsondata:Name {value: "monthly_price_in_cents"}
    int monthlyPriceInCents;
    # The current state of the Marketplace listing plan.
    string state;
    # The pricing model used for this plan (FREE, FLAT_RATE, or PER_UNIT).
    @jsondata:Name {value: "price_model"}
    "FREE"|"FLAT_RATE"|"PER_UNIT" priceModel;
    # A list of feature bullet points describing this plan.
    string[] bullets;
};

public type RepositoryRulesetLinks record {
    # The API link to this ruleset resource.
    RepositoryRulesetLinksSelf self?;
    # The HTML link to view this ruleset on GitHub.
    RepositoryRulesetLinksHtml html?;
};

# Represents the Queries record for the operation: activity/list-public-events
public type ActivityListPublicEventsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type RepositoryAdvisoryCredits record {
    # The username of the user credited
    string login?;
    # The type of credit assigned to the credited user.
    SecurityAdvisoryCreditTypes 'type?;
};

# Represents the Queries record for the operation: users/list-blocked-by-authenticated-user
public type UsersListBlockedByAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Allow specific users, teams, or apps to bypass pull request requirements
public type ReposownerrepobranchesbranchprotectionRequiredPullRequestReviewsBypassPullRequestAllowances record {
    # The list of team slugs allowed to bypass pull request requirements
    string[] teams?;
    # The list of user logins allowed to bypass pull request requirements
    string[] users?;
    # The list of app slugs allowed to bypass pull request requirements
    string[] apps?;
};

# Represents the Queries record for the operation: repos/list-public
public type ReposListPublicQueries record {
    # A repository ID. Only return repositories with an ID greater than this ID
    int since?;
};

public type IssueSearchResultItemPullRequest record {
    # The URL to download the patch for this pull request.
    @jsondata:Name {value: "patch_url"}
    string? patchUrl;
    # The timestamp when this pull request was merged.
    @jsondata:Name {value: "merged_at"}
    string? mergedAt?;
    # The HTML URL to view this pull request on GitHub.
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    # The URL to view the diff for this pull request.
    @jsondata:Name {value: "diff_url"}
    string? diffUrl;
    # The API URL for this pull request.
    string? url;
};

# Represents the Queries record for the operation: actions/list-repo-organization-secrets
public type ActionsListRepoOrganizationSecretsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Full Repository
public type FullRepository record {
    # The parent repository, if this repository is a fork.
    Repository parent?;
    # Whether forking is allowed on the repository
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking?;
    # Whether anonymous git access is allowed
    @jsondata:Name {value: "anonymous_access_enabled"}
    boolean anonymousAccessEnabled = true;
    # API URL for the authenticated user's subscription to the repository
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    # API URL template for listing repository branches
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    # API URL template for accessing issue comments
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    # Whether rebase merging is allowed on pull requests
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge?;
    # API URL for listing repository watchers
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    # The permissions the authenticated user has on this repository.
    FullRepositoryPermissions permissions?;
    # A temporary token for cloning the repository
    @jsondata:Name {value: "temp_clone_token"}
    string? tempCloneToken?;
    # API URL template for listing repository releases
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    # The default value for a squash merge commit message:
    # 
    # - PR_BODY - default to the pull request's body.
    # - COMMIT_MESSAGES - default to the branch's commit messages.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "squash_merge_commit_message"}
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squashMergeCommitMessage?;
    # The number of users watching the repository
    @jsondata:Name {value: "subscribers_count"}
    int subscribersCount;
    # The unique identifier of the repository
    int id;
    # Whether the repository has discussions enabled
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions;
    # The number of forks of the repository
    int forks;
    # API URL template for accessing Git references
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    # The SSH URL for cloning the repository
    @jsondata:Name {value: "ssh_url"}
    string sshUrl;
    # The full name of the repository in owner/name format
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0
    int size;
    # The template repository from which this repository was created
    @jsondata:Name {value: "template_repository"}
    NullableRepository? templateRepository?;
    # API URL for listing programming languages used
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    # URL of the repository page on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # API URL template for listing repository collaborators
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    # The HTTPS URL for cloning the repository
    @jsondata:Name {value: "clone_url"}
    string cloneUrl;
    # The default branch of the repository
    @jsondata:Name {value: "default_branch"}
    string defaultBranch;
    # API URL for listing repository webhooks
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    # API URL template for accessing Git trees
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    # Whether the repository has downloads enabled
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads?;
    # The date the repository was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The number of watchers on the repository
    int watchers;
    # API URL for listing repository deployments
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    # API URL template for listing repository deploy keys
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    # Whether the repository is archived
    boolean archived;
    # Whether the repository has the wiki enabled
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki;
    # The date the repository was last updated
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Returns whether or not this repository disabled
    boolean disabled;
    # API URL template for comparing two commits
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    # API URL template for accessing Git commits
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    # The list of topics associated with the repository
    string[] topics?;
    # Whether the pull request branch can be updated from the base branch
    @jsondata:Name {value: "allow_update_branch"}
    boolean allowUpdateBranch?;
    # API URL template for accessing Git tags
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    # API URL for performing merge operations
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    # API URL for the repository
    string url;
    # API URL template for accessing repository contents
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    # API URL template for listing repository issues
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # Whether the PR title is used as the default squash commit message
    @jsondata:Name {value: "use_squash_pr_title_as_default"}
    boolean useSquashPrTitleAsDefault?;
    # The organization that owns the repository, if applicable.
    NullableSimpleUser? organization?;
    # The default value for a merge commit message.
    # 
    # - PR_TITLE - default to the pull request's title.
    # - PR_BODY - default to the pull request's body.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "merge_commit_message"}
    "PR_BODY"|"PR_TITLE"|"BLANK" mergeCommitMessage?;
    # API URL template for listing repository assignees
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    # The default value for a squash merge commit title:
    # 
    # - PR_TITLE - default to the pull request's title.
    # - COMMIT_OR_PR_TITLE - default to the commit's title (if only one commit) or the pull request's title (when more than one commit)
    @jsondata:Name {value: "squash_merge_commit_title"}
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squashMergeCommitTitle?;
    # The number of open issues in the repository
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    # The GraphQL node identifier of the repository
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The number of stars on the repository
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount;
    # Whether the repository is a template repository
    @jsondata:Name {value: "is_template"}
    boolean isTemplate?;
    # The date of the most recent push to the repository
    @jsondata:Name {value: "pushed_at"}
    string pushedAt;
    # The primary programming language of the repository
    string? language;
    # The ultimate source repository in a fork network.
    Repository 'source?;
    # API URL template for listing repository labels
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # The Subversion URL for the repository
    @jsondata:Name {value: "svn_url"}
    string svnUrl;
    # The name of the master branch
    @jsondata:Name {value: "master_branch"}
    string masterBranch?;
    # API URL template for downloading repository archives
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    # Whether merge commits are allowed on pull requests
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit?;
    # API URL for listing repository forks
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The repository visibility: public, private, or internal
    string visibility?;
    # API URL template for listing commit statuses
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    # The number of repositories in the fork network
    @jsondata:Name {value: "network_count"}
    int networkCount;
    # The license associated with the repository.
    NullableLicenseSimple? license;
    # Whether auto-merge is allowed on pull requests
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge?;
    # The name of the repository
    string name;
    # API URL template for listing pull requests
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    # API URL for listing repository tags
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    # Whether the repository is private
    boolean 'private;
    # API URL for listing repository contributors
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    # API URL template for listing repository notifications
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    # The number of open issues in the repository
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount;
    # A short description of the repository
    string? description;
    # Whether the repository has projects enabled
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects;
    # The default value for a merge commit title.
    # 
    #   - PR_TITLE - default to the pull request's title.
    #   - MERGE_MESSAGE - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name)
    @jsondata:Name {value: "merge_commit_title"}
    "PR_TITLE"|"MERGE_MESSAGE" mergeCommitTitle?;
    # API URL template for listing commit comments
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # API URL for listing users who starred the repository
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    # Whether to delete branches on merge
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge?;
    # The Git protocol URL for the repository
    @jsondata:Name {value: "git_url"}
    string gitUrl;
    # Whether the repository has GitHub Pages enabled
    @jsondata:Name {value: "has_pages"}
    boolean hasPages;
    # The user or organization that owns the repository.
    SimpleUser owner;
    # Whether squash merging is allowed on pull requests
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge?;
    # API URL template for listing repository commits
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    # API URL template for accessing repository blobs
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    # API URL for listing repository downloads
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    # Whether the repository has issues enabled
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues;
    # Whether commit sign-off is required for web-based commits
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    # The code of conduct for the repository
    @jsondata:Name {value: "code_of_conduct"}
    CodeOfConductSimple codeOfConduct?;
    # The URL of the mirror for the repository
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl;
    # API URL template for listing repository milestones
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    # API URL for listing teams with access to the repository
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    # The security and analysis settings for the repository
    @jsondata:Name {value: "security_and_analysis"}
    SecurityAndAnalysis? securityAndAnalysis?;
    # Whether the repository is a fork
    boolean 'fork;
    # API URL for listing repository events
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # API URL template for listing issue events
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    # The number of watchers on the repository
    @jsondata:Name {value: "watchers_count"}
    int watchersCount;
    # The URL of the repository's homepage
    string? homepage;
    # The number of forks of the repository
    @jsondata:Name {value: "forks_count"}
    int forksCount;
};

public type ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf11 record {
    # The name of the status checks
    string[] contexts;
};

public type ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf12 record {
    # The name of the status checks
    string[] contexts;
};

public type PullRequestReviewCommentLinks record {
    # Hypermedia link to the associated pull request.
    @jsondata:Name {value: "pull_request"}
    PullRequestReviewCommentLinksPullRequest pullRequest;
    # Hypermedia link to the review comment itself.
    PullRequestReviewCommentLinksSelf self;
    # Hypermedia link to the HTML page of the review comment.
    PullRequestReviewCommentLinksHtml html;
};

public type BranchShortCommit record {
    # The SHA hash of the commit.
    string sha;
    # API URL for the commit.
    string url;
};

# The duration of the interaction restriction. Default: one_day
public type InteractionExpiry "one_day"|"three_days"|"one_week"|"one_month"|"six_months";

public type Cwes CwesOneOf1|CwesCwesOneOf12;

public type UseremailsuseremailsuseremailsOneOf1123 string;

# Whether GitHub Actions can approve pull requests. Enabling this can be a security risk
public type ActionsCanApprovePullRequestReviews boolean;

# Severity of a code scanning alert
public type CodeScanningAlertSeverity "critical"|"high"|"medium"|"low"|"warning"|"note"|"error";

# Use the status property to enable or disable secret scanning push protection for this repository. For more information, see "[Protecting pushes with secret scanning](/code-security/secret-scanning/protecting-pushes-with-secret-scanning)."
public type ReposownerrepoSecurityAndAnalysisSecretScanningPushProtection record {
    # Can be enabled or disabled
    string status?;
};

public type EventPayloadPages record {
    # A summary of the wiki page change.
    string? summary?;
    # The name of the wiki page that was changed.
    @jsondata:Name {value: "page_name"}
    string pageName?;
    # The URL of the wiki page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The action performed on the wiki page.
    string action?;
    # The title of the wiki page.
    string title?;
    # The SHA of the commit associated with the wiki page change.
    string sha?;
};

# Represents the Queries record for the operation: teams/list-discussions-in-org
public type TeamsListDiscussionsInOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Pinned discussions only filter
    string pinned?;
    # Page number of the results to fetch
    int page = 1;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# Represents the Queries record for the operation: issues/list-for-repo
public type IssuesListForRepoQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The user that created the issue
    string creator?;
    # If an integer is passed, it should refer to a milestone by its number field. If the string * is passed, issues with any milestone are accepted. If the string none is passed, issues without milestones are returned
    string milestone?;
    # Indicates the state of the issues to return
    "open"|"closed"|"all" state = "open";
    # Can be the name of a user. Pass in none for issues with no assigned user, and * for issues assigned to any user
    string assignee?;
    # What to sort results by
    "created"|"updated"|"comments" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # A user that's mentioned in the issue
    string mentioned?;
    # A list of comma separated label names. Example: bug,ui,@high
    string labels?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

# Represents the Queries record for the operation: codespaces/list-in-repository-for-authenticated-user
public type CodespacesListInRepositoryForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Hypermedia links related to this content item
public type ContentDirectoryInnerLinks record {
    # URL to the Git API endpoint for this content item.
    string? git;
    # URL to the API endpoint for this content item.
    string self;
    # URL to the HTML web page for this content item.
    string? html;
};

public type RunnerIdLabelsBody1 record {
    # The names of the custom labels to add to the runner
    @constraint:Array {maxLength: 100, minLength: 1}
    string[] labels;
};

public type JobIdRerunBody record {
    # Whether to enable debug logging for the re-run
    @jsondata:Name {value: "enable_debug_logging"}
    boolean enableDebugLogging = false;
};

# Deployment protection rule
public type DeploymentProtectionRule record {
    # The GitHub App that provides the deployment protection rule.
    CustomDeploymentRuleApp app;
    # The unique identifier for the deployment protection rule
    int id;
    # Whether the deployment protection rule is enabled for the environment
    boolean enabled;
    # The node ID for the deployment protection rule
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# A diff of the dependencies between two commits
public type DependencyGraphDiff DependencyGraphDiffInner[];

public type ActionsPermissionsBody1 record {
    # The actions and reusable workflows permitted to run in the organization.
    @jsondata:Name {value: "allowed_actions"}
    AllowedActions allowedActions?;
    # Whether GitHub Actions is enabled for the organization.
    ActionsEnabled enabled;
};

public type PagesHealthCheckAltDomain record {
    # The reason for the domain's current health status.
    string? reason?;
    # Whether the domain resolves to a Cloudflare IP address.
    @jsondata:Name {value: "is_cloudflare_ip"}
    boolean? isCloudflareIp?;
    # Whether the domain enforces HTTPS.
    @jsondata:Name {value: "enforces_https"}
    boolean enforcesHttps?;
    # Whether the domain is pointed to a GitHub Pages IP address.
    @jsondata:Name {value: "is_pointed_to_github_pages_ip"}
    boolean? isPointedToGithubPagesIp?;
    # Whether the domain is actively served by GitHub Pages.
    @jsondata:Name {value: "is_served_by_pages"}
    boolean? isServedByPages?;
    # Whether the domain resolves to a Fastly IP address.
    @jsondata:Name {value: "is_fastly_ip"}
    boolean? isFastlyIp?;
    # Whether the domain is an apex (root) domain.
    @jsondata:Name {value: "is_apex_domain"}
    boolean isApexDomain?;
    # The hostname of the alternate domain.
    string host?;
    # Whether the domain responds to HTTPS requests.
    @jsondata:Name {value: "responds_to_https"}
    boolean respondsToHttps?;
    # Whether the domain has a CNAME record pointing to pages.github.com.
    @jsondata:Name {value: "is_cname_to_pages_dot_github_dot_com"}
    boolean? isCnameToPagesDotGithubDotCom?;
    # Whether the domain has an A record configured.
    @jsondata:Name {value: "is_a_record"}
    boolean? isARecord?;
    # Whether the domain has a CNAME record pointing to a GitHub user domain.
    @jsondata:Name {value: "is_cname_to_github_user_domain"}
    boolean? isCnameToGithubUserDomain?;
    # Whether the domain is a GitHub Pages domain.
    @jsondata:Name {value: "is_pages_domain"}
    boolean isPagesDomain?;
    # Whether the domain points to a deprecated GitHub Pages IP address.
    @jsondata:Name {value: "is_old_ip_address"}
    boolean? isOldIpAddress?;
    # Whether the domain has a CNAME record configured.
    @jsondata:Name {value: "has_cname_record"}
    boolean? hasCnameRecord?;
    # Whether the domain has a CNAME record pointing to Fastly.
    @jsondata:Name {value: "is_cname_to_fastly"}
    boolean? isCnameToFastly?;
    # Whether the domain's DNS resolves successfully.
    @jsondata:Name {value: "dns_resolves"}
    boolean dnsResolves?;
    # Whether the domain is eligible for HTTPS enforcement.
    @jsondata:Name {value: "is_https_eligible"}
    boolean? isHttpsEligible?;
    # The error message related to CAA DNS record validation, if any.
    @jsondata:Name {value: "caa_error"}
    string? caaError?;
    # Whether the domain is served through a proxy.
    @jsondata:Name {value: "is_proxied"}
    boolean? isProxied?;
    # Whether the domain is a valid domain name.
    @jsondata:Name {value: "is_valid_domain"}
    boolean isValidDomain?;
    # Whether a non-GitHub Pages IP address is present in DNS records.
    @jsondata:Name {value: "is_non_github_pages_ip_present"}
    boolean? isNonGithubPagesIpPresent?;
    # The URI of the alternate domain.
    string uri?;
    # Whether the domain should be configured as an A record.
    @jsondata:Name {value: "should_be_a_record"}
    boolean? shouldBeARecord?;
    # The nameservers associated with the domain.
    string nameservers?;
    # Whether the domain has MX records present.
    @jsondata:Name {value: "has_mx_records_present"}
    boolean? hasMxRecordsPresent?;
    # Whether the alternate domain configuration is valid.
    @jsondata:Name {value: "is_valid"}
    boolean isValid?;
    # The error message related to HTTPS configuration, if any.
    @jsondata:Name {value: "https_error"}
    string? httpsError?;
};

# Represents the Queries record for the operation: actions/list-workflow-runs-for-repo
public type ActionsListWorkflowRunsForRepoQueries record {
    # Returns someone's workflow runs. Use the login for the user who created the push associated with the check suite or workflow run
    string actor?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Returns workflow runs with the check_suite_id that you specify
    @http:Query {name: "check_suite_id"}
    int checkSuiteId?;
    # Returns workflow runs created within the given date-time range. For more information on the syntax, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    string created?;
    # If true pull requests are omitted from the response (empty array)
    @http:Query {name: "exclude_pull_requests"}
    boolean excludePullRequests = false;
    # Page number of the results to fetch
    int page = 1;
    # Returns workflow run triggered by the event you specify. For example, push, pull_request or issue. For more information, see "[Events that trigger workflows](https://docs.github.com/actions/automating-your-workflow-with-github-actions/events-that-trigger-workflows)."
    string event?;
    # Returns workflow runs associated with a branch. Use the name of the branch of the push
    string branch?;
    # Only returns workflow runs that are associated with the specified head_sha
    @http:Query {name: "head_sha"}
    string headSha?;
    # Returns workflow runs with the check run status or conclusion that you specify. For example, a conclusion can be success or a status can be in_progress. Only GitHub can set a status of waiting or requested
    "completed"|"action_required"|"cancelled"|"failure"|"neutral"|"skipped"|"stale"|"success"|"timed_out"|"in_progress"|"queued"|"requested"|"waiting"|"pending" status?;
};

public type ProtectedBranchPullRequestReviewDismissalRestrictions record {
    # API URL for listing teams with review dismissal access.
    @jsondata:Name {value: "teams_url"}
    string teamsUrl?;
    # The list of teams with review dismissal access
    Team[] teams?;
    # API URL for listing users with review dismissal access.
    @jsondata:Name {value: "users_url"}
    string usersUrl?;
    # The list of users with review dismissal access
    SimpleUser[] users?;
    # API URL for the dismissal restrictions resource.
    string url?;
    # The list of apps with review dismissal access
    Integration[] apps?;
};

public type OutsideCollaboratorsusernameBody record {
    # When set to true, the request will be performed asynchronously. Returns a 202 status code when the job is successfully queued
    boolean async = false;
};

# The time that the alert was dismissed in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
public type AlertDismissedAt string?;

# Represents the Queries record for the operation: repos/get-readme
public type ReposGetReadmeQueries record {
    # The name of the commit/branch/tag. Default: the repository’s default branch
    string ref?;
};

public type CwesOneOf1 string;

# Moved Column in Project Issue Event
public type MovedColumnInProjectIssueEvent record {
    # The user who triggered the move column event.
    SimpleUser actor;
    # The URL of the commit associated with the event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The GitHub App that performed this event, if applicable.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The date and time the event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the event.
    int id;
    # The type of event that occurred.
    string event;
    # The SHA of the commit associated with the event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # The API URL for the event.
    string url;
    # The project card that was moved to a different column.
    @jsondata:Name {value: "project_card"}
    RemovedFromProjectIssueEventProjectCard projectCard?;
    # The GraphQL node identifier of the event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# The public key used for setting user Codespaces' Secrets
public type CodespacesUserPublicKey record {
    # The identifier for the key
    @jsondata:Name {value: "key_id"}
    string keyId;
    # The Base64 encoded public key
    string 'key;
};

public type UserSshSigningKeysBody record {
    # A descriptive name for the new key
    string title?;
    # The public SSH key to add to your GitHub account. For more information, see "[Checking for existing SSH keys](https://docs.github.com/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys)."
    @constraint:String {pattern: re `^ssh-(rsa|dss|ed25519) |^ecdsa-sha2-nistp(256|384|521) |^(sk-ssh-ed25519|sk-ecdsa-sha2-nistp256)@openssh.com `}
    string 'key;
};

# Email
public type Email record {
    # The visibility of the email address (public or private).
    string? visibility;
    # Whether the email address has been verified.
    boolean verified;
    # The email address.
    string email;
    # Whether this is the primary email address for the account.
    boolean primary;
};

# Key Simple
public type KeySimple record {
    # The unique identifier of the SSH key.
    int id;
    # The public SSH key value.
    string 'key;
};

# Project Collaborator Permission
public type ProjectCollaboratorPermission record {
    # The permission level of the collaborator on the project.
    string permission;
    # The user associated with the collaborator permission.
    NullableSimpleUser? user;
};

public type OrgsorgBody record {
    # Whether Dependabot security updates is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a GET /orgs/{org} request
    @jsondata:Name {value: "dependabot_security_updates_enabled_for_new_repositories"}
    boolean dependabotSecurityUpdatesEnabledForNewRepositories?;
    # Whether Dependabot alerts is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a GET /orgs/{org} request
    @jsondata:Name {value: "dependabot_alerts_enabled_for_new_repositories"}
    boolean dependabotAlertsEnabledForNewRepositories?;
    # Whether organization members can create internal repositories, which are visible to all enterprise members. You can only allow members to create internal repositories if your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+. For more information, see "[Restricting repository creation in your organization](https://docs.github.com/github/setting-up-and-managing-organizations-and-teams/restricting-repository-creation-in-your-organization)" in the GitHub Help documentation
    @jsondata:Name {value: "members_can_create_internal_repositories"}
    boolean membersCanCreateInternalRepositories?;
    # If secret_scanning_push_protection_custom_link_enabled is true, the URL that will be displayed to contributors who are blocked from pushing a secret
    @jsondata:Name {value: "secret_scanning_push_protection_custom_link"}
    string secretScanningPushProtectionCustomLink?;
    # Whether repositories that belong to the organization can use repository projects
    @jsondata:Name {value: "has_repository_projects"}
    boolean hasRepositoryProjects?;
    # The Twitter username of the company
    @jsondata:Name {value: "twitter_username"}
    string twitterUsername?;
    # Whether organization members can create public GitHub Pages sites. Existing published sites will not be impacted
    @jsondata:Name {value: "members_can_create_public_pages"}
    boolean membersCanCreatePublicPages = true;
    # The description of the company
    string description?;
    # Whether GitHub Advanced Security is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a GET /orgs/{org} request
    @jsondata:Name {value: "advanced_security_enabled_for_new_repositories"}
    boolean advancedSecurityEnabledForNewRepositories?;
    # The URL of the organization's blog or website.
    string blog?;
    # Whether dependency graph is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a GET /orgs/{org} request
    @jsondata:Name {value: "dependency_graph_enabled_for_new_repositories"}
    boolean dependencyGraphEnabledForNewRepositories?;
    # Default permission level members have for organization repositories
    @jsondata:Name {value: "default_repository_permission"}
    "read"|"write"|"admin"|"none" defaultRepositoryPermission = "read";
    # Whether secret scanning is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a GET /orgs/{org} request
    @jsondata:Name {value: "secret_scanning_enabled_for_new_repositories"}
    boolean secretScanningEnabledForNewRepositories?;
    # Billing email address. This address is not publicized
    @jsondata:Name {value: "billing_email"}
    string billingEmail?;
    # Specifies which types of repositories non-admin organization members can create. private is only available to repositories that are part of an organization on GitHub Enterprise Cloud. 
    # **Note:** This parameter is deprecated and will be removed in the future. Its return value ignores internal repositories. Using this parameter overrides values set in members_can_create_repositories. See the parameter deprecation notice in the operation description for details
    @jsondata:Name {value: "members_allowed_repository_creation_type"}
    "all"|"private"|"none" membersAllowedRepositoryCreationType?;
    # Whether organization members can fork private organization repositories
    @jsondata:Name {value: "members_can_fork_private_repositories"}
    boolean membersCanForkPrivateRepositories = false;
    # The company name
    string company?;
    # Whether secret scanning push protection is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a GET /orgs/{org} request
    @jsondata:Name {value: "secret_scanning_push_protection_enabled_for_new_repositories"}
    boolean secretScanningPushProtectionEnabledForNewRepositories?;
    # Whether organization members can create private GitHub Pages sites. Existing published sites will not be impacted
    @jsondata:Name {value: "members_can_create_private_pages"}
    boolean membersCanCreatePrivatePages = true;
    # The publicly visible email address
    string email?;
    # Whether of non-admin organization members can create repositories. **Note:** A parameter can override this parameter. See members_allowed_repository_creation_type in this table for details
    @jsondata:Name {value: "members_can_create_repositories"}
    boolean membersCanCreateRepositories = true;
    # Whether organization members can create private repositories, which are visible to organization members with permission. For more information, see "[Restricting repository creation in your organization](https://docs.github.com/github/setting-up-and-managing-organizations-and-teams/restricting-repository-creation-in-your-organization)" in the GitHub Help documentation
    @jsondata:Name {value: "members_can_create_private_repositories"}
    boolean membersCanCreatePrivateRepositories?;
    # Whether contributors to organization repositories are required to sign off on commits they make through GitHub's web interface
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired = false;
    # Whether organization members can create public repositories, which are visible to anyone. For more information, see "[Restricting repository creation in your organization](https://docs.github.com/github/setting-up-and-managing-organizations-and-teams/restricting-repository-creation-in-your-organization)" in the GitHub Help documentation
    @jsondata:Name {value: "members_can_create_public_repositories"}
    boolean membersCanCreatePublicRepositories?;
    # Whether an organization can use organization projects
    @jsondata:Name {value: "has_organization_projects"}
    boolean hasOrganizationProjects?;
    # Whether organization members can create GitHub Pages sites. Existing published sites will not be impacted
    @jsondata:Name {value: "members_can_create_pages"}
    boolean membersCanCreatePages = true;
    # The shorthand name of the company
    string name?;
    # The location
    string location?;
    # Whether a custom link is shown to contributors who are blocked from pushing a secret by push protection
    @jsondata:Name {value: "secret_scanning_push_protection_custom_link_enabled"}
    boolean secretScanningPushProtectionCustomLinkEnabled?;
};

public type NotificationRead record {
    # A message describing the result of marking notifications as read.
    string message?;
    # The URL to check the status of the mark-as-read operation.
    string url?;
};

public type AccessSelectedUsersBody record {
    # The usernames of the organization members whose codespaces be billed to the organization
    @jsondata:Name {value: "selected_usernames"}
    string[] selectedUsernames;
};

# Details of a deployment that is waiting for protection rules to pass
public type PendingDeployment record {
    # The environment that is waiting for deployment approval.
    PendingDeploymentEnvironment environment;
    # The time that the wait timer began
    @jsondata:Name {value: "wait_timer_started_at"}
    string? waitTimerStartedAt;
    # The set duration of the wait timer
    @jsondata:Name {value: "wait_timer"}
    int waitTimer;
    # Whether the currently authenticated user can approve the deployment
    @jsondata:Name {value: "current_user_can_approve"}
    boolean currentUserCanApprove;
    # The people or teams that may approve jobs that reference the environment. You can list up to six users or teams as reviewers. The reviewers must have at least read access to the repository. Only one of the required reviewers needs to approve the job for it to proceed
    PendingDeploymentReviewers[] reviewers;
};

# The permissions granted to the user access token
public type AppPermissions record {
    # The level of permission to grant the access token to view and manage secret scanning alerts
    @jsondata:Name {value: "secret_scanning_alerts"}
    "read"|"write" secretScanningAlerts?;
    # The level of permission to grant the access token to search repositories, list collaborators, and access repository metadata
    "read"|"write" metadata?;
    # The level of permission to grant the access token to view and manage announcement banners for an organization
    @jsondata:Name {value: "organization_announcement_banners"}
    "read"|"write" organizationAnnouncementBanners?;
    # The level of permission to grant the access token for organization packages published to GitHub Packages
    @jsondata:Name {value: "organization_packages"}
    "read"|"write" organizationPackages?;
    # The level of permission to grant the access token for managing repository environments
    "read"|"write" environments?;
    # The level of permission to grant the access token to manage team discussions and related comments
    @jsondata:Name {value: "team_discussions"}
    "read"|"write" teamDiscussions?;
    # The level of permission to grant the access token for repository creation, deletion, settings, teams, and collaborators creation
    "read"|"write" administration?;
    # The level of permission to grant the access token for viewing an organization's plan
    @jsondata:Name {value: "organization_plan"}
    "read" organizationPlan?;
    # The level of permission to grant the access token to manage Dependabot alerts
    @jsondata:Name {value: "vulnerability_alerts"}
    "read"|"write" vulnerabilityAlerts?;
    # The level of permission to grant the access token for viewing and managing fine-grained personal access token requests to an organization
    @jsondata:Name {value: "organization_personal_access_tokens"}
    "read"|"write" organizationPersonalAccessTokens?;
    # The level of permission to grant the access token for viewing and managing fine-grained personal access tokens that have been approved by an organization
    @jsondata:Name {value: "organization_personal_access_token_requests"}
    "read"|"write" organizationPersonalAccessTokenRequests?;
    # The level of permission to grant the access token to update GitHub Actions workflow files
    "write" workflows?;
    # The level of permission to grant the access token for issues and related comments, assignees, labels, and milestones
    "read"|"write" issues?;
    # The level of permission to grant the access token for pull requests and related comments, assignees, labels, milestones, and merges
    @jsondata:Name {value: "pull_requests"}
    "read"|"write" pullRequests?;
    # The level of permission to grant the access token to view and manage users blocked by the organization
    @jsondata:Name {value: "organization_user_blocking"}
    "read"|"write" organizationUserBlocking?;
    # The level of permission to grant the access token to manage just a single file
    @jsondata:Name {value: "single_file"}
    "read"|"write" singleFile?;
    # The level of permission to grant the access token to retrieve Pages statuses, configuration, and builds, as well as create new builds
    "read"|"write" pages?;
    # The level of permission to grant the access token to manage repository projects, columns, and cards
    @jsondata:Name {value: "repository_projects"}
    "read"|"write"|"admin" repositoryProjects?;
    # The level of permission to grant the access token for organization teams and members
    "read"|"write" members?;
    # The level of permission to grant the access token for custom repository roles management. This property is in beta and is subject to change
    @jsondata:Name {value: "organization_custom_roles"}
    "read"|"write" organizationCustomRoles?;
    # The level of permission to grant the access token to manage access to an organization
    @jsondata:Name {value: "organization_administration"}
    "read"|"write" organizationAdministration?;
    # The level of permission to grant the access token to manage organization secrets
    @jsondata:Name {value: "organization_secrets"}
    "read"|"write" organizationSecrets?;
    # The level of permission to grant the access token to manage the post-receive hooks for an organization
    @jsondata:Name {value: "organization_hooks"}
    "read"|"write" organizationHooks?;
    # The level of permission to grant the access token for packages published to GitHub Packages
    "read"|"write" packages?;
    # The level of permission to grant the access token to manage repository secrets
    "read"|"write" secrets?;
    # The level of permission to grant the access token for deployments and deployment statuses
    "read"|"write" deployments?;
    # The level of permission to grant the access token for checks on code
    "read"|"write" checks?;
    # The level of permission to grant the access token to manage organization projects and projects beta (where available)
    @jsondata:Name {value: "organization_projects"}
    "read"|"write"|"admin" organizationProjects?;
    # The level of permission to grant the access token to view and manage security events like code scanning alerts
    @jsondata:Name {value: "security_events"}
    "read"|"write" securityEvents?;
    # The level of permission to grant the access token for repository contents, commits, branches, downloads, releases, and merges
    "read"|"write" contents?;
    # The level of permission to grant the access token to manage the post-receive hooks for a repository
    @jsondata:Name {value: "repository_hooks"}
    "read"|"write" repositoryHooks?;
    # The level of permission to grant the access token for commit statuses
    "read"|"write" statuses?;
    # The level of permission to grant the access token for GitHub Actions workflows, workflow runs, and artifacts
    "read"|"write" actions?;
    # The level of permission to grant the access token to view and manage GitHub Actions self-hosted runners available to an organization
    @jsondata:Name {value: "organization_self_hosted_runners"}
    "read"|"write" organizationSelfHostedRunners?;
};

# Interaction limit settings
public type InteractionLimitResponse record {
    # The date and time when the interaction limit expires.
    @jsondata:Name {value: "expires_at"}
    string expiresAt;
    # The origin context where the interaction limit is applied.
    string origin;
    # The type of interaction limit currently active.
    InteractionGroup 'limit;
};

public type PullRequestHeadRepoOwner record {
    # API URL template for the owner's gists.
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    # API URL for listing the owner's repositories.
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    # API URL template for users the owner is following.
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    # API URL template for repositories the owner has starred.
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    # API URL for listing the owner's followers.
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    # The username of the repository owner.
    string login;
    # The type of account, such as User or Organization.
    string 'type;
    # API URL for the owner's account.
    string url;
    # API URL for the owner's watched repositories.
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    # API URL for events received by the owner.
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    # URL of the owner's profile avatar image.
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # API URL template for events performed by the owner.
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # URL of the owner's profile page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Whether the owner is a GitHub site administrator.
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    # The unique identifier of the owner.
    int id;
    # The Gravatar ID associated with the owner's email.
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    # The GraphQL node identifier of the owner.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # API URL for listing the owner's organizations.
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
};

# Represents the Queries record for the operation: migrations/get-status-for-authenticated-user
public type MigrationsGetStatusForAuthenticatedUserQueries record {
    # Exclude attributes from the API response to improve performance.
    string[] exclude?;
};

public type CodeScanningAlertInstance record {
    # Classifications that have been applied to the file that triggered the alert.
    # For example identifying it as documentation, or a generated file
    CodeScanningAlertClassification[] classifications?;
    # The Git reference associated with this alert instance.
    CodeScanningRef ref?;
    # The environment in which the alert instance was detected.
    CodeScanningAlertEnvironment environment?;
    # The SHA of the commit where the alert instance was detected.
    @jsondata:Name {value: "commit_sha"}
    string commitSha?;
    # The URL of the alert instance page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The code location where the alert was detected.
    CodeScanningAlertLocation location?;
    # The state of the code scanning alert instance.
    CodeScanningAlertState state?;
    # The analysis key that identifies the analysis configuration.
    @jsondata:Name {value: "analysis_key"}
    CodeScanningAnalysisAnalysisKey analysisKey?;
    # The category of the code scanning analysis that produced this alert.
    CodeScanningAnalysisCategory category?;
    # The message associated with the code scanning alert instance.
    CodeScanningAlertInstanceMessage message?;
};

public type NotificationsBody record {
    # Whether the notification has been read
    boolean read?;
    # Describes the last point that notifications were checked. Anything updated since this time will not be marked as read. If you omit this parameter, all notifications are marked as read. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ. Default: The current timestamp
    @jsondata:Name {value: "last_read_at"}
    string lastReadAt?;
};

public type RestrictionsTeamsBody ReposownerrepobranchesbranchprotectionrestrictionsteamsOneOf1|ReposownerrepobranchesbranchprotectionrestrictionsteamsreposownerrepobranchesbranchprotectionrestrictionsteamsOneOf12;

# Represents the Queries record for the operation: dependabot/list-repo-secrets
public type DependabotListRepoSecretsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type IssueSearchResultItemLabels record {
    # Whether this is a default label provided by GitHub.
    boolean default?;
    # The hexadecimal color code of the label.
    string color?;
    # The name of the label.
    string name?;
    # A short description of the label.
    string? description?;
    # The unique identifier of the label.
    int id?;
    # The API URL for the label.
    string url?;
    # The GraphQL node identifier of the label.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# Status Check Policy
public type StatusCheckPolicy record {
    # The list of required status checks that must pass before merging.
    StatusCheckPolicyChecks[] checks;
    # API URL for listing required status check contexts.
    @jsondata:Name {value: "contexts_url"}
    string contextsUrl;
    # The list of required status check context names.
    string[] contexts;
    # Whether the branch must be up to date before merging.
    boolean strict;
    # API URL for the status check policy.
    string url;
};

# Represents the Queries record for the operation: issues/list-labels-on-issue
public type IssuesListLabelsOnIssueQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# A classification of the file. For example to identify it as generated
public type CodeScanningAlertClassification "source"|"generated"|"test"|"library"?;

public type RunnersGenerateJitconfigBody record {
    # The working directory to be used for job execution, relative to the runner install directory
    @jsondata:Name {value: "work_folder"}
    string workFolder = "_work";
    # The name of the new runner
    string name;
    # The ID of the runner group to register the runner to
    @jsondata:Name {value: "runner_group_id"}
    int runnerGroupId;
    # The names of the custom labels to add to the runner. **Minimum items**: 1. **Maximum items**: 100
    @constraint:Array {maxLength: 100, minLength: 1}
    string[] labels;
};

public type ActionsGetDefaultWorkflowPermissions record {
    # The default permissions granted to the GITHUB_TOKEN in workflows.
    @jsondata:Name {value: "default_workflow_permissions"}
    ActionsDefaultWorkflowPermissions defaultWorkflowPermissions;
    # Whether GitHub Actions can approve pull request reviews.
    @jsondata:Name {value: "can_approve_pull_request_reviews"}
    ActionsCanApprovePullRequestReviews canApprovePullRequestReviews;
};

public type MembershipsusernameBody1 record {
    # The role that this user should have in the team
    "member"|"maintainer" role = "member";
};

public type ImportLfsBody record {
    # Whether to store large files during the import. opt_in means large files will be stored using Git LFS. opt_out means large files will be removed during the import
    @jsondata:Name {value: "use_lfs"}
    "opt_in"|"opt_out" useLfs;
};

# Represents the Queries record for the operation: packages/list-packages-for-authenticated-user
public type PackagesListPackagesForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The selected visibility of the packages.  This parameter is optional and only filters an existing result set.
    # 
    # The internal visibility is only supported for GitHub Packages registries that allow for granular permissions. For other ecosystems internal is synonymous with private.
    # For the list of GitHub Packages registries that support granular permissions, see "[About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages#granular-permissions-for-userorganization-scoped-packages)."
    "public"|"private"|"internal" visibility?;
    # Page number of the results to fetch
    int page = 1;
    # The type of supported package. Packages in GitHub's Gradle registry have the type maven. Docker images pushed to GitHub's Container registry (ghcr.io) have the type container. You can use the type docker to find images that were pushed to GitHub's Docker registry (docker.pkg.github.com), even if these have now been migrated to the Container registry
    @http:Query {name: "package_type"}
    "npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType;
};

# Installation
public type InstallationResponse record {
    # The total number of installations returned.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of GitHub App installations.
    Installation[] installations;
};

public type CardscardIdBody record {
    # The project card's note
    string? note?;
    # Whether or not the card is archived
    boolean archived?;
};

# A credit given to a user for a repository security advisory
public type RepositoryAdvisoryCredit record {|
    # The state of the user's acceptance of the credit
    "accepted"|"declined"|"pending" state;
    # The type of credit assigned to the user for the advisory.
    SecurityAdvisoryCreditTypes 'type;
    # The user receiving credit for the security advisory.
    SimpleUser user;
|};

public type SimpleCommitStatus record {
    # The avatar URL of the user or app that created the status.
    @jsondata:Name {value: "avatar_url"}
    string? avatarUrl;
    # The date and time the status was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The URL associated with the status for additional details.
    @jsondata:Name {value: "target_url"}
    string? targetUrl;
    # The label identifying the status check provider.
    string context;
    # A short description of the commit status.
    string? description;
    # The date and time the status was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the commit status.
    int id;
    # The state of the commit status.
    string state;
    # Whether this status check is required to pass.
    boolean? required?;
    # The API URL for the commit status.
    string url;
    # The GraphQL node identifier of the commit status.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents the Queries record for the operation: actions/list-environment-variables
public type ActionsListEnvironmentVariablesQueries record {
    # The number of results per page (max 30)
    @http:Query {name: "per_page"}
    int perPage = 10;
    # Page number of the results to fetch
    int page = 1;
};

public type EventPayload record {
    # The list of wiki pages affected by the event.
    EventPayloadPages[] pages?;
    # The issue associated with the event.
    Issue issue?;
    # The action that triggered the event.
    string action?;
    # The issue comment associated with the event.
    IssueComment comment?;
};

public type PersonalAccessTokenspatIdBody record {
    # Action to apply to the fine-grained personal access token
    "revoke" action;
};

public type CodespacescodespaceNameBody record {
    # A valid machine to transition this codespace to
    string machine?;
    # Recently opened folders inside the codespace. It is currently used by the clients to determine the folder path to load the codespace in
    @jsondata:Name {value: "recent_folders"}
    string[] recentFolders?;
    # Display name for this codespace
    @jsondata:Name {value: "display_name"}
    string displayName?;
};

# The GitHub Pages deployment status
public type PageDeployment record {
    # The URI to the deployed GitHub Pages
    @jsondata:Name {value: "page_url"}
    string pageUrl;
    # The URI to the deployed GitHub Pages preview
    @jsondata:Name {value: "preview_url"}
    string previewUrl?;
    # The URI to monitor GitHub Pages deployment status
    @jsondata:Name {value: "status_url"}
    string statusUrl;
};

# State Change Issue Event
public type StateChangeIssueEvent record {
    # The user who triggered the state change event.
    SimpleUser actor;
    # The URL of the commit associated with the state change.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The reason for the issue state change.
    @jsondata:Name {value: "state_reason"}
    string? stateReason?;
    # The GitHub App that performed this event, if applicable.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The date and time the event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the event.
    int id;
    # The type of event that occurred.
    string event;
    # The SHA of the commit associated with the state change.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # The API URL for the event.
    string url;
    # The GraphQL node identifier of the event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents the Queries record for the operation: gists/list-for-user
public type GistsListForUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

public type NameRepositoriesBody record {
    # The IDs of the repositories that can access the organization variable
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds;
};

# Represents the Queries record for the operation: actions/list-repo-secrets
public type ActionsListRepoSecretsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type ReposownerrepobranchesbranchprotectionrestrictionsteamsOneOf1 record {
    # The slug values for teams
    string[] teams;
};

# Represents the Queries record for the operation: repos/list-deploy-keys
public type ReposListDeployKeysQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: repos/upload-release-asset
public type ReposUploadReleaseAssetQueries record {
    # The file name of the asset.
    string name;
    # An optional label to display instead of the asset file name.
    string label?;
};

public type ArtifactWorkflowRun record {
    # The branch from which the workflow run was triggered.
    @jsondata:Name {value: "head_branch"}
    string headBranch?;
    # The unique identifier of the repository where the workflow ran.
    @jsondata:Name {value: "repository_id"}
    int repositoryId?;
    # The unique identifier of the head repository for the workflow run.
    @jsondata:Name {value: "head_repository_id"}
    int headRepositoryId?;
    # The unique identifier of the workflow run.
    int id?;
    # The SHA of the head commit for the workflow run.
    @jsondata:Name {value: "head_sha"}
    string headSha?;
};

public type ImportProjectChoices record {
    # The human-readable name of the importable project.
    @jsondata:Name {value: "human_name"}
    string humanName?;
    # The TFVC project name for Team Foundation Version Control imports.
    @jsondata:Name {value: "tfvc_project"}
    string tfvcProject?;
    # The version control system type of the importable project.
    string vcs?;
};

# Code of Conduct Simple
public type CodeOfConductSimple record {
    # The URL of the code of conduct page on GitHub.
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    # The name of the code of conduct.
    string name;
    # The API URL for the code of conduct.
    string url;
    # The unique key identifying the code of conduct.
    string 'key;
};

# A GitHub Classroom classroom
public type Classroom record {
    # Whether classroom is archived
    boolean archived;
    # The GitHub organization associated with the classroom.
    SimpleClassroomOrganization organization;
    # The name of the classroom
    string name;
    # Unique identifier of the classroom
    int id;
    # The URL of the classroom on GitHub Classroom
    string url;
};

public type GitBlobsBody record {
    # The encoding used for content. Currently, "utf-8" and "base64" are supported
    string encoding = "utf-8";
    # The new blob's content
    string content;
};

public type GistSimpleForks record {
    # The timestamp when the gist fork was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    # The timestamp when the gist fork was created.
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    # The unique identifier of the gist fork.
    string id?;
    # The user who forked the gist.
    PublicUser user?;
    # The API URL of the gist fork.
    string url?;
};

# Represents the Queries record for the operation: issues/list-comments
public type IssuesListCommentsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

# Secrets for a GitHub Codespace
public type CodespacesOrgSecretResponse record {
    # The total number of organization-level Codespace secrets.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of Codespace secrets for the organization.
    CodespacesOrgSecret[] secrets;
};

# Organization Invitation
public type OrganizationInvitation record {
    # The source of the invitation, e.g., member or team.
    @jsondata:Name {value: "invitation_source"}
    string invitationSource?;
    # The role assigned to the invited user in the organization.
    string role;
    # The timestamp when the invitation was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The user who sent the organization invitation.
    SimpleUser inviter;
    # The unique identifier of the organization invitation.
    int id;
    # The timestamp when the invitation failed, if applicable.
    @jsondata:Name {value: "failed_at"}
    string? failedAt?;
    # The GitHub username of the invited user.
    string? login;
    # The URL listing teams associated with this invitation.
    @jsondata:Name {value: "invitation_teams_url"}
    string invitationTeamsUrl;
    # The email address of the invited user.
    string? email;
    # The reason the invitation failed, if applicable.
    @jsondata:Name {value: "failed_reason"}
    string? failedReason?;
    # The number of teams the invited user is being added to.
    @jsondata:Name {value: "team_count"}
    int teamCount;
    # The GraphQL node ID of the organization invitation.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type RestrictionsAppsBody ReposownerrepobranchesbranchprotectionrestrictionsappsOneOf1|ReposownerrepobranchesbranchprotectionrestrictionsappsreposownerrepobranchesbranchprotectionrestrictionsappsOneOf12;

# Converted Note to Issue Issue Event
public type ConvertedNoteToIssueIssueEvent record {
    # The user who triggered the converted note to issue event.
    SimpleUser actor;
    # The URL of the commit associated with this event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The GitHub App that performed this event, if any.
    @jsondata:Name {value: "performed_via_github_app"}
    Integration performedViaGithubApp;
    # The timestamp when the event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the issue event.
    int id;
    # The type of event that occurred on the issue.
    string event;
    # The SHA of the commit associated with this event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # The API URL of the issue event.
    string url;
    # The project card that was converted to an issue.
    @jsondata:Name {value: "project_card"}
    RemovedFromProjectIssueEventProjectCard projectCard?;
    # The GraphQL node ID of the issue event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type GlobalAdvisoryVulnerabilities record {
    # The package version that resolve the vulnerability
    @jsondata:Name {value: "first_patched_version"}
    string? firstPatchedVersion;
    # The package affected by this vulnerability.
    GlobalAdvisoryPackage? package;
    # The functions in the package that are affected by the vulnerability
    @jsondata:Name {value: "vulnerable_functions"}
    string[]? vulnerableFunctions;
    # The range of the package versions affected by the vulnerability
    @jsondata:Name {value: "vulnerable_version_range"}
    string? vulnerableVersionRange;
};

# Gist Simple
public type GistSimple record {
    # The list of forks of this gist.
    # 
    # # Deprecated
    @deprecated
    GistSimpleForks[]? forks?;
    # The user who owns the gist.
    SimpleUser owner?;
    # The API URL to retrieve the gist's commit history.
    @jsondata:Name {value: "commits_url"}
    string commitsUrl?;
    # The number of comments on the gist.
    int comments?;
    # The API URL to retrieve the gist's forks.
    @jsondata:Name {value: "forks_url"}
    string forksUrl?;
    # The Git URL used to push changes to the gist.
    @jsondata:Name {value: "git_push_url"}
    string gitPushUrl?;
    # The timestamp when the gist was created.
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    # A brief description of the gist.
    string? description?;
    # Indicates whether the gist content is truncated.
    boolean truncated?;
    # The original gist this gist was forked from.
    @jsondata:Name {value: "fork_of"}
    Gist? forkOf?;
    # The list of historical versions of the gist.
    # 
    # # Deprecated
    @deprecated
    GistHistory[]? history?;
    # The API URL of the gist.
    string url?;
    # Indicates whether the gist is publicly visible.
    boolean 'public?;
    # The timestamp when the gist was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    # The browser-accessible URL of the gist.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The Git URL used to pull the gist contents.
    @jsondata:Name {value: "git_pull_url"}
    string gitPullUrl?;
    # The API URL to retrieve comments on the gist.
    @jsondata:Name {value: "comments_url"}
    string commentsUrl?;
    # The files contained within the gist.
    record {|GistSimpleFiles?...;|} files?;
    # The unique identifier of the gist.
    string id?;
    # The username associated with the gist.
    string? user?;
    # The GraphQL node ID of the gist.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# A schema for the SPDX JSON format returned by the Dependency Graph
public type DependencyGraphSpdxSbom record {
    # The SPDX-formatted software bill of materials for the repository.
    DependencyGraphSpdxSbomSbom sbom;
};

# Represents the Queries record for the operation: issues/list-assignees
public type IssuesListAssigneesQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# The total number of seat assignments created
public type CopilotSeatCreated record {
    # The number of Copilot seat assignments successfully created.
    @jsondata:Name {value: "seats_created"}
    int seatsCreated;
};

public type FeedLinks record {
    # The feed link for repository discussions.
    @jsondata:Name {value: "repository_discussions"}
    LinkWithType repositoryDiscussions?;
    # The feed link for the current user's organization activity.
    @jsondata:Name {value: "current_user_organization"}
    LinkWithType currentUserOrganization?;
    # The feed links for all of the current user's organizations.
    @jsondata:Name {value: "current_user_organizations"}
    LinkWithType[] currentUserOrganizations?;
    # The feed link for the current user's activity as an actor.
    @jsondata:Name {value: "current_user_actor"}
    LinkWithType currentUserActor?;
    # The feed link for the authenticated user's timeline.
    LinkWithType timeline;
    # The feed link for the user's public activity.
    LinkWithType user;
    # The feed link for GitHub security advisories.
    @jsondata:Name {value: "security_advisories"}
    LinkWithType securityAdvisories?;
    # The feed link for the current user's public activity.
    @jsondata:Name {value: "current_user_public"}
    LinkWithType currentUserPublic?;
    # The feed link for a specific repository discussion category.
    @jsondata:Name {value: "repository_discussions_category"}
    LinkWithType repositoryDiscussionsCategory?;
    # The feed link for the current authenticated user's activity.
    @jsondata:Name {value: "current_user"}
    LinkWithType currentUser?;
};

# Represents the Queries record for the operation: actions/list-jobs-for-workflow-run-attempt
public type ActionsListJobsForWorkflowRunAttemptQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: security-advisories/list-global-advisories
public type SecurityAdvisoriesListGlobalAdvisoriesQueries record {
    # If specified, only advisories with these severities will be returned
    "unknown"|"low"|"medium"|"high"|"critical" severity?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # If specified, only advisories for these ecosystems will be returned
    "actions"|"composer"|"erlang"|"go"|"maven"|"npm"|"nuget"|"other"|"pip"|"pub"|"rubygems"|"rust" ecosystem?;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor
    string before?;
    # Whether to only return advisories that have been withdrawn
    @http:Query {name: "is_withdrawn"}
    boolean isWithdrawn?;
    # If specified, only return advisories that affect any of package or package@version. A maximum of 1000 packages can be specified.
    # If the query parameter causes the URL to exceed the maximum URL length supported by your client, you must specify fewer packages.
    # 
    # Example: affects=package1,package2@1.0.0,package3@^2.0.0 or affects[]=package1&affects[]=package2@1.0.0
    Affects affects?;
    # If specified, only return advisories that were published on a date or date range.
    # 
    # For more information on the syntax of the date range, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    string published?;
    # The property to sort the results by
    "updated"|"published" sort = "published";
    # If specified, only advisories of this type will be returned. By default, a request with no other parameters defined will only return reviewed advisories that are not malware
    "reviewed"|"malware"|"unreviewed" 'type = "reviewed";
    # If specified, only advisories with these Common Weakness Enumerations (CWEs) will be returned.
    # 
    # Example: cwes=79,284,22 or cwes[]=79&cwes[]=284&cwes[]=22
    Cwes cwes?;
    # If specified, only advisories with this GHSA (GitHub Security Advisory) identifier will be returned
    @http:Query {name: "ghsa_id"}
    string ghsaId?;
    # If specified, only advisories with this CVE (Common Vulnerabilities and Exposures) identifier will be returned
    @http:Query {name: "cve_id"}
    string cveId?;
    # If specified, only show advisories that were updated or published on a date or date range.
    # 
    # For more information on the syntax of the date range, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    string modified?;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor
    string after?;
    # If specified, only return advisories that were updated on a date or date range.
    # 
    # For more information on the syntax of the date range, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    string updated?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# An advisory identifier
public type DependabotAlertSecurityAdvisoryIdentifiers record {|
    # The type of advisory identifier
    "CVE"|"GHSA" 'type;
    # The value of the advisory identifer
    string value;
|};

# The policy that controls the repositories in the organization that are allowed to run GitHub Actions
public type EnabledRepositories "all"|"none"|"selected";

public type TagsProtectionBody record {
    # An optional glob pattern to match against when enforcing tag protection
    string pattern;
};

public type SelectedRepositoryIdsAnyOf1 int;

# Represents the Queries record for the operation: codespaces/get-codespaces-for-user-in-org
public type CodespacesGetCodespacesForUserInOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Review Dismissed Issue Event
public type ReviewDismissedIssueEvent record {
    # The user who dismissed the pull request review.
    SimpleUser actor;
    # The URL of the commit associated with this event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # Details about the review that was dismissed.
    @jsondata:Name {value: "dismissed_review"}
    ReviewDismissedIssueEventDismissedReview dismissedReview;
    # The GitHub App that performed this event, if any.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The timestamp when the review dismissal event occurred.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the issue event.
    int id;
    # The type of event that occurred on the issue.
    string event;
    # The SHA of the commit associated with this event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # The API URL of the issue event.
    string url;
    # The GraphQL node ID of the issue event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type CwesCwesOneOf12 string[];

# Represents the Queries record for the operation: gists/list-public
public type GistsListPublicQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

# The billing plan for the user
public type PublicUserPlan record {
    # Number of private repositories allowed under this billing plan.
    @jsondata:Name {value: "private_repos"}
    int privateRepos;
    # The name of the billing plan.
    string name;
    # Number of collaborators allowed under this billing plan.
    int collaborators;
    # Amount of storage space allocated under this billing plan in bytes.
    int space;
};

# License
public type License record {
    # Indicates whether the license is featured on GitHub.
    boolean featured;
    # Instructions on how to implement the license in a project.
    string implementation;
    # A brief description of the license.
    string description;
    # The full text body of the license.
    string body;
    # The SPDX identifier for the license.
    @jsondata:Name {value: "spdx_id"}
    string? spdxId;
    # The API URL for the license resource.
    string? url;
    # List of permissions granted by this license.
    string[] permissions;
    # The URL to the human-readable license page.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The full name of the license.
    string name;
    # List of conditions required by this license.
    string[] conditions;
    # The unique key identifier for the license.
    string 'key;
    # The GraphQL node ID for the license.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # List of limitations imposed by this license.
    string[] limitations;
};

public type PullRequestBaseRepo record {
    # Indicates whether forking of the repository is allowed.
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking?;
    # Indicates whether the repository is a template repository.
    @jsondata:Name {value: "is_template"}
    boolean isTemplate?;
    # Number of users who have starred the repository.
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount;
    # Timestamp of the most recent push to the repository.
    @jsondata:Name {value: "pushed_at"}
    string pushedAt;
    # API URL to manage subscription notifications for the repository.
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    # The primary programming language of the repository.
    string? language;
    # API URL template for the repository's branches.
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    # API URL template for issue comments in the repository.
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    # Indicates whether rebase merging is allowed for pull requests.
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge?;
    # API URL template for the repository's labels.
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # API URL listing subscribers watching the repository.
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    # The permissions the authenticated user has on this repository.
    RepoSearchResultItemPermissions permissions?;
    # Temporary token used for cloning the repository.
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    # API URL template for the repository's releases.
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    # The SVN URL for the repository.
    @jsondata:Name {value: "svn_url"}
    string svnUrl;
    # The unique numeric identifier for the repository.
    int id;
    # Indicates whether the repository has discussions enabled.
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions;
    # The name of the repository's master branch.
    @jsondata:Name {value: "master_branch"}
    string masterBranch?;
    # Number of forks of the repository.
    int forks;
    # API URL template for accessing archived contents of the repository.
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    # Indicates whether merge commits are allowed for pull requests.
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit?;
    # API URL template for the repository's Git refs.
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    # API URL listing forks of the repository.
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The repository visibility: public, private, or internal
    string visibility?;
    # API URL template for commit statuses in the repository.
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    # The SSH URL used to clone the repository.
    @jsondata:Name {value: "ssh_url"}
    string sshUrl;
    # The license associated with the repository.
    NullableLicenseSimple? license;
    # The full name of the repository including the owner, e.g., owner/repo.
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The size of the repository in kilobytes.
    int size;
    # API URL listing the languages used in the repository.
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    # API URL template for the repository's collaborators.
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    # The URL to the repository's GitHub page.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The HTTPS URL used to clone the repository.
    @jsondata:Name {value: "clone_url"}
    string cloneUrl;
    # The name of the repository.
    string name;
    # API URL template for pull requests in the repository.
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    # The default branch of the repository.
    @jsondata:Name {value: "default_branch"}
    string defaultBranch;
    # API URL for the repository's webhooks.
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    # API URL template for Git trees in the repository.
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    # API URL for the repository's tags.
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    # API URL listing contributors to the repository.
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    # Indicates whether the repository is private.
    boolean 'private;
    # Indicates whether the repository has downloads enabled.
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads;
    # API URL template for notifications related to the repository.
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    # Number of open issues in the repository.
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount;
    # A short description of the repository.
    string? description;
    # Number of users watching the repository.
    int watchers;
    # Timestamp when the repository was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # API URL for the repository's deployments.
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    # API URL template for the repository's deploy keys.
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    # Indicates whether the repository has projects enabled.
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects;
    # Indicates whether the repository is archived and read-only.
    boolean archived;
    # Indicates whether the repository has a wiki enabled.
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki;
    # Timestamp when the repository was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # API URL template for comments in the repository.
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # API URL listing users who have starred the repository.
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    # Indicates whether the repository has been disabled.
    boolean disabled;
    # The Git URL used to clone the repository.
    @jsondata:Name {value: "git_url"}
    string gitUrl;
    # Indicates whether the repository has GitHub Pages enabled.
    @jsondata:Name {value: "has_pages"}
    boolean hasPages;
    # The owner of the repository.
    PullRequestHeadRepoOwner owner;
    # Indicates whether squash merging is allowed for pull requests.
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge?;
    # API URL template for commits in the repository.
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    # API URL template for comparing commits in the repository.
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    # API URL template for Git commits in the repository.
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    # List of topic tags associated with the repository.
    string[] topics?;
    # API URL template for Git blobs in the repository.
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    # API URL template for Git tags in the repository.
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    # API URL for merges in the repository.
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    # API URL for the repository's downloads.
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    # Indicates whether the repository has issues enabled.
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues;
    # Indicates whether web-based commits must include a sign-off.
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    # The API URL for the repository resource.
    string url;
    # API URL template for the repository's file contents.
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    # The URL of the source repository if this is a mirror.
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl;
    # API URL template for the repository's milestones.
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    # API URL listing teams with access to the repository.
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    # Indicates whether the repository is a fork.
    boolean 'fork;
    # API URL template for issues in the repository.
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # API URL for events related to the repository.
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # API URL for events related to issues in the repository.
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    # API URL template for assignees in the repository.
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    # Number of currently open issues and pull requests.
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    # Number of users watching the repository for notifications.
    @jsondata:Name {value: "watchers_count"}
    int watchersCount;
    # The GraphQL node ID for the repository.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # Total number of forks of the repository.
    @jsondata:Name {value: "forks_count"}
    int forksCount;
    # The URL of the repository's associated website or homepage.
    string? homepage;
};

public type RepoImportBody record {
    # If authentication is required, the username to provide to vcs_url
    @jsondata:Name {value: "vcs_username"}
    string vcsUsername?;
    # If authentication is required, the password to provide to vcs_url
    @jsondata:Name {value: "vcs_password"}
    string vcsPassword?;
    # The URL of the originating repository
    @jsondata:Name {value: "vcs_url"}
    string vcsUrl;
    # For a tfvc import, the name of the project that is being imported
    @jsondata:Name {value: "tfvc_project"}
    string tfvcProject?;
    # The originating VCS type. Without this parameter, the import job will take additional time to detect the VCS type before beginning the import. This detection step will be reflected in the response
    "subversion"|"git"|"mercurial"|"tfvc" vcs?;
};

public type OrgMigrationsBody record {
    # Indicates whether metadata should be excluded and only git source should be included for the migration
    @jsondata:Name {value: "exclude_metadata"}
    boolean excludeMetadata = false;
    # A list of arrays indicating which repositories should be migrated
    string[] repositories;
    # Indicates whether the repository git data should be excluded from the migration
    @jsondata:Name {value: "exclude_git_data"}
    boolean excludeGitData = false;
    # Indicates whether attachments should be excluded from the migration (to reduce migration archive file size)
    @jsondata:Name {value: "exclude_attachments"}
    boolean excludeAttachments = false;
    # Indicates whether releases should be excluded from the migration (to reduce migration archive file size)
    @jsondata:Name {value: "exclude_releases"}
    boolean excludeReleases = false;
    # Indicates whether projects owned by the organization or users should be excluded. from the migration
    @jsondata:Name {value: "exclude_owner_projects"}
    boolean excludeOwnerProjects = false;
    # Indicates whether this should only include organization metadata (repositories array should be empty and will ignore other flags)
    @jsondata:Name {value: "org_metadata_only"}
    boolean orgMetadataOnly = false;
    # Exclude related items from being returned in the response in order to improve performance of the request
    ("repositories")[] exclude?;
    # Indicates whether repositories should be locked (to prevent manipulation) while migrating data
    @jsondata:Name {value: "lock_repositories"}
    boolean lockRepositories = false;
};

# Represents the Queries record for the operation: activity/list-org-events-for-authenticated-user
public type ActivityListOrgEventsForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type WorkflowRunUsageBillableUBUNTUJobRuns record {
    # The duration of the job run in milliseconds.
    @jsondata:Name {value: "duration_ms"}
    int durationMs;
    # The unique identifier of the workflow job.
    @jsondata:Name {value: "job_id"}
    int jobId;
};

# Milestoned Issue Event
public type MilestonedIssueEvent record {
    # The user who triggered the milestoned event.
    SimpleUser actor;
    # The API URL of the commit associated with the event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The GitHub App that performed this event, if applicable.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The milestone added to the issue.
    MilestonedIssueEventMilestone milestone;
    # Timestamp when the event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique numeric identifier for the event.
    int id;
    # The type of event that occurred.
    string event;
    # The SHA of the commit associated with the event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # The API URL for this event.
    string url;
    # The GraphQL node ID for the event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Secrets for a GitHub Codespace
public type CodespacesOrgSecret record {
    # The date and time at which the secret was created, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The type of repositories in the organization that the secret is visible to
    "all"|"private"|"selected" visibility;
    # The name of the secret
    string name;
    # The API URL at which the list of repositories this secret is visible to can be retrieved
    @jsondata:Name {value: "selected_repositories_url"}
    string selectedRepositoriesUrl?;
    # The date and time at which the secret was created, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "created_at"}
    string createdAt;
};

public type UsercodespacesOneOf1 record {
    # The geographic area for this codespace. If not specified, the value is assigned by IP. This property replaces location, which is being deprecated
    "EuropeWest"|"SoutheastAsia"|"UsEast"|"UsWest" geo?;
    # Path to devcontainer.json config to use for this codespace
    @jsondata:Name {value: "devcontainer_path"}
    string devcontainerPath?;
    # Git ref (typically a branch name) for this codespace
    string ref?;
    # Whether to authorize requested permissions from devcontainer.json
    @jsondata:Name {value: "multi_repo_permissions_opt_out"}
    boolean multiRepoPermissionsOptOut?;
    # Machine type to use for this codespace
    string machine?;
    # Repository id for this codespace
    @jsondata:Name {value: "repository_id"}
    int repositoryId;
    # The requested location for a new codespace. Best efforts are made to respect this upon creation. Assigned by IP if not provided
    string location?;
    # IP for location auto-detection when proxying a request
    @jsondata:Name {value: "client_ip"}
    string clientIp?;
    # Working directory for this codespace
    @jsondata:Name {value: "working_directory"}
    string workingDirectory?;
    # Duration in minutes after codespace has gone idle in which it will be deleted. Must be integer minutes between 0 and 43200 (30 days)
    @jsondata:Name {value: "retention_period_minutes"}
    int retentionPeriodMinutes?;
    # Display name for this codespace
    @jsondata:Name {value: "display_name"}
    string displayName?;
    # Time in minutes before codespace stops from inactivity
    @jsondata:Name {value: "idle_timeout_minutes"}
    int idleTimeoutMinutes?;
};

# Topic Search Result Item
public type TopicSearchResultItemResponse record {
    # Total number of topics matching the search query.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # Indicates whether the search results are incomplete.
    @jsondata:Name {value: "incomplete_results"}
    boolean incompleteResults;
    # List of topic search result items matching the query.
    TopicSearchResultItem[] items;
};

public type GitRefObject record {
    # The type of Git object the reference points to.
    string 'type;
    # SHA for the reference
    @constraint:String {maxLength: 40, minLength: 40}
    string sha;
    # The API URL for the Git reference object.
    string url;
};

public type PullNumberRequestedReviewersBody1 record {
    # An array of team slugs that will be removed
    @jsondata:Name {value: "team_reviewers"}
    string[] teamReviewers?;
    # An array of user logins that will be removed
    string[] reviewers;
};

# An export of a codespace. Also, latest export details for a codespace can be fetched with id = latest
public type CodespaceExportDetails record {
    # Completion time of the last export operation
    @jsondata:Name {value: "completed_at"}
    string? completedAt?;
    # Web url for the exported branch
    @jsondata:Name {value: "html_url"}
    string? htmlUrl?;
    # Url for fetching export details
    @jsondata:Name {value: "export_url"}
    string exportUrl?;
    # State of the latest export
    string? state?;
    # Id for the export details
    string id?;
    # Name of the exported branch
    string? branch?;
    # Git commit SHA of the exported branch
    string? sha?;
};

# Choose which environments must be successfully deployed to before refs can be merged into a branch that matches this rule
public type RepositoryRuleRequiredDeployments record {
    # The rule type identifier, always 'required_deployments'.
    "required_deployments" 'type;
    # Configuration parameters for the required deployments rule.
    RepositoryRuleRequiredDeploymentsParameters parameters?;
};

# License Simple
public type NullableLicenseSimple record {
    # The URL to the human-readable license page.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The full name of the license.
    string name;
    # The SPDX identifier for the license.
    @jsondata:Name {value: "spdx_id"}
    string? spdxId;
    # The unique key identifier for the license.
    string 'key;
    # The API URL for the license resource.
    string? url;
    # The GraphQL node ID for the license.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type ReactionRollup record {
    # Count of confused reactions on the subject.
    int confused;
    # Count of thumbs-down reactions on the subject.
    @jsondata:Name {value: "-1"}
    int minus1;
    # Total number of reactions on the subject.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # Count of thumbs-up reactions on the subject.
    @jsondata:Name {value: "+1"}
    int plus1;
    # Count of rocket reactions on the subject.
    int rocket;
    # Count of hooray reactions on the subject.
    int hooray;
    # Count of eyes reactions on the subject.
    int eyes;
    # The API URL for the reactions resource.
    string url;
    # Count of laugh reactions on the subject.
    int laugh;
    # Count of heart reactions on the subject.
    int heart;
};

# Hypermedia Link with Type
public type LinkWithType record {
    # The URL of the hypermedia link.
    string href;
    # The media type of the hypermedia link.
    string 'type;
};

# An object describing a symlink
public type ContentSymlink record {
    # The file path of the symlink within the repository.
    string path;
    # The size of the symlink target path in bytes.
    int size;
    # Hypermedia links related to the symlink content.
    @jsondata:Name {value: "_links"}
    ContentSymlinkLinks links;
    # The URL to view the symlink on GitHub.
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    # The name of the symlink file.
    string name;
    # The URL to download the symlink target file.
    @jsondata:Name {value: "download_url"}
    string? downloadUrl;
    # The content type, always 'symlink' for symlink objects.
    "symlink" 'type;
    # The API URL for the Git blob associated with the symlink.
    @jsondata:Name {value: "git_url"}
    string? gitUrl;
    # The SHA hash of the symlink object.
    string sha;
    # The API URL for the symlink content.
    string url;
    # The path the symlink points to.
    string target;
};

# Represents the Queries record for the operation: actions/list-repo-workflows
public type ActionsListRepoWorkflowsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# The permissions the collaborator has on the repository
public type NullableCollaboratorPermissions record {
    # Indicates whether the collaborator has pull (read) permission.
    boolean pull;
    # Indicates whether the collaborator has maintain permission.
    boolean maintain?;
    # Indicates whether the collaborator has admin permission.
    boolean admin;
    # Indicates whether the collaborator has triage permission.
    boolean triage?;
    # Indicates whether the collaborator has push (write) permission.
    boolean push;
};

# Represents the Queries record for the operation: actions/list-org-secrets
public type ActionsListOrgSecretsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type OrgPersonalAccessTokenRequestsBody record {
    # Reason for approving or denying the requests. Max 1024 characters
    string? reason?;
    # Unique identifiers of the requests for access via fine-grained personal access token. Must be formed of between 1 and 100 pat_request_id values
    @jsondata:Name {value: "pat_request_ids"}
    int[] patRequestIds?;
    # Action to apply to the requests
    "approve"|"deny" action;
};

# The object used to create GitHub Pages deployment
public type PagesDeploymentBody record {
    # The URL of an artifact that contains the .zip or .tar of static assets to deploy. The artifact belongs to the repository
    @jsondata:Name {value: "artifact_url"}
    string artifactUrl;
    # The target environment for this GitHub Pages deployment
    string environment = "github-pages";
    # The OIDC token issued by GitHub Actions certifying the origin of the deployment
    @jsondata:Name {value: "oidc_token"}
    string oidcToken;
    # A unique string that represents the version of the build for this deployment
    @jsondata:Name {value: "pages_build_version"}
    string pagesBuildVersion = "GITHUB_SHA";
};

# A workflow referenced/reused by the initial caller workflow
public type ReferencedWorkflow record {
    # The file path of the referenced workflow within the repository.
    string path;
    # The ref (branch or tag) of the referenced workflow.
    string ref?;
    # The commit SHA of the referenced workflow.
    string sha;
};

# A label for a self hosted runner
public type RunnerLabel record {
    # Name of the label
    string name;
    # Unique identifier of the label
    int id?;
    # The type of label. Read-only labels are applied automatically when the runner is configured
    "read-only"|"custom" 'type?;
};

# Represents the Queries record for the operation: actions/list-artifacts-for-repo
public type ActionsListArtifactsForRepoQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The name field of an artifact. When specified, only artifacts with this name will be returned
    string name?;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: issues/list-events
public type IssuesListEventsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: teams/list-child-legacy
public type TeamsListChildLegacyQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type RulesetsrulesetIdBody1 record {
    # The actors that can bypass the rules in this ruleset
    @jsondata:Name {value: "bypass_actors"}
    RepositoryRulesetBypassActor[] bypassActors?;
    # The name of the ruleset
    string name?;
    # The enforcement level of the ruleset.
    RepositoryRuleEnforcement enforcement?;
    # An array of rules within the ruleset
    RepositoryRule[] rules?;
    # The conditions that determine which refs the ruleset applies to.
    RepositoryRulesetConditions conditions?;
    # The target of the ruleset
    "branch"|"tag" target?;
};

public type ProtectionRulesAnyOf1 record {
    # The unique identifier of the protection rule.
    int id;
    # The wait timer duration before the environment can be deployed to.
    @jsondata:Name {value: "wait_timer"}
    WaitTimer waitTimer?;
    # The type of the protection rule.
    string 'type;
    # The GraphQL node identifier of the protection rule.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# A self hosted runner
public type RunnerResponse record {
    # The total number of self-hosted runners available.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of self-hosted runners.
    Runner[] runners;
};

# Represents the Queries record for the operation: apps/list-installations-for-authenticated-user
public type AppsListInstallationsForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type DiscussionNumberReactionsBody record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the team discussion
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

# GitHub account for managing multiple users, teams, and repositories
public type Organization record {
    # API URL for listing the organization's repositories
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    # Specifies if repository projects are enabled for repositories that belong to this org
    @jsondata:Name {value: "has_repository_projects"}
    boolean hasRepositoryProjects;
    # API URL template for listing the organization's members
    @jsondata:Name {value: "members_url"}
    string membersUrl;
    # A short description of the organization
    string? description;
    # The date the organization was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Unique login name of the organization
    string login;
    # Display blog url for the organization
    string blog?;
    # The type of the account
    string 'type;
    # API URL template for listing public members
    @jsondata:Name {value: "public_members_url"}
    string publicMembersUrl;
    # The date the organization was last updated
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Display company name for the organization
    string company?;
    # The unique identifier of the organization
    int id;
    # The number of public repositories in the organization
    @jsondata:Name {value: "public_repos"}
    int publicRepos;
    # The subscription plan associated with the organization.
    OrganizationPlan plan?;
    # Display email for the organization
    string email?;
    # Whether the organization's domain is verified
    @jsondata:Name {value: "is_verified"}
    boolean isVerified?;
    # The number of public gists in the organization
    @jsondata:Name {value: "public_gists"}
    int publicGists;
    # URL for the organization
    string url;
    # API URL for listing the organization's issues
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # The number of followers of the organization
    int followers;
    # URL of the organization's avatar image
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # API URL for listing the organization's events
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # Specifies if organization projects are enabled for this org
    @jsondata:Name {value: "has_organization_projects"}
    boolean hasOrganizationProjects;
    # URL of the organization's GitHub profile page
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The number of accounts the organization is following
    int following;
    # Display name for the organization
    string name?;
    # Display location for the organization
    string location?;
    # API URL for listing the organization's webhooks
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    # The GraphQL node identifier of the organization
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# A deployment created as the result of an Actions check run from a workflow that references an environment
public type DeploymentSimple record {
    # The API URL for listing the deployment's statuses.
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    # A short description of the deployment.
    string? description;
    # The date and time the deployment was created, in ISO 8601 format.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The API URL for the deployment.
    string url;
    # Name for the target deployment environment
    string environment;
    # Parameter to specify a task to execute
    string task;
    # The date and time the deployment was last updated, in ISO 8601 format.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The GitHub App that triggered the deployment, if applicable.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    # Specifies if the given environment is will no longer exist at some point in the future. Default: false
    @jsondata:Name {value: "transient_environment"}
    boolean transientEnvironment?;
    # The original target environment for the deployment.
    @jsondata:Name {value: "original_environment"}
    string originalEnvironment?;
    # Unique identifier of the deployment
    int id;
    # The API URL for the repository associated with the deployment.
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    # The GraphQL node identifier of the deployment.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # Specifies if the given environment is one that end-users directly interact with. Default: false
    @jsondata:Name {value: "production_environment"}
    boolean productionEnvironment?;
};

# A CodeQL database
public type CodeScanningCodeqlDatabase record {
    # The MIME type of the CodeQL database file
    @jsondata:Name {value: "content_type"}
    string contentType;
    # The size of the CodeQL database file in bytes
    int size;
    # The date and time at which the CodeQL database was last updated, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The commit SHA of the repository at the time the CodeQL database was created
    @jsondata:Name {value: "commit_oid"}
    string? commitOid?;
    # The user who uploaded the CodeQL database.
    SimpleUser uploader;
    # The name of the CodeQL database
    string name;
    # The date and time at which the CodeQL database was created, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The language of the CodeQL database
    string language;
    # The ID of the CodeQL database
    int id;
    # The URL at which to download the CodeQL database. The Accept header must be set to the value of the content_type property
    string url;
};

# Represents the Queries record for the operation: reactions/list-for-release
public type ReactionsListForReleaseQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to a release
    "+1"|"laugh"|"heart"|"hooray"|"rocket"|"eyes" content?;
};

public type CommunityProfileFiles record {
    # The issue template community health file for the repository.
    @jsondata:Name {value: "issue_template"}
    NullableCommunityHealthFile? issueTemplate;
    # The license associated with the repository.
    NullableLicenseSimple? license;
    # The code of conduct file community health file for the repository.
    @jsondata:Name {value: "code_of_conduct_file"}
    NullableCommunityHealthFile? codeOfConductFile;
    # The contributing guidelines community health file for the repository.
    NullableCommunityHealthFile? contributing;
    # The README community health file for the repository.
    NullableCommunityHealthFile? readme;
    # The pull request template community health file for the repository.
    @jsondata:Name {value: "pull_request_template"}
    NullableCommunityHealthFile? pullRequestTemplate;
    # The code of conduct associated with the repository.
    @jsondata:Name {value: "code_of_conduct"}
    NullableCodeOfConductSimple? codeOfConduct;
};

# Unassigned Issue Event
public type UnassignedIssueEvent record {
    # The user who triggered the unassigned event.
    SimpleUser actor;
    # The URL of the commit associated with the event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The GitHub App that performed the unassigned event.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The user who removed the assignee from the issue.
    SimpleUser assigner;
    # The date and time the event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Unique identifier of the issue event.
    int id;
    # The user who was unassigned from the issue.
    SimpleUser assignee;
    # The type of event that occurred on the issue.
    string event;
    # The SHA of the commit associated with the event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # The API URL for the issue event.
    string url;
    # The GraphQL node ID of the issue event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type HookDeliveryResponse record {
    # The response headers received when the delivery was made
    record {}? headers;
    # The response payload received
    record {}? payload;
};

public type PageBuildError record {
    # The error message describing the GitHub Pages build failure.
    string? message;
};

# Information of a job execution in a workflow run
public type JobResponse record {
    # The total number of jobs in the workflow run.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of jobs in the workflow run.
    Job[] jobs;
};

public type PackagesBillingUsage record {
    # Free storage space (GB) for GitHub Packages
    @jsondata:Name {value: "included_gigabytes_bandwidth"}
    int includedGigabytesBandwidth;
    # Sum of the free and paid storage space (GB) for GitHuub Packages
    @jsondata:Name {value: "total_gigabytes_bandwidth_used"}
    int totalGigabytesBandwidthUsed;
    # Total paid storage space (GB) for GitHuub Packages
    @jsondata:Name {value: "total_paid_gigabytes_bandwidth_used"}
    int totalPaidGigabytesBandwidthUsed;
};

public type BranchProtectionBody record {
    # Whether to set the branch as read-only. If this is true, users will not be able to push to the branch. Default: false
    @jsondata:Name {value: "lock_branch"}
    boolean lockBranch = false;
    # Settings for required pull request reviews before merging.
    @jsondata:Name {value: "required_pull_request_reviews"}
    ReposownerrepobranchesbranchprotectionRequiredPullRequestReviews? requiredPullRequestReviews;
    # If set to true, the restrictions branch protection settings which limits who can push will also block pushes which create new branches, unless the push is initiated by a user, team, or app which has the ability to push. Set to true to restrict new branch creation. Default: false
    @jsondata:Name {value: "block_creations"}
    boolean blockCreations?;
    # Requires all conversations on code to be resolved before a pull request can be merged into a branch that matches this rule. Set to false to disable. Default: false
    @jsondata:Name {value: "required_conversation_resolution"}
    boolean requiredConversationResolution?;
    # Settings for required status checks before merging.
    @jsondata:Name {value: "required_status_checks"}
    ReposownerrepobranchesbranchprotectionRequiredStatusChecks? requiredStatusChecks;
    # Whether users can pull changes from upstream when the branch is locked. Set to true to allow fork syncing. Set to false to prevent fork syncing. Default: false
    @jsondata:Name {value: "allow_fork_syncing"}
    boolean allowForkSyncing = false;
    # Restrictions on who can push to the protected branch.
    ReposownerrepobranchesbranchprotectionRestrictions? restrictions;
    # Enforces a linear commit Git history, which prevents anyone from pushing merge commits to a branch. Set to true to enforce a linear commit history. Set to false to disable a linear commit Git history. Your repository must allow squash merging or rebase merging before you can enable a linear commit history. Default: false. For more information, see "[Requiring a linear commit history](https://docs.github.com/github/administering-a-repository/requiring-a-linear-commit-history)" in the GitHub Help documentation
    @jsondata:Name {value: "required_linear_history"}
    boolean requiredLinearHistory?;
    # Enforce all configured restrictions for administrators. Set to true to enforce required status checks for repository administrators. Set to null to disable
    @jsondata:Name {value: "enforce_admins"}
    boolean? enforceAdmins;
    # Allows deletion of the protected branch by anyone with write access to the repository. Set to false to prevent deletion of the protected branch. Default: false. For more information, see "[Enabling force pushes to a protected branch](https://docs.github.com/github/administering-a-repository/enabling-force-pushes-to-a-protected-branch)" in the GitHub Help documentation
    @jsondata:Name {value: "allow_deletions"}
    boolean allowDeletions?;
    # Permits force pushes to the protected branch by anyone with write access to the repository. Set to true to allow force pushes. Set to false or null to block force pushes. Default: false. For more information, see "[Enabling force pushes to a protected branch](https://docs.github.com/github/administering-a-repository/enabling-force-pushes-to-a-protected-branch)" in the GitHub Help documentation."
    @jsondata:Name {value: "allow_force_pushes"}
    boolean? allowForcePushes?;
};

# Issue Search Result Item
public type IssueSearchResultItemResponse record {
    # The total number of issues matching the search query.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # Indicates whether the search results are incomplete.
    @jsondata:Name {value: "incomplete_results"}
    boolean incompleteResults;
    # The list of issues matching the search query.
    IssueSearchResultItem[] items;
};

# Groups of organization members that gives permissions on specified repositories
public type NullableTeamSimple record {
    # The API URL listing repositories accessible to the team.
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
    # The API URL template listing members of the team.
    @jsondata:Name {value: "members_url"}
    string membersUrl;
    # Description of the team
    string? description;
    # The level of privacy this team should have
    string privacy?;
    # Permission that the team will have for its repositories
    string permission;
    # URL for the team
    string url;
    # The notification setting the team has set
    @jsondata:Name {value: "notification_setting"}
    string notificationSetting?;
    # Distinguished Name (DN) that team maps to within LDAP environment
    @jsondata:Name {value: "ldap_dn"}
    string ldapDn?;
    # The GitHub web URL for the team's page.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Name of the team
    string name;
    # Unique identifier of the team
    int id;
    # The URL-friendly identifier for the team.
    string slug;
    # The GraphQL node ID of the team.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type OrgHookConfig record {
    # The media type used to serialize payloads sent to the webhook.
    @jsondata:Name {value: "content_type"}
    string contentType?;
    # Indicates whether SSL verification is skipped for webhook delivery.
    @jsondata:Name {value: "insecure_ssl"}
    string insecureSsl?;
    # The shared secret used to sign webhook payloads.
    string secret?;
    # The URL to which webhook payloads are delivered.
    string url?;
};

# Represents the Queries record for the operation: checks/list-for-suite
public type ChecksListForSuiteQueries record {
    # Filters check runs by their completed_at timestamp. latest returns the most recent check runs
    "latest"|"all" filter = "latest";
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Returns check runs with the specified name
    @http:Query {name: "check_name"}
    string checkName?;
    # Page number of the results to fetch
    int page = 1;
    # Returns check runs with the specified status
    "queued"|"in_progress"|"completed" status?;
};

# Represents the Queries record for the operation: actions/get-actions-cache-list
public type ActionsGetActionsCacheListQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The full Git reference for narrowing down the cache. The ref for a branch should be formatted as refs/heads/<branch name>. To reference a pull request use refs/pull/<number>/merge
    string ref?;
    # Page number of the results to fetch
    int page = 1;
    # The property to sort the results by. created_at means when the cache was created. last_accessed_at means when the cache was last accessed. size_in_bytes is the size of the cache in bytes
    "created_at"|"last_accessed_at"|"size_in_bytes" sort = "last_accessed_at";
    # An explicit key or prefix for identifying the cache
    string 'key?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# Represents the Queries record for the operation: users/list-gpg-keys-for-authenticated-user
public type UsersListGpgKeysForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type GistsFiles record {
    # Content of the file
    string content;
};

# Parameters to be used for the committer_email_pattern rule
public type RepositoryRuleCommitterEmailPattern record {
    # The rule type identifier, always 'committer_email_pattern'.
    "committer_email_pattern" 'type;
    # The parameters defining the committer email pattern rule.
    RepositoryRuleBranchNamePatternParameters parameters?;
};

# Unlabeled Issue Event
public type UnlabeledIssueEvent record {
    # The user who triggered the unlabeled event.
    SimpleUser actor;
    # The URL of the commit associated with the event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The GitHub App that performed the unlabeled event.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The date and time the event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Unique identifier of the issue event.
    int id;
    # The label that was removed from the issue.
    UnlabeledIssueEventLabel label;
    # The type of event that occurred on the issue.
    string event;
    # The SHA of the commit associated with the event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # The API URL for the issue event.
    string url;
    # The GraphQL node ID of the issue event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Pull Request Review Request
public type PullRequestReviewRequest record {
    # The list of teams requested to review the pull request.
    Team[] teams;
    # The list of users requested to review the pull request.
    SimpleUser[] users;
};

# The commit statistics showing additions, deletions, and total changes
public type CommitStats record {
    # The total number of lines changed in the commit.
    int total?;
    # The number of lines added in the commit.
    int additions?;
    # The number of lines deleted in the commit.
    int deletions?;
};

# State of a code scanning alert
public type CodeScanningAlertState "open"|"dismissed"|"fixed";

public type CommentNumberReactionsBody record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the team discussion comment
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

public type UserSocialAccountsBody record {
    # Full URLs for the social media profiles to add
    @jsondata:Name {value: "account_urls"}
    string[] accountUrls;
};

public type RuleSuiteRuleEvaluations record {
    # The source ruleset or rule that was evaluated.
    @jsondata:Name {value: "rule_source"}
    RuleSuiteRuleSource ruleSource?;
    # The result of the evaluation of the individual rule
    "pass"|"fail" result?;
    # The type of rule
    @jsondata:Name {value: "rule_type"}
    string ruleType?;
    # The enforcement level of this rule source
    "active"|"evaluate"|"deleted ruleset" enforcement?;
    # Any associated details with the rule evaluation
    string details?;
};

# The base branch of the pull request
public type PullRequestSimpleBase record {
    # The branch name of the base branch.
    string ref;
    # The repository that the base branch belongs to.
    Repository repo;
    # The label identifying the base branch with its owner.
    string label;
    # The SHA of the latest commit on the base branch.
    string sha;
    # The user associated with the base branch.
    NullableSimpleUser? user;
};

# Webhooks for repositories
public type Hook record {
    # The URL used to test the webhook delivery.
    @jsondata:Name {value: "test_url"}
    string testUrl;
    # Determines whether the hook is actually triggered on pushes
    boolean active;
    # The date and time the webhook was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The type of webhook.
    string 'type;
    # The API URL for the webhook.
    string url;
    # The date and time the webhook was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The name of a valid service, use 'web' for a webhook
    string name;
    # Unique identifier of the webhook
    int id;
    # The last response received from the webhook endpoint.
    @jsondata:Name {value: "last_response"}
    HookResponse lastResponse;
    # Configuration settings for the webhook.
    HookConfig config;
    # The URL used to ping the webhook.
    @jsondata:Name {value: "ping_url"}
    string pingUrl;
    # Determines what events the hook is triggered for. Default: ['push']
    string[] events;
    # The API URL listing deliveries for this webhook.
    @jsondata:Name {value: "deliveries_url"}
    string deliveriesUrl?;
};

# Installation
public type Installation record {
    # The API URL to create access tokens for the installation.
    @jsondata:Name {value: "access_tokens_url"}
    string accessTokensUrl;
    # The API URL listing repositories accessible to the installation.
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
    # The type of account the installation targets, such as User or Organization.
    @jsondata:Name {value: "target_type"}
    string targetType;
    # The single file path the installation is granted access to.
    @jsondata:Name {value: "single_file_name"}
    string? singleFileName;
    # The date and time the installation was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The ID of the user or organization this token is being scoped to
    @jsondata:Name {value: "target_id"}
    int targetId;
    # The contact email address associated with the installation.
    @jsondata:Name {value: "contact_email"}
    string? contactEmail?;
    # Describe whether all repositories have been selected or there's a selection involved
    @jsondata:Name {value: "repository_selection"}
    "all"|"selected" repositorySelection;
    # The URL-friendly slug identifier for the GitHub App.
    @jsondata:Name {value: "app_slug"}
    string appSlug;
    # The user who suspended the installation, if applicable.
    @jsondata:Name {value: "suspended_by"}
    NullableSimpleUser? suspendedBy;
    # The date and time the installation was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The permissions granted to the installation.
    AppPermissions permissions;
    # The GitHub web URL for the GitHub App's installation page.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Indicates whether the installation has access to multiple single files.
    @jsondata:Name {value: "has_multiple_single_files"}
    boolean hasMultipleSingleFiles?;
    # The ID of the installation
    int id;
    # The ID of the GitHub App associated with this installation.
    @jsondata:Name {value: "app_id"}
    int appId;
    # The list of file paths the installation is granted single-file access to.
    @jsondata:Name {value: "single_file_paths"}
    string[] singleFilePaths?;
    # The account (user or organization) where the app is installed.
    SimpleUser|Enterprise? account;
    # The list of events the installation is subscribed to.
    string[] events;
    # The date and time the installation was suspended.
    @jsondata:Name {value: "suspended_at"}
    string? suspendedAt;
};

# Runner Application
public type RunnerApplication record {
    # The SHA-256 checksum of the runner application download.
    @jsondata:Name {value: "sha256_checksum"}
    string sha256Checksum?;
    # The filename of the runner application package.
    string filename;
    # The operating system the runner application targets.
    string os;
    # A short lived bearer token used to download the runner, if needed
    @jsondata:Name {value: "temp_download_token"}
    string tempDownloadToken?;
    # The URL to download the runner application.
    @jsondata:Name {value: "download_url"}
    string downloadUrl;
    # The CPU architecture the runner application targets.
    string architecture;
};

# Issue Event Milestone
public type IssueEventMilestone record {
    # The title of the milestone associated with the issue event.
    string title;
};

# Check suite configuration preferences for a repository
public type CheckSuitePreference record {
    # The auto-trigger preferences for check suites on the repository.
    CheckSuitePreferencePreferences preferences;
    # The repository to which the check suite preferences apply.
    MinimalRepository repository;
};

public type GistsgistIdFiles record {
    # The new filename for the file
    string? filename?;
    # The new content of the file
    string content?;
};

# Represents the Queries record for the operation: search/labels
public type SearchLabelsQueries record {
    # The search keywords. This endpoint does not accept qualifiers in the query. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query)
    string q;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The id of the repository
    @http:Query {name: "repository_id"}
    int repositoryId;
    # Sorts the results of your query by when the label was created or updated. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    "created"|"updated" sort?;
    # Page number of the results to fetch
    int page = 1;
    # Determines whether the first search result returned is the highest number of matches (desc) or lowest number of matches (asc). This parameter is ignored unless you provide sort
    "desc"|"asc" 'order = "desc";
};

# Represents the Queries record for the operation: search/repos
public type SearchReposQueries record {
    # The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching for repositories](https://docs.github.com/articles/searching-for-repositories/)" for a detailed list of qualifiers
    string q;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Sorts the results of your query by number of stars, forks, or help-wanted-issues or how recently the items were updated. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    "stars"|"forks"|"help-wanted-issues"|"updated" sort?;
    # Page number of the results to fetch
    int page = 1;
    # Determines whether the first search result returned is the highest number of matches (desc) or lowest number of matches (asc). This parameter is ignored unless you provide sort
    "desc"|"asc" 'order = "desc";
};

public type TimelineCommittedEventVerification record {
    # The reason for the verification status of the commit signature.
    string reason;
    # The cryptographic signature used to verify the commit.
    string? signature;
    # The signed data payload used for commit signature verification.
    string? payload;
    # Indicates whether the commit signature has been verified.
    boolean verified;
};

# Represents the Queries record for the operation: teams/list
public type TeamsListQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# The license information for the repository
public type MinimalRepositoryLicense record {
    # The full name of the repository's license.
    string name?;
    # The SPDX identifier for the license.
    @jsondata:Name {value: "spdx_id"}
    string spdxId?;
    # The unique key identifier for the license.
    string 'key?;
    # The API URL for the license details.
    string? url?;
    # The GraphQL node ID of the license.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# Represents the Queries record for the operation: actions/list-environment-secrets
public type ActionsListEnvironmentSecretsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: repos/list-tags
public type ReposListTagsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# An enterprise on GitHub
public type Enterprise record {
    # The enterprise's website URL
    @jsondata:Name {value: "website_url"}
    string? websiteUrl?;
    # The date and time the enterprise was last updated.
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    # The URL of the enterprise's avatar image.
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # The GitHub web URL for the enterprise's page.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The name of the enterprise
    string name;
    # A short description of the enterprise
    string? description?;
    # The date and time the enterprise was created.
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    # Unique identifier of the enterprise
    int id;
    # The slug url identifier for the enterprise
    string slug;
    # The GraphQL node ID of the enterprise.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Whether users can pull changes from upstream when the branch is locked. Set to true to allow fork syncing. Set to false to prevent fork syncing
public type ProtectedBranchAllowForkSyncing record {|
    # Indicates whether fork syncing is allowed for the locked branch.
    boolean enabled = false;
|};

# Represents the Queries record for the operation: repos/get-repo-ruleset
public type ReposGetRepoRulesetQueries record {
    # Include rulesets configured at higher levels that apply to this repository
    @http:Query {name: "includes_parents"}
    boolean includesParents = true;
};

# Key/value pairs to provide settings for this webhook
public type ReposownerrepohookshookIdConfig record {
    # The address used for certain webhook service integrations.
    string address?;
    # The media type used to serialize payloads sent to the webhook.
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    # Determines whether SSL verification is skipped for webhook delivery.
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    # The shared secret used to sign webhook payloads.
    WebhookConfigSecret secret?;
    # The URL to which webhook payloads are delivered.
    WebhookConfigUrl url;
    # The chat room identifier for certain webhook service integrations.
    string room?;
};

# Represents the Queries record for the operation: users/list-followed-by-authenticated-user
public type UsersListFollowedByAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type MarketplacePurchaseMarketplacePendingChange record {
    # Indicates whether the Marketplace plan is currently installed.
    @jsondata:Name {value: "is_installed"}
    boolean isInstalled?;
    # The date when the pending plan change takes effect.
    @jsondata:Name {value: "effective_date"}
    string effectiveDate?;
    # Unique identifier of the pending Marketplace change.
    int id?;
    # The Marketplace listing plan associated with the pending change.
    MarketplaceListingPlan plan?;
    # The number of units for the pending Marketplace plan change.
    @jsondata:Name {value: "unit_count"}
    int? unitCount?;
};

public type CommitSearchResultItemCommitTree record {
    # The SHA of the Git tree object for the commit.
    string sha;
    # The API URL for the Git tree object.
    string url;
};

# Metaproperties for Git author/committer information
public type NullableGitUser record {
    # The date and time associated with the Git author or committer.
    string date?;
    # The name of the Git author or committer.
    string name?;
    # The email address of the Git author or committer.
    string email?;
};

public type RunnerIdLabelsBody record {
    # The names of the custom labels to set for the runner. You can pass an empty array to remove all custom labels
    @constraint:Array {maxLength: 100}
    string[] labels;
};

public type TeamRepositoryPermissions record {
    # Indicates whether the team has pull (read) access to the repository.
    boolean pull;
    # Indicates whether the team has maintain access to the repository.
    boolean maintain?;
    # Indicates whether the team has admin access to the repository.
    boolean admin;
    # Indicates whether the team has triage access to the repository.
    boolean triage?;
    # Indicates whether the team has push (write) access to the repository.
    boolean push;
};

# The name of the tool used to generate the code scanning analysis
public type CodeScanningAnalysisToolName string;

public type ReleasesGenerateNotesBody record {
    # The tag name for the release. This can be an existing tag or a new one
    @jsondata:Name {value: "tag_name"}
    string tagName;
    # Specifies the commitish value that will be the target for the release's tag. Required if the supplied tag_name does not reference an existing tag. Ignored if the tag_name already exists
    @jsondata:Name {value: "target_commitish"}
    string targetCommitish?;
    # The name of the previous tag to use as the starting point for the release notes. Use to manually specify the range for the set of changes considered as part this release
    @jsondata:Name {value: "previous_tag_name"}
    string previousTagName?;
    # Specifies a path to a file in the repository containing configuration settings used for generating the release notes. If unspecified, the configuration file located in the repository at '.github/release.yml' or '.github/release.yaml' will be used. If that is not present, the default configuration will be used
    @jsondata:Name {value: "configuration_file_path"}
    string configurationFilePath?;
};

public type WebhookConfigInsecureSslWebhookConfigInsecureSslOneOf12 decimal;

public type GitCommitsBody record {
    # The person who committed the code to the repository.
    ReposownerrepogitcommitsCommitter committer?;
    # The [PGP signature](https://en.wikipedia.org/wiki/Pretty_Good_Privacy) of the commit. GitHub adds the signature to the gpgsig header of the created commit. For a commit signature to be verifiable by Git or GitHub, it must be an ASCII-armored detached PGP signature over the string commit as it would be written to the object database. To pass a signature parameter, you need to first manually create a valid PGP signature, which can be complicated. You may find it easier to [use the command line](https://git-scm.com/book/id/v2/Git-Tools-Signing-Your-Work) to create signed commits
    string signature?;
    # The person who originally authored the commit.
    ReposownerrepogitcommitsAuthor author?;
    # The SHA of the tree object this commit points to
    string tree;
    # The commit message
    string message;
    # The SHAs of the commits that were the parents of this commit. If omitted or empty, the commit will be written as a root commit. For a single parent, an array of one SHA should be provided; for a merge commit, an array of more than one should be provided
    string[] parents?;
};

# Represents the Queries record for the operation: orgs/list-for-authenticated-user
public type OrgsListForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: gists/list-forks
public type GistsListForksQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# object containing information about the committer
public type ReposownerrepocontentspathCommitter1 record {
    # The name of the author (or committer) of the commit
    string name?;
    # The email of the author (or committer) of the commit
    string email?;
};

# The name of the package affected by the vulnerability
public type GlobalAdvisoryPackage record {
    # The package ecosystem in which the vulnerability exists.
    SecurityAdvisoryEcosystems ecosystem;
    # The unique package name within its ecosystem
    string? name;
};

public type EmailVisibilityBody record {
    # Denotes whether an email is publicly visible
    "public"|"private" visibility;
};

public type Affects AffectsOneOf1|AffectsAffectsOneOf12;

public type IssueNumberLockBody record {
    # The reason for locking the issue or pull request conversation. Lock will fail if you don't use one of these reasons:  
    #  * off-topic  
    #  * too heated  
    #  * resolved  
    #  * spam
    @jsondata:Name {value: "lock_reason"}
    "off-topic"|"too heated"|"resolved"|"spam" lockReason?;
};

public type OrgRulesetsBody record {
    # The actors that can bypass the rules in this ruleset
    @jsondata:Name {value: "bypass_actors"}
    RepositoryRulesetBypassActor[] bypassActors?;
    # The name of the ruleset
    string name;
    # The enforcement level of the ruleset.
    RepositoryRuleEnforcement enforcement;
    # An array of rules within the ruleset
    RepositoryRule[] rules?;
    # The conditions that determine which repositories the ruleset applies to.
    OrgRulesetConditions conditions?;
    # The target of the ruleset
    "branch"|"tag" target?;
};

# The URL to which the payloads will be delivered
public type WebhookConfigUrl string;

# Represents the Queries record for the operation: actions/list-repo-variables
public type ActionsListRepoVariablesQueries record {
    # The number of results per page (max 30)
    @http:Query {name: "per_page"}
    int perPage = 10;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: issues/list-labels-for-milestone
public type IssuesListLabelsForMilestoneQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Information about the author of the commit. By default, the author will be the authenticated user and the current date. See the author and committer object below for details
public type ReposownerrepogitcommitsAuthor record {
    # Indicates when this commit was authored (or committed). This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string date?;
    # The name of the author (or committer) of the commit
    string name;
    # The email of the author (or committer) of the commit
    string email;
};

public type ProtectionRequiredStatusChecksBody record {
    # The list of status checks to require in order to merge into this branch
    ReposownerrepobranchesbranchprotectionRequiredStatusChecksChecks[] checks?;
    # **Deprecated**: The list of status checks to require in order to merge into this branch. If any of these checks have recently been set by a particular GitHub App, they will be required to come from that app in future for the branch to merge. Use checks instead of contexts for more fine-grained control
    # 
    # # Deprecated
    @deprecated
    string[] contexts?;
    # Require branches to be up to date before merging
    boolean strict?;
};

# Required status check
public type RepositoryRuleParamsStatusCheckConfiguration record {
    # The optional integration ID that this status check must originate from
    @jsondata:Name {value: "integration_id"}
    int integrationId?;
    # The status check context name that must be present on the commit
    string context;
};

public type RequiredStatusChecksContextsBody ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf1|ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsreposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf12;

public type LabelsOneOf13 string;

public type CommentIdRepliesBody record {
    # The text of the review comment
    string body;
};

# Collaborator
public type NullableCollaborator record {
    # API URL template for the user's gists
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    # API URL to list the user's repositories
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    # API URL template to check who the user is following
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    # API URL template for repositories the user has starred
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    # The username of the user
    string login;
    # API URL to list the user's followers
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    # The type of the account
    string 'type;
    # API URL for the user
    string url;
    # The role name assigned to the collaborator
    @jsondata:Name {value: "role_name"}
    string roleName;
    # API URL to list repositories the user is watching
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    # API URL for events received by the user
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    # URL of the user's avatar image
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # API URL template for the user's events
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # The permission levels granted to the collaborator on the repository.
    NullableCollaboratorPermissions permissions?;
    # URL of the user's GitHub profile page
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The display name of the user
    string? name?;
    # Whether the user is a GitHub site administrator
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    # The unique identifier of the user
    int id;
    # The Gravatar ID of the user
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    # The publicly visible email address of the user
    string? email?;
    # The GraphQL node identifier of the user
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # API URL to list the user's organizations
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
};

public type GistsBody record {
    # Whether the gist is public or private.
    boolean|"true"|"false" 'public?;
    # Description of the gist
    string description?;
    # Names and content for the files that make up the gist
    record {|GistsFiles...;|} files;
};

# Represents the Queries record for the operation: actions/get-workflow-run-attempt
public type ActionsGetWorkflowRunAttemptQueries record {
    # If true pull requests are omitted from the response (empty array)
    @http:Query {name: "exclude_pull_requests"}
    boolean excludePullRequests = false;
};

# Represents the Queries record for the operation: orgs/list-pat-grant-request-repositories
public type OrgsListPatGrantRequestRepositoriesQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Feed
public type Feed record {
    # URL for the feed of public security advisories.
    @jsondata:Name {value: "security_advisories_url"}
    string securityAdvisoriesUrl?;
    # Hypermedia links for the feed resources.
    @jsondata:Name {value: "_links"}
    FeedLinks links;
    # URL for the authenticated user's activity feed.
    @jsondata:Name {value: "current_user_url"}
    string currentUserUrl?;
    # URL for the authenticated user's organization activity feed.
    @jsondata:Name {value: "current_user_organization_url"}
    string currentUserOrganizationUrl?;
    # List of URLs for each of the authenticated user's organization feeds.
    @jsondata:Name {value: "current_user_organization_urls"}
    string[] currentUserOrganizationUrls?;
    # URL template for a given user's public activity feed.
    @jsondata:Name {value: "user_url"}
    string userUrl;
    # A feed of discussions for a given repository
    @jsondata:Name {value: "repository_discussions_url"}
    string repositoryDiscussionsUrl?;
    # URL for the authenticated user's activity feed as an actor.
    @jsondata:Name {value: "current_user_actor_url"}
    string currentUserActorUrl?;
    # A feed of discussions for a given repository and category
    @jsondata:Name {value: "repository_discussions_category_url"}
    string repositoryDiscussionsCategoryUrl?;
    # URL for the authenticated user's public activity feed.
    @jsondata:Name {value: "current_user_public_url"}
    string currentUserPublicUrl?;
    # URL for the authenticated user's timeline feed.
    @jsondata:Name {value: "timeline_url"}
    string timelineUrl;
};

# Details about the codespace's git repository
public type CodespaceGitStatus record {
    # The number of commits the local repository is behind the remote
    int behind?;
    # The current branch (or SHA if in detached HEAD state) of the local repository
    string ref?;
    # The number of commits the local repository is ahead of the remote
    int ahead?;
    # Whether the local repository has unpushed changes
    @jsondata:Name {value: "has_unpushed_changes"}
    boolean hasUnpushedChanges?;
    # Whether the local repository has uncommitted changes
    @jsondata:Name {value: "has_uncommitted_changes"}
    boolean hasUncommittedChanges?;
};

# Represents the Queries record for the operation: orgs/list-for-user
public type OrgsListForUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Dev Containers
public type DevcontainersResponse record {
    # List of dev container configurations found in the repository.
    Devcontainers[] devcontainers;
    # The total number of dev container configurations.
    @jsondata:Name {value: "total_count"}
    int totalCount;
};

# Public User
public type PublicUser record {|
    # API URL template for the user's gists
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    # API URL to list the user's repositories
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    # API URL template to check who the user is following
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    # The Twitter username of the user
    @jsondata:Name {value: "twitter_username"}
    string? twitterUsername?;
    # The biography of the user
    string? bio;
    # The date the user account was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The username of the user
    string login;
    # The type of the account
    string 'type;
    # The URL of the user's blog or website
    string? blog;
    # The number of private gists the user owns
    @jsondata:Name {value: "private_gists"}
    int privateGists?;
    # The total number of private repositories the user owns
    @jsondata:Name {value: "total_private_repos"}
    int totalPrivateRepos?;
    # API URL to list repositories the user is watching
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    # The date the user account was last updated
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Whether the user is a GitHub site administrator
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    # The total disk usage across all repositories in kilobytes
    @jsondata:Name {value: "disk_usage"}
    int diskUsage?;
    # The number of collaborators across the user's private repositories
    int collaborators?;
    # The company the user belongs to
    string? company;
    # The number of private repositories owned by the user
    @jsondata:Name {value: "owned_private_repos"}
    int ownedPrivateRepos?;
    # The unique identifier of the user
    int id;
    # The number of public repositories the user owns
    @jsondata:Name {value: "public_repos"}
    int publicRepos;
    # The Gravatar ID of the user
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    # The subscription plan associated with the user's account.
    PublicUserPlan plan?;
    # The publicly visible email address of the user
    string? email;
    # API URL to list the user's organizations
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
    # Whether the user is available for hire
    boolean? hireable;
    # API URL template for repositories the user has starred
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    # API URL to list the user's followers
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    # The number of public gists the user owns
    @jsondata:Name {value: "public_gists"}
    int publicGists;
    # API URL for the user
    string url;
    # API URL for events received by the user
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    # The number of followers the user has
    int followers;
    # URL of the user's avatar image
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # API URL template for the user's events
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # URL of the user's GitHub profile page
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The number of users the user is following
    int following;
    # The display name of the user
    string? name;
    # The geographic location of the user
    string? location;
    # The GraphQL node identifier of the user
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The date the user account was suspended
    @jsondata:Name {value: "suspended_at"}
    string? suspendedAt?;
|};

public type LabelsOneOf12 string;

public type LabelsOneOf11 string;

# Represents the Queries record for the operation: activity/list-watched-repos-for-authenticated-user
public type ActivityListWatchedReposForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type HookDeliveryRequest record {
    # The request headers sent with the webhook delivery
    record {}? headers;
    # The webhook payload
    record {}? payload;
};

public type InteractionLimitResponseAnyAnyOf2 record {|
|};

# Represents the Queries record for the operation: codespaces/list-in-organization
public type CodespacesListInOrganizationQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Data related to a release
public type ReleaseAsset record {
    # The date and time the release asset was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The URL to download the release asset via a browser.
    @jsondata:Name {value: "browser_download_url"}
    string browserDownloadUrl;
    # An optional display label for the release asset.
    string? label;
    # API URL for the release asset.
    string url;
    # The number of times the release asset has been downloaded.
    @jsondata:Name {value: "download_count"}
    int downloadCount;
    # The MIME type of the release asset.
    @jsondata:Name {value: "content_type"}
    string contentType;
    # The size of the release asset in bytes.
    int size;
    # The date and time the release asset was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The user who uploaded the release asset.
    NullableSimpleUser? uploader;
    # The file name of the asset
    string name;
    # The unique identifier of the release asset.
    int id;
    # State of the release asset
    "uploaded"|"open" state;
    # The GraphQL node identifier of the release asset.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents an 'issue_title' secret scanning location type. This location type shows that a secret was detected in the title of an issue
public type SecretScanningLocationIssueTitle record {
    # The API URL to get the issue where the secret was detected
    @jsondata:Name {value: "issue_title_url"}
    string issueTitleUrl;
};

# Repo Search Result Item
public type RepoSearchResultItemResponse record {
    # The total number of repositories matching the search query.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # Whether the search results are incomplete due to a timeout.
    @jsondata:Name {value: "incomplete_results"}
    boolean incompleteResults;
    # The list of repositories matching the search query.
    RepoSearchResultItem[] items;
};

# Represents the Queries record for the operation: pulls/list-comments-for-review
public type PullsListCommentsForReviewQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type PersonalAccessTokenRequestspatRequestIdBody record {
    # Reason for approving or denying the request. Max 1024 characters
    string? reason?;
    # Action to apply to the request
    "approve"|"deny" action;
};

# Hypermedia links for the review comment
public type ReviewCommentLinks record {
    # Hypermedia link to the pull request the comment belongs to.
    @jsondata:Name {value: "pull_request"}
    Link pullRequest;
    # Hypermedia link to the review comment itself.
    Link self;
    # Hypermedia link to the HTML page of the review comment.
    Link html;
};

# Minimal Repository
public type NullableMinimalRepository record {
    # Whether forking is allowed on the repository
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking?;
    # The number of stars on the repository
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount?;
    # Whether the repository is a template repository
    @jsondata:Name {value: "is_template"}
    boolean isTemplate?;
    # The date of the most recent push to the repository
    @jsondata:Name {value: "pushed_at"}
    string? pushedAt?;
    # API URL for the authenticated user's subscription to the repository
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    # The primary programming language of the repository
    string? language?;
    # API URL template for listing repository branches
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    # API URL template for accessing issue comments
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    # API URL template for listing repository labels
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # API URL for listing repository watchers
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    # The permissions the authenticated user has on the repository.
    MinimalRepositoryPermissions permissions?;
    # A temporary token for cloning the repository
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    # API URL template for listing repository releases
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    # The Subversion URL for the repository
    @jsondata:Name {value: "svn_url"}
    string svnUrl?;
    # The number of users watching the repository
    @jsondata:Name {value: "subscribers_count"}
    int subscribersCount?;
    # The unique identifier of the repository
    int id;
    # Whether the repository has discussions enabled
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions?;
    # The number of forks of the repository
    int forks?;
    # API URL template for downloading repository archives
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    # API URL template for accessing Git references
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    # API URL for listing repository forks
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The visibility of the repository
    string visibility?;
    # API URL template for listing commit statuses
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    # The number of repositories in the fork network
    @jsondata:Name {value: "network_count"}
    int networkCount?;
    # The SSH URL for cloning the repository
    @jsondata:Name {value: "ssh_url"}
    string sshUrl?;
    # The role name assigned to the user for this repository
    @jsondata:Name {value: "role_name"}
    string roleName?;
    # The license associated with the repository.
    NullableMinimalRepositoryLicense? license?;
    # The full name of the repository in owner/name format
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0
    int size?;
    # API URL for listing programming languages used
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    # URL of the repository page on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # API URL template for listing repository collaborators
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    # The HTTPS URL for cloning the repository
    @jsondata:Name {value: "clone_url"}
    string cloneUrl?;
    # The name of the repository
    string name;
    # API URL template for listing pull requests
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    # The default branch of the repository
    @jsondata:Name {value: "default_branch"}
    string defaultBranch?;
    # API URL for listing repository webhooks
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    # API URL template for accessing Git trees
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    # API URL for listing repository tags
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    # Whether the repository is private
    boolean 'private;
    # API URL for listing repository contributors
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    # Whether the repository has downloads enabled
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads?;
    # API URL template for listing repository notifications
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    # The number of open issues in the repository
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount?;
    # A short description of the repository
    string? description;
    # The date the repository was created
    @jsondata:Name {value: "created_at"}
    string? createdAt?;
    # The number of watchers on the repository
    int watchers?;
    # API URL for listing repository deployments
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    # API URL template for listing repository deploy keys
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    # Whether the repository has projects enabled
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects?;
    # Whether the repository is archived
    boolean archived?;
    # Whether the repository has the wiki enabled
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki?;
    # The date the repository was last updated
    @jsondata:Name {value: "updated_at"}
    string? updatedAt?;
    # API URL template for listing commit comments
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # API URL for listing users who starred the repository
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    # Whether the repository is disabled
    boolean disabled?;
    # Whether to delete branches on merge
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge?;
    # The Git protocol URL for the repository
    @jsondata:Name {value: "git_url"}
    string gitUrl?;
    # Whether the repository has GitHub Pages enabled
    @jsondata:Name {value: "has_pages"}
    boolean hasPages?;
    # The user or organization that owns the repository.
    SimpleUser owner;
    # API URL template for listing repository commits
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    # API URL template for comparing two commits
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    # API URL template for accessing Git commits
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    # The list of topics associated with the repository
    string[] topics?;
    # API URL template for accessing repository blobs
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    # API URL template for accessing Git tags
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    # API URL for performing merge operations
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    # API URL for listing repository downloads
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    # Whether the repository has issues enabled
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues?;
    # The code of conduct for the repository
    @jsondata:Name {value: "code_of_conduct"}
    CodeOfConduct codeOfConduct?;
    # Whether commit sign-off is required for web-based commits
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    # API URL for the repository
    string url;
    # API URL template for accessing repository contents
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    # The URL of the mirror for the repository
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl?;
    # API URL template for listing repository milestones
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    # API URL for listing teams with access to the repository
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    # The security and analysis settings for the repository
    @jsondata:Name {value: "security_and_analysis"}
    SecurityAndAnalysis? securityAndAnalysis?;
    # Whether the repository is a fork
    boolean 'fork;
    # API URL template for listing repository issues
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # API URL for listing repository events
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # API URL template for listing issue events
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    # API URL template for listing repository assignees
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    # The number of open issues in the repository
    @jsondata:Name {value: "open_issues"}
    int openIssues?;
    # The number of watchers on the repository
    @jsondata:Name {value: "watchers_count"}
    int watchersCount?;
    # The GraphQL node identifier of the repository
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The URL of the repository's homepage
    string? homepage?;
    # The number of forks of the repository
    @jsondata:Name {value: "forks_count"}
    int forksCount?;
};

# Represents the Queries record for the operation: users/list-ssh-signing-keys-for-user
public type UsersListSshSigningKeysForUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# A commit
public type SimpleCommit record {
    # The person who committed the changes to the repository.
    SimpleCommitCommitter? committer;
    # SHA for the commit's tree
    @jsondata:Name {value: "tree_id"}
    string treeId;
    # The person who authored the commit.
    SimpleCommitAuthor? author;
    # SHA for the commit
    string id;
    # Message describing the purpose of the commit
    string message;
    # Timestamp of the commit
    string timestamp;
};

public type RepositoryRuleDetailedOneOf14 record {
    *RepositoryRuleTagNamePattern;
    *RepositoryRuleRulesetInfo;
};

# A self hosted runner
public type Runner record {
    # The Operating System of the runner
    string os;
    # Whether the runner is currently executing a job.
    boolean busy;
    # The name of the runner
    string name;
    # The id of the runner
    int id;
    # The id of the runner group
    @jsondata:Name {value: "runner_group_id"}
    int runnerGroupId?;
    # The status of the runner
    string status;
    # The labels assigned to the runner for job routing.
    RunnerLabel[] labels;
};

public type RepositoryRuleDetailedOneOf12 record {
    *RepositoryRuleCommitterEmailPattern;
    *RepositoryRuleRulesetInfo;
};

# Allow specific users, teams, or apps to bypass pull request requirements
public type ProtectedBranchPullRequestReviewBypassPullRequestAllowances record {
    # The list of teams allowed to bypass pull request requirements
    Team[] teams?;
    # The list of users allowed to bypass pull request requirements
    SimpleUser[] users?;
    # The list of apps allowed to bypass pull request requirements
    Integration[] apps?;
};

public type RepositoryRuleDetailedOneOf13 record {
    *RepositoryRuleBranchNamePattern;
    *RepositoryRuleRulesetInfo;
};

# The security alert number
public type AlertNumber int;

public type RepoMilestonesBody record {
    # A description of the milestone
    string description?;
    # The state of the milestone. Either open or closed
    "open"|"closed" state = "open";
    # The title of the milestone
    string title;
    # The milestone due date. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "due_on"}
    string dueOn?;
};

# Parameters to be used for the commit_author_email_pattern rule
public type RepositoryRuleCommitAuthorEmailPattern record {
    # The type identifier for the commit author email pattern rule.
    "commit_author_email_pattern" 'type;
    # The parameters defining the pattern to match against commit author emails.
    RepositoryRuleBranchNamePatternParameters parameters?;
};

public type ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf1 record {
    # The name of the status checks
    string[] contexts;
};

public type RepositoryRuleDetailedOneOf10 record {
    *RepositoryRuleCommitMessagePattern;
    *RepositoryRuleRulesetInfo;
};

# A Dependabot alert
public type DependabotAlertWithRepository record {|
    # The vulnerable dependency that triggered the alert.
    DependabotAlertWithRepositoryDependency dependency;
    # The security advisory associated with the alert.
    @jsondata:Name {value: "security_advisory"}
    DependabotAlertSecurityAdvisory securityAdvisory;
    # The specific vulnerability details from the security advisory.
    @jsondata:Name {value: "security_vulnerability"}
    DependabotAlertSecurityVulnerability securityVulnerability;
    # The date and time the alert was created.
    @jsondata:Name {value: "created_at"}
    AlertCreatedAt createdAt;
    # An optional comment associated with the alert's dismissal
    @jsondata:Name {value: "dismissed_comment"}
    string? dismissedComment;
    # The repository where the vulnerable dependency was detected.
    SimpleRepository repository;
    # The date and time the alert was automatically dismissed.
    @jsondata:Name {value: "auto_dismissed_at"}
    AlertAutoDismissedAt? autoDismissedAt?;
    # The API URL for the Dependabot alert.
    AlertUrl url;
    # The number that uniquely identifies the alert within the repository.
    AlertNumber number;
    # The date and time the alert was last updated.
    @jsondata:Name {value: "updated_at"}
    AlertUpdatedAt updatedAt;
    # The URL of the alert's page on GitHub.
    @jsondata:Name {value: "html_url"}
    AlertHtmlUrl htmlUrl;
    # The date and time the vulnerability was fixed.
    @jsondata:Name {value: "fixed_at"}
    AlertFixedAt? fixedAt;
    # The state of the Dependabot alert
    "auto_dismissed"|"dismissed"|"fixed"|"open" state;
    # The user who dismissed the alert.
    @jsondata:Name {value: "dismissed_by"}
    NullableSimpleUser? dismissedBy;
    # The reason that the alert was dismissed
    @jsondata:Name {value: "dismissed_reason"}
    "fix_started"|"inaccurate"|"no_bandwidth"|"not_used"|"tolerable_risk"? dismissedReason;
    # The date and time the alert was dismissed.
    @jsondata:Name {value: "dismissed_at"}
    AlertDismissedAt? dismissedAt;
|};

public type RepositoryRuleDetailedOneOf11 record {
    *RepositoryRuleCommitAuthorEmailPattern;
    *RepositoryRuleRulesetInfo;
};

public type HookshookIdBody record {
    # The name of the webhook.
    string name?;
    # Determines if notifications are sent when the webhook is triggered. Set to true to send notifications
    boolean active = true;
    # The configuration settings for the webhook.
    OrgsorghookshookIdConfig config?;
    # Determines what [events](https://docs.github.com/webhooks/event-payloads) the hook is triggered for
    string[] events = ["push"];
};

public type RateLimit record {
    # The maximum number of requests allowed per rate limit window.
    int 'limit;
    # The Unix timestamp when the rate limit window resets.
    int reset;
    # The number of requests used in the current rate limit window.
    int used;
    # The number of requests remaining in the current rate limit window.
    int remaining;
};

# Thread Subscription
public type ThreadSubscription record {
    # Whether the authenticated user is subscribed to the thread.
    boolean subscribed;
    # Whether the authenticated user has chosen to ignore the thread.
    boolean ignored;
    # The reason the authenticated user is subscribed to the thread.
    string? reason;
    # The date and time the subscription was created.
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    # API URL for the subscribed thread.
    @jsondata:Name {value: "thread_url"}
    string threadUrl?;
    # API URL for the repository containing the thread.
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl?;
    # API URL for the thread subscription.
    string url;
};

# Represents the Queries record for the operation: repos/list-deployment-branch-policies
public type ReposListDeploymentBranchPoliciesQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Organization variable for GitHub Actions
public type OrganizationActionsVariable record {
    # The date and time at which the variable was last updated, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Visibility of a variable
    "all"|"private"|"selected" visibility;
    # The name of the variable
    string name;
    # API URL to list repositories that can access this variable.
    @jsondata:Name {value: "selected_repositories_url"}
    string selectedRepositoriesUrl?;
    # The date and time at which the variable was created, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The value of the variable
    string value;
};

public type CheckRunOutput record {
    # A brief summary of the check run results.
    string? summary;
    # API URL to retrieve annotations for the check run output.
    @jsondata:Name {value: "annotations_url"}
    string annotationsUrl;
    # Detailed information about the check run results.
    string? text;
    # The title of the check run output.
    string? title;
    # The total number of annotations associated with the check run.
    @jsondata:Name {value: "annotations_count"}
    int annotationsCount;
};

# A topic aggregates entities that are related to a subject
public type Topic record {
    # The list of topic names associated with the subject.
    string[] names;
};

# Represents the Queries record for the operation: repos/list-pages-builds
public type ReposListPagesBuildsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Whether users can pull changes from upstream when the branch is locked. Set to true to allow fork syncing. Set to false to prevent fork syncing
public type BranchProtectionAllowForkSyncing record {
    # Whether fork syncing is enabled for the locked branch.
    boolean enabled = false;
};

# Represents the Queries record for the operation: orgs/list-pat-grant-repositories
public type OrgsListPatGrantRepositoriesQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type CheckSuitePreferencePreferencesAutoTriggerChecks record {
    # The unique identifier of the GitHub App.
    @jsondata:Name {value: "app_id"}
    int appId;
    # Whether auto-trigger is enabled for the specified app's check suites.
    boolean setting;
};

# Commit Comment
public type CommitComment record {
    # The line number in the file the comment applies to.
    int? line;
    # The date and time the comment was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The content of the commit comment.
    string body;
    # API URL for the commit comment.
    string url;
    # The commenter's association with the repository.
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # The relative file path the comment is associated with.
    string? path;
    # The date and time the comment was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # URL of the commit comment on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Reaction counts for the commit comment.
    ReactionRollup reactions?;
    # The unique identifier of the commit comment.
    int id;
    # The line index in the diff the comment applies to.
    int? position;
    # The SHA of the commit the comment is associated with.
    @jsondata:Name {value: "commit_id"}
    string commitId;
    # The user who created the commit comment.
    NullableSimpleUser? user;
    # The GraphQL node identifier of the commit comment.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Specify which users, teams, and apps can dismiss pull request reviews. Pass an empty dismissal_restrictions object to disable. User and team dismissal_restrictions are only available for organization-owned repositories. Omit this parameter for personal repositories
public type ReposownerrepobranchesbranchprotectionRequiredPullRequestReviewsDismissalRestrictions record {
    # The list of team slugs with dismissal access
    string[] teams?;
    # The list of user logins with dismissal access
    string[] users?;
    # The list of app slugs with dismissal access
    string[] apps?;
};

public type Manifest record {|
    # Additional metadata associated with the dependency manifest.
    Metadata metadata?;
    # The file details associated with the dependency manifest.
    ManifestFile file?;
    # The name of the manifest
    string name;
    # A collection of resolved package dependencies
    record {|Dependency...;|} resolved?;
|};

# Represents the Queries record for the operation: repos/list-for-user
public type ReposListForUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The property to sort the results by
    "created"|"updated"|"pushed"|"full_name" sort = "full_name";
    # Page number of the results to fetch
    int page = 1;
    # Limit results to repositories of the specified type
    "all"|"owner"|"member" 'type = "owner";
    # The order to sort by. Default: asc when using full_name, otherwise desc
    "asc"|"desc" direction?;
};

public type RulesetsrulesetIdBody record {
    # The actors that can bypass the rules in this ruleset
    @jsondata:Name {value: "bypass_actors"}
    RepositoryRulesetBypassActor[] bypassActors?;
    # The name of the ruleset
    string name?;
    # The enforcement level of the ruleset.
    RepositoryRuleEnforcement enforcement?;
    # An array of rules within the ruleset
    RepositoryRule[] rules?;
    # The conditions that determine which repositories the ruleset applies to.
    OrgRulesetConditions conditions?;
    # The target of the ruleset
    "branch"|"tag" target?;
};

# Hypermedia links for the review
public type PullRequestReviewLinks record {
    # Hypermedia link to the pull request the review belongs to.
    @jsondata:Name {value: "pull_request"}
    TimelineReviewedEventLinksHtml pullRequest;
    # Hypermedia link to the HTML page of the pull request review.
    TimelineReviewedEventLinksHtml html;
};

# Protected Branch Pull Request Review
public type ProtectedBranchPullRequestReview record {
    # Restrictions on who can dismiss pull request reviews.
    @jsondata:Name {value: "dismissal_restrictions"}
    ProtectedBranchPullRequestReviewDismissalRestrictions dismissalRestrictions?;
    # The number of approving reviews required before merging.
    @jsondata:Name {value: "required_approving_review_count"}
    int requiredApprovingReviewCount?;
    # Whether an approval from a code owner is required to merge.
    @jsondata:Name {value: "require_code_owner_reviews"}
    boolean requireCodeOwnerReviews;
    # Whether approvals are dismissed when new commits are pushed.
    @jsondata:Name {value: "dismiss_stale_reviews"}
    boolean dismissStaleReviews;
    # Users, teams, or apps allowed to bypass required pull request reviews.
    @jsondata:Name {value: "bypass_pull_request_allowances"}
    ProtectedBranchPullRequestReviewBypassPullRequestAllowances bypassPullRequestAllowances?;
    # Whether the most recent push must be approved by someone other than the person who pushed it
    @jsondata:Name {value: "require_last_push_approval"}
    boolean requireLastPushApproval = false;
    # API URL for the pull request review protection settings.
    string url?;
};

# Branch protections protect branches
public type ProtectedBranch record {
    # Settings for required pull request reviews before merging.
    @jsondata:Name {value: "required_pull_request_reviews"}
    ProtectedBranchRequiredPullRequestReviews requiredPullRequestReviews?;
    # Settings requiring signed commits on the protected branch.
    @jsondata:Name {value: "required_signatures"}
    ProtectedBranchRequiredSignatures requiredSignatures?;
    # Status check policy required before merging into the branch.
    @jsondata:Name {value: "required_status_checks"}
    StatusCheckPolicy requiredStatusChecks?;
    # Settings controlling whether fork syncing is allowed on the branch.
    @jsondata:Name {value: "allow_fork_syncing"}
    ProtectedBranchAllowForkSyncing allowForkSyncing?;
    # Settings requiring a linear commit history on the branch.
    @jsondata:Name {value: "required_linear_history"}
    ProtectedBranchRequiredLinearHistory requiredLinearHistory?;
    # Access restrictions controlling who can push to the branch.
    BranchRestrictionPolicy restrictions?;
    # Settings for enforcing branch protections on administrators.
    @jsondata:Name {value: "enforce_admins"}
    ProtectedBranchEnforceAdmins enforceAdmins?;
    # API URL for the protected branch.
    string url;
    # Settings controlling whether force pushes are allowed on the branch.
    @jsondata:Name {value: "allow_force_pushes"}
    ProtectedBranchRequiredLinearHistory allowForcePushes?;
    # Settings controlling whether the branch is locked from changes.
    @jsondata:Name {value: "lock_branch"}
    ProtectedBranchLockBranch lockBranch?;
    # Settings requiring all comments to be resolved before merging.
    @jsondata:Name {value: "required_conversation_resolution"}
    ProtectedBranchRequiredConversationResolution requiredConversationResolution?;
    # Settings blocking creation of matching branches or tags.
    @jsondata:Name {value: "block_creations"}
    ProtectedBranchRequiredLinearHistory blockCreations?;
    # Settings controlling whether the branch can be deleted.
    @jsondata:Name {value: "allow_deletions"}
    ProtectedBranchRequiredLinearHistory allowDeletions?;
};

# Represents the Queries record for the operation: actions/list-self-hosted-runners-for-org
public type ActionsListSelfHostedRunnersForOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The name of a self-hosted runner
    string name?;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: secret-scanning/list-alerts-for-org
public type SecretScanningListAlertsForOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # A comma-separated list of secret types to return. By default all secret types are returned.
    # See "[Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns#supported-secrets-for-advanced-security)"
    # for a complete list of secret types
    @http:Query {name: "secret_type"}
    string secretType?;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for events before this cursor. To receive an initial cursor on your first request, include an empty "before" query string
    string before?;
    # Set to open or resolved to only list secret scanning alerts in a specific state
    "open"|"resolved" state?;
    # The property to sort the results by. created means when the alert was created. updated means when the alert was updated or resolved
    "created"|"updated" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for events after this cursor.  To receive an initial cursor on your first request, include an empty "after" query string
    string after?;
    # A comma-separated list of resolutions. Only secret scanning alerts with one of these resolutions are listed. Valid resolutions are false_positive, wont_fix, revoked, pattern_edited, pattern_deleted or used_in_tests
    string resolution?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

public type OwnerrepoBody record {
    # The permission to grant the team on this repository. We accept the following permissions to be set: pull, triage, push, maintain, admin and you can also specify a custom repository role name, if the owning organization has defined any. If no permission is specified, the team's permission attribute will be used to determine what permission to grant the team on this repository
    string permission = "push";
};

# A GitHub Actions workflow
public type WorkflowResponse record {
    # The total number of workflows in the repository.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of GitHub Actions workflows.
    Workflow[] workflows;
};

public type RepositoryRulePullRequestParameters record {
    # All conversations on code must be resolved before a pull request can be merged
    @jsondata:Name {value: "required_review_thread_resolution"}
    boolean requiredReviewThreadResolution;
    # The number of approving reviews that are required before a pull request can be merged
    @jsondata:Name {value: "required_approving_review_count"}
    int requiredApprovingReviewCount;
    # Require an approving review in pull requests that modify files that have a designated code owner
    @jsondata:Name {value: "require_code_owner_review"}
    boolean requireCodeOwnerReview;
    # New, reviewable commits pushed will dismiss previous pull request review approvals
    @jsondata:Name {value: "dismiss_stale_reviews_on_push"}
    boolean dismissStaleReviewsOnPush;
    # Whether the most recent reviewable push must be approved by someone other than the person who pushed it
    @jsondata:Name {value: "require_last_push_approval"}
    boolean requireLastPushApproval;
};

# Pull request number for this codespace
public type UsercodespacesPullRequest record {
    # Pull request number
    @jsondata:Name {value: "pull_request_number"}
    int pullRequestNumber;
    # Repository id for this codespace
    @jsondata:Name {value: "repository_id"}
    int repositoryId;
};

# The package's language or package management ecosystem
public type SecurityAdvisoryEcosystems "rubygems"|"npm"|"pip"|"maven"|"nuget"|"composer"|"go"|"rust"|"erlang"|"actions"|"pub"|"other"|"swift";

# Represents a 'commit' secret scanning location type. This location type shows that a secret was detected inside a commit to a repository
public type SecretScanningLocationCommit record {
    # The file path in the repository
    string path;
    # The column at which the secret starts within the start line when the file is interpreted as 8BIT ASCII
    @jsondata:Name {value: "start_column"}
    decimal startColumn;
    # The API URL to get the associated commit resource
    @jsondata:Name {value: "commit_url"}
    string commitUrl;
    # SHA-1 hash ID of the associated commit
    @jsondata:Name {value: "commit_sha"}
    string commitSha;
    # Line number at which the secret starts in the file
    @jsondata:Name {value: "start_line"}
    decimal startLine;
    # SHA-1 hash ID of the associated blob
    @jsondata:Name {value: "blob_sha"}
    string blobSha;
    # The API URL to get the associated blob resource
    @jsondata:Name {value: "blob_url"}
    string blobUrl;
    # Line number at which the secret ends in the file
    @jsondata:Name {value: "end_line"}
    decimal endLine;
    # The column at which the secret ends within the end line when the file is interpreted as 8BIT ASCII
    @jsondata:Name {value: "end_column"}
    decimal endColumn;
};

# Prevent merge commits from being pushed to matching refs
public type RepositoryRuleRequiredLinearHistory record {
    # The rule type, must be 'required_linear_history'.
    "required_linear_history" 'type;
};

# Represents the Queries record for the operation: migrations/list-for-authenticated-user
public type MigrationsListForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: orgs/list-app-installations
public type OrgsListAppInstallationsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Conditions to target repositories by name and refs by name
public type RepositoryNameAndRefName record {
    *RepositoryRulesetConditions;
    *RepositoryRulesetConditionsRepositoryNameTarget;
};

# Represents the Queries record for the operation: repos/codeowners-errors
public type ReposCodeownersErrorsQueries record {
    # A branch, tag or commit name used to determine which version of the CODEOWNERS file to use. Default: the repository's default branch (e.g. main)
    string ref?;
};

# A repository on GitHub
public type NullableRepository record {
    # Whether to allow forking this repo
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking?;
    # Whether anonymous git access is enabled for this repository
    @jsondata:Name {value: "anonymous_access_enabled"}
    boolean anonymousAccessEnabled?;
    # API URL for managing the repository subscription.
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    # API URL template for the repository's branches.
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    # API URL template for the repository's issue comments.
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    # Whether to allow rebase merges for pull requests
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge = true;
    # The permissions the authenticated user has on this repository.
    TeamRepositoryPermissions permissions?;
    # API URL for the repository's subscribers list.
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    # Temporary token used for cloning the repository.
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    # API URL template for the repository's releases.
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    # The default value for a squash merge commit message:
    # 
    # - PR_BODY - default to the pull request's body.
    # - COMMIT_MESSAGES - default to the branch's commit messages.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "squash_merge_commit_message"}
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squashMergeCommitMessage?;
    # Number of users watching the repository.
    @jsondata:Name {value: "subscribers_count"}
    int subscribersCount?;
    # Unique identifier of the repository
    int id;
    # Whether discussions are enabled
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions = false;
    # Number of forks of the repository.
    int forks;
    # API URL template for the repository's git refs.
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    # SSH URL used to clone the repository.
    @jsondata:Name {value: "ssh_url"}
    string sshUrl;
    # Full repository name including owner, e.g., 'owner/repo'.
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0
    int size;
    # The template repository used to create this repository.
    @jsondata:Name {value: "template_repository"}
    NullableRepositoryTemplateRepository? templateRepository?;
    # API URL for the repository's language breakdown.
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    # URL to the repository's GitHub web page.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # API URL template for the repository's collaborators.
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    # HTTPS URL used to clone the repository.
    @jsondata:Name {value: "clone_url"}
    string cloneUrl;
    # The default branch of the repository
    @jsondata:Name {value: "default_branch"}
    string defaultBranch;
    # API URL for the repository's webhooks.
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    # API URL template for the repository's git trees.
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    # Whether downloads are enabled
    # 
    # # Deprecated
    @jsondata:Name {value: "has_downloads"}
    @deprecated
    boolean hasDownloads = true;
    # Timestamp when the repository was created.
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    # Number of users watching the repository.
    int watchers;
    # API URL for the repository's deployments.
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    # API URL template for the repository's deploy keys.
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    # Whether the repository is archived
    boolean archived = false;
    # Whether the wiki is enabled
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki = true;
    # Timestamp when the repository was last updated.
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    # Returns whether or not this repository disabled
    boolean disabled;
    # API URL template for comparing two refs in the repository.
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    # API URL template for the repository's git commits.
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    # List of topics associated with the repository.
    string[] topics?;
    # Whether or not a pull request head branch that is behind its base branch can always be updated even if it is not required to be up to date before merging
    @jsondata:Name {value: "allow_update_branch"}
    boolean allowUpdateBranch = false;
    # API URL template for the repository's git tags.
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    # API URL for the repository's branch merges.
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    # Timestamp when the repository was starred by the authenticated user.
    @jsondata:Name {value: "starred_at"}
    string starredAt?;
    # API URL for the repository.
    string url;
    # API URL template for the repository's file contents.
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    # API URL template for the repository's issues.
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # Whether a squash merge commit can use the pull request title as default. **This property has been deprecated. Please use squash_merge_commit_title instead
    # 
    # # Deprecated
    @jsondata:Name {value: "use_squash_pr_title_as_default"}
    @deprecated
    boolean useSquashPrTitleAsDefault = false;
    # The organization that owns the repository, if applicable.
    NullableSimpleUser? organization?;
    # The default value for a merge commit message.
    # 
    # - PR_TITLE - default to the pull request's title.
    # - PR_BODY - default to the pull request's body.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "merge_commit_message"}
    "PR_BODY"|"PR_TITLE"|"BLANK" mergeCommitMessage?;
    # API URL template for the repository's assignees.
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    # The default value for a squash merge commit title:
    # 
    # - PR_TITLE - default to the pull request's title.
    # - COMMIT_OR_PR_TITLE - default to the commit's title (if only one commit) or the pull request's title (when more than one commit)
    @jsondata:Name {value: "squash_merge_commit_title"}
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squashMergeCommitTitle?;
    # Number of open issues and pull requests in the repository.
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    # Global Node ID of the repository.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # Number of users who have starred the repository.
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount;
    # Whether this repository acts as a template that can be used to generate new repositories
    @jsondata:Name {value: "is_template"}
    boolean isTemplate = false;
    # Timestamp of the most recent push to the repository.
    @jsondata:Name {value: "pushed_at"}
    string? pushedAt;
    # Primary programming language used in the repository.
    string? language;
    # API URL template for the repository's labels.
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # SVN URL used to access the repository.
    @jsondata:Name {value: "svn_url"}
    string svnUrl;
    # The name of the repository's master branch.
    @jsondata:Name {value: "master_branch"}
    string masterBranch?;
    # API URL template for downloading an archive of the repository.
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    # Whether to allow merge commits for pull requests
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit = true;
    # API URL for the repository's forks.
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The repository visibility: public, private, or internal
    string visibility = "public";
    # API URL template for commit statuses in the repository.
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    # Number of repositories in the repository's network.
    @jsondata:Name {value: "network_count"}
    int networkCount?;
    # The license associated with the repository.
    NullableLicenseSimple? license;
    # Whether to allow Auto-merge to be used on pull requests
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge = false;
    # The name of the repository
    string name;
    # API URL template for the repository's pull requests.
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    # API URL for the repository's tags.
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    # Whether the repository is private or public
    boolean 'private = false;
    # API URL for the repository's contributors.
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    # API URL template for the repository's notifications.
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    # Number of open issues in the repository.
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount;
    # Short description of the repository.
    string? description;
    # Whether projects are enabled
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects = true;
    # The default value for a merge commit title.
    # 
    # - PR_TITLE - default to the pull request's title.
    # - MERGE_MESSAGE - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name)
    @jsondata:Name {value: "merge_commit_title"}
    "PR_TITLE"|"MERGE_MESSAGE" mergeCommitTitle?;
    # API URL template for the repository's comments.
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # API URL for users who have starred the repository.
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    # Whether to delete head branches when pull requests are merged
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge = false;
    # Git URL used to access the repository.
    @jsondata:Name {value: "git_url"}
    string gitUrl;
    # Whether GitHub Pages is enabled for the repository.
    @jsondata:Name {value: "has_pages"}
    boolean hasPages;
    # The user or organization that owns the repository.
    SimpleUser owner;
    # Whether to allow squash merges for pull requests
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge = true;
    # API URL template for the repository's commits.
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    # API URL template for the repository's git blobs.
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    # API URL for the repository's downloads.
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    # Whether issues are enabled
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues = true;
    # Whether to require contributors to sign off on web-based commits
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired = false;
    # URL of the repository's mirror, if it is a mirror.
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl;
    # API URL template for the repository's milestones.
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    # API URL for the repository's teams.
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    # Whether the repository is a fork of another repository.
    boolean 'fork;
    # API URL for the repository's events.
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # API URL template for the repository's issue events.
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    # Number of users watching the repository.
    @jsondata:Name {value: "watchers_count"}
    int watchersCount;
    # URL of the repository's homepage or website.
    string? homepage;
    # Number of forks of the repository.
    @jsondata:Name {value: "forks_count"}
    int forksCount;
};

# Represents the Queries record for the operation: code-scanning/list-alert-instances
public type CodeScanningListAlertInstancesQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The Git reference for the results you want to list. The ref for a branch can be formatted either as refs/heads/<branch name> or simply <branch name>. To reference a pull request use refs/pull/<number>/merge
    CodeScanningRef ref?;
    # Page number of the results to fetch
    int page = 1;
};

public type PullRequestReviewCommentLinksHtml record {
    # URL to the pull request review comment on GitHub.
    string href;
};

public type OrgInvitationsBody record {
    # The role for the new member. 
    #  * admin - Organization owners with full administrative rights to the organization and complete access to all repositories and teams.  
    #  * direct_member - Non-owner organization members with ability to see other members and join teams by invitation.  
    #  * billing_manager - Non-owner organization members with ability to manage the billing settings of your organization
    "admin"|"direct_member"|"billing_manager" role = "direct_member";
    # Specify IDs for the teams you want to invite new members to
    @jsondata:Name {value: "team_ids"}
    int[] teamIds?;
    # **Required unless you provide email**. GitHub user ID for the person you are inviting
    @jsondata:Name {value: "invitee_id"}
    int inviteeId?;
    # **Required unless you provide invitee_id**. Email address of the person you are inviting, which can be an existing GitHub user
    string email?;
};

# Represents the Queries record for the operation: activity/list-repos-starred-by-user
public type ActivityListReposStarredByUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The property to sort the results by. created means when the repository was starred. updated means when the repository was last pushed to
    "created"|"updated" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub
public type NullableIntegration record {
    # The user or organization that owns the GitHub app.
    NullableSimpleUser? owner;
    # The number of installations associated with the GitHub app
    @jsondata:Name {value: "installations_count"}
    int installationsCount?;
    # Short description of the GitHub app.
    string? description;
    # Timestamp when the GitHub app was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The OAuth client ID of the GitHub app.
    @jsondata:Name {value: "client_id"}
    string clientId?;
    # External URL for the GitHub app's homepage.
    @jsondata:Name {value: "external_url"}
    string externalUrl;
    # Timestamp when the GitHub app was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The set of permissions granted to the GitHub app.
    IntegrationPermissions permissions;
    # URL to the GitHub app's web page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The name of the GitHub app
    string name;
    # The secret used to secure webhook payloads from the GitHub app.
    @jsondata:Name {value: "webhook_secret"}
    string? webhookSecret?;
    # The private key PEM used to sign access tokens for the GitHub app.
    string pem?;
    # Unique identifier of the GitHub app
    int id;
    # The OAuth client secret of the GitHub app.
    @jsondata:Name {value: "client_secret"}
    string clientSecret?;
    # The slug name of the GitHub app
    string slug?;
    # The list of events for the GitHub app
    string[] events;
    # Global Node ID of the GitHub app.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# GitHub Actions Cache Usage by repository
public type ActionsCacheUsageByRepositoryResponse record {
    # Total number of repositories with Actions cache usage data.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # List of repositories and their Actions cache usage details.
    @jsondata:Name {value: "repository_cache_usages"}
    ActionsCacheUsageByRepository[] repositoryCacheUsages;
};

# Actor
public type Actor record {
    # The display name shown for the actor in GitHub events.
    @jsondata:Name {value: "display_login"}
    string displayLogin?;
    # URL of the actor's avatar image.
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # Unique identifier of the actor.
    int id;
    # The username of the actor.
    string login;
    # Gravatar ID associated with the actor's email.
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    # API URL for the actor's GitHub profile.
    string url;
};

# Represents the Queries record for the operation: reactions/list-for-team-discussion-in-org
public type ReactionsListForTeamDiscussionInOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to a team discussion
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content?;
};

public type WorkflowRunUsageBillable record {
    # Billing usage data for jobs run on Ubuntu runners.
    @jsondata:Name {value: "UBUNTU"}
    WorkflowRunUsageBillableUBUNTU uBUNTU?;
    # Billing usage data for jobs run on macOS runners.
    @jsondata:Name {value: "MACOS"}
    WorkflowRunUsageBillableUBUNTU mACOS?;
    # Billing usage data for jobs run on Windows runners.
    @jsondata:Name {value: "WINDOWS"}
    WorkflowRunUsageBillableUBUNTU wINDOWS?;
};

public type SecretScanningAlert record {
    # The type of secret that secret scanning detected
    @jsondata:Name {value: "secret_type"}
    string secretType?;
    # The user who bypassed push protection for this alert.
    @jsondata:Name {value: "push_protection_bypassed_by"}
    NullableSimpleUser? pushProtectionBypassedBy?;
    # The time that push protection was bypassed in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "push_protection_bypassed_at"}
    string? pushProtectionBypassedAt?;
    # Timestamp when the secret scanning alert was created.
    @jsondata:Name {value: "created_at"}
    AlertCreatedAt createdAt?;
    # User-friendly name for the detected secret, matching the secret_type.
    # For a list of built-in patterns, see "[Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns#supported-secrets-for-advanced-security)."
    @jsondata:Name {value: "secret_type_display_name"}
    string secretTypeDisplayName?;
    # The secret that was detected
    string secret?;
    # The reason for resolving the secret scanning alert.
    SecretScanningAlertResolution? resolution?;
    # REST API URL of the secret scanning alert.
    AlertUrl url?;
    # The unique number identifying this secret scanning alert.
    AlertNumber number?;
    # The user who resolved the secret scanning alert.
    @jsondata:Name {value: "resolved_by"}
    NullableSimpleUser? resolvedBy?;
    # Timestamp when the secret scanning alert was last updated.
    @jsondata:Name {value: "updated_at"}
    NullableAlertUpdatedAt? updatedAt?;
    # The REST API URL of the code locations for this alert
    @jsondata:Name {value: "locations_url"}
    string locationsUrl?;
    # An optional comment to resolve an alert
    @jsondata:Name {value: "resolution_comment"}
    string? resolutionComment?;
    # The time that the alert was resolved in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "resolved_at"}
    string? resolvedAt?;
    # URL to the secret scanning alert on GitHub.
    @jsondata:Name {value: "html_url"}
    AlertHtmlUrl htmlUrl?;
    # Whether push protection was bypassed for the detected secret
    @jsondata:Name {value: "push_protection_bypassed"}
    boolean? pushProtectionBypassed?;
    # The state of the secret scanning alert, open or resolved.
    SecretScanningAlertState state?;
};

public type GpgKeySubkeys record {
    # The public key data for the GPG subkey.
    @jsondata:Name {value: "public_key"}
    string publicKey?;
    # The identifier of the GPG subkey.
    @jsondata:Name {value: "key_id"}
    string keyId?;
    # Timestamp when the GPG subkey was created.
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    # Whether the GPG subkey has been revoked.
    boolean revoked?;
    # The raw key data for the GPG subkey.
    @jsondata:Name {value: "raw_key"}
    string? rawKey?;
    # Email addresses associated with the GPG subkey.
    GpgKeyEmails[] emails?;
    # Whether the GPG subkey can certify other keys.
    @jsondata:Name {value: "can_certify"}
    boolean canCertify?;
    # Timestamp when the GPG subkey expires.
    @jsondata:Name {value: "expires_at"}
    string? expiresAt?;
    # Whether the GPG subkey can encrypt communications.
    @jsondata:Name {value: "can_encrypt_comms"}
    boolean canEncryptComms?;
    # Whether the GPG subkey can encrypt storage.
    @jsondata:Name {value: "can_encrypt_storage"}
    boolean canEncryptStorage?;
    # Whether the GPG subkey can create signatures.
    @jsondata:Name {value: "can_sign"}
    boolean canSign?;
    # Unique identifier of the GPG subkey.
    int id?;
    # List of subkeys associated with this GPG subkey.
    anydata[] subkeys?;
    # Identifier of the primary GPG key that owns this subkey.
    @jsondata:Name {value: "primary_key_id"}
    int primaryKeyId?;
};

# Key/value pairs to provide settings for this webhook
public type OrgsorghooksConfig record {
    # Password credential used for webhook authentication.
    string password?;
    # The media type used to serialize payloads sent to this webhook.
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    # Determines whether SSL verification is skipped for webhook delivery.
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    # Secret token used to generate the HMAC hex digest signature for webhook payloads.
    WebhookConfigSecret secret?;
    # The URL to which webhook payloads will be delivered.
    WebhookConfigUrl url;
    # Username credential used for webhook authentication.
    string username?;
};

# A description of the detector used
public type SnapshotDetector record {|
    # The name of the detector used
    string name;
    # The version of the detector used
    string version;
    # The url of the detector used
    string url;
|};

public type RepoForksBody record {
    # Optional parameter to specify the organization name if forking into an organization
    string organization?;
    # When forking from an existing repository, a new name for the fork
    string name?;
    # When forking from an existing repository, fork with only the default branch
    @jsondata:Name {value: "default_branch_only"}
    boolean defaultBranchOnly?;
};

# Represents the Queries record for the operation: codespaces/list-selected-repos-for-org-secret
public type CodespacesListSelectedReposForOrgSecretQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: teams/list-pending-invitations-legacy
public type TeamsListPendingInvitationsLegacyQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# **Required when the state is resolved.** The reason for resolving the alert
public type SecretScanningAlertResolution "false_positive"|"wont_fix"|"revoked"|"used_in_tests"?;

public type RunIdPendingDeploymentsBody record {
    # A comment to accompany the deployment review
    string comment;
    # Whether to approve or reject deployment to the specified environments
    "approved"|"rejected" state;
    # The list of environment ids to approve or reject
    @jsondata:Name {value: "environment_ids"}
    int[] environmentIds;
};

public type DeploymentBranchPolicyNamePatternWithType record {
    # The name pattern that branches or tags must match in order to deploy to the environment.
    # 
    # Wildcard characters will not match /. For example, to match branches that begin with release/ and contain an additional single slash, use release/*/*.
    # For more information about pattern matching syntax, see the [Ruby File.fnmatch documentation](https://ruby-doc.org/core-2.5.1/File.html#method-c-fnmatch)
    string name;
    # Whether this rule targets a branch or tag
    "branch"|"tag" 'type?;
};

# Represents the Queries record for the operation: repos/list-webhook-deliveries
public type ReposListWebhookDeliveriesQueries record {
    # Used for pagination: the starting delivery from which the page of deliveries is fetched. Refer to the link header for the next and previous page cursors
    string cursor?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Filter to only return redeliveries.
    boolean redelivery?;
};

public type TimelineReviewedEventLinksHtml record {
    # The URL linking to the HTML view of the reviewed event.
    string href;
};

public type StargazerResponseStargazerResponseAnyOf12 Stargazer[];

# Commit Search Result Item
public type CommitSearchResultItem record {
    # The search relevance score for this commit result.
    decimal score;
    # The Git user who committed the changes.
    NullableGitUser? committer;
    # The GitHub user who authored the commit.
    NullableSimpleUser? author;
    # The URL to view this commit on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Text fragments that matched the search query within this commit.
    @jsondata:Name {value: "text_matches"}
    SearchResultTextMatches textMatches?;
    # The API URL to retrieve comments for this commit.
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # Detailed commit data including message, tree, and author information.
    CommitSearchResultItemCommit 'commit;
    # The repository where this commit was made.
    MinimalRepository repository;
    # The SHA hash uniquely identifying this commit.
    string sha;
    # The API URL for this commit resource.
    string url;
    # List of parent commits for this commit.
    CommitSearchResultItemParents[] parents;
    # The unique GraphQL node identifier for this commit.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type Dependency record {|
    # Additional metadata key/value pairs associated with this dependency.
    Metadata metadata?;
    # Package-url (PURL) of dependency. See https://github.com/package-url/purl-spec for more details
    @jsondata:Name {value: "package_url"}
    string packageUrl?;
    # A notation of whether the dependency is required for the primary build artifact (runtime) or is only used for development. Future versions of this specification may allow for more granular scopes
    "runtime"|"development" scope?;
    # A notation of whether a dependency is requested directly by this manifest or is a dependency of another dependency
    "direct"|"indirect" relationship?;
    # Array of package-url (PURLs) of direct child dependencies
    string[] dependencies?;
|};

public type PagesHealthCheckDomain record {
    # Explanation of the domain health check result or failure reason.
    string? reason?;
    # Indicates whether the domain resolves to a Cloudflare IP address.
    @jsondata:Name {value: "is_cloudflare_ip"}
    boolean? isCloudflareIp?;
    # Indicates whether the domain enforces HTTPS connections.
    @jsondata:Name {value: "enforces_https"}
    boolean enforcesHttps?;
    # Indicates whether the domain points to a GitHub Pages IP address.
    @jsondata:Name {value: "is_pointed_to_github_pages_ip"}
    boolean? isPointedToGithubPagesIp?;
    # Indicates whether the domain is actively served by GitHub Pages.
    @jsondata:Name {value: "is_served_by_pages"}
    boolean? isServedByPages?;
    # Indicates whether the domain resolves to a Fastly CDN IP address.
    @jsondata:Name {value: "is_fastly_ip"}
    boolean? isFastlyIp?;
    # Indicates whether the domain is an apex (root) domain.
    @jsondata:Name {value: "is_apex_domain"}
    boolean isApexDomain?;
    # The hostname of the domain being health-checked.
    string host?;
    # Indicates whether the domain responds to HTTPS requests.
    @jsondata:Name {value: "responds_to_https"}
    boolean respondsToHttps?;
    # Indicates whether the domain has a CNAME record pointing to pages.github.com.
    @jsondata:Name {value: "is_cname_to_pages_dot_github_dot_com"}
    boolean? isCnameToPagesDotGithubDotCom?;
    # Indicates whether the domain has a DNS A record configured.
    @jsondata:Name {value: "is_a_record"}
    boolean? isARecord?;
    # Indicates whether the domain CNAME points to a GitHub user domain.
    @jsondata:Name {value: "is_cname_to_github_user_domain"}
    boolean? isCnameToGithubUserDomain?;
    # Indicates whether this is a recognized GitHub Pages domain.
    @jsondata:Name {value: "is_pages_domain"}
    boolean isPagesDomain?;
    # Indicates whether the domain resolves to a deprecated GitHub Pages IP address.
    @jsondata:Name {value: "is_old_ip_address"}
    boolean? isOldIpAddress?;
    # Indicates whether the domain has a CNAME DNS record.
    @jsondata:Name {value: "has_cname_record"}
    boolean? hasCnameRecord?;
    # Indicates whether the domain has a CNAME record pointing to Fastly.
    @jsondata:Name {value: "is_cname_to_fastly"}
    boolean? isCnameToFastly?;
    # Indicates whether the domain successfully resolves via DNS.
    @jsondata:Name {value: "dns_resolves"}
    boolean dnsResolves?;
    # Indicates whether the domain is eligible for HTTPS enforcement.
    @jsondata:Name {value: "is_https_eligible"}
    boolean? isHttpsEligible?;
    # Error message from the CAA DNS record check, if any.
    @jsondata:Name {value: "caa_error"}
    string? caaError?;
    # Indicates whether the domain traffic is routed through a proxy.
    @jsondata:Name {value: "is_proxied"}
    boolean? isProxied?;
    # Indicates whether the domain name is a valid domain.
    @jsondata:Name {value: "is_valid_domain"}
    boolean isValidDomain?;
    # Indicates whether a non-GitHub Pages IP address is present for the domain.
    @jsondata:Name {value: "is_non_github_pages_ip_present"}
    boolean? isNonGithubPagesIpPresent?;
    # The full URI of the domain being health-checked.
    string uri?;
    # Indicates whether the domain should be configured as an A record.
    @jsondata:Name {value: "should_be_a_record"}
    boolean? shouldBeARecord?;
    # The nameservers responsible for the domain's DNS resolution.
    string nameservers?;
    # Indicates whether MX records are present for the domain.
    @jsondata:Name {value: "has_mx_records_present"}
    boolean? hasMxRecordsPresent?;
    # Indicates whether the domain configuration is valid for GitHub Pages.
    @jsondata:Name {value: "is_valid"}
    boolean isValid?;
    # Error message describing any HTTPS configuration issue for the domain.
    @jsondata:Name {value: "https_error"}
    string? httpsError?;
};

# Key/value pairs to provide settings for this webhook
public type OrgsorghookshookIdConfig record {
    # The media type used to serialize payloads sent to this webhook.
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    # Determines whether SSL verification is skipped for webhook delivery.
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    # Secret token used to generate the HMAC hex digest signature for webhook payloads.
    WebhookConfigSecret secret?;
    # The URL to which webhook payloads will be delivered.
    WebhookConfigUrl url;
};

public type ReviewCustomGatesStateRequired record {
    # Optional comment to include with the review
    string comment?;
    # Whether to approve or reject deployment to the specified environments
    "approved"|"rejected" state;
    # The name of the environment to approve or reject
    @jsondata:Name {value: "environment_name"}
    string environmentName;
};

# Projects are a way to organize columns and cards of work
public type Project record {
    # The API URL to list columns in this project.
    @jsondata:Name {value: "columns_url"}
    string columnsUrl;
    # The GitHub user who created this project.
    NullableSimpleUser? creator;
    # Whether or not this project can be seen by everyone. Only present if owner is an organization
    boolean 'private?;
    # The baseline permission that all organization members have on this project. Only present if owner is an organization
    @jsondata:Name {value: "organization_permission"}
    "read"|"write"|"admin"|"none" organizationPermission?;
    # The timestamp when this project was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Body of the project
    string? body;
    # The API URL for this project resource.
    string url;
    # The API URL of the project's owner resource.
    @jsondata:Name {value: "owner_url"}
    string ownerUrl;
    # The sequential number identifying this project within its owner.
    int number;
    # The timestamp when this project was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The URL to view this project on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Name of the project
    string name;
    # The unique numeric identifier for this project.
    int id;
    # State of the project; either 'open' or 'closed'
    string state;
    # The unique GraphQL node identifier for this project.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# The billing plan for the organization
public type TeamOrganizationPlan record {
    # The number of private repositories allowed under this plan.
    @jsondata:Name {value: "private_repos"}
    int privateRepos;
    # The number of seats currently occupied in the organization.
    @jsondata:Name {value: "filled_seats"}
    int filledSeats?;
    # The name of the billing plan.
    string name;
    # The total number of seats available in this billing plan.
    int seats?;
    # The total storage space in bytes allocated by this plan.
    int space;
};

public type IssueNumberLabelsBody1 ReposownerrepoissuesissueNumberlabelsOneOf11|ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf112|ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf1123|ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf11234|ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf112345;

# Conditions to target repositories by id and refs by name
public type RepositoryIdAndRefName record {
    *RepositoryRulesetConditions;
    *RepositoryRulesetConditionsRepositoryIdTarget;
};

public type RefsrefBody record {
    # Indicates whether to force the update or to make sure the update is a fast-forward update. Leaving this out or setting it to false will make sure you're not overwriting work
    boolean force = false;
    # The SHA1 value to set this reference to
    string sha;
};

# Represents the Queries record for the operation: search/code
public type SearchCodeQueries record {
    # The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching code](https://docs.github.com/search-github/searching-on-github/searching-code)" for a detailed list of qualifiers
    string q;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # **This field is deprecated.** Sorts the results of your query. Can only be indexed, which indicates how recently a file has been indexed by the GitHub search infrastructure. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    # 
    # # Deprecated
    @deprecated
    "indexed" sort?;
    # Page number of the results to fetch
    int page = 1;
    # **This field is deprecated.** Determines whether the first search result returned is the highest number of matches (desc) or lowest number of matches (asc). This parameter is ignored unless you provide sort. 
    # 
    # # Deprecated
    @deprecated
    "desc"|"asc" 'order = "desc";
};

# Topic Search Result Item
public type TopicSearchResultItem record {
    # A brief summary description of the topic.
    @jsondata:Name {value: "short_description"}
    string? shortDescription;
    # Indicates whether this topic is featured by GitHub.
    boolean featured;
    # List of alternative names or aliases for this topic.
    TopicSearchResultItemAliases[]? aliases?;
    # The URL of the logo image associated with this topic.
    @jsondata:Name {value: "logo_url"}
    string? logoUrl?;
    # The full description of the topic.
    string? description;
    # The timestamp when this topic was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The human-readable display name for this topic.
    @jsondata:Name {value: "display_name"}
    string? displayName;
    # The user or organization that created this topic.
    @jsondata:Name {value: "created_by"}
    string? createdBy;
    # The search relevance score for this topic result.
    decimal score;
    # The timestamp when this topic was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # List of topics related to this topic.
    TopicSearchResultItemAliases[]? related?;
    # Indicates whether this topic has been curated by GitHub.
    boolean curated;
    # Text fragments matching the search query within this topic.
    @jsondata:Name {value: "text_matches"}
    SearchResultTextMatches textMatches?;
    # The unique name identifier for this topic.
    string name;
    # The number of repositories tagged with this topic.
    @jsondata:Name {value: "repository_count"}
    int? repositoryCount?;
    # The release date or version associated with this topic.
    string? released;
};

# Set secrets for GitHub Actions
public type ActionsSecretResponse record {
    # The total number of Actions secrets available.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of Actions secrets.
    ActionsSecret[] secrets;
};

# A codespace
public type Codespace record {
    # UUID identifying this codespace's environment
    @jsondata:Name {value: "environment_id"}
    string? environmentId;
    # Whether or not a codespace has a pending async operation. This would mean that the codespace is temporarily unavailable. The only thing that you can do with a codespace in this state is delete it
    @jsondata:Name {value: "pending_operation"}
    boolean? pendingOperation?;
    # The user to whom charges for this codespace are billed.
    @jsondata:Name {value: "billable_owner"}
    SimpleUser billableOwner;
    # API URL to start this codespace
    @jsondata:Name {value: "start_url"}
    string startUrl;
    # The timestamp when this codespace was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # API URL to stop this codespace
    @jsondata:Name {value: "stop_url"}
    string stopUrl;
    # The repository associated with this codespace.
    MinimalRepository repository;
    # Last known time this codespace was started
    @jsondata:Name {value: "last_used_at"}
    string lastUsedAt;
    # Whether the codespace was created from a prebuild
    boolean? prebuild;
    # The timestamp when this codespace was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # When a codespace will be auto-deleted based on the "retention_period_minutes" and "last_used_at"
    @jsondata:Name {value: "retention_expires_at"}
    string? retentionExpiresAt?;
    # Unique numeric identifier for this codespace.
    int id;
    # State of this codespace
    "Unknown"|"Created"|"Queued"|"Provisioning"|"Available"|"Awaiting"|"Unavailable"|"Deleted"|"Moved"|"Shutdown"|"Archived"|"Starting"|"ShuttingDown"|"Failed"|"Exporting"|"Updating"|"Rebuilding" state;
    # The current git status of the codespace's working directory.
    @jsondata:Name {value: "git_status"}
    CodespaceGitStatus gitStatus;
    # API URL to publish this codespace to a new repository
    @jsondata:Name {value: "publish_url"}
    string? publishUrl?;
    # API URL to access available alternate machine types for this codespace
    @jsondata:Name {value: "machines_url"}
    string machinesUrl;
    # The user who owns this codespace.
    SimpleUser owner;
    # Runtime constraints applied to this codespace.
    @jsondata:Name {value: "runtime_constraints"}
    CodespaceRuntimeConstraints runtimeConstraints?;
    # The text to display to a user when a codespace has been stopped for a potentially actionable reason
    @jsondata:Name {value: "last_known_stop_notice"}
    string? lastKnownStopNotice?;
    # List of recently opened folders in this codespace.
    @jsondata:Name {value: "recent_folders"}
    string[] recentFolders;
    # Duration in minutes after codespace has gone idle in which it will be deleted. Must be integer minutes between 0 and 43200 (30 days)
    @jsondata:Name {value: "retention_period_minutes"}
    int? retentionPeriodMinutes?;
    # Display name for this codespace
    @jsondata:Name {value: "display_name"}
    string? displayName?;
    # API URL for this codespace
    string url;
    # Path to devcontainer.json from repo root used to create Codespace
    @jsondata:Name {value: "devcontainer_path"}
    string? devcontainerPath?;
    # Text to show user when codespace is disabled by a pending operation
    @jsondata:Name {value: "pending_operation_disabled_reason"}
    string? pendingOperationDisabledReason?;
    # URL to access this codespace on the web
    @jsondata:Name {value: "web_url"}
    string webUrl;
    # The machine type used by this codespace.
    NullableCodespaceMachine? machine;
    # Automatically generated name of this codespace
    string name;
    # API URL for the Pull Request associated with this codespace, if any
    @jsondata:Name {value: "pulls_url"}
    string? pullsUrl;
    # The initally assigned location of a new codespace
    "EastUs"|"SouthEastAsia"|"WestEurope"|"WestUs2" location;
    # Text to show user when codespace idle timeout minutes has been overriden by an organization policy
    @jsondata:Name {value: "idle_timeout_notice"}
    string? idleTimeoutNotice?;
    # The number of minutes of inactivity after which this codespace will be automatically stopped
    @jsondata:Name {value: "idle_timeout_minutes"}
    int? idleTimeoutMinutes;
};

# Labeled Issue Event
public type LabeledIssueEvent record {
    # The user who triggered this labeled event.
    SimpleUser actor;
    # API URL of the commit associated with this event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The GitHub App that triggered this event, if any.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The timestamp when this event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Unique numeric identifier for this event.
    int id;
    # The label that was applied in this event.
    UnlabeledIssueEventLabel label;
    # The type of event that occurred.
    string event;
    # The SHA of the commit associated with this event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # API URL for this event.
    string url;
    # Global node identifier for this event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Tag protection
public type TagProtection record {
    # The timestamp when this tag protection rule was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    # The pattern that tags must match to be protected.
    string pattern;
    # The timestamp when this tag protection rule was created.
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    # Unique numeric identifier for this tag protection rule.
    int id?;
    # Whether this tag protection rule is currently enabled.
    boolean enabled?;
};

public type NotificationThreadSubject record {
    # API URL of the latest comment on the notification subject.
    @jsondata:Name {value: "latest_comment_url"}
    string latestCommentUrl;
    # The title of the notification subject.
    string title;
    # The type of resource this notification subject refers to.
    string 'type;
    # API URL for the notification subject resource.
    string url;
};

public type RepoImportBody1 record {
    # The username to provide to the originating repository
    @jsondata:Name {value: "vcs_username"}
    string vcsUsername?;
    # The password to provide to the originating repository
    @jsondata:Name {value: "vcs_password"}
    string vcsPassword?;
    # For a tfvc import, the name of the project that is being imported
    @jsondata:Name {value: "tfvc_project"}
    string tfvcProject?;
    # The type of version control system you are migrating from
    "subversion"|"tfvc"|"git"|"mercurial" vcs?;
};

public type Traffic record {
    # The number of unique visitors for this traffic entry.
    int uniques;
    # The total number of views or clones for this traffic entry.
    int count;
    # The timestamp representing this traffic data point.
    string timestamp;
};

# Represents the Queries record for the operation: activity/list-public-events-for-repo-network
public type ActivityListPublicEventsForRepoNetworkQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type ActionsBillingUsage record {
    # The total paid GitHub Actions minutes used
    @jsondata:Name {value: "total_paid_minutes_used"}
    int totalPaidMinutesUsed;
    # The amount of free GitHub Actions minutes available
    @jsondata:Name {value: "included_minutes"}
    int includedMinutes;
    # The sum of the free and paid GitHub Actions minutes used
    @jsondata:Name {value: "total_minutes_used"}
    int totalMinutesUsed;
    # Breakdown of GitHub Actions minutes used by operating system.
    @jsondata:Name {value: "minutes_used_breakdown"}
    ActionsBillingUsageMinutesUsedBreakdown minutesUsedBreakdown;
};

public type ProtectionRulesProtectionRulesAnyOf12 record {
    # Whether deployments to this environment can be approved by the user who created the deployment
    @jsondata:Name {value: "prevent_self_review"}
    boolean preventSelfReview?;
    # Unique numeric identifier for this protection rule.
    int id;
    # The type of protection rule.
    string 'type;
    # The people or teams that may approve jobs that reference the environment. You can list up to six users or teams as reviewers. The reviewers must have at least read access to the repository. Only one of the required reviewers needs to approve the job for it to proceed
    PendingDeploymentReviewers[] reviewers?;
    # Global node identifier for this protection rule.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents the Queries record for the operation: issues/list-labels-for-repo
public type IssuesListLabelsForRepoQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: teams/list-repos-legacy
public type TeamsListReposLegacyQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Response
public type RuleSuites RuleSuitesInner[];

# Represents the Queries record for the operation: packages/restore-package-for-authenticated-user
public type PackagesRestorePackageForAuthenticatedUserQueries record {
    # package token
    string token?;
};

# Repository Collaborator Permission
public type RepositoryCollaboratorPermission record {
    # The name of the role assigned to the collaborator.
    @jsondata:Name {value: "role_name"}
    string roleName;
    # The permission level granted to the collaborator.
    string permission;
    # The collaborator user associated with this permission.
    NullableCollaborator? user;
};

public type PullNumberUpdateBranchBody record {
    # The expected SHA of the pull request's HEAD ref. This is the most recent commit on the pull request's branch. If the expected SHA does not match the pull request's HEAD, you will receive a 422 Unprocessable Entity status. You can use the "[List commits](https://docs.github.com/rest/commits/commits#list-commits)" endpoint to find the most recent commit SHA. Default: SHA of the pull request's current HEAD ref
    @jsondata:Name {value: "expected_head_sha"}
    string expectedHeadSha?;
};

public type PullNumberReviewsBody record {
    # Use the following table to specify the location, destination, and contents of the draft review comment
    ReposownerrepopullspullNumberreviewsComments[] comments?;
    # **Required** when using REQUEST_CHANGES or COMMENT for the event parameter. The body text of the pull request review
    string body?;
    # The review action you want to perform. The review actions include: APPROVE, REQUEST_CHANGES, or COMMENT. By leaving this blank, you set the review action state to PENDING, which means you will need to [submit the pull request review](https://docs.github.com/rest/pulls/reviews#submit-a-review-for-a-pull-request) when you are ready
    "APPROVE"|"REQUEST_CHANGES"|"COMMENT" event?;
    # The SHA of the commit that needs a review. Not using the latest commit SHA may render your review comment outdated if a subsequent commit modifies the line you specify as the position. Defaults to the most recent commit in the pull request when you do not specify a value
    @jsondata:Name {value: "commit_id"}
    string commitId?;
};

# Represents the Queries record for the operation: security-advisories/list-repository-advisories
public type SecurityAdvisoriesListRepositoryAdvisoriesQueries record {
    # Number of advisories to return per page
    @http:Query {name: "per_page"}
    int perPage = 30;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor
    string before?;
    # The property to sort the results by
    "created"|"updated"|"published" sort = "created";
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor
    string after?;
    # Filter by state of the repository advisories. Only advisories of this state will be returned
    "triage"|"draft"|"published"|"closed" state?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# Represents the Queries record for the operation: code-scanning/list-alerts-for-org
public type CodeScanningListAlertsForOrgQueries record {
    # The name of a code scanning tool. Only results by this tool will be listed. You can specify the tool by using either tool_name or tool_guid, but not both
    @http:Query {name: "tool_name"}
    CodeScanningAnalysisToolName toolName?;
    # If specified, only code scanning alerts with this severity will be returned
    CodeScanningAlertSeverity severity?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor
    string before?;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor
    string after?;
    # Page number of the results to fetch
    int page = 1;
    # If specified, only code scanning alerts with this state will be returned
    CodeScanningAlertStateQuery state?;
    # The property by which to sort the results
    "created"|"updated" sort = "created";
    # The GUID of a code scanning tool. Only results by this tool will be listed. Note that some code scanning tools may not include a GUID in their analysis data. You can specify the tool by using either tool_guid or tool_name, but not both
    @http:Query {name: "tool_guid"}
    CodeScanningAnalysisToolGuid? toolGuid?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# Represents the Queries record for the operation: repos/get-readme-in-directory
public type ReposGetReadmeInDirectoryQueries record {
    # The name of the commit/branch/tag. Default: the repository’s default branch
    string ref?;
};

public type FileCommitContent record {
    # The file path relative to the repository root.
    string path?;
    # The size of the file in bytes.
    int size?;
    # Hypermedia links related to this file content resource.
    @jsondata:Name {value: "_links"}
    FileCommitContentLinks links?;
    # URL to view this file on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The name of the file.
    string name?;
    # URL to download the raw file contents.
    @jsondata:Name {value: "download_url"}
    string downloadUrl?;
    # API URL for this file's git object.
    @jsondata:Name {value: "git_url"}
    string gitUrl?;
    # The type of content, such as file or directory.
    string 'type?;
    # The SHA hash of the file blob.
    string sha?;
    # API URL for this file content resource.
    string url?;
};

public type ReviewIdDismissalsBody record {
    # The message for the pull request review dismissal
    string message;
    # The event action for dismissing the pull request review.
    "DISMISS" event?;
};

# Rate Limit Overview
public type RateLimitOverview record {
    # The core rate limit data for the authenticated user.
    RateLimit rate;
    # Rate limit data broken down by resource type.
    RateLimitOverviewResources resources;
};

# A repository rule
public type RepositoryRule RepositoryRuleCreation|RepositoryRuleUpdate|RepositoryRuleDeletion|RepositoryRuleRequiredLinearHistory|RepositoryRuleRequiredDeployments|RepositoryRuleRequiredSignatures|RepositoryRulePullRequest|RepositoryRuleRequiredStatusChecks|RepositoryRuleNonFastForward|RepositoryRuleCommitMessagePattern|RepositoryRuleCommitAuthorEmailPattern|RepositoryRuleCommitterEmailPattern|RepositoryRuleBranchNamePattern|RepositoryRuleTagNamePattern;

public type PullRequestReviewCommentLinksSelf record {
    # The URL of the pull request review comment itself.
    string href;
};

# Sets the state of the secret scanning alert. You must provide resolution when you set the state to resolved
public type SecretScanningAlertState "open"|"resolved";

# Represents the Queries record for the operation: projects/list-for-user
public type ProjectsListForUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Indicates the state of the projects to return
    "open"|"closed"|"all" state = "open";
    # Page number of the results to fetch
    int page = 1;
};

# Parameters to be used for the commit_message_pattern rule
public type RepositoryRuleCommitMessagePattern record {
    # The type identifier for the commit message pattern rule.
    "commit_message_pattern" 'type;
    # Parameters defining the commit message pattern matching criteria.
    RepositoryRuleBranchNamePatternParameters parameters?;
};

# The amount of time to delay a job after the job is initially triggered. The time (in minutes) must be an integer between 0 and 43,200 (30 days)
public type WaitTimer int;

public type ReposownerrepobranchesbranchprotectionRequiredStatusChecksChecks record {
    # The name of the required check
    string context;
    # The ID of the GitHub App that must provide this check. Omit this field to automatically select the GitHub App that has recently provided this check, or any app if it was not set by a GitHub App. Pass -1 to explicitly allow any app to set the status
    @jsondata:Name {value: "app_id"}
    int appId?;
};

# Represents the Queries record for the operation: repos/list-branches
public type ReposListBranchesQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Setting to true returns only protected branches. When set to false, only unprotected branches are returned. Omitting this parameter returns all branches
    boolean protected?;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: apps/list-installations
public type AppsListInstallationsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Filter to only return outdated installations.
    string outdated?;
    # Page number of the results to fetch
    int page = 1;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

public type RepoNotificationsBody record {
    # Describes the last point that notifications were checked. Anything updated since this time will not be marked as read. If you omit this parameter, all notifications are marked as read. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ. Default: The current timestamp
    @jsondata:Name {value: "last_read_at"}
    string lastReadAt?;
};

# Deletes one or more email addresses from your GitHub account. Must contain at least one email address. **Note:** Alternatively, you can pass a single email address or an array of emails addresses directly, but we recommend that you pass an object using the emails key
public type UseremailsOneOf11 record {
    # Email addresses associated with the GitHub user account
    string[] emails;
};

public type PullRequestHeadRepo record {
    # Indicates whether forking this repository is allowed.
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking?;
    # The number of users who have starred the repository.
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount;
    # Indicates whether this repository is a template repository.
    @jsondata:Name {value: "is_template"}
    boolean isTemplate?;
    # Timestamp of the most recent push to the repository.
    @jsondata:Name {value: "pushed_at"}
    string pushedAt;
    # API URL for managing repository subscriptions.
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    # The primary programming language used in the repository.
    string? language;
    # API URL template for accessing repository branches.
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    # API URL template for accessing issue comments.
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    # Indicates whether rebase merging is allowed for pull requests.
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge?;
    # API URL template for accessing repository labels.
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # API URL for listing repository subscribers.
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    # The permissions the current user has on this repository.
    RepoSearchResultItemPermissions permissions?;
    # Temporary token used for cloning the repository.
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    # API URL template for accessing repository releases.
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    # The SVN-compatible URL for the repository.
    @jsondata:Name {value: "svn_url"}
    string svnUrl;
    # The unique numeric identifier of the repository.
    int id;
    # Indicates whether the repository has discussions enabled.
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions;
    # The name of the master branch of the repository.
    @jsondata:Name {value: "master_branch"}
    string masterBranch?;
    # The number of forks of the repository.
    int forks;
    # API URL template for downloading repository archives.
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    # Indicates whether merge commits are allowed for pull requests.
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit?;
    # API URL template for accessing git refs.
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    # API URL for listing repository forks.
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The repository visibility: public, private, or internal
    string visibility?;
    # API URL template for accessing commit statuses.
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    # The SSH URL used to clone the repository.
    @jsondata:Name {value: "ssh_url"}
    string sshUrl;
    # The license associated with the repository.
    PullRequestHeadRepoLicense? license;
    # The full name of the repository, including owner and repo name.
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The size of the repository in kilobytes.
    int size;
    # API URL for listing the programming languages used.
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    # API URL template for accessing repository collaborators.
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    # The HTML URL for viewing the repository on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The HTTPS URL used to clone the repository.
    @jsondata:Name {value: "clone_url"}
    string cloneUrl;
    # The name of the repository.
    string name;
    # API URL template for accessing pull requests.
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    # The default branch of the repository.
    @jsondata:Name {value: "default_branch"}
    string defaultBranch;
    # API URL for managing repository webhooks.
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    # API URL template for accessing git trees.
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    # API URL for listing repository tags.
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    # API URL for listing repository contributors.
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    # Indicates whether the repository is private.
    boolean 'private;
    # Indicates whether the repository has downloads enabled.
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads;
    # API URL template for accessing repository notifications.
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    # The number of open issues in the repository.
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount;
    # A short description of the repository.
    string? description;
    # The number of users watching the repository.
    int watchers;
    # Timestamp when the repository was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # API URL for listing repository deployments.
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    # API URL template for accessing deploy keys.
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    # Indicates whether the repository has projects enabled.
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects;
    # Indicates whether the repository has been archived.
    boolean archived;
    # Indicates whether the repository has a wiki enabled.
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki;
    # Timestamp when the repository was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # API URL template for accessing repository comments.
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # API URL for listing users who starred the repository.
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    # Indicates whether the repository has been disabled.
    boolean disabled;
    # The Git URL used to clone the repository.
    @jsondata:Name {value: "git_url"}
    string gitUrl;
    # Indicates whether the repository has GitHub Pages enabled.
    @jsondata:Name {value: "has_pages"}
    boolean hasPages;
    # The user or organization that owns the repository.
    PullRequestHeadRepoOwner owner;
    # Indicates whether squash merging is allowed for pull requests.
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge?;
    # API URL template for accessing repository commits.
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    # API URL template for comparing two refs in the repository.
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    # API URL template for accessing git commit objects.
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    # List of topics associated with the repository.
    string[] topics?;
    # API URL template for accessing git blob objects.
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    # API URL template for accessing git tag objects.
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    # API URL for performing repository merges.
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    # API URL for listing repository downloads.
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    # Indicates whether the repository has issues enabled.
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues;
    # Indicates whether web commits must be signed off.
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    # The API URL for the repository.
    string url;
    # API URL template for accessing repository contents.
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    # The URL this repository mirrors, if applicable.
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl;
    # API URL template for accessing repository milestones.
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    # API URL for listing teams with access to the repository.
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    # Indicates whether this repository is a fork.
    boolean 'fork;
    # API URL template for accessing repository issues.
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # API URL for listing repository events.
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # API URL for listing issue events in the repository.
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    # API URL template for accessing possible issue assignees.
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    # The number of open issues and pull requests.
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    # The number of users watching the repository.
    @jsondata:Name {value: "watchers_count"}
    int watchersCount;
    # The GraphQL node ID of the repository.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The number of forks of the repository.
    @jsondata:Name {value: "forks_count"}
    int forksCount;
    # The URL of the repository's homepage.
    string? homepage;
};

# A unique encryption key
public type GpgKey record {
    # The public key value of the GPG key.
    @jsondata:Name {value: "public_key"}
    string publicKey;
    # The unique identifier string of the GPG key.
    @jsondata:Name {value: "key_id"}
    string keyId;
    # Timestamp when the GPG key was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Indicates whether the GPG key has been revoked.
    boolean revoked;
    # The raw key data string of the GPG key.
    @jsondata:Name {value: "raw_key"}
    string? rawKey;
    # List of email addresses associated with the GPG key.
    GpgKeyEmails[] emails;
    # Indicates whether this key can be used to certify other keys.
    @jsondata:Name {value: "can_certify"}
    boolean canCertify;
    # Timestamp when the GPG key expires, or null if it never expires.
    @jsondata:Name {value: "expires_at"}
    string? expiresAt;
    # Indicates whether this key can encrypt communications.
    @jsondata:Name {value: "can_encrypt_comms"}
    boolean canEncryptComms;
    # The display name associated with the GPG key.
    string? name?;
    # Indicates whether this key can encrypt storage.
    @jsondata:Name {value: "can_encrypt_storage"}
    boolean canEncryptStorage;
    # Indicates whether this key can be used to create signatures.
    @jsondata:Name {value: "can_sign"}
    boolean canSign;
    # The unique numeric identifier of the GPG key.
    int id;
    # List of subkeys associated with this GPG key.
    GpgKeySubkeys[] subkeys;
    # The ID of the primary GPG key this key is associated with.
    @jsondata:Name {value: "primary_key_id"}
    int? primaryKeyId;
};

# Represents the Queries record for the operation: users/list-public-keys-for-user
public type UsersListPublicKeysForUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type PullNumberRequestedReviewersBody anydata;

# Represents the Queries record for the operation: gists/list
public type GistsListQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

# Color-coded labels help you categorize and filter your issues (just like labels in Gmail)
public type Label record {
    # Whether this label comes by default in a new repository
    boolean default;
    # 6-character hex code, without the leading #, identifying the color
    string color;
    # The name of the label
    string name;
    # Optional description of the label, such as its purpose
    string? description;
    # Unique identifier for the label
    int id;
    # URL for the label
    string url;
    # The GraphQL node ID of the label.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type StarredRepositoryResponseAnyOf1 StarredRepository[];

public type FileCommitCommit record {
    # Details about the person who committed the file change.
    FileCommitCommitAuthor committer?;
    # Details about the person who authored the file change.
    FileCommitCommitAuthor author?;
    # The HTML URL to view the commit on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The git tree object associated with this commit.
    FileCommitCommitTree tree?;
    # The commit message describing the file change.
    string message?;
    # The SHA hash of the commit object.
    string sha?;
    # The API URL for the commit.
    string url?;
    # Signature verification details for the commit.
    FileCommitCommitVerification verification?;
    # The GraphQL node ID of the commit.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
    # List of parent commits for this commit.
    CommitSearchResultItemParents[] parents?;
};

# Represents the Queries record for the operation: migrations/list-repos-for-org
public type MigrationsListReposForOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# License Content
public type LicenseContent record {
    # Hypermedia links for navigating related resources.
    @jsondata:Name {value: "_links"}
    ContentSymlinkLinks links;
    # The type of the content object.
    string 'type;
    # The encoding used for the content field.
    string encoding;
    # The SHA hash of the file content.
    string sha;
    # The API URL for the license content.
    string url;
    # The Base64-encoded content of the license file.
    string content;
    # The path of the license file within the repository.
    string path;
    # The license information associated with this content.
    NullableLicenseSimple? license;
    # The size of the file in bytes.
    int size;
    # The HTML URL to view the license file on GitHub.
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    # The filename of the license file.
    string name;
    # The URL to download the raw license file content.
    @jsondata:Name {value: "download_url"}
    string? downloadUrl;
    # The API URL for the git blob object of the license file.
    @jsondata:Name {value: "git_url"}
    string? gitUrl;
};

# A label for a self hosted runner
public type RunnerLabelResponse record {
    # The total number of labels associated with the runner.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of labels assigned to the self-hosted runner.
    RunnerLabel[] labels;
};

public type ActionsRepositoryPermissions record {
    # The permissions policy that controls which actions are allowed to run.
    @jsondata:Name {value: "allowed_actions"}
    AllowedActions allowedActions?;
    # The API URL to retrieve the list of selected allowed actions.
    @jsondata:Name {value: "selected_actions_url"}
    SelectedActionsUrl selectedActionsUrl?;
    # Indicates whether GitHub Actions is enabled for the repository.
    ActionsEnabled enabled;
};

public type RepoCheckRunsBody record {"completed" status;}|record {"queued"|"in_progress" status?;};

# Whether to set the branch as read-only. If this is true, users will not be able to push to the branch
public type ProtectedBranchLockBranch record {|
    # Indicates whether the branch is locked as read-only.
    boolean enabled = false;
|};

public type CommitShaCommentsBody record {
    # Relative path of the file to comment on
    string path?;
    # **Deprecated**. Use **position** parameter instead. Line number in the file to comment on
    int line?;
    # Line index in the diff to comment on
    int position?;
    # The contents of the comment
    string body;
};

public type UsercodespacesusercodespacesOneOf12 record {
    # The geographic area for this codespace. If not specified, the value is assigned by IP. This property replaces location, which is being deprecated
    "EuropeWest"|"SoutheastAsia"|"UsEast"|"UsWest" geo?;
    # Path to devcontainer.json config to use for this codespace
    @jsondata:Name {value: "devcontainer_path"}
    string devcontainerPath?;
    # The pull request to create a codespace from.
    @jsondata:Name {value: "pull_request"}
    UsercodespacesPullRequest pullRequest;
    # Machine type to use for this codespace
    string machine?;
    # The requested location for a new codespace. Best efforts are made to respect this upon creation. Assigned by IP if not provided
    string location?;
    # Working directory for this codespace
    @jsondata:Name {value: "working_directory"}
    string workingDirectory?;
    # Time in minutes before codespace stops from inactivity
    @jsondata:Name {value: "idle_timeout_minutes"}
    int idleTimeoutMinutes?;
};

public type CodeScanningAlert record {
    # The URL to retrieve all instances of this code scanning alert.
    @jsondata:Name {value: "instances_url"}
    AlertInstancesUrl instancesUrl;
    # Timestamp when the code scanning alert was created.
    @jsondata:Name {value: "created_at"}
    AlertCreatedAt createdAt;
    # Optional comment provided when the alert was dismissed.
    @jsondata:Name {value: "dismissed_comment"}
    CodeScanningAlertDismissedComment? dismissedComment?;
    # The code scanning rule that triggered this alert.
    CodeScanningAlertRule rule;
    # The API URL for this code scanning alert.
    AlertUrl url;
    # The analysis tool that generated this code scanning alert.
    CodeScanningAnalysisTool tool;
    # The unique number identifying this alert within the repository.
    AlertNumber number;
    # Timestamp when the code scanning alert was last updated.
    @jsondata:Name {value: "updated_at"}
    AlertUpdatedAt updatedAt?;
    # The HTML URL to view the alert on GitHub.
    @jsondata:Name {value: "html_url"}
    AlertHtmlUrl htmlUrl;
    # Timestamp when the code scanning alert was fixed.
    @jsondata:Name {value: "fixed_at"}
    AlertFixedAt? fixedAt?;
    # The most recent instance of this code scanning alert.
    @jsondata:Name {value: "most_recent_instance"}
    CodeScanningAlertInstance mostRecentInstance;
    # The state of the code scanning alert.
    CodeScanningAlertState state;
    # The user who dismissed the code scanning alert.
    @jsondata:Name {value: "dismissed_by"}
    NullableSimpleUser? dismissedBy;
    # The reason provided for dismissing the alert.
    @jsondata:Name {value: "dismissed_reason"}
    CodeScanningAlertDismissedReason? dismissedReason;
    # Timestamp when the code scanning alert was dismissed.
    @jsondata:Name {value: "dismissed_at"}
    AlertDismissedAt? dismissedAt;
};

# A GitHub user simplified for Classroom
public type SimpleClassroomUser record {
    # The URL of the user's avatar image.
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # The HTML URL of the user's GitHub profile.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The unique numeric identifier of the GitHub user.
    int id;
    # The GitHub username (login handle) of the user.
    string login;
};

# Set secrets for Dependabot
public type DependabotSecretResponse record {
    # The total number of Dependabot secrets available.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of Dependabot secrets.
    DependabotSecret[] secrets;
};

# Interaction limit settings
public type InteractionLimitResponseAny InteractionLimitResponse|InteractionLimitResponseAnyAnyOf2;

public type FileCommitContentLinks record {
    # The API URL for the git blob object of the file.
    string git?;
    # The API URL for the file content resource.
    string self?;
    # The HTML URL to view the file on GitHub.
    string html?;
};

# Actions OIDC Subject customization
public type OidcCustomSub record {
    # Array of unique strings. Each claim key can only contain alphanumeric characters and underscores
    @jsondata:Name {value: "include_claim_keys"}
    string[] includeClaimKeys;
};

# A set of rules to apply when specified conditions are met
public type RepositoryRuleset record {
    # Hypermedia links for navigating related ruleset resources.
    @jsondata:Name {value: "_links"}
    RepositoryRulesetLinks links?;
    # The enforcement level of the ruleset.
    RepositoryRuleEnforcement enforcement;
    # Timestamp when the ruleset was created.
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    # The type of the source of the ruleset
    @jsondata:Name {value: "source_type"}
    "Repository"|"Organization" sourceType?;
    # The list of rules included in this ruleset.
    RepositoryRule[] rules?;
    # The name of the source
    string 'source;
    # The target of the ruleset
    "branch"|"tag" target?;
    # The actors that can bypass the rules in this ruleset
    @jsondata:Name {value: "bypass_actors"}
    RepositoryRulesetBypassActor[] bypassActors?;
    # Timestamp when the ruleset was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    # The bypass type of the user making the API request for this ruleset. This field is only returned when
    # querying the repository-level endpoint
    @jsondata:Name {value: "current_user_can_bypass"}
    "always"|"pull_requests_only"|"never" currentUserCanBypass?;
    # The name of the ruleset
    string name;
    # The ID of the ruleset
    int id;
    # The conditions that determine when this ruleset applies.
    RepositoryRulesetConditions|OrgRulesetConditions conditions?;
    # The GraphQL node ID of the ruleset.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# The full Git reference, formatted as refs/heads/<branch name>,
# refs/pull/<number>/merge, or refs/pull/<number>/head
public type CodeScanningRef string;

# Check Automated Security Fixes
public type CheckAutomatedSecurityFixes record {
    # Whether automated security fixes are paused for the repository
    boolean paused;
    # Whether automated security fixes are enabled for the repository
    boolean enabled;
};

public type ReposownerrepoissuesissueNumberLabels LabelsOneOf11|LabelsLabelsOneOf112;

public type ApiOverviewSshKeyFingerprints record {
    # The SHA256 fingerprint of the RSA SSH host key.
    @jsondata:Name {value: "SHA256_RSA"}
    string sHA256RSA?;
    # The SHA256 fingerprint of the DSA SSH host key.
    @jsondata:Name {value: "SHA256_DSA"}
    string sHA256DSA?;
    # The SHA256 fingerprint of the ECDSA SSH host key.
    @jsondata:Name {value: "SHA256_ECDSA"}
    string sHA256ECDSA?;
    # The SHA256 fingerprint of the Ed25519 SSH host key.
    @jsondata:Name {value: "SHA256_ED25519"}
    string sHA256ED25519?;
};

# Clone Traffic
public type CloneTraffic record {
    # List of clone traffic data points over time.
    Traffic[] clones;
    # The total number of clones over the reporting period.
    int count;
    # The number of unique cloners over the reporting period.
    int uniques;
};

public type BillingSelectedTeamsBody1 record {
    # The names of teams from which to revoke access to GitHub Copilot
    @jsondata:Name {value: "selected_teams"}
    string[] selectedTeams;
};

# Represents the Queries record for the operation: repos/list-invitations-for-authenticated-user
public type ReposListInvitationsForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type PullRequestReviewCommentLinksPullRequest record {
    # The URL of the pull request associated with this review comment.
    string href;
};

public type GitCommitParents record {
    # The HTML URL to view the parent commit on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # SHA for the commit
    string sha;
    # The API URL for the parent commit.
    string url;
};

public type PullspullNumberBody record {
    # Indicates whether [maintainers can modify](https://docs.github.com/articles/allowing-changes-to-a-pull-request-branch-created-from-a-fork/) the pull request
    @jsondata:Name {value: "maintainer_can_modify"}
    boolean maintainerCanModify?;
    # State of this Pull Request. Either open or closed
    "open"|"closed" state?;
    # The title of the pull request
    string title?;
    # The contents of the pull request
    string body?;
    # The name of the branch you want your changes pulled into. This should be an existing branch on the current repository. You cannot update the base branch on a pull request to point to another repository
    string base?;
};

# Represents the Queries record for the operation: orgs/list-pending-invitations
public type OrgsListPendingInvitationsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Filter invitations by their invitation source
    @http:Query {name: "invitation_source"}
    "all"|"member"|"scim" invitationSource = "all";
    # Filter invitations by their member role
    "all"|"admin"|"direct_member"|"billing_manager"|"hiring_manager" role = "all";
    # Page number of the results to fetch
    int page = 1;
};

public type RemovedFromProjectIssueEventProjectCard record {
    # The unique identifier of the project the card belonged to.
    @jsondata:Name {value: "project_id"}
    int projectId;
    # The name of the column from which the card was removed.
    @jsondata:Name {value: "column_name"}
    string columnName;
    # The URL of the project the card belonged to.
    @jsondata:Name {value: "project_url"}
    string projectUrl;
    # The unique identifier of the project card.
    int id;
    # The name of the column the card was in before removal.
    @jsondata:Name {value: "previous_column_name"}
    string previousColumnName?;
    # The API URL for the project card.
    string url;
};

public type RepoMergeUpstreamBody record {
    # The name of the branch which should be updated to match upstream
    string branch;
};

# Represents the Queries record for the operation: repos/list-releases
public type ReposListReleasesQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type CollaboratorsusernameBody1 record {
    # The permission to grant the collaborator. **Only valid on organization-owned repositories.** We accept the following permissions to be set: pull, triage, push, maintain, admin and you can also specify a custom repository role name, if the owning organization has defined any
    string permission = "push";
};

public type RepositoryAdvisoryCreate record {|
    # A short summary of the advisory
    @constraint:String {maxLength: 1024}
    string summary;
    # The severity of the advisory. You must choose between setting this field or cvss_vector_string
    "critical"|"high"|"medium"|"low"? severity?;
    # The Common Vulnerabilities and Exposures (CVE) ID
    @jsondata:Name {value: "cve_id"}
    string? cveId?;
    # A list of users receiving credit for their participation in the security advisory
    RepositoryAdvisoryCreateCredits[]? credits?;
    # The CVSS vector that calculates the severity of the advisory. You must choose between setting this field or severity
    @jsondata:Name {value: "cvss_vector_string"}
    string? cvssVectorString?;
    # A detailed description of what the advisory impacts
    @constraint:String {maxLength: 65535}
    string description;
    # A product affected by the vulnerability detailed in a repository security advisory
    RepositoryAdvisoryCreateVulnerabilities[] vulnerabilities;
    # A list of Common Weakness Enumeration (CWE) IDs
    @jsondata:Name {value: "cwe_ids"}
    string[]? cweIds?;
|};

# Code Of Conduct
public type CodeOfConduct record {
    # The HTML URL to view the code of conduct on GitHub.
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    # The display name of the code of conduct.
    string name;
    # The full text content of the code of conduct.
    string body?;
    # The unique key identifier for the code of conduct.
    string 'key;
    # The API URL for the code of conduct.
    string url;
};

# Minimal representation of an organization programmatic access grant request for enumerations
public type OrganizationProgrammaticAccessGrantRequest record {
    # The GitHub user who owns the fine-grained personal access token.
    SimpleUser owner;
    # Reason for requesting access
    string? reason;
    # Type of repository selection requested
    @jsondata:Name {value: "repository_selection"}
    "none"|"all"|"subset" repositorySelection;
    # URL to the list of repositories requested to be accessed via fine-grained personal access token. Should only be followed when repository_selection is subset
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
    # Date and time when the associated fine-grained personal access token expires
    @jsondata:Name {value: "token_expires_at"}
    string? tokenExpiresAt;
    # The permissions requested by the fine-grained personal access token.
    OrganizationProgrammaticAccessGrantPermissions permissions;
    # Date and time when the associated fine-grained personal access token was last used for authentication
    @jsondata:Name {value: "token_last_used_at"}
    string? tokenLastUsedAt;
    # Date and time when the request for access was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Unique identifier of the request for access via fine-grained personal access token. The pat_request_id used to review PAT requests
    int id;
    # Whether the associated fine-grained personal access token has expired
    @jsondata:Name {value: "token_expired"}
    boolean tokenExpired;
};

public type RepoKeysBody record {
    # If true, the key will only be able to read repository contents. Otherwise, the key will be able to read and write.  
    #   
    # Deploy keys with write access can perform the same actions as an organization member with admin access, or a collaborator on a personal repository. For more information, see "[Repository permission levels for an organization](https://docs.github.com/articles/repository-permission-levels-for-an-organization/)" and "[Permission levels for a user account repository](https://docs.github.com/articles/permission-levels-for-a-user-account-repository/)."
    @jsondata:Name {value: "read_only"}
    boolean readOnly?;
    # A name for the key
    string title?;
    # The contents of the key
    string 'key;
};

public type ActionsSetDefaultWorkflowPermissions record {
    # The default permissions granted to the GITHUB_TOKEN for workflows.
    @jsondata:Name {value: "default_workflow_permissions"}
    ActionsDefaultWorkflowPermissions defaultWorkflowPermissions?;
    # Indicates whether GitHub Actions can approve pull request reviews.
    @jsondata:Name {value: "can_approve_pull_request_reviews"}
    ActionsCanApprovePullRequestReviews canApprovePullRequestReviews?;
};

public type InstallationIdAccessTokensBody record {
    # List of repository IDs that the token should have access to
    @jsondata:Name {value: "repository_ids"}
    int[] repositoryIds?;
    # List of repository names that the token should have access to
    string[] repositories?;
    # The permissions granted to the installation access token.
    AppPermissions permissions?;
};

public type RequiredStatusChecksContextsBody2 ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf12|ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsreposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf122;

# Set repository secrets for GitHub Codespaces
public type RepoCodespacesSecretResponse record {
    # The total number of Codespaces secrets for the repository.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of Codespaces secrets for the repository.
    RepoCodespacesSecret[] secrets;
};

# Contributor
public type Contributor record {
    # API URL template for the user's gists.
    @jsondata:Name {value: "gists_url"}
    string gistsUrl?;
    # API URL to list the user's repositories.
    @jsondata:Name {value: "repos_url"}
    string reposUrl?;
    # API URL template to check who the user is following.
    @jsondata:Name {value: "following_url"}
    string followingUrl?;
    # API URL template for repositories the user has starred.
    @jsondata:Name {value: "starred_url"}
    string starredUrl?;
    # The username of the contributor.
    string login?;
    # API URL to list the user's followers.
    @jsondata:Name {value: "followers_url"}
    string followersUrl?;
    # The type of the account.
    string 'type;
    # API URL for the contributor.
    string url?;
    # API URL to list repositories the user is watching.
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl?;
    # API URL for events received by the user.
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl?;
    # The total number of contributions made by the contributor.
    int contributions;
    # URL of the user's avatar image.
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl?;
    # API URL template for the user's events.
    @jsondata:Name {value: "events_url"}
    string eventsUrl?;
    # URL of the user's GitHub profile page.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # Whether the user is a GitHub site administrator.
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin?;
    # The display name of the contributor.
    string name?;
    # The unique identifier of the contributor.
    int id?;
    # The Gravatar ID of the user.
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId?;
    # The publicly visible email address of the contributor.
    string email?;
    # The GraphQL node identifier of the contributor.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
    # API URL to list the user's organizations.
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl?;
};

# Results of a successful merge upstream request
public type MergedUpstream record {
    # The name of the base branch that was synced upstream.
    @jsondata:Name {value: "base_branch"}
    string baseBranch?;
    # The type of merge operation performed during the upstream sync.
    @jsondata:Name {value: "merge_type"}
    "merge"|"fast-forward"|"none" mergeType?;
    # A message describing the result of the upstream merge.
    string message?;
};

public type TimelineCommittedEventTree record {
    # SHA for the commit
    string sha;
    # API URL for the tree object.
    string url;
};

# Represents the Queries record for the operation: repos/list-pull-requests-associated-with-commit
public type ReposListPullRequestsAssociatedWithCommitQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: pulls/list-review-comments
public type PullsListReviewCommentsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The property to sort the results by
    "created"|"updated" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # The direction to sort results. Ignored without sort parameter
    "asc"|"desc" direction?;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

public type RepositoryAdvisoryUpdate record {|
    # A short summary of the advisory
    @constraint:String {maxLength: 1024}
    string summary?;
    # The severity of the advisory. You must choose between setting this field or cvss_vector_string
    "critical"|"high"|"medium"|"low"? severity?;
    # The Common Vulnerabilities and Exposures (CVE) ID
    @jsondata:Name {value: "cve_id"}
    string? cveId?;
    # A list of users receiving credit for their participation in the security advisory
    RepositoryAdvisoryCreateCredits[]? credits?;
    # The CVSS vector that calculates the severity of the advisory. You must choose between setting this field or severity
    @jsondata:Name {value: "cvss_vector_string"}
    string? cvssVectorString?;
    # A list of team slugs which have been granted write access to the advisory
    @jsondata:Name {value: "collaborating_teams"}
    string[]? collaboratingTeams?;
    # A detailed description of what the advisory impacts
    @constraint:String {maxLength: 65535}
    string description?;
    # A product affected by the vulnerability detailed in a repository security advisory
    RepositoryAdvisoryCreateVulnerabilities[] vulnerabilities?;
    # The state of the advisory
    "published"|"closed"|"draft" state?;
    # A list of usernames who have been granted write access to the advisory
    @jsondata:Name {value: "collaborating_users"}
    string[]? collaboratingUsers?;
    # A list of Common Weakness Enumeration (CWE) IDs
    @jsondata:Name {value: "cwe_ids"}
    string[]? cweIds?;
|};

# Represents the Queries record for the operation: migrations/list-repos-for-authenticated-user
public type MigrationsListReposForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type RequiredStatusChecksContextsBody1 ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf11|ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsreposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf112;

# The status of auto merging a pull request
public type AutoMerge record {
    # Title for the merge commit message
    @jsondata:Name {value: "commit_title"}
    string commitTitle;
    # The user who enabled auto-merge on the pull request.
    @jsondata:Name {value: "enabled_by"}
    SimpleUser enabledBy;
    # Commit message for the merge commit
    @jsondata:Name {value: "commit_message"}
    string commitMessage;
    # The merge method to use
    @jsondata:Name {value: "merge_method"}
    "merge"|"squash"|"rebase" mergeMethod;
};

# Represents the Queries record for the operation: repos/list-invitations
public type ReposListInvitationsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: orgs/list-outside-collaborators
public type OrgsListOutsideCollaboratorsQueries record {
    # Filter the list of outside collaborators. 2fa_disabled means that only outside collaborators without [two-factor authentication](https://github.com/blog/1614-two-factor-authentication) enabled will be returned
    "2fa_disabled"|"all" filter = "all";
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type DependencyGraphSpdxSbomSbomExternalRefs record {
    # A locator for the particular external resource this reference refers to
    string referenceLocator;
    # The category of reference to an external resource this reference refers to
    string referenceType;
    # The category of reference to an external resource this reference refers to
    string referenceCategory;
};

public type PullRequestMinimalHeadRepo record {
    # The name of the repository.
    string name;
    # The unique identifier of the repository.
    int id;
    # API URL for the repository.
    string url;
};

# Social media account
public type SocialAccount record {
    # The social media platform provider name.
    string provider;
    # The URL of the user's social media profile.
    string url;
};

# Represents the Queries record for the operation: orgs/list-invitation-teams
public type OrgsListInvitationTeamsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Assigned Issue Event
public type AssignedIssueEvent record {
    # The user who triggered the assignment event.
    SimpleUser actor;
    # API URL for the commit associated with the event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The GitHub App that performed the assignment event.
    @jsondata:Name {value: "performed_via_github_app"}
    Integration performedViaGithubApp;
    # The user who assigned the issue.
    SimpleUser assigner;
    # The date and time the event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the event.
    int id;
    # The user who was assigned to the issue.
    SimpleUser assignee;
    # The type of event that occurred.
    string event;
    # The SHA of the commit associated with the event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # API URL for the event.
    string url;
    # The GraphQL node identifier of the event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type UserResponse PrivateUser|PublicUser;

# Branch With Protection
public type BranchWithProtection record {
    # Whether the branch has branch protection rules enabled.
    boolean protected;
    # Hypermedia links related to the branch.
    @jsondata:Name {value: "_links"}
    BranchWithProtectionLinks links;
    # The number of approving reviews required before merging.
    @jsondata:Name {value: "required_approving_review_count"}
    int requiredApprovingReviewCount?;
    # The name of the branch.
    string name;
    # The latest commit on the branch.
    Commit 'commit;
    # The branch name pattern used for protection rules.
    string pattern?;
    # The branch protection settings applied to the branch.
    BranchProtection protection;
    # API URL for the branch protection settings.
    @jsondata:Name {value: "protection_url"}
    string protectionUrl;
};

# Collaborator
public type Collaborator record {
    # API URL template for the user's gists
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    # API URL to list the user's repositories
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    # API URL template to check who the user is following
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    # API URL template for repositories the user has starred
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    # The username of the user
    string login;
    # API URL to list the user's followers
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    # The type of the account
    string 'type;
    # API URL for the user
    string url;
    # The role name assigned to the collaborator
    @jsondata:Name {value: "role_name"}
    string roleName;
    # API URL to list repositories the user is watching
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    # API URL for events received by the user
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    # URL of the user's avatar image
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # API URL template for the user's events
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # The permission levels granted to the collaborator on the repository.
    NullableCollaboratorPermissions permissions?;
    # URL of the user's GitHub profile page
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The display name of the user
    string? name?;
    # Whether the user is a GitHub site administrator
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    # The unique identifier of the user
    int id;
    # The Gravatar ID of the user
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    # The publicly visible email address of the user
    string? email?;
    # The GraphQL node identifier of the user
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # API URL to list the user's organizations
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
};

public type LabelsnameBody record {
    # The [hexadecimal color code](http://www.color-hex.com/) for the label, without the leading #
    string color?;
    # A short description of the label. Must be 100 characters or fewer
    string description?;
    # The new name of the label. Emoji can be added to label names, using either native emoji or colon-style markup. For example, typing :strawberry: will render the emoji ![:strawberry:](https://github.githubassets.com/images/icons/emoji/unicode/1f353.png ":strawberry:"). For a full list of available emoji and codes, see "[Emoji cheat sheet](https://github.com/ikatyang/emoji-cheat-sheet)."
    @jsondata:Name {value: "new_name"}
    string newName?;
};

# User-defined metadata to store domain-specific information limited to 8 keys with scalar values
public type RepositoryRuleRulesetInfo record {
    # The type of source for the ruleset that includes this rule.
    "Repository"|"Organization" ruleset_source_type?;
    # The name of the source of the ruleset that includes this rule.
    string ruleset_source?;
    # The ID of the ruleset that includes this rule.
    int ruleset_id?;
};

public type FileCommitCommitTree record {
    # The SHA of the tree object.
    string sha?;
    # API URL for the tree object.
    string url?;
};

# Represents the Queries record for the operation: repos/get-all-environments
public type ReposGetAllEnvironmentsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type ColumnIdCardsBody ProjectscolumnscolumnIdcardsOneOf1|ProjectscolumnscolumnIdcardsprojectscolumnscolumnIdcardsOneOf12;

public type ReposownerrepoissuesissueNumberlabelsLabels record {
    # The name of the label to add to the issue.
    string name;
};

public type OrgHooksBody record {
    # Must be passed as "web"
    string name;
    # Determines if notifications are sent when the webhook is triggered. Set to true to send notifications
    boolean active = true;
    # Configuration settings for the webhook, including URL and content type.
    OrgsorghooksConfig config;
    # Determines what [events](https://docs.github.com/webhooks/event-payloads) the hook is triggered for. Set to ["*"] to receive all possible events
    string[] events = ["push"];
};

public type PullNumberCommentsBody record {
    # The relative path to the file that necessitates a comment
    string path;
    # In a split diff view, the side of the diff that the pull request's changes appear on. Can be LEFT or RIGHT. Use LEFT for deletions that appear in red. Use RIGHT for additions that appear in green or unchanged lines that appear in white and are shown for context. For a multi-line comment, side represents whether the last line of the comment range is a deletion or addition. For more information, see "[Diff view options](https://docs.github.com/articles/about-comparing-branches-in-pull-requests#diff-view-options)" in the GitHub Help documentation
    "LEFT"|"RIGHT" side?;
    # The level at which the comment is targeted
    @jsondata:Name {value: "subject_type"}
    "line"|"file" subjectType?;
    # **Required unless using subject_type:file**. The line of the blob in the pull request diff that the comment applies to. For a multi-line comment, the last line of the range that your comment applies to
    int line?;
    # **Required when using multi-line comments unless using in_reply_to**. The start_line is the first line in the pull request diff that your multi-line comment applies to. To learn more about multi-line comments, see "[Commenting on a pull request](https://docs.github.com/articles/commenting-on-a-pull-request#adding-line-comments-to-a-pull-request)" in the GitHub Help documentation
    @jsondata:Name {value: "start_line"}
    int startLine?;
    # **This parameter is deprecated. Use line instead**. The position in the diff where you want to add a review comment. Note this value is not the same as the line number in the file. For help finding the position value, read the note above
    # 
    # # Deprecated
    @deprecated
    int position?;
    # The text of the review comment
    string body;
    # The SHA of the commit needing a comment. Not using the latest commit SHA may render your comment outdated if a subsequent commit modifies the line you specify as the position
    @jsondata:Name {value: "commit_id"}
    string commitId;
    # **Required when using multi-line comments unless using in_reply_to**. The start_side is the starting side of the diff that the comment applies to. Can be LEFT or RIGHT. To learn more about multi-line comments, see "[Commenting on a pull request](https://docs.github.com/articles/commenting-on-a-pull-request#adding-line-comments-to-a-pull-request)" in the GitHub Help documentation. See side in this table for additional context
    @jsondata:Name {value: "start_side"}
    "LEFT"|"RIGHT"|"side" startSide?;
    # The ID of the review comment to reply to. To find the ID of a review comment with ["List review comments on a pull request"](#list-review-comments-on-a-pull-request). When specified, all parameters other than body in the request body are ignored
    @jsondata:Name {value: "in_reply_to"}
    int inReplyTo?;
};

# Issue Event Rename
public type IssueEventRename record {
    # The previous name of the issue before renaming.
    string 'from;
    # The new name of the issue after renaming.
    string to;
};

# Represents the Queries record for the operation: teams/list-discussion-comments-in-org
public type TeamsListDiscussionCommentsInOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

public type IssueLabels LabelsOneOf12|LabelsLabelsOneOf122;

public type RepoTransferBody record {
    # The username or organization name the repository will be transferred to
    @jsondata:Name {value: "new_owner"}
    string newOwner;
    # ID of the team or teams to add to the repository. Teams can only be added to organization-owned repositories
    @jsondata:Name {value: "team_ids"}
    int[] teamIds?;
    # The new name to be given to the repository
    @jsondata:Name {value: "new_name"}
    string newName?;
};

public type FileCommitCommitVerification record {
    # The reason for the verification status of the commit signature.
    string reason?;
    # The GPG signature of the commit.
    string? signature?;
    # The signed payload used to verify the commit signature.
    string? payload?;
    # Whether the commit signature was successfully verified.
    boolean verified?;
};

public type ReposownerrepocheckSuitespreferencesAutoTriggerChecks record {
    # The id of the GitHub App
    @jsondata:Name {value: "app_id"}
    int appId;
    # Set to true to enable automatic creation of CheckSuite events upon pushes to the repository, or false to disable them
    boolean setting = true;
};

# Repository invitations let you manage who you collaborate with
public type RepositoryInvitation record {
    # Whether or not the invitation has expired
    boolean expired?;
    # The permission associated with the invitation
    "read"|"write"|"admin"|"triage"|"maintain" permissions;
    # URL of the repository invitation page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The date and time the invitation was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The user who sent the repository invitation.
    NullableSimpleUser? inviter;
    # Unique identifier of the repository invitation
    int id;
    # The repository to which the user is invited.
    MinimalRepository repository;
    # URL for the repository invitation
    string url;
    # The user who received the repository invitation.
    NullableSimpleUser? invitee;
    # The GraphQL node identifier of the invitation.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Issue Event Project Card
public type IssueEventProjectCard record {
    # The unique identifier of the project containing the card.
    @jsondata:Name {value: "project_id"}
    int projectId;
    # The name of the project column containing the card.
    @jsondata:Name {value: "column_name"}
    string columnName;
    # API URL for the project associated with the card.
    @jsondata:Name {value: "project_url"}
    string projectUrl;
    # The unique identifier of the project card.
    int id;
    # The name of the column the card was moved from.
    @jsondata:Name {value: "previous_column_name"}
    string previousColumnName?;
    # API URL for the project card.
    string url;
};

# Represents the Queries record for the operation: checks/list-annotations
public type ChecksListAnnotationsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: search/commits
public type SearchCommitsQueries record {
    # The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching commits](https://docs.github.com/search-github/searching-on-github/searching-commits)" for a detailed list of qualifiers
    string q;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Sorts the results of your query by author-date or committer-date. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    "author-date"|"committer-date" sort?;
    # Page number of the results to fetch
    int page = 1;
    # Determines whether the first search result returned is the highest number of matches (desc) or lowest number of matches (asc). This parameter is ignored unless you provide sort
    "desc"|"asc" 'order = "desc";
};

# Request to install an integration on a target
public type IntegrationInstallationRequest record {
    # The user who requested the integration installation.
    SimpleUser requester;
    # The date and time the installation request was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Unique identifier of the request installation
    int id;
    # The target account for the integration installation request.
    SimpleUser|Enterprise account;
    # The GraphQL node identifier of the installation request.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

public type RepoCodespacesBody record {
    # The geographic area for this codespace. If not specified, the value is assigned by IP. This property replaces location, which is being deprecated
    "EuropeWest"|"SoutheastAsia"|"UsEast"|"UsWest" geo?;
    # Path to devcontainer.json config to use for this codespace
    @jsondata:Name {value: "devcontainer_path"}
    string devcontainerPath?;
    # Git ref (typically a branch name) for this codespace
    string ref?;
    # Whether to authorize requested permissions from devcontainer.json
    @jsondata:Name {value: "multi_repo_permissions_opt_out"}
    boolean multiRepoPermissionsOptOut?;
    # Machine type to use for this codespace
    string machine?;
    # The requested location for a new codespace. Best efforts are made to respect this upon creation. Assigned by IP if not provided
    string location?;
    # IP for location auto-detection when proxying a request
    @jsondata:Name {value: "client_ip"}
    string clientIp?;
    # Working directory for this codespace
    @jsondata:Name {value: "working_directory"}
    string workingDirectory?;
    # Duration in minutes after codespace has gone idle in which it will be deleted. Must be integer minutes between 0 and 43200 (30 days)
    @jsondata:Name {value: "retention_period_minutes"}
    int retentionPeriodMinutes?;
    # Display name for this codespace
    @jsondata:Name {value: "display_name"}
    string displayName?;
    # Time in minutes before codespace stops from inactivity
    @jsondata:Name {value: "idle_timeout_minutes"}
    int idleTimeoutMinutes?;
};

public type ContainerMetadata record {
    # The list of tags associated with the container package.
    string[] tags;
};

# Demilestoned Issue Event
public type DemilestonedIssueEvent record {
    # The user who triggered the demilestone event.
    SimpleUser actor;
    # API URL for the commit associated with the event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The GitHub App that performed the demilestone event.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The milestone that was removed from the issue.
    MilestonedIssueEventMilestone milestone;
    # The date and time the event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the event.
    int id;
    # The type of event that occurred.
    string event;
    # The SHA of the commit associated with the event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # API URL for the event.
    string url;
    # The GraphQL node identifier of the event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Commit Search Result Item
public type CommitSearchResultItemResponse record {
    # The total number of commits matching the search query.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # Whether the search results are incomplete due to a timeout.
    @jsondata:Name {value: "incomplete_results"}
    boolean incompleteResults;
    # The list of commit search result items.
    CommitSearchResultItem[] items;
};

public type ReposownerrepoenvironmentsenvironmentNameReviewers record {
    # The id of the user or team who can review the deployment
    int id?;
    # The type of reviewer, either a user or a team.
    DeploymentReviewerType 'type?;
};

# Represents the Queries record for the operation: packages/list-packages-for-organization
public type PackagesListPackagesForOrganizationQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The selected visibility of the packages.  This parameter is optional and only filters an existing result set.
    # 
    # The internal visibility is only supported for GitHub Packages registries that allow for granular permissions. For other ecosystems internal is synonymous with private.
    # For the list of GitHub Packages registries that support granular permissions, see "[About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages#granular-permissions-for-userorganization-scoped-packages)."
    "public"|"private"|"internal" visibility?;
    # Page number of the results to fetch
    int page = 1;
    # The type of supported package. Packages in GitHub's Gradle registry have the type maven. Docker images pushed to GitHub's Container registry (ghcr.io) have the type container. You can use the type docker to find images that were pushed to GitHub's Docker registry (docker.pkg.github.com), even if these have now been migrated to the Container registry
    @http:Query {name: "package_type"}
    "npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType;
};

public type CodeScanningSarifsReceipt record {
    # The identifier for the uploaded SARIF analysis.
    CodeScanningAnalysisSarifId id?;
    # The REST API URL for checking the status of the upload
    string url?;
};

# The time that the alert was no longer detected and was considered fixed in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
public type AlertFixedAt string?;

public type UseremailsuseremailsOneOf12 string[];

# Branch Restriction Policy
public type BranchRestrictionPolicy record {
    # API URL for the teams allowed to push to the branch.
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    # The list of teams allowed to push to the restricted branch.
    BranchRestrictionPolicyTeams[] teams;
    # API URL for the users allowed to push to the branch.
    @jsondata:Name {value: "users_url"}
    string usersUrl;
    # API URL for the branch restriction policy.
    string url;
    # API URL for the apps allowed to push to the branch.
    @jsondata:Name {value: "apps_url"}
    string appsUrl;
    # The list of users allowed to push to the restricted branch.
    RepositoryTemplateRepositoryOwner[] users;
    # The list of apps allowed to push to the restricted branch.
    BranchRestrictionPolicyApps[] apps;
};

# Details for the advisory pertaining to the Common Vulnerability Scoring System
public type DependabotAlertSecurityAdvisoryCvss record {|
    # The overall CVSS score of the advisory
    @constraint:Number {minValue: 0, maxValue: 10}
    decimal score;
    # The full CVSS vector string for the advisory
    @jsondata:Name {value: "vector_string"}
    string? vectorString;
|};

# License Simple
public type LicenseSimple record {
    # URL of the license page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The full name of the license.
    string name;
    # The SPDX identifier for the license.
    @jsondata:Name {value: "spdx_id"}
    string? spdxId;
    # The unique key identifier for the license.
    string 'key;
    # API URL for the license.
    string? url;
    # The GraphQL node identifier of the license.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents the Queries record for the operation: apps/list-installation-repos-for-authenticated-user
public type AppsListInstallationReposForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Private User
public type PrivateUser record {
    # API URL template for the user's gists
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    # API URL to list the user's repositories
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    # Whether the user has two-factor authentication enabled
    @jsondata:Name {value: "two_factor_authentication"}
    boolean twoFactorAuthentication;
    # API URL template to check who the user is following
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    # The Twitter username of the user
    @jsondata:Name {value: "twitter_username"}
    string? twitterUsername?;
    # The biography of the user
    string? bio;
    # The date the user account was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The username of the user
    string login;
    # The type of the account
    string 'type;
    # The URL of the user's blog or website
    string? blog;
    # The number of private gists the user owns
    @jsondata:Name {value: "private_gists"}
    int privateGists;
    # The total number of private repositories the user owns
    @jsondata:Name {value: "total_private_repos"}
    int totalPrivateRepos;
    # API URL to list repositories the user is watching
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    # The date the user account was last updated
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Whether the user is a GitHub site administrator
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    # The total disk usage across all repositories in kilobytes
    @jsondata:Name {value: "disk_usage"}
    int diskUsage;
    # The number of collaborators across the user's private repositories
    int collaborators;
    # The company the user belongs to
    string? company;
    # The number of private repositories owned by the user
    @jsondata:Name {value: "owned_private_repos"}
    int ownedPrivateRepos;
    # The unique identifier of the user
    int id;
    # The number of public repositories the user owns
    @jsondata:Name {value: "public_repos"}
    int publicRepos;
    # The Gravatar ID of the user
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    # The GitHub subscription plan associated with the user's account.
    PublicUserPlan plan?;
    # The publicly visible email address of the user
    string? email;
    # API URL to list the user's organizations
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
    # Whether the user is available for hire
    boolean? hireable;
    # API URL template for repositories the user has starred
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    # API URL to list the user's followers
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    # The number of public gists the user owns
    @jsondata:Name {value: "public_gists"}
    int publicGists;
    # API URL for the user
    string url;
    # API URL for events received by the user
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    # The LDAP distinguished name for the user
    @jsondata:Name {value: "ldap_dn"}
    string ldapDn?;
    # The number of followers the user has
    int followers;
    # URL of the user's avatar image
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # API URL template for the user's events
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # Whether the user has a GitHub Business Plus plan
    @jsondata:Name {value: "business_plus"}
    boolean businessPlus?;
    # URL of the user's GitHub profile page
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The number of users the user is following
    int following;
    # The display name of the user
    string? name;
    # The geographic location of the user
    string? location;
    # The GraphQL node identifier of the user
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The date the user account was suspended
    @jsondata:Name {value: "suspended_at"}
    string? suspendedAt?;
};

# The time that the analysis was created in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
public type CodeScanningAnalysisCreatedAt string;

# Thread
public type NotificationThread record {
    # The reason the user is receiving the notification.
    string reason;
    # The date and time the notification was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Whether the notification has been read.
    boolean unread;
    # The subject of the notification thread.
    NotificationThreadSubject subject;
    # API URL for managing the thread subscription.
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    # The unique identifier of the notification thread.
    string id;
    # The repository associated with the notification thread.
    MinimalRepository repository;
    # The date and time the thread was last marked as read.
    @jsondata:Name {value: "last_read_at"}
    string? lastReadAt;
    # API URL for the notification thread.
    string url;
};

public type HovercardContexts record {
    # The context message displayed in the hovercard.
    string message;
    # The octicon icon name used for the hovercard context.
    string octicon;
};

# Represents the Queries record for the operation: classroom/list-classrooms
public type ClassroomListClassroomsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# A GitHub Classroom accepted assignment
public type ClassroomAcceptedAssignment record {
    # Count of student commits
    @jsondata:Name {value: "commit_count"}
    int commitCount;
    # Whether an accepted assignment has been submitted
    boolean submitted;
    # The classroom assignment associated with this accepted assignment.
    SimpleClassroomAssignment assignment;
    # Most recent grade
    string grade;
    # The list of students who accepted the assignment.
    SimpleClassroomUser[] students;
    # Unique identifier of the repository
    int id;
    # Whether a submission passed
    boolean passing;
    # The repository created for the accepted assignment.
    SimpleClassroomRepository repository;
};

# GitHub Actions Cache Usage by repository
public type ActionsCacheUsageByRepository record {
    # The repository owner and name for the cache usage being shown
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The number of active caches in the repository
    @jsondata:Name {value: "active_caches_count"}
    int activeCachesCount;
    # The sum of the size in bytes of all the active cache items in the repository
    @jsondata:Name {value: "active_caches_size_in_bytes"}
    int activeCachesSizeInBytes;
};

# Represents the Queries record for the operation: orgs/list
public type OrgsListQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # An organization ID. Only return organizations with an ID greater than this ID
    int since?;
};

# Represents the Queries record for the operation: apps/list-installation-requests-for-authenticated-app
public type AppsListInstallationRequestsForAuthenticatedAppQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Use the status property to enable or disable secret scanning for this repository. For more information, see "[About secret scanning](/code-security/secret-security/about-secret-scanning)."
public type ReposownerrepoSecurityAndAnalysisSecretScanning record {
    # Can be enabled or disabled
    string status?;
};

# Pull Request Simple
public type PullRequestSimple record {
    # API URL for the associated issue
    @jsondata:Name {value: "issue_url"}
    string issueUrl;
    # Hypermedia links related to the pull request.
    @jsondata:Name {value: "_links"}
    PullRequestLinks links;
    # URL of the pull request diff
    @jsondata:Name {value: "diff_url"}
    string diffUrl;
    # The date the pull request was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The users assigned to the pull request
    SimpleUser[]? assignees?;
    # The users requested to review the pull request
    @jsondata:Name {value: "requested_reviewers"}
    SimpleUser[]? requestedReviewers?;
    # The title of the pull request
    string title;
    # The body text of the pull request
    string? body;
    # The teams requested to review the pull request
    @jsondata:Name {value: "requested_teams"}
    Team[]? requestedTeams?;
    # The head branch details of the pull request.
    PullRequestSimpleHead head;
    # The association of the author with the repository
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # The pull request number
    int number;
    # URL of the pull request patch
    @jsondata:Name {value: "patch_url"}
    string patchUrl;
    # The date the pull request was last updated
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Indicates whether or not the pull request is a draft
    boolean draft?;
    # API URL for the pull request comments
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # The SHA of the merge commit
    @jsondata:Name {value: "merge_commit_sha"}
    string? mergeCommitSha;
    # API URL template for a pull request review comment
    @jsondata:Name {value: "review_comment_url"}
    string reviewCommentUrl;
    # The reason the pull request conversation was locked
    @jsondata:Name {value: "active_lock_reason"}
    string? activeLockReason?;
    # The unique identifier of the pull request
    int id;
    # The state of the pull request
    string state;
    # Whether the pull request is locked
    boolean locked;
    # API URL for the pull request commits
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    # The date the pull request was closed
    @jsondata:Name {value: "closed_at"}
    string? closedAt;
    # API URL for the pull request commit statuses
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    # The date the pull request was merged
    @jsondata:Name {value: "merged_at"}
    string? mergedAt;
    # The auto-merge configuration for the pull request
    @jsondata:Name {value: "auto_merge"}
    AutoMerge? autoMerge;
    # API URL for the pull request
    string url;
    # The labels associated with the pull request
    PullRequestLabels[] labels;
    # The milestone associated with the pull request.
    NullableMilestone? milestone;
    # URL of the pull request page on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # API URL for the pull request review comments
    @jsondata:Name {value: "review_comments_url"}
    string reviewCommentsUrl;
    # The primary user assigned to the pull request.
    NullableSimpleUser? assignee;
    # The user who created the pull request.
    NullableSimpleUser? user;
    # The GraphQL node identifier of the pull request
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The base branch details of the pull request.
    PullRequestSimpleBase base;
};

# An optional comment when closing an alert. Cannot be updated or deleted. Must be null when changing state to open
public type SecretScanningAlertResolutionComment string?;

public type WorkflowRunUsageBillableUBUNTU record {
    # The list of individual job run billing details for Ubuntu runners.
    @jsondata:Name {value: "job_runs"}
    WorkflowRunUsageBillableUBUNTUJobRuns[] jobRuns?;
    # The total billable time in milliseconds for Ubuntu runners.
    @jsondata:Name {value: "total_ms"}
    int totalMs;
    # The total number of jobs run on Ubuntu runners.
    int jobs;
};

public type PullRequestMinimalHead record {
    # The name of the head branch.
    string ref;
    # The repository containing the head branch.
    PullRequestMinimalHeadRepo repo;
    # The SHA of the head commit.
    string sha;
};

public type RepositoryAdvisorySubmission record {
    # Whether a private vulnerability report was accepted by the repository's administrators
    boolean accepted;
};

# The public key used for setting Codespaces secrets
public type CodespacesPublicKey record {
    # The identifier for the key
    @jsondata:Name {value: "key_id"}
    string keyId;
    # The date and time the public key was created.
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    # The unique numeric identifier for the public key.
    int id?;
    # The title or label associated with the public key.
    string title?;
    # The Base64 encoded public key
    string 'key;
    # The API URL for the public key resource.
    string url?;
};

public type PendingDeploymentReviewers record {
    # The user or team assigned to review the pending deployment.
    SimpleUser|Team reviewer?;
    # The type of reviewer, either a user or team.
    DeploymentReviewerType 'type?;
};

# Represents the Queries record for the operation: search/issues-and-pull-requests
public type SearchIssuesAndPullRequestsQueries record {
    # The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching issues and pull requests](https://docs.github.com/search-github/searching-on-github/searching-issues-and-pull-requests)" for a detailed list of qualifiers
    string q;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Sorts the results of your query by the number of comments, reactions, reactions-+1, reactions--1, reactions-smile, reactions-thinking_face, reactions-heart, reactions-tada, or interactions. You can also sort results by how recently the items were created or updated, Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    "comments"|"reactions"|"reactions-+1"|"reactions--1"|"reactions-smile"|"reactions-thinking_face"|"reactions-heart"|"reactions-tada"|"interactions"|"created"|"updated" sort?;
    # Page number of the results to fetch
    int page = 1;
    # Determines whether the first search result returned is the highest number of matches (desc) or lowest number of matches (asc). This parameter is ignored unless you provide sort
    "desc"|"asc" 'order = "desc";
};

# Represents the Queries record for the operation: apps/list-accounts-for-plan-stubbed
public type AppsListAccountsForPlanStubbedQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The property to sort the results by
    "created"|"updated" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # To return the oldest accounts first, set to asc. Ignored without the sort parameter
    "asc"|"desc" direction?;
};

public type CommentIdReactionsBody2 record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the pull request review comment
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

public type BranchRestrictionPolicyApps record {
    # The owner of the GitHub App.
    BranchRestrictionPolicyOwner owner?;
    # The external URL associated with the GitHub App.
    @jsondata:Name {value: "external_url"}
    string externalUrl?;
    # The date and time the app was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    # The permissions granted to the GitHub App.
    BranchRestrictionPolicyPermissions permissions?;
    # The HTML URL for the GitHub App's page.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The name of the GitHub App.
    string name?;
    # A short description of the GitHub App.
    string description?;
    # The date and time the app was created.
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    # The unique numeric identifier for the GitHub App.
    int id?;
    # The URL-friendly name of the GitHub App.
    string slug?;
    # The list of events the GitHub App subscribes to.
    string[] events?;
    # The GraphQL node ID for the GitHub App.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# Represents the Queries record for the operation: apps/list-subscriptions-for-authenticated-user-stubbed
public type AppsListSubscriptionsForAuthenticatedUserStubbedQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type WorkflowIdDispatchesBody record {
    # The git reference for the workflow. The reference can be a branch or tag name
    string ref;
    # Input keys and values configured in the workflow file. The maximum number of properties is 10. Any default properties configured in the workflow file will be used when inputs are omitted
    record {} inputs?;
};

# Represents the Queries record for the operation: actions/list-self-hosted-runners-for-repo
public type ActionsListSelfHostedRunnersForRepoQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The name of a self-hosted runner
    string name?;
    # Page number of the results to fetch
    int page = 1;
};

# A commit
public type NullableSimpleCommit record {
    # The user who committed the changes to the repository.
    SimpleCommitCommitter? committer;
    # SHA for the commit's tree
    @jsondata:Name {value: "tree_id"}
    string treeId;
    # The user who authored the commit.
    SimpleCommitAuthor? author;
    # SHA for the commit
    string id;
    # Message describing the purpose of the commit
    string message;
    # Timestamp of the commit
    string timestamp;
};

public type ProjectscolumnscolumnIdcardsprojectscolumnscolumnIdcardsOneOf12 record {
    # The piece of content associated with the card
    @jsondata:Name {value: "content_type"}
    string contentType;
    # The unique identifier of the content associated with the card
    @jsondata:Name {value: "content_id"}
    int contentId;
};

# Represents the Queries record for the operation: actions/delete-actions-cache-by-key
public type ActionsDeleteActionsCacheByKeyQueries record {
    # The full Git reference for narrowing down the cache. The ref for a branch should be formatted as refs/heads/<branch name>. To reference a pull request use refs/pull/<number>/merge
    string ref?;
    # A key for identifying the cache
    string 'key;
};

# Sets the state of the code scanning alert. You must provide dismissed_reason when you set the state to dismissed
public type CodeScanningAlertSetState "open"|"dismissed";

public type CodeScanningAnalysis record {
    # Indicates whether this analysis can be deleted.
    boolean deletable;
    # The date and time the analysis was created.
    @jsondata:Name {value: "created_at"}
    CodeScanningAnalysisCreatedAt createdAt;
    # The total number of rules used in the analysis
    @jsondata:Name {value: "rules_count"}
    int rulesCount;
    # The unique key identifying the analysis configuration.
    @jsondata:Name {value: "analysis_key"}
    CodeScanningAnalysisAnalysisKey analysisKey;
    # Any error message generated during the analysis.
    string 'error;
    # The API URL for this code scanning analysis.
    CodeScanningAnalysisUrl url;
    # The code scanning tool used to perform the analysis.
    CodeScanningAnalysisTool tool;
    # The Git reference associated with the analysis.
    CodeScanningRef ref;
    # The SHA of the commit the analysis was performed on.
    @jsondata:Name {value: "commit_sha"}
    CodeScanningAnalysisCommitSha commitSha;
    # The environment variables used in the analysis.
    CodeScanningAnalysisEnvironment environment;
    # The total number of results in the analysis
    @jsondata:Name {value: "results_count"}
    int resultsCount;
    # Warning generated when processing the analysis
    string warning;
    # The SARIF ID associated with the uploaded analysis file.
    @jsondata:Name {value: "sarif_id"}
    CodeScanningAnalysisSarifId sarifId;
    # Unique identifier for this analysis
    int id;
    # The category grouping for this analysis.
    CodeScanningAnalysisCategory category?;
};

public type RepositoryTemplateRepositoryOwner record {
    # The API URL template for the owner's gists.
    @jsondata:Name {value: "gists_url"}
    string gistsUrl?;
    # The API URL for the owner's repositories.
    @jsondata:Name {value: "repos_url"}
    string reposUrl?;
    # The API URL template for users this owner follows.
    @jsondata:Name {value: "following_url"}
    string followingUrl?;
    # The API URL template for the owner's starred repositories.
    @jsondata:Name {value: "starred_url"}
    string starredUrl?;
    # The username of the repository owner.
    string login?;
    # The API URL for the owner's followers.
    @jsondata:Name {value: "followers_url"}
    string followersUrl?;
    # The type of account, either User or Organization.
    string 'type?;
    # The API URL for the owner's account.
    string url?;
    # The API URL for the owner's subscriptions.
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl?;
    # The API URL for events received by the owner.
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl?;
    # The URL of the owner's avatar image.
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl?;
    # The API URL template for the owner's events.
    @jsondata:Name {value: "events_url"}
    string eventsUrl?;
    # The HTML URL for the owner's GitHub profile.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # Indicates whether the owner is a GitHub site administrator.
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin?;
    # The unique numeric identifier for the owner.
    int id?;
    # The Gravatar ID associated with the owner's email.
    @jsondata:Name {value: "gravatar_id"}
    string gravatarId?;
    # The GraphQL node ID for the owner.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
    # The API URL for the owner's organizations.
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl?;
};

# Represents the Queries record for the operation: secret-scanning/list-alerts-for-enterprise
public type SecretScanningListAlertsForEnterpriseQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # A comma-separated list of secret types to return. By default all secret types are returned.
    # See "[Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns#supported-secrets-for-advanced-security)"
    # for a complete list of secret types
    @http:Query {name: "secret_type"}
    string secretType?;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor
    string before?;
    # Set to open or resolved to only list secret scanning alerts in a specific state
    "open"|"resolved" state?;
    # The property to sort the results by. created means when the alert was created. updated means when the alert was updated or resolved
    "created"|"updated" sort = "created";
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor
    string after?;
    # A comma-separated list of resolutions. Only secret scanning alerts with one of these resolutions are listed. Valid resolutions are false_positive, wont_fix, revoked, pattern_edited, pattern_deleted or used_in_tests
    string resolution?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# A codespace
public type CodespaceResponse record {
    # The total number of codespaces returned.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of codespaces for the user or organization.
    Codespace[] codespaces;
};

# Secrets for GitHub Dependabot for an organization
public type OrganizationDependabotSecret record {
    # The date and time the secret was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Visibility of a secret
    "all"|"private"|"selected" visibility;
    # The name of the secret
    string name;
    # The API URL to list repositories with access to this secret.
    @jsondata:Name {value: "selected_repositories_url"}
    string selectedRepositoriesUrl?;
    # The date and time the secret was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
};

# An object with information about the individual creating the tag
public type ReposownerrepogittagsTagger record {
    # When this object was tagged. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string date?;
    # The name of the author of the tag
    string name;
    # The email of the author of the tag
    string email;
};

public type JobSteps record {
    # The outcome of the job
    string? conclusion;
    # The sequential step number within the job.
    int number;
    # The time that the job finished, in ISO 8601 format
    @jsondata:Name {value: "completed_at"}
    string? completedAt?;
    # The name of the job
    string name;
    # The time that the step started, in ISO 8601 format
    @jsondata:Name {value: "started_at"}
    string? startedAt?;
    # The phase of the lifecycle that the job is currently in
    "queued"|"in_progress"|"completed" status;
};

public type Verification record {
    # The reason for the verification status of the commit.
    string reason;
    # The signed payload used to verify the commit signature.
    string? payload;
    # The cryptographic signature used to verify the commit.
    string? signature;
    # Indicates whether the commit signature was verified by GitHub.
    boolean verified;
};

# Restrict who can push to the protected branch. User, app, and team restrictions are only available for organization-owned repositories. Set to null to disable
public type ReposownerrepobranchesbranchprotectionRestrictions record {
    # The list of team slugs with push access
    string[] teams;
    # The list of user logins with push access
    string[] users;
    # The list of app slugs with push access
    string[] apps?;
};

# Review Request Removed Issue Event
public type ReviewRequestRemovedIssueEvent record {
    # The user who triggered the review request removal event.
    SimpleUser actor;
    # The URL of the commit associated with the event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The team whose review request was removed.
    @jsondata:Name {value: "requested_team"}
    Team requestedTeam?;
    # The GitHub App that performed this event, if applicable.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The user who originally requested the review.
    @jsondata:Name {value: "review_requester"}
    SimpleUser reviewRequester;
    # The date and time the event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The user whose review request was removed.
    @jsondata:Name {value: "requested_reviewer"}
    SimpleUser requestedReviewer?;
    # The unique numeric identifier for the event.
    int id;
    # The type of issue event that occurred.
    string event;
    # The SHA of the commit associated with this event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # The API URL for this issue event.
    string url;
    # The GraphQL node ID for the event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# An artifact
public type Artifact record {
    # The URL to download the artifact as a zip archive.
    @jsondata:Name {value: "archive_download_url"}
    string archiveDownloadUrl;
    # Whether or not the artifact has expired
    boolean expired;
    # The date and time when the artifact expires.
    @jsondata:Name {value: "expires_at"}
    string? expiresAt;
    # The workflow run associated with this artifact.
    @jsondata:Name {value: "workflow_run"}
    ArtifactWorkflowRun? workflowRun?;
    # The date and time the artifact was last updated.
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    # The name of the artifact
    string name;
    # The size in bytes of the artifact
    @jsondata:Name {value: "size_in_bytes"}
    int sizeInBytes;
    # The date and time the artifact was created.
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    # The unique numeric identifier for the artifact.
    int id;
    # The API URL for this artifact.
    string url;
    # The GraphQL node ID for the artifact.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type AffectsOneOf1 string;

# Authentication token for a GitHub App installed on a user or org
public type InstallationToken record {
    # Indicates whether the token applies to all or selected repositories.
    @jsondata:Name {value: "repository_selection"}
    "all"|"selected" repositorySelection?;
    # The path of the single file the token has access to.
    @jsondata:Name {value: "single_file"}
    string singleFile?;
    # The date and time when the installation token expires.
    @jsondata:Name {value: "expires_at"}
    string expiresAt;
    # The list of repositories the token has access to.
    Repository[] repositories?;
    # The permissions granted to the installation token.
    AppPermissions permissions?;
    # Indicates whether the token grants access to multiple single files.
    @jsondata:Name {value: "has_multiple_single_files"}
    boolean hasMultipleSingleFiles?;
    # The list of file paths the token has single-file access to.
    @jsondata:Name {value: "single_file_paths"}
    string[] singleFilePaths?;
    # The authentication token string for the installation.
    string token;
};

# The API URL to use to get or set the actions and reusable workflows that are allowed to run, when allowed_actions is set to selected
public type SelectedActionsUrl string;

# Hypermedia links for the pull request
public type PullRequestLinks record {
    # Hypermedia link to the pull request's comments.
    Link comments;
    # Hypermedia link to the issue associated with the pull request.
    Link issue;
    # Hypermedia link to the pull request's commits.
    Link commits;
    # Hypermedia link to the pull request's commit statuses.
    Link statuses;
    # Hypermedia link to the pull request's review comments.
    @jsondata:Name {value: "review_comments"}
    Link reviewComments;
    # Hypermedia link to the pull request itself.
    Link self;
    # Hypermedia link to the pull request's HTML page.
    Link html;
    # Hypermedia link to a single review comment resource.
    @jsondata:Name {value: "review_comment"}
    Link reviewComment;
};

public type RepositoryRulesetConditionsRepositoryIdTargetRepositoryId record {
    # The repository IDs that the ruleset applies to. One of these IDs must match for the condition to pass
    @jsondata:Name {value: "repository_ids"}
    int[] repositoryIds?;
};

# Describe a region within a file for the alert
public type CodeScanningAlertLocation record {
    # The file path where the alert was detected.
    string path?;
    # The column number where the alert region begins.
    @jsondata:Name {value: "start_column"}
    int startColumn?;
    # The line number where the alert region begins.
    @jsondata:Name {value: "start_line"}
    int startLine?;
    # The line number where the alert region ends.
    @jsondata:Name {value: "end_line"}
    int endLine?;
    # The column number where the alert region ends.
    @jsondata:Name {value: "end_column"}
    int endColumn?;
};

public type CodeScanningSarifsBody record {
    # The name of the tool used to generate the code scanning analysis. If this parameter is not used, the tool name defaults to "API". If the uploaded SARIF contains a tool GUID, this will be available for filtering using the tool_guid parameter of operations such as GET /repos/{owner}/{repo}/code-scanning/alerts
    @jsondata:Name {value: "tool_name"}
    string toolName?;
    # The SHA of the commit the SARIF analysis was performed on.
    @jsondata:Name {value: "commit_sha"}
    CodeScanningAnalysisCommitSha commitSha;
    # The Git reference associated with the uploaded SARIF analysis.
    CodeScanningRef ref;
    # The SARIF data containing the code scanning analysis results.
    CodeScanningAnalysisSarifFile sarif;
    # The base directory used in the analysis, as it appears in the SARIF file.
    # This property is used to convert file paths from absolute to relative, so that alerts can be mapped to their correct location in the repository
    @jsondata:Name {value: "checkout_uri"}
    string checkoutUri?;
    # The time that the analysis run began. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "started_at"}
    string startedAt?;
    # Whether the SARIF file will be validated according to the code scanning specifications.
    # This parameter is intended to help integrators ensure that the uploaded SARIF files are correctly rendered by code scanning
    boolean validate?;
};

# Represents the Queries record for the operation: repos/get-commit
public type ReposGetCommitQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type DeploymentIdStatusesBody record {
    # Name for the target deployment environment, which can be changed when setting a deploy status. For example, production, staging, or qa. If not defined, the environment of the previous status on the deployment will be used, if it exists. Otherwise, the environment of the deployment will be used
    string environment?;
    # Sets the URL for accessing your environment. Default: ""
    @jsondata:Name {value: "environment_url"}
    string environmentUrl = "";
    # The target URL to associate with this status. This URL should contain output to keep the user updated while the task is running or serve as historical information for what happened in the deployment. **Note:** It's recommended to use the log_url parameter, which replaces target_url
    @jsondata:Name {value: "target_url"}
    string targetUrl = "";
    # The full URL of the deployment's output. This parameter replaces target_url. We will continue to accept target_url to support legacy uses, but we recommend replacing target_url with log_url. Setting log_url will automatically set target_url to the same value. Default: ""
    @jsondata:Name {value: "log_url"}
    string logUrl = "";
    # Adds a new inactive status to all prior non-transient, non-production environment deployments with the same repository and environment name as the created status's deployment. An inactive status is only added to deployments that had a success state. Default: true
    @jsondata:Name {value: "auto_inactive"}
    boolean autoInactive?;
    # A short description of the status. The maximum description length is 140 characters
    string description = "";
    # The state of the status. When you set a transient deployment to inactive, the deployment will be shown as destroyed in GitHub
    "error"|"failure"|"inactive"|"in_progress"|"queued"|"pending"|"success" state;
};

public type CommentIdReactionsBody1 record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the issue comment
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

public type ClientIdTokenBody record {
    # The access_token of the OAuth or GitHub application
    @jsondata:Name {value: "access_token"}
    string accessToken;
};

public type CheckSuitePreferencePreferences record {
    # The list of auto-trigger check settings per GitHub App.
    @jsondata:Name {value: "auto_trigger_checks"}
    CheckSuitePreferencePreferencesAutoTriggerChecks[] autoTriggerChecks?;
};

# Represents the Queries record for the operation: users/list-following-for-user
public type UsersListFollowingForUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type RepositoryRuleBranchNamePatternParameters record {
    # If true, the rule will fail if the pattern matches
    boolean negate?;
    # How this rule will appear to users
    string name?;
    # The pattern to match with
    string pattern;
    # The operator to use for matching
    "starts_with"|"ends_with"|"contains"|"regex" operator;
};

# Identifies the variable values associated with the environment in which the analysis that generated this alert instance was performed, such as the language that was analyzed
public type CodeScanningAlertEnvironment string;

public type OrgPersonalAccessTokensBody record {
    # The IDs of the fine-grained personal access tokens
    @jsondata:Name {value: "pat_ids"}
    int[] patIds;
    # Action to apply to the fine-grained personal access token
    "revoke" action;
};

# The permissions the authenticated user has on the repository
public type FullRepositoryPermissions record {
    # Indicates whether the user has pull (read) permission.
    boolean pull;
    # Indicates whether the user has maintain permission on the repository.
    boolean maintain?;
    # Indicates whether the user has admin permission on the repository.
    boolean admin;
    # Indicates whether the user has triage permission on the repository.
    boolean triage?;
    # Indicates whether the user has push (write) permission.
    boolean push;
};

public type HookResponse record {
    # The HTTP response code from the webhook delivery.
    int? code;
    # The response message from the webhook delivery.
    string? message;
    # The response status string from the webhook delivery.
    string? status;
};

# Delivery made by a webhook, without request and response information
public type HookDeliveryItem record {
    # Time spent delivering
    decimal duration;
    # Status code received when delivery was made
    @jsondata:Name {value: "status_code"}
    int statusCode;
    # Unique identifier for the event (shared with all deliveries for all webhooks that subscribe to this event)
    string guid;
    # The type of activity for the event that triggered the delivery
    string? action;
    # The id of the GitHub App installation associated with this event
    @jsondata:Name {value: "installation_id"}
    int? installationId;
    # The id of the repository associated with this event
    @jsondata:Name {value: "repository_id"}
    int? repositoryId;
    # Unique identifier of the webhook delivery
    int id;
    # The event that triggered the delivery
    string event;
    # Time when the webhook delivery occurred
    @jsondata:Name {value: "delivered_at"}
    string deliveredAt;
    # Whether the webhook delivery is a redelivery
    boolean redelivery;
    # Describes the response returned after attempting the delivery
    string status;
};

# Represents the Queries record for the operation: teams/list-pending-invitations-in-org
public type TeamsListPendingInvitationsInOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type ActionsVariablesBody1 record {
    # The name of the variable
    string name;
    # The value of the variable
    string value;
};

# Represents the Queries record for the operation: activity/list-notifications-for-authenticated-user
public type ActivityListNotificationsForAuthenticatedUserQueries record {
    # If true, show notifications marked as read
    boolean all = false;
    # The number of results per page (max 50)
    @http:Query {name: "per_page"}
    int perPage = 50;
    # Only show notifications updated before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string before?;
    # If true, only shows notifications in which the user is directly participating or mentioned
    boolean participating = false;
    # Page number of the results to fetch
    int page = 1;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

# Represents the Queries record for the operation: reactions/list-for-team-discussion-comment-in-org
public type ReactionsListForTeamDiscussionCommentInOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to a team discussion comment
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content?;
};

# Represents the Queries record for the operation: repos/get-branch-rules
public type ReposGetBranchRulesQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type BillingSelectedUsersBody1 record {
    # The usernames of the organization members for which to revoke access to GitHub Copilot
    @jsondata:Name {value: "selected_usernames"}
    string[] selectedUsernames;
};

# The permissions policy that controls the actions and reusable workflows that are allowed to run
public type AllowedActions "all"|"local_only"|"selected";

public type ProtectedBranchEnforceAdmins record {|
    # The API URL for the enforce admins branch protection setting.
    string url;
    # Indicates whether admin enforcement is enabled for the branch.
    boolean enabled;
|};

# Represents the Queries record for the operation: users/list-emails-for-authenticated-user
public type UsersListEmailsForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Information of a job execution in a workflow run
public type Job record {
    # The ID of the runner to which this job has been assigned. (If a runner hasn't yet been assigned, this will be null.)
    @jsondata:Name {value: "runner_id"}
    int? runnerId;
    # The id of the associated workflow run
    @jsondata:Name {value: "run_id"}
    int runId;
    # The name of the workflow
    @jsondata:Name {value: "workflow_name"}
    string? workflowName;
    # The name of the current branch
    @jsondata:Name {value: "head_branch"}
    string? headBranch;
    # The name of the runner to which this job has been assigned. (If a runner hasn't yet been assigned, this will be null.)
    @jsondata:Name {value: "runner_name"}
    string? runnerName;
    # The name of the runner group to which this job has been assigned. (If a runner hasn't yet been assigned, this will be null.)
    @jsondata:Name {value: "runner_group_name"}
    string? runnerGroupName;
    # The time that the job created, in ISO 8601 format
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Steps in this job
    JobSteps[] steps?;
    # The SHA of the commit that is being run
    @jsondata:Name {value: "head_sha"}
    string headSha;
    # The API URL for this workflow job.
    string url;
    # The API URL for the check run associated with this job.
    @jsondata:Name {value: "check_run_url"}
    string checkRunUrl;
    # Labels for the workflow job. Specified by the "runs_on" attribute in the action's workflow file
    string[] labels;
    # The outcome of the job
    "success"|"failure"|"neutral"|"cancelled"|"skipped"|"timed_out"|"action_required"? conclusion;
    # The time that the job finished, in ISO 8601 format
    @jsondata:Name {value: "completed_at"}
    string? completedAt;
    # The API URL for the workflow run associated with this job.
    @jsondata:Name {value: "run_url"}
    string runUrl;
    # The HTML URL for viewing this job on GitHub.
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    # The name of the job
    string name;
    # Attempt number of the associated workflow run, 1 for first attempt and higher if the workflow was re-run
    @jsondata:Name {value: "run_attempt"}
    int runAttempt?;
    # The time that the job started, in ISO 8601 format
    @jsondata:Name {value: "started_at"}
    string startedAt;
    # The id of the job
    int id;
    # The ID of the runner group to which this job has been assigned. (If a runner hasn't yet been assigned, this will be null.)
    @jsondata:Name {value: "runner_group_id"}
    int? runnerGroupId;
    # The GraphQL node ID for the job.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The phase of the lifecycle that the job is currently in
    "queued"|"in_progress"|"completed" status;
};

# Branch Protection
public type BranchProtection record {
    # The pull request review requirements for the protected branch.
    @jsondata:Name {value: "required_pull_request_reviews"}
    ProtectedBranchPullRequestReview requiredPullRequestReviews?;
    # The commit signature requirements for the protected branch.
    @jsondata:Name {value: "required_signatures"}
    ProtectedBranchRequiredSignatures requiredSignatures?;
    # The required status checks that must pass before merging.
    @jsondata:Name {value: "required_status_checks"}
    ProtectedBranchRequiredStatusCheck requiredStatusChecks?;
    # Indicates whether forked repositories can be synced with this branch.
    @jsondata:Name {value: "allow_fork_syncing"}
    BranchProtectionAllowForkSyncing allowForkSyncing?;
    # The user, team, and app restrictions for pushing to the branch.
    BranchRestrictionPolicy restrictions?;
    # Indicates whether a linear commit history is required.
    @jsondata:Name {value: "required_linear_history"}
    BranchProtectionRequiredLinearHistory requiredLinearHistory?;
    # Indicates whether branch protections are enforced for administrators.
    @jsondata:Name {value: "enforce_admins"}
    ProtectedBranchAdminEnforced enforceAdmins?;
    # The API URL for this branch protection configuration.
    string url?;
    # Indicates whether branch protection is enabled.
    boolean enabled?;
    # Indicates whether force pushes are permitted to the branch.
    @jsondata:Name {value: "allow_force_pushes"}
    BranchProtectionRequiredLinearHistory allowForcePushes?;
    # Indicates whether the branch is locked against changes.
    @jsondata:Name {value: "lock_branch"}
    BranchProtectionLockBranch lockBranch?;
    # Indicates whether branch creations matching this rule are blocked.
    @jsondata:Name {value: "block_creations"}
    BranchProtectionRequiredLinearHistory blockCreations?;
    # Indicates whether all conversations must be resolved before merging.
    @jsondata:Name {value: "required_conversation_resolution"}
    BranchProtectionRequiredLinearHistory requiredConversationResolution?;
    # The name of the protected branch.
    string name?;
    # Indicates whether the branch can be deleted.
    @jsondata:Name {value: "allow_deletions"}
    BranchProtectionRequiredLinearHistory allowDeletions?;
    # The API URL for the branch protection resource.
    @jsondata:Name {value: "protection_url"}
    string protectionUrl?;
};

# Represents the Queries record for the operation: search/topics
public type SearchTopicsQueries record {
    # The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query)
    string q;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type GistSimpleFiles record {
    # The name of the file in the gist.
    string filename?;
    # The size of the file in bytes.
    int size?;
    # Indicates whether the file content is truncated.
    boolean truncated?;
    # The detected programming language of the file.
    string language?;
    # The MIME type of the file.
    string 'type?;
    # The URL to access the raw file content.
    @jsondata:Name {value: "raw_url"}
    string rawUrl?;
    # The text content of the gist file.
    string content?;
};

# The tree object referenced by the commit
public type GitCommitTree record {
    # SHA for the commit
    string sha;
    # The API URL for the tree object referenced by the commit.
    string url;
};

# The person that committed the file. Default: the authenticated user
public type ReposownerrepocontentspathCommitter record {
    # The date and time of the commit in ISO 8601 format.
    string date?;
    # The name of the author or committer of the commit. You'll receive a 422 status code if name is omitted
    string name;
    # The email of the author or committer of the commit. You'll receive a 422 status code if email is omitted
    string email;
};

# Commit Activity
public type CommitActivity record {
    # The total number of commits in the week.
    int total;
    # The Unix timestamp representing the start of the week.
    int week;
    # The number of commits per day of the week, Sunday through Saturday.
    int[] days;
};

# Blob
public type Blob record {
    # The size of the blob content in bytes.
    int? size;
    # The encoding used for the blob content, such as base64 or utf-8.
    string encoding;
    # The SHA hash of the blob object.
    string sha;
    # The syntax-highlighted HTML content of the blob.
    @jsondata:Name {value: "highlighted_content"}
    string highlightedContent?;
    # The encoded content of the blob.
    string content;
    # The API URL for this blob object.
    string url;
    # The GraphQL node ID for the blob.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Timeline Unassigned Issue Event
public type TimelineUnassignedIssueEvent record {
    # The user who performed the unassign action.
    SimpleUser actor;
    # The URL of the commit associated with the event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The GitHub App that performed this event, if applicable.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The date and time the event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique numeric identifier for the event.
    int id;
    # The user who was unassigned from the issue.
    SimpleUser assignee;
    # The type of timeline event that occurred.
    string event;
    # The SHA of the commit associated with this event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # The API URL for this timeline event.
    string url;
    # The GraphQL node ID for the event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type PendingDeploymentEnvironment record {
    # The HTML URL of the environment on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The name of the environment
    string name?;
    # The id of the environment
    int id?;
    # The API URL of the environment.
    string url?;
    # The GraphQL node identifier of the environment.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# Set repository secrets for GitHub Codespaces
public type RepoCodespacesSecret record {
    # The date and time the secret was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The name of the secret
    string name;
    # The date and time the secret was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
};

# Secrets for a GitHub Codespace
public type CodespacesSecretResponse record {
    # The total number of Codespaces secrets available.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # List of secrets for the GitHub Codespace.
    CodespacesSecret[] secrets;
};

public type ContentspathBody1 record {
    # The person who committed the file deletion.
    ReposownerrepocontentspathCommitter1 committer?;
    # The author of the file deletion commit.
    ReposownerrepocontentspathAuthor1 author?;
    # The commit message
    string message;
    # The blob SHA of the file being deleted
    string sha;
    # The branch name. Default: the repository’s default branch
    string branch?;
};

public type RepoHooksBody record {|
    # Use web to create a webhook. Default: web. This parameter only accepts the value web
    string name?;
    # Determines if notifications are sent when the webhook is triggered. Set to true to send notifications
    boolean active = true;
    # Configuration object defining the webhook URL, content type, and secret.
    ReposownerrepohooksConfig config?;
    # Determines what [events](https://docs.github.com/webhooks/event-payloads) the hook is triggered for
    string[] events = ["push"];
|};

# Represents the Queries record for the operation: repos/get-all-topics
public type ReposGetAllTopicsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# A GitHub App that is providing a custom deployment protection rule
public type CustomDeploymentRuleAppResponse record {
    # List of available custom deployment protection rule integrations for this environment.
    @jsondata:Name {value: "available_custom_deployment_protection_rule_integrations"}
    CustomDeploymentRuleApp[] availableCustomDeploymentProtectionRuleIntegrations?;
    # The total number of custom deployment protection rule integrations available for this environment
    @jsondata:Name {value: "total_count"}
    int totalCount?;
};

# The set of permissions for the GitHub app
public type IntegrationPermissions record {|
    # Permission level granted for issues.
    string issues?;
    # Permission level granted for check runs and check suites.
    string checks?;
    # Permission level granted for repository metadata.
    string metadata?;
    # Permission level granted for repository contents.
    string contents?;
    # Permission level granted for deployments.
    string deployments?;
    string...;
|};

# Represents the Queries record for the operation: issues/list-comments-for-repo
public type IssuesListCommentsForRepoQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The property to sort the results by
    "created"|"updated" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # Either asc or desc. Ignored without the sort parameter
    "asc"|"desc" direction?;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

# The public key used for setting Actions Secrets
public type ActionsPublicKey record {
    # The identifier for the key
    @jsondata:Name {value: "key_id"}
    string keyId;
    # The date and time the public key was created.
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    # The unique identifier of the public key.
    int id?;
    # A descriptive title for the public key.
    string title?;
    # The Base64 encoded public key
    string 'key;
    # The API URL for the public key.
    string url?;
};

public type ReposownerrepobranchesbranchprotectionrestrictionsappsOneOf1 record {
    # The GitHub Apps that have push access to this branch. Use the slugified version of the app name. **Note**: The list of users, apps, and teams in total is limited to 100 items
    string[] apps;
};

# Represents the Queries record for the operation: reactions/list-for-pull-request-review-comment
public type ReactionsListForPullRequestReviewCommentQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to a pull request review comment
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content?;
};

# Org Membership
public type OrgMembership record {
    # The API URL of the organization.
    @jsondata:Name {value: "organization_url"}
    string organizationUrl;
    # The user's membership type in the organization
    "admin"|"member"|"billing_manager" role;
    # The permissions the user has within the organization.
    OrgMembershipPermissions permissions?;
    # The organization the membership belongs to.
    OrganizationSimple organization;
    # The state of the member in the organization. The pending state indicates the user has not yet accepted an invitation
    "active"|"pending" state;
    # The user associated with this membership.
    NullableSimpleUser? user;
    # The API URL for this membership.
    string url;
};

public type OrgsorgBody1 record {
    # The state that the membership should be in. Only "active" will be accepted
    "active" state;
};

public type TeamSlugDiscussionsBody record {
    # Private posts are only visible to team members, organization owners, and team maintainers. Public posts are visible to all members of the organization. Set to true to create a private post
    boolean 'private = false;
    # The discussion post's title
    string title;
    # The discussion post's body text
    string body;
};

# Workflow Run Usage
public type WorkflowRunUsage record {
    # The total duration of the workflow run in milliseconds.
    @jsondata:Name {value: "run_duration_ms"}
    int runDurationMs?;
    # Billable usage breakdown by operating system for the workflow run.
    WorkflowRunUsageBillable billable;
};

# Represents the Queries record for the operation: users/list-social-accounts-for-authenticated-user
public type UsersListSocialAccountsForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: pulls/list-reviews
public type PullsListReviewsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Details for the vulnerable dependency
public type DependabotAlertWithRepositoryDependency record {
    # The package associated with the vulnerable dependency.
    DependabotAlertPackage package?;
    # The full path to the dependency manifest file, relative to the root of the repository
    @jsondata:Name {value: "manifest_path"}
    string manifestPath?;
    # The execution scope of the vulnerable dependency
    "development"|"runtime"? scope?;
};

public type ActionsBillingUsageMinutesUsedBreakdown record {
    # Total minutes used on Windows 4 core runner machines
    @jsondata:Name {value: "windows_4_core"}
    int windows4Core?;
    # Total minutes used on Ubuntu 64 core runner machines
    @jsondata:Name {value: "ubuntu_64_core"}
    int ubuntu64Core?;
    # Total minutes used on macOS runner machines
    @jsondata:Name {value: "MACOS"}
    int mACOS?;
    # Total minutes used on macOS 12 core runner machines
    @jsondata:Name {value: "macos_12_core"}
    int macos12Core?;
    # Total minutes used on Ubuntu runner machines
    @jsondata:Name {value: "UBUNTU"}
    int uBUNTU?;
    # Total minutes used on Ubuntu 8 core runner machines
    @jsondata:Name {value: "ubuntu_8_core"}
    int ubuntu8Core?;
    # Total minutes used on all runner machines
    int total?;
    # Total minutes used on Windows 64 core runner machines
    @jsondata:Name {value: "windows_64_core"}
    int windows64Core?;
    # Total minutes used on Ubuntu 32 core runner machines
    @jsondata:Name {value: "ubuntu_32_core"}
    int ubuntu32Core?;
    # Total minutes used on Windows runner machines
    @jsondata:Name {value: "WINDOWS"}
    int wINDOWS?;
    # Total minutes used on Ubuntu 16 core runner machines
    @jsondata:Name {value: "ubuntu_16_core"}
    int ubuntu16Core?;
    # Total minutes used on Windows 32 core runner machines
    @jsondata:Name {value: "windows_32_core"}
    int windows32Core?;
    # Total minutes used on Ubuntu 4 core runner machines
    @jsondata:Name {value: "ubuntu_4_core"}
    int ubuntu4Core?;
    # Total minutes used on Windows 8 core runner machines
    @jsondata:Name {value: "windows_8_core"}
    int windows8Core?;
    # Total minutes used on Windows 16 core runner machines
    @jsondata:Name {value: "windows_16_core"}
    int windows16Core?;
};

# The name of the status checks
public type ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsreposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf122 string[];

# The version of the tool used to generate the code scanning analysis
public type CodeScanningAnalysisToolVersion string?;

public type DependencyGraphDiffInner record {
    # The license associated with the dependency.
    string? license;
    # The package ecosystem of the dependency.
    string ecosystem;
    # The package URL (PURL) identifying the dependency.
    @jsondata:Name {value: "package_url"}
    string? packageUrl;
    # The path to the manifest file containing the dependency.
    string manifest;
    # Where the dependency is utilized. development means that the dependency is only utilized in the development environment. runtime means that the dependency is utilized at runtime and in the development environment
    "unknown"|"runtime"|"development" scope;
    # The name of the dependency package.
    string name;
    # List of known vulnerabilities associated with this dependency.
    DependencyGraphDiffInnerVulnerabilities[] vulnerabilities;
    # Whether the dependency was added or removed in the diff.
    @jsondata:Name {value: "change_type"}
    "added"|"removed" changeType;
    # The URL of the source repository for the dependency.
    @jsondata:Name {value: "source_repository_url"}
    string? sourceRepositoryUrl;
    # The version of the dependency.
    string version;
};

public type UserBody record {
    # The new hiring availability of the user
    boolean hireable?;
    # The new name of the user
    string name?;
    # The new Twitter username of the user
    @jsondata:Name {value: "twitter_username"}
    string? twitterUsername?;
    # The new short biography of the user
    string bio?;
    # The new company of the user
    string company?;
    # The new location of the user
    string location?;
    # The new blog URL of the user
    string blog?;
    # The publicly visible email address of the user
    string email?;
};

# A release
public type Release record {
    # The HTML-rendered description of the release
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    # The plain text description of the release
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    # The name of the tag
    @jsondata:Name {value: "tag_name"}
    string tagName;
    # The user who authored the release.
    SimpleUser author;
    # The date the release was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The number of mentions found in the release body
    @jsondata:Name {value: "mentions_count"}
    int mentionsCount?;
    # The description body of the release
    string? body?;
    # API URL for the release
    string url;
    # API URL for the release assets
    @jsondata:Name {value: "assets_url"}
    string assetsUrl;
    # The list of assets attached to the release
    ReleaseAsset[] assets;
    # Whether to identify the release as a prerelease or a full release
    boolean prerelease;
    # URL of the release page on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # URL to download the release source as a zip file
    @jsondata:Name {value: "zipball_url"}
    string? zipballUrl;
    # Specifies the commitish value that determines where the Git tag is created from
    @jsondata:Name {value: "target_commitish"}
    string targetCommitish;
    # true to create a draft (unpublished) release, false to create a published one
    boolean draft;
    # The name of the release
    string? name;
    # URL template for uploading release assets
    @jsondata:Name {value: "upload_url"}
    string uploadUrl;
    # Reaction counts for the release.
    ReactionRollup reactions?;
    # The unique identifier of the release
    int id;
    # URL to download the release source as a tarball
    @jsondata:Name {value: "tarball_url"}
    string? tarballUrl;
    # The date the release was published
    @jsondata:Name {value: "published_at"}
    string? publishedAt;
    # The GraphQL node identifier of the release
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The URL of the release discussion
    @jsondata:Name {value: "discussion_url"}
    string discussionUrl?;
};

# The hierarchy between files in a Git repository
public type GitTree record {
    # Objects specifying a tree structure
    GitTreeTree[] tree;
    # Indicates whether the tree was truncated due to size limits.
    boolean truncated;
    # The SHA1 hash of the Git tree object.
    string sha;
    # The API URL for this Git tree.
    string url;
};

public type ProjectscolumnscolumnIdcardsOneOf1 record {
    # The project card's note
    string? note;
};

public type StatusesshaBody record {
    # The target URL to associate with this status. This URL will be linked from the GitHub UI to allow users to easily see the source of the status.  
    # For example, if your continuous integration system is posting build status, you would want to provide the deep link for the build output for this specific SHA:  
    # http://ci.example.com/user/repo/build/sha
    @jsondata:Name {value: "target_url"}
    string? targetUrl?;
    # A string label to differentiate this status from the status of other systems. This field is case-insensitive
    string context = "default";
    # A short description of the status
    string? description?;
    # The state of the status
    "error"|"failure"|"pending"|"success" state;
};

public type FileCommitCommitAuthor record {
    # The date and time the author made the commit.
    string date?;
    # The name of the commit author.
    string name?;
    # The email address of the commit author.
    string email?;
};

# Identifying information for the git-user
public type GitCommitCommitter record {
    # Timestamp of the commit
    string date;
    # Name of the git user
    string name;
    # Git email address of the user
    string email;
};

# The enforcement level of the ruleset. evaluate allows admins to test rules before enforcing them. Admins can view insights on the Rule Insights page (evaluate is only available with GitHub Enterprise)
public type RepositoryRuleEnforcement "disabled"|"active"|"evaluate";

# Represents the Queries record for the operation: codespaces/list-repo-secrets
public type CodespacesListRepoSecretsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: reactions/list-for-issue-comment
public type ReactionsListForIssueCommentQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to an issue comment
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content?;
};

# Represents the Queries record for the operation: repos/get-combined-status-for-ref
public type ReposGetCombinedStatusForRefQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type CommitSearchResultItemParents record {
    # The HTML URL of the parent commit on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The SHA hash of the parent commit.
    string sha?;
    # The API URL of the parent commit.
    string url?;
};

# An autolink reference
public type Autolink record {
    # The prefix of a key that is linkified
    @jsondata:Name {value: "key_prefix"}
    string keyPrefix;
    # A template for the target URL that is generated if a key was found
    @jsondata:Name {value: "url_template"}
    string urlTemplate;
    # The unique identifier of the autolink reference.
    int id;
    # Whether this autolink reference matches alphanumeric characters. If false, this autolink reference only matches numeric characters
    @jsondata:Name {value: "is_alphanumeric"}
    boolean isAlphanumeric;
};

# Issue Event Label
public type IssueEventLabel record {
    # The hex color code of the label.
    string? color;
    # The name of the label.
    string? name;
};

public type GitTreesBody record {
    # The SHA1 of an existing Git tree object which will be used as the base for the new tree. If provided, a new Git tree object will be created from entries in the Git tree object pointed to by base_tree and entries defined in the tree parameter. Entries defined in the tree parameter will overwrite items from base_tree with the same path. If you're creating new changes on a branch, then normally you'd set base_tree to the SHA1 of the Git tree object of the current latest commit on the branch you're working on.
    # If not provided, GitHub will create a new Git tree object from only the entries defined in the tree parameter. If you create a new commit pointing to such a tree, then all files which were a part of the parent commit's tree and were not defined in the tree parameter will be listed as deleted by the new commit
    @jsondata:Name {value: "base_tree"}
    string baseTree?;
    # Objects (of path, mode, type, and sha) specifying a tree structure
    ReposownerrepogittreesTree[] tree;
};

public type CodeScanningAnalysisTool record {
    # The name of the code scanning analysis tool.
    CodeScanningAnalysisToolName name?;
    # The globally unique identifier of the code scanning tool.
    CodeScanningAnalysisToolGuid? guid?;
    # The version of the code scanning analysis tool.
    CodeScanningAnalysisToolVersion? version?;
};

# A check performed on the code of a given code change
public type CheckRun record {
    # The GitHub App that created this check run.
    NullableIntegration? app;
    # A reference identifier for the check run provided by the app.
    @jsondata:Name {value: "external_id"}
    string? externalId;
    # The URL where details about the check run are displayed.
    @jsondata:Name {value: "details_url"}
    string? detailsUrl;
    # The SHA of the commit that is being checked
    @jsondata:Name {value: "head_sha"}
    string headSha;
    # The API URL for this check run.
    string url;
    # The final conclusion result of the completed check run.
    "success"|"failure"|"neutral"|"cancelled"|"skipped"|"timed_out"|"action_required"? conclusion;
    # The output summary and annotations for this check run.
    CheckRunOutput output;
    # The date and time the check run completed.
    @jsondata:Name {value: "completed_at"}
    string? completedAt;
    # Pull requests that are open with a head_sha or head_branch that matches the check. The returned pull requests do not necessarily indicate pull requests that triggered the check
    @jsondata:Name {value: "pull_requests"}
    PullRequestMinimal[] pullRequests;
    # The HTML URL of the check run on GitHub.
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    # The name of the check
    string name;
    # The date and time the check run started.
    @jsondata:Name {value: "started_at"}
    string? startedAt;
    # The id of the check
    int id;
    # The check suite this check run belongs to.
    @jsondata:Name {value: "check_suite"}
    CheckRunCheckSuite? checkSuite;
    # The GraphQL node identifier of the check run.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The phase of the lifecycle that the check is currently in
    "queued"|"in_progress"|"completed" status;
    # The deployment associated with this check run.
    DeploymentSimple deployment?;
};

# Porter Large File
public type PorterLargeFile record {
    # The Git reference name associated with the large file.
    @jsondata:Name {value: "ref_name"}
    string refName;
    # The file path of the large file in the repository.
    string path;
    # The size of the large file in bytes.
    int size;
    # The Git object identifier (OID) of the large file.
    string oid;
};

# Represents the Queries record for the operation: teams/list-discussion-comments-legacy
public type TeamsListDiscussionCommentsLegacyQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# Represents the Queries record for the operation: activity/list-public-org-events
public type ActivityListPublicOrgEventsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type SecretScanningLocation record {
    # Location details specific to the type where the secret was found.
    SecretScanningLocationCommit|SecretScanningLocationIssueTitle|SecretScanningLocationIssueBody|SecretScanningLocationIssueComment details;
    # The location type. Because secrets may be found in different types of resources (ie. code, comments, issues), this field identifies the type of resource where the secret was found
    "commit"|"issue_title"|"issue_body"|"issue_comment" 'type;
};

# Represents the Queries record for the operation: dependency-graph/diff-range
public type DependencyGraphDiffRangeQueries record {
    # The full path, relative to the repository root, of the dependency manifest file
    string name?;
};

public type CodeScanningAlertItems record {
    # The API URL to list all instances of this alert.
    @jsondata:Name {value: "instances_url"}
    AlertInstancesUrl instancesUrl;
    # The date and time the alert was created.
    @jsondata:Name {value: "created_at"}
    AlertCreatedAt createdAt;
    # Optional comment provided when the alert was dismissed.
    @jsondata:Name {value: "dismissed_comment"}
    CodeScanningAlertDismissedComment? dismissedComment?;
    # The code scanning rule that triggered this alert.
    CodeScanningAlertRuleSummary rule;
    # The API URL for this code scanning alert.
    AlertUrl url;
    # The code scanning tool that generated this alert.
    CodeScanningAnalysisTool tool;
    # The unique number identifying this alert within the repository.
    AlertNumber number;
    # The date and time the alert was last updated.
    @jsondata:Name {value: "updated_at"}
    AlertUpdatedAt updatedAt?;
    # The HTML URL of the alert on GitHub.
    @jsondata:Name {value: "html_url"}
    AlertHtmlUrl htmlUrl;
    # The date and time the alert was fixed.
    @jsondata:Name {value: "fixed_at"}
    AlertFixedAt? fixedAt?;
    # The most recent instance of this alert.
    @jsondata:Name {value: "most_recent_instance"}
    CodeScanningAlertInstance mostRecentInstance;
    # The current state of the code scanning alert.
    CodeScanningAlertState state;
    # The user who dismissed this alert.
    @jsondata:Name {value: "dismissed_by"}
    NullableSimpleUser? dismissedBy;
    # The reason provided when the alert was dismissed.
    @jsondata:Name {value: "dismissed_reason"}
    CodeScanningAlertDismissedReason? dismissedReason;
    # The date and time the alert was dismissed.
    @jsondata:Name {value: "dismissed_at"}
    AlertDismissedAt? dismissedAt;
};

public type LabelsLabelsOneOf122 record {
    # Indicates whether this is a default label for the repository.
    boolean default?;
    # The hex color code of the label.
    string? color?;
    # The name of the label.
    string name?;
    # A brief description of the label.
    string? description?;
    # The unique identifier of the label.
    int id?;
    # The API URL of the label.
    string url?;
    # The GraphQL node identifier of the label.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# The permissions the authenticated user has on the repository
public type MinimalRepositoryPermissions record {
    # Indicates whether the user has pull (read) permission.
    boolean pull?;
    # Indicates whether the user has maintain permission.
    boolean maintain?;
    # Indicates whether the user has admin permission.
    boolean admin?;
    # Indicates whether the user has triage permission.
    boolean triage?;
    # Indicates whether the user has push (write) permission.
    boolean push?;
};

# Configuration for code scanning default setup
public type CodeScanningDefaultSetupUpdate record {
    # CodeQL query suite to be used
    @jsondata:Name {value: "query_suite"}
    "default"|"extended" querySuite?;
    # CodeQL languages to be analyzed
    ("c-cpp"|"csharp"|"go"|"java-kotlin"|"javascript-typescript"|"python"|"ruby"|"swift")[] languages?;
    # Whether code scanning default setup has been configured or not
    "configured"|"not-configured" state;
};

# Project columns contain cards of work
public type ProjectColumn record {
    # The date and time the project column was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The API URL to list cards in this column.
    @jsondata:Name {value: "cards_url"}
    string cardsUrl;
    # Name of the project column
    string name;
    # The API URL of the project this column belongs to.
    @jsondata:Name {value: "project_url"}
    string projectUrl;
    # The date and time the project column was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the project column
    int id;
    # The API URL for this project column.
    string url;
    # The GraphQL node identifier of the project column.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type NullableCommunityHealthFile record {
    # The HTML URL of the community health file on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The API URL of the community health file.
    string url;
};

# Represents the Queries record for the operation: repos/list-for-org
public type ReposListForOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The property to sort the results by
    "created"|"updated"|"pushed"|"full_name" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # Specifies the types of repositories you want returned
    "all"|"public"|"private"|"forks"|"sources"|"member" 'type = "all";
    # The order to sort by. Default: asc when using full_name, otherwise desc
    "asc"|"desc" direction?;
};

public type ReleasesreleaseIdBody record {
    # If specified, a discussion of the specified category is created and linked to the release. The value must be a category that already exists in the repository. If there is already a discussion linked to the release, this parameter is ignored. For more information, see "[Managing categories for discussions in your repository](https://docs.github.com/discussions/managing-discussions-for-your-community/managing-categories-for-discussions-in-your-repository)."
    @jsondata:Name {value: "discussion_category_name"}
    string discussionCategoryName?;
    # Specifies whether this release should be set as the latest release for the repository. Drafts and prereleases cannot be set as latest. Defaults to true for newly published releases. legacy specifies that the latest release should be determined based on the release creation date and higher semantic version
    @jsondata:Name {value: "make_latest"}
    "true"|"false"|"legacy" makeLatest = "true";
    # The name of the tag
    @jsondata:Name {value: "tag_name"}
    string tagName?;
    # true to identify the release as a prerelease, false to identify the release as a full release
    boolean prerelease?;
    # Specifies the commitish value that determines where the Git tag is created from. Can be any branch or commit SHA. Unused if the Git tag already exists. Default: the repository's default branch
    @jsondata:Name {value: "target_commitish"}
    string targetCommitish?;
    # true makes the release a draft, and false publishes the release
    boolean draft?;
    # The name of the release
    string name?;
    # Text describing the contents of the tag
    string body?;
};

public type PackageVersionMetadata record {
    # Container-specific metadata for the package version.
    ContainerMetadata container?;
    # The type of package ecosystem for this version.
    @jsondata:Name {value: "package_type"}
    "npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType;
    # Docker-specific metadata for the package version.
    DockerMetadata docker?;
};

public type RepoReleasesBody record {
    # If specified, a discussion of the specified category is created and linked to the release. The value must be a category that already exists in the repository. For more information, see "[Managing categories for discussions in your repository](https://docs.github.com/discussions/managing-discussions-for-your-community/managing-categories-for-discussions-in-your-repository)."
    @jsondata:Name {value: "discussion_category_name"}
    string discussionCategoryName?;
    # Specifies whether this release should be set as the latest release for the repository. Drafts and prereleases cannot be set as latest. Defaults to true for newly published releases. legacy specifies that the latest release should be determined based on the release creation date and higher semantic version
    @jsondata:Name {value: "make_latest"}
    "true"|"false"|"legacy" makeLatest = "true";
    # The name of the tag
    @jsondata:Name {value: "tag_name"}
    string tagName;
    # true to identify the release as a prerelease. false to identify the release as a full release
    boolean prerelease = false;
    # Specifies the commitish value that determines where the Git tag is created from. Can be any branch or commit SHA. Unused if the Git tag already exists. Default: the repository's default branch
    @jsondata:Name {value: "target_commitish"}
    string targetCommitish?;
    # true to create a draft (unpublished) release, false to create a published one
    boolean draft = false;
    # The name of the release
    string name?;
    # Text describing the contents of the tag
    string body?;
    # Whether to automatically generate the name and body for this release. If name is specified, the specified name will be used; otherwise, a name will be automatically generated. If body is specified, the body will be pre-pended to the automatically generated notes
    @jsondata:Name {value: "generate_release_notes"}
    boolean generateReleaseNotes = false;
};

public type RepoPagesBody anydata;

public type CodeScanningSarifsStatus record {
    # pending files have not yet been processed, while complete means results from the SARIF have been stored. failed files have either not been processed at all, or could only be partially processed
    @jsondata:Name {value: "processing_status"}
    "pending"|"complete"|"failed" processingStatus?;
    # The REST API URL for getting the analyses associated with the upload
    @jsondata:Name {value: "analyses_url"}
    string? analysesUrl?;
    # Any errors that ocurred during processing of the delivery
    string[]? errors?;
};

public type ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf1123 record {
    # List of label names to apply to the issue.
    @constraint:Array {minLength: 1}
    ReposownerrepoissuesissueNumberlabelsLabels[] labels?;
};

public type DependencyGraphDiffInnerVulnerabilities record {
    # Severity level of the vulnerability (e.g., low, medium, high, critical).
    string severity;
    # URL to the GitHub Security Advisory for this vulnerability.
    @jsondata:Name {value: "advisory_url"}
    string advisoryUrl;
    # GitHub Security Advisory identifier for this vulnerability.
    @jsondata:Name {value: "advisory_ghsa_id"}
    string advisoryGhsaId;
    # Brief description summarizing the security advisory.
    @jsondata:Name {value: "advisory_summary"}
    string advisorySummary;
};

# A Base64 string representing the SARIF file to upload. You must first compress your SARIF file using [gzip](http://www.gnu.org/software/gzip/manual/gzip.html) and then translate the contents of the file into a Base64 encoding string. For more information, see "[SARIF support for code scanning](https://docs.github.com/code-security/secure-coding/sarif-support-for-code-scanning)."
public type CodeScanningAnalysisSarifFile string;

# An actor that can bypass rules in a ruleset
public type RepositoryRulesetBypassActor record {
    # The type of actor that can bypass a ruleset
    @jsondata:Name {value: "actor_type"}
    "RepositoryRole"|"Team"|"Integration"|"OrganizationAdmin" actorType;
    # When the specified actor can bypass the ruleset. pull_request means that an actor can only bypass rules on pull requests
    @jsondata:Name {value: "bypass_mode"}
    "always"|"pull_request" bypassMode;
    # The ID of the actor that can bypass a ruleset. If actor_type is OrganizationAdmin, this should be 1
    @jsondata:Name {value: "actor_id"}
    int actorId;
};

public type CodeownersErrorsErrors record {
    # The path of the file where the error occured
    string path;
    # The line number where this errors occurs
    int line;
    # The type of error
    string kind;
    # Suggested action to fix the error. This will usually be null, but is provided for some common errors
    string? suggestion?;
    # The column number where this errors occurs
    int column;
    # The contents of the line where the error occurs
    string 'source?;
    # A human-readable description of the error, combining information from multiple fields, laid out for display in a monospaced typeface (for example, a command-line setting)
    string message;
};

# Set secrets for GitHub Actions
public type ActionsSecret record {
    # The date and time the secret was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The name of the secret
    string name;
    # The date and time the secret was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
};

# Diff Entry
public type DiffEntry record {
    # The patch content showing the diff changes for the file.
    string patch?;
    # The path of the file in the repository.
    string filename;
    # The number of lines added in the file.
    int additions;
    # The number of lines deleted from the file.
    int deletions;
    # The total number of lines changed in the file.
    int changes;
    # The previous path of the file before renaming.
    @jsondata:Name {value: "previous_filename"}
    string previousFilename?;
    # The SHA hash identifying the file blob.
    string sha;
    # URL to the file blob on GitHub.
    @jsondata:Name {value: "blob_url"}
    string blobUrl;
    # URL to the raw file content.
    @jsondata:Name {value: "raw_url"}
    string rawUrl;
    # The change status of the file in the diff.
    "added"|"removed"|"modified"|"renamed"|"copied"|"changed"|"unchanged" status;
    # URL to retrieve the file contents via the API.
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
};

public type LabelsLabelsOneOf132 record {
    # Indicates whether this is a default label for the repository.
    boolean default?;
    # The hexadecimal color code for the label.
    string? color?;
    # The name of the label.
    string name?;
    # A short description of the label.
    string? description?;
    # The unique numeric identifier of the label.
    int id?;
    # The URL of the label resource.
    string url?;
    # The GraphQL node identifier for the label.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# Timeline Cross Referenced Event
public type TimelineCrossReferencedEvent record {
    # The user who created the cross-reference.
    SimpleUser actor?;
    # The date and time the cross-reference event was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The date and time the cross-reference event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The source issue or pull request that contains the cross-reference.
    TimelineCrossReferencedEventSource 'source;
    # The type of timeline event, indicating a cross-reference.
    string event;
};

public type CheckSuitesPreferencesBody record {
    # Enables or disables automatic creation of CheckSuite events upon pushes to the repository. Enabled by default
    @jsondata:Name {value: "auto_trigger_checks"}
    ReposownerrepocheckSuitespreferencesAutoTriggerChecks[] autoTriggerChecks?;
};

public type PullRequestLabels record {
    # Indicates whether this is a default label for the repository.
    boolean default;
    # The hexadecimal color code for the label.
    string color;
    # The name of the label.
    string name;
    # A short description of the label.
    string? description;
    # The unique numeric identifier of the label.
    int id;
    # The URL of the label resource.
    string url;
    # The GraphQL node identifier for the label.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type SearchResultTextMatchesInner record {
    # A text fragment from the object that contains the match.
    string fragment?;
    # The URL of the object where the match was found.
    @jsondata:Name {value: "object_url"}
    string objectUrl?;
    # The type of object that contains the search match.
    @jsondata:Name {value: "object_type"}
    string? objectType?;
    # The property name of the object where the match occurred.
    string property?;
    # A list of match details including indices and text.
    SearchResultTextMatchesInnerMatches[] matches?;
};

# Determines whether the SSL certificate of the host for url will be verified when delivering payloads. Supported values include 0 (verification is performed) and 1 (verification is not performed). The default is 0. **We strongly recommend not setting this to 1 as you are subject to man-in-the-middle and other attacks.**
public type WebhookConfigInsecureSslOneOf1 string;

public type ActionsVariableResponse record {
    # The list of Actions variables returned in the response.
    ActionsVariable[] variables;
    # The total number of Actions variables available.
    @jsondata:Name {value: "total_count"}
    int totalCount;
};

# Dev Containers
public type Devcontainers record {
    # The file path to the dev container configuration.
    string path;
    # The internal name identifier of the dev container.
    string name?;
    # The human-readable display name of the dev container.
    @jsondata:Name {value: "display_name"}
    string displayName?;
};

# Represents the Queries record for the operation: projects/list-collaborators
public type ProjectsListCollaboratorsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Filters the collaborators by their affiliation. outside means outside collaborators of a project that are not a member of the project's organization. direct means collaborators with permissions to a project, regardless of organization membership status. all means all collaborators the authenticated user can see
    "outside"|"direct"|"all" affiliation = "all";
    # Page number of the results to fetch
    int page = 1;
};

# Parameters to be used for the branch_name_pattern rule
public type RepositoryRuleBranchNamePattern record {
    # The rule type, identifying this as a branch name pattern rule.
    "branch_name_pattern" 'type;
    # The configuration parameters for the branch name pattern rule.
    RepositoryRuleBranchNamePatternParameters parameters?;
};

# Represents the Queries record for the operation: secret-scanning/list-alerts-for-repo
public type SecretScanningListAlertsForRepoQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # A comma-separated list of secret types to return. By default all secret types are returned.
    # See "[Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns#supported-secrets-for-advanced-security)"
    # for a complete list of secret types
    @http:Query {name: "secret_type"}
    string secretType?;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for events before this cursor. To receive an initial cursor on your first request, include an empty "before" query string
    string before?;
    # Set to open or resolved to only list secret scanning alerts in a specific state
    "open"|"resolved" state?;
    # The property to sort the results by. created means when the alert was created. updated means when the alert was updated or resolved
    "created"|"updated" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for events after this cursor.  To receive an initial cursor on your first request, include an empty "after" query string
    string after?;
    # A comma-separated list of resolutions. Only secret scanning alerts with one of these resolutions are listed. Valid resolutions are false_positive, wont_fix, revoked, pattern_edited, pattern_deleted or used_in_tests
    string resolution?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# Represents an 'issue_comment' secret scanning location type. This location type shows that a secret was detected in a comment on an issue
public type SecretScanningLocationIssueComment record {
    # The API URL to get the issue comment where the secret was detected
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
};

# Represents the Queries record for the operation: classroom/list-accepted-assigments-for-an-assignment
public type ClassroomListAcceptedAssigmentsForAnAssignmentQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type UserEmailsBody UseremailsOneOf1|UseremailsuseremailsOneOf12|UseremailsuseremailsuseremailsOneOf123;

public type GpgKeyEmails record {
    # Indicates whether the email address is verified for the GPG key.
    boolean verified?;
    # The email address associated with the GPG key.
    string email?;
};

public type UseremailsOneOf1 record {
    # Adds one or more email addresses to your GitHub account. Must contain at least one email address. **Note:** Alternatively, you can pass a single email address or an array of emails addresses directly, but we recommend that you pass an object using the emails key
    string[] emails;
};

# Hypermedia Link
public type Link record {
    # The URL of the hyperlink.
    string href;
};

public type CodespacesAccessBody record {
    # Which users can access codespaces in the organization. disabled means that no users can access codespaces in the organization
    "disabled"|"selected_members"|"all_members"|"all_members_and_outside_collaborators" visibility;
    # The usernames of the organization members who should have access to codespaces in the organization. Required when visibility is selected_members. The provided list of usernames will replace any existing value
    @jsondata:Name {value: "selected_usernames"}
    string[] selectedUsernames?;
};

public type CodeScanningAlertRuleSummary record {
    # The severity of the alert
    "none"|"note"|"warning"|"error"? severity?;
    # The name of the rule used to detect the alert
    string name?;
    # A short description of the rule used to detect the alert
    string description?;
    # A unique identifier for the rule used to detect the alert
    string? id?;
    # A set of tags applicable for the rule
    string[]? tags?;
};

# The type of reviewer
public type DeploymentReviewerType "User"|"Team";

public type ContentspathBody record {
    # The person that committed the file on behalf of the author.
    ReposownerrepocontentspathCommitter committer?;
    # The author of the file being created or updated.
    ReposownerrepocontentspathAuthor author?;
    # The commit message
    string message;
    # **Required if you are updating a file**. The blob SHA of the file being replaced
    string sha?;
    # The branch name. Default: the repository’s default branch
    string branch?;
    # The new file content, using Base64 encoding
    string content;
};

# Branch Short
public type BranchShort record {
    # Indicates whether the branch is protected.
    boolean protected;
    # The name of the branch.
    string name;
    # The latest commit on the branch.
    BranchShortCommit 'commit;
};

# A version of a software package
public type PackageVersion record {
    # The license associated with this package version.
    string license?;
    # Additional metadata specific to the package version's ecosystem.
    PackageVersionMetadata metadata?;
    # The date and time the package version was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The HTML URL for viewing the package version on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The name of the package version
    string name;
    # A brief description of the package version.
    string description?;
    # The date and time the package version was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Unique identifier of the package version
    int id;
    # The date and time the package version was deleted.
    @jsondata:Name {value: "deleted_at"}
    string deletedAt?;
    # The API URL for this package version.
    string url;
    # The HTML URL for the parent package on GitHub.
    @jsondata:Name {value: "package_html_url"}
    string packageHtmlUrl;
};

# Repo Search Result Item
public type RepoSearchResultItem record {
    # Indicates whether the repository can be forked.
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking?;
    # The number of users who have starred the repository.
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount;
    # Indicates whether the repository is a template repository.
    @jsondata:Name {value: "is_template"}
    boolean isTemplate?;
    # The date and time of the most recent push to the repository.
    @jsondata:Name {value: "pushed_at"}
    string pushedAt;
    # The primary programming language used in the repository.
    string? language;
    # API URL to manage the authenticated user's subscription to this repository.
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    # API URL template for accessing the repository's branches.
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    # API URL template for accessing comments on issues in the repository.
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    # Indicates whether rebase merging is allowed for pull requests.
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge?;
    # API URL template for accessing the repository's labels.
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # The search relevance score of this repository result.
    decimal score;
    # API URL for listing subscribers watching the repository.
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    # The permissions the authenticated user has on this repository.
    RepoSearchResultItemPermissions permissions?;
    # A temporary token used for cloning the repository.
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    # API URL template for accessing the repository's releases.
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    # The SVN URL for the repository.
    @jsondata:Name {value: "svn_url"}
    string svnUrl;
    # The unique numeric identifier of the repository.
    int id;
    # The name of the master branch of the repository.
    @jsondata:Name {value: "master_branch"}
    string masterBranch?;
    # Indicates whether the repository has discussions enabled.
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions?;
    # The number of forks of the repository.
    int forks;
    # API URL template for downloading an archive of the repository.
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    # Indicates whether merge commits are allowed for pull requests.
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit?;
    # API URL template for accessing the repository's Git refs.
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    # API URL for listing forks of the repository.
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The repository visibility: public, private, or internal
    string visibility?;
    # API URL template for accessing commit statuses in the repository.
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    # The SSH URL used to clone the repository.
    @jsondata:Name {value: "ssh_url"}
    string sshUrl;
    # The license associated with the repository.
    NullableLicenseSimple? license;
    # The full name of the repository, including the owner's login.
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The size of the repository in kilobytes.
    int size;
    # Indicates whether auto-merge is allowed for pull requests.
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge?;
    # API URL for listing the programming languages used in the repository.
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    # The HTML URL for viewing the repository on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # API URL template for accessing the repository's collaborators.
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    # The HTTPS URL used to clone the repository.
    @jsondata:Name {value: "clone_url"}
    string cloneUrl;
    # The name of the repository.
    string name;
    # API URL template for accessing the repository's pull requests.
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    # The name of the repository's default branch.
    @jsondata:Name {value: "default_branch"}
    string defaultBranch;
    # API URL for accessing the repository's webhooks.
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    # API URL template for accessing the repository's Git trees.
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    # API URL for listing the repository's tags.
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    # Indicates whether the repository is private.
    boolean 'private;
    # API URL for listing the repository's contributors.
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    # Indicates whether the repository has downloads enabled.
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads;
    # The number of open issues in the repository.
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount;
    # API URL template for accessing notifications for the repository.
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    # A short description of the repository.
    string? description;
    # The date and time the repository was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The number of users watching the repository.
    int watchers;
    # API URL template for accessing the repository's deploy keys.
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    # API URL for listing the repository's deployments.
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    # Indicates whether the repository has projects enabled.
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects;
    # Indicates whether the repository has been archived.
    boolean archived;
    # Indicates whether the repository has a wiki enabled.
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki;
    # The date and time the repository was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # API URL template for accessing comments in the repository.
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # API URL for listing users who have starred the repository.
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    # Returns whether or not this repository disabled
    boolean disabled;
    # Indicates whether branches are automatically deleted after merging.
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge?;
    # The Git URL used to clone the repository.
    @jsondata:Name {value: "git_url"}
    string gitUrl;
    # Indicates whether the repository has GitHub Pages enabled.
    @jsondata:Name {value: "has_pages"}
    boolean hasPages;
    # The user or organization that owns the repository.
    NullableSimpleUser? owner;
    # Indicates whether squash merging is allowed for pull requests.
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge?;
    # API URL template for accessing the repository's commits.
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    # API URL template for comparing two commits or branches.
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    # API URL template for accessing the repository's Git commits.
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    # A list of topic tags associated with the repository.
    string[] topics?;
    # API URL template for accessing Git blobs in the repository.
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    # API URL template for accessing Git tags in the repository.
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    # API URL for performing branch merges in the repository.
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    # API URL for accessing the repository's downloads.
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    # Indicates whether the repository has issues enabled.
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues;
    # Indicates whether web-based commits must include a sign-off.
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    # The API URL for the repository.
    string url;
    # API URL template for accessing files and directories in the repository.
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    # The URL of the repository this is mirrored from, if applicable.
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl;
    # API URL template for accessing the repository's milestones.
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    # API URL for listing teams with access to the repository.
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    # Indicates whether this repository is a fork of another repository.
    boolean 'fork;
    # API URL template for accessing the repository's issues.
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # API URL for listing events associated with the repository.
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # API URL for listing events on issues in the repository.
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    # Text fragments that matched the search query within the repository.
    @jsondata:Name {value: "text_matches"}
    SearchResultTextMatches textMatches?;
    # API URL template for accessing potential assignees for the repository.
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    # The number of open issues and pull requests in the repository.
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    # The number of users watching the repository for notifications.
    @jsondata:Name {value: "watchers_count"}
    int watchersCount;
    # The GraphQL node ID of the repository.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The URL of the repository's homepage or project website.
    string? homepage;
    # The total number of forks of the repository.
    @jsondata:Name {value: "forks_count"}
    int forksCount;
};

public type ActionsOrganizationPermissions record {
    # The policy that controls which repositories can use GitHub Actions.
    @jsondata:Name {value: "enabled_repositories"}
    EnabledRepositories enabledRepositories;
    # The policy that controls which actions and reusable workflows are allowed.
    @jsondata:Name {value: "allowed_actions"}
    AllowedActions allowedActions?;
    # The API URL to use to get or set the selected repositories that are allowed to run GitHub Actions, when enabled_repositories is set to selected
    @jsondata:Name {value: "selected_repositories_url"}
    string selectedRepositoriesUrl?;
    # The API URL to get or set the allowed actions for the organization.
    @jsondata:Name {value: "selected_actions_url"}
    SelectedActionsUrl selectedActionsUrl?;
};

# Use the status property to enable or disable GitHub Advanced Security for this repository. For more information, see "[About GitHub Advanced Security](/github/getting-started-with-github/learning-about-github/about-github-advanced-security)."
public type ReposownerrepoSecurityAndAnalysisAdvancedSecurity record {
    # Can be enabled or disabled
    string status?;
};

# Represents the Queries record for the operation: codespaces/check-permissions-for-devcontainer
public type CodespacesCheckPermissionsForDevcontainerQueries record {
    # Path to the devcontainer.json configuration to use for the permission check
    @http:Query {name: "devcontainer_path"}
    string devcontainerPath;
    # The git reference that points to the location of the devcontainer configuration to use for the permission check. The value of ref will typically be a branch name (heads/BRANCH_NAME). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation
    string ref;
};

public type TimelineReviewedEventLinks record {
    # Hypermedia link to the pull request associated with the review event.
    @jsondata:Name {value: "pull_request"}
    TimelineReviewedEventLinksHtml pullRequest;
    # Hypermedia link to the HTML page of the review event.
    TimelineReviewedEventLinksHtml html;
};

public type EventRepo record {
    # The full name of the repository associated with the event.
    string name;
    # The unique numeric identifier of the repository.
    int id;
    # The API URL for the repository associated with the event.
    string url;
};

# Represents the Queries record for the operation: repos/list-webhooks
public type ReposListWebhooksQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type CodeScanningAlertInstanceMessage record {
    # The message text describing the code scanning alert.
    string text?;
};

# Specify which security and analysis features to enable or disable for the repository.
# 
# To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
# 
# For example, to enable GitHub Advanced Security, use this data in the body of the PATCH request:
# { "security_and_analysis": {"advanced_security": { "status": "enabled" } } }.
# 
# You can check which security and analysis features are currently enabled by using a GET /repos/{owner}/{repo} request
public type ReposownerrepoSecurityAndAnalysis record {
    # Settings for secret scanning push protection on the repository.
    @jsondata:Name {value: "secret_scanning_push_protection"}
    ReposownerrepoSecurityAndAnalysisSecretScanningPushProtection secretScanningPushProtection?;
    # Settings for secret scanning on the repository.
    @jsondata:Name {value: "secret_scanning"}
    ReposownerrepoSecurityAndAnalysisSecretScanning secretScanning?;
    # Settings for GitHub Advanced Security on the repository.
    @jsondata:Name {value: "advanced_security"}
    ReposownerrepoSecurityAndAnalysisAdvancedSecurity advancedSecurity?;
};

public type RepositoryRuleDetailedOneOf5 record {
    *RepositoryRuleRequiredDeployments;
    *RepositoryRuleRulesetInfo;
};

public type RepositoryRuleDetailedOneOf6 record {
    *RepositoryRuleRequiredSignatures;
    *RepositoryRuleRulesetInfo;
};

public type LabelsLabelsOneOf112 record {
    # The hexadecimal color code for the label.
    string? color?;
    # The name of the label.
    string name?;
    # A short description of the label.
    string? description?;
    # The unique identifier of the label.
    int id?;
};

public type RepositoryRuleDetailedOneOf3 record {
    *RepositoryRuleDeletion;
    *RepositoryRuleRulesetInfo;
};

public type RepositoryRuleDetailedOneOf4 record {
    *RepositoryRuleRequiredLinearHistory;
    *RepositoryRuleRulesetInfo;
};

public type RepositoryRuleDetailedOneOf1 record {
    *RepositoryRuleCreation;
    *RepositoryRuleRulesetInfo;
};

public type SelectedActions record {
    # Specifies a list of string-matching patterns to allow specific action(s) and reusable workflow(s). Wildcards, tags, and SHAs are allowed. For example, monalisa/octocat@*, monalisa/octocat@v2, monalisa/*.
    # 
    # **Note**: The patterns_allowed setting only applies to public repositories
    @jsondata:Name {value: "patterns_allowed"}
    string[] patternsAllowed?;
    # Whether actions from GitHub Marketplace verified creators are allowed. Set to true to allow all actions by GitHub Marketplace verified creators
    @jsondata:Name {value: "verified_allowed"}
    boolean verifiedAllowed?;
    # Whether GitHub-owned actions are allowed. For example, this includes the actions in the actions organization
    @jsondata:Name {value: "github_owned_allowed"}
    boolean githubOwnedAllowed?;
};

public type NullableRepositoryTemplateRepository record {
    # The number of stars on the repository.
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount?;
    # Whether this repository acts as a template for generating new repositories.
    @jsondata:Name {value: "is_template"}
    boolean isTemplate?;
    # The date of the most recent push to the repository.
    @jsondata:Name {value: "pushed_at"}
    string pushedAt?;
    # API URL for the authenticated user's subscription to the repository.
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl?;
    # The primary programming language of the repository.
    string language?;
    # API URL template for listing repository branches.
    @jsondata:Name {value: "branches_url"}
    string branchesUrl?;
    # API URL template for accessing issue comments.
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl?;
    # Whether to allow rebase merges for pull requests.
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge?;
    # API URL template for listing repository labels.
    @jsondata:Name {value: "labels_url"}
    string labelsUrl?;
    # API URL for listing repository watchers.
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl?;
    # The permissions the authenticated user has on this repository.
    RepositoryTemplateRepositoryPermissions permissions?;
    # A temporary token for cloning the repository.
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    # API URL template for listing repository releases.
    @jsondata:Name {value: "releases_url"}
    string releasesUrl?;
    # The Subversion URL for the repository.
    @jsondata:Name {value: "svn_url"}
    string svnUrl?;
    # The default value for a squash merge commit message:
    # 
    # - PR_BODY - default to the pull request's body.
    # - COMMIT_MESSAGES - default to the branch's commit messages.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "squash_merge_commit_message"}
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squashMergeCommitMessage?;
    # The number of users watching the repository.
    @jsondata:Name {value: "subscribers_count"}
    int subscribersCount?;
    # The unique identifier of the repository.
    int id?;
    # API URL template for downloading repository archives.
    @jsondata:Name {value: "archive_url"}
    string archiveUrl?;
    # Whether to allow merge commits for pull requests.
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit?;
    # API URL template for accessing Git references.
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl?;
    # API URL for listing repository forks.
    @jsondata:Name {value: "forks_url"}
    string forksUrl?;
    # The repository visibility: public, private, or internal.
    string visibility?;
    # API URL template for listing commit statuses.
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl?;
    # The number of repositories in the fork network.
    @jsondata:Name {value: "network_count"}
    int networkCount?;
    # The SSH URL for cloning the repository.
    @jsondata:Name {value: "ssh_url"}
    string sshUrl?;
    # The full name of the repository in owner/name format.
    @jsondata:Name {value: "full_name"}
    string fullName?;
    # The size of the repository in kilobytes.
    int size?;
    # Whether to allow auto-merge on pull requests.
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge?;
    # API URL for listing programming languages used.
    @jsondata:Name {value: "languages_url"}
    string languagesUrl?;
    # URL of the repository page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # API URL template for listing repository collaborators.
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl?;
    # The HTTPS URL for cloning the repository.
    @jsondata:Name {value: "clone_url"}
    string cloneUrl?;
    # The name of the repository.
    string name?;
    # API URL template for listing pull requests.
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl?;
    # The default branch of the repository.
    @jsondata:Name {value: "default_branch"}
    string defaultBranch?;
    # API URL for listing repository webhooks.
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl?;
    # API URL template for accessing Git trees.
    @jsondata:Name {value: "trees_url"}
    string treesUrl?;
    # API URL for listing repository tags.
    @jsondata:Name {value: "tags_url"}
    string tagsUrl?;
    # Whether the repository is private or public.
    boolean 'private?;
    # API URL for listing repository contributors.
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl?;
    # Whether downloads are enabled.
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads?;
    # API URL template for listing repository notifications.
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl?;
    # The number of open issues in the repository.
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount?;
    # A short description of the repository.
    string description?;
    # The date the repository was created.
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    # API URL for listing repository deployments.
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl?;
    # API URL template for listing repository deploy keys.
    @jsondata:Name {value: "keys_url"}
    string keysUrl?;
    # Whether projects are enabled.
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects?;
    # Whether the repository is archived.
    boolean archived?;
    # Whether the wiki is enabled.
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki?;
    # The date the repository was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    # The default value for a merge commit title.
    # 
    # - PR_TITLE - default to the pull request's title.
    # - MERGE_MESSAGE - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name)
    @jsondata:Name {value: "merge_commit_title"}
    "PR_TITLE"|"MERGE_MESSAGE" mergeCommitTitle?;
    # API URL template for listing commit comments.
    @jsondata:Name {value: "comments_url"}
    string commentsUrl?;
    # API URL for listing users who starred the repository.
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl?;
    # Whether the repository is disabled.
    boolean disabled?;
    # Whether to delete head branches when pull requests are merged.
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge?;
    # The Git protocol URL for the repository.
    @jsondata:Name {value: "git_url"}
    string gitUrl?;
    # Whether the repository has GitHub Pages enabled.
    @jsondata:Name {value: "has_pages"}
    boolean hasPages?;
    # The account that owns the template repository.
    RepositoryTemplateRepositoryOwner owner?;
    # Whether to allow squash merges for pull requests.
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge?;
    # API URL template for listing repository commits.
    @jsondata:Name {value: "commits_url"}
    string commitsUrl?;
    # API URL template for comparing two commits.
    @jsondata:Name {value: "compare_url"}
    string compareUrl?;
    # API URL template for accessing Git commits.
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl?;
    # The list of topics associated with the repository.
    string[] topics?;
    # API URL template for accessing repository blobs.
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl?;
    # Whether pull request head branches can be updated even if not required.
    @jsondata:Name {value: "allow_update_branch"}
    boolean allowUpdateBranch?;
    # API URL template for accessing Git tags.
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl?;
    # API URL for performing merge operations.
    @jsondata:Name {value: "merges_url"}
    string mergesUrl?;
    # API URL for listing repository downloads.
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl?;
    # Whether issues are enabled.
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues?;
    # API URL for the repository.
    string url?;
    # API URL template for accessing repository contents.
    @jsondata:Name {value: "contents_url"}
    string contentsUrl?;
    # The URL of the mirror for the repository.
    @jsondata:Name {value: "mirror_url"}
    string mirrorUrl?;
    # API URL template for listing repository milestones.
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl?;
    # API URL for listing teams with access to the repository.
    @jsondata:Name {value: "teams_url"}
    string teamsUrl?;
    # Whether the repository is a fork.
    boolean 'fork?;
    # API URL template for listing repository issues.
    @jsondata:Name {value: "issues_url"}
    string issuesUrl?;
    # API URL for listing repository events.
    @jsondata:Name {value: "events_url"}
    string eventsUrl?;
    # Whether to use the pull request title as the default squash merge commit title.
    @jsondata:Name {value: "use_squash_pr_title_as_default"}
    boolean useSquashPrTitleAsDefault?;
    # API URL template for listing issue events.
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl?;
    # The default value for a merge commit message.
    # 
    # - PR_TITLE - default to the pull request's title.
    # - PR_BODY - default to the pull request's body.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "merge_commit_message"}
    "PR_BODY"|"PR_TITLE"|"BLANK" mergeCommitMessage?;
    # API URL template for listing repository assignees.
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl?;
    # The default value for a squash merge commit title:
    # 
    # - PR_TITLE - default to the pull request's title.
    # - COMMIT_OR_PR_TITLE - default to the commit's title (if only one commit) or the pull request's title (when more than one commit)
    @jsondata:Name {value: "squash_merge_commit_title"}
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squashMergeCommitTitle?;
    # The number of watchers on the repository.
    @jsondata:Name {value: "watchers_count"}
    int watchersCount?;
    # The GraphQL node identifier of the repository.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
    # The URL of the repository's homepage.
    string homepage?;
    # The number of forks of the repository.
    @jsondata:Name {value: "forks_count"}
    int forksCount?;
};

public type ReposownerrepoissuesLabels LabelsOneOf1|LabelsLabelsOneOf12;

public type RepositoryRuleDetailedOneOf2 record {
    *RepositoryRuleUpdate;
    *RepositoryRuleRulesetInfo;
};

public type CardIdMovesBody record {
    # The unique identifier of the column the card should be moved to
    @jsondata:Name {value: "column_id"}
    int columnId?;
    # The position of the card in a column. Can be one of: top, bottom, or after:<card_id> to place after the specified card
    @constraint:String {pattern: re `^(?:top|bottom|after:\d+)$`}
    string position;
};

# Represents the Queries record for the operation: pulls/list-commits
public type PullsListCommitsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type MilestonedIssueEventMilestone record {
    # The title of the milestone associated with the issue event.
    string title;
};

# Base Gist
public type BaseGist record {
    # The user who owns the gist.
    SimpleUser owner?;
    # List of gist forks.
    anydata[] forks?;
    # API URL for listing gist commits.
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    # The number of comments on the gist.
    int comments;
    # API URL for listing gist forks.
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The Git push URL for the gist.
    @jsondata:Name {value: "git_push_url"}
    string gitPushUrl;
    # The date and time the gist was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # A short description of the gist.
    string? description;
    # Whether the gist content is truncated due to size.
    boolean truncated?;
    # List of gist revision history entries.
    anydata[] history?;
    # API URL for the gist.
    string url;
    # Whether the gist is public.
    boolean 'public;
    # The date and time the gist was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # URL of the gist page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The Git pull URL for the gist.
    @jsondata:Name {value: "git_pull_url"}
    string gitPullUrl;
    # API URL for listing gist comments.
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # The files included in the gist.
    record {|BaseGistFiles...;|} files;
    # The unique identifier of the gist.
    string id;
    # The user associated with the gist, if applicable.
    NullableSimpleUser? user;
    # The GraphQL node identifier of the gist.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type RepositoryRuleRequiredDeploymentsParameters record {
    # The environments that must be successfully deployed to before branches can be merged
    @jsondata:Name {value: "required_deployment_environments"}
    string[] requiredDeploymentEnvironments;
};

# Issue Search Result Item
public type IssueSearchResultItem record {
    # The HTML-rendered body of the issue.
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    # The plain-text body of the issue.
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    # The list of users assigned to the issue.
    SimpleUser[]? assignees?;
    # The date and time the issue was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The title of the issue.
    string title;
    # The body content of the issue.
    string? body?;
    # The repository containing the issue.
    Repository repository?;
    # API URL for listing labels on this issue.
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # The author's association with the repository.
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # The issue number within the repository.
    int number;
    # The relevance score of the issue in search results.
    decimal score;
    # The date and time the issue was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The GitHub App that triggered the issue action, if any.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    # Whether the associated pull request is a draft.
    boolean draft?;
    # API URL for listing comments on the issue.
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # The reason the issue is locked, if applicable.
    @jsondata:Name {value: "active_lock_reason"}
    string? activeLockReason?;
    # API URL for the repository containing the issue.
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    # The unique identifier of the issue.
    int id;
    # The state of the issue, either open or closed.
    string state;
    # Whether the issue is locked.
    boolean locked;
    # API URL for the issue's timeline events.
    @jsondata:Name {value: "timeline_url"}
    string timelineUrl?;
    # The reason the issue was set to its current state.
    @jsondata:Name {value: "state_reason"}
    string? stateReason?;
    # Pull request metadata if the issue is linked to one.
    @jsondata:Name {value: "pull_request"}
    IssueSearchResultItemPullRequest pullRequest?;
    # The number of comments on the issue.
    int comments;
    # The date and time the issue was closed.
    @jsondata:Name {value: "closed_at"}
    string? closedAt;
    # API URL for the issue.
    string url;
    # The list of labels applied to the issue.
    IssueSearchResultItemLabels[] labels;
    # The milestone associated with the issue.
    NullableMilestone? milestone;
    # API URL for listing events on the issue.
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # URL of the issue page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Text fragments matching the search query.
    @jsondata:Name {value: "text_matches"}
    SearchResultTextMatches textMatches?;
    # Reaction counts for the issue.
    ReactionRollup reactions?;
    # The primary user assigned to the issue.
    NullableSimpleUser? assignee;
    # The user who created the issue.
    NullableSimpleUser? user;
    # The GraphQL node identifier of the issue.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type ManifestFile record {|
    # The path of the manifest file relative to the root of the Git repository
    @jsondata:Name {value: "source_location"}
    string sourceLocation?;
|};

public type UserProjectsBody record {
    # Name of the project
    string name;
    # Body of the project
    string? body?;
};

# A repository on GitHub
public type Repository record {
    # Whether to allow forking this repo
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking?;
    # Whether anonymous git access is enabled for this repository
    @jsondata:Name {value: "anonymous_access_enabled"}
    boolean anonymousAccessEnabled?;
    # API URL for the authenticated user's subscription to the repository
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    # API URL template for listing repository branches
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    # API URL template for accessing issue comments
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    # Whether to allow rebase merges for pull requests
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge = true;
    # The permissions the authenticated user has on this repository.
    RepositoryPermissions permissions?;
    # API URL for listing repository watchers
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    # A temporary token for cloning the repository
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    # API URL template for listing repository releases
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    # The default value for a squash merge commit message:
    # 
    # - PR_BODY - default to the pull request's body.
    # - COMMIT_MESSAGES - default to the branch's commit messages.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "squash_merge_commit_message"}
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squashMergeCommitMessage?;
    # The number of users watching the repository
    @jsondata:Name {value: "subscribers_count"}
    int subscribersCount?;
    # Unique identifier of the repository
    int id;
    # Whether discussions are enabled
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions = false;
    # The number of forks of the repository
    int forks;
    # API URL template for accessing Git references
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    # The SSH URL for cloning the repository
    @jsondata:Name {value: "ssh_url"}
    string sshUrl;
    # The full name of the repository in owner/name format
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0
    int size;
    # The template repository used to create this repository, if any.
    @jsondata:Name {value: "template_repository"}
    RepositoryTemplateRepository? templateRepository?;
    # API URL for listing programming languages used
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    # URL of the repository page on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # API URL template for listing repository collaborators
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    # The HTTPS URL for cloning the repository
    @jsondata:Name {value: "clone_url"}
    string cloneUrl;
    # The default branch of the repository
    @jsondata:Name {value: "default_branch"}
    string defaultBranch;
    # API URL for listing repository webhooks
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    # API URL template for accessing Git trees
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    # Whether downloads are enabled
    # 
    # # Deprecated
    @jsondata:Name {value: "has_downloads"}
    @deprecated
    boolean hasDownloads = true;
    # The date the repository was created
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    # The number of watchers on the repository
    int watchers;
    # API URL for listing repository deployments
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    # API URL template for listing repository deploy keys
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    # Whether the repository is archived
    boolean archived = false;
    # Whether the wiki is enabled
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki = true;
    # The date the repository was last updated
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    # Returns whether or not this repository disabled
    boolean disabled;
    # API URL template for comparing two commits
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    # API URL template for accessing Git commits
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    # The list of topics associated with the repository
    string[] topics?;
    # Whether or not a pull request head branch that is behind its base branch can always be updated even if it is not required to be up to date before merging
    @jsondata:Name {value: "allow_update_branch"}
    boolean allowUpdateBranch = false;
    # API URL template for accessing Git tags
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    # API URL for performing merge operations
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    # The time the authenticated user starred the repository
    @jsondata:Name {value: "starred_at"}
    string starredAt?;
    # API URL for the repository
    string url;
    # API URL template for accessing repository contents
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    # API URL template for listing repository issues
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # Whether a squash merge commit can use the pull request title as default. **This property has been deprecated. Please use squash_merge_commit_title instead
    # 
    # # Deprecated
    @jsondata:Name {value: "use_squash_pr_title_as_default"}
    @deprecated
    boolean useSquashPrTitleAsDefault = false;
    # The organization that owns the repository, if applicable.
    NullableSimpleUser? organization?;
    # The default value for a merge commit message.
    # 
    # - PR_TITLE - default to the pull request's title.
    # - PR_BODY - default to the pull request's body.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "merge_commit_message"}
    "PR_BODY"|"PR_TITLE"|"BLANK" mergeCommitMessage?;
    # API URL template for listing repository assignees
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    # The default value for a squash merge commit title:
    # 
    # - PR_TITLE - default to the pull request's title.
    # - COMMIT_OR_PR_TITLE - default to the commit's title (if only one commit) or the pull request's title (when more than one commit)
    @jsondata:Name {value: "squash_merge_commit_title"}
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squashMergeCommitTitle?;
    # The number of open issues in the repository
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    # The GraphQL node identifier of the repository
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The number of stars on the repository
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount;
    # Whether this repository acts as a template that can be used to generate new repositories
    @jsondata:Name {value: "is_template"}
    boolean isTemplate = false;
    # The date of the most recent push to the repository
    @jsondata:Name {value: "pushed_at"}
    string? pushedAt;
    # The primary programming language of the repository
    string? language;
    # API URL template for listing repository labels
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # The Subversion URL for the repository
    @jsondata:Name {value: "svn_url"}
    string svnUrl;
    # The name of the master branch
    @jsondata:Name {value: "master_branch"}
    string masterBranch?;
    # API URL template for downloading repository archives
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    # Whether to allow merge commits for pull requests
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit = true;
    # API URL for listing repository forks
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The repository visibility: public, private, or internal
    string visibility = "public";
    # API URL template for listing commit statuses
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    # The number of repositories in the fork network
    @jsondata:Name {value: "network_count"}
    int networkCount?;
    # The license applied to the repository.
    NullableLicenseSimple? license;
    # Whether to allow Auto-merge to be used on pull requests
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge = false;
    # The name of the repository
    string name;
    # API URL template for listing pull requests
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    # API URL for listing repository tags
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    # Whether the repository is private or public
    boolean 'private = false;
    # API URL for listing repository contributors
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    # API URL template for listing repository notifications
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    # The number of open issues in the repository
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount;
    # A short description of the repository
    string? description;
    # Whether projects are enabled
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects = true;
    # The default value for a merge commit title.
    # 
    # - PR_TITLE - default to the pull request's title.
    # - MERGE_MESSAGE - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name)
    @jsondata:Name {value: "merge_commit_title"}
    "PR_TITLE"|"MERGE_MESSAGE" mergeCommitTitle?;
    # API URL template for listing commit comments
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # API URL for listing users who starred the repository
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    # Whether to delete head branches when pull requests are merged
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge = false;
    # The Git protocol URL for the repository
    @jsondata:Name {value: "git_url"}
    string gitUrl;
    # Whether the repository has GitHub Pages enabled
    @jsondata:Name {value: "has_pages"}
    boolean hasPages;
    # The account that owns the repository.
    SimpleUser owner;
    # Whether to allow squash merges for pull requests
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge = true;
    # API URL template for listing repository commits
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    # API URL template for accessing repository blobs
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    # API URL for listing repository downloads
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    # Whether issues are enabled
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues = true;
    # Whether to require contributors to sign off on web-based commits
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired = false;
    # The URL of the mirror for the repository
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl;
    # API URL template for listing repository milestones
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    # API URL for listing teams with access to the repository
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    # Whether the repository is a fork
    boolean 'fork;
    # API URL for listing repository events
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # API URL template for listing issue events
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    # The number of watchers on the repository
    @jsondata:Name {value: "watchers_count"}
    int watchersCount;
    # The URL of the repository's homepage
    string? homepage;
    # The number of forks of the repository
    @jsondata:Name {value: "forks_count"}
    int forksCount;
};

# Minimal Repository
public type MinimalRepository record {
    # Whether forking is allowed on the repository
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking?;
    # The number of stars on the repository
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount?;
    # Whether the repository is a template repository
    @jsondata:Name {value: "is_template"}
    boolean isTemplate?;
    # The date of the most recent push to the repository
    @jsondata:Name {value: "pushed_at"}
    string? pushedAt?;
    # API URL for the authenticated user's subscription to the repository
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    # The primary programming language of the repository
    string? language?;
    # API URL template for listing repository branches
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    # API URL template for accessing issue comments
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    # API URL template for listing repository labels
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # API URL for listing repository watchers
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    # The permissions the authenticated user has on this repository.
    MinimalRepositoryPermissions permissions?;
    # A temporary token for cloning the repository
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    # API URL template for listing repository releases
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    # The Subversion URL for the repository
    @jsondata:Name {value: "svn_url"}
    string svnUrl?;
    # The number of users watching the repository
    @jsondata:Name {value: "subscribers_count"}
    int subscribersCount?;
    # The unique identifier of the repository
    int id;
    # Whether the repository has discussions enabled
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions?;
    # The number of forks of the repository
    int forks?;
    # API URL template for downloading repository archives
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    # API URL template for accessing Git references
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    # API URL for listing repository forks
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The visibility of the repository
    string visibility?;
    # API URL template for listing commit statuses
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    # The number of repositories in the fork network
    @jsondata:Name {value: "network_count"}
    int networkCount?;
    # The SSH URL for cloning the repository
    @jsondata:Name {value: "ssh_url"}
    string sshUrl?;
    # The role name assigned to the user for this repository
    @jsondata:Name {value: "role_name"}
    string roleName?;
    # The license applied to the repository.
    MinimalRepositoryLicense? license?;
    # The full name of the repository in owner/name format
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0
    int size?;
    # API URL for listing programming languages used
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    # URL of the repository page on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # API URL template for listing repository collaborators
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    # The HTTPS URL for cloning the repository
    @jsondata:Name {value: "clone_url"}
    string cloneUrl?;
    # The name of the repository
    string name;
    # API URL template for listing pull requests
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    # The default branch of the repository
    @jsondata:Name {value: "default_branch"}
    string defaultBranch?;
    # API URL for listing repository webhooks
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    # API URL template for accessing Git trees
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    # API URL for listing repository tags
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    # Whether the repository is private
    boolean 'private;
    # API URL for listing repository contributors
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    # Whether the repository has downloads enabled
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads?;
    # API URL template for listing repository notifications
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    # The number of open issues in the repository
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount?;
    # A short description of the repository
    string? description;
    # The date the repository was created
    @jsondata:Name {value: "created_at"}
    string? createdAt?;
    # The number of watchers on the repository
    int watchers?;
    # API URL for listing repository deployments
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    # API URL template for listing repository deploy keys
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    # Whether the repository has projects enabled
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects?;
    # Whether the repository is archived
    boolean archived?;
    # Whether the repository has the wiki enabled
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki?;
    # The date the repository was last updated
    @jsondata:Name {value: "updated_at"}
    string? updatedAt?;
    # API URL template for listing commit comments
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # API URL for listing users who starred the repository
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    # Whether the repository is disabled
    boolean disabled?;
    # Whether to delete branches on merge
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge?;
    # The Git protocol URL for the repository
    @jsondata:Name {value: "git_url"}
    string gitUrl?;
    # Whether the repository has GitHub Pages enabled
    @jsondata:Name {value: "has_pages"}
    boolean hasPages?;
    # The account that owns the repository.
    SimpleUser owner;
    # API URL template for listing repository commits
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    # API URL template for comparing two commits
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    # API URL template for accessing Git commits
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    # The list of topics associated with the repository
    string[] topics?;
    # API URL template for accessing repository blobs
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    # API URL template for accessing Git tags
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    # API URL for performing merge operations
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    # API URL for listing repository downloads
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    # Whether the repository has issues enabled
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues?;
    # The code of conduct for the repository
    @jsondata:Name {value: "code_of_conduct"}
    CodeOfConduct codeOfConduct?;
    # Whether commit sign-off is required for web-based commits
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    # API URL for the repository
    string url;
    # API URL template for accessing repository contents
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    # The URL of the mirror for the repository
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl?;
    # API URL template for listing repository milestones
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    # API URL for listing teams with access to the repository
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    # The security and analysis settings for the repository
    @jsondata:Name {value: "security_and_analysis"}
    SecurityAndAnalysis? securityAndAnalysis?;
    # Whether the repository is a fork
    boolean 'fork;
    # API URL template for listing repository issues
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # API URL for listing repository events
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # API URL template for listing issue events
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    # API URL template for listing repository assignees
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    # The number of open issues in the repository
    @jsondata:Name {value: "open_issues"}
    int openIssues?;
    # The number of watchers on the repository
    @jsondata:Name {value: "watchers_count"}
    int watchersCount?;
    # The GraphQL node identifier of the repository
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The URL of the repository's homepage
    string? homepage?;
    # The number of forks of the repository
    @jsondata:Name {value: "forks_count"}
    int forksCount?;
};

# Timeline Assigned Issue Event
public type TimelineAssignedIssueEvent record {
    # The user who performed the assignment action.
    SimpleUser actor;
    # API URL of the commit associated with this event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The GitHub App that triggered this event, if any.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The date and time the event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the event.
    int id;
    # The user who was assigned to the issue.
    SimpleUser assignee;
    # The type of event that occurred.
    string event;
    # The SHA of the commit associated with this event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # API URL for this event.
    string url;
    # The GraphQL node identifier of the event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type UserCodespacesBody UsercodespacesOneOf1|UsercodespacesusercodespacesOneOf12;

# Represents the Queries record for the operation: issues/list-for-org
public type IssuesListForOrgQueries record {
    # Indicates which sorts of issues to return. assigned means issues assigned to you. created means issues created by you. mentioned means issues mentioning you. subscribed means issues you're subscribed to updates for. all or repos means all issues you can see, regardless of participation or creation
    "assigned"|"created"|"mentioned"|"subscribed"|"repos"|"all" filter = "assigned";
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Indicates the state of the issues to return
    "open"|"closed"|"all" state = "open";
    # What to sort results by
    "created"|"updated"|"comments" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # A list of comma separated label names. Example: bug,ui,@high
    string labels?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

# Starred Repository
public type StarredRepository record {
    # The repository that was starred.
    Repository repo;
    # The date and time when the repository was starred.
    @jsondata:Name {value: "starred_at"}
    string starredAt;
};

public type RepositoryRuleDetailedOneOf9 record {
    *RepositoryRuleNonFastForward;
    *RepositoryRuleRulesetInfo;
};

# The time that the alert was last updated in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
public type AlertUpdatedAt string;

# The head branch of the pull request
public type PullRequestHead record {
    # The branch name of the head ref.
    string ref;
    # The repository containing the head branch.
    PullRequestHeadRepo? repo;
    # The label identifying the head branch, including owner prefix.
    string label;
    # The SHA of the head commit.
    string sha;
    # The user associated with the head branch.
    PullRequestHeadRepoOwner user;
};

public type RepositoryRuleDetailedOneOf7 record {
    *RepositoryRulePullRequest;
    *RepositoryRuleRulesetInfo;
};

# Starred Repository
public type StarredRepositoryResponse StarredRepositoryResponseAnyOf1|StarredRepositoryResponseStarredRepositoryResponseAnyOf12;

# Represents the Queries record for the operation: projects/list-for-repo
public type ProjectsListForRepoQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Indicates the state of the projects to return
    "open"|"closed"|"all" state = "open";
    # Page number of the results to fetch
    int page = 1;
};

public type RepositoryRuleDetailedOneOf8 record {
    *RepositoryRuleRequiredStatusChecks;
    *RepositoryRuleRulesetInfo;
};

# Represents the Queries record for the operation: repos/compare-commits
public type ReposCompareCommitsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Issues are a great way to keep track of tasks, enhancements, and bugs for your projects
public type Issue record {
    # The HTML-rendered body of the issue
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    # The plain text body of the issue
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    # The users assigned to the issue
    SimpleUser[]? assignees?;
    # The date the issue was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Title of the issue
    string title;
    # Contents of the issue
    string? body?;
    # The repository this issue belongs to.
    Repository repository?;
    # The user who closed the issue
    @jsondata:Name {value: "closed_by"}
    NullableSimpleUser? closedBy?;
    # API URL template for the issue's labels
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # The association of the author with the repository
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # Number uniquely identifying the issue within its repository
    int number;
    # The date the issue was last updated
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The GitHub App that triggered the event
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    # Whether the issue is a draft
    boolean draft?;
    # API URL for the issue's comments
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # The reason the issue conversation was locked
    @jsondata:Name {value: "active_lock_reason"}
    string? activeLockReason?;
    # The unique identifier of the issue
    int id;
    # API URL for the repository containing the issue
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    # State of the issue; either 'open' or 'closed'
    string state;
    # Whether the issue conversation is locked
    boolean locked;
    # API URL for the issue's timeline events
    @jsondata:Name {value: "timeline_url"}
    string timelineUrl?;
    # The reason for the current state
    @jsondata:Name {value: "state_reason"}
    "completed"|"reopened"|"not_planned"? stateReason?;
    # Pull request details linked to this issue, if applicable.
    @jsondata:Name {value: "pull_request"}
    IssuePullRequest pullRequest?;
    # The number of comments on the issue
    int comments;
    # The date the issue was closed
    @jsondata:Name {value: "closed_at"}
    string? closedAt;
    # URL for the issue
    string url;
    # Labels to associate with this issue; pass one or more label names to replace the set of labels on this issue; send an empty array to clear all labels from the issue; note that the labels are silently dropped for users without push access to the repository
    IssueLabels[] labels;
    # The milestone associated with this issue.
    NullableMilestone? milestone;
    # API URL for the issue's events
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # URL of the issue page on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Reaction counts aggregated for the issue.
    ReactionRollup reactions?;
    # The primary user assigned to the issue.
    NullableSimpleUser? assignee;
    # The user who created the issue.
    NullableSimpleUser? user;
    # The GraphQL node identifier of the issue
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Minimal representation of an organization programmatic access grant for enumerations
public type OrganizationProgrammaticAccessGrant record {
    # The user who owns the fine-grained personal access token.
    SimpleUser owner;
    # Type of repository selection requested
    @jsondata:Name {value: "repository_selection"}
    "none"|"all"|"subset" repositorySelection;
    # URL to the list of repositories the fine-grained personal access token can access. Only follow when repository_selection is subset
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
    # Date and time when the associated fine-grained personal access token expires
    @jsondata:Name {value: "token_expires_at"}
    string? tokenExpiresAt;
    # The permissions granted to the fine-grained personal access token.
    OrganizationProgrammaticAccessGrantPermissions permissions;
    # Date and time when the associated fine-grained personal access token was last used for authentication
    @jsondata:Name {value: "token_last_used_at"}
    string? tokenLastUsedAt;
    # Unique identifier of the fine-grained personal access token. The pat_id used to get details about an approved fine-grained personal access token
    int id;
    # Whether the associated fine-grained personal access token has expired
    @jsondata:Name {value: "token_expired"}
    boolean tokenExpired;
    # Date and time when the fine-grained personal access token was approved to access the organization
    @jsondata:Name {value: "access_granted_at"}
    string accessGrantedAt;
};

public type CommentIdReactionsBody record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the commit comment
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

# Repository invitations let you manage who you collaborate with
public type RepositorySubscription record {
    # Determines if notifications should be received from this repository
    boolean subscribed;
    # Determines if all notifications should be blocked from this repository
    boolean ignored;
    # The reason for the subscription to this repository.
    string? reason;
    # The date and time when the subscription was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # API URL for the subscribed repository.
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    # API URL for this subscription.
    string url;
};

public type GlobalAdvisoryCwes record {
    # The Common Weakness Enumeration (CWE) identifier
    @jsondata:Name {value: "cwe_id"}
    string cweId;
    # The name of the CWE
    string name;
};

# A request for a specific ref(branch,sha,tag) to be deployed
public type Deployment record {
    # The user who created the deployment.
    NullableSimpleUser? creator;
    # API URL for the deployment's statuses.
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    # A short description of the deployment.
    string? description;
    # The date and time when the deployment was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The SHA of the commit being deployed.
    string sha;
    # API URL for this deployment.
    string url;
    # The ref to deploy. This can be a branch, tag, or sha
    string ref;
    # Name for the target deployment environment
    string environment;
    # Parameter to specify a task to execute
    string task;
    # The date and time when the deployment was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The GitHub App that performed the deployment.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    # Additional metadata supplied by the deployer as a JSON object.
    record {}|string payload;
    # Specifies if the given environment is will no longer exist at some point in the future. Default: false
    @jsondata:Name {value: "transient_environment"}
    boolean transientEnvironment?;
    # The original environment targeted by this deployment.
    @jsondata:Name {value: "original_environment"}
    string originalEnvironment?;
    # Unique identifier of the deployment
    int id;
    # API URL for the repository associated with this deployment.
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    # The GraphQL node identifier of the deployment.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # Specifies if the given environment is one that end-users directly interact with. Default: false
    @jsondata:Name {value: "production_environment"}
    boolean productionEnvironment?;
};

# Whether to set the branch as read-only. If this is true, users will not be able to push to the branch
public type BranchProtectionLockBranch record {
    # Whether the branch is set as read-only.
    boolean enabled = false;
};

# Represents the Queries record for the operation: issues/list-events-for-repo
public type IssuesListEventsForRepoQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Short Blob
public type ShortBlob record {
    # The SHA hash of the blob.
    string sha;
    # API URL for the blob.
    string url;
};

# The type of GitHub user that can comment, open issues, or create pull requests while the interaction limit is in effect
public type InteractionGroup "existing_users"|"contributors_only"|"collaborators_only";

# Configuration for code scanning default setup
public type CodeScanningDefaultSetup record {
    # The frequency of the periodic analysis
    "weekly"? schedule?;
    # CodeQL query suite to be used
    @jsondata:Name {value: "query_suite"}
    "default"|"extended" querySuite?;
    # Languages to be analyzed
    ("c-cpp"|"csharp"|"go"|"java-kotlin"|"javascript-typescript"|"javascript"|"python"|"ruby"|"typescript"|"swift")[] languages?;
    # Timestamp of latest configuration update
    @jsondata:Name {value: "updated_at"}
    string? updatedAt?;
    # Code scanning default setup has been configured or not
    "configured"|"not-configured" state?;
};

# The license information for the repository
public type NullableMinimalRepositoryLicense record {
    # The full name of the license.
    string name?;
    # The SPDX identifier of the license.
    @jsondata:Name {value: "spdx_id"}
    string spdxId?;
    # The lowercase license key identifier.
    string 'key?;
    # API URL for the license.
    string url?;
    # The GraphQL node identifier of the license.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

public type CommitSearchResultItemCommitAuthor record {
    # The date and time when the commit was authored.
    string date;
    # The name of the commit author.
    string name;
    # The email address of the commit author.
    string email;
};

public type ParticipationStats record {
    # Weekly commit counts for all users over the past year.
    int[] all;
    # Weekly commit counts for the repository owner over the past year.
    int[] owner;
};

public type ColumnIdMovesBody record {
    # The position of the column in a project. Can be one of: first, last, or after:<column_id> to place after the specified column
    @constraint:String {pattern: re `^(?:first|last|after:\d+)$`}
    string position;
};

# Represents the Queries record for the operation: projects/list-cards
public type ProjectsListCardsQueries record {
    # Filters the project cards that are returned by the card's state
    @http:Query {name: "archived_state"}
    "all"|"archived"|"not_archived" archivedState = "not_archived";
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: activity/list-events-for-authenticated-user
public type ActivityListEventsForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# A list of directory items
public type ContentDirectory ContentDirectoryInner[];

# Git references within a repository
public type GitRef record {
    # The fully qualified name of the Git reference.
    string ref;
    # API URL for this Git reference.
    string url;
    # The GraphQL node identifier of the Git reference.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The Git object this reference points to.
    GitRefObject 'object;
};

# User Search Result Item
public type UserSearchResultItem record {
    # API URL listing the user's repositories.
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    # API URL template for the user's gists.
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    # API URL template for users this user follows.
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    # The date and time when the user account was created.
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    # The user's profile biography.
    string? bio?;
    # The user's GitHub login username.
    string login;
    # The type of GitHub account.
    string 'type;
    # The URL of the user's blog or website.
    string? blog?;
    # API URL for the user's repository subscriptions.
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    # The search relevance score for this user result.
    decimal score;
    # The date and time when the user profile was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    # Whether the user is a GitHub site administrator.
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    # The company the user is affiliated with.
    string? company?;
    # The unique numeric identifier of the user.
    int id;
    # The number of public repositories owned by the user.
    @jsondata:Name {value: "public_repos"}
    int publicRepos?;
    # The Gravatar identifier for the user's avatar.
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    # The publicly visible email address of the user.
    string? email?;
    # API URL for the user's organization memberships.
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
    # Whether the user is available for hire.
    boolean? hireable?;
    # API URL template for repositories starred by the user.
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    # API URL for the user's followers.
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    # The number of public gists owned by the user.
    @jsondata:Name {value: "public_gists"}
    int publicGists?;
    # API URL for the user.
    string url;
    # API URL for events received by the user.
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    # The number of users following this user.
    int followers?;
    # URL of the user's avatar image.
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # API URL template for events performed by the user.
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # URL of the user's profile page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The number of users this user is following.
    int following?;
    # Text matches for search highlighting in the result.
    @jsondata:Name {value: "text_matches"}
    SearchResultTextMatches textMatches?;
    # The display name of the user.
    string? name?;
    # The geographic location of the user.
    string? location?;
    # The GraphQL node identifier of the user.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The date and time when the user account was suspended.
    @jsondata:Name {value: "suspended_at"}
    string? suspendedAt?;
};

public type CodespaceNamePublishBody record {
    # Whether the new repository should be private
    boolean 'private = false;
    # A name for the new repository
    string name?;
};

public type ActionsPermissionsBody record {
    # The policy for which repositories are permitted to use Actions.
    @jsondata:Name {value: "enabled_repositories"}
    EnabledRepositories enabledRepositories;
    # The policy for which Actions and reusable workflows are allowed to run.
    @jsondata:Name {value: "allowed_actions"}
    AllowedActions allowedActions?;
};

public type GlobalAdvisoryCredits record {
    # The type of credit assigned for the security advisory contribution.
    SecurityAdvisoryCreditTypes 'type;
    # The user receiving credit for the security advisory.
    SimpleUser user;
};

# Timeline Reviewed Event
public type TimelineReviewedEvent record {
    # The HTML-rendered body of the review.
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    # Hypermedia links related to the review.
    @jsondata:Name {value: "_links"}
    TimelineReviewedEventLinks links;
    # The date and time when the review was submitted.
    @jsondata:Name {value: "submitted_at"}
    string submittedAt?;
    # The plain text body of the review.
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    # API URL for the pull request this review belongs to.
    @jsondata:Name {value: "pull_request_url"}
    string pullRequestUrl;
    # The text of the review
    string? body;
    # The association of the review author with the repository.
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # URL of the review on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Unique identifier of the review
    int id;
    # The state of the review, such as approved or changes requested.
    string state;
    # The event type that triggered this timeline entry.
    string event;
    # The user who submitted the review.
    SimpleUser user;
    # A commit SHA for the review
    @jsondata:Name {value: "commit_id"}
    string commitId;
    # The GraphQL node identifier of the review.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type RepositoryRulesetLinksSelf record {
    # The URL of the ruleset
    string href?;
};

# The time that the alert was created in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
public type AlertCreatedAt string;

public type BranchRestrictionPolicyOwner record {
    # API URL listing the owner's repositories.
    @jsondata:Name {value: "repos_url"}
    string reposUrl?;
    # API URL template for the owner's gists.
    @jsondata:Name {value: "gists_url"}
    string gistsUrl?;
    # API URL template for the organization's members.
    @jsondata:Name {value: "members_url"}
    string membersUrl?;
    # API URL template for users this owner follows.
    @jsondata:Name {value: "following_url"}
    string followingUrl?;
    # The description of the organization.
    string description?;
    # API URL template for repositories starred by the owner.
    @jsondata:Name {value: "starred_url"}
    string starredUrl?;
    # The owner's GitHub login username.
    string login?;
    # API URL for the owner's followers.
    @jsondata:Name {value: "followers_url"}
    string followersUrl?;
    # The type of GitHub account.
    string 'type?;
    # API URL for the owner.
    string url?;
    # API URL template for the organization's public members.
    @jsondata:Name {value: "public_members_url"}
    string publicMembersUrl?;
    # API URL for the owner's repository subscriptions.
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl?;
    # API URL template for the organization's issues.
    @jsondata:Name {value: "issues_url"}
    string issuesUrl?;
    # API URL for events received by the owner.
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl?;
    # URL of the owner's avatar image.
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl?;
    # API URL template for events performed by the owner.
    @jsondata:Name {value: "events_url"}
    string eventsUrl?;
    # URL of the owner's profile page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # Whether the owner is a GitHub site administrator.
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin?;
    # The unique numeric identifier of the owner.
    int id?;
    # API URL for the organization's webhooks.
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl?;
    # The Gravatar identifier for the owner's avatar.
    @jsondata:Name {value: "gravatar_id"}
    string gravatarId?;
    # The GraphQL node identifier of the owner.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
    # API URL for the owner's organization memberships.
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl?;
};

public type BillingSelectedTeamsBody record {
    # List of team names within the organization to which to grant access to GitHub Copilot
    @jsondata:Name {value: "selected_teams"}
    string[] selectedTeams;
};

# Represents the Queries record for the operation: apps/list-plans
public type AppsListPlansQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Parameters for a repository name condition
public type RepositoryRulesetConditionsRepositoryNameTarget record {
    # Conditions targeting repositories by their name pattern.
    @jsondata:Name {value: "repository_name"}
    RepositoryRulesetConditionsRepositoryNameTargetRepositoryName repositoryName;
};

public type SecretNameRepositoriesBody record {
    # An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the visibility is set to selected. You can add and remove individual repositories using the [Add selected repository to an organization secret](https://docs.github.com/rest/actions/secrets#add-selected-repository-to-an-organization-secret) and [Remove selected repository from an organization secret](https://docs.github.com/rest/actions/secrets#remove-selected-repository-from-an-organization-secret) endpoints
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds;
};

# Deployment protection rule
public type DeploymentProtectionRuleResponse record {
    # The number of enabled custom deployment protection rules for this environment
    @jsondata:Name {value: "total_count"}
    int totalCount?;
    # The list of enabled custom deployment protection rules.
    @jsondata:Name {value: "custom_deployment_protection_rules"}
    DeploymentProtectionRule[] customDeploymentProtectionRules?;
};

public type SecretssecretNameBody4 record {
    # ID of the key you used to encrypt the secret
    @jsondata:Name {value: "key_id"}
    string keyId?;
    # Value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get a repository public key](https://docs.github.com/rest/codespaces/repository-secrets#get-a-repository-public-key) endpoint
    @jsondata:Name {value: "encrypted_value"}
    string encryptedValue?;
};

public type SecretssecretNameBody5 record {
    # ID of the key you used to encrypt the secret
    @jsondata:Name {value: "key_id"}
    string keyId?;
    # Value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get a repository public key](https://docs.github.com/rest/dependabot/secrets#get-a-repository-public-key) endpoint
    @jsondata:Name {value: "encrypted_value"}
    string encryptedValue?;
};

public type AuthorsauthorIdBody record {|
    # The new Git author name
    string name?;
    # The new Git author email
    string email?;
|};

public type SecretssecretNameBody6 record {
    # ID of the key you used to encrypt the secret
    @jsondata:Name {value: "key_id"}
    string keyId;
    # Value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get an environment public key](https://docs.github.com/rest/actions/secrets#get-an-environment-public-key) endpoint
    @jsondata:Name {value: "encrypted_value"}
    string encryptedValue;
};

public type SecretssecretNameBody7 record {
    # An array of repository ids that can access the user secret. You can manage the list of selected repositories using the [List selected repositories for a user secret](https://docs.github.com/rest/codespaces/secrets#list-selected-repositories-for-a-user-secret), [Set selected repositories for a user secret](https://docs.github.com/rest/codespaces/secrets#set-selected-repositories-for-a-user-secret), and [Remove a selected repository from a user secret](https://docs.github.com/rest/codespaces/secrets#remove-a-selected-repository-from-a-user-secret) endpoints
    @jsondata:Name {value: "selected_repository_ids"}
    UsercodespacessecretssecretNameSelectedRepositoryIds[] selectedRepositoryIds?;
    # ID of the key you used to encrypt the secret
    @jsondata:Name {value: "key_id"}
    string keyId;
    # Value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get the public key for the authenticated user](https://docs.github.com/rest/codespaces/secrets#get-public-key-for-the-authenticated-user) endpoint
    @jsondata:Name {value: "encrypted_value"}
    string encryptedValue?;
};

# Low-level Git commit operations within a repository
public type GitCommit record {
    # The person who committed the changes to the repository.
    GitCommitCommitter committer;
    # The person who originally authored the commit.
    GitCommitCommitter author;
    # URL of the commit page on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The Git tree object this commit points to.
    GitCommitTree tree;
    # Message describing the purpose of the commit
    string message;
    # SHA for the commit
    string sha;
    # API URL for the commit
    string url;
    # Signature verification details for this commit.
    GitCommitVerification verification;
    # The GraphQL node identifier of the commit
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The parent commits of this commit
    GitCommitParents[] parents;
};

public type SecretssecretNameBody1 record {
    # An array of repository IDs that can access the organization secret. You can only provide a list of repository IDs when the visibility is set to selected. You can manage the list of selected repositories using the [List selected repositories for an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#list-selected-repositories-for-an-organization-secret), [Set selected repositories for an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#set-selected-repositories-for-an-organization-secret), and [Remove selected repository from an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#remove-selected-repository-from-an-organization-secret) endpoints
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds?;
    # Which type of organization repositories have access to the organization secret. selected means only the repositories specified by selected_repository_ids can access the secret
    "all"|"private"|"selected" visibility;
    # The ID of the key you used to encrypt the secret
    @jsondata:Name {value: "key_id"}
    string keyId?;
    # The value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get an organization public key](https://docs.github.com/rest/codespaces/organization-secrets#get-an-organization-public-key) endpoint
    @jsondata:Name {value: "encrypted_value"}
    string encryptedValue?;
};

public type SecretssecretNameBody2 record {
    # An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the visibility is set to selected. You can manage the list of selected repositories using the [List selected repositories for an organization secret](https://docs.github.com/rest/dependabot/secrets#list-selected-repositories-for-an-organization-secret), [Set selected repositories for an organization secret](https://docs.github.com/rest/dependabot/secrets#set-selected-repositories-for-an-organization-secret), and [Remove selected repository from an organization secret](https://docs.github.com/rest/dependabot/secrets#remove-selected-repository-from-an-organization-secret) endpoints
    @jsondata:Name {value: "selected_repository_ids"}
    string[] selectedRepositoryIds?;
    # Which type of organization repositories have access to the organization secret. selected means only the repositories specified by selected_repository_ids can access the secret
    "all"|"private"|"selected" visibility;
    # ID of the key you used to encrypt the secret
    @jsondata:Name {value: "key_id"}
    string keyId?;
    # Value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get an organization public key](https://docs.github.com/rest/dependabot/secrets#get-an-organization-public-key) endpoint
    @jsondata:Name {value: "encrypted_value"}
    string encryptedValue?;
};

public type SecretssecretNameBody3 record {
    # ID of the key you used to encrypt the secret
    @jsondata:Name {value: "key_id"}
    string keyId?;
    # Value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get a repository public key](https://docs.github.com/rest/actions/secrets#get-a-repository-public-key) endpoint
    @jsondata:Name {value: "encrypted_value"}
    string encryptedValue?;
};

public type GitTagsBody record {
    # The person creating the tag, including name, email, and date.
    ReposownerrepogittagsTagger tagger?;
    # The tag's name. This is typically a version (e.g., "v0.0.1")
    string tag;
    # The tag message
    string message;
    # The type of the object we're tagging. Normally this is a commit but it can also be a tree or a blob
    "commit"|"tree"|"blob" 'type;
    # The SHA of the git object this is tagging
    string 'object;
};

# Represents the Queries record for the operation: actions/list-selected-repositories-enabled-github-actions-organization
public type ActionsListSelectedRepositoriesEnabledGithubActionsOrganizationQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# A suite of checks performed on the code of a given code change
public type CheckSuiteResponse record {
    # The total number of check suites returned.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of check suites.
    @jsondata:Name {value: "check_suites"}
    CheckSuite[] checkSuites;
};

# Represents the Queries record for the operation: pulls/list
public type PullsListQueries record {
    # Filter pulls by head user or head organization and branch name in the format of user:ref-name or organization:ref-name. For example: github:new-script-format or octocat:test-branch
    string head?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Either open, closed, or all to filter by state
    "open"|"closed"|"all" state = "open";
    # What to sort results by. popularity will sort by the number of comments. long-running will sort by date created and will limit the results to pull requests that have been open for more than a month and have had activity within the past month
    "created"|"updated"|"popularity"|"long-running" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # Filter pulls by base branch name. Example: gh-pages
    string base?;
    # The direction of the sort. Default: desc when sort is created or sort is not specified, otherwise asc
    "asc"|"desc" direction?;
};

# A reply to a discussion within a team
public type TeamDiscussionComment record {
    # The HTML-rendered body of the comment.
    @jsondata:Name {value: "body_html"}
    string bodyHtml;
    # The current version of the body content. If provided, this update operation will be rejected if the given version does not match the latest version on the server
    @jsondata:Name {value: "body_version"}
    string bodyVersion;
    # The user who authored the comment.
    NullableSimpleUser? author;
    # The date and time when the comment was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The main text of the comment
    string body;
    # API URL for this discussion comment.
    string url;
    # The unique sequence number of a team discussion comment
    int number;
    # The date and time when the comment was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # URL of the comment on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The date and time when the comment was last edited.
    @jsondata:Name {value: "last_edited_at"}
    string? lastEditedAt;
    # Reaction counts aggregated for this comment.
    ReactionRollup reactions?;
    # API URL for the discussion this comment belongs to.
    @jsondata:Name {value: "discussion_url"}
    string discussionUrl;
    # The GraphQL node identifier of the comment.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type RunIdDeploymentProtectionRuleBody ReviewCustomGatesCommentRequired|ReviewCustomGatesStateRequired;

# Gitignore Template
public type GitignoreTemplate record {
    # The name of the gitignore template.
    string name;
    # The gitignore template content with ignore patterns.
    string 'source;
};

# Represents the Queries record for the operation: repos/get-org-rulesets
public type ReposGetOrgRulesetsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: gists/list-starred
public type GistsListStarredQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

# An entry in the reviews log for environment deployments
public type EnvironmentApprovals record {
    # The list of environments that were approved or rejected
    EnvironmentApprovalsEnvironments[] environments;
    # The comment submitted with the deployment review
    string comment;
    # Whether deployment to the environment(s) was approved or rejected or pending (with comments)
    "approved"|"rejected"|"pending" state;
    # The user who approved or rejected the deployment.
    SimpleUser user;
};

# Language
public type Language record {|
    int...;
|};

# An object without any properties
public type EmptyObject record {|
|};

# Combined Commit Status
public type CombinedCommitStatus record {
    # API URL for the commit this status is associated with.
    @jsondata:Name {value: "commit_url"}
    string commitUrl;
    # The total number of statuses for this commit.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of individual commit statuses.
    SimpleCommitStatus[] statuses;
    # The combined state of all statuses for the commit.
    string state;
    # The repository containing the commit.
    MinimalRepository repository;
    # The SHA of the commit.
    string sha;
    # API URL for this combined commit status.
    string url;
};

# Delivery made by a webhook
public type HookDelivery record {
    # The request that was sent for this webhook delivery.
    HookDeliveryRequest request;
    # Status code received when delivery was made
    @jsondata:Name {value: "status_code"}
    int statusCode;
    # The id of the GitHub App installation associated with this event
    @jsondata:Name {value: "installation_id"}
    int? installationId;
    # Whether the delivery is a redelivery
    boolean redelivery;
    # The URL target of the delivery
    string url?;
    # Time spent delivering
    decimal duration;
    # The response received for this webhook delivery.
    HookDeliveryResponse response;
    # Unique identifier for the event (shared with all deliveries for all webhooks that subscribe to this event)
    string guid;
    # The type of activity for the event that triggered the delivery
    string? action;
    # The id of the repository associated with this event
    @jsondata:Name {value: "repository_id"}
    int? repositoryId;
    # Unique identifier of the delivery
    int id;
    # The event that triggered the delivery
    string event;
    # Time when the delivery was delivered
    @jsondata:Name {value: "delivered_at"}
    string deliveredAt;
    # Description of the status of the attempted delivery
    string status;
};

# Locked Issue Event
public type LockedIssueEvent record {
    # The user who locked the issue.
    SimpleUser actor;
    # API URL for the commit associated with this event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The GitHub App that triggered the lock event.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The reason the issue was locked.
    @jsondata:Name {value: "lock_reason"}
    string? lockReason;
    # The date and time when the issue was locked.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of this event.
    int id;
    # The type of event that occurred.
    string event;
    # The SHA of the commit associated with this event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # API URL for this event.
    string url;
    # The GraphQL node identifier of this event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type WorkflowUsageBillable record {
    # Billable usage minutes for Ubuntu-based workflow runs.
    @jsondata:Name {value: "UBUNTU"}
    WorkflowUsageBillableUBUNTU uBUNTU?;
    # Billable usage minutes for macOS-based workflow runs.
    @jsondata:Name {value: "MACOS"}
    WorkflowUsageBillableUBUNTU mACOS?;
    # Billable usage minutes for Windows-based workflow runs.
    @jsondata:Name {value: "WINDOWS"}
    WorkflowUsageBillableUBUNTU wINDOWS?;
};

public type OrgMembershipPermissions record {
    # Indicates whether the member can create repositories in the organization.
    @jsondata:Name {value: "can_create_repository"}
    boolean canCreateRepository;
};

# Hovercard
public type Hovercard record {
    # List of contextual information displayed in the hovercard.
    HovercardContexts[] contexts;
};

# Actions OIDC subject customization for a repository
public type ActionsOIDCSubjectCustomizationForARepository record {
    # Array of unique strings. Each claim key can only contain alphanumeric characters and underscores
    @jsondata:Name {value: "include_claim_keys"}
    string[] includeClaimKeys?;
    # Whether to use the default template or not. If true, the include_claim_keys field is ignored
    @jsondata:Name {value: "use_default"}
    boolean useDefault;
};

# Legacy Review Comment
public type ReviewComment record {
    # The HTML-rendered body of the review comment
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    # The SHA of the original commit to which the comment applied
    @jsondata:Name {value: "original_commit_id"}
    string originalCommitId;
    # Hypermedia links related to the review comment.
    @jsondata:Name {value: "_links"}
    ReviewCommentLinks links;
    # The plain text body of the review comment
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    # The ID of the comment this comment replies to
    @jsondata:Name {value: "in_reply_to_id"}
    int inReplyToId?;
    # The line of the blob to which the comment applies. The last line of the range for a multi-line comment
    int line?;
    # The diff hunk to which the comment applies
    @jsondata:Name {value: "diff_hunk"}
    string diffHunk;
    # The date the review comment was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The first line of the range for a multi-line comment
    @jsondata:Name {value: "start_line"}
    int? startLine?;
    # The body text of the review comment
    string body;
    # The association of the comment author with the repository
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # The relative path of the file to which the comment applies
    string path;
    # The original line index in the diff to which the comment applied
    @jsondata:Name {value: "original_position"}
    int originalPosition;
    # The date the review comment was last updated
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The ID of the pull request review this comment belongs to
    @jsondata:Name {value: "pull_request_review_id"}
    int? pullRequestReviewId;
    # The unique identifier of the review comment
    int id;
    # The side of the first line of the range for a multi-line comment
    "LEFT"|"RIGHT" side = "RIGHT";
    # API URL for the pull request
    @jsondata:Name {value: "pull_request_url"}
    string pullRequestUrl;
    # API URL for the review comment
    string url;
    # The side of the first line of the range for a multi-line comment
    @jsondata:Name {value: "start_side"}
    "LEFT"|"RIGHT"? startSide = "RIGHT";
    # The original line of the blob to which the comment applies. The last line of the range for a multi-line comment
    @jsondata:Name {value: "original_line"}
    int originalLine?;
    # The original first line of the range for a multi-line comment
    @jsondata:Name {value: "original_start_line"}
    int? originalStartLine?;
    # URL of the review comment on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Reaction rollup summarizing emoji reactions on the review comment.
    ReactionRollup reactions?;
    # The line index in the diff to which the comment applies
    int? position;
    # The SHA of the commit to which the comment applies
    @jsondata:Name {value: "commit_id"}
    string commitId;
    # The user who created the review comment.
    NullableSimpleUser? user;
    # The GraphQL node identifier of the review comment
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# A team's access to a repository
public type TeamRepository record {
    # Whether to allow forking this repo
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking = false;
    # The number of users who have starred the repository.
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount;
    # Whether this repository acts as a template that can be used to generate new repositories
    @jsondata:Name {value: "is_template"}
    boolean isTemplate = false;
    # The date and time of the most recent push to the repository.
    @jsondata:Name {value: "pushed_at"}
    string? pushedAt;
    # The API URL to manage the authenticated user's subscription to the repository.
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    # The primary programming language used in the repository.
    string? language;
    # A template for the API URL to get information about branches in the repository.
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    # A template for the API URL to get information about issue comments on the repository.
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    # Whether to allow rebase merges for pull requests
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge = true;
    # A template for the API URL to get information about labels of the repository.
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # The team's permissions for the repository.
    TeamRepositoryPermissions permissions?;
    # The API URL to list the subscribers on the repository.
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    # A temporary token used to clone the repository.
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    # A template for the API URL to get information about releases on the repository.
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    # The Subversion URL to check out the repository.
    @jsondata:Name {value: "svn_url"}
    string svnUrl;
    # The number of users watching the repository.
    @jsondata:Name {value: "subscribers_count"}
    int subscribersCount?;
    # Unique identifier of the repository
    int id;
    # The name of the master branch of the repository.
    @jsondata:Name {value: "master_branch"}
    string masterBranch?;
    # The number of forks of the repository.
    int forks;
    # A template for the API URL to download the repository as an archive.
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    # Whether to allow merge commits for pull requests
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit = true;
    # A template for the API URL to get information about Git refs of the repository.
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    # The API URL to list the forks of the repository.
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The repository visibility: public, private, or internal
    string visibility = "public";
    # A template for the API URL to get information about statuses of a commit.
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    # The number of repositories in the repository's network.
    @jsondata:Name {value: "network_count"}
    int networkCount?;
    # The SSH URL to clone the repository.
    @jsondata:Name {value: "ssh_url"}
    string sshUrl;
    # The role name assigned to the team for this repository.
    @jsondata:Name {value: "role_name"}
    string roleName?;
    # The license associated with the repository.
    NullableLicenseSimple? license;
    # The full, globally unique name of the repository.
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The size of the repository in kilobytes.
    int size;
    # The repository used as a template to create this repository.
    @jsondata:Name {value: "template_repository"}
    NullableRepository? templateRepository?;
    # Whether to allow Auto-merge to be used on pull requests
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge = false;
    # The API URL to get information about the languages used in the repository.
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    # The URL to view the repository on GitHub.com.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # A template for the API URL to get information about collaborators of the repository.
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    # The HTTPS URL to clone the repository.
    @jsondata:Name {value: "clone_url"}
    string cloneUrl;
    # The name of the repository
    string name;
    # A template for the API URL to get information about pull requests on the repository.
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    # The default branch of the repository
    @jsondata:Name {value: "default_branch"}
    string defaultBranch;
    # The API URL to list the hooks on the repository.
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    # A template for the API URL to create or retrieve a raw Git tree of the repository.
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    # The API URL to get information about tags on the repository.
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    # Whether the repository is private or public
    boolean 'private = false;
    # The API URL to list the contributors to the repository.
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    # Whether downloads are enabled
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads = true;
    # A template for the API URL to get information about notifications on the repository.
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    # The number of open issues in the repository.
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount;
    # The description of the repository.
    string? description;
    # The date and time the repository was created.
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    # The number of users watching the repository.
    int watchers;
    # The API URL to list the deployments of the repository.
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    # A template for the API URL to get information about deploy keys on the repository.
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    # Whether projects are enabled
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects = true;
    # Whether the repository is archived
    boolean archived = false;
    # Whether the wiki is enabled
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki = true;
    # The date and time the repository was last updated.
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    # A template for the API URL to get information about comments on the repository.
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # The API URL to list the stargazers on the repository.
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    # Returns whether or not this repository disabled
    boolean disabled;
    # Whether to delete head branches when pull requests are merged
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge = false;
    # The Git URL to clone the repository.
    @jsondata:Name {value: "git_url"}
    string gitUrl;
    # Whether the repository has GitHub Pages enabled.
    @jsondata:Name {value: "has_pages"}
    boolean hasPages;
    # The user or organization that owns the repository.
    NullableSimpleUser? owner;
    # Whether to allow squash merges for pull requests
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge = true;
    # A template for the API URL to get information about commits on the repository.
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    # A template for the API URL to compare two commits or refs.
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    # A template for the API URL to get information about Git commits of the repository.
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    # The list of topics associated with the repository.
    string[] topics?;
    # A template for the API URL to create or retrieve a raw Git blob in the repository.
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    # A template for the API URL to get information about Git tags of the repository.
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    # The API URL to merge branches in the repository.
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    # The API URL to list the downloads on the repository.
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    # Whether issues are enabled
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues = true;
    # Whether to require contributors to sign off on web-based commits
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired = false;
    # The API URL for the repository.
    string url;
    # A template for the API URL to get the contents of the repository.
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    # The URL of the repository's mirror, if it is a mirror.
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl;
    # A template for the API URL to get information about milestones of the repository.
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    # The API URL to list the teams on the repository.
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    # Whether the repository is a fork of another repository.
    boolean 'fork;
    # A template for the API URL to get information about issues on the repository.
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # The API URL to list the events of the repository.
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # A template for the API URL to get information about issue events on the repository.
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    # A template for the API URL to list the available assignees for issues in the repository.
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    # The number of open issues and pull requests in the repository.
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    # The number of users watching the repository.
    @jsondata:Name {value: "watchers_count"}
    int watchersCount;
    # The GraphQL node identifier of the repository.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The URL of the repository's homepage.
    string? homepage;
    # The number of forks of the repository.
    @jsondata:Name {value: "forks_count"}
    int forksCount;
};

# Represents the Queries record for the operation: packages/get-all-package-versions-for-package-owned-by-org
public type PackagesGetAllPackageVersionsForPackageOwnedByOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # The state of the package, either active or deleted
    "active"|"deleted" state = "active";
};

# Represents the Queries record for the operation: users/list-followers-for-user
public type UsersListFollowersForUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Details of a deployment branch or tag policy
public type DeploymentBranchPolicyResponse record {
    # The number of deployment branch policies for the environment
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # List of deployment branch or tag policies for the environment.
    @jsondata:Name {value: "branch_policies"}
    DeploymentBranchPolicy[] branchPolicies;
};

# A GitHub repository
public type SimpleRepository record {
    # The API URL to get information about tags on the repository
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    # Whether the repository is private
    boolean 'private;
    # A template for the API URL to list the contributors to the repository
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    # A template for the API URL to get information about notifications on the repository
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    # The repository description
    string? description;
    # The API URL to subscribe to notifications for this repository
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    # A template for the API URL to get information about branches in the repository
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    # The API URL to list the deployments of the repository
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    # A template for the API URL to get information about deploy keys on the repository
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    # A template for the API URL to get information about issue comments on the repository
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    # A template for the API URL to get information about labels of the repository
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # The API URL to list the subscribers on the repository
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    # A template for the API URL to get information about releases on the repository
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    # A template for the API URL to get information about comments on the repository
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # The API URL to list the stargazers on the repository
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    # A unique identifier of the repository
    int id;
    # The user or organization that owns the repository.
    SimpleUser owner;
    # A template for the API URL to download the repository as an archive
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    # A template for the API URL to get information about commits on the repository
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    # A template for the API URL to get information about Git refs of the repository
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    # A template for the API URL to compare two commits or refs
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    # The API URL to list the forks of the repository
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # A template for the API URL to get information about statuses of a commit
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    # A template for the API URL to get information about Git commits of the repository
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    # A template for the API URL to create or retrieve a raw Git blob in the repository
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    # A template for the API URL to get information about Git tags of the repository
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    # The API URL to merge branches in the repository
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    # The API URL to list the downloads on the repository
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    # The URL to get more information about the repository from the GitHub API
    string url;
    # A template for the API URL to get the contents of the repository
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    # A template for the API URL to get information about milestones of the repository
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    # The API URL to list the teams on the repository
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    # Whether the repository is a fork
    boolean 'fork;
    # A template for the API URL to get information about issues on the repository
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # The full, globally unique, name of the repository
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The API URL to list the events of the repository
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # A template for the API URL to get information about issue events on the repository
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    # The API URL to get information about the languages of the repository
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    # The URL to view the repository on GitHub.com
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # A template for the API URL to get information about collaborators of the repository
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    # The name of the repository
    string name;
    # A template for the API URL to get information about pull requests on the repository
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    # The API URL to list the hooks on the repository
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    # A template for the API URL to list the available assignees for issues in the repository
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    # A template for the API URL to create or retrieve a raw Git tree of the repository
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    # The GraphQL identifier of the repository
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Require status checks to pass before merging. Set to null to disable
public type ReposownerrepobranchesbranchprotectionRequiredStatusChecks record {
    # The list of status checks to require in order to merge into this branch
    ReposownerrepobranchesbranchprotectionRequiredStatusChecksChecks[] checks?;
    # **Deprecated**: The list of status checks to require in order to merge into this branch. If any of these checks have recently been set by a particular GitHub App, they will be required to come from that app in future for the branch to merge. Use checks instead of contexts for more fine-grained control
    # 
    # # Deprecated
    @deprecated
    string[] contexts;
    # Require branches to be up to date before merging
    boolean strict;
};

# Represents the Queries record for the operation: apps/list-webhook-deliveries
public type AppsListWebhookDeliveriesQueries record {
    # Used for pagination: the starting delivery from which the page of deliveries is fetched. Refer to the link header for the next and previous page cursors
    string cursor?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Filter to only return redeliveries.
    boolean redelivery?;
};

public type IssueNumberReactionsBody record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the issue
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

# A GitHub user
public type NullableSimpleUser record {
    # API URL template for the user's gists
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    # API URL to list the user's repositories
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    # API URL template to check who the user is following
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    # API URL template for repositories the user has starred
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    # The username of the user
    string login;
    # API URL to list the user's followers
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    # The type of the account
    string 'type;
    # The time the user starred the resource
    @jsondata:Name {value: "starred_at"}
    string starredAt?;
    # API URL for the user
    string url;
    # API URL to list repositories the user is watching
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    # API URL for events received by the user
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    # URL of the user's avatar image
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # API URL template for the user's events
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # URL of the user's GitHub profile page
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The display name of the user
    string? name?;
    # Whether the user is a GitHub site administrator
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    # The unique identifier of the user
    int id;
    # The Gravatar ID of the user
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    # The publicly visible email address of the user
    string? email?;
    # The GraphQL node identifier of the user
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # API URL to list the user's organizations
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
};

public type RepoDeploymentsBody record {
    # The ref to deploy. This can be a branch, tag, or SHA
    string ref;
    # Name for the target deployment environment (e.g., production, staging, qa)
    string environment = "production";
    # Specifies a task to execute (e.g., deploy or deploy:migrations)
    string task = "deploy";
    # The [status](https://docs.github.com/rest/commits/statuses) contexts to verify against commit status checks. If you omit this parameter, GitHub verifies all unique contexts before creating a deployment. To bypass checking entirely, pass an empty array. Defaults to all unique contexts
    @jsondata:Name {value: "required_contexts"}
    string[] requiredContexts?;
    # Optional JSON payload with extra information about the deployment.
    record {}|string payload?;
    # Specifies if the given environment is specific to the deployment and will no longer exist at some point in the future. Default: false
    @jsondata:Name {value: "transient_environment"}
    boolean transientEnvironment = false;
    # Short description of the deployment
    string? description = "";
    # Attempts to automatically merge the default branch into the requested ref, if it's behind the default branch
    @jsondata:Name {value: "auto_merge"}
    boolean autoMerge = true;
    # Specifies if the given environment is one that end-users directly interact with. Default: true when environment is production and false otherwise
    @jsondata:Name {value: "production_environment"}
    boolean productionEnvironment?;
};

# Successful deletion of a code scanning analysis
public type CodeScanningAnalysisDeletion record {
    # Next deletable analysis in chain, without last analysis deletion confirmation
    @jsondata:Name {value: "next_analysis_url"}
    string? nextAnalysisUrl;
    # Next deletable analysis in chain, with last analysis deletion confirmation
    @jsondata:Name {value: "confirm_delete_url"}
    string? confirmDeleteUrl;
};

public type DeploymentBranchPolicyNamePattern record {
    # The name pattern that branches must match in order to deploy to the environment.
    # 
    # Wildcard characters will not match /. For example, to match branches that begin with release/ and contain an additional single slash, use release/*/*.
    # For more information about pattern matching syntax, see the [Ruby File.fnmatch documentation](https://ruby-doc.org/core-2.5.1/File.html#method-c-fnmatch)
    string name;
};

# Represents the Queries record for the operation: activity/list-repos-starred-by-authenticated-user
public type ActivityListReposStarredByAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The property to sort the results by. created means when the repository was starred. updated means when the repository was last pushed to
    "created"|"updated" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

public type PullNumberMergeBody record {
    # Title for the automatic commit message
    @jsondata:Name {value: "commit_title"}
    string commitTitle?;
    # Extra detail to append to automatic commit message
    @jsondata:Name {value: "commit_message"}
    string commitMessage?;
    # SHA that pull request head must match to allow merge
    string sha?;
    # The merge method to use
    @jsondata:Name {value: "merge_method"}
    "merge"|"squash"|"rebase" mergeMethod?;
};

# Details pertaining to the package version that patches this vulnerability
public type DependabotAlertSecurityVulnerabilityFirstPatchedVersion record {|
    # The package version that patches this vulnerability
    string identifier;
|};

# Commits pushed to matching refs must have verified signatures
public type RepositoryRuleRequiredSignatures record {
    # The rule type identifier, always 'required_signatures'.
    "required_signatures" 'type;
};

# Gist History
public type GistHistory record {
    # The date and time the gist version was committed.
    @jsondata:Name {value: "committed_at"}
    string committedAt?;
    # The change status showing additions and deletions for this version.
    @jsondata:Name {value: "change_status"}
    GistHistoryChangeStatus changeStatus?;
    # The user who made this change to the gist.
    NullableSimpleUser? user?;
    # The commit SHA identifier for this version of the gist.
    string version?;
    # The API URL for this specific gist history entry.
    string url?;
};

# Represents the Queries record for the operation: dependabot/list-alerts-for-org
public type DependabotListAlertsForOrgQueries record {
    # A comma-separated list of severities. If specified, only alerts with these severities will be returned.
    # 
    # Can be: low, medium, high, critical
    string severity?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # A comma-separated list of package names. If specified, only alerts for these packages will be returned
    string package?;
    # A comma-separated list of ecosystems. If specified, only alerts for these ecosystems will be returned.
    # 
    # Can be: composer, go, maven, npm, nuget, pip, pub, rubygems, rust
    string ecosystem?;
    # **Deprecated**. The number of results per page (max 100), starting from the last matching result.
    # This parameter must not be used in combination with first.
    # Instead, use per_page in combination with before to fetch the last page of results
    @constraint:Int {minValue: 1, maxValue: 100}
    int last?;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor
    string before?;
    # The scope of the vulnerable dependency. If specified, only alerts with this scope will be returned
    "development"|"runtime" scope?;
    # A comma-separated list of states. If specified, only alerts with these states will be returned.
    # 
    # Can be: auto_dismissed, dismissed, fixed, open
    string state?;
    # The property by which to sort the results.
    # created means when the alert was created.
    # updated means when the alert's state last changed
    "created"|"updated" sort = "created";
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor
    string after?;
    # **Deprecated**. The number of results per page (max 100), starting from the first matching result.
    # This parameter must not be used in combination with last.
    # Instead, use per_page in combination with after to fetch the first page of results
    @constraint:Int {minValue: 1, maxValue: 100}
    int first = 30;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

public type OrganizationSecretScanningAlert record {
    # The type of secret that secret scanning detected
    @jsondata:Name {value: "secret_type"}
    string secretType?;
    # The user who bypassed push protection for this alert.
    @jsondata:Name {value: "push_protection_bypassed_by"}
    NullableSimpleUser? pushProtectionBypassedBy?;
    # The time that push protection was bypassed in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "push_protection_bypassed_at"}
    string? pushProtectionBypassedAt?;
    # The time the alert was created in ISO 8601 format.
    @jsondata:Name {value: "created_at"}
    AlertCreatedAt createdAt?;
    # User-friendly name for the detected secret, matching the secret_type.
    # For a list of built-in patterns, see "[Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns#supported-secrets-for-advanced-security)."
    @jsondata:Name {value: "secret_type_display_name"}
    string secretTypeDisplayName?;
    # The secret that was detected
    string secret?;
    # The repository where the secret was detected.
    SimpleRepository repository?;
    # The resolution status of the secret scanning alert.
    SecretScanningAlertResolution? resolution?;
    # The REST API URL of the secret scanning alert.
    AlertUrl url?;
    # The unique number identifying the alert within the repository.
    AlertNumber number?;
    # The user who resolved the secret scanning alert.
    @jsondata:Name {value: "resolved_by"}
    NullableSimpleUser? resolvedBy?;
    # The time the alert was last updated in ISO 8601 format.
    @jsondata:Name {value: "updated_at"}
    NullableAlertUpdatedAt? updatedAt?;
    # The REST API URL of the code locations for this alert
    @jsondata:Name {value: "locations_url"}
    string locationsUrl?;
    # The comment that was optionally added when this alert was closed
    @jsondata:Name {value: "resolution_comment"}
    string? resolutionComment?;
    # The time that the alert was resolved in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "resolved_at"}
    string? resolvedAt?;
    # The GitHub web URL of the secret scanning alert.
    @jsondata:Name {value: "html_url"}
    AlertHtmlUrl htmlUrl?;
    # Whether push protection was bypassed for the detected secret
    @jsondata:Name {value: "push_protection_bypassed"}
    boolean? pushProtectionBypassed?;
    # The state of the secret scanning alert.
    SecretScanningAlertState state?;
};

# A repository import from an external source
public type Import record {
    # The name of the import step that failed.
    @jsondata:Name {value: "failed_step"}
    string? failedStep?;
    # The error message if the import encountered a failure.
    @jsondata:Name {value: "error_message"}
    string? errorMessage?;
    # The percentage of the push phase that has completed.
    @jsondata:Name {value: "push_percent"}
    int? pushPercent?;
    # The number of large files identified during the import.
    @jsondata:Name {value: "large_files_count"}
    int largeFilesCount?;
    # The URL of the originating repository
    @jsondata:Name {value: "vcs_url"}
    string vcsUrl;
    # The version control system of the source repository.
    string? vcs;
    # The root path of the source version control repository.
    @jsondata:Name {value: "svc_root"}
    string svcRoot?;
    # The REST API URL to retrieve the list of import authors.
    @jsondata:Name {value: "authors_url"}
    string authorsUrl;
    # A status message describing the current state of the import.
    string message?;
    # Available project choices when multiple projects are detected.
    @jsondata:Name {value: "project_choices"}
    ImportProjectChoices[] projectChoices?;
    # The REST API URL of the import.
    string url;
    # The total number of commits imported from the source repository.
    @jsondata:Name {value: "commit_count"}
    int? commitCount?;
    # Whether large files are stored using Git Large File Storage.
    @jsondata:Name {value: "use_lfs"}
    boolean useLfs?;
    # The TFVC project name being imported.
    @jsondata:Name {value: "tfvc_project"}
    string tfvcProject?;
    # The number of authors identified in the import source.
    @jsondata:Name {value: "authors_count"}
    int? authorsCount?;
    # The GitHub web URL of the imported repository.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The percentage of the import phase that has completed.
    @jsondata:Name {value: "import_percent"}
    int? importPercent?;
    # Whether the import source contains large files.
    @jsondata:Name {value: "has_large_files"}
    boolean hasLargeFiles?;
    # A human-readable description of the current import status.
    @jsondata:Name {value: "status_text"}
    string? statusText?;
    # The REST API URL of the destination repository.
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    # The root path of the SVN repository being imported.
    @jsondata:Name {value: "svn_root"}
    string svnRoot?;
    # The total size in kilobytes of large files in the import.
    @jsondata:Name {value: "large_files_size"}
    int largeFilesSize?;
    # The current status of the import process.
    "auth"|"error"|"none"|"detecting"|"choose"|"auth_failed"|"importing"|"mapping"|"waiting_to_push"|"pushing"|"complete"|"setup"|"unknown"|"detection_found_multiple"|"detection_found_nothing"|"detection_needs_auth" status;
};

# Marketplace Purchase
public type MarketplacePurchase record {
    # A pending change to the user's Marketplace subscription.
    @jsondata:Name {value: "marketplace_pending_change"}
    MarketplacePurchaseMarketplacePendingChange? marketplacePendingChange?;
    # The billing email address of the purchasing organization.
    @jsondata:Name {value: "organization_billing_email"}
    string organizationBillingEmail?;
    # The unique identifier of the Marketplace purchaser account.
    int id;
    # The details of the current Marketplace purchase subscription.
    @jsondata:Name {value: "marketplace_purchase"}
    MarketplacePurchaseMarketplacePurchase marketplacePurchase;
    # The type of account making the Marketplace purchase.
    string 'type;
    # The username of the account making the Marketplace purchase.
    string login;
    # The REST API URL of the purchasing account.
    string url;
    # The email address of the account making the Marketplace purchase.
    string? email?;
};

# Codespace default attributes
public type CodespaceDefault record {
    # The path to the devcontainer configuration file for the codespace.
    @jsondata:Name {value: "devcontainer_path"}
    string? devcontainerPath;
    # The geographic location where the codespace will be created.
    string location;
};

public type ThreadIdSubscriptionBody record {
    # Whether to block all notifications from a thread
    boolean ignored = false;
};

public type IssueEventDismissedReview record {
    # The unique identifier of the dismissed pull request review.
    @jsondata:Name {value: "review_id"}
    int reviewId;
    # The state of the review at the time it was dismissed.
    string state;
    # The SHA of the commit at which the review was dismissed.
    @jsondata:Name {value: "dismissal_commit_id"}
    string? dismissalCommitId?;
    # The message provided when the review was dismissed.
    @jsondata:Name {value: "dismissal_message"}
    string? dismissalMessage;
};

# Pull requests let you tell others about changes you've pushed to a repository on GitHub. Once a pull request is sent, interested parties can review the set of changes, discuss potential modifications, and even push follow-up commits if necessary
public type PullRequest record {
    # API URL for the associated issue
    @jsondata:Name {value: "issue_url"}
    string issueUrl;
    # Whether the pull request can be rebased
    boolean? rebaseable?;
    # Hypermedia links related to the pull request.
    @jsondata:Name {value: "_links"}
    PullRequestLinks links;
    # The number of lines deleted in the pull request
    int deletions;
    # URL of the pull request diff
    @jsondata:Name {value: "diff_url"}
    string diffUrl;
    # The date the pull request was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The users assigned to the pull request
    SimpleUser[]? assignees?;
    # The users requested to review the pull request
    @jsondata:Name {value: "requested_reviewers"}
    SimpleUser[]? requestedReviewers?;
    # The user who merged the pull request
    @jsondata:Name {value: "merged_by"}
    NullableSimpleUser? mergedBy;
    # The title of the pull request
    string title;
    # The body text of the pull request
    string? body;
    # The teams requested to review the pull request
    @jsondata:Name {value: "requested_teams"}
    TeamSimple[]? requestedTeams?;
    # The head branch details of the pull request.
    PullRequestHead head;
    # The association of the author with the repository
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # Number uniquely identifying the pull request within its repository
    int number;
    # Whether the pull request can be merged
    boolean? mergeable;
    # URL of the pull request patch
    @jsondata:Name {value: "patch_url"}
    string patchUrl;
    # The date the pull request was last updated
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Indicates whether or not the pull request is a draft
    boolean draft?;
    # API URL for the pull request comments
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # The SHA of the merge commit
    @jsondata:Name {value: "merge_commit_sha"}
    string? mergeCommitSha;
    # API URL template for a pull request review comment
    @jsondata:Name {value: "review_comment_url"}
    string reviewCommentUrl;
    # The reason the pull request conversation was locked
    @jsondata:Name {value: "active_lock_reason"}
    string? activeLockReason?;
    # The unique identifier of the pull request
    int id;
    # State of this Pull Request. Either open or closed
    "open"|"closed" state;
    # Whether the pull request is locked
    boolean locked;
    # The mergeability state of the pull request
    @jsondata:Name {value: "mergeable_state"}
    string mergeableState;
    # API URL for the pull request commits
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    # The date the pull request was closed
    @jsondata:Name {value: "closed_at"}
    string? closedAt;
    # The number of comments on the pull request
    int comments;
    # The number of lines added in the pull request
    int additions;
    # API URL for the pull request commit statuses
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    # The date the pull request was merged
    @jsondata:Name {value: "merged_at"}
    string? mergedAt;
    # Whether the pull request has been merged
    boolean merged;
    # The number of review comments on the pull request
    @jsondata:Name {value: "review_comments"}
    int reviewComments;
    # The auto-merge configuration for the pull request
    @jsondata:Name {value: "auto_merge"}
    AutoMerge? autoMerge;
    # The number of files changed in the pull request
    @jsondata:Name {value: "changed_files"}
    int changedFiles;
    # API URL for the pull request
    string url;
    # The labels associated with the pull request
    PullRequestLabels[] labels;
    # The milestone associated with the pull request.
    NullableMilestone? milestone;
    # URL of the pull request page on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # API URL for the pull request review comments
    @jsondata:Name {value: "review_comments_url"}
    string reviewCommentsUrl;
    # Indicates whether maintainers can modify the pull request
    @jsondata:Name {value: "maintainer_can_modify"}
    boolean maintainerCanModify;
    # The number of commits in the pull request
    int commits;
    # The primary user assigned to the pull request.
    NullableSimpleUser? assignee;
    # The user who created the pull request.
    SimpleUser user;
    # The GraphQL node identifier of the pull request
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The base branch details that the pull request targets.
    PullRequestBase base;
};

# Represents the Queries record for the operation: repos/get-repo-rule-suites
public type ReposGetRepoRuleSuitesQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The name of the ref. Cannot contain wildcard characters. When specified, only rule evaluations triggered for this ref will be returned
    string ref?;
    # The handle for the GitHub user account to filter on. When specified, only rule evaluations triggered by this actor will be returned
    @http:Query {name: "actor_name"}
    string actorName?;
    # Page number of the results to fetch
    int page = 1;
    # The time period to filter by.
    # 
    # For example, day will filter for rule suites that occurred in the past 24 hours, and week will filter for insights that occurred in the past 7 days (168 hours)
    @http:Query {name: "time_period"}
    "hour"|"day"|"week"|"month" timePeriod = "day";
    # The rule results to filter on. When specified, only suites with this result will be returned
    @http:Query {name: "rule_suite_result"}
    "pass"|"fail"|"bypass"|"all" ruleSuiteResult = "all";
};

# Represents the Queries record for the operation: orgs/list-webhook-deliveries
public type OrgsListWebhookDeliveriesQueries record {
    # Used for pagination: the starting delivery from which the page of deliveries is fetched. Refer to the link header for the next and previous page cursors
    string cursor?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Filter to only return redeliveries.
    boolean redelivery?;
};

public type IssueNumberLabelsBody ReposownerrepoissuesissueNumberlabelsOneOf1|ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf12|ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf123|ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf1234|ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf12345;

public type RepositoryRulesetLinksHtml record {
    # The html URL of the ruleset
    string href?;
};

public type DependencyGraphSpdxSbomSbomPackages record {
    # Whether the package's file content has been subjected to
    # analysis during the creation of the SPDX document
    boolean filesAnalyzed?;
    # The license of the package as determined while creating the SPDX document
    string licenseConcluded?;
    # A unique SPDX identifier for the package
    @jsondata:Name {value: "SPDXID"}
    string sPDXID?;
    # The distribution source of this package, or NOASSERTION if this was not determined
    string supplier?;
    # The name of the package
    string name?;
    # External references providing additional information about the package.
    DependencyGraphSpdxSbomSbomExternalRefs[] externalRefs?;
    # The location where the package can be downloaded,
    # or NOASSERTION if this has not been determined
    string downloadLocation?;
    # The license of the package as declared by its author, or NOASSERTION if this information
    # was not available when the SPDX document was created
    string licenseDeclared?;
    # The version of the package. If the package does not have an exact version specified,
    # a version range is given
    string versionInfo?;
};

public type ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf123 record {
    # The list of labels to apply to the issue.
    @constraint:Array {minLength: 1}
    ReposownerrepoissuesissueNumberlabelsLabels[] labels?;
};

# Represents the Queries record for the operation: orgs/list-failed-invitations
public type OrgsListFailedInvitationsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: secret-scanning/list-locations-for-alert
public type SecretScanningListLocationsForAlertQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Pull request metadata if this issue is a pull request
public type IssuePullRequest record {
    # The URL to download the pull request as a patch file.
    @jsondata:Name {value: "patch_url"}
    string? patchUrl;
    # The date and time the pull request was merged.
    @jsondata:Name {value: "merged_at"}
    string? mergedAt?;
    # The GitHub web URL of the associated pull request.
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    # The URL to download the pull request as a diff file.
    @jsondata:Name {value: "diff_url"}
    string? diffUrl;
    # The REST API URL of the associated pull request.
    string? url;
};

# A public SSH key used to sign Git commits
public type SshSigningKey record {
    # The date and time the SSH signing key was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the SSH signing key.
    int id;
    # The descriptive name given to the SSH signing key.
    string title;
    # The public SSH key value used for signing Git commits.
    string 'key;
};

public type Root record {
    # URL template for searching labels across repositories.
    @jsondata:Name {value: "label_search_url"}
    string labelSearchUrl;
    # URL template for listing repositories belonging to an organization.
    @jsondata:Name {value: "organization_repositories_url"}
    string organizationRepositoriesUrl;
    # URL template for listing repositories belonging to a user.
    @jsondata:Name {value: "user_repositories_url"}
    string userRepositoriesUrl;
    # URL template for accessing GitHub Gists.
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    # URL for accessing the authenticated user's notifications.
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    # URL template for listing users the authenticated user follows.
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    # URL for accessing the authenticated user's SSH keys.
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    # URL template for searching GitHub users.
    @jsondata:Name {value: "user_search_url"}
    string userSearchUrl;
    # URL for accessing available Atom RSS feeds.
    @jsondata:Name {value: "feeds_url"}
    string feedsUrl;
    # URL template for searching repository topics.
    @jsondata:Name {value: "topic_search_url"}
    string topicSearchUrl?;
    # URL for accessing gists starred by the authenticated user.
    @jsondata:Name {value: "starred_gists_url"}
    string starredGistsUrl;
    # URL template for accessing a specific user's profile.
    @jsondata:Name {value: "user_url"}
    string userUrl;
    # URL template for accessing a specific repository.
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    # URL for listing organizations the authenticated user belongs to.
    @jsondata:Name {value: "user_organizations_url"}
    string userOrganizationsUrl;
    # HTML URL for managing the current user's OAuth authorizations.
    @jsondata:Name {value: "current_user_authorizations_html_url"}
    string currentUserAuthorizationsHtmlUrl;
    # URL for retrieving available GitHub emojis.
    @jsondata:Name {value: "emojis_url"}
    string emojisUrl;
    # URL template for accessing a specific organization's profile.
    @jsondata:Name {value: "organization_url"}
    string organizationUrl;
    # URL for GitHub's PubSubHubbub hub endpoint.
    @jsondata:Name {value: "hub_url"}
    string hubUrl;
    # URL template for accessing repositories starred by the authenticated user.
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    # URL for listing the authenticated user's followers.
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    # URL for managing the authenticated user's email addresses.
    @jsondata:Name {value: "emails_url"}
    string emailsUrl;
    # URL for checking the current API rate limit status.
    @jsondata:Name {value: "rate_limit_url"}
    string rateLimitUrl;
    # URL template for searching commits across repositories.
    @jsondata:Name {value: "commit_search_url"}
    string commitSearchUrl;
    # URL template for accessing GitHub issues.
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # URL template for listing teams within an organization.
    @jsondata:Name {value: "organization_teams_url"}
    string organizationTeamsUrl;
    # URL for listing all public GitHub Gists.
    @jsondata:Name {value: "public_gists_url"}
    string publicGistsUrl;
    # URL for managing OAuth authorizations.
    @jsondata:Name {value: "authorizations_url"}
    string authorizationsUrl;
    # URL for listing public GitHub events.
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # URL for accessing the authenticated user's profile.
    @jsondata:Name {value: "current_user_url"}
    string currentUserUrl;
    # URL for listing the authenticated user's repositories.
    @jsondata:Name {value: "current_user_repositories_url"}
    string currentUserRepositoriesUrl;
    # URL template for searching issues across repositories.
    @jsondata:Name {value: "issue_search_url"}
    string issueSearchUrl;
    # URL template for searching code across repositories.
    @jsondata:Name {value: "code_search_url"}
    string codeSearchUrl;
    # URL template for searching GitHub repositories.
    @jsondata:Name {value: "repository_search_url"}
    string repositorySearchUrl;
};

public type MembershipsusernameBody record {
    # The role to give the user in the organization. Can be one of:  
    #  * admin - The user will become an owner of the organization.  
    #  * member - The user will become a non-owner member of the organization
    "admin"|"member" role = "member";
};

public type GitTreeTree record {
    # File mode of the tree node, representing permissions and type.
    string mode?;
    # Path of the file or directory within the repository tree.
    string path?;
    # Size in bytes of the file represented by this tree node.
    int size?;
    # Type of the tree node, such as blob, tree, or commit.
    string 'type?;
    # SHA1 checksum hash of the tree node object.
    string sha?;
    # API URL for retrieving this tree node's details.
    string url?;
};

public type RepositoryRulesetConditionsRefName record {
    # Array of ref names or patterns to include. One of these patterns must match for the condition to pass. Also accepts ~DEFAULT_BRANCH to include the default branch or ~ALL to include all branches
    string[] include?;
    # Array of ref names or patterns to exclude. The condition will not pass if any of these patterns match
    string[] exclude?;
};

# If provided, the secret will be used as the key to generate the HMAC hex digest value for [delivery signature headers](https://docs.github.com/webhooks/event-payloads/#delivery-headers)
public type WebhookConfigSecret string;

# A CWE weakness assigned to the advisory
public type DependabotAlertSecurityAdvisoryCwes record {|
    # The unique CWE ID
    @jsondata:Name {value: "cwe_id"}
    string cweId;
    # The short, plain text name of the CWE
    string name;
|};

# Represents the Queries record for the operation: checks/list-for-ref
public type ChecksListForRefQueries record {
    # Filters check runs by their completed_at timestamp. latest returns the most recent check runs
    "latest"|"all" filter = "latest";
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Returns check runs with the specified name
    @http:Query {name: "check_name"}
    string checkName?;
    # Page number of the results to fetch
    int page = 1;
    # Filter check runs by the app that created them, using the app's ID.
    @http:Query {name: "app_id"}
    int appId?;
    # Returns check runs with the specified status
    "queued"|"in_progress"|"completed" status?;
};

# Create a new snapshot of a repository's dependencies
public type Snapshot record {|
    # The repository branch that triggered this snapshot
    @constraint:String {pattern: re `^refs/`}
    string ref;
    # Additional metadata associated with the dependency snapshot.
    Metadata metadata?;
    # The time at which the snapshot was scanned
    string scanned;
    # A collection of package manifests, which are a collection of related dependencies declared in a file or representing a logical group of dependencies
    record {|Manifest...;|} manifests?;
    # Details about the CI job that generated this snapshot.
    SnapshotJob job;
    # The version of the repository snapshot submission
    int version;
    # The commit SHA associated with this dependency snapshot. Maximum length: 40 characters
    @constraint:String {maxLength: 40, minLength: 40}
    string sha;
    # Information about the tool that detected the dependencies.
    SnapshotDetector detector;
|};

# Label Search Result Item
public type LabelSearchResultItem record {
    # Search relevance score for this label result.
    decimal score;
    # Indicates whether this is a default label for new repositories.
    boolean default;
    # Hex color code associated with the label.
    string color;
    # Text match metadata for highlighted search result snippets.
    @jsondata:Name {value: "text_matches"}
    SearchResultTextMatches textMatches?;
    # Name of the label.
    string name;
    # Short description of the label's purpose.
    string? description;
    # Unique numeric identifier of the label.
    int id;
    # API URL for accessing this label.
    string url;
    # Global GraphQL node identifier for the label.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type CommentscommentIdBody2 record {
    # The text of the reply to the review comment
    string body;
};

# Represents the Queries record for the operation: reactions/list-for-team-discussion-comment-legacy
public type ReactionsListForTeamDiscussionCommentLegacyQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to a team discussion comment
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content?;
};

# Actions OIDC subject customization for a repository
public type OidcCustomSubRepo record {
    # Array of unique strings. Each claim key can only contain alphanumeric characters and underscores
    @jsondata:Name {value: "include_claim_keys"}
    string[] includeClaimKeys?;
    # Whether to use the default template or not. If true, the include_claim_keys field is ignored
    @jsondata:Name {value: "use_default"}
    boolean useDefault;
};

# Represents the Queries record for the operation: codespaces/list-for-authenticated-user
public type CodespacesListForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # ID of the Repository to filter on
    @http:Query {name: "repository_id"}
    int repositoryId?;
    # Page number of the results to fetch
    int page = 1;
};

public type CommentscommentIdBody1 record {
    # The contents of the comment
    string body;
};

public type ReposownerrepopullspullNumberreviewsComments record {
    # The relative path to the file that necessitates a review comment
    string path;
    # The side of the diff to place the review comment on.
    string side?;
    # The line number in the file where the comment applies.
    int line?;
    # The first line of the range for a multi-line comment.
    @jsondata:Name {value: "start_line"}
    int startLine?;
    # The position in the diff where you want to add a review comment. Note this value is not the same as the line number in the file. For help finding the position value, read the note below
    int position?;
    # Text of the review comment
    string body;
    # The side of the diff for the start of a multi-line comment.
    @jsondata:Name {value: "start_side"}
    string startSide?;
};

public type CodeScanningOrganizationAlertItems record {
    # URL for listing all instances of this code scanning alert.
    @jsondata:Name {value: "instances_url"}
    AlertInstancesUrl instancesUrl;
    # Timestamp indicating when the code scanning alert was created.
    @jsondata:Name {value: "created_at"}
    AlertCreatedAt createdAt;
    # Optional comment provided when the alert was dismissed.
    @jsondata:Name {value: "dismissed_comment"}
    CodeScanningAlertDismissedComment? dismissedComment?;
    # Details of the code scanning rule that triggered this alert.
    CodeScanningAlertRule rule;
    # The repository where this code scanning alert was detected.
    SimpleRepository repository;
    # API URL for accessing this code scanning alert.
    AlertUrl url;
    # The code analysis tool that generated this alert.
    CodeScanningAnalysisTool tool;
    # Unique number identifying this alert within the repository.
    AlertNumber number;
    # Timestamp indicating when the code scanning alert was last updated.
    @jsondata:Name {value: "updated_at"}
    AlertUpdatedAt updatedAt?;
    # HTML URL for viewing this alert in the GitHub UI.
    @jsondata:Name {value: "html_url"}
    AlertHtmlUrl htmlUrl;
    # Timestamp indicating when the code scanning alert was fixed.
    @jsondata:Name {value: "fixed_at"}
    AlertFixedAt? fixedAt?;
    # The most recent instance of this code scanning alert.
    @jsondata:Name {value: "most_recent_instance"}
    CodeScanningAlertInstance mostRecentInstance;
    # Current state of the code scanning alert.
    CodeScanningAlertState state;
    # The user who dismissed this code scanning alert.
    @jsondata:Name {value: "dismissed_by"}
    NullableSimpleUser? dismissedBy;
    # Reason provided for dismissing this code scanning alert.
    @jsondata:Name {value: "dismissed_reason"}
    CodeScanningAlertDismissedReason? dismissedReason;
    # Timestamp indicating when this code scanning alert was dismissed.
    @jsondata:Name {value: "dismissed_at"}
    AlertDismissedAt? dismissedAt;
};

# Merged branch response message
public type MergedBranchResponse record {
    # Response message indicating the result of the branch merge.
    string message?;
};

public type TemplateRepoGenerateBody record {
    # The organization or person who will own the new repository. To create a new repository in an organization, the authenticated user must be a member of the specified organization
    string owner?;
    # Either true to create a new private repository or false to create a new public one
    boolean 'private = false;
    # Set to true to include the directory structure and files from all branches in the template repository, and not just the default branch. Default: false
    @jsondata:Name {value: "include_all_branches"}
    boolean includeAllBranches = false;
    # The name of the new repository
    string name;
    # A short description of the new repository
    string description?;
};

# Represents the Queries record for the operation: actions/list-selected-repos-for-org-secret
public type ActionsListSelectedReposForOrgSecretQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type RestrictionsUsersBody ReposownerrepobranchesbranchprotectionrestrictionsusersOneOf1|ReposownerrepobranchesbranchprotectionrestrictionsusersreposownerrepobranchesbranchprotectionrestrictionsusersOneOf12;

# Content File
public type ContentFile record {
    # Hypermedia links for navigating related content resources.
    @jsondata:Name {value: "_links"}
    ContentSymlinkLinks links;
    # Git URL of the submodule repository, if applicable.
    @jsondata:Name {value: "submodule_git_url"}
    string submoduleGitUrl?;
    # Type of the content, always 'file' for this schema.
    "file" 'type;
    # Encoding format used for the file content, such as base64.
    string encoding;
    # SHA hash of the file blob.
    string sha;
    # Base64-encoded content of the file.
    string content;
    # API URL for accessing this file's content.
    string url;
    # Symlink target path if the file is a symbolic link.
    string target?;
    # Path to the file within the repository.
    string path;
    # Size of the file in bytes.
    int size;
    # HTML URL for viewing this file in the GitHub UI.
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    # Name of the file.
    string name;
    # Direct URL for downloading the raw file content.
    @jsondata:Name {value: "download_url"}
    string? downloadUrl;
    # API URL for accessing the underlying Git blob object.
    @jsondata:Name {value: "git_url"}
    string? gitUrl;
};

public type CodeScanningAlertRule record {
    # The severity of the alert
    "none"|"note"|"warning"|"error"? severity?;
    # Detailed documentation for the rule as GitHub Flavored Markdown
    string? help?;
    # The security severity of the alert
    @jsondata:Name {value: "security_severity_level"}
    "low"|"medium"|"high"|"critical"? securitySeverityLevel?;
    # description of the rule used to detect the alert
    @jsondata:Name {value: "full_description"}
    string fullDescription?;
    # The name of the rule used to detect the alert
    string name?;
    # A short description of the rule used to detect the alert
    string description?;
    # A unique identifier for the rule used to detect the alert
    string? id?;
    # A link to the documentation for the rule used to detect the alert
    @jsondata:Name {value: "help_uri"}
    string? helpUri?;
    # A set of tags applicable for the rule
    string[]? tags?;
};

# The type of credit the user is receiving
public type SecurityAdvisoryCreditTypes "analyst"|"finder"|"reporter"|"coordinator"|"remediation_developer"|"remediation_reviewer"|"remediation_verifier"|"tool"|"sponsor"|"other";

# Represents the Queries record for the operation: projects/list-for-org
public type ProjectsListForOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Indicates the state of the projects to return
    "open"|"closed"|"all" state = "open";
    # Page number of the results to fetch
    int page = 1;
};

public type ProtectedBranchRequiredStatusCheckChecks record {
    # Name of the required status check context.
    string context;
    # GitHub App ID that must provide this required status check.
    @jsondata:Name {value: "app_id"}
    int? appId;
};

# The slug values for teams
public type ReposownerrepobranchesbranchprotectionrestrictionsteamsreposownerrepobranchesbranchprotectionrestrictionsteamsOneOf12 string[];

# Represents the Queries record for the operation: teams/list-members-in-org
public type TeamsListMembersInOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Filters members returned by their role in the team
    "member"|"maintainer"|"all" role = "all";
    # Page number of the results to fetch
    int page = 1;
};

public type ProtectionRulesProtectionRulesProtectionRulesAnyOf123 record {
    # Unique numeric identifier of the protection rule.
    int id;
    # Type of environment protection rule.
    string 'type;
    # Global GraphQL node identifier for this protection rule.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# The authorization for an OAuth app, GitHub App, or a Personal Access Token
public type Authorization record {
    # The OAuth application associated with this authorization.
    AuthorizationApp app;
    # A note to remind you what the authorization is for.
    string? note;
    # A URL to remind you what the authorization is for.
    @jsondata:Name {value: "note_url"}
    string? noteUrl;
    # The timestamp indicating when the authorization was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The URL of the authorization resource.
    string url;
    # The OAuth access token string.
    string token;
    # The hashed version of the OAuth access token.
    @jsondata:Name {value: "hashed_token"}
    string? hashedToken;
    # The timestamp indicating when the token expires.
    @jsondata:Name {value: "expires_at"}
    string? expiresAt;
    # The timestamp indicating when the authorization was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The scoped installation associated with this authorization.
    NullableScopedInstallation? installation?;
    # The last eight characters of the token for identification.
    @jsondata:Name {value: "token_last_eight"}
    string? tokenLastEight;
    # A unique string to distinguish an authorization from others with the same note.
    string? fingerprint;
    # The unique identifier of the authorization.
    int id;
    # A list of scopes that this authorization is in
    string[]? scopes;
    # The user associated with this authorization.
    NullableSimpleUser? user?;
};

# A description of the machine powering a codespace
public type NullableCodespaceMachine record {
    # How many cores are available to the codespace
    int cpus;
    # The name of the machine
    string name;
    # Whether a prebuild is currently available when creating a codespace for this machine and repository. If a branch was not specified as a ref, the default branch will be assumed. Value will be "null" if prebuilds are not supported or prebuild availability could not be determined. Value will be "none" if no prebuild is available. Latest values "ready" and "in_progress" indicate the prebuild availability status
    @jsondata:Name {value: "prebuild_availability"}
    "none"|"ready"|"in_progress"? prebuildAvailability;
    # The operating system of the machine
    @jsondata:Name {value: "operating_system"}
    string operatingSystem;
    # The display name of the machine includes cores, memory, and storage
    @jsondata:Name {value: "display_name"}
    string displayName;
    # How much memory is available to the codespace
    @jsondata:Name {value: "memory_in_bytes"}
    int memoryInBytes;
    # How much storage is available to the codespace
    @jsondata:Name {value: "storage_in_bytes"}
    int storageInBytes;
};

# Whether GitHub Actions is enabled on the repository
public type ActionsEnabled boolean;

# Represents the Queries record for the operation: repos/list-release-assets
public type ReposListReleaseAssetsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type ReposownerrepobranchesbranchprotectionrestrictionsusersOneOf1 record {
    # The username for users
    string[] users;
};

# Represents the Queries record for the operation: repos/list-comments-for-commit
public type ReposListCommentsForCommitQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Require at least one approving review on a pull request, before merging. Set to null to disable
public type ReposownerrepobranchesbranchprotectionRequiredPullRequestReviews record {
    # Specifies users, teams, or apps allowed to dismiss pull request reviews.
    @jsondata:Name {value: "dismissal_restrictions"}
    ReposownerrepobranchesbranchprotectionRequiredPullRequestReviewsDismissalRestrictions dismissalRestrictions?;
    # Specify the number of reviewers required to approve pull requests. Use a number between 1 and 6 or 0 to not require reviewers
    @jsondata:Name {value: "required_approving_review_count"}
    int requiredApprovingReviewCount?;
    # Blocks merging pull requests until [code owners](https://docs.github.com/articles/about-code-owners/) review them
    @jsondata:Name {value: "require_code_owner_reviews"}
    boolean requireCodeOwnerReviews?;
    # Set to true if you want to automatically dismiss approving reviews when someone pushes a new commit
    @jsondata:Name {value: "dismiss_stale_reviews"}
    boolean dismissStaleReviews?;
    # Specifies users, teams, or apps allowed to bypass required pull request reviews.
    @jsondata:Name {value: "bypass_pull_request_allowances"}
    ReposownerrepobranchesbranchprotectionRequiredPullRequestReviewsBypassPullRequestAllowances bypassPullRequestAllowances?;
    # Whether the most recent push must be approved by someone other than the person who pushed it. Default: false
    @jsondata:Name {value: "require_last_push_approval"}
    boolean requireLastPushApproval = false;
};

# Represents the Queries record for the operation: dependabot/list-alerts-for-repo
public type DependabotListAlertsForRepoQueries record {
    # A comma-separated list of severities. If specified, only alerts with these severities will be returned.
    # 
    # Can be: low, medium, high, critical
    string severity?;
    # The number of results per page (max 100)
    # 
    # # Deprecated
    @http:Query {name: "per_page"}
    @deprecated
    int perPage = 30;
    # A comma-separated list of package names. If specified, only alerts for these packages will be returned
    string package?;
    # A comma-separated list of ecosystems. If specified, only alerts for these ecosystems will be returned.
    # 
    # Can be: composer, go, maven, npm, nuget, pip, pub, rubygems, rust
    string ecosystem?;
    # **Deprecated**. The number of results per page (max 100), starting from the last matching result.
    # This parameter must not be used in combination with first.
    # Instead, use per_page in combination with before to fetch the last page of results
    @constraint:Int {minValue: 1, maxValue: 100}
    int last?;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor
    string before?;
    # A comma-separated list of full manifest paths. If specified, only alerts for these manifests will be returned
    string manifest?;
    # The property by which to sort the results.
    # created means when the alert was created.
    # updated means when the alert's state last changed
    "created"|"updated" sort = "created";
    # The scope of the vulnerable dependency. If specified, only alerts with this scope will be returned
    "development"|"runtime" scope?;
    # A comma-separated list of states. If specified, only alerts with these states will be returned.
    # 
    # Can be: auto_dismissed, dismissed, fixed, open
    string state?;
    # **Deprecated**. Page number of the results to fetch. Use cursor-based pagination with before or after instead
    # 
    # # Deprecated
    @deprecated
    int page = 1;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor
    string after?;
    # **Deprecated**. The number of results per page (max 100), starting from the first matching result.
    # This parameter must not be used in combination with last.
    # Instead, use per_page in combination with after to fetch the first page of results
    @constraint:Int {minValue: 1, maxValue: 100}
    int first = 30;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# A GitHub Classroom classroom
public type SimpleClassroom record {
    # Returns whether classroom is archived or not
    boolean archived;
    # The name of the classroom
    string name;
    # Unique identifier of the classroom
    int id;
    # The url of the classroom on GitHub Classroom
    string url;
};

# Represents the Queries record for the operation: activity/list-public-events-for-user
public type ActivityListPublicEventsForUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Org Hook
public type OrgHook record {
    # The timestamp indicating when the webhook was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The name of the webhook.
    string name;
    # Whether the webhook is active and will receive events.
    boolean active;
    # The timestamp indicating when the webhook was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the webhook.
    int id;
    # The type of the webhook.
    string 'type;
    # The URL used to ping the webhook.
    @jsondata:Name {value: "ping_url"}
    string pingUrl;
    # The configuration settings for the webhook.
    OrgHookConfig config;
    # The URL of the webhook resource.
    string url;
    # The URL to list webhook deliveries.
    @jsondata:Name {value: "deliveries_url"}
    string deliveriesUrl?;
    # The list of events the webhook is subscribed to.
    string[] events;
};

# The name of the status checks
public type ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsreposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf12 string[];

# Represents the Queries record for the operation: activity/list-received-public-events-for-user
public type ActivityListReceivedPublicEventsForUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: apps/list-repos-accessible-to-installation
public type AppsListReposAccessibleToInstallationQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type ColumnscolumnIdBody record {
    # Name of the project column
    string name;
};

public type GistHistoryChangeStatus record {
    # The total number of lines changed in the gist revision.
    int total?;
    # The number of lines added in the gist revision.
    int additions?;
    # The number of lines deleted in the gist revision.
    int deletions?;
};

public type SecurityProductenablementBody record {
    # CodeQL query suite to be used. If you specify the query_suite parameter, the default setup will be configured with this query suite only on all repositories that didn't have default setup already configured. It will not change the query suite on repositories that already have default setup configured.
    # If you don't specify any query_suite in your request, the preferred query suite of the organization will be applied.
    @jsondata:Name {value: "query_suite"}
    "default"|"extended" querySuite?;
};

# An object describing a submodule
public type ContentSubmodule record {
    # The path of the submodule within the repository.
    string path;
    # The size of the submodule content in bytes.
    int size;
    # The Git URL of the submodule repository.
    @jsondata:Name {value: "submodule_git_url"}
    string submoduleGitUrl;
    # Links to related resources for the submodule.
    @jsondata:Name {value: "_links"}
    ContentSymlinkLinks links;
    # The URL to view the submodule on GitHub.
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    # The name of the submodule.
    string name;
    # The URL to download the submodule content.
    @jsondata:Name {value: "download_url"}
    string? downloadUrl;
    # The content type, always 'submodule' for submodule entries.
    "submodule" 'type;
    # The API URL to retrieve the Git object for the submodule.
    @jsondata:Name {value: "git_url"}
    string? gitUrl;
    # The SHA hash identifying the submodule commit.
    string sha;
    # The API URL of the submodule resource.
    string url;
};

# Represents the Queries record for the operation: licenses/get-all-commonly-used
public type LicensesGetAllCommonlyUsedQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Filter to only return featured licenses.
    boolean featured?;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: repos/get-content
public type ReposGetContentQueries record {
    # The name of the commit/branch/tag. Default: the repository’s default branch
    string ref?;
};

public type IssueNumberAssigneesBody record {
    # Usernames of people to assign this issue to. _NOTE: Only users with push access can add assignees to an issue. Assignees are silently ignored otherwise._
    string[] assignees?;
};

# Require all commits be made to a non-target branch and submitted via a pull request before they can be merged
public type RepositoryRulePullRequest record {
    # The rule type, always 'pull_request' for this rule.
    "pull_request" 'type;
    # The parameters configuring the pull request rule requirements.
    RepositoryRulePullRequestParameters parameters?;
};

# Represents the Queries record for the operation: activity/list-stargazers-for-repo
public type ActivityListStargazersForRepoQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type UserEmailsBody1 UseremailsOneOf11|UseremailsuseremailsOneOf112|UseremailsuseremailsuseremailsOneOf1123;

public type StatusCheckPolicyChecks record {
    # The name of the required status check context.
    string context;
    # The ID of the GitHub App that must provide this status check.
    @jsondata:Name {value: "app_id"}
    int? appId;
};

# The status of a deployment
public type DeploymentStatus record {
    # The user who created this deployment status.
    NullableSimpleUser? creator;
    # Deprecated: the URL to associate with this status
    @jsondata:Name {value: "target_url"}
    string targetUrl = "";
    # The URL of the deployment associated with this status.
    @jsondata:Name {value: "deployment_url"}
    string deploymentUrl;
    # A short description of the status
    @constraint:String {maxLength: 140}
    string description = "";
    # The timestamp indicating when the deployment status was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The API URL of the deployment status resource.
    string url;
    # The environment of the deployment that the status is for
    string environment = "";
    # The URL for accessing your environment
    @jsondata:Name {value: "environment_url"}
    string environmentUrl = "";
    # The timestamp indicating when the deployment status was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The GitHub App that triggered this deployment status.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    # The URL to associate with this status
    @jsondata:Name {value: "log_url"}
    string logUrl = "";
    # The unique identifier of the deployment status.
    int id;
    # The state of the status
    "error"|"failure"|"inactive"|"pending"|"success"|"queued"|"in_progress" state;
    # The URL of the repository associated with this deployment status.
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    # The GraphQL node identifier of the deployment status.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Secrets for GitHub Actions for an organization
public type OrganizationActionsSecret record {
    # The timestamp indicating when the secret was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Visibility of a secret
    "all"|"private"|"selected" visibility;
    # The name of the secret
    string name;
    # The URL to list repositories with access to this secret.
    @jsondata:Name {value: "selected_repositories_url"}
    string selectedRepositoriesUrl?;
    # The timestamp indicating when the secret was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
};

# Timeline Committed Event
public type TimelineCommittedEvent record {
    # The person who committed the code to the repository.
    GitCommitCommitter committer;
    # The person who authored the commit.
    GitCommitCommitter author;
    # The URL to view the commit on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The Git tree object associated with this commit.
    TimelineCommittedEventTree tree;
    # The type of timeline event, identifying this as a commit.
    string event?;
    # Message describing the purpose of the commit
    string message;
    # SHA for the commit
    string sha;
    # The API URL of the commit resource.
    string url;
    # The verification details for the commit signature.
    TimelineCommittedEventVerification verification;
    # The GraphQL node identifier of the commit.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The list of parent commits for this commit.
    GitCommitParents[] parents;
};

# Represents the Queries record for the operation: projects/list-columns
public type ProjectsListColumnsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# The name of the package affected by the vulnerability
public type RepositoryAdvisoryVulnerabilityPackage record {
    # The package ecosystem where the vulnerability exists.
    SecurityAdvisoryEcosystems ecosystem;
    # The unique package name within its ecosystem
    string? name;
};

# The GUID of the tool used to generate the code scanning analysis, if provided in the uploaded SARIF data
public type CodeScanningAnalysisToolGuid string?;

public type CollaboratorsusernameBody record {
    # The permission to grant the collaborator
    "read"|"write"|"admin" permission = "write";
};

public type MilestonesmilestoneNumberBody record {
    # A description of the milestone
    string description?;
    # The state of the milestone. Either open or closed
    "open"|"closed" state = "open";
    # The title of the milestone
    string title?;
    # The milestone due date. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "due_on"}
    string dueOn?;
};

# Secrets for GitHub Dependabot for an organization
public type OrganizationDependabotSecretResponse record {
    # The total number of Dependabot secrets in the organization.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of Dependabot secrets for the organization.
    OrganizationDependabotSecret[] secrets;
};

# Generated name and body describing a release
public type ReleaseNotesContent record {
    # The generated name of the release
    string name;
    # The generated body describing the contents of the release supporting markdown formatting
    string body;
};

# **Required when the state is dismissed.** The reason for dismissing or closing the alert
public type CodeScanningAlertDismissedReason "false positive"|"won't fix"|"used in tests"?;

# Represents the Queries record for the operation: actions/list-repo-organization-variables
public type ActionsListRepoOrganizationVariablesQueries record {
    # The number of results per page (max 30)
    @http:Query {name: "per_page"}
    int perPage = 10;
    # Page number of the results to fetch
    int page = 1;
};

# Permission check result for a given devcontainer config
public type CodespacesPermissionsCheckForDevcontainer record {
    # Whether the user has accepted the permissions defined by the devcontainer config
    boolean accepted;
};

# Pages Health Check Status
public type PagesHealthCheck record {
    # The health check details for the alternate domain of the Pages site.
    @jsondata:Name {value: "alt_domain"}
    PagesHealthCheckAltDomain? altDomain?;
    # The health check details for the primary domain of the Pages site.
    PagesHealthCheckDomain domain?;
};

public type ReleaseIdReactionsBody record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the release
    "+1"|"laugh"|"heart"|"hooray"|"rocket"|"eyes" content;
};

# A GitHub Classroom assignment
public type SimpleClassroomAssignment record {
    # The selected editor for the assignment
    string editor;
    # Whether feedback pull request will be created on assignment acceptance
    @jsondata:Name {value: "feedback_pull_requests_enabled"}
    boolean feedbackPullRequestsEnabled;
    # Whether the invitation link is enabled. Visiting an enabled invitation link will accept the assignment
    @jsondata:Name {value: "invitations_enabled"}
    boolean invitationsEnabled;
    # Whether students are admins on created repository on accepted assignment
    @jsondata:Name {value: "students_are_repo_admins"}
    boolean studentsAreRepoAdmins;
    # The number of students that have accepted the assignment
    int accepted;
    # The programming language used in the assignment
    string language;
    # The GitHub Classroom this assignment belongs to.
    SimpleClassroom classroom;
    # Assignment title
    string title;
    # Whether it's a Group Assignment or Individual Assignment
    "individual"|"group" 'type;
    # The link that a student can use to accept the assignment
    @jsondata:Name {value: "invite_link"}
    string inviteLink;
    # The number of students that have submitted the assignment
    int submitted;
    # The maximum allowable teams for the assignment
    @jsondata:Name {value: "max_teams"}
    int? maxTeams?;
    # Whether an accepted assignment creates a public repository
    @jsondata:Name {value: "public_repo"}
    boolean publicRepo;
    # The maximum allowable members per team
    @jsondata:Name {value: "max_members"}
    int? maxMembers?;
    # Unique identifier of the repository
    int id;
    # The number of students that have passed the assignment
    int passing;
    # The time at which the assignment is due
    string? deadline;
    # Sluggified name of the assignment
    string slug;
};

# Check Annotation
public type CheckAnnotation record {
    # The file path to which this annotation applies.
    string path;
    # The starting column number of the annotated code.
    @jsondata:Name {value: "start_column"}
    int? startColumn;
    # The severity level of the annotation (notice, warning, or failure).
    @jsondata:Name {value: "annotation_level"}
    string? annotationLevel;
    # The URL to the annotated file blob on GitHub.
    @jsondata:Name {value: "blob_href"}
    string blobHref;
    # Additional raw details providing extra information for the annotation.
    @jsondata:Name {value: "raw_details"}
    string? rawDetails;
    # The starting line number of the annotated code.
    @jsondata:Name {value: "start_line"}
    int startLine;
    # The title of the annotation.
    string? title;
    # The message describing the annotation.
    string? message;
    # The ending line number of the annotated code.
    @jsondata:Name {value: "end_line"}
    int endLine;
    # The ending column number of the annotated code.
    @jsondata:Name {value: "end_column"}
    int? endColumn;
};

# Represents the Queries record for the operation: actions/list-selected-repos-for-org-variable
public type ActionsListSelectedReposForOrgVariableQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type RuleSuiteRuleSource record {
    # The name of the rule source
    string? name?;
    # The ID of the rule source
    int? id?;
    # The type of rule source
    string 'type?;
};

# A team discussion is a persistent record of a free-form conversation within a team
public type TeamDiscussion record {
    # The HTML-rendered version of the discussion body.
    @jsondata:Name {value: "body_html"}
    string bodyHtml;
    # Whether or not this discussion should be pinned for easy retrieval
    boolean pinned;
    # Whether or not this discussion should be restricted to team members and organization administrators
    boolean 'private;
    # The current version of the body content. If provided, this update operation will be rejected if the given version does not match the latest version on the server
    @jsondata:Name {value: "body_version"}
    string bodyVersion;
    # The user who authored the discussion.
    NullableSimpleUser? author;
    # The timestamp indicating when the discussion was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The main text of the discussion
    string body;
    # The title of the discussion
    string title;
    # The API URL of the discussion resource.
    string url;
    # The unique sequence number of a team discussion
    int number;
    # The timestamp indicating when the discussion was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The total number of comments on the discussion.
    @jsondata:Name {value: "comments_count"}
    int commentsCount;
    # The URL to view the discussion on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The API URL to list comments on the discussion.
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # The timestamp indicating when the discussion was last edited.
    @jsondata:Name {value: "last_edited_at"}
    string? lastEditedAt;
    # The reaction counts for the discussion.
    ReactionRollup reactions?;
    # The API URL of the team that owns the discussion.
    @jsondata:Name {value: "team_url"}
    string teamUrl;
    # The GraphQL node identifier of the discussion.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type ActionsCacheListActionsCaches record {
    # The Git ref associated with the cache entry.
    string ref?;
    # The size of the cache entry in bytes.
    @jsondata:Name {value: "size_in_bytes"}
    int sizeInBytes?;
    # The timestamp indicating when the cache entry was created.
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    # The unique identifier of the cache entry.
    int id?;
    # The timestamp indicating when the cache entry was last accessed.
    @jsondata:Name {value: "last_accessed_at"}
    string lastAccessedAt?;
    # The version identifier of the cache entry.
    string version?;
    # The cache key used to identify the cache entry.
    string 'key?;
};

# The source branch and directory used to publish your Pages site
public type RepoPagesBody1 anydata?;

# Information about a Copilot for Business seat assignment for a user, team, or organization
public type CopilotSeatDetails record {|
    # Timestamp of when the assignee's GitHub Copilot access was last updated, in ISO 8601 format
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    # Last editor that was used by the user for a GitHub Copilot completion
    @jsondata:Name {value: "last_activity_editor"}
    string? lastActivityEditor?;
    # Timestamp of user's last GitHub Copilot activity, in ISO 8601 format
    @jsondata:Name {value: "last_activity_at"}
    string? lastActivityAt?;
    # The team that granted access to GitHub Copilot to the assignee. This will be null if the user was assigned a seat individually
    @jsondata:Name {value: "assigning_team"}
    Team? assigningTeam?;
    # Timestamp of when the assignee was last granted access to GitHub Copilot, in ISO 8601 format
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The pending cancellation date for the seat, in YYYY-MM-DD format. This will be null unless the assignee's Copilot access has been canceled during the current billing cycle. If the seat has been cancelled, this corresponds to the start of the organization's next billing cycle
    @jsondata:Name {value: "pending_cancellation_date"}
    string? pendingCancellationDate?;
    # The assignee that has been granted access to GitHub Copilot
    SimpleUser|Team|Organization assignee;
|};

public type ReposownerrepobranchesbranchprotectionrestrictionsusersreposownerrepobranchesbranchprotectionrestrictionsusersOneOf12 string[];

# Represents the Queries record for the operation: users/list-public-emails-for-authenticated-user
public type UsersListPublicEmailsForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type CommitCommitTree record {
    # The SHA hash of the commit tree object.
    string sha;
    # The API URL of the commit tree resource.
    string url;
};

public type VariablesnameBody record {
    # An array of repository ids that can access the organization variable. You can only provide a list of repository ids when the visibility is set to selected
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds?;
    # The type of repositories in the organization that can access the variable. selected means only the repositories specified by selected_repository_ids can access the variable
    "all"|"private"|"selected" visibility?;
    # The name of the variable
    string name?;
    # The value of the variable
    string value?;
};

# Represents the Queries record for the operation: repos/list-activities
public type ReposListActivitiesQueries record {
    # The GitHub username to use to filter by the actor who performed the activity
    string actor?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The Git reference for the activities you want to list.
    # 
    # The ref for a branch can be formatted either as refs/heads/BRANCH_NAME or BRANCH_NAME, where BRANCH_NAME is the name of your branch
    string ref?;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor
    string before?;
    # The activity type to filter by.
    # 
    # For example, you can choose to filter by "force_push", to see all force pushes to the repository
    @http:Query {name: "activity_type"}
    "push"|"force_push"|"branch_creation"|"branch_deletion"|"pr_merge"|"merge_queue_merge" activityType?;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor
    string after?;
    # The time period to filter by.
    # 
    # For example, day will filter for activity that occurred in the past 24 hours, and week will filter for activity that occurred in the past 7 days (168 hours)
    @http:Query {name: "time_period"}
    "day"|"week"|"month"|"quarter"|"year" timePeriod?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# Metadata for a Git tag
public type GitTag record {
    # The person who created the tag.
    GitTagTagger tagger;
    # Name of the tag
    string tag;
    # Message describing the purpose of the tag
    string message;
    # The SHA hash identifying the tag object.
    string sha;
    # URL for the tag
    string url;
    # The verification details of the tag signature.
    Verification verification?;
    # The GraphQL node identifier of the tag.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The Git object that this tag points to.
    GitTagObject 'object;
};

# Grade for a student or groups GitHub Classroom assignment
public type ClassroomAssignmentGrade record {
    # URL of the assignment
    @jsondata:Name {value: "assignment_url"}
    string assignmentUrl;
    # Timestamp of the student's assignment submission
    @jsondata:Name {value: "submission_timestamp"}
    string submissionTimestamp;
    # Roster identifier of the student
    @jsondata:Name {value: "roster_identifier"}
    string rosterIdentifier;
    # If a group assignment, name of the group the student is in
    @jsondata:Name {value: "group_name"}
    string groupName?;
    # URL of the student's assignment repository
    @jsondata:Name {value: "student_repository_url"}
    string studentRepositoryUrl;
    # Number of points awarded to the student
    @jsondata:Name {value: "points_awarded"}
    int pointsAwarded;
    # GitHub username of the student
    @jsondata:Name {value: "github_username"}
    string githubUsername;
    # Name of the assignment
    @jsondata:Name {value: "assignment_name"}
    string assignmentName;
    # Number of points available for the assignment
    @jsondata:Name {value: "points_available"}
    int pointsAvailable;
    # URL of the starter code for the assignment
    @jsondata:Name {value: "starter_code_url"}
    string starterCodeUrl;
    # Name of the student's assignment repository
    @jsondata:Name {value: "student_repository_name"}
    string studentRepositoryName;
};

# A suite of checks performed on the code of a given code change
public type CheckSuite record {
    # The GitHub App that created this check suite.
    NullableIntegration? app;
    # The commit at the head of the branch being checked.
    @jsondata:Name {value: "head_commit"}
    SimpleCommit headCommit;
    # The name of the branch the check suite is associated with.
    @jsondata:Name {value: "head_branch"}
    string? headBranch;
    # The SHA of the commit before the head commit in the push.
    string? before;
    # The timestamp indicating when the check suite was created.
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    # The repository this check suite belongs to.
    MinimalRepository repository;
    # The SHA of the head commit that is being checked
    @jsondata:Name {value: "head_sha"}
    string headSha;
    # The API URL of the check suite resource.
    string? url;
    # The final conclusion of the check suite after completion.
    "success"|"failure"|"neutral"|"cancelled"|"skipped"|"timed_out"|"action_required"|"startup_failure"|"stale"? conclusion;
    # The pull requests associated with this check suite.
    @jsondata:Name {value: "pull_requests"}
    PullRequestMinimal[]? pullRequests;
    # The timestamp indicating when the check suite was last updated.
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    # The total number of check runs in this check suite.
    @jsondata:Name {value: "latest_check_runs_count"}
    int latestCheckRunsCount;
    # Whether the check suite can be manually rerequested.
    boolean rerequestable?;
    # Whether individual check runs in the suite can be rerequested.
    @jsondata:Name {value: "runs_rerequestable"}
    boolean runsRerequestable?;
    # The unique identifier of the check suite.
    int id;
    # The SHA of the commit after the head commit in the push.
    string? after;
    # The URL to list all check runs in this check suite.
    @jsondata:Name {value: "check_runs_url"}
    string checkRunsUrl;
    # The GraphQL node identifier of the check suite.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The phase of the lifecycle that the check suite is currently in. Statuses of waiting, requested, and pending are reserved for GitHub Actions check suites
    "queued"|"in_progress"|"completed"? status;
};

# Represents the Queries record for the operation: orgs/list-members
public type OrgsListMembersQueries record {
    # Filter members returned in the list. 2fa_disabled means that only members without [two-factor authentication](https://github.com/blog/1614-two-factor-authentication) enabled will be returned. This options is only available for organization owners
    "2fa_disabled"|"all" filter = "all";
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Filter members returned by their role
    "all"|"admin"|"member" role = "all";
    # Page number of the results to fetch
    int page = 1;
};

# The name of the package affected by the vulnerability
public type RepositoryAdvisoryCreatePackage record {
    # The package ecosystem where the vulnerability exists.
    SecurityAdvisoryEcosystems ecosystem;
    # The unique package name within its ecosystem
    string? name?;
};

# Details for the GitHub Security Advisory
public type DependabotAlertSecurityAdvisory record {|
    # A short, plain text summary of the advisory
    @constraint:String {maxLength: 1024}
    string summary;
    # The severity of the advisory
    "low"|"medium"|"high"|"critical" severity;
    # Links to additional advisory information
    DependabotAlertSecurityAdvisoryReferences[] references;
    # Values that identify this advisory among security information sources
    DependabotAlertSecurityAdvisoryIdentifiers[] identifiers;
    # A long-form Markdown-supported description of the advisory
    string description;
    # Details for the advisory pertaining to Common Weakness Enumeration
    DependabotAlertSecurityAdvisoryCwes[] cwes;
    # The unique GitHub Security Advisory ID assigned to the advisory
    @jsondata:Name {value: "ghsa_id"}
    string ghsaId;
    # The time that the advisory was last modified in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The unique CVE ID assigned to the advisory
    @jsondata:Name {value: "cve_id"}
    string? cveId;
    # Vulnerable version range information for the advisory
    DependabotAlertSecurityVulnerability[] vulnerabilities;
    # The time that the advisory was withdrawn in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "withdrawn_at"}
    string? withdrawnAt;
    # The time that the advisory was published in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "published_at"}
    string publishedAt;
    # The CVSS score and vector string for the advisory.
    DependabotAlertSecurityAdvisoryCvss cvss;
|};

# Details of a deployment environment
public type EnvironmentResponse record {
    # The list of deployment environments in the repository.
    Environment[] environments?;
    # The number of environments in this repository
    @jsondata:Name {value: "total_count"}
    int totalCount?;
};

# The total number of seat assignments cancelled
public type CopilotSeatCancelled record {
    # The number of Copilot seat assignments that were cancelled.
    @jsondata:Name {value: "seats_cancelled"}
    int seatsCancelled;
};

# Referrer Traffic
public type ReferrerTraffic record {
    # The URL or domain of the referring site.
    string referrer;
    # The total number of views from this referrer.
    int count;
    # The number of unique visitors from this referrer.
    int uniques;
};

public type RuleSuitesInner record {
    # The result of the rule evaluations for rules with the active enforcement status
    "pass"|"fail"|"bypass" result?;
    # The first commit sha before the push evaluation
    @jsondata:Name {value: "before_sha"}
    string beforeSha?;
    # The ref name that the evaluation ran on
    string ref?;
    # The result of the rule evaluations for rules with the active and evaluate enforcement statuses, demonstrating whether rules would pass or fail if all rules in the rule suite were active
    @jsondata:Name {value: "evaluation_result"}
    "pass"|"fail" evaluationResult?;
    # The timestamp indicating when the push event occurred.
    @jsondata:Name {value: "pushed_at"}
    string pushedAt?;
    # The handle for the GitHub user account
    @jsondata:Name {value: "actor_name"}
    string actorName?;
    # The ID of the repository associated with the rule evaluation
    @jsondata:Name {value: "repository_id"}
    int repositoryId?;
    # The unique identifier of the rule insight
    int id?;
    # The number that identifies the user
    @jsondata:Name {value: "actor_id"}
    int actorId?;
    # The last commit sha in the push evaluation
    @jsondata:Name {value: "after_sha"}
    string afterSha?;
    # The name of the repository without the .git extension
    @jsondata:Name {value: "repository_name"}
    string repositoryName?;
};

# A GitHub user
public type SimpleUser record {
    # API URL template for the user's gists
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    # API URL to list the user's repositories
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    # API URL template to check who the user is following
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    # API URL template for repositories the user has starred
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    # The username of the user
    string login;
    # API URL to list the user's followers
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    # The type of the account
    string 'type;
    # The time the user starred the resource
    @jsondata:Name {value: "starred_at"}
    string starredAt?;
    # API URL for the user
    string url;
    # API URL to list repositories the user is watching
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    # API URL for events received by the user
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    # URL of the user's avatar image
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # API URL template for the user's events
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # URL of the user's GitHub profile page
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The display name of the user
    string? name?;
    # Whether the user is a GitHub site administrator
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    # The unique identifier of the user
    int id;
    # The Gravatar ID of the user
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    # The publicly visible email address of the user
    string? email?;
    # The GraphQL node identifier of the user
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # API URL to list the user's organizations
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
};

public type GistsgistIdBody record {
    # The description of the gist
    string description?;
    # The gist files to be updated, renamed, or deleted. Each key must match the current filename
    # (including extension) of the targeted gist file. For example: hello.py.
    # 
    # To delete a file, set the whole file to null. For example: hello.py : null. The file will also be
    # deleted if the specified object does not contain at least one of content or filename
    record {|GistsgistIdFiles?...;|} files?;
};

# Enable or disable GitHub Advanced Security for the repository.
# 
# For standalone Code Scanning or Secret Protection products, this parameter cannot be used
public type SecurityAndAnalysisAdvancedSecurity record {
    # The enablement status of GitHub Advanced Security for the repository.
    "enabled"|"disabled" status?;
};

public type WorkflowUsageBillableUBUNTU record {
    # The total billable milliseconds used on Ubuntu runners.
    @jsondata:Name {value: "total_ms"}
    int totalMs?;
};

public type BranchRestrictionPolicyTeams record {
    # The parent team of this team, if any.
    string? parent?;
    # The URL to list repositories accessible to this team.
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl?;
    # The URL to list members of this team.
    @jsondata:Name {value: "members_url"}
    string membersUrl?;
    # A description of the team.
    string? description?;
    # The privacy level of the team (secret or closed).
    string privacy?;
    # The default permission level for this team.
    string permission?;
    # The API URL of the team resource.
    string url?;
    # The notification setting for members of this team.
    @jsondata:Name {value: "notification_setting"}
    string notificationSetting?;
    # The URL to view the team on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The name of the team.
    string name?;
    # The unique identifier of the team.
    int id?;
    # The URL-friendly name of the team.
    string slug?;
    # The GraphQL node identifier of the team.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# Represents the Queries record for the operation: repos/list-autolinks
public type ReposListAutolinksQueries record {
    # Page number of the results to fetch
    int page = 1;
};

public type InlineResponse200 ContentDirectory|ContentFile|ContentSymlink|ContentSubmodule;

public type ProtectedBranchRequiredLinearHistory record {|
    # Whether linear history is required for the protected branch.
    boolean enabled;
|};

public type TopicSearchResultItemAliases record {
    # The relationship details between this topic and its alias topic.
    @jsondata:Name {value: "topic_relation"}
    TopicSearchResultItemTopicRelation topicRelation?;
};

# Represents the Queries record for the operation: repos/list-deployments
public type ReposListDeploymentsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The name of the ref. This can be a branch, tag, or SHA
    string ref = "none";
    # The name of the environment that was deployed to (e.g., staging or production)
    string? environment = "none";
    # The name of the task for the deployment (e.g., deploy or deploy:migrations)
    string task = "none";
    # Page number of the results to fetch
    int page = 1;
    # The SHA recorded at creation time
    string sha = "none";
};

public type ContentSymlinkLinks record {
    # API URL for the symlink's Git object.
    string? git;
    # API URL for this symlink content resource.
    string self;
    # URL of the symlink on GitHub.
    string? html;
};

# object containing information about the author
public type ReposownerrepocontentspathAuthor1 record {
    # The name of the author (or committer) of the commit
    string name?;
    # The email of the author (or committer) of the commit
    string email?;
};

# Represents the Queries record for the operation: packages/restore-package-for-user
public type PackagesRestorePackageForUserQueries record {
    # package token
    string token?;
};

# Represents the Queries record for the operation: users/list-social-accounts-for-user
public type UsersListSocialAccountsForUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type WebhookConfigInsecureSsl WebhookConfigInsecureSslOneOf1|WebhookConfigInsecureSslWebhookConfigInsecureSslOneOf12;

public type BranchRestrictionPolicyPermissions record {
    # Permission level granted for repository metadata.
    string metadata?;
    # Permission level granted for a single specified file.
    @jsondata:Name {value: "single_file"}
    string singleFile?;
    # Permission level granted for repository contents.
    string contents?;
    # Permission level granted for repository issues.
    string issues?;
};

# Represents the Queries record for the operation: actions/list-workflow-run-artifacts
public type ActionsListWorkflowRunArtifactsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The name field of an artifact. When specified, only artifacts with this name will be returned
    string name?;
    # Page number of the results to fetch
    int page = 1;
};

public type RepoIssuesBody record {
    # The milestone to associate with the issue.
    string|int? milestone?;
    # Logins for Users to assign to this issue. _NOTE: Only users with push access can set assignees for new issues. Assignees are silently dropped otherwise._
    string[] assignees?;
    # Login for the user that this issue should be assigned to. _NOTE: Only users with push access can set the assignee for new issues. The assignee is silently dropped otherwise. **This field is deprecated.**_
    string? assignee?;
    # The title of the issue
    string|int title;
    # The contents of the issue
    string body?;
    # Labels to associate with this issue. _NOTE: Only users with push access can set labels for new issues. Labels are silently dropped otherwise._
    ReposownerrepoissuesLabels[] labels?;
};

# Pull Request Merge Result
public type PullRequestMergeResult record {
    # Whether the pull request was successfully merged.
    boolean merged;
    # A message describing the result of the merge.
    string message;
    # The SHA of the merge commit.
    string sha;
};

# The time that the alert was auto-dismissed in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
public type AlertAutoDismissedAt string?;

# Represents the Queries record for the operation: issues/list
public type IssuesListQueries record {
    # Indicates which sorts of issues to return. assigned means issues assigned to you. created means issues created by you. mentioned means issues mentioning you. subscribed means issues you're subscribed to updates for. all or repos means all issues you can see, regardless of participation or creation
    "assigned"|"created"|"mentioned"|"subscribed"|"repos"|"all" filter = "assigned";
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # If true, include issues from collaborating repositories.
    boolean collab?;
    # If true, include issues from repositories owned by the authenticated user.
    boolean owned?;
    # Indicates the state of the issues to return
    "open"|"closed"|"all" state = "open";
    # What to sort results by
    "created"|"updated"|"comments" sort = "created";
    # If true, include issues from organization repositories.
    boolean orgs?;
    # Page number of the results to fetch
    int page = 1;
    # A list of comma separated label names. Example: bug,ui,@high
    string labels?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
    # If true, include pull requests in the results.
    boolean pulls?;
};

# Label Search Result Item
public type LabelSearchResultItemResponse record {
    # The total number of labels matching the search query.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # Whether the search results are incomplete due to a timeout.
    @jsondata:Name {value: "incomplete_results"}
    boolean incompleteResults;
    # The list of label search result items.
    LabelSearchResultItem[] items;
};

public type NullableIssueLabels LabelsOneOf13|LabelsLabelsOneOf132;

# GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub
public type Integration record {
    # The user or organization that owns the GitHub app.
    NullableSimpleUser? owner;
    # The number of installations associated with the GitHub app
    @jsondata:Name {value: "installations_count"}
    int installationsCount?;
    # A short description of the GitHub app.
    string? description;
    # The date and time the GitHub app was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The client ID used for OAuth authentication.
    @jsondata:Name {value: "client_id"}
    string clientId?;
    # The external URL linked to the GitHub app.
    @jsondata:Name {value: "external_url"}
    string externalUrl;
    # The date and time the GitHub app was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The set of permissions granted to the GitHub app.
    IntegrationPermissions permissions;
    # The URL of the GitHub app's GitHub profile page.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The name of the GitHub app
    string name;
    # The secret used to secure webhook payloads.
    @jsondata:Name {value: "webhook_secret"}
    string? webhookSecret?;
    # The private key PEM used to sign access token requests.
    string pem?;
    # Unique identifier of the GitHub app
    int id;
    # The client secret used for OAuth authentication.
    @jsondata:Name {value: "client_secret"}
    string clientSecret?;
    # The slug name of the GitHub app
    string slug?;
    # The list of events for the GitHub app
    string[] events;
    # The GraphQL node identifier of the GitHub app.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents the Queries record for the operation: code-scanning/delete-analysis
public type CodeScanningDeleteAnalysisQueries record {
    # Allow deletion if the specified analysis is the last in a set. If you attempt to delete the final analysis in a set without setting this parameter to true, you'll get a 400 response with the message: Analysis is last of its type and deletion may result in the loss of historical alert data. Please specify confirm_delete
    @http:Query {name: "confirm_delete"}
    string? confirmDelete?;
};

# A description of the machine powering a codespace
public type CodespaceMachine record {
    # How many cores are available to the codespace
    int cpus;
    # The name of the machine
    string name;
    # Whether a prebuild is currently available when creating a codespace for this machine and repository. If a branch was not specified as a ref, the default branch will be assumed. Value will be "null" if prebuilds are not supported or prebuild availability could not be determined. Value will be "none" if no prebuild is available. Latest values "ready" and "in_progress" indicate the prebuild availability status
    @jsondata:Name {value: "prebuild_availability"}
    "none"|"ready"|"in_progress"? prebuildAvailability;
    # The operating system of the machine
    @jsondata:Name {value: "operating_system"}
    string operatingSystem;
    # The display name of the machine includes cores, memory, and storage
    @jsondata:Name {value: "display_name"}
    string displayName;
    # How much memory is available to the codespace
    @jsondata:Name {value: "memory_in_bytes"}
    int memoryInBytes;
    # How much storage is available to the codespace
    @jsondata:Name {value: "storage_in_bytes"}
    int storageInBytes;
};

# Choose which status checks must pass before branches can be merged into a branch that matches this rule. When enabled, commits must first be pushed to another branch, then merged or pushed directly to a ref that matches this rule after status checks have passed
public type RepositoryRuleRequiredStatusChecks record {
    # The rule type identifier for required status checks.
    "required_status_checks" 'type;
    # Configuration parameters for the required status checks rule.
    RepositoryRuleRequiredStatusChecksParameters parameters?;
};

# Represents the Queries record for the operation: repos/list-teams
public type ReposListTeamsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: orgs/list-pat-grants
public type OrgsListPatGrantsQueries record {
    # A list of owner usernames to use to filter the results
    @constraint:Array {maxLength: 10}
    string[] owner?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Only show fine-grained personal access tokens used before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    @http:Query {name: "last_used_before"}
    string lastUsedBefore?;
    # Only show fine-grained personal access tokens used after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    @http:Query {name: "last_used_after"}
    string lastUsedAfter?;
    # The permission to use to filter the results
    string permission?;
    # Page number of the results to fetch
    int page = 1;
    # The property by which to sort the results
    "created_at" sort = "created_at";
    # The name of the repository to use to filter the results
    string repository?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

public type NullableScopedInstallation record {
    # Describe whether all repositories have been selected or there's a selection involved
    @jsondata:Name {value: "repository_selection"}
    "all"|"selected" repositorySelection;
    # API URL for listing repositories accessible to this installation.
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
    # The permissions granted to this installation.
    AppPermissions permissions;
    # The path of the single file the installation is restricted to.
    @jsondata:Name {value: "single_file_name"}
    string? singleFileName;
    # Whether the installation has access to multiple single files.
    @jsondata:Name {value: "has_multiple_single_files"}
    boolean hasMultipleSingleFiles?;
    # The list of file paths the installation is restricted to.
    @jsondata:Name {value: "single_file_paths"}
    string[] singleFilePaths?;
    # The user or organization account associated with this installation.
    SimpleUser account;
};

public type ActionsVariable record {
    # The date and time at which the variable was last updated, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The name of the variable
    string name;
    # The date and time at which the variable was created, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The value of the variable
    string value;
};

# Commit
public type Commit record {
    # The GitHub user who committed the commit.
    NullableSimpleUser? committer;
    # Statistics about additions and deletions in the commit.
    CommitStats stats?;
    # The GitHub user who authored the commit.
    NullableSimpleUser? author;
    # URL of the commit page on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # API URL for the commit's comments
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # The raw Git commit data including message and authorship.
    CommitCommit 'commit;
    # The list of files changed in the commit
    DiffEntry[] files?;
    # The SHA hash of the commit
    string sha;
    # API URL for the commit
    string url;
    # The GraphQL node identifier of the commit
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The parent commits of this commit
    CommitParents[] parents;
};

public type ProtectedBranchRequiredPullRequestReviewsDismissalRestrictions record {
    # API URL for listing teams with pull request review dismissal rights.
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    # The list of teams allowed to dismiss pull request reviews.
    Team[] teams;
    # API URL for listing users with pull request review dismissal rights.
    @jsondata:Name {value: "users_url"}
    string usersUrl;
    # API URL for the dismissal restrictions resource.
    string url;
    # The list of users allowed to dismiss pull request reviews.
    SimpleUser[] users;
    # The list of apps allowed to dismiss pull request reviews.
    Integration[] apps?;
};

# Details pertaining to one vulnerable version range for the advisory
public type DependabotAlertSecurityVulnerability record {|
    # The severity of the vulnerability
    "low"|"medium"|"high"|"critical" severity;
    # The earliest version of the package that resolves this vulnerability.
    @jsondata:Name {value: "first_patched_version"}
    DependabotAlertSecurityVulnerabilityFirstPatchedVersion? firstPatchedVersion;
    # The package ecosystem and name affected by this vulnerability.
    DependabotAlertPackage package;
    # Conditions that identify vulnerable versions of this vulnerability's package
    @jsondata:Name {value: "vulnerable_version_range"}
    string vulnerableVersionRange;
|};

# Parameters for a repository ruleset ref name condition
public type RepositoryRulesetConditions record {
    # Conditions specifying which ref names this ruleset applies to.
    @jsondata:Name {value: "ref_name"}
    RepositoryRulesetConditionsRefName refName?;
};

# You can use run_url to track the status of the run. This includes a property status and conclusion.
# You should not rely on this always being an actions workflow run object
public type CodeScanningDefaultSetupUpdateResponse record {
    # ID of the corresponding run
    @jsondata:Name {value: "run_id"}
    int runId?;
    # URL of the corresponding run
    @jsondata:Name {value: "run_url"}
    string runUrl?;
};

# Timeline Commit Commented Event
public type TimelineCommitCommentedEvent record {
    # The list of comments made on the commit.
    CommitComment[] comments?;
    # The type of timeline event.
    string event?;
    # The SHA of the commit that was commented on.
    @jsondata:Name {value: "commit_id"}
    string commitId?;
    # The GraphQL node identifier of this event.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# Represents the Queries record for the operation: repos/list-for-authenticated-user
public type ReposListForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Limit results to repositories with the specified visibility
    "all"|"public"|"private" visibility = "all";
    # Comma-separated list of values. Can include:  
    #  * owner: Repositories that are owned by the authenticated user.  
    #  * collaborator: Repositories that the user has been added to as a collaborator.  
    #  * organization_member: Repositories that the user has access to through being a member of an organization. This includes every repository on every team that the user is on
    string affiliation = "owner,collaborator,organization_member";
    # Only show repositories updated before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string before?;
    # The property to sort the results by
    "created"|"updated"|"pushed"|"full_name" sort = "full_name";
    # Page number of the results to fetch
    int page = 1;
    # Limit results to repositories of the specified type. Will cause a 422 error if used in the same request as **visibility** or **affiliation**
    "all"|"owner"|"public"|"private"|"member" 'type = "all";
    # The order to sort by. Default: asc when using full_name, otherwise desc
    "asc"|"desc" direction?;
    # Only show repositories updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

# Represents the Queries record for the operation: pulls/list-review-comments-for-repo
public type PullsListReviewCommentsForRepoQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The property to sort results by.
    "created"|"updated"|"created_at" sort?;
    # Page number of the results to fetch
    int page = 1;
    # The direction to sort results. Ignored without sort parameter
    "asc"|"desc" direction?;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

# Represents the Queries record for the operation: users/list-public-ssh-keys-for-authenticated-user
public type UsersListPublicSshKeysForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type ApiOverviewDomains record {
    # The list of domains used for GitHub website traffic.
    string[] website?;
    # The list of domains used by GitHub Copilot.
    string[] copilot?;
    # The list of domains used by GitHub Codespaces.
    string[] codespaces?;
    # The list of domains used by GitHub Packages.
    string[] packages?;
};

# A Dependabot alert
public type DependabotAlert record {|
    # The vulnerable dependency associated with this alert.
    DependabotAlertWithRepositoryDependency dependency;
    # The security advisory details for this alert.
    @jsondata:Name {value: "security_advisory"}
    DependabotAlertSecurityAdvisory securityAdvisory;
    # The specific vulnerability details for this alert.
    @jsondata:Name {value: "security_vulnerability"}
    DependabotAlertSecurityVulnerability securityVulnerability;
    # The date and time the alert was created.
    @jsondata:Name {value: "created_at"}
    AlertCreatedAt createdAt;
    # An optional comment associated with the alert's dismissal
    @jsondata:Name {value: "dismissed_comment"}
    string? dismissedComment;
    # The date and time the alert was automatically dismissed.
    @jsondata:Name {value: "auto_dismissed_at"}
    AlertAutoDismissedAt? autoDismissedAt?;
    # The API URL for this Dependabot alert.
    AlertUrl url;
    # The unique number identifying this Dependabot alert in the repository.
    AlertNumber number;
    # The date and time the alert was last updated.
    @jsondata:Name {value: "updated_at"}
    AlertUpdatedAt updatedAt;
    # The URL of the Dependabot alert on GitHub.
    @jsondata:Name {value: "html_url"}
    AlertHtmlUrl htmlUrl;
    # The date and time the alert was fixed.
    @jsondata:Name {value: "fixed_at"}
    AlertFixedAt? fixedAt;
    # The state of the Dependabot alert
    "auto_dismissed"|"dismissed"|"fixed"|"open" state;
    # The user who dismissed the alert.
    @jsondata:Name {value: "dismissed_by"}
    NullableSimpleUser? dismissedBy;
    # The reason that the alert was dismissed
    @jsondata:Name {value: "dismissed_reason"}
    "fix_started"|"inaccurate"|"no_bandwidth"|"not_used"|"tolerable_risk"? dismissedReason;
    # The date and time the alert was dismissed.
    @jsondata:Name {value: "dismissed_at"}
    AlertDismissedAt? dismissedAt;
|};

# Team Organization
public type TeamOrganization record {
    # API URL for listing the organization's repositories
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    # Whether members can create internal repositories
    @jsondata:Name {value: "members_can_create_internal_repositories"}
    boolean membersCanCreateInternalRepositories?;
    # Whether members can create public GitHub Pages sites
    @jsondata:Name {value: "members_can_create_public_pages"}
    boolean membersCanCreatePublicPages?;
    # The URL of the organization's blog or website
    string blog?;
    # The type of the account
    string 'type;
    # API URL template for listing public members
    @jsondata:Name {value: "public_members_url"}
    string publicMembersUrl;
    # The number of private gists
    @jsondata:Name {value: "private_gists"}
    int? privateGists?;
    # The default permission level for organization repositories
    @jsondata:Name {value: "default_repository_permission"}
    string? defaultRepositoryPermission?;
    # The billing email address for the organization
    @jsondata:Name {value: "billing_email"}
    string? billingEmail?;
    # The total disk usage in kilobytes
    @jsondata:Name {value: "disk_usage"}
    int? diskUsage?;
    # The number of collaborators across all repositories
    int? collaborators?;
    # The unique identifier of the organization
    int id;
    # The billing plan associated with the organization.
    TeamOrganizationPlan plan?;
    # Whether members can create private GitHub Pages sites
    @jsondata:Name {value: "members_can_create_private_pages"}
    boolean membersCanCreatePrivatePages?;
    # Whether members can create repositories
    @jsondata:Name {value: "members_can_create_repositories"}
    boolean? membersCanCreateRepositories?;
    # Whether members can create private repositories
    @jsondata:Name {value: "members_can_create_private_repositories"}
    boolean membersCanCreatePrivateRepositories?;
    # The number of public gists in the organization
    @jsondata:Name {value: "public_gists"}
    int publicGists;
    # The number of followers of the organization
    int followers;
    # Whether the organization has projects enabled
    @jsondata:Name {value: "has_organization_projects"}
    boolean hasOrganizationProjects;
    # The number of accounts the organization is following
    int following;
    # URL of the organization's GitHub profile page
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The display name of the organization
    string name?;
    # API URL for listing the organization's webhooks
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    # Whether repositories can have projects enabled
    @jsondata:Name {value: "has_repository_projects"}
    boolean hasRepositoryProjects;
    # API URL template for listing the organization's members
    @jsondata:Name {value: "members_url"}
    string membersUrl;
    # The Twitter username of the organization
    @jsondata:Name {value: "twitter_username"}
    string? twitterUsername?;
    # A short description of the organization
    string? description;
    # The date the organization was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The login name of the organization
    string login;
    # The total number of private repositories
    @jsondata:Name {value: "total_private_repos"}
    int totalPrivateRepos?;
    # The date the organization was last updated
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The types of repositories members can create
    @jsondata:Name {value: "members_allowed_repository_creation_type"}
    string membersAllowedRepositoryCreationType?;
    # Whether members can fork private repositories
    @jsondata:Name {value: "members_can_fork_private_repositories"}
    boolean? membersCanForkPrivateRepositories?;
    # The company name of the organization
    string company?;
    # The number of owned private repositories
    @jsondata:Name {value: "owned_private_repos"}
    int ownedPrivateRepos?;
    # The number of public repositories in the organization
    @jsondata:Name {value: "public_repos"}
    int publicRepos;
    # The publicly visible email of the organization
    string email?;
    # Whether two-factor authentication is required for members
    @jsondata:Name {value: "two_factor_requirement_enabled"}
    boolean? twoFactorRequirementEnabled?;
    # The date the organization was archived
    @jsondata:Name {value: "archived_at"}
    string? archivedAt;
    # Whether the organization's domain is verified
    @jsondata:Name {value: "is_verified"}
    boolean isVerified?;
    # Whether commit sign-off is required for web-based commits
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    # API URL for the organization
    string url;
    # Whether members can create public repositories
    @jsondata:Name {value: "members_can_create_public_repositories"}
    boolean membersCanCreatePublicRepositories?;
    # API URL for listing the organization's issues
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # URL of the organization's avatar image
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # API URL for listing the organization's events
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # Whether members can create GitHub Pages sites
    @jsondata:Name {value: "members_can_create_pages"}
    boolean membersCanCreatePages?;
    # The geographic location of the organization
    string location?;
    # The GraphQL node identifier of the organization
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents the Queries record for the operation: repos/list-custom-deployment-rule-integrations
public type ReposListCustomDeploymentRuleIntegrationsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Permissions requested, categorized by type of permission
public type OrganizationProgrammaticAccessGrantPermissions record {
    # Other miscellaneous permissions granted by the access token.
    record {|string...;|} other?;
    # Organization-level permissions granted by the access token.
    record {|string...;|} organization?;
    # Repository-level permissions granted by the access token.
    record {|string...;|} repository?;
};

# Represents the Queries record for the operation: issues/list-for-authenticated-user
public type IssuesListForAuthenticatedUserQueries record {
    # Indicates which sorts of issues to return. assigned means issues assigned to you. created means issues created by you. mentioned means issues mentioning you. subscribed means issues you're subscribed to updates for. all or repos means all issues you can see, regardless of participation or creation
    "assigned"|"created"|"mentioned"|"subscribed"|"repos"|"all" filter = "assigned";
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Indicates the state of the issues to return
    "open"|"closed"|"all" state = "open";
    # What to sort results by
    "created"|"updated"|"comments" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # A list of comma separated label names. Example: bug,ui,@high
    string labels?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

public type ProjectsprojectIdBody1 record {
    # Whether or not this project can be seen by everyone
    boolean 'private?;
    # The baseline permission that all organization members have on this project
    @jsondata:Name {value: "organization_permission"}
    "read"|"write"|"admin"|"none" organizationPermission?;
    # Name of the project
    string name?;
    # State of the project; either 'open' or 'closed'
    string state?;
    # Body of the project
    string? body?;
};

# Activity
public type Activity record {
    # The user who performed the activity.
    NullableSimpleUser? actor;
    # The full Git reference, formatted as refs/heads/<branch name>
    string ref;
    # The SHA of the commit before the activity
    string before;
    # The type of the activity that was performed
    @jsondata:Name {value: "activity_type"}
    "push"|"force_push"|"branch_deletion"|"branch_creation"|"pr_merge"|"merge_queue_merge" activityType;
    # The unique identifier of the activity.
    int id;
    # The SHA of the commit after the activity
    string after;
    # The GraphQL node identifier of the activity.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The time when the activity occurred
    string timestamp;
};

public type ProjectsprojectIdBody2 record {
    # The permission to grant to the team for this project. Default: the team's permission attribute will be used to determine what permission to grant the team on this project. Note that, if you choose not to pass any parameters, you'll need to set Content-Length to zero when calling this endpoint. For more information, see "[HTTP verbs](https://docs.github.com/rest/overview/resources-in-the-rest-api#http-verbs)."
    "read"|"write"|"admin" permission?;
};

public type RepositoryTemplateRepositoryPermissions record {
    # Whether the user has pull (read) permission on the repository.
    boolean pull?;
    # Whether the user has maintain permission on the repository.
    boolean maintain?;
    # Whether the user has admin permission on the repository.
    boolean admin?;
    # Whether the user has triage permission on the repository.
    boolean triage?;
    # Whether the user has push (write) permission on the repository.
    boolean push?;
};

# The Git commit data
public type CommitCommit record {
    # The number of comments on this commit.
    @jsondata:Name {value: "comment_count"}
    int commentCount;
    # The Git user information for the committer.
    NullableGitUser? committer;
    # The Git user information for the author.
    NullableGitUser? author;
    # The Git tree object associated with this commit.
    CommitCommitTree tree;
    # The commit message.
    string message;
    # The API URL for this commit object.
    string url;
    # The signature verification details for this commit.
    Verification verification?;
};

public type BaseGistFiles record {
    # The name of the gist file.
    string filename?;
    # The size of the gist file in bytes.
    int size?;
    # The detected programming language of the gist file.
    string language?;
    # The MIME type of the gist file.
    string 'type?;
    # The URL to retrieve the raw contents of the gist file.
    @jsondata:Name {value: "raw_url"}
    string rawUrl?;
};

public type HookIdConfigBody record {|
    # The media type used to serialize the webhook payload.
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    # Whether to disable SSL verification for webhook delivery.
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    # The secret used to sign webhook payloads for verification.
    WebhookConfigSecret secret?;
    # The URL to which webhook payloads will be delivered.
    WebhookConfigUrl url?;
|};

# Issue Event
public type IssueEvent record {
    # The team requested for review in this event.
    @jsondata:Name {value: "requested_team"}
    Team requestedTeam?;
    # Details of the dismissed review associated with this event.
    @jsondata:Name {value: "dismissed_review"}
    IssueEventDismissedReview dismissedReview?;
    # The issue associated with this event.
    NullableIssue? issue?;
    # The reason the issue was locked.
    @jsondata:Name {value: "lock_reason"}
    string? lockReason?;
    # The user who performed the assignment action.
    NullableSimpleUser? assigner?;
    # The date and time the event was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The user requested as a reviewer in this event.
    @jsondata:Name {value: "requested_reviewer"}
    NullableSimpleUser? requestedReviewer?;
    # The label added or removed in this event.
    IssueEventLabel label?;
    # The API URL for this issue event.
    string url;
    # The project card associated with this event.
    @jsondata:Name {value: "project_card"}
    IssueEventProjectCard projectCard?;
    # The user who triggered this event.
    NullableSimpleUser? actor;
    # The role of the actor in relation to the repository.
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation?;
    # The API URL of the commit associated with this event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The user who requested the review.
    @jsondata:Name {value: "review_requester"}
    NullableSimpleUser? reviewRequester?;
    # The milestone added or removed in this event.
    IssueEventMilestone milestone?;
    # The GitHub app that performed this event, if applicable.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    # The rename details if the issue was renamed.
    IssueEventRename rename?;
    # The unique identifier of the issue event.
    int id;
    # The user assigned or unassigned in this event.
    NullableSimpleUser? assignee?;
    # The type of event that occurred on the issue.
    string event;
    # The SHA of the commit associated with this event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # The GraphQL node identifier of this event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Timeline Comment Event
public type TimelineCommentEvent record {
    # The API URL of the issue this comment belongs to.
    @jsondata:Name {value: "issue_url"}
    string issueUrl;
    # The HTML-rendered body of the comment.
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    # The plain text body of the comment.
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    # The date and time the comment was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Contents of the issue comment
    string body?;
    # URL for the issue comment
    string url;
    # The user who performed the comment action.
    SimpleUser actor;
    # The role of the commenter in relation to the repository.
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # The date and time the comment was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The GitHub app that created the comment, if applicable.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    # The URL of the comment on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The reaction counts for this comment.
    ReactionRollup reactions?;
    # Unique identifier of the issue comment
    int id;
    # The type of timeline event.
    string event;
    # The user who created the comment.
    SimpleUser user;
    # The GraphQL node identifier of this comment.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Timeline Line Commented Event
public type TimelineLineCommentedEvent record {
    # The list of pull request review comments on this line.
    PullRequestReviewComment[] comments?;
    # The type of timeline event.
    string event?;
    # The GraphQL node identifier of this event.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

public type RepositoryRuleRequiredStatusChecksParameters record {
    # Whether pull requests targeting a matching branch must be tested with the latest code. This setting will not take effect unless at least one status check is enabled
    @jsondata:Name {value: "strict_required_status_checks_policy"}
    boolean strictRequiredStatusChecksPolicy;
    # Status checks that are required
    @jsondata:Name {value: "required_status_checks"}
    RepositoryRuleParamsStatusCheckConfiguration[] requiredStatusChecks;
};

# Represents the Queries record for the operation: actions/list-org-variables
public type ActionsListOrgVariablesQueries record {
    # The number of results per page (max 30)
    @http:Query {name: "per_page"}
    int perPage = 10;
    # Page number of the results to fetch
    int page = 1;
};

public type ProtectedBranchRequiredConversationResolution record {|
    # Whether all conversations must be resolved before merging.
    boolean enabled?;
|};

public type BranchRenameBody record {
    # The new name of the branch
    @jsondata:Name {value: "new_name"}
    string newName;
};

# A GitHub Security Advisory
public type GlobalAdvisory record {|
    # A short summary of the advisory
    @constraint:String {maxLength: 1024}
    string summary;
    # The severity of the advisory
    "critical"|"high"|"medium"|"low"|"unknown" severity;
    # The URL of the advisory's source code
    @jsondata:Name {value: "source_code_location"}
    string? sourceCodeLocation;
    # A list of reference URLs related to the advisory.
    string[]? references;
    # The API URL for the repository advisory
    @jsondata:Name {value: "repository_advisory_url"}
    string? repositoryAdvisoryUrl;
    # A list of identifiers such as CVE or GHSA IDs for the advisory.
    GlobalAdvisoryIdentifiers[]? identifiers;
    # A detailed description of what the advisory entails
    string? description;
    # The type of advisory
    "reviewed"|"unreviewed"|"malware" 'type;
    # The Common Weakness Enumeration (CWE) entries associated with the advisory.
    GlobalAdvisoryCwes[]? cwes;
    # The date and time when the advisory was published in the National Vulnerability Database, in ISO 8601 format.
    # This field is only populated when the advisory is imported from the National Vulnerability Database
    @jsondata:Name {value: "nvd_published_at"}
    string? nvdPublishedAt;
    # The API URL for the advisory
    string url;
    # The GitHub Security Advisory ID
    @jsondata:Name {value: "ghsa_id"}
    string ghsaId;
    # The date and time of when the advisory was last updated, in ISO 8601 format
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The Common Vulnerabilities and Exposures (CVE) ID
    @jsondata:Name {value: "cve_id"}
    string? cveId;
    # The users who contributed to the advisory
    GlobalAdvisoryCredits[]? credits;
    # The URL for the advisory
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The date and time of when the advisory was reviewed by GitHub, in ISO 8601 format
    @jsondata:Name {value: "github_reviewed_at"}
    string? githubReviewedAt;
    # The date and time of when the advisory was withdrawn, in ISO 8601 format
    @jsondata:Name {value: "withdrawn_at"}
    string? withdrawnAt;
    # The products and respective version ranges affected by the advisory
    GlobalAdvisoryVulnerabilities[]? vulnerabilities;
    # The date and time of when the advisory was published, in ISO 8601 format
    @jsondata:Name {value: "published_at"}
    string publishedAt;
    # The CVSS score and vector string for the advisory.
    GlobalAdvisoryCvss? cvss;
|};

public type TeamProjectPermissions record {
    # Whether the team has read permission on the project.
    boolean read;
    # Whether the team has admin permission on the project.
    boolean admin;
    # Whether the team has write permission on the project.
    boolean write;
};

# Represents the Queries record for the operation: teams/list-for-authenticated-user
public type TeamsListForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Configurations related to client authentication
    http:BearerTokenConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    http:ClientHttp1Settings http1Settings = {};
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings = {};
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 30;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with Redirection
    http:FollowRedirects followRedirects?;
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache = {};
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with cookies
    http:CookieConfig cookieConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits = {};
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Provides settings related to client socket configuration
    http:ClientSocketConfig socketConfig = {};
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
    # Enables relaxed data binding on the client side. When enabled, `nil` values are treated as optional, 
    # and absent fields are handled as `nilable` types. Enabled by default.
    boolean laxDataBinding = true;
|};

# The GitHub URL of the alert resource
public type AlertHtmlUrl string;

# Workflow Usage
public type WorkflowUsage record {
    # Billable minutes used by each operating system for this workflow.
    WorkflowUsageBillable billable;
};

public type ReposownerrepogittreesTree record {
    # The file mode; one of 100644 for file (blob), 100755 for executable (blob), 040000 for subdirectory (tree), 160000 for submodule (commit), or 120000 for a blob that specifies the path of a symlink
    "100644"|"100755"|"040000"|"160000"|"120000" mode?;
    # The file referenced in the tree
    string path?;
    # Either blob, tree, or commit
    "blob"|"tree"|"commit" 'type?;
    # The SHA1 checksum ID of the object in the tree. Also called tree.sha. If the value is null then the file will be deleted.  
    #   
    # **Note:** Use either tree.sha or content to specify the contents of the entry. Using both tree.sha and content will return an error
    string? sha?;
    # The content you want this file to have. GitHub will write this blob out and use that SHA for this entry. Use either this, or tree.sha.  
    #   
    # **Note:** Use either tree.sha or content to specify the contents of the entry. Using both tree.sha and content will return an error
    string content?;
};

public type AlertsalertNumberBody record {
    # An optional comment explaining why the alert was dismissed.
    @jsondata:Name {value: "dismissed_comment"}
    CodeScanningAlertDismissedComment? dismissedComment?;
    # The desired state to set for the code scanning alert.
    CodeScanningAlertSetState state;
    # The reason for dismissing or closing the alert.
    @jsondata:Name {value: "dismissed_reason"}
    CodeScanningAlertDismissedReason? dismissedReason?;
};

# A GitHub Actions workflow
public type Workflow record {
    # URL for the workflow's status badge image.
    @jsondata:Name {value: "badge_url"}
    string badgeUrl;
    # The file path of the workflow within the repository.
    string path;
    # The date and time the workflow was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # URL of the workflow's page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The name of the workflow.
    string name;
    # The date and time the workflow was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the workflow.
    int id;
    # The current state of the workflow.
    "active"|"deleted"|"disabled_fork"|"disabled_inactivity"|"disabled_manually" state;
    # The date and time the workflow was deleted.
    @jsondata:Name {value: "deleted_at"}
    string deletedAt?;
    # The API URL for the workflow.
    string url;
    # The GraphQL node identifier of the workflow.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type BranchProtectionRequiredLinearHistory record {
    # Whether required linear history is enabled for the branch.
    boolean enabled?;
};

# The SHA of the commit to which the analysis you are uploading relates
@constraint:String {maxLength: 40, minLength: 40, pattern: re `^[0-9a-fA-F]+$`}
public type CodeScanningAnalysisCommitSha string;

# Represents the Queries record for the operation: dependabot/list-selected-repos-for-org-secret
public type DependabotListSelectedReposForOrgSecretQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Information about the person who is making the commit. By default, committer will use the information set in author. See the author and committer object below for details
public type ReposownerrepogitcommitsCommitter record {
    # Indicates when this commit was authored (or committed). This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string date?;
    # The name of the author (or committer) of the commit
    string name?;
    # The email of the author (or committer) of the commit
    string email?;
};

# Represents the Queries record for the operation: reactions/list-for-commit-comment
public type ReactionsListForCommitCommentQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to a commit comment
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content?;
};

# Organization Full
public type OrganizationFull record {
    # API URL for listing the organization's repositories
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    # Whether members can create internal repositories
    @jsondata:Name {value: "members_can_create_internal_repositories"}
    boolean membersCanCreateInternalRepositories?;
    # An optional URL string to display to contributors who are blocked from pushing a secret
    @jsondata:Name {value: "secret_scanning_push_protection_custom_link"}
    string? secretScanningPushProtectionCustomLink?;
    # Whether members can create public GitHub Pages sites
    @jsondata:Name {value: "members_can_create_public_pages"}
    boolean membersCanCreatePublicPages?;
    # The URL of the organization's blog or website
    string blog?;
    # The type of the account
    string 'type;
    # API URL template for listing public members
    @jsondata:Name {value: "public_members_url"}
    string publicMembersUrl;
    # The number of private gists
    @jsondata:Name {value: "private_gists"}
    int? privateGists?;
    # The default permission level for organization repositories
    @jsondata:Name {value: "default_repository_permission"}
    string? defaultRepositoryPermission?;
    # The billing email address for the organization
    @jsondata:Name {value: "billing_email"}
    string? billingEmail?;
    # The total disk usage in kilobytes
    @jsondata:Name {value: "disk_usage"}
    int? diskUsage?;
    # The number of collaborators on private repositories.
    # 
    # This field may be null if the number of private repositories is over 50,000
    int? collaborators?;
    # The unique identifier of the organization
    int id;
    # Whether secret scanning push protection is automatically enabled for new repositories and repositories
    # transferred to this organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role
    @jsondata:Name {value: "secret_scanning_push_protection_enabled_for_new_repositories"}
    boolean secretScanningPushProtectionEnabledForNewRepositories?;
    # The subscription plan associated with the organization.
    TeamOrganizationPlan plan?;
    # Whether members can create private GitHub Pages sites
    @jsondata:Name {value: "members_can_create_private_pages"}
    boolean membersCanCreatePrivatePages?;
    # Whether members can create repositories
    @jsondata:Name {value: "members_can_create_repositories"}
    boolean? membersCanCreateRepositories?;
    # Whether members can create private repositories
    @jsondata:Name {value: "members_can_create_private_repositories"}
    boolean membersCanCreatePrivateRepositories?;
    # The number of public gists in the organization
    @jsondata:Name {value: "public_gists"}
    int publicGists;
    # The number of followers of the organization
    int followers;
    # Whether the organization has projects enabled
    @jsondata:Name {value: "has_organization_projects"}
    boolean hasOrganizationProjects;
    # The number of accounts the organization is following
    int following;
    # URL of the organization's GitHub profile page
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The display name of the organization
    string name?;
    # API URL for listing the organization's webhooks
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    # Whether dependabot security updates are automatically enabled for new repositories and repositories transferred
    # to this organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role
    @jsondata:Name {value: "dependabot_security_updates_enabled_for_new_repositories"}
    boolean dependabotSecurityUpdatesEnabledForNewRepositories?;
    # Whether GitHub Advanced Security is automatically enabled for new repositories and repositories transferred to
    # this organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role
    @jsondata:Name {value: "dependabot_alerts_enabled_for_new_repositories"}
    boolean dependabotAlertsEnabledForNewRepositories?;
    # Whether repositories can have projects enabled
    @jsondata:Name {value: "has_repository_projects"}
    boolean hasRepositoryProjects;
    # API URL template for listing the organization's members
    @jsondata:Name {value: "members_url"}
    string membersUrl;
    # The Twitter username of the organization
    @jsondata:Name {value: "twitter_username"}
    string? twitterUsername?;
    # A short description of the organization
    string? description;
    # Whether GitHub Advanced Security is enabled for new repositories and repositories transferred to this organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role
    @jsondata:Name {value: "advanced_security_enabled_for_new_repositories"}
    boolean advancedSecurityEnabledForNewRepositories?;
    # The date the organization was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The login name of the organization
    string login;
    # Whether dependency graph is automatically enabled for new repositories and repositories transferred to this
    # organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role
    @jsondata:Name {value: "dependency_graph_enabled_for_new_repositories"}
    boolean dependencyGraphEnabledForNewRepositories?;
    # The total number of private repositories
    @jsondata:Name {value: "total_private_repos"}
    int totalPrivateRepos?;
    # Whether secret scanning is automatically enabled for new repositories and repositories transferred to this
    # organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role
    @jsondata:Name {value: "secret_scanning_enabled_for_new_repositories"}
    boolean secretScanningEnabledForNewRepositories?;
    # The date the organization was last updated
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The types of repositories members can create
    @jsondata:Name {value: "members_allowed_repository_creation_type"}
    string membersAllowedRepositoryCreationType?;
    # Whether members can fork private repositories
    @jsondata:Name {value: "members_can_fork_private_repositories"}
    boolean? membersCanForkPrivateRepositories?;
    # The company name of the organization
    string? company?;
    # The number of owned private repositories
    @jsondata:Name {value: "owned_private_repos"}
    int ownedPrivateRepos?;
    # The number of public repositories in the organization
    @jsondata:Name {value: "public_repos"}
    int publicRepos;
    # The publicly visible email of the organization
    string? email?;
    # Whether two-factor authentication is required for members
    @jsondata:Name {value: "two_factor_requirement_enabled"}
    boolean? twoFactorRequirementEnabled?;
    # The date the organization was archived
    @jsondata:Name {value: "archived_at"}
    string? archivedAt;
    # Whether the organization's domain is verified
    @jsondata:Name {value: "is_verified"}
    boolean isVerified?;
    # Whether commit sign-off is required for web-based commits
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    # API URL for the organization
    string url;
    # Whether members can create public repositories
    @jsondata:Name {value: "members_can_create_public_repositories"}
    boolean membersCanCreatePublicRepositories?;
    # API URL for listing the organization's issues
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # URL of the organization's avatar image
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # API URL for listing the organization's events
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # Whether members can create GitHub Pages sites
    @jsondata:Name {value: "members_can_create_pages"}
    boolean membersCanCreatePages?;
    # The geographic location of the organization
    string location?;
    # Whether a custom link is shown to contributors who are blocked from pushing a secret by push protection
    @jsondata:Name {value: "secret_scanning_push_protection_custom_link_enabled"}
    boolean secretScanningPushProtectionCustomLinkEnabled?;
    # The GraphQL node identifier of the organization
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type PagesSourceHash record {
    # The directory path used as the GitHub Pages source.
    string path;
    # The branch used as the GitHub Pages source.
    string branch;
};

public type MarkdownBody record {
    # The rendering mode
    "markdown"|"gfm" mode = "markdown";
    # The repository context to use when creating references in gfm mode.  For example, setting context to octo-org/octo-repo will change the text #42 into an HTML link to issue 42 in the octo-org/octo-repo repository
    string context?;
    # The Markdown text to render in HTML
    string text;
};

# Represents the Queries record for the operation: migrations/list-for-org
public type MigrationsListForOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Exclude attributes from the API response to improve performance
    ("repositories")[] exclude?;
    # Page number of the results to fetch
    int page = 1;
};

# Key
public type Key record {
    # Whether the SSH key grants read-only access to the repository.
    @jsondata:Name {value: "read_only"}
    boolean readOnly;
    # Whether the SSH key has been verified.
    boolean verified;
    # The date and time the key was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the SSH key.
    int id;
    # The display title of the SSH key.
    string title;
    # The public SSH key value.
    string 'key;
    # The API URL for the SSH key.
    string url;
};

# The type of deployment branch policy for this environment. To allow all branches to deploy, set to null
public type DeploymentBranchPolicySettings record {
    # Whether only branches that match the specified name patterns can deploy to this environment.  If custom_branch_policies is true, protected_branches must be false; if custom_branch_policies is false, protected_branches must be true
    @jsondata:Name {value: "custom_branch_policies"}
    boolean customBranchPolicies;
    # Whether only branches with branch protection rules can deploy to this environment. If protected_branches is true, custom_branch_policies must be false; if protected_branches is false, custom_branch_policies must be true
    @jsondata:Name {value: "protected_branches"}
    boolean protectedBranches;
};

# Represents the Queries record for the operation: activity/list-repo-events
public type ActivityListRepoEventsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Only allow users with bypass permission to create matching refs
public type RepositoryRuleCreation record {
    # The rule type, always 'creation' for this rule.
    "creation" 'type;
};

public type ProjectsprojectIdBody record {
    # The permission to grant to the team for this project. Default: the team's permission attribute will be used to determine what permission to grant the team on this project. Note that, if you choose not to pass any parameters, you'll need to set Content-Length to zero when calling this endpoint. For more information, see "[HTTP verbs](https://docs.github.com/rest/overview/resources-in-the-rest-api#http-verbs)."
    "read"|"write"|"admin" permission?;
};

# User-defined metadata to store domain-specific information limited to 8 keys with scalar values
public type Metadata record {
};

# Short Branch
public type ShortBranch record {
    # Whether the branch has branch protection enabled.
    boolean protected;
    # The name of the branch.
    string name;
    # The latest commit on the branch.
    CommitSearchResultItemCommitTree 'commit;
    # Branch protection settings applied to this branch.
    BranchProtection protection?;
    # The API URL for the branch's protection settings.
    @jsondata:Name {value: "protection_url"}
    string protectionUrl?;
};

# Represents the Queries record for the operation: dependabot/list-org-secrets
public type DependabotListOrgSecretsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: actions/list-jobs-for-workflow-run
public type ActionsListJobsForWorkflowRunQueries record {
    # Filters jobs by their completed_at timestamp. latest returns jobs from the most recent execution of the workflow run. all returns all jobs for a workflow run, including from old executions of the workflow run
    "latest"|"all" filter = "latest";
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# A list of errors found in a repo's CODEOWNERS file
public type CodeownersErrors record {
    # List of errors found in the repository's CODEOWNERS file.
    CodeownersErrorsErrors[] errors;
};

# Issue Event for Issue
public type IssueEventForIssue LabeledIssueEvent|UnlabeledIssueEvent|AssignedIssueEvent|UnassignedIssueEvent|MilestonedIssueEvent|DemilestonedIssueEvent|RenamedIssueEvent|ReviewRequestedIssueEvent|ReviewRequestRemovedIssueEvent|ReviewDismissedIssueEvent|LockedIssueEvent|AddedToProjectIssueEvent|MovedColumnInProjectIssueEvent|RemovedFromProjectIssueEvent|ConvertedNoteToIssueIssueEvent;

public type AssetsassetIdBody record {
    # The file name of the asset
    string name?;
    # An alternate short description of the asset. Used in place of the filename
    string label?;
    # The state of the release asset.
    string state?;
};

# Represents the Queries record for the operation: activity/list-repos-watched-by-user
public type ActivityListReposWatchedByUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type RepoLabelsBody record {
    # The [hexadecimal color code](http://www.color-hex.com/) for the label, without the leading #
    string color?;
    # The name of the label. Emoji can be added to label names, using either native emoji or colon-style markup. For example, typing :strawberry: will render the emoji ![:strawberry:](https://github.githubassets.com/images/icons/emoji/unicode/1f353.png ":strawberry:"). For a full list of available emoji and codes, see "[Emoji cheat sheet](https://github.com/ikatyang/emoji-cheat-sheet)."
    string name;
    # A short description of the label. Must be 100 characters or fewer
    string description?;
};

# Configuration object of the webhook
public type WebhookConfig record {
    # The media type used to serialize the payload of the webhook.
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    # Whether SSL verification is skipped when delivering payloads.
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    # The shared secret used to generate the HMAC signature of webhook payloads.
    WebhookConfigSecret secret?;
    # The URL to which webhook payloads are delivered.
    WebhookConfigUrl url?;
};

# Represents the Queries record for the operation: repos/get-views
public type ReposGetViewsQueries record {
    # The time frame to display results for
    "day"|"week" per = "day";
};

# Represents the Queries record for the operation: users/list
public type UsersListQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # A user ID. Only return users with an ID greater than this ID
    int since?;
};

# State of a code scanning alert
public type CodeScanningAlertStateQuery "open"|"closed"|"dismissed"|"fixed";

public type CodespaceRuntimeConstraints record {
    # The privacy settings a user can select from when forwarding a port
    @jsondata:Name {value: "allowed_port_privacy_settings"}
    string[]? allowedPortPrivacySettings?;
};

public type SecretssecretNameBody record {
    # An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the visibility is set to selected. You can manage the list of selected repositories using the [List selected repositories for an organization secret](https://docs.github.com/rest/actions/secrets#list-selected-repositories-for-an-organization-secret), [Set selected repositories for an organization secret](https://docs.github.com/rest/actions/secrets#set-selected-repositories-for-an-organization-secret), and [Remove selected repository from an organization secret](https://docs.github.com/rest/actions/secrets#remove-selected-repository-from-an-organization-secret) endpoints
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds?;
    # Which type of organization repositories have access to the organization secret. selected means only the repositories specified by selected_repository_ids can access the secret
    "all"|"private"|"selected" visibility;
    # ID of the key you used to encrypt the secret
    @jsondata:Name {value: "key_id"}
    string keyId?;
    # Value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get an organization public key](https://docs.github.com/rest/actions/secrets#get-an-organization-public-key) endpoint
    @jsondata:Name {value: "encrypted_value"}
    string encryptedValue?;
};

# Groups of organization members that gives permissions on specified repositories
public type Team record {
    # The parent team of this team, if nested.
    NullableTeamSimple? parent;
    # The API URL for listing repositories this team has access to.
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
    # The API URL template for listing team members.
    @jsondata:Name {value: "members_url"}
    string membersUrl;
    # A short description of the team.
    string? description;
    # The privacy level of the team, either secret or visible.
    string privacy?;
    # The default permission level for the team on its repositories.
    string permission;
    # The API URL for the team.
    string url;
    # The notification setting the team has chosen for its members.
    @jsondata:Name {value: "notification_setting"}
    string notificationSetting?;
    # The permissions the team has on its repositories.
    TeamPermissions permissions?;
    # The URL of the team's page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The name of the team.
    string name;
    # The unique identifier of the team.
    int id;
    # The URL-friendly identifier of the team.
    string slug;
    # The GraphQL node identifier of the team.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# A GitHub organization
public type SimpleClassroomOrganization record {
    # URL of the organization's avatar image.
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # URL of the organization's GitHub profile page.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The display name of the organization.
    string? name;
    # The unique identifier of the organization.
    int id;
    # The login name of the organization.
    string login;
    # The GraphQL node identifier of the organization.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents the Queries record for the operation: actions/get-workflow-run
public type ActionsGetWorkflowRunQueries record {
    # If true pull requests are omitted from the response (empty array)
    @http:Query {name: "exclude_pull_requests"}
    boolean excludePullRequests = false;
};

public type SnapshotJob record {|
    # Correlator provides a key that is used to group snapshots submitted over time. Only the "latest" submitted snapshot for a given combination of job.correlator and detector.name will be considered when calculating a repository's current dependencies. Correlator should be as unique as it takes to distinguish all detection runs for a given "wave" of CI workflow you run. If you're using GitHub Actions, a good default value for this could be the environment variables GITHUB_WORKFLOW and GITHUB_JOB concatenated together. If you're using a build matrix, then you'll also need to add additional key(s) to distinguish between each submission inside a matrix variation
    string correlator;
    # The url for the job
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The external ID of the job
    string id;
|};

public type TeamsteamIdBody record {
    # The ID of a team to set as the parent team
    @jsondata:Name {value: "parent_team_id"}
    int? parentTeamId?;
    # The name of the team
    string name;
    # The description of the team
    string description?;
    # The level of privacy this team should have. Editing teams without specifying this parameter leaves privacy intact. The options are:  
    # **For a non-nested team:**  
    #  * secret - only visible to organization owners and members of this team.  
    #  * closed - visible to all members of this organization.  
    # **For a parent or child team:**  
    #  * closed - visible to all members of this organization
    "secret"|"closed" privacy?;
    # **Deprecated**. The permission that new repositories will be added to the team with when none is specified
    "pull"|"push"|"admin" permission = "pull";
    # The notification setting the team has chosen. Editing teams without specifying this parameter leaves notification_setting intact. The options are: 
    #  * notifications_enabled - team members receive notifications when the team is @mentioned.  
    #  * notifications_disabled - no one receives notifications
    @jsondata:Name {value: "notification_setting"}
    "notifications_enabled"|"notifications_disabled" notificationSetting?;
};

# Represents the Queries record for the operation: codespaces/list-secrets-for-authenticated-user
public type CodespacesListSecretsForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Only allow users with bypass permissions to delete matching refs
public type RepositoryRuleDeletion record {
    # The rule type, always 'deletion' for this rule.
    "deletion" 'type;
};

# Represents the Queries record for the operation: actions/list-workflow-runs
public type ActionsListWorkflowRunsQueries record {
    # Returns someone's workflow runs. Use the login for the user who created the push associated with the check suite or workflow run
    string actor?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Returns workflow runs with the check_suite_id that you specify
    @http:Query {name: "check_suite_id"}
    int checkSuiteId?;
    # Returns workflow runs created within the given date-time range. For more information on the syntax, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    string created?;
    # If true pull requests are omitted from the response (empty array)
    @http:Query {name: "exclude_pull_requests"}
    boolean excludePullRequests = false;
    # Page number of the results to fetch
    int page = 1;
    # Returns workflow run triggered by the event you specify. For example, push, pull_request or issue. For more information, see "[Events that trigger workflows](https://docs.github.com/actions/automating-your-workflow-with-github-actions/events-that-trigger-workflows)."
    string event?;
    # Returns workflow runs associated with a branch. Use the name of the branch of the push
    string branch?;
    # Only returns workflow runs that are associated with the specified head_sha
    @http:Query {name: "head_sha"}
    string headSha?;
    # Returns workflow runs with the check run status or conclusion that you specify. For example, a conclusion can be success or a status can be in_progress. Only GitHub can set a status of waiting or requested
    "completed"|"action_required"|"cancelled"|"failure"|"neutral"|"skipped"|"stale"|"success"|"timed_out"|"in_progress"|"queued"|"requested"|"waiting"|"pending" status?;
};

# Porter Author
public type PorterAuthor record {
    # The author's name as it appears in the remote source repository.
    @jsondata:Name {value: "remote_name"}
    string remoteName;
    # The author's identifier in the remote source repository.
    @jsondata:Name {value: "remote_id"}
    string remoteId;
    # The API URL for updating this author during import.
    @jsondata:Name {value: "import_url"}
    string importUrl;
    # The mapped GitHub name for the author.
    string name;
    # The unique identifier of the porter author.
    int id;
    # The mapped GitHub email address for the author.
    string email;
    # The API URL for this porter author resource.
    string url;
};

public type UserSocialAccountsBody1 record {
    # Full URLs for the social media profiles to delete
    @jsondata:Name {value: "account_urls"}
    string[] accountUrls;
};

# Reactions to conversations provide a way to help people express their feelings more simply and effectively
public type Reaction record {
    # The date and time the reaction was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the reaction.
    int id;
    # The user who created the reaction.
    NullableSimpleUser? user;
    # The reaction to use
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
    # The GraphQL node identifier of the reaction.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type SecurityAndAnalysisSecretScanningPushProtection record {
    # Whether secret scanning push protection is enabled or disabled.
    "enabled"|"disabled" status?;
};

# A collection of related issues and pull requests
public type NullableMilestone record {
    # The user who created the milestone.
    NullableSimpleUser? creator;
    # The date the milestone was closed
    @jsondata:Name {value: "closed_at"}
    string? closedAt;
    # A description of the milestone
    string? description;
    # The date the milestone was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The title of the milestone
    string title;
    # The number of closed issues in the milestone
    @jsondata:Name {value: "closed_issues"}
    int closedIssues;
    # API URL for the milestone
    string url;
    # The due date for the milestone
    @jsondata:Name {value: "due_on"}
    string? dueOn;
    # API URL for issues with this milestone
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # The number of the milestone
    int number;
    # The date the milestone was last updated
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # URL of the milestone page on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The unique identifier of the milestone
    int id;
    # The state of the milestone
    "open"|"closed" state = "open";
    # The number of open issues in the milestone
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    # The GraphQL node identifier of the milestone
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Pull Request Review Comments are comments on a portion of the Pull Request's diff
public type PullRequestReviewComment record {
    # The comment body rendered as HTML.
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    # The SHA of the original commit to which the comment applies
    @jsondata:Name {value: "original_commit_id"}
    string originalCommitId;
    # Hypermedia links related to the pull request review comment.
    @jsondata:Name {value: "_links"}
    PullRequestReviewCommentLinks links;
    # The comment body rendered as plain text.
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    # The comment ID to reply to
    @jsondata:Name {value: "in_reply_to_id"}
    int inReplyToId?;
    # The line of the blob to which the comment applies. The last line of the range for a multi-line comment
    int line?;
    # The diff of the line that the comment refers to
    @jsondata:Name {value: "diff_hunk"}
    string diffHunk;
    # The date and time the comment was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The first line of the range for a multi-line comment
    @jsondata:Name {value: "start_line"}
    int? startLine?;
    # The text of the comment
    string body;
    # The commenter's association with the repository.
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # The relative path of the file to which the comment applies
    string path;
    # The index of the original line in the diff to which the comment applies. This field is deprecated; use original_line instead
    @jsondata:Name {value: "original_position"}
    int originalPosition?;
    # The date and time the comment was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The ID of the pull request review to which the comment belongs
    @jsondata:Name {value: "pull_request_review_id"}
    int? pullRequestReviewId;
    # The ID of the pull request review comment
    int id;
    # The side of the diff to which the comment applies. The side of the last line of the range for a multi-line comment
    "LEFT"|"RIGHT" side = "RIGHT";
    # The level at which the comment is targeted, can be a diff line or a file
    @jsondata:Name {value: "subject_type"}
    "line"|"file" subjectType?;
    # URL for the pull request that the review comment belongs to
    @jsondata:Name {value: "pull_request_url"}
    string pullRequestUrl;
    # URL for the pull request review comment
    string url;
    # The side of the first line of the range for a multi-line comment
    @jsondata:Name {value: "start_side"}
    "LEFT"|"RIGHT"? startSide = "RIGHT";
    # The line of the blob to which the comment applies. The last line of the range for a multi-line comment
    @jsondata:Name {value: "original_line"}
    int originalLine?;
    # The first line of the range for a multi-line comment
    @jsondata:Name {value: "original_start_line"}
    int? originalStartLine?;
    # HTML URL for the pull request review comment
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Reaction rollup totals for the pull request review comment.
    ReactionRollup reactions?;
    # The line index in the diff to which the comment applies. This field is deprecated; use line instead
    int position?;
    # The SHA of the commit to which the comment applies
    @jsondata:Name {value: "commit_id"}
    string commitId;
    # The user who created the pull request review comment.
    SimpleUser user;
    # The node ID of the pull request review comment
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# The time that the alert was last updated in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
public type NullableAlertUpdatedAt string?;

public type ProtectedBranchRequiredPullRequestReviewsBypassPullRequestAllowances record {
    # Teams allowed to bypass required pull request reviews.
    Team[] teams;
    # Users allowed to bypass required pull request reviews.
    SimpleUser[] users;
    # Apps allowed to bypass required pull request reviews.
    Integration[] apps?;
};

# Gist Commit
public type GistCommit record {
    # The date and time the gist revision was committed.
    @jsondata:Name {value: "committed_at"}
    string committedAt;
    # Statistics about additions, deletions, and total changes in this revision.
    @jsondata:Name {value: "change_status"}
    GistHistoryChangeStatus changeStatus;
    # The commit SHA identifying this version of the gist.
    string version;
    # The user who committed this version of the gist.
    NullableSimpleUser? user;
    # The API URL for this gist commit.
    string url;
};

# Only allow users with bypass permission to update matching refs
public type RepositoryRuleUpdate record {
    # The rule type, always 'update' for this rule.
    "update" 'type;
    # Parameters for the update rule configuration.
    RepositoryRuleUpdateParameters parameters?;
};

# Page Build
public type PageBuild record {
    # The duration of the build in milliseconds.
    int duration;
    # The user who triggered the GitHub Pages build.
    NullableSimpleUser? pusher;
    # The date and time the build was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The SHA of the commit that triggered the build.
    string 'commit;
    # The date and time the build was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Error information if the build failed.
    PageBuildError 'error;
    # The API URL for this page build.
    string url;
    # The current status of the GitHub Pages build.
    string status;
};

# Event
public type Event record {
    # The user or application that triggered the event.
    Actor actor;
    # Whether the event is publicly visible.
    boolean 'public;
    # The organization associated with the event, if applicable.
    Actor org?;
    # The event-specific payload data.
    EventPayload payload;
    # The repository where the event occurred.
    EventRepo repo;
    # The date and time the event was created.
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    # The unique identifier of the event.
    string id;
    # The type of GitHub event.
    string? 'type;
};

# Represents the Queries record for the operation: issues/list-events-for-timeline
public type IssuesListEventsForTimelineQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: migrations/get-commit-authors
public type MigrationsGetCommitAuthorsQueries record {
    # A user ID. Only return users with an ID greater than this ID
    int since?;
};

# An invocation of a workflow
public type WorkflowRunResponse record {
    # The total number of workflow runs matching the request.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # The list of workflow run objects.
    @jsondata:Name {value: "workflow_runs"}
    WorkflowRun[] workflowRuns;
};

public type PermissionsRepositoriesBody record {
    # List of repository IDs to enable for GitHub Actions
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds;
};

# A repository security advisory
public type RepositoryAdvisory record {|
    # Detailed credit information including credit type for each credited user.
    @jsondata:Name {value: "credits_detailed"}
    RepositoryAdvisoryCredit[]? creditsDetailed;
    # A detailed description of what the advisory entails
    string? description;
    # The date and time of when the advisory was created, in ISO 8601 format
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    # The CWE (Common Weakness Enumeration) entries associated with the advisory.
    GlobalAdvisoryCwes[]? cwes;
    # The date and time of when the advisory was last updated, in ISO 8601 format
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    # Users credited for discovering or fixing the advisory.
    RepositoryAdvisoryCredits[]? credits;
    # The date and time of when the advisory was withdrawn, in ISO 8601 format
    @jsondata:Name {value: "withdrawn_at"}
    string? withdrawnAt;
    # The state of the advisory
    "published"|"closed"|"withdrawn"|"draft"|"triage" state;
    # The date and time of when the advisory was published, in ISO 8601 format
    @jsondata:Name {value: "published_at"}
    string? publishedAt;
    # A list of users that collaborate on the advisory
    @jsondata:Name {value: "collaborating_users"}
    SimpleUser[]? collaboratingUsers;
    # A temporary private fork of the advisory's repository for collaborating on a fix
    @jsondata:Name {value: "private_fork"}
    SimpleRepository? privateFork;
    # A short summary of the advisory
    @constraint:String {maxLength: 1024}
    string summary;
    # The severity of the advisory
    "critical"|"high"|"medium"|"low"? severity;
    # The date and time of when the advisory was closed, in ISO 8601 format
    @jsondata:Name {value: "closed_at"}
    string? closedAt;
    # The author of the advisory
    SimpleUser? author;
    # A list of identifiers such as CVE or GHSA IDs for the advisory.
    GlobalAdvisoryIdentifiers[] identifiers;
    # The API URL for the advisory
    string url;
    # The GitHub Security Advisory ID
    @jsondata:Name {value: "ghsa_id"}
    string ghsaId;
    # The Common Vulnerabilities and Exposures (CVE) ID
    @jsondata:Name {value: "cve_id"}
    string? cveId;
    # A list of teams that collaborate on the advisory
    @jsondata:Name {value: "collaborating_teams"}
    Team[]? collaboratingTeams;
    # The URL for the advisory
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The publisher of the advisory
    SimpleUser? publisher;
    # The packages and version ranges affected by this advisory.
    RepositoryAdvisoryVulnerability[]? vulnerabilities;
    # Submission details if the advisory was submitted by an external reporter.
    RepositoryAdvisorySubmission? submission;
    # The CVSS score and vector string for the advisory.
    GlobalAdvisoryCvss? cvss;
    # A list of only the CWE IDs
    @jsondata:Name {value: "cwe_ids"}
    string[]? cweIds;
|};

public type HookConfigBody record {
    # The media type used to serialize the webhook payload.
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    # Whether SSL verification is skipped when delivering payloads.
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    # The shared secret used to generate the HMAC signature of webhook payloads.
    WebhookConfigSecret secret?;
    # The URL to which webhook payloads are delivered.
    WebhookConfigUrl url?;
};

public type UserMigrationsBody record {
    # Indicates whether metadata should be excluded and only git source should be included for the migration
    @jsondata:Name {value: "exclude_metadata"}
    boolean excludeMetadata?;
    # The list of repository names to include in the migration.
    string[] repositories;
    # Indicates whether the repository git data should be excluded from the migration
    @jsondata:Name {value: "exclude_git_data"}
    boolean excludeGitData?;
    # Do not include attachments in the migration
    @jsondata:Name {value: "exclude_attachments"}
    boolean excludeAttachments?;
    # Do not include releases in the migration
    @jsondata:Name {value: "exclude_releases"}
    boolean excludeReleases?;
    # Indicates whether projects owned by the organization or users should be excluded
    @jsondata:Name {value: "exclude_owner_projects"}
    boolean excludeOwnerProjects?;
    # Indicates whether this should only include organization metadata (repositories array should be empty and will ignore other flags)
    @jsondata:Name {value: "org_metadata_only"}
    boolean orgMetadataOnly = false;
    # Exclude attributes from the API response to improve performance
    ("repositories")[] exclude?;
    # Lock the repositories being migrated at the start of the migration
    @jsondata:Name {value: "lock_repositories"}
    boolean lockRepositories?;
};

# Represents the Queries record for the operation: repos/list-forks
public type ReposListForksQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The sort order. stargazers will sort by star count
    "newest"|"oldest"|"stargazers"|"watchers" sort = "newest";
    # Page number of the results to fetch
    int page = 1;
};

# Organization variable for GitHub Actions
public type OrganizationActionsVariableResponse record {
    # The list of organization-level Actions variables.
    OrganizationActionsVariable[] variables;
    # The total number of organization Actions variables.
    @jsondata:Name {value: "total_count"}
    int totalCount;
};

public type RepoAutolinksBody record {
    # This prefix appended by certain characters will generate a link any time it is found in an issue, pull request, or commit
    @jsondata:Name {value: "key_prefix"}
    string keyPrefix;
    # The URL must contain <num> for the reference number. <num> matches different characters depending on the value of is_alphanumeric
    @jsondata:Name {value: "url_template"}
    string urlTemplate;
    # Whether this autolink reference matches alphanumeric characters. If true, the <num> parameter of the url_template matches alphanumeric characters A-Z (case insensitive), 0-9, and -. If false, this autolink reference only matches numeric characters
    @jsondata:Name {value: "is_alphanumeric"}
    boolean isAlphanumeric = true;
};

# An SSH key granting access to a single repository
public type DeployKey record {
    # Whether the deploy key has read-only access to the repository.
    @jsondata:Name {value: "read_only"}
    boolean readOnly;
    # The username of the user who added the deploy key.
    @jsondata:Name {value: "added_by"}
    string? addedBy?;
    # The timestamp when the deploy key was last used.
    @jsondata:Name {value: "last_used"}
    string? lastUsed?;
    # Whether the deploy key has been verified.
    boolean verified;
    # The timestamp when the deploy key was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the deploy key.
    int id;
    # The display name of the deploy key.
    string title;
    # The public SSH key string.
    string 'key;
    # The API URL for this deploy key.
    string url;
};

# Parameters for a repository ID condition
public type RepositoryRulesetConditionsRepositoryIdTarget record {
    # The repository ID condition parameters for the ruleset.
    @jsondata:Name {value: "repository_id"}
    RepositoryRulesetConditionsRepositoryIdTargetRepositoryId repositoryId;
};

# Code Frequency Stat
public type CodeFrequencyStat int[];

# The configuration for GitHub Pages for a repository
public type Page record {
    # Whether the GitHub Pages site is publicly visible. If set to true, the site is accessible to anyone on the internet. If set to false, the site will only be accessible to users who have at least read access to the repository that published the site
    boolean 'public;
    # The HTTPS certificate associated with the GitHub Pages site.
    @jsondata:Name {value: "https_certificate"}
    PagesHttpsCertificate httpsCertificate?;
    # Whether the Page has a custom 404 page
    @jsondata:Name {value: "custom_404"}
    boolean custom404 = false;
    # The web address the Page can be accessed from
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The Pages site's custom domain
    string? cname;
    # Whether https is enabled on the domain
    @jsondata:Name {value: "https_enforced"}
    boolean httpsEnforced?;
    # The timestamp when a pending domain becomes unverified
    @jsondata:Name {value: "pending_domain_unverified_at"}
    string? pendingDomainUnverifiedAt?;
    # The source branch and directory from which the Pages site is built.
    PagesSourceHash 'source?;
    # The state if the domain is verified
    @jsondata:Name {value: "protected_domain_state"}
    "pending"|"verified"|"unverified"? protectedDomainState?;
    # The process in which the Page will be built
    @jsondata:Name {value: "build_type"}
    "legacy"|"workflow"? buildType?;
    # The API address for accessing this Page resource
    string url;
    # The status of the most recent build of the Page
    "built"|"building"|"errored"? status;
};

public type JitConfig record {
    # The runner associated with this just-in-time configuration.
    Runner runner;
    # The base64 encoded runner configuration
    @jsondata:Name {value: "encoded_jit_config"}
    string encodedJitConfig;
};

# Represents the Queries record for the operation: classroom/list-assignments-for-a-classroom
public type ClassroomListAssignmentsForAClassroomQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: actions/get-actions-cache-usage-by-repo-for-org
public type ActionsGetActionsCacheUsageByRepoForOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type UserGpgKeysBody record {
    # A GPG key in ASCII-armored format
    @jsondata:Name {value: "armored_public_key"}
    string armoredPublicKey;
    # A descriptive name for the new key
    string name?;
};

# Timeline Event
public type TimelineIssueEvents LabeledIssueEvent|UnlabeledIssueEvent|MilestonedIssueEvent|DemilestonedIssueEvent|RenamedIssueEvent|ReviewRequestedIssueEvent|ReviewRequestRemovedIssueEvent|ReviewDismissedIssueEvent|LockedIssueEvent|AddedToProjectIssueEvent|MovedColumnInProjectIssueEvent|RemovedFromProjectIssueEvent|ConvertedNoteToIssueIssueEvent|TimelineCommentEvent|TimelineCrossReferencedEvent|TimelineCommittedEvent|TimelineReviewedEvent|TimelineLineCommentedEvent|TimelineCommitCommentedEvent|TimelineAssignedIssueEvent|TimelineUnassignedIssueEvent|StateChangeIssueEvent;

public type RepoSubscriptionBody record {
    # Determines if notifications should be received from this repository
    boolean subscribed?;
    # Determines if all notifications should be blocked from this repository
    boolean ignored?;
};

public type GlobalAdvisoryCvss record {
    # The CVSS score
    decimal? score;
    # The CVSS vector
    @jsondata:Name {value: "vector_string"}
    string? vectorString;
};

# Represents the Queries record for the operation: security-advisories/list-org-repository-advisories
public type SecurityAdvisoriesListOrgRepositoryAdvisoriesQueries record {
    # The number of advisories to return per page
    @http:Query {name: "per_page"}
    int perPage = 30;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor
    string before?;
    # The property to sort the results by
    "created"|"updated"|"published" sort = "created";
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor
    string after?;
    # Filter by the state of the repository advisories. Only advisories of this state will be returned
    "triage"|"draft"|"published"|"closed" state?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# Represents the Queries record for the operation: issues/list-milestones
public type IssuesListMilestonesQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The state of the milestone. Either open, closed, or all
    "open"|"closed"|"all" state = "open";
    # What to sort results by. Either due_on or completeness
    "due_on"|"completeness" sort = "due_on";
    # Page number of the results to fetch
    int page = 1;
    # The direction of the sort. Either asc or desc
    "asc"|"desc" direction = "asc";
};

# Secrets for a GitHub Codespace
public type CodespacesSecret record {
    # The date and time at which the secret was last updated, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The type of repositories in the organization that the secret is visible to
    "all"|"private"|"selected" visibility;
    # The name of the secret
    string name;
    # The API URL at which the list of repositories this secret is visible to can be retrieved
    @jsondata:Name {value: "selected_repositories_url"}
    string selectedRepositoriesUrl;
    # The date and time at which the secret was created, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "created_at"}
    string createdAt;
};

# A collection of related issues and pull requests
public type Milestone record {
    # The user who created the milestone.
    NullableSimpleUser? creator;
    # The date the milestone was closed
    @jsondata:Name {value: "closed_at"}
    string? closedAt;
    # A description of the milestone
    string? description;
    # The date the milestone was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The title of the milestone
    string title;
    # The number of closed issues in the milestone
    @jsondata:Name {value: "closed_issues"}
    int closedIssues;
    # API URL for the milestone
    string url;
    # The due date for the milestone
    @jsondata:Name {value: "due_on"}
    string? dueOn;
    # API URL for issues with this milestone
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # The number of the milestone
    int number;
    # The date the milestone was last updated
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # URL of the milestone page on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The unique identifier of the milestone
    int id;
    # The state of the milestone
    "open"|"closed" state = "open";
    # The number of open issues in the milestone
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    # The GraphQL node identifier of the milestone
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Stargazer
public type StargazerResponse StargazerResponseAnyOf1|StargazerResponseStargazerResponseAnyOf12;

public type SecretNameRepositoriesBody1 record {
    # An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the visibility is set to selected. You can add and remove individual repositories using the [Set selected repositories for an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#set-selected-repositories-for-an-organization-secret) and [Remove selected repository from an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#remove-selected-repository-from-an-organization-secret) endpoints
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds;
};

public type SecretNameRepositoriesBody2 record {
    # An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the visibility is set to selected. You can add and remove individual repositories using the [Set selected repositories for an organization secret](https://docs.github.com/rest/dependabot/secrets#set-selected-repositories-for-an-organization-secret) and [Remove selected repository from an organization secret](https://docs.github.com/rest/dependabot/secrets#remove-selected-repository-from-an-organization-secret) endpoints
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds;
};

public type SecretNameRepositoriesBody3 record {
    # An array of repository ids for which a codespace can access the secret. You can manage the list of selected repositories using the [List selected repositories for a user secret](https://docs.github.com/rest/codespaces/secrets#list-selected-repositories-for-a-user-secret), [Add a selected repository to a user secret](https://docs.github.com/rest/codespaces/secrets#add-a-selected-repository-to-a-user-secret), and [Remove a selected repository from a user secret](https://docs.github.com/rest/codespaces/secrets#remove-a-selected-repository-from-a-user-secret) endpoints
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds;
};

public type MarketplaceAccount record {
    # The billing email address for the organization account.
    @jsondata:Name {value: "organization_billing_email"}
    string? organizationBillingEmail?;
    # The unique identifier of the marketplace account.
    int id;
    # The type of account, such as User or Organization.
    string 'type;
    # The login username of the marketplace account.
    string login;
    # The API URL for the marketplace account.
    string url;
    # The email address associated with the marketplace account.
    string? email?;
    # The GraphQL node identifier of the marketplace account.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

public type OwnerrepoBody2 record {
    # The permission to grant the team on this repository. If no permission is specified, the team's permission attribute will be used to determine what permission to grant the team on this repository
    "pull"|"push"|"admin" permission?;
};

public type OwnerrepoBody1 record {
    # Either true to make the repository private or false to make it public. Default: false.  
    # **Note**: You will get a 422 error if the organization restricts [changing repository visibility](https://docs.github.com/articles/repository-permission-levels-for-an-organization#changing-the-visibility-of-repositories) to organization owners and a non-owner tries to change the value of private
    boolean 'private = false;
    # Either true to allow private forks, or false to prevent private forks
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking = false;
    # Either true to make this repo available as a template repository or false to prevent it
    @jsondata:Name {value: "is_template"}
    boolean isTemplate = false;
    # A short description of the repository
    string description?;
    # Either true to allow rebase-merging pull requests, or false to prevent rebase-merging
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge = true;
    # Either true to enable projects for this repository or false to disable them. **Note:** If you're creating a repository in an organization that has disabled repository projects, the default is false, and if you pass true, the API returns an error
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects = true;
    # Whether to archive this repository. false will unarchive a previously archived repository
    boolean archived = false;
    # Either true to enable the wiki for this repository or false to disable it
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki = true;
    # The default value for a merge commit title.
    # 
    # - PR_TITLE - default to the pull request's title.
    # - MERGE_MESSAGE - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name)
    @jsondata:Name {value: "merge_commit_title"}
    "PR_TITLE"|"MERGE_MESSAGE" mergeCommitTitle?;
    # The default value for a squash merge commit message:
    # 
    # - PR_BODY - default to the pull request's body.
    # - COMMIT_MESSAGES - default to the branch's commit messages.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "squash_merge_commit_message"}
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squashMergeCommitMessage?;
    # Either true to allow automatically deleting head branches when pull requests are merged, or false to prevent automatic deletion
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge = false;
    # Either true to allow squash-merging pull requests, or false to prevent squash-merging
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge = true;
    # Either true to allow merging pull requests with a merge commit, or false to prevent merging pull requests with merge commits
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit = true;
    # The visibility of the repository
    "public"|"private" visibility?;
    # Either true to always allow a pull request head branch that is behind its base branch to be updated even if it is not required to be up to date before merging, or false otherwise
    @jsondata:Name {value: "allow_update_branch"}
    boolean allowUpdateBranch = false;
    # Either true to enable issues for this repository or false to disable them
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues = true;
    # Either true to require contributors to sign off on web-based commits, or false to not require contributors to sign off on web-based commits
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired = false;
    # Security and analysis settings to enable or disable for the repository.
    @jsondata:Name {value: "security_and_analysis"}
    ReposownerrepoSecurityAndAnalysis? securityAndAnalysis?;
    # Either true to allow auto-merge on pull requests, or false to disallow auto-merge
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge = false;
    # Either true to allow squash-merge commits to use pull request title, or false to use commit message. **This property has been deprecated. Please use squash_merge_commit_title instead
    # 
    # # Deprecated
    @jsondata:Name {value: "use_squash_pr_title_as_default"}
    @deprecated
    boolean useSquashPrTitleAsDefault = false;
    # The name of the repository
    string name?;
    # Updates the default branch for this repository
    @jsondata:Name {value: "default_branch"}
    string defaultBranch?;
    # The default value for a merge commit message.
    # 
    # - PR_TITLE - default to the pull request's title.
    # - PR_BODY - default to the pull request's body.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "merge_commit_message"}
    "PR_BODY"|"PR_TITLE"|"BLANK" mergeCommitMessage?;
    # The default value for a squash merge commit title:
    # 
    # - PR_TITLE - default to the pull request's title.
    # - COMMIT_OR_PR_TITLE - default to the commit's title (if only one commit) or the pull request's title (when more than one commit)
    @jsondata:Name {value: "squash_merge_commit_title"}
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squashMergeCommitTitle?;
    # A URL with more information about the repository
    string homepage?;
};

# Protected Branch Admin Enforced
public type ProtectedBranchAdminEnforced record {
    # The API URL for this admin enforcement resource.
    string url;
    # Whether admin enforcement is enabled for the protected branch.
    boolean enabled;
};

# The REST API URL of the alert resource
public type AlertUrl string;

# Set secrets for Dependabot
public type DependabotSecret record {
    # The timestamp when the Dependabot secret was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The name of the secret
    string name;
    # The timestamp when the Dependabot secret was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
};

# Issues are a great way to keep track of tasks, enhancements, and bugs for your projects
public type NullableIssue record {
    # The HTML-rendered body of the issue
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    # The plain text body of the issue
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    # The users assigned to the issue
    SimpleUser[]? assignees?;
    # The date the issue was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Title of the issue
    string title;
    # Contents of the issue
    string? body?;
    # The repository in which the issue exists.
    Repository repository?;
    # The user who closed the issue
    @jsondata:Name {value: "closed_by"}
    NullableSimpleUser? closedBy?;
    # API URL template for the issue's labels
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # The association of the author with the repository
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # Number uniquely identifying the issue within its repository
    int number;
    # The date the issue was last updated
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The GitHub App that triggered the event
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    # Whether the issue is a draft
    boolean draft?;
    # API URL for the issue's comments
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # The reason the issue conversation was locked
    @jsondata:Name {value: "active_lock_reason"}
    string? activeLockReason?;
    # The unique identifier of the issue
    int id;
    # API URL for the repository containing the issue
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    # State of the issue; either 'open' or 'closed'
    string state;
    # Whether the issue conversation is locked
    boolean locked;
    # API URL for the issue's timeline events
    @jsondata:Name {value: "timeline_url"}
    string timelineUrl?;
    # The reason for the current state
    @jsondata:Name {value: "state_reason"}
    "completed"|"reopened"|"not_planned"? stateReason?;
    # Pull request metadata if the issue is linked to a pull request.
    @jsondata:Name {value: "pull_request"}
    IssuePullRequest pullRequest?;
    # The number of comments on the issue
    int comments;
    # The date the issue was closed
    @jsondata:Name {value: "closed_at"}
    string? closedAt;
    # URL for the issue
    string url;
    # Labels to associate with this issue; pass one or more label names to replace the set of labels on this issue; send an empty array to clear all labels from the issue; note that the labels are silently dropped for users without push access to the repository
    NullableIssueLabels[] labels;
    # The milestone associated with the issue.
    NullableMilestone? milestone;
    # API URL for the issue's events
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # URL of the issue page on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Reaction summary counts for the issue.
    ReactionRollup reactions?;
    # The primary user assigned to the issue.
    NullableSimpleUser? assignee;
    # The user who created the issue.
    NullableSimpleUser? user;
    # The GraphQL node identifier of the issue
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Content Traffic
public type ContentTraffic record {
    # The path of the content page receiving traffic.
    string path;
    # The total number of views for the content page.
    int count;
    # The number of unique visitors to the content page.
    int uniques;
    # The title of the content page.
    string title;
};

# The author of the file. Default: The committer or the authenticated user if you omit committer
public type ReposownerrepocontentspathAuthor record {
    # The date and time the commit was authored, in ISO 8601 format.
    string date?;
    # The name of the author or committer of the commit. You'll receive a 422 status code if name is omitted
    string name;
    # The email of the author or committer of the commit. You'll receive a 422 status code if email is omitted
    string email;
};

public type TimelineCrossReferencedEventSource record {
    # The issue that is the source of the cross-reference.
    Issue issue?;
    # The type of source that created the cross-reference.
    string 'type?;
};

# Represents the Queries record for the operation: codespaces/pre-flight-with-repo-for-authenticated-user
public type CodespacesPreFlightWithRepoForAuthenticatedUserQueries record {
    # The branch or commit to check for a default devcontainer path. If not specified, the default branch will be checked
    string ref?;
    # An alternative IP for default location auto-detection, such as when proxying a request
    @http:Query {name: "client_ip"}
    string clientIp?;
};

# Represents the Queries record for the operation: repos/get-repo-rulesets
public type ReposGetRepoRulesetsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Include rulesets configured at higher levels that apply to this repository
    @http:Query {name: "includes_parents"}
    boolean includesParents = true;
};

# An identifier for the upload
public type CodeScanningAnalysisSarifId string;

# User Marketplace Purchase
public type UserMarketplacePurchase record {
    # The date and time when the free trial period ends.
    @jsondata:Name {value: "free_trial_ends_on"}
    string? freeTrialEndsOn;
    # Whether the purchase is currently on a free trial.
    @jsondata:Name {value: "on_free_trial"}
    boolean onFreeTrial;
    # The timestamp when the marketplace purchase was last updated.
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    # The billing cycle frequency, such as monthly or yearly.
    @jsondata:Name {value: "billing_cycle"}
    string billingCycle;
    # The Marketplace listing plan associated with this purchase.
    MarketplaceListingPlan plan;
    # The number of units purchased in the plan.
    @jsondata:Name {value: "unit_count"}
    int? unitCount;
    # The marketplace account associated with this purchase.
    MarketplaceAccount account;
    # The date of the next scheduled billing.
    @jsondata:Name {value: "next_billing_date"}
    string? nextBillingDate;
};

public type GitTagObject record {
    # The type of Git object the tag points to.
    string 'type;
    # The SHA of the Git object the tag points to.
    string sha;
    # The API URL for the tagged Git object.
    string url;
};

# Gist
public type Gist record {
    # The user who owns the gist.
    NullableSimpleUser? owner?;
    # List of forks of this gist.
    anydata[] forks?;
    # The API URL for the gist's commit history.
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    # The number of comments on the gist.
    int comments;
    # The API URL for the gist's forks.
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The Git push URL for the gist.
    @jsondata:Name {value: "git_push_url"}
    string gitPushUrl;
    # The timestamp when the gist was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The description of the gist.
    string? description;
    # Whether the gist content is truncated due to size limits.
    boolean truncated?;
    # The list of revision history entries for the gist.
    anydata[] history?;
    # The API URL for the gist.
    string url;
    # Whether the gist is publicly accessible.
    boolean 'public;
    # The timestamp when the gist was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The URL of the gist page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The Git pull URL for the gist.
    @jsondata:Name {value: "git_pull_url"}
    string gitPullUrl;
    # The API URL for the gist's comments.
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    # The files contained within the gist.
    record {|BaseGistFiles...;|} files;
    # The unique identifier of the gist.
    string id;
    # The user associated with the gist.
    NullableSimpleUser? user;
    # The GraphQL node identifier of the gist.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type RepoMergesBody record {
    # The head to merge. This can be a branch name or a commit SHA1
    string head;
    # Commit message to use for the merge commit. If omitted, a default message will be used
    @jsondata:Name {value: "commit_message"}
    string commitMessage?;
    # The name of the base branch that the head will be merged into
    string base;
};

# Represents the Queries record for the operation: search/users
public type SearchUsersQueries record {
    # The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching users](https://docs.github.com/search-github/searching-on-github/searching-users)" for a detailed list of qualifiers
    string q;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Sorts the results of your query by number of followers or repositories, or when the person joined GitHub. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    "followers"|"repositories"|"joined" sort?;
    # Page number of the results to fetch
    int page = 1;
    # Determines whether the first search result returned is the highest number of matches (desc) or lowest number of matches (asc). This parameter is ignored unless you provide sort
    "desc"|"asc" 'order = "desc";
};

# Represents the Queries record for the operation: repos/list-commit-statuses-for-ref
public type ReposListCommitStatusesForRefQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type CheckRunscheckRunIdBody record {"completed" status?;}|record {"queued"|"in_progress" status?;};

public type AuthorizationApp record {
    # The name of the OAuth application.
    string name;
    # The client ID of the OAuth application.
    @jsondata:Name {value: "client_id"}
    string clientId;
    # The URL of the OAuth application's homepage.
    string url;
};

public type EnvironmentNameDeploymentProtectionRulesBody record {
    # The ID of the custom app that will be enabled on the environment
    @jsondata:Name {value: "integration_id"}
    int integrationId?;
};

# A product affected by the vulnerability detailed in a repository security advisory
public type RepositoryAdvisoryVulnerability record {|
    # The package affected by the vulnerability.
    RepositoryAdvisoryVulnerabilityPackage? package;
    # The functions in the package that are affected
    @jsondata:Name {value: "vulnerable_functions"}
    string[]? vulnerableFunctions;
    # The range of the package versions affected by the vulnerability
    @jsondata:Name {value: "vulnerable_version_range"}
    string? vulnerableVersionRange;
    # The package version(s) that resolve the vulnerability
    @jsondata:Name {value: "patched_versions"}
    string? patchedVersions;
|};

# A repository rule with ruleset details
public type RepositoryRuleDetailed RepositoryRuleDetailedOneOf1|RepositoryRuleDetailedOneOf2|RepositoryRuleDetailedOneOf3|RepositoryRuleDetailedOneOf4|RepositoryRuleDetailedOneOf5|RepositoryRuleDetailedOneOf6|RepositoryRuleDetailedOneOf7|RepositoryRuleDetailedOneOf8|RepositoryRuleDetailedOneOf9|RepositoryRuleDetailedOneOf10|RepositoryRuleDetailedOneOf11|RepositoryRuleDetailedOneOf12|RepositoryRuleDetailedOneOf13|RepositoryRuleDetailedOneOf14;

public type ProtectionRequiredPullRequestReviewsBody record {
    # Users and teams allowed to dismiss pull request reviews.
    @jsondata:Name {value: "dismissal_restrictions"}
    ReposownerrepobranchesbranchprotectionRequiredPullRequestReviewsDismissalRestrictions dismissalRestrictions?;
    # Specifies the number of reviewers required to approve pull requests. Use a number between 1 and 6 or 0 to not require reviewers
    @jsondata:Name {value: "required_approving_review_count"}
    int requiredApprovingReviewCount?;
    # Blocks merging pull requests until [code owners](https://docs.github.com/articles/about-code-owners/) have reviewed
    @jsondata:Name {value: "require_code_owner_reviews"}
    boolean requireCodeOwnerReviews?;
    # Set to true if you want to automatically dismiss approving reviews when someone pushes a new commit
    @jsondata:Name {value: "dismiss_stale_reviews"}
    boolean dismissStaleReviews?;
    # Users and teams allowed to bypass required pull request reviews.
    @jsondata:Name {value: "bypass_pull_request_allowances"}
    ReposownerrepobranchesbranchprotectionRequiredPullRequestReviewsBypassPullRequestAllowances bypassPullRequestAllowances?;
    # Whether the most recent push must be approved by someone other than the person who pushed it. Default: false
    @jsondata:Name {value: "require_last_push_approval"}
    boolean requireLastPushApproval = false;
};

public type UnlabeledIssueEventLabel record {
    # The hex color code of the label.
    string color;
    # The name of the label that was removed.
    string name;
};

public type PrivateVulnerabilityReportCreate record {|
    # A short summary of the advisory
    @constraint:String {maxLength: 1024}
    string summary;
    # The severity of the advisory. You must choose between setting this field or cvss_vector_string
    "critical"|"high"|"medium"|"low"? severity?;
    # The CVSS vector that calculates the severity of the advisory. You must choose between setting this field or severity
    @jsondata:Name {value: "cvss_vector_string"}
    string? cvssVectorString?;
    # A detailed description of what the advisory impacts
    @constraint:String {maxLength: 65535}
    string description;
    # An array of products affected by the vulnerability detailed in a repository security advisory
    RepositoryAdvisoryCreateVulnerabilities[]? vulnerabilities?;
    # A list of Common Weakness Enumeration (CWE) IDs
    @jsondata:Name {value: "cwe_ids"}
    string[]? cweIds?;
|};

# The template repository from which this repository was created
public type RepositoryTemplateRepository record {
    # The number of users who have starred the repository.
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount?;
    # Whether the repository is a template repository.
    @jsondata:Name {value: "is_template"}
    boolean isTemplate?;
    # The timestamp of the most recent push to the repository.
    @jsondata:Name {value: "pushed_at"}
    string pushedAt?;
    # The API URL for managing repository subscriptions.
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl?;
    # The primary programming language used in the repository.
    string language?;
    # The API URL template for the repository's branches.
    @jsondata:Name {value: "branches_url"}
    string branchesUrl?;
    # The API URL template for the repository's issue comments.
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl?;
    # Whether rebase-merging pull requests is allowed.
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge?;
    # The API URL template for the repository's labels.
    @jsondata:Name {value: "labels_url"}
    string labelsUrl?;
    # The API URL for the repository's subscribers.
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl?;
    # The permissions the authenticated user has on this repository.
    RepositoryTemplateRepositoryPermissions permissions?;
    # A temporary token used for cloning the repository.
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    # The API URL template for the repository's releases.
    @jsondata:Name {value: "releases_url"}
    string releasesUrl?;
    # The Subversion URL for accessing the repository.
    @jsondata:Name {value: "svn_url"}
    string svnUrl?;
    # The default value for a squash merge commit message:
    # 
    # - PR_BODY - default to the pull request's body.
    # - COMMIT_MESSAGES - default to the branch's commit messages.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "squash_merge_commit_message"}
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squashMergeCommitMessage?;
    # The number of users watching the repository.
    @jsondata:Name {value: "subscribers_count"}
    int subscribersCount?;
    # The unique identifier of the repository.
    int id?;
    # The API URL template for downloading repository archives.
    @jsondata:Name {value: "archive_url"}
    string archiveUrl?;
    # Whether merging pull requests with a merge commit is allowed.
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit?;
    # The API URL template for the repository's Git refs.
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl?;
    # The API URL for the repository's forks.
    @jsondata:Name {value: "forks_url"}
    string forksUrl?;
    # The visibility level of the repository.
    string visibility?;
    # The API URL template for the repository's commit statuses.
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl?;
    # The number of repositories in the network.
    @jsondata:Name {value: "network_count"}
    int networkCount?;
    # The SSH URL used to clone the repository.
    @jsondata:Name {value: "ssh_url"}
    string sshUrl?;
    # The full repository name including owner and repository name.
    @jsondata:Name {value: "full_name"}
    string fullName?;
    # The size of the repository in kilobytes.
    int size?;
    # Whether auto-merge is allowed on pull requests.
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge?;
    # The API URL for the repository's language breakdown.
    @jsondata:Name {value: "languages_url"}
    string languagesUrl?;
    # The URL of the repository page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The API URL template for the repository's collaborators.
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl?;
    # The HTTPS URL used to clone the repository.
    @jsondata:Name {value: "clone_url"}
    string cloneUrl?;
    # The name of the repository.
    string name?;
    # The API URL template for the repository's pull requests.
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl?;
    # The name of the repository's default branch.
    @jsondata:Name {value: "default_branch"}
    string defaultBranch?;
    # The API URL for the repository's webhooks.
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl?;
    # The API URL template for the repository's Git trees.
    @jsondata:Name {value: "trees_url"}
    string treesUrl?;
    # The API URL for the repository's tags.
    @jsondata:Name {value: "tags_url"}
    string tagsUrl?;
    # Whether the repository is private.
    boolean 'private?;
    # The API URL for the repository's contributors.
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl?;
    # Whether the repository has downloads enabled.
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads?;
    # The API URL template for the repository's notifications.
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl?;
    # The number of open issues in the repository.
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount?;
    # The description of the repository.
    string description?;
    # The timestamp when the repository was created.
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    # The API URL for the repository's deployments.
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl?;
    # The API URL template for the repository's deploy keys.
    @jsondata:Name {value: "keys_url"}
    string keysUrl?;
    # Whether projects are enabled for the repository.
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects?;
    # Whether the repository is archived.
    boolean archived?;
    # Whether the wiki is enabled for the repository.
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki?;
    # The timestamp when the repository was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    # The default value for a merge commit title.
    # 
    # - PR_TITLE - default to the pull request's title.
    # - MERGE_MESSAGE - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name)
    @jsondata:Name {value: "merge_commit_title"}
    "PR_TITLE"|"MERGE_MESSAGE" mergeCommitTitle?;
    # The API URL template for the repository's comments.
    @jsondata:Name {value: "comments_url"}
    string commentsUrl?;
    # The API URL for the repository's stargazers.
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl?;
    # Whether the repository is disabled.
    boolean disabled?;
    # Whether branches are automatically deleted after pull request merges.
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge?;
    # The Git URL used to access the repository.
    @jsondata:Name {value: "git_url"}
    string gitUrl?;
    # Whether GitHub Pages is enabled for the repository.
    @jsondata:Name {value: "has_pages"}
    boolean hasPages?;
    # The owner of the template repository.
    RepositoryTemplateRepositoryOwner owner?;
    # Whether squash-merging pull requests is allowed.
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge?;
    # The API URL template for the repository's commits.
    @jsondata:Name {value: "commits_url"}
    string commitsUrl?;
    # The API URL template for comparing branches or commits.
    @jsondata:Name {value: "compare_url"}
    string compareUrl?;
    # The API URL template for the repository's Git commits.
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl?;
    # The list of topics associated with the repository.
    string[] topics?;
    # The API URL template for the repository's Git blobs.
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl?;
    # Whether pull request branches can be updated even if not required.
    @jsondata:Name {value: "allow_update_branch"}
    boolean allowUpdateBranch?;
    # The API URL template for the repository's Git tags.
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl?;
    # The API URL for merging branches in the repository.
    @jsondata:Name {value: "merges_url"}
    string mergesUrl?;
    # The API URL for the repository's downloads.
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl?;
    # Whether issues are enabled for the repository.
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues?;
    # The API URL for the repository.
    string url?;
    # The API URL template for the repository's contents.
    @jsondata:Name {value: "contents_url"}
    string contentsUrl?;
    # The URL of the source repository if this is a mirror.
    @jsondata:Name {value: "mirror_url"}
    string mirrorUrl?;
    # The API URL template for the repository's milestones.
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl?;
    # The API URL for the repository's teams.
    @jsondata:Name {value: "teams_url"}
    string teamsUrl?;
    # Whether the repository is a fork of another repository.
    boolean 'fork?;
    # The API URL template for the repository's issues.
    @jsondata:Name {value: "issues_url"}
    string issuesUrl?;
    # The API URL for the repository's events.
    @jsondata:Name {value: "events_url"}
    string eventsUrl?;
    # Whether squash merge commits use the pull request title by default.
    @jsondata:Name {value: "use_squash_pr_title_as_default"}
    boolean useSquashPrTitleAsDefault?;
    # The API URL template for the repository's issue events.
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl?;
    # The default value for a merge commit message.
    # 
    # - PR_TITLE - default to the pull request's title.
    # - PR_BODY - default to the pull request's body.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "merge_commit_message"}
    "PR_BODY"|"PR_TITLE"|"BLANK" mergeCommitMessage?;
    # The API URL template for the repository's assignees.
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl?;
    # The default value for a squash merge commit title:
    # 
    # - PR_TITLE - default to the pull request's title.
    # - COMMIT_OR_PR_TITLE - default to the commit's title (if only one commit) or the pull request's title (when more than one commit)
    @jsondata:Name {value: "squash_merge_commit_title"}
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squashMergeCommitTitle?;
    # The number of users watching the repository.
    @jsondata:Name {value: "watchers_count"}
    int watchersCount?;
    # The GraphQL node identifier of the repository.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
    # The URL of the repository's homepage or website.
    string homepage?;
    # The number of forks of the repository.
    @jsondata:Name {value: "forks_count"}
    int forksCount?;
};

# Represents the Queries record for the operation: orgs/list-webhooks
public type OrgsListWebhooksQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf112345 string;

# Enable or disable Dependabot security updates for the repository
public type SecurityAndAnalysisDependabotSecurityUpdates record {
    # The enablement status of Dependabot security updates for the repository
    "enabled"|"disabled" status?;
};

# Represents the Queries record for the operation: pulls/list-files
public type PullsListFilesQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Codespace default attributes
public type CodespaceDefaultResponse record {
    # The default codespace configuration attributes.
    CodespaceDefault defaults?;
    # The user billed for the codespace usage.
    @jsondata:Name {value: "billable_owner"}
    SimpleUser billableOwner?;
};

public type RepoDispatchesBody record {
    # A custom webhook event name. Must be 100 characters or fewer
    @jsondata:Name {value: "event_type"}
    string eventType;
    # JSON payload with extra information about the webhook event that your action or workflow may use. The maximum number of top-level properties is 10
    @jsondata:Name {value: "client_payload"}
    record {} clientPayload?;
};

# Represents the Queries record for the operation: codespaces/list-org-secrets
public type CodespacesListOrgSecretsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type IssueNumberAssigneesBody1 record {
    # Usernames of assignees to remove from an issue. _NOTE: Only users with push access can remove assignees from an issue. Assignees are silently ignored otherwise._
    string[] assignees?;
};

# The default workflow permissions granted to the GITHUB_TOKEN when running workflows
public type ActionsDefaultWorkflowPermissions "read"|"write";

# The breakdown of Copilot for Business seats for the organization
public type CopilotSeatBreakdown record {
    # The number of seats that have not used Copilot during the current billing cycle
    @jsondata:Name {value: "inactive_this_cycle"}
    int inactiveThisCycle?;
    # The total number of seats being billed for the organization as of the current billing cycle
    int total?;
    # Seats added during the current billing cycle
    @jsondata:Name {value: "added_this_cycle"}
    int addedThisCycle?;
    # The number of seats that have been assigned to users that have not yet accepted an invitation to this organization
    @jsondata:Name {value: "pending_invitation"}
    int pendingInvitation?;
    # The number of seats that have used Copilot during the current billing cycle
    @jsondata:Name {value: "active_this_cycle"}
    int activeThisCycle?;
    # The number of seats that are pending cancellation at the end of the current billing cycle
    @jsondata:Name {value: "pending_cancellation"}
    int pendingCancellation?;
};

# Represents the Queries record for the operation: packages/list-packages-for-user
public type PackagesListPackagesForUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The selected visibility of the packages.  This parameter is optional and only filters an existing result set.
    # 
    # The internal visibility is only supported for GitHub Packages registries that allow for granular permissions. For other ecosystems internal is synonymous with private.
    # For the list of GitHub Packages registries that support granular permissions, see "[About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages#granular-permissions-for-userorganization-scoped-packages)."
    "public"|"private"|"internal" visibility?;
    # Page number of the results to fetch
    int page = 1;
    # The type of supported package. Packages in GitHub's Gradle registry have the type maven. Docker images pushed to GitHub's Container registry (ghcr.io) have the type container. You can use the type docker to find images that were pushed to GitHub's Docker registry (docker.pkg.github.com), even if these have now been migrated to the Container registry
    @http:Query {name: "package_type"}
    "npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType;
};

# Page Build Status
public type PageBuildStatus record {
    # The API URL for the GitHub Pages build.
    string url;
    # The current status of the GitHub Pages build.
    string status;
};

public type DockerMetadata record {
    # The list of tags associated with the Docker container image.
    string[] tag?;
};

public type RepositoryRuleUpdateParameters record {
    # Branch can pull changes from its upstream repository
    @jsondata:Name {value: "update_allows_fetch_and_merge"}
    boolean updateAllowsFetchAndMerge;
};

# Groups of organization members that gives permissions on specified repositories
public type TeamFull record {
    # The parent team of this team, if applicable.
    NullableTeamSimple? parent?;
    # The API URL for the team's repositories.
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
    # The number of repositories accessible to the team.
    @jsondata:Name {value: "repos_count"}
    int reposCount;
    # The API URL template for the team's members.
    @jsondata:Name {value: "members_url"}
    string membersUrl;
    # The description of the team.
    string? description;
    # The level of privacy this team should have
    "closed"|"secret" privacy?;
    # The timestamp when the team was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Permission that the team will have for its repositories
    string permission;
    # URL for the team
    string url;
    # The notification setting the team has set
    @jsondata:Name {value: "notification_setting"}
    "notifications_enabled"|"notifications_disabled" notificationSetting?;
    # Distinguished Name (DN) that team maps to within LDAP environment
    @jsondata:Name {value: "ldap_dn"}
    string ldapDn?;
    # The timestamp when the team was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The URL of the team page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The organization to which the team belongs.
    TeamOrganization organization;
    # Name of the team
    string name;
    # The number of members in the team.
    @jsondata:Name {value: "members_count"}
    int membersCount;
    # Unique identifier of the team
    int id;
    # The URL-friendly name of the team.
    string slug;
    # The GraphQL node identifier of the team.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Project cards represent a scope of work
public type ProjectCard record {
    # The API URL for the column this card belongs to.
    @jsondata:Name {value: "column_url"}
    string columnUrl;
    # The text note content of the project card.
    string? note;
    # The user who created the project card.
    NullableSimpleUser? creator;
    # The name of the column this card belongs to.
    @jsondata:Name {value: "column_name"}
    string columnName?;
    # The timestamp when the project card was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The API URL for the project containing this card.
    @jsondata:Name {value: "project_url"}
    string projectUrl;
    # The API URL for this project card.
    string url;
    # Whether or not the card is archived
    boolean archived?;
    # The timestamp when the project card was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The identifier of the project containing this card.
    @jsondata:Name {value: "project_id"}
    string projectId?;
    # The API URL for the issue or pull request linked to this card.
    @jsondata:Name {value: "content_url"}
    string contentUrl?;
    # The project card's ID
    int id;
    # The GraphQL node identifier of the project card.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type PullNumberCodespacesBody record {
    # The geographic area for this codespace. If not specified, the value is assigned by IP. This property replaces location, which is being deprecated
    "EuropeWest"|"SoutheastAsia"|"UsEast"|"UsWest" geo?;
    # Path to devcontainer.json config to use for this codespace
    @jsondata:Name {value: "devcontainer_path"}
    string devcontainerPath?;
    # Whether to authorize requested permissions from devcontainer.json
    @jsondata:Name {value: "multi_repo_permissions_opt_out"}
    boolean multiRepoPermissionsOptOut?;
    # Machine type to use for this codespace
    string machine?;
    # The requested location for a new codespace. Best efforts are made to respect this upon creation. Assigned by IP if not provided
    string location?;
    # IP for location auto-detection when proxying a request
    @jsondata:Name {value: "client_ip"}
    string clientIp?;
    # Working directory for this codespace
    @jsondata:Name {value: "working_directory"}
    string workingDirectory?;
    # Duration in minutes after codespace has gone idle in which it will be deleted. Must be integer minutes between 0 and 43200 (30 days)
    @jsondata:Name {value: "retention_period_minutes"}
    int retentionPeriodMinutes?;
    # Display name for this codespace
    @jsondata:Name {value: "display_name"}
    string displayName?;
    # Time in minutes before codespace stops from inactivity
    @jsondata:Name {value: "idle_timeout_minutes"}
    int idleTimeoutMinutes?;
};

# A link to additional advisory information
public type DependabotAlertSecurityAdvisoryReferences record {|
    # The URL of the reference
    string url;
|};

# Represents the Queries record for the operation: code-scanning/list-recent-analyses
public type CodeScanningListRecentAnalysesQueries record {
    # The name of a code scanning tool. Only results by this tool will be listed. You can specify the tool by using either tool_name or tool_guid, but not both
    @http:Query {name: "tool_name"}
    CodeScanningAnalysisToolName toolName?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The Git reference for the analyses you want to list. The ref for a branch can be formatted either as refs/heads/<branch name> or simply <branch name>. To reference a pull request use refs/pull/<number>/merge
    CodeScanningRef ref?;
    # Filter analyses belonging to the same SARIF upload
    @http:Query {name: "sarif_id"}
    CodeScanningAnalysisSarifId sarifId?;
    # Page number of the results to fetch
    int page = 1;
    # The property by which to sort the results
    "created" sort = "created";
    # The GUID of a code scanning tool. Only results by this tool will be listed. Note that some code scanning tools may not include a GUID in their analysis data. You can specify the tool by using either tool_guid or tool_name, but not both
    @http:Query {name: "tool_guid"}
    CodeScanningAnalysisToolGuid? toolGuid?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

@constraint:Array {minLength: 1}
public type ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf12 string[];

public type EnvironmentApprovalsEnvironments record {
    # The time that the environment was last updated, in ISO 8601 format
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    # The URL of the environment page on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The name of the environment
    string name?;
    # The time that the environment was created, in ISO 8601 format
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    # The id of the environment
    int id?;
    # The API URL for the environment.
    string url?;
    # The GraphQL node identifier of the environment.
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# Represents the Queries record for the operation: packages/restore-package-for-org
public type PackagesRestorePackageForOrgQueries record {
    # package token
    string token?;
};

public type ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf12345 string;

# A migration
public type Migration record {
    # The user or organization that owns the migration.
    NullableSimpleUser? owner;
    # The URL to download the migration archive.
    @jsondata:Name {value: "archive_url"}
    string archiveUrl?;
    # Whether Git data is excluded from the migration.
    @jsondata:Name {value: "exclude_git_data"}
    boolean excludeGitData;
    # The timestamp when the migration was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Whether releases are excluded from the migration.
    @jsondata:Name {value: "exclude_releases"}
    boolean excludeReleases;
    # Whether owner projects are excluded from the migration.
    @jsondata:Name {value: "exclude_owner_projects"}
    boolean excludeOwnerProjects;
    # Whether repositories are locked during the migration.
    @jsondata:Name {value: "lock_repositories"}
    boolean lockRepositories;
    # The API URL for this migration.
    string url;
    # Whether metadata is excluded from the migration.
    @jsondata:Name {value: "exclude_metadata"}
    boolean excludeMetadata;
    # The timestamp when the migration was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The repositories included in the migration. Only returned for export migrations
    Repository[] repositories;
    # The unique GUID identifier for the migration.
    string guid;
    # Whether attachments are excluded from the migration.
    @jsondata:Name {value: "exclude_attachments"}
    boolean excludeAttachments;
    # Whether only organization metadata is included in the migration.
    @jsondata:Name {value: "org_metadata_only"}
    boolean orgMetadataOnly;
    # Exclude related items from being returned in the response in order to improve performance of the request. The array can include any of: "repositories"
    string[] exclude?;
    # The unique identifier of the migration.
    int id;
    # The current state of the migration.
    string state;
    # The GraphQL node identifier of the migration.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Identifies the variable values associated with the environment in which this analysis was performed
public type CodeScanningAnalysisEnvironment string;

# The permissions the authenticated user has on the repository
public type RepositoryPermissions record {
    # Whether the authenticated user can pull from the repository.
    boolean pull;
    # Whether the authenticated user has maintain permissions on the repository.
    boolean maintain?;
    # Whether the authenticated user has admin permissions on the repository.
    boolean admin;
    # Whether the authenticated user has triage permissions on the repository.
    boolean triage?;
    # Whether the authenticated user can push to the repository.
    boolean push;
};

public type VariablesnameBody1 record {
    # The name of the variable
    string name?;
    # The value of the variable
    string value?;
};

# The dismissal comment associated with the dismissal of the alert
public type CodeScanningAlertDismissedComment string?;

@constraint:Array {minLength: 1}
public type ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf112 string[];

public type PagesHttpsCertificate record {
    # The date and time when the HTTPS certificate expires.
    @jsondata:Name {value: "expires_at"}
    string expiresAt?;
    # A description of the current certificate state or error.
    string description;
    # Array of the domain set and its alternate name (if it is configured)
    string[] domains;
    # The current provisioning state of the HTTPS certificate.
    "new"|"authorization_created"|"authorization_pending"|"authorized"|"authorization_revoked"|"issued"|"uploaded"|"approved"|"errored"|"bad_authz"|"destroy_pending"|"dns_changed" state;
};

public type CommitSearchResultItemCommit record {
    # The number of comments on the commit.
    @jsondata:Name {value: "comment_count"}
    int commentCount;
    # The Git user who committed the change.
    NullableGitUser? committer;
    # The author information for the commit.
    CommitSearchResultItemCommitAuthor author;
    # The Git tree object associated with the commit.
    CommitSearchResultItemCommitTree tree;
    # The commit message describing the changes made.
    string message;
    # The API URL for the commit resource.
    string url;
    # The GPG signature verification status of the commit.
    Verification verification?;
};

public type OrgProjectsBody record {
    # The name of the project
    string name;
    # The description of the project
    string body?;
};

public type CombinedBillingUsage record {
    # Numbers of days left in billing cycle
    @jsondata:Name {value: "days_left_in_billing_cycle"}
    int daysLeftInBillingCycle;
    # Estimated storage space (GB) used in billing cycle
    @jsondata:Name {value: "estimated_paid_storage_for_month"}
    int estimatedPaidStorageForMonth;
    # Estimated sum of free and paid storage space (GB) used in billing cycle
    @jsondata:Name {value: "estimated_storage_for_month"}
    int estimatedStorageForMonth;
};

# Team Membership
public type TeamMembership record {
    # The role of the user in the team
    "member"|"maintainer" role = "member";
    # The state of the user's membership in the team
    "active"|"pending" state;
    # The API URL for the team membership resource.
    string url;
};

public type ManifestConversions record {
    *Integration;
    string client_id;
    string client_secret;
    string? webhook_secret;
    string pem;
};

public type OrgTeamsBody record {
    # List GitHub IDs for organization members who will become team maintainers
    string[] maintainers?;
    # The ID of a team to set as the parent team
    @jsondata:Name {value: "parent_team_id"}
    int parentTeamId?;
    # The name of the team
    string name;
    # The full name (e.g., "organization-name/repository-name") of repositories to add the team to
    @jsondata:Name {value: "repo_names"}
    string[] repoNames?;
    # The description of the team
    string description?;
    # The level of privacy this team should have. The options are:  
    # **For a non-nested team:**  
    #  * secret - only visible to organization owners and members of this team.  
    #  * closed - visible to all members of this organization.  
    # Default: secret  
    # **For a parent or child team:**  
    #  * closed - visible to all members of this organization.  
    # Default for child team: closed
    "secret"|"closed" privacy?;
    # **Deprecated**. The permission that new repositories will be added to the team with when none is specified
    "pull"|"push" permission = "pull";
    # The notification setting the team has chosen. The options are:  
    #  * notifications_enabled - team members receive notifications when the team is @mentioned.  
    #  * notifications_disabled - no one receives notifications.  
    # Default: notifications_enabled
    @jsondata:Name {value: "notification_setting"}
    "notifications_enabled"|"notifications_disabled" notificationSetting?;
};

# The media type used to serialize the payloads. Supported values include json and form. The default is form
public type WebhookConfigContentType string;

# Whether or not a user who created the job is prevented from approving their own job
public type PreventSelfReview boolean;

public type SearchResultTextMatches SearchResultTextMatchesInner[];

public type AccessSelectedUsersBody1 record {
    # The usernames of the organization members whose codespaces should not be billed to the organization
    @jsondata:Name {value: "selected_usernames"}
    string[] selectedUsernames;
};

# Response
public type RuleSuite record {
    # The result of the rule evaluations for rules with the active enforcement status
    "pass"|"fail"|"bypass" result?;
    # The first commit sha before the push evaluation
    @jsondata:Name {value: "before_sha"}
    string beforeSha?;
    # The ref name that the evaluation ran on
    string ref?;
    # The result of the rule evaluations for rules with the active and evaluate enforcement statuses, demonstrating whether rules would pass or fail if all rules in the rule suite were active
    @jsondata:Name {value: "evaluation_result"}
    "pass"|"fail" evaluationResult?;
    # Details on the evaluated rules
    @jsondata:Name {value: "rule_evaluations"}
    RuleSuiteRuleEvaluations[] ruleEvaluations?;
    # The timestamp of when the push event occurred.
    @jsondata:Name {value: "pushed_at"}
    string pushedAt?;
    # The handle for the GitHub user account
    @jsondata:Name {value: "actor_name"}
    string actorName?;
    # The ID of the repository associated with the rule evaluation
    @jsondata:Name {value: "repository_id"}
    int repositoryId?;
    # The unique identifier of the rule insight
    int id?;
    # The number that identifies the user
    @jsondata:Name {value: "actor_id"}
    int actorId?;
    # The last commit sha in the push evaluation
    @jsondata:Name {value: "after_sha"}
    string afterSha?;
    # The name of the repository without the .git extension
    @jsondata:Name {value: "repository_name"}
    string repositoryName?;
};

public type ReposownerrepoissuesissueNumberlabelsOneOf11 record {
    # The names of the labels to add to the issue's existing labels. You can pass an empty array to remove all labels. Alternatively, you can pass a single label as a string or an array of labels directly, but GitHub recommends passing an object with the labels key. You can also replace all of the labels for an issue. For more information, see "[Set labels for an issue](https://docs.github.com/rest/issues/labels#set-labels-for-an-issue)."
    @constraint:Array {minLength: 1}
    string[] labels?;
};

# Information about a Copilot for Business seat assignment for a user, team, or organization
public type CopilotSeatDetailsResponse record {
    # Total number of Copilot For Business seats for the organization currently being billed
    @jsondata:Name {value: "total_seats"}
    int totalSeats?;
    # List of Copilot seat assignments for the organization.
    CopilotSeatDetails[] seats?;
};

# Information about the Git author
public type SimpleCommitAuthor record {
    # Name of the commit's author
    string name;
    # Git email address of the commit's author
    string email;
};

# Represents the Queries record for the operation: copilot/list-copilot-seats
public type CopilotListCopilotSeatsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 50;
    # Page number of the results to fetch
    int page = 1;
};

public type CommentscommentIdBody record {
    # The contents of the comment
    string body;
};

# Comments provide a way for people to collaborate on an issue
public type IssueComment record {
    # API URL for the associated issue
    @jsondata:Name {value: "issue_url"}
    string issueUrl;
    # The HTML-rendered body of the comment
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    # The plain text body of the comment
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    # The date the comment was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Contents of the issue comment
    string body?;
    # URL for the issue comment
    string url;
    # The association of the comment author with the repository
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # The date the comment was last updated
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The GitHub App that created the comment
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    # URL of the comment on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Reaction counts aggregated by emoji for the comment.
    ReactionRollup reactions?;
    # Unique identifier of the issue comment
    int id;
    # The user who created the issue comment.
    NullableSimpleUser? user;
    # The GraphQL node identifier of the comment
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type SearchResultTextMatchesInnerMatches record {
    # Start and end character positions of the match within the text.
    int[] indices?;
    # The matched text fragment found in the search result.
    string text?;
};

public type LabelsLabelsOneOf12 record {
    # The hexadecimal color code for the label.
    string? color?;
    # The name of the label.
    string name?;
    # A short description of the label's purpose.
    string? description?;
    # The unique identifier of the label.
    int id?;
};

# Repository actions caches
public type ActionsCacheList record {
    # Total number of caches
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # Array of caches
    @jsondata:Name {value: "actions_caches"}
    ActionsCacheListActionsCaches[] actionsCaches;
};

# A software package
public type Package record {
    # The user or organization that owns the package.
    NullableSimpleUser? owner?;
    # The visibility level of the package, either public or private.
    "private"|"public" visibility;
    # The date and time when the package was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The URL to view the package on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The name of the package
    string name;
    # The date and time when the package was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Unique identifier of the package
    int id;
    # The package registry type, such as npm or container.
    @jsondata:Name {value: "package_type"}
    "npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType;
    # The repository associated with the package.
    NullableMinimalRepository? repository?;
    # The number of versions of the package
    @jsondata:Name {value: "version_count"}
    int versionCount;
    # The API URL for the package resource.
    string url;
};

# Represents the Queries record for the operation: code-scanning/list-alerts-for-repo
public type CodeScanningListAlertsForRepoQueries record {
    # The name of a code scanning tool. Only results by this tool will be listed. You can specify the tool by using either tool_name or tool_guid, but not both
    @http:Query {name: "tool_name"}
    CodeScanningAnalysisToolName toolName?;
    # If specified, only code scanning alerts with this severity will be returned
    CodeScanningAlertSeverity severity?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The Git reference for the results you want to list. The ref for a branch can be formatted either as refs/heads/<branch name> or simply <branch name>. To reference a pull request use refs/pull/<number>/merge
    CodeScanningRef ref?;
    # Page number of the results to fetch
    int page = 1;
    # The property by which to sort the results
    "created"|"updated" sort = "created";
    # If specified, only code scanning alerts with this state will be returned
    CodeScanningAlertStateQuery state?;
    # The GUID of a code scanning tool. Only results by this tool will be listed. Note that some code scanning tools may not include a GUID in their analysis data. You can specify the tool by using either tool_guid or tool_name, but not both
    @http:Query {name: "tool_guid"}
    CodeScanningAnalysisToolGuid? toolGuid?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

public type InvitationsinvitationIdBody record {
    # The permissions that the associated user will have on the repository. Valid values are read, write, maintain, triage, and admin
    "read"|"write"|"maintain"|"triage"|"admin" permissions?;
};

# Represents the Queries record for the operation: repos/list-commit-comments-for-repo
public type ReposListCommitCommentsForRepoQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# The GPG signature verification data for the commit
public type GitCommitVerification record {
    # The reason for the verification status of the signature.
    string reason;
    # The GPG signature string for the commit.
    string? signature;
    # The signed data payload used to verify the signature.
    string? payload;
    # Indicates whether the commit signature is verified.
    boolean verified;
};

public type ReviewDismissedIssueEventDismissedReview record {
    # The unique identifier of the dismissed review.
    @jsondata:Name {value: "review_id"}
    int reviewId;
    # The state of the review when it was dismissed.
    string state;
    # The SHA of the commit at which the review was dismissed.
    @jsondata:Name {value: "dismissal_commit_id"}
    string dismissalCommitId?;
    # The message provided when the review was dismissed.
    @jsondata:Name {value: "dismissal_message"}
    string? dismissalMessage;
};

public type ActionsWorkflowAccessToRepository record {
    # Defines the level of access that workflows outside of the repository have to actions and reusable workflows within the
    # repository.
    # 
    # none means the access is only possible from workflows in this repository. user level access allows sharing across user owned private repos only. organization level access allows sharing across the organization
    @jsondata:Name {value: "access_level"}
    "none"|"user"|"organization" accessLevel;
};

# Represents the Queries record for the operation: migrations/get-status-for-org
public type MigrationsGetStatusForOrgQueries record {
    # Exclude attributes from the API response to improve performance
    ("repositories")[] exclude?;
};

public type BranchWithProtectionLinks record {
    # The API URL for the branch resource.
    string self;
    # The URL to view the branch on GitHub.
    string html;
};

public type CheckRunCheckSuite record {
    # The unique identifier of the check suite.
    int id;
};

public type StargazerResponseAnyOf1 SimpleUser[];

public type IssuesissueNumberBody record {
    # The reason for the state change. Ignored unless state is changed
    @jsondata:Name {value: "state_reason"}
    "completed"|"not_planned"|"reopened"? stateReason?;
    # The milestone to associate with this issue, or null to remove.
    string|int? milestone?;
    # Usernames to assign to this issue. Pass one or more user logins to _replace_ the set of assignees on this issue. Send an empty array ([]) to clear all assignees from the issue. Only users with push access can set assignees for new issues. Without push access to the repository, assignee changes are silently dropped
    string[] assignees?;
    # Username to assign to this issue. **This field is deprecated.**
    string? assignee?;
    # The open or closed state of the issue
    "open"|"closed" state?;
    # The title of the issue
    string|int? title?;
    # The contents of the issue
    string? body?;
    # Labels to associate with this issue. Pass one or more labels to _replace_ the set of labels on this issue. Send an empty array ([]) to clear all labels from the issue. Only users with push access can set labels for issues. Without push access to the repository, label changes are silently dropped
    ReposownerrepoissuesissueNumberLabels[] labels?;
};

# Conditions for an organization ruleset. The conditions object should contain both repository_name and ref_name properties or both repository_id and ref_name properties
public type OrgRulesetConditions RepositoryNameAndRefName|RepositoryIdAndRefName;

public type CommitParents record {
    # The URL to view the parent commit on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The SHA hash of the parent commit.
    string sha;
    # The API URL for the parent commit resource.
    string url;
};

# The base branch of the pull request
public type PullRequestBase record {
    # The branch name of the base branch.
    string ref;
    # The repository object for the base branch.
    PullRequestBaseRepo repo;
    # The label identifying the base branch with owner prefix.
    string label;
    # The SHA of the latest commit on the base branch.
    string sha;
    # The user associated with the base branch.
    PullRequestHeadRepoOwner user;
};

# Renamed Issue Event
public type RenamedIssueEvent record {
    # The user who triggered the rename event.
    SimpleUser actor;
    # The API URL of the commit associated with this event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The GitHub App that performed this event, if any.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The old and new title values from the rename action.
    RenamedIssueEventRename rename;
    # The date and time when the rename event occurred.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the issue event.
    int id;
    # The type of event that occurred on the issue.
    string event;
    # The SHA of the commit associated with this event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # The API URL for this issue event.
    string url;
    # The GraphQL node identifier for this event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type UserReposBody record {
    # Whether the repository is initialized with a minimal README
    @jsondata:Name {value: "auto_init"}
    boolean autoInit = false;
    # The desired language or platform to apply to the .gitignore
    @jsondata:Name {value: "gitignore_template"}
    string gitignoreTemplate?;
    # Whether to allow squash merges for pull requests
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge = true;
    # Whether to allow merge commits for pull requests
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit = true;
    # Whether the repository is private
    boolean 'private = false;
    # Whether downloads are enabled
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads = true;
    # Whether this repository acts as a template that can be used to generate new repositories
    @jsondata:Name {value: "is_template"}
    boolean isTemplate = false;
    # A short description of the repository
    string description?;
    # The id of the team that will be granted access to this repository. This is only valid when creating a repository in an organization
    @jsondata:Name {value: "team_id"}
    int teamId?;
    # Whether to allow rebase merges for pull requests
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge = true;
    # Whether issues are enabled
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues = true;
    # Whether projects are enabled
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects = true;
    # The license keyword of the open source license for this repository
    @jsondata:Name {value: "license_template"}
    string licenseTemplate?;
    # Whether the wiki is enabled
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki = true;
    # Whether to allow Auto-merge to be used on pull requests
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge = false;
    # The default value for a merge commit title.
    # 
    # - PR_TITLE - default to the pull request's title.
    # - MERGE_MESSAGE - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name)
    @jsondata:Name {value: "merge_commit_title"}
    "PR_TITLE"|"MERGE_MESSAGE" mergeCommitTitle?;
    # The name of the repository
    string name;
    # The default value for a squash merge commit message:
    # 
    # - PR_BODY - default to the pull request's body.
    # - COMMIT_MESSAGES - default to the branch's commit messages.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "squash_merge_commit_message"}
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squashMergeCommitMessage?;
    # Whether to delete head branches when pull requests are merged
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge = false;
    # The default value for a merge commit message.
    # 
    # - PR_TITLE - default to the pull request's title.
    # - PR_BODY - default to the pull request's body.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "merge_commit_message"}
    "PR_BODY"|"PR_TITLE"|"BLANK" mergeCommitMessage?;
    # The default value for a squash merge commit title:
    # 
    # - PR_TITLE - default to the pull request's title.
    # - COMMIT_OR_PR_TITLE - default to the commit's title (if only one commit) or the pull request's title (when more than one commit)
    @jsondata:Name {value: "squash_merge_commit_title"}
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squashMergeCommitTitle?;
    # Whether discussions are enabled
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions = false;
    # A URL with more information about the repository
    string homepage?;
};

# Represents the Queries record for the operation: teams/list-discussions-legacy
public type TeamsListDiscussionsLegacyQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# The REST API URL for fetching the list of instances for an alert
public type AlertInstancesUrl string;

public type EnvironmentsenvironmentNameBody record {|
    # Prevents the actor who triggered the deployment from approving it.
    @jsondata:Name {value: "prevent_self_review"}
    PreventSelfReview preventSelfReview?;
    # The branch policy that governs which branches can deploy to this environment.
    @jsondata:Name {value: "deployment_branch_policy"}
    DeploymentBranchPolicySettings? deploymentBranchPolicy?;
    # The time in minutes to wait before allowing deployments to proceed.
    @jsondata:Name {value: "wait_timer"}
    WaitTimer waitTimer?;
    # The people or teams that may review jobs that reference the environment. You can list up to six users or teams as reviewers. The reviewers must have at least read access to the repository. Only one of the required reviewers needs to approve the job for it to proceed
    ReposownerrepoenvironmentsenvironmentNameReviewers[]? reviewers?;
|};

public type AlertsalertNumberBody2 record {
    # An optional comment explaining the resolution of the secret scanning alert.
    @jsondata:Name {value: "resolution_comment"}
    SecretScanningAlertResolutionComment? resolutionComment?;
    # The state to set for the secret scanning alert.
    SecretScanningAlertState state;
    # The reason for resolving the secret scanning alert.
    SecretScanningAlertResolution? resolution?;
};

# Snapshot of a newly created repository's dependencies
public type SnapshotResponse record {
    # Either "SUCCESS", "ACCEPTED", or "INVALID". "SUCCESS" indicates that the snapshot was successfully created and the repository's dependencies were updated. "ACCEPTED" indicates that the snapshot was successfully created, but the repository's dependencies were not updated. "INVALID" indicates that the snapshot was malformed
    string result;
    # The time at which the snapshot was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # ID of the created snapshot
    int id;
    # A message providing further details about the result, such as why the dependencies were not updated
    string message;
};

# Prevent users with push access from force pushing to refs
public type RepositoryRuleNonFastForward record {
    # The rule type identifier for non-fast-forward prevention.
    "non_fast_forward" 'type;
};

public type ProtectedBranchRequiredPullRequestReviews record {
    # Users and teams allowed to dismiss pull request reviews.
    @jsondata:Name {value: "dismissal_restrictions"}
    ProtectedBranchRequiredPullRequestReviewsDismissalRestrictions dismissalRestrictions?;
    # The number of approving reviews required before merging.
    @jsondata:Name {value: "required_approving_review_count"}
    int requiredApprovingReviewCount?;
    # Indicates whether code owner review is required before merging.
    @jsondata:Name {value: "require_code_owner_reviews"}
    boolean requireCodeOwnerReviews?;
    # Indicates whether approvals are dismissed when new commits are pushed.
    @jsondata:Name {value: "dismiss_stale_reviews"}
    boolean dismissStaleReviews?;
    # Users and teams allowed to bypass required pull request reviews.
    @jsondata:Name {value: "bypass_pull_request_allowances"}
    ProtectedBranchRequiredPullRequestReviewsBypassPullRequestAllowances bypassPullRequestAllowances?;
    # Whether the most recent push must be approved by someone other than the person who pushed it
    @jsondata:Name {value: "require_last_push_approval"}
    boolean requireLastPushApproval = false;
    # The API URL for the required pull request reviews settings.
    string url;
};

# Details for the vulnerable package
public type DependabotAlertPackage record {|
    # The package's language or package management ecosystem
    string ecosystem;
    # The unique package name within its ecosystem
    string name;
|};

public type AlertsalertNumberBody1 record {|
    # An optional comment associated with dismissing the alert
    @jsondata:Name {value: "dismissed_comment"}
    string dismissedComment?;
    # The state of the Dependabot alert.
    # A dismissed_reason must be provided when setting the state to dismissed
    "dismissed"|"open" state;
    # **Required when state is dismissed.** A reason for dismissing the alert
    @jsondata:Name {value: "dismissed_reason"}
    "fix_started"|"inaccurate"|"no_bandwidth"|"not_used"|"tolerable_risk" dismissedReason?;
|};

# The public key used for setting Dependabot Secrets
public type DependabotPublicKey record {
    # The identifier for the key
    @jsondata:Name {value: "key_id"}
    string keyId;
    # The Base64 encoded public key
    string 'key;
};

# Secrets for GitHub Actions for an organization
public type OrganizationActionsSecretResponse record {
    # The total number of Actions secrets available to the organization.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # List of Actions secrets configured for the organization.
    OrganizationActionsSecret[] secrets;
};

public type UseremailsuseremailsuseremailsOneOf123 string;

# A check performed on the code of a given code change
public type CheckRunResponse record {
    # List of check runs associated with the code change.
    @jsondata:Name {value: "check_runs"}
    CheckRun[] checkRuns;
    # The total number of check runs in the response.
    @jsondata:Name {value: "total_count"}
    int totalCount;
};

# Limit interactions to a specific type of user for a specified duration
public type InteractionLimit record {
    # The type of user interaction to restrict.
    InteractionGroup 'limit;
    # The duration for which the interaction limit is active.
    InteractionExpiry expiry?;
};

# Represents the Queries record for the operation: codespaces/list-devcontainers-in-repository-for-authenticated-user
public type CodespacesListDevcontainersInRepositoryForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type DependencyGraphSpdxSbomSbom record {
    # The license under which the SPDX document is licensed
    string dataLicense;
    # The namespace for the SPDX document
    string documentNamespace;
    # The version of the SPDX specification that this document conforms to
    string spdxVersion;
    # The SPDX identifier for the SPDX document
    @jsondata:Name {value: "SPDXID"}
    string sPDXID;
    # The name of the SPDX document
    string name;
    # The name of the repository that the SPDX document describes
    string[] documentDescribes;
    # List of packages described in the SPDX SBOM document.
    DependencyGraphSpdxSbomSbomPackages[] packages;
    # Metadata about when and how the SPDX document was created.
    DependencyGraphSpdxSbomSbomCreationInfo creationInfo;
};

# Represents the Queries record for the operation: apps/list-accounts-for-plan
public type AppsListAccountsForPlanQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The property to sort the results by
    "created"|"updated" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # To return the oldest accounts first, set to asc. Ignored without the sort parameter
    "asc"|"desc" direction?;
};

# File Commit
public type FileCommit record {
    # The commit object created as a result of the file operation.
    FileCommitCommit 'commit;
    # The file content metadata after the commit operation.
    FileCommitContent? content;
};

# Represents the Queries record for the operation: gists/list-commits
public type GistsListCommitsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type RepositoryAdvisoryCreateCredits record {|
    # The username of the user credited
    string login;
    # The type of contribution credited to the user for the advisory.
    SecurityAdvisoryCreditTypes 'type;
|};

# Represents the Queries record for the operation: apps/list-subscriptions-for-authenticated-user
public type AppsListSubscriptionsForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Tag
public type Tag record {
    # The URL to download the repository as a zip archive at this tag.
    @jsondata:Name {value: "zipball_url"}
    string zipballUrl;
    # The name of the tag.
    string name;
    # The commit object that the tag points to.
    CommitSearchResultItemCommitTree 'commit;
    # The URL to download the repository as a tarball at this tag.
    @jsondata:Name {value: "tarball_url"}
    string tarballUrl;
    # The GraphQL node identifier for the tag.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents the Queries record for the operation: teams/list-projects-in-org
public type TeamsListProjectsInOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Groups of organization members that gives permissions on specified repositories
public type TeamSimple record {
    # The API URL listing repositories accessible to the team.
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
    # The API URL template listing members of the team.
    @jsondata:Name {value: "members_url"}
    string membersUrl;
    # Description of the team
    string? description;
    # The level of privacy this team should have
    string privacy?;
    # Permission that the team will have for its repositories
    string permission;
    # URL for the team
    string url;
    # The notification setting the team has set
    @jsondata:Name {value: "notification_setting"}
    string notificationSetting?;
    # Distinguished Name (DN) that team maps to within LDAP environment
    @jsondata:Name {value: "ldap_dn"}
    string ldapDn?;
    # The URL to view the team on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Name of the team
    string name;
    # Unique identifier of the team
    int id;
    # The URL-friendly identifier for the team.
    string slug;
    # The GraphQL node identifier for the team.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type DiscussionNumberCommentsBody record {
    # The discussion comment's body text
    string body;
};

public type GitTagTagger record {
    # The date and time when the tag was created.
    string date;
    # The name of the person who created the tag.
    string name;
    # The email address of the person who created the tag.
    string email;
};

public type MarketplacePurchaseMarketplacePurchase record {
    # Indicates whether the GitHub App is installed for this purchase.
    @jsondata:Name {value: "is_installed"}
    boolean isInstalled?;
    # The date and time when the free trial period ends.
    @jsondata:Name {value: "free_trial_ends_on"}
    string? freeTrialEndsOn?;
    # Indicates whether the account is currently on a free trial.
    @jsondata:Name {value: "on_free_trial"}
    boolean onFreeTrial?;
    # The date and time when the purchase was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    # The billing cycle frequency for the Marketplace plan.
    @jsondata:Name {value: "billing_cycle"}
    string billingCycle?;
    # The Marketplace listing plan associated with this purchase.
    MarketplaceListingPlan plan?;
    # The number of units purchased for the Marketplace plan.
    @jsondata:Name {value: "unit_count"}
    int? unitCount?;
    # The date and time of the next scheduled billing.
    @jsondata:Name {value: "next_billing_date"}
    string? nextBillingDate?;
};

# Represents the Queries record for the operation: teams/list-members-legacy
public type TeamsListMembersLegacyQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Filters members returned by their role in the team
    "member"|"maintainer"|"all" role = "all";
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: repos/list-deployment-statuses
public type ReposListDeploymentStatusesQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: users/list-gpg-keys-for-user
public type UsersListGpgKeysForUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type GistIdCommentsBody record {
    # The comment text
    @constraint:String {maxLength: 65535}
    string body;
};

public type ProtectedBranchRequiredSignatures record {
    # API URL for the required signatures protection rule.
    string url;
    # Indicates whether required commit signatures are enabled for the branch.
    boolean enabled;
};

# Represents the Queries record for the operation: repos/get-clones
public type ReposGetClonesQueries record {
    # The time frame to display results for
    "day"|"week" per = "day";
};

# Stargazer
public type Stargazer record {
    # The date and time when the user starred the repository.
    @jsondata:Name {value: "starred_at"}
    string starredAt;
    # The user who starred the repository.
    NullableSimpleUser? user;
};

# Protected Branch Required Status Check
public type ProtectedBranchRequiredStatusCheck record {
    # The enforcement level for required status checks on the branch.
    @jsondata:Name {value: "enforcement_level"}
    string enforcementLevel?;
    # The list of status checks required before merging.
    ProtectedBranchRequiredStatusCheckChecks[] checks;
    # API URL to retrieve the required status check contexts.
    @jsondata:Name {value: "contexts_url"}
    string contextsUrl?;
    # The list of status check context names that are required.
    string[] contexts;
    # Indicates whether branches must be up to date before merging.
    boolean strict?;
    # API URL for this required status check configuration.
    string url?;
};

public type OrgReposBody record {
    # Pass true to create an initial commit with empty README
    @jsondata:Name {value: "auto_init"}
    boolean autoInit = false;
    # Desired language or platform [.gitignore template](https://github.com/github/gitignore) to apply. Use the name of the template without the extension. For example, "Haskell"
    @jsondata:Name {value: "gitignore_template"}
    string gitignoreTemplate?;
    # Either true to allow squash-merging pull requests, or false to prevent squash-merging
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge = true;
    # Either true to allow merging pull requests with a merge commit, or false to prevent merging pull requests with merge commits
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit = true;
    # Whether the repository is private
    boolean 'private = false;
    # Whether downloads are enabled
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads = true;
    # The visibility of the repository
    "public"|"private" visibility?;
    # Either true to make this repo available as a template repository or false to prevent it
    @jsondata:Name {value: "is_template"}
    boolean isTemplate = false;
    # A short description of the repository
    string description?;
    # The id of the team that will be granted access to this repository. This is only valid when creating a repository in an organization
    @jsondata:Name {value: "team_id"}
    int teamId?;
    # Either true to allow rebase-merging pull requests, or false to prevent rebase-merging
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge = true;
    # Either true to enable issues for this repository or false to disable them
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues = true;
    # Either true to enable projects for this repository or false to disable them. **Note:** If you're creating a repository in an organization that has disabled repository projects, the default is false, and if you pass true, the API returns an error
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects = true;
    # Choose an [open source license template](https://choosealicense.com/) that best suits your needs, and then use the [license keyword](https://docs.github.com/articles/licensing-a-repository/#searching-github-by-license-type) as the license_template string. For example, "mit" or "mpl-2.0"
    @jsondata:Name {value: "license_template"}
    string licenseTemplate?;
    # Either true to enable the wiki for this repository or false to disable it
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki = true;
    # Either true to allow auto-merge on pull requests, or false to disallow auto-merge
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge = false;
    # Either true to allow squash-merge commits to use pull request title, or false to use commit message. **This property has been deprecated. Please use squash_merge_commit_title instead
    # 
    # # Deprecated
    @jsondata:Name {value: "use_squash_pr_title_as_default"}
    @deprecated
    boolean useSquashPrTitleAsDefault = false;
    # The default value for a merge commit title.
    # 
    # - PR_TITLE - default to the pull request's title.
    # - MERGE_MESSAGE - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name)
    @jsondata:Name {value: "merge_commit_title"}
    "PR_TITLE"|"MERGE_MESSAGE" mergeCommitTitle?;
    # The name of the repository
    string name;
    # The default value for a squash merge commit message:
    # 
    # - PR_BODY - default to the pull request's body.
    # - COMMIT_MESSAGES - default to the branch's commit messages.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "squash_merge_commit_message"}
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squashMergeCommitMessage?;
    # Either true to allow automatically deleting head branches when pull requests are merged, or false to prevent automatic deletion. **The authenticated user must be an organization owner to set this property to true.**
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge = false;
    # The default value for a merge commit message.
    # 
    # - PR_TITLE - default to the pull request's title.
    # - PR_BODY - default to the pull request's body.
    # - BLANK - default to a blank commit message
    @jsondata:Name {value: "merge_commit_message"}
    "PR_BODY"|"PR_TITLE"|"BLANK" mergeCommitMessage?;
    # The default value for a squash merge commit title:
    # 
    # - PR_TITLE - default to the pull request's title.
    # - COMMIT_OR_PR_TITLE - default to the commit's title (if only one commit) or the pull request's title (when more than one commit)
    @jsondata:Name {value: "squash_merge_commit_title"}
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squashMergeCommitTitle?;
    # A URL with more information about the repository
    string homepage?;
};

public type ReviewIdEventsBody record {
    # The body text of the pull request review
    string body?;
    # The review action you want to perform. The review actions include: APPROVE, REQUEST_CHANGES, or COMMENT. When you leave this blank, the API returns _HTTP 422 (Unrecognizable entity)_ and sets the review action state to PENDING, which means you will need to re-submit the pull request review using a review action
    "APPROVE"|"REQUEST_CHANGES"|"COMMENT" event;
};

# A repository on GitHub
public type RepositoryResponse record {
    # Indicates whether all or selected repositories are included.
    @jsondata:Name {value: "repository_selection"}
    string repositorySelection?;
    # The list of repositories returned in this response.
    Repository[] repositories;
    # The total number of repositories matching the request.
    @jsondata:Name {value: "total_count"}
    int totalCount;
};

# Represents the Queries record for the operation: orgs/list-blocked-users
public type OrgsListBlockedUsersQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type ActionsVariablesBody record {
    # An array of repository ids that can access the organization variable. You can only provide a list of repository ids when the visibility is set to selected
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds?;
    # The type of repositories in the organization that can access the variable. selected means only the repositories specified by selected_repository_ids can access the variable
    "all"|"private"|"selected" visibility;
    # The name of the variable
    string name;
    # The value of the variable
    string value;
};

public type PullRequestHeadRepoLicense record {
    # The full name of the license.
    string name;
    # The SPDX identifier for the license.
    @jsondata:Name {value: "spdx_id"}
    string? spdxId;
    # The unique key identifying the license.
    string 'key;
    # API URL for the license details.
    string? url;
    # The GraphQL node identifier for the license.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# A codespace
public type CodespaceWithFullRepository record {
    # UUID identifying this codespace's environment
    @jsondata:Name {value: "environment_id"}
    string? environmentId;
    # Whether or not a codespace has a pending async operation. This would mean that the codespace is temporarily unavailable. The only thing that you can do with a codespace in this state is delete it
    @jsondata:Name {value: "pending_operation"}
    boolean? pendingOperation?;
    # The user to whom the codespace usage is billed.
    @jsondata:Name {value: "billable_owner"}
    SimpleUser billableOwner;
    # API URL to start this codespace
    @jsondata:Name {value: "start_url"}
    string startUrl;
    # The date and time when the codespace was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # API URL to stop this codespace
    @jsondata:Name {value: "stop_url"}
    string stopUrl;
    # The full repository associated with this codespace.
    FullRepository repository;
    # Last known time this codespace was started
    @jsondata:Name {value: "last_used_at"}
    string lastUsedAt;
    # Whether the codespace was created from a prebuild
    boolean? prebuild;
    # The date and time when the codespace was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # When a codespace will be auto-deleted based on the "retention_period_minutes" and "last_used_at"
    @jsondata:Name {value: "retention_expires_at"}
    string? retentionExpiresAt?;
    # Unique numeric identifier for the codespace.
    int id;
    # State of this codespace
    "Unknown"|"Created"|"Queued"|"Provisioning"|"Available"|"Awaiting"|"Unavailable"|"Deleted"|"Moved"|"Shutdown"|"Archived"|"Starting"|"ShuttingDown"|"Failed"|"Exporting"|"Updating"|"Rebuilding" state;
    # The current Git status of the codespace repository.
    @jsondata:Name {value: "git_status"}
    CodespaceGitStatus gitStatus;
    # API URL to publish this codespace to a new repository
    @jsondata:Name {value: "publish_url"}
    string? publishUrl?;
    # API URL to access available alternate machine types for this codespace
    @jsondata:Name {value: "machines_url"}
    string machinesUrl;
    # The user who owns this codespace.
    SimpleUser owner;
    # The runtime constraints applied to this codespace.
    @jsondata:Name {value: "runtime_constraints"}
    CodespaceRuntimeConstraints runtimeConstraints?;
    # List of recently opened folders within the codespace.
    @jsondata:Name {value: "recent_folders"}
    string[] recentFolders;
    # Duration in minutes after codespace has gone idle in which it will be deleted. Must be integer minutes between 0 and 43200 (30 days)
    @jsondata:Name {value: "retention_period_minutes"}
    int? retentionPeriodMinutes?;
    # Display name for this codespace
    @jsondata:Name {value: "display_name"}
    string? displayName?;
    # API URL for this codespace
    string url;
    # Path to devcontainer.json from repo root used to create Codespace
    @jsondata:Name {value: "devcontainer_path"}
    string? devcontainerPath?;
    # Text to show user when codespace is disabled by a pending operation
    @jsondata:Name {value: "pending_operation_disabled_reason"}
    string? pendingOperationDisabledReason?;
    # URL to access this codespace on the web
    @jsondata:Name {value: "web_url"}
    string webUrl;
    # The machine type allocated for this codespace.
    NullableCodespaceMachine? machine;
    # Automatically generated name of this codespace
    string name;
    # API URL for the Pull Request associated with this codespace, if any
    @jsondata:Name {value: "pulls_url"}
    string? pullsUrl;
    # The initally assigned location of a new codespace
    "EastUs"|"SouthEastAsia"|"WestEurope"|"WestUs2" location;
    # Text to show user when codespace idle timeout minutes has been overriden by an organization policy
    @jsondata:Name {value: "idle_timeout_notice"}
    string? idleTimeoutNotice?;
    # The number of minutes of inactivity after which this codespace will be automatically stopped
    @jsondata:Name {value: "idle_timeout_minutes"}
    int? idleTimeoutMinutes;
};

# Identifies the configuration under which the analysis was executed. Used to distinguish between multiple analyses for the same tool and commit, but performed on different languages or different parts of the code
public type CodeScanningAnalysisCategory string;

public type RepoTopicsBody record {
    # An array of topics to add to the repository. Pass one or more topics to _replace_ the set of existing topics. Send an empty array ([]) to clear all topics from the repository. **Note:** Topic names cannot contain uppercase letters
    string[] names;
};

# Represents the Queries record for the operation: users/list-followers-for-authenticated-user
public type UsersListFollowersForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# The billing plan for the organization
public type OrganizationPlan record {
    # The number of private repositories allowed under this plan.
    @jsondata:Name {value: "private_repos"}
    int privateRepos?;
    # The number of seats currently in use.
    @jsondata:Name {value: "filled_seats"}
    int filledSeats?;
    # The name of the billing plan.
    string name?;
    # The total number of seats available under this plan.
    int seats?;
    # The total storage space allocated under this plan in bytes.
    int space?;
};

# Represents the Queries record for the operation: teams/list-repos-in-org
public type TeamsListReposInOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: users/get-context-for-user
public type UsersGetContextForUserQueries record {
    # Uses the ID for the subject_type you specified. **Required** when using subject_type
    @http:Query {name: "subject_id"}
    string subjectId?;
    # Identifies which additional information you'd like to receive about the person's hovercard. Can be organization, repository, issue, pull_request. **Required** when using subject_id
    @http:Query {name: "subject_type"}
    "organization"|"repository"|"issue"|"pull_request" subjectType?;
};

public type RepoRulesetsBody record {
    # The actors that can bypass the rules in this ruleset
    @jsondata:Name {value: "bypass_actors"}
    RepositoryRulesetBypassActor[] bypassActors?;
    # The name of the ruleset
    string name;
    # The enforcement level for this ruleset.
    RepositoryRuleEnforcement enforcement;
    # An array of rules within the ruleset
    RepositoryRule[] rules?;
    # The conditions that determine which refs the ruleset applies to.
    RepositoryRulesetConditions conditions?;
    # The target of the ruleset
    "branch"|"tag" target?;
};

# Represents the Queries record for the operation: gists/list-comments
public type GistsListCommentsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# An invocation of a workflow
public type WorkflowRun record {
    # The ID of the parent workflow
    @jsondata:Name {value: "workflow_id"}
    int workflowId;
    # The head commit associated with this workflow run.
    @jsondata:Name {value: "head_commit"}
    NullableSimpleCommit? headCommit;
    # The start time of the latest run. Resets on re-run
    @jsondata:Name {value: "run_started_at"}
    string runStartedAt?;
    # The branch from which the workflow run was triggered.
    @jsondata:Name {value: "head_branch"}
    string? headBranch;
    # The URL to the associated check suite
    @jsondata:Name {value: "check_suite_url"}
    string checkSuiteUrl;
    # The URL to the artifacts for the workflow run
    @jsondata:Name {value: "artifacts_url"}
    string artifactsUrl;
    # The event-specific title associated with the run or the run-name if set, or the value of run-name if it is set in the workflow
    @jsondata:Name {value: "display_title"}
    string displayTitle;
    # The URL to download the logs for the workflow run
    @jsondata:Name {value: "logs_url"}
    string logsUrl;
    # The date and time when the workflow run was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The URL to the jobs for the workflow run
    @jsondata:Name {value: "jobs_url"}
    string jobsUrl;
    # The repository where the workflow run occurred.
    MinimalRepository repository;
    # The SHA of the head commit that points to the version of the workflow being run
    @jsondata:Name {value: "head_sha"}
    string headSha;
    # The final result of the completed workflow run.
    string? conclusion;
    # The URL to rerun the workflow run
    @jsondata:Name {value: "rerun_url"}
    string rerunUrl;
    # The full path of the workflow
    string path;
    # Pull requests that are open with a head_sha or head_branch that matches the workflow run. The returned pull requests do not necessarily indicate pull requests that triggered the run
    @jsondata:Name {value: "pull_requests"}
    PullRequestMinimal[]? pullRequests;
    # The date and time when the workflow run was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The URL to the previous attempted run of this workflow, if one exists
    @jsondata:Name {value: "previous_attempt_url"}
    string? previousAttemptUrl?;
    # The ID of the workflow run
    int id;
    # The repository containing the head branch for this run.
    @jsondata:Name {value: "head_repository"}
    MinimalRepository headRepository;
    # The event that triggered the workflow run.
    string event;
    # The user who triggered the workflow run.
    @jsondata:Name {value: "triggering_actor"}
    SimpleUser triggeringActor?;
    # The ID of the associated check suite
    @jsondata:Name {value: "check_suite_id"}
    int checkSuiteId?;
    # The URL to the workflow
    @jsondata:Name {value: "workflow_url"}
    string workflowUrl;
    # The node ID of the associated check suite
    @jsondata:Name {value: "check_suite_node_id"}
    string checkSuiteNodeId?;
    # The unique identifier of the head repository.
    @jsondata:Name {value: "head_repository_id"}
    int headRepositoryId?;
    # The URL to the workflow run
    string url;
    # The user who initiated the workflow run.
    SimpleUser actor?;
    # List of reusable workflows referenced by this workflow run.
    @jsondata:Name {value: "referenced_workflows"}
    ReferencedWorkflow[]? referencedWorkflows?;
    # The URL to view the workflow run on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The name of the workflow run
    string? name?;
    # The auto incrementing run number for the workflow run
    @jsondata:Name {value: "run_number"}
    int runNumber;
    # Attempt number of the run, 1 for first attempt and higher if the workflow was re-run
    @jsondata:Name {value: "run_attempt"}
    int runAttempt?;
    # The URL to cancel the workflow run
    @jsondata:Name {value: "cancel_url"}
    string cancelUrl;
    # The GraphQL node identifier for this workflow run.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The current status of the workflow run.
    string? status;
};

# Represents the Queries record for the operation: apps/list-plans-stubbed
public type AppsListPlansStubbedQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type HookConfig record {
    # The password used for authentication with the webhook endpoint.
    string password?;
    # The media type used to serialize webhook payloads.
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    # Determines whether SSL verification is bypassed for webhook delivery.
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    # The digest value used for webhook payload verification.
    string digest?;
    # The subdomain used for the webhook service integration.
    string subdomain?;
    # The secret token used to sign webhook payloads.
    WebhookConfigSecret secret?;
    # The email address associated with the webhook configuration.
    string email?;
    # The chat room associated with the webhook integration.
    string room?;
    # The URL to which webhook payloads are delivered.
    WebhookConfigUrl url?;
    # The authentication token for the webhook service integration.
    string token?;
};

# Identifies the configuration under which the analysis was executed. For example, in GitHub Actions this includes the workflow filename and job name
public type CodeScanningAnalysisAnalysisKey string;

public type ActionsCacheUsageOrgEnterprise record {
    # The total size in bytes of all active cache items across all repositories of an enterprise or an organization
    @jsondata:Name {value: "total_active_caches_size_in_bytes"}
    int totalActiveCachesSizeInBytes;
    # The count of active caches across all repositories of an enterprise or an organization
    @jsondata:Name {value: "total_active_caches_count"}
    int totalActiveCachesCount;
};

public type ContributorActivityWeeks record {
    # The number of lines added during the week.
    int a?;
    # The number of commits made during the week.
    int c?;
    # The number of lines deleted during the week.
    int d?;
    # The start of the week as a Unix timestamp.
    int w?;
};

# A GitHub organization
public type OrganizationSimple record {
    # API URL to retrieve issues for the organization.
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # API URL to retrieve repositories for the organization.
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    # URL of the organization's avatar image.
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    # API URL to retrieve events for the organization.
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # API URL template to retrieve members of the organization.
    @jsondata:Name {value: "members_url"}
    string membersUrl;
    # A short description of the organization.
    string? description;
    # Unique numeric identifier for the organization.
    int id;
    # API URL to retrieve webhooks for the organization.
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    # The login name of the organization.
    string login;
    # API URL for this organization.
    string url;
    # The GraphQL node identifier for the organization.
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # API URL template to retrieve public members of the organization.
    @jsondata:Name {value: "public_members_url"}
    string publicMembersUrl;
};

# How the author is associated with the repository
public type AuthorAssociation "COLLABORATOR"|"CONTRIBUTOR"|"FIRST_TIMER"|"FIRST_TIME_CONTRIBUTOR"|"MANNEQUIN"|"MEMBER"|"NONE"|"OWNER";

# Details of a deployment environment
public type Environment record {
    # The time that the environment was last updated, in ISO 8601 format
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # URL to view the environment on GitHub.
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The name of the environment
    string name;
    # Built-in deployment protection rules for the environment
    @jsondata:Name {value: "protection_rules"}
    EnvironmentProtectionRules[] protectionRules?;
    # The branch policy settings controlling which branches can deploy.
    @jsondata:Name {value: "deployment_branch_policy"}
    DeploymentBranchPolicySettings? deploymentBranchPolicy?;
    # The time that the environment was created, in ISO 8601 format
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The id of the environment
    int id;
    # API URL for this deployment environment.
    string url;
    # The GraphQL node identifier for this environment.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents the Queries record for the operation: packages/get-all-package-versions-for-package-owned-by-authenticated-user
public type PackagesGetAllPackageVersionsForPackageOwnedByAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # The state of the package, either active or deleted
    "active"|"deleted" state = "active";
};

public type PullRequestMinimal record {
    # The head branch information for the pull request.
    PullRequestMinimalHead head;
    # The pull request number within the repository.
    int number;
    # Unique numeric identifier for the pull request.
    int id;
    # API URL for this pull request.
    string url;
    # The base branch information for the pull request.
    PullRequestMinimalHead base;
};

public type ReposownerrepoissuesissueNumberlabelsOneOf1 record {
    # The names of the labels to set for the issue. The labels you set replace any existing labels. You can pass an empty array to remove all labels. Alternatively, you can pass a single label as a string or an array of labels directly, but GitHub recommends passing an object with the labels key. You can also add labels to the existing labels for an issue. For more information, see "[Add labels to an issue](https://docs.github.com/rest/issues/labels#add-labels-to-an-issue)."
    @constraint:Array {minLength: 1}
    string[] labels?;
};

public type workflowId int|string;

# Represents the Queries record for the operation: orgs/list-memberships-for-authenticated-user
public type OrgsListMembershipsForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Indicates the state of the memberships to return. If not specified, the API returns both active and pending memberships
    "active"|"pending" state?;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: activity/list-repo-notifications-for-authenticated-user
public type ActivityListRepoNotificationsForAuthenticatedUserQueries record {
    # If true, show notifications marked as read
    boolean all = false;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Only show notifications updated before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string before?;
    # If true, only shows notifications in which the user is directly participating or mentioned
    boolean participating = false;
    # Page number of the results to fetch
    int page = 1;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ
    string since?;
};

public type ReviewCustomGatesCommentRequired record {
    # Comment associated with the pending deployment protection rule. **Required when state is not provided.**
    string comment;
    # The name of the environment to approve or reject
    @jsondata:Name {value: "environment_name"}
    string environmentName;
};

# Pull Request Reviews are reviews on pull requests
public type PullRequestReview record {
    # The HTML-rendered body of the review
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    # Hypermedia links related to the pull request review.
    @jsondata:Name {value: "_links"}
    PullRequestReviewLinks links;
    # The date the review was submitted
    @jsondata:Name {value: "submitted_at"}
    string submittedAt?;
    # The plain text body of the review
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    # API URL for the reviewed pull request
    @jsondata:Name {value: "pull_request_url"}
    string pullRequestUrl;
    # The text of the review
    string body;
    # The association of the reviewer with the repository
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # URL of the review on GitHub
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Unique identifier of the review
    int id;
    # The state of the review
    string state;
    # The user who submitted the pull request review.
    NullableSimpleUser? user;
    # A commit SHA for the review. If the commit object was garbage collected or forcibly deleted, then it no longer exists in Git and this value will be null
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # The GraphQL node identifier of the review
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents an 'issue_body' secret scanning location type. This location type shows that a secret was detected in the body of an issue
public type SecretScanningLocationIssueBody record {
    # The API URL to get the issue where the secret was detected
    @jsondata:Name {value: "issue_body_url"}
    string issueBodyUrl;
};

public type EnvironmentProtectionRules ProtectionRulesAnyOf1|ProtectionRulesProtectionRulesAnyOf12|ProtectionRulesProtectionRulesProtectionRulesAnyOf123;

# Represents the Queries record for the operation: checks/list-suites-for-ref
public type ChecksListSuitesForRefQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Returns check runs with the specified name
    @http:Query {name: "check_name"}
    string checkName?;
    # Page number of the results to fetch
    int page = 1;
    # Filters check suites by GitHub App id
    @http:Query {name: "app_id"}
    int appId?;
};

public type DiscussionsdiscussionNumberBody record {
    # The discussion post's title
    string title?;
    # The discussion post's body text
    string body?;
};

# Code Search Result Item
public type CodeSearchResultItemResponse record {
    # The total number of code search results found.
    @jsondata:Name {value: "total_count"}
    int totalCount;
    # Indicates whether the search results are incomplete.
    @jsondata:Name {value: "incomplete_results"}
    boolean incompleteResults;
    # The list of code search result items returned.
    CodeSearchResultItem[] items;
};

@constraint:Array {minLength: 1}
public type ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf1234 ReposownerrepoissuesissueNumberlabelsLabels[];

# A comment made to a gist
public type GistComment record {
    # The commenter's association with the gist's repository.
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # The date and time when the comment was last updated.
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The date and time when the comment was created.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Unique numeric identifier for the comment.
    int id;
    # The comment text
    @constraint:String {maxLength: 65535}
    string body;
    # The user who created the comment.
    NullableSimpleUser? user;
    # API URL for this gist comment.
    string url;
    # The GraphQL node identifier for this comment.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents the Queries record for the operation: codespaces/repo-machines-for-authenticated-user
public type CodespacesRepoMachinesForAuthenticatedUserQueries record {
    # The branch or commit to check for prebuild availability and devcontainer restrictions
    string ref?;
    # The location to check for available machines. Assigned by IP if not provided
    string location?;
    # IP for location auto-detection when proxying a request
    @http:Query {name: "client_ip"}
    string clientIp?;
};

# Added to Project Issue Event
public type AddedToProjectIssueEvent record {
    # The user who triggered this issue event.
    SimpleUser actor;
    # API URL for the commit associated with this event.
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    # The GitHub App that performed this event, if any.
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    # The date and time when this event occurred.
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Unique numeric identifier for this issue event.
    int id;
    # The type of event that occurred on the issue.
    string event;
    # The SHA of the commit associated with this event.
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    # API URL for this issue event.
    string url;
    # The project card associated with this event.
    @jsondata:Name {value: "project_card"}
    RemovedFromProjectIssueEventProjectCard projectCard?;
    # The GraphQL node identifier for this issue event.
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type HookshookIdBody1 record {
    # Determines a list of events to be removed from the list of events that the Hook triggers for
    @jsondata:Name {value: "remove_events"}
    string[] removeEvents?;
    # Determines if notifications are sent when the webhook is triggered. Set to true to send notifications
    boolean active = true;
    # Determines a list of events to be added to the list of events that the Hook triggers for
    @jsondata:Name {value: "add_events"}
    string[] addEvents?;
    # Configuration object for the webhook including URL and content type.
    ReposownerrepohookshookIdConfig config?;
    # Determines what [events](https://docs.github.com/webhooks/event-payloads) the hook is triggered for. This replaces the entire array of events
    string[] events = ["push"];
};

public type GitRefsBody record {
    # The name of the fully qualified reference (ie: refs/heads/master). If it doesn't start with 'refs' and have at least two slashes, it will be rejected
    string ref;
    # The SHA1 value for this reference
    string sha;
};

# Information about the Git committer
public type SimpleCommitCommitter record {
    # Name of the commit's committer
    string name;
    # Git email address of the commit's committer
    string email;
};

# The REST API URL of the analysis resource
public type CodeScanningAnalysisUrl string;

# Represents the Queries record for the operation: teams/list-child-in-org
public type TeamsListChildInOrgQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type RepoSearchResultItemPermissions record {
    # Indicates whether the user has pull permission on the repository.
    boolean pull;
    # Indicates whether the user has maintain permission on the repository.
    boolean maintain?;
    # Indicates whether the user has admin permission on the repository.
    boolean admin;
    # Indicates whether the user has triage permission on the repository.
    boolean triage?;
    # Indicates whether the user has push permission on the repository.
    boolean push;
};

# Parameters to be used for the tag_name_pattern rule
public type RepositoryRuleTagNamePattern record {
    # Identifies this rule as a tag name pattern rule.
    "tag_name_pattern" 'type;
    # The pattern parameters applied to tag name matching.
    RepositoryRuleBranchNamePatternParameters parameters?;
};

public type SelectedRepositoryIdsSelectedRepositoryIdsAnyOf12 string;

# Represents the Queries record for the operation: orgs/list-public-members
public type OrgsListPublicMembersQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Contributor Activity
public type ContributorActivity record {
    # The total number of commits made by the contributor.
    int total;
    # Weekly breakdown of the contributor's commit activity.
    ContributorActivityWeeks[] weeks;
    # The contributor whose activity is being reported.
    NullableSimpleUser? author;
};

public type TokenScopedBody record {
    # The access token used to authenticate to the GitHub API
    @jsondata:Name {value: "access_token"}
    string accessToken;
    # The list of repository IDs to scope the user access token to. repository_ids may not be specified if repositories is specified
    @jsondata:Name {value: "repository_ids"}
    int[] repositoryIds?;
    # The list of repository names to scope the user access token to. repositories may not be specified if repository_ids is specified
    string[] repositories?;
    # The permissions granted to the scoped user access token.
    AppPermissions permissions?;
    # The ID of the user or organization to scope the user access token to. **Required** unless target is specified
    @jsondata:Name {value: "target_id"}
    int targetId?;
    # The name of the user or organization to scope the user access token to. **Required** unless target_id is specified
    string target?;
};

# Represents the Queries record for the operation: git/get-tree
public type GitGetTreeQueries record {
    # Setting this parameter to any value returns the objects or subtrees referenced by the tree specified in :tree_sha. For example, setting recursive to any of the following will enable returning objects or subtrees: 0, 1, "true", and "false". Omit this parameter to prevent recursively returning objects or subtrees
    string recursive?;
};

public type RenamedIssueEventRename record {
    # The previous title of the issue before renaming.
    string 'from;
    # The new title of the issue after renaming.
    string to;
};

# A GitHub Classroom assignment
public type ClassroomAssignment record {
    # The selected editor for the assignment
    string editor;
    # Whether feedback pull request will be created when a student accepts the assignment
    @jsondata:Name {value: "feedback_pull_requests_enabled"}
    boolean feedbackPullRequestsEnabled;
    # Whether the invitation link is enabled. Visiting an enabled invitation link will accept the assignment
    @jsondata:Name {value: "invitations_enabled"}
    boolean invitationsEnabled;
    # Whether students are admins on created repository when a student accepts the assignment
    @jsondata:Name {value: "students_are_repo_admins"}
    boolean studentsAreRepoAdmins;
    # The number of students that have accepted the assignment
    int accepted;
    # The programming language used in the assignment
    string language;
    # The classroom to which this assignment belongs.
    Classroom classroom;
    # Assignment title
    string title;
    # Whether it's a group assignment or individual assignment
    "individual"|"group" 'type;
    # The link that a student can use to accept the assignment
    @jsondata:Name {value: "invite_link"}
    string inviteLink;
    # The repository used as starter code for the assignment.
    @jsondata:Name {value: "starter_code_repository"}
    SimpleClassroomRepository starterCodeRepository;
    # The number of students that have submitted the assignment
    int submitted;
    # The maximum allowable teams for the assignment
    @jsondata:Name {value: "max_teams"}
    int? maxTeams;
    # Whether an accepted assignment creates a public repository
    @jsondata:Name {value: "public_repo"}
    boolean publicRepo;
    # The maximum allowable members per team
    @jsondata:Name {value: "max_members"}
    int? maxMembers;
    # Unique identifier of the repository
    int id;
    # The number of students that have passed the assignment
    int passing;
    # The time at which the assignment is due
    string? deadline;
    # Sluggified name of the assignment
    string slug;
};

# Represents the Queries record for the operation: teams/list-projects-legacy
public type TeamsListProjectsLegacyQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: repos/list-collaborators
public type ReposListCollaboratorsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Filter collaborators returned by their affiliation. outside means all outside collaborators of an organization-owned repository. direct means all collaborators with permissions to an organization-owned repository, regardless of organization membership status. all means all collaborators the authenticated user can see
    "outside"|"direct"|"all" affiliation = "all";
    # Filter collaborators by the permissions they have on the repository. If not specified, all collaborators will be returned
    "pull"|"triage"|"push"|"maintain"|"admin" permission?;
    # Page number of the results to fetch
    int page = 1;
};

public type GlobalAdvisoryIdentifiers record {
    # The type of identifier
    "CVE"|"GHSA" 'type;
    # The identifier value
    string value;
};

@constraint:Array {maxLength: 1000}
public type AffectsAffectsOneOf12 string[];

# Community Profile
public type CommunityProfile record {
    # The overall community health score as a percentage.
    @jsondata:Name {value: "health_percentage"}
    int healthPercentage;
    # The date and time when the community profile was last updated.
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    # URL to the repository's documentation.
    string? documentation;
    # The description of the repository.
    string? description;
    # Community health files present in the repository.
    CommunityProfileFiles files;
    # Indicates whether content reporting is enabled for the repository.
    @jsondata:Name {value: "content_reports_enabled"}
    boolean contentReportsEnabled?;
};

# Represents the Queries record for the operation: repos/list-contributors
public type ReposListContributorsQueries record {
    # Set to 1 or true to include anonymous contributors in results
    string anon?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: reactions/list-for-team-discussion-legacy
public type ReactionsListForTeamDiscussionLegacyQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Returns a single [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions). Omit this parameter to list all reactions to a team discussion
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content?;
};

public type TeamsteamSlugBody record {
    # The ID of a team to set as the parent team
    @jsondata:Name {value: "parent_team_id"}
    int? parentTeamId?;
    # The name of the team
    string name?;
    # The description of the team
    string description?;
    # The level of privacy this team should have. Editing teams without specifying this parameter leaves privacy intact. When a team is nested, the privacy for parent teams cannot be secret. The options are:  
    # **For a non-nested team:**  
    #  * secret - only visible to organization owners and members of this team.  
    #  * closed - visible to all members of this organization.  
    # **For a parent or child team:**  
    #  * closed - visible to all members of this organization
    "secret"|"closed" privacy?;
    # **Deprecated**. The permission that new repositories will be added to the team with when none is specified
    "pull"|"push"|"admin" permission = "pull";
    # The notification setting the team has chosen. Editing teams without specifying this parameter leaves notification_setting intact. The options are: 
    #  * notifications_enabled - team members receive notifications when the team is @mentioned.  
    #  * notifications_disabled - no one receives notifications
    @jsondata:Name {value: "notification_setting"}
    "notifications_enabled"|"notifications_disabled" notificationSetting?;
};

public type ClientIdGrantBody record {
    # The OAuth access token used to authenticate to the GitHub API
    @jsondata:Name {value: "access_token"}
    string accessToken;
};
