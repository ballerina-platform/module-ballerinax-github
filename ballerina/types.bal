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
    @jsondata:Name {value: "secret_scanning_push_protection"}
    SecurityAndAnalysisAdvancedSecurity secretScanningPushProtection?;
    @jsondata:Name {value: "dependabot_security_updates"}
    SecurityAndAnalysisDependabotSecurityUpdates dependabotSecurityUpdates?;
    @jsondata:Name {value: "secret_scanning"}
    SecurityAndAnalysisAdvancedSecurity secretScanning?;
    @jsondata:Name {value: "advanced_security"}
    SecurityAndAnalysisAdvancedSecurity advancedSecurity?;
};

# Authentication Token
public type AuthenticationToken record {
    # Describe whether all repositories have been selected or there's a selection involved
    @jsondata:Name {value: "repository_selection"}
    "all"|"selected" repositorySelection?;
    @jsondata:Name {value: "single_file"}
    string? singleFile?;
    # The time this token expires
    @jsondata:Name {value: "expires_at"}
    string expiresAt;
    # The repositories this token has access to
    Repository[] repositories?;
    record {} permissions?;
    # The token used for authentication
    string token;
};

public type TeamPermissions record {
    boolean pull;
    boolean maintain;
    boolean admin;
    boolean triage;
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
    @jsondata:Name {value: "line_numbers"}
    string[] lineNumbers?;
    string? language?;
    MinimalRepository repository;
    string sha;
    string url;
    @jsondata:Name {value: "file_size"}
    int fileSize?;
    @jsondata:Name {value: "last_modified_at"}
    string lastModifiedAt?;
    string path;
    decimal score;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "text_matches"}
    SearchResultTextMatches textMatches?;
    string name;
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
    string name?;
    int id?;
    @jsondata:Name {value: "topic_id"}
    int topicId?;
    @jsondata:Name {value: "relation_type"}
    string relationType?;
};

# Minimal Repository
public type MinimalRepositoryResponse record {
    MinimalRepository[] repositories;
    @jsondata:Name {value: "total_count"}
    int totalCount;
};

public type FileCommitCommitParents record {
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    string sha?;
    string url?;
};

# Information about the seat breakdown and policies set for an organization with a Copilot for Business subscription
public type CopilotOrganizationDetails record {
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
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
    @jsondata:Name {value: "project_card"}
    AddedToProjectIssueEventProjectCard projectCard?;
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
    NullableSimpleUser? creator;
    @jsondata:Name {value: "avatar_url"}
    string? avatarUrl;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "target_url"}
    string? targetUrl;
    string context;
    string? description;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string state;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Api Overview
public type ApiOverview record {
    @jsondata:Name {value: "ssh_key_fingerprints"}
    ApiOverviewSshKeyFingerprints sshKeyFingerprints?;
    string[] importer?;
    @jsondata:Name {value: "verifiable_password_authentication"}
    boolean verifiablePasswordAuthentication;
    ApiOverviewDomains domains?;
    string[] packages?;
    @jsondata:Name {value: "github_enterprise_importer"}
    string[] githubEnterpriseImporter?;
    @jsondata:Name {value: "ssh_keys"}
    string[] sshKeys?;
    string[] git?;
    string[] pages?;
    string[] web?;
    string[] api?;
    string[] hooks?;
    string[] actions?;
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
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "requested_team"}
    Team requestedTeam?;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    @jsondata:Name {value: "review_requester"}
    SimpleUser reviewRequester;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    @jsondata:Name {value: "requested_reviewer"}
    SimpleUser requestedReviewer?;
    int id;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type UseremailsuseremailsOneOf112 string[];

public type RepositoryRulesetConditionsRepositoryNameTargetRepositoryName record {
    # Array of repository names or patterns to include. One of these patterns must match for the condition to pass. Also accepts `~ALL` to include all repositories
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
    # For example, `day` will filter for rule suites that occurred in the past 24 hours, and `week` will filter for insights that occurred in the past 7 days (168 hours)
    @http:Query {name: "time_period"}
    "hour"|"day"|"week"|"month" timePeriod = "day";
    # The rule results to filter on. When specified, only suites with this result will be returned
    @http:Query {name: "rule_suite_result"}
    "pass"|"fail"|"bypass"|"all" ruleSuiteResult = "all";
};

public type RateLimitOverviewResources record {
    RateLimit core;
    RateLimit scim?;
    RateLimit search;
    @jsondata:Name {value: "source_import"}
    RateLimit sourceImport?;
    @jsondata:Name {value: "actions_runner_registration"}
    RateLimit actionsRunnerRegistration?;
    RateLimit graphql?;
    @jsondata:Name {value: "code_scanning_upload"}
    RateLimit codeScanningUpload?;
    @jsondata:Name {value: "integration_manifest"}
    RateLimit integrationManifest?;
    @jsondata:Name {value: "code_search"}
    RateLimit codeSearch?;
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
    # Only show fine-grained personal access tokens used before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    @http:Query {name: "last_used_before"}
    string lastUsedBefore?;
    # Only show fine-grained personal access tokens used after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
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
    @jsondata:Name {value: "total_count"}
    int totalCount;
    @jsondata:Name {value: "incomplete_results"}
    boolean incompleteResults;
    UserSearchResultItem[] items;
};

public type RepoCheckSuitesBody record {
    # The sha of the head commit
    @jsondata:Name {value: "head_sha"}
    string headSha;
};

# An artifact
public type ArtifactResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
    Artifact[] artifacts;
};

public type ReposownerrepobranchesbranchprotectionrestrictionsappsreposownerrepobranchesbranchprotectionrestrictionsappsOneOf112 string[];

@constraint:Array {minLength: 1}
public type ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf11234 ReposownerrepoissuesissueNumberlabelsLabels[];

# The name of the status checks
public type ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsreposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf112 string[];

public type RepositoryAdvisoryCreateVulnerabilities record {|
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

public type DependencyGraphDiffInner_vulnerabilities record {
    string severity;
    string advisory_ghsa_id;
    string advisory_summary;
    string advisory_url;
};

public type RepoPullsBody record {
    # The name of the branch where your changes are implemented. For cross-repository pull requests in the same network, namespace `head` with a user like this: `username:branch`
    string head;
    # An issue in the repository to convert to a pull request. The issue title, body, and comments will become the title, body, and comments on the new pull request. Required unless `title` is specified
    int issue?;
    # The name of the repository where the changes in the pull request were made. This field is required for cross-repository pull requests if both repositories are owned by the same organization
    @jsondata:Name {value: "head_repo"}
    string headRepo?;
    # Indicates whether the pull request is a draft. See "[Draft Pull Requests](https://docs.github.com/articles/about-pull-requests#draft-pull-requests)" in the GitHub Help documentation to learn more
    boolean draft?;
    # Indicates whether [maintainers can modify](https://docs.github.com/articles/allowing-changes-to-a-pull-request-branch-created-from-a-fork/) the pull request
    @jsondata:Name {value: "maintainer_can_modify"}
    boolean maintainerCanModify?;
    # The title of the new pull request. Required unless `issue` is specified
    string title?;
    # The contents of the pull request
    string body?;
    # The name of the branch you want the changes pulled into. This should be an existing branch on the current repository. You cannot submit a pull request to one repository that requests a merge to a base of another repository
    string base;
};

# Code of Conduct Simple
public type NullableCodeOfConductSimple record {
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    string name;
    string url;
    string 'key;
};

# Key/value pairs to provide settings for this webhook
public type ReposownerrepohooksConfig record {
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    string digest?;
    WebhookConfigSecret secret?;
    WebhookConfigUrl url?;
    string token?;
};

# View Traffic
public type ViewTraffic record {
    int count;
    int uniques;
    Traffic[] views;
};

# Represents the Queries record for the operation: dependabot/list-alerts-for-enterprise
public type DependabotListAlertsForEnterpriseQueries record {
    # A comma-separated list of severities. If specified, only alerts with these severities will be returned.
    # 
    # Can be: `low`, `medium`, `high`, `critical`
    string severity?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # A comma-separated list of package names. If specified, only alerts for these packages will be returned
    string package?;
    # A comma-separated list of ecosystems. If specified, only alerts for these ecosystems will be returned.
    # 
    # Can be: `composer`, `go`, `maven`, `npm`, `nuget`, `pip`, `pub`, `rubygems`, `rust`
    string ecosystem?;
    # **Deprecated**. The number of results per page (max 100), starting from the last matching result.
    # This parameter must not be used in combination with `first`.
    # Instead, use `per_page` in combination with `before` to fetch the last page of results
    @constraint:Int {minValue: 1, maxValue: 100}
    int last?;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor
    string before?;
    # The scope of the vulnerable dependency. If specified, only alerts with this scope will be returned
    "development"|"runtime" scope?;
    # A comma-separated list of states. If specified, only alerts with these states will be returned.
    # 
    # Can be: `auto_dismissed`, `dismissed`, `fixed`, `open`
    string state?;
    # The property by which to sort the results.
    # `created` means when the alert was created.
    # `updated` means when the alert's state last changed
    "created"|"updated" sort = "created";
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor
    string after?;
    # **Deprecated**. The number of results per page (max 100), starting from the first matching result.
    # This parameter must not be used in combination with `last`.
    # Instead, use `per_page` in combination with `after` to fetch the first page of results
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
    @jsondata:Name {value: "total_count"}
    int totalCount;
    CodespaceMachine[] machines;
};

# Commit Comparison
public type CommitComparison record {
    @jsondata:Name {value: "base_commit"}
    Commit baseCommit;
    @jsondata:Name {value: "behind_by"}
    int behindBy;
    @jsondata:Name {value: "diff_url"}
    string diffUrl;
    @jsondata:Name {value: "ahead_by"}
    int aheadBy;
    @jsondata:Name {value: "merge_base_commit"}
    Commit mergeBaseCommit;
    string url;
    @jsondata:Name {value: "total_commits"}
    int totalCommits;
    @jsondata:Name {value: "patch_url"}
    string patchUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    Commit[] commits;
    DiffEntry[] files?;
    @jsondata:Name {value: "permalink_url"}
    string permalinkUrl;
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
    string path;
    int size;
    ContentDirectoryInner__links _links;
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    string name;
    @jsondata:Name {value: "download_url"}
    string? downloadUrl;
    "dir"|"file"|"submodule"|"symlink" 'type;
    @jsondata:Name {value: "git_url"}
    string? gitUrl;
    string sha;
    string content?;
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
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# A team's access to a project
public type TeamProject record {
    @jsondata:Name {value: "columns_url"}
    string columnsUrl;
    SimpleUser creator;
    # Whether the project is private or not. Only present when owner is an organization
    boolean 'private?;
    # The organization permission for this project. Only present when owner is an organization
    @jsondata:Name {value: "organization_permission"}
    string organizationPermission?;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    string? body;
    string url;
    @jsondata:Name {value: "owner_url"}
    string ownerUrl;
    int number;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    TeamProjectPermissions permissions;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    string name;
    int id;
    string state;
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
    # Only commits before this date will be returned. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string until?;
    # Page number of the results to fetch
    int page = 1;
    # SHA or branch to start listing commits from. Default: the repository’s default branch (usually `main`)
    string sha?;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string since?;
};

public type ReviewsreviewIdBody record {
    # The body text of the pull request review
    string body;
};

public type PullRequestSimpleHead record {
    string ref;
    Repository repo;
    string label;
    string sha;
    NullableSimpleUser? user;
};

# Marketplace Listing Plan
public type MarketplaceListingPlan record {
    @jsondata:Name {value: "has_free_trial"}
    boolean hasFreeTrial;
    @jsondata:Name {value: "accounts_url"}
    string accountsUrl;
    string description;
    string url;
    @jsondata:Name {value: "unit_name"}
    string? unitName;
    int number;
    @jsondata:Name {value: "yearly_price_in_cents"}
    int yearlyPriceInCents;
    string name;
    int id;
    @jsondata:Name {value: "monthly_price_in_cents"}
    int monthlyPriceInCents;
    string state;
    @jsondata:Name {value: "price_model"}
    "FREE"|"FLAT_RATE"|"PER_UNIT" priceModel;
    string[] bullets;
};

public type RepositoryRulesetLinks record {
    RepositoryRulesetLinksSelf self?;
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
    # The list of team `slug`s allowed to bypass pull request requirements
    string[] teams?;
    # The list of user `login`s allowed to bypass pull request requirements
    string[] users?;
    # The list of app `slug`s allowed to bypass pull request requirements
    string[] apps?;
};

# Represents the Queries record for the operation: repos/list-public
public type ReposListPublicQueries record {
    # A repository ID. Only return repositories with an ID greater than this ID
    int since?;
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
    Repository parent?;
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking?;
    # Whether anonymous git access is allowed
    @jsondata:Name {value: "anonymous_access_enabled"}
    boolean anonymousAccessEnabled = true;
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge?;
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    FullRepositoryPermissions permissions?;
    @jsondata:Name {value: "temp_clone_token"}
    string? tempCloneToken?;
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    # The default value for a squash merge commit message:
    # 
    # - `PR_BODY` - default to the pull request's body.
    # - `COMMIT_MESSAGES` - default to the branch's commit messages.
    # - `BLANK` - default to a blank commit message
    @jsondata:Name {value: "squash_merge_commit_message"}
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squashMergeCommitMessage?;
    @jsondata:Name {value: "subscribers_count"}
    int subscribersCount;
    int id;
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions;
    int forks;
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    @jsondata:Name {value: "ssh_url"}
    string sshUrl;
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0
    int size;
    @jsondata:Name {value: "template_repository"}
    NullableRepository? templateRepository?;
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    @jsondata:Name {value: "clone_url"}
    string cloneUrl;
    @jsondata:Name {value: "default_branch"}
    string defaultBranch;
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads?;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int watchers;
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    boolean archived;
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Returns whether or not this repository disabled
    boolean disabled;
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    string[] topics?;
    @jsondata:Name {value: "allow_update_branch"}
    boolean allowUpdateBranch?;
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    string url;
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    @jsondata:Name {value: "use_squash_pr_title_as_default"}
    boolean useSquashPrTitleAsDefault?;
    NullableSimpleUser? organization?;
    # The default value for a merge commit message.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `PR_BODY` - default to the pull request's body.
    # - `BLANK` - default to a blank commit message
    @jsondata:Name {value: "merge_commit_message"}
    "PR_BODY"|"PR_TITLE"|"BLANK" mergeCommitMessage?;
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    # The default value for a squash merge commit title:
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `COMMIT_OR_PR_TITLE` - default to the commit's title (if only one commit) or the pull request's title (when more than one commit)
    @jsondata:Name {value: "squash_merge_commit_title"}
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squashMergeCommitTitle?;
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount;
    @jsondata:Name {value: "is_template"}
    boolean isTemplate?;
    @jsondata:Name {value: "pushed_at"}
    string pushedAt;
    string? language;
    Repository 'source?;
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    @jsondata:Name {value: "svn_url"}
    string svnUrl;
    @jsondata:Name {value: "master_branch"}
    string masterBranch?;
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit?;
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The repository visibility: public, private, or internal
    string visibility?;
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    @jsondata:Name {value: "network_count"}
    int networkCount;
    NullableLicenseSimple? license;
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge?;
    string name;
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    boolean 'private;
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount;
    string? description;
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects;
    # The default value for a merge commit title.
    # 
    #   - `PR_TITLE` - default to the pull request's title.
    #   - `MERGE_MESSAGE` - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name)
    @jsondata:Name {value: "merge_commit_title"}
    "PR_TITLE"|"MERGE_MESSAGE" mergeCommitTitle?;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge?;
    @jsondata:Name {value: "git_url"}
    string gitUrl;
    @jsondata:Name {value: "has_pages"}
    boolean hasPages;
    SimpleUser owner;
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge?;
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues;
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    @jsondata:Name {value: "code_of_conduct"}
    CodeOfConductSimple codeOfConduct?;
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl;
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    @jsondata:Name {value: "security_and_analysis"}
    SecurityAndAnalysis? securityAndAnalysis?;
    boolean 'fork;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    @jsondata:Name {value: "watchers_count"}
    int watchersCount;
    string? homepage;
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

public type ReposownerrepobranchesbranchprotectionrestrictionsappsreposownerrepobranchesbranchprotectionrestrictionsappsOneOf122 string[];

public type PullRequestReviewCommentLinks record {
    @jsondata:Name {value: "pull_request"}
    PullRequestReviewCommentLinksPullRequest pullRequest;
    PullRequestReviewCommentLinksSelf self;
    PullRequestReviewCommentLinksHtml html;
};

public type BranchShortCommit record {
    string sha;
    string url;
};

# The duration of the interaction restriction. Default: `one_day`
public type InteractionExpiry "one_day"|"three_days"|"one_week"|"one_month"|"six_months";

public type RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf123456789 record {
    *RepositoryRuleNonFastForward;
    *RepositoryRuleRulesetInfo;
};

public type Cwes CwesOneOf1|CwesCwesOneOf12;

public type UseremailsuseremailsuseremailsOneOf1123 string;

# Whether GitHub Actions can approve pull requests. Enabling this can be a security risk
public type ActionsCanApprovePullRequestReviews boolean;

# Severity of a code scanning alert
public type CodeScanningAlertSeverity "critical"|"high"|"medium"|"low"|"warning"|"note"|"error";

# Use the `status` property to enable or disable secret scanning push protection for this repository. For more information, see "[Protecting pushes with secret scanning](/code-security/secret-scanning/protecting-pushes-with-secret-scanning)."
public type ReposownerrepoSecurityAndAnalysisSecretScanningPushProtection record {
    # Can be `enabled` or `disabled`
    string status?;
};

public type EventPayloadPages record {
    string? summary?;
    @jsondata:Name {value: "page_name"}
    string pageName?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    string action?;
    string title?;
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

public type ReposownerrepobranchesbranchprotectionrestrictionsusersOneOf11 record {
    # The username for users
    string[] users;
};

# Represents the Queries record for the operation: issues/list-for-repo
public type IssuesListForRepoQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The user that created the issue
    string creator?;
    # If an `integer` is passed, it should refer to a milestone by its `number` field. If the string `*` is passed, issues with any milestone are accepted. If the string `none` is passed, issues without milestones are returned
    string milestone?;
    # Indicates the state of the issues to return
    "open"|"closed"|"all" state = "open";
    # Can be the name of a user. Pass in `none` for issues with no assigned user, and `*` for issues assigned to any user
    string assignee?;
    # What to sort results by
    "created"|"updated"|"comments" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # A user that's mentioned in the issue
    string mentioned?;
    # A list of comma separated label names. Example: `bug,ui,@high`
    string labels?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string since?;
};

public type ReposownerrepobranchesbranchprotectionrestrictionsusersOneOf12 record {
    # The username for users
    string[] users;
};

# Represents the Queries record for the operation: codespaces/list-in-repository-for-authenticated-user
public type CodespacesListInRepositoryForAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
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
    @jsondata:Name {value: "allowed_actions"}
    AllowedActions allowedActions?;
    ActionsEnabled enabled;
};

public type PagesHealthCheckAltDomain record {
    string? reason?;
    @jsondata:Name {value: "is_cloudflare_ip"}
    boolean? isCloudflareIp?;
    @jsondata:Name {value: "enforces_https"}
    boolean enforcesHttps?;
    @jsondata:Name {value: "is_pointed_to_github_pages_ip"}
    boolean? isPointedToGithubPagesIp?;
    @jsondata:Name {value: "is_served_by_pages"}
    boolean? isServedByPages?;
    @jsondata:Name {value: "is_fastly_ip"}
    boolean? isFastlyIp?;
    @jsondata:Name {value: "is_apex_domain"}
    boolean isApexDomain?;
    string host?;
    @jsondata:Name {value: "responds_to_https"}
    boolean respondsToHttps?;
    @jsondata:Name {value: "is_cname_to_pages_dot_github_dot_com"}
    boolean? isCnameToPagesDotGithubDotCom?;
    @jsondata:Name {value: "is_a_record"}
    boolean? isARecord?;
    @jsondata:Name {value: "is_cname_to_github_user_domain"}
    boolean? isCnameToGithubUserDomain?;
    @jsondata:Name {value: "is_pages_domain"}
    boolean isPagesDomain?;
    @jsondata:Name {value: "is_old_ip_address"}
    boolean? isOldIpAddress?;
    @jsondata:Name {value: "has_cname_record"}
    boolean? hasCnameRecord?;
    @jsondata:Name {value: "is_cname_to_fastly"}
    boolean? isCnameToFastly?;
    @jsondata:Name {value: "dns_resolves"}
    boolean dnsResolves?;
    @jsondata:Name {value: "is_https_eligible"}
    boolean? isHttpsEligible?;
    @jsondata:Name {value: "caa_error"}
    string? caaError?;
    @jsondata:Name {value: "is_proxied"}
    boolean? isProxied?;
    @jsondata:Name {value: "is_valid_domain"}
    boolean isValidDomain?;
    @jsondata:Name {value: "is_non_github_pages_ip_present"}
    boolean? isNonGithubPagesIpPresent?;
    string uri?;
    @jsondata:Name {value: "should_be_a_record"}
    boolean? shouldBeARecord?;
    string nameservers?;
    @jsondata:Name {value: "has_mx_records_present"}
    boolean? hasMxRecordsPresent?;
    @jsondata:Name {value: "is_valid"}
    boolean isValid?;
    @jsondata:Name {value: "https_error"}
    string? httpsError?;
};

# Represents the Queries record for the operation: actions/list-workflow-runs-for-repo
public type ActionsListWorkflowRunsForRepoQueries record {
    # Returns someone's workflow runs. Use the login for the user who created the `push` associated with the check suite or workflow run
    string actor?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Returns workflow runs with the `check_suite_id` that you specify
    @http:Query {name: "check_suite_id"}
    int checkSuiteId?;
    # Returns workflow runs created within the given date-time range. For more information on the syntax, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    string created?;
    # If `true` pull requests are omitted from the response (empty array)
    @http:Query {name: "exclude_pull_requests"}
    boolean excludePullRequests = false;
    # Page number of the results to fetch
    int page = 1;
    # Returns workflow run triggered by the event you specify. For example, `push`, `pull_request` or `issue`. For more information, see "[Events that trigger workflows](https://docs.github.com/actions/automating-your-workflow-with-github-actions/events-that-trigger-workflows)."
    string event?;
    # Returns workflow runs associated with a branch. Use the name of the branch of the `push`
    string branch?;
    # Only returns workflow runs that are associated with the specified `head_sha`
    @http:Query {name: "head_sha"}
    string headSha?;
    # Returns workflow runs with the check run `status` or `conclusion` that you specify. For example, a conclusion can be `success` or a status can be `in_progress`. Only GitHub can set a status of `waiting` or `requested`
    "completed"|"action_required"|"cancelled"|"failure"|"neutral"|"skipped"|"stale"|"success"|"timed_out"|"in_progress"|"queued"|"requested"|"waiting"|"pending" status?;
};

public type ProtectedBranchPullRequestReviewDismissalRestrictions record {
    @jsondata:Name {value: "teams_url"}
    string teamsUrl?;
    # The list of teams with review dismissal access
    Team[] teams?;
    @jsondata:Name {value: "users_url"}
    string usersUrl?;
    # The list of users with review dismissal access
    SimpleUser[] users?;
    string url?;
    # The list of apps with review dismissal access
    Integration[] apps?;
};

public type OutsideCollaboratorsusernameBody record {
    # When set to `true`, the request will be performed asynchronously. Returns a 202 status code when the job is successfully queued
    boolean async = false;
};

# The time that the alert was dismissed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`
public type AlertDismissedAt string?;

# Represents the Queries record for the operation: repos/get-readme
public type ReposGetReadmeQueries record {
    # The name of the commit/branch/tag. Default: the repository’s default branch
    string ref?;
};

public type CwesOneOf1 string;

# Moved Column in Project Issue Event
public type MovedColumnInProjectIssueEvent record {
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
    @jsondata:Name {value: "project_card"}
    AddedToProjectIssueEventProjectCard projectCard?;
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
    string? visibility;
    boolean verified;
    string email;
    boolean primary;
};

# Key Simple
public type KeySimple record {
    int id;
    string 'key;
};

# Project Collaborator Permission
public type ProjectCollaboratorPermission record {
    string permission;
    NullableSimpleUser? user;
};

public type OrgsorgBody record {
    # Whether Dependabot security updates is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a `GET /orgs/{org}` request
    @jsondata:Name {value: "dependabot_security_updates_enabled_for_new_repositories"}
    boolean dependabotSecurityUpdatesEnabledForNewRepositories?;
    # Whether Dependabot alerts is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a `GET /orgs/{org}` request
    @jsondata:Name {value: "dependabot_alerts_enabled_for_new_repositories"}
    boolean dependabotAlertsEnabledForNewRepositories?;
    # Whether organization members can create internal repositories, which are visible to all enterprise members. You can only allow members to create internal repositories if your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+. For more information, see "[Restricting repository creation in your organization](https://docs.github.com/github/setting-up-and-managing-organizations-and-teams/restricting-repository-creation-in-your-organization)" in the GitHub Help documentation
    @jsondata:Name {value: "members_can_create_internal_repositories"}
    boolean membersCanCreateInternalRepositories?;
    # If `secret_scanning_push_protection_custom_link_enabled` is true, the URL that will be displayed to contributors who are blocked from pushing a secret
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
    # You can check which security and analysis features are currently enabled by using a `GET /orgs/{org}` request
    @jsondata:Name {value: "advanced_security_enabled_for_new_repositories"}
    boolean advancedSecurityEnabledForNewRepositories?;
    string blog?;
    # Whether dependency graph is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a `GET /orgs/{org}` request
    @jsondata:Name {value: "dependency_graph_enabled_for_new_repositories"}
    boolean dependencyGraphEnabledForNewRepositories?;
    # Default permission level members have for organization repositories
    @jsondata:Name {value: "default_repository_permission"}
    "read"|"write"|"admin"|"none" defaultRepositoryPermission = "read";
    # Whether secret scanning is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a `GET /orgs/{org}` request
    @jsondata:Name {value: "secret_scanning_enabled_for_new_repositories"}
    boolean secretScanningEnabledForNewRepositories?;
    # Billing email address. This address is not publicized
    @jsondata:Name {value: "billing_email"}
    string billingEmail?;
    # Specifies which types of repositories non-admin organization members can create. `private` is only available to repositories that are part of an organization on GitHub Enterprise Cloud. 
    # **Note:** This parameter is deprecated and will be removed in the future. Its return value ignores internal repositories. Using this parameter overrides values set in `members_can_create_repositories`. See the parameter deprecation notice in the operation description for details
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
    # You can check which security and analysis features are currently enabled by using a `GET /orgs/{org}` request
    @jsondata:Name {value: "secret_scanning_push_protection_enabled_for_new_repositories"}
    boolean secretScanningPushProtectionEnabledForNewRepositories?;
    # Whether organization members can create private GitHub Pages sites. Existing published sites will not be impacted
    @jsondata:Name {value: "members_can_create_private_pages"}
    boolean membersCanCreatePrivatePages = true;
    # The publicly visible email address
    string email?;
    # Whether of non-admin organization members can create repositories. **Note:** A parameter can override this parameter. See `members_allowed_repository_creation_type` in this table for details
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
    string message?;
    string url?;
};

public type AccessSelectedUsersBody record {
    # The usernames of the organization members whose codespaces be billed to the organization
    @jsondata:Name {value: "selected_usernames"}
    string[] selectedUsernames;
};

# Details of a deployment that is waiting for protection rules to pass
public type PendingDeployment record {
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
    @jsondata:Name {value: "expires_at"}
    string expiresAt;
    string origin;
    InteractionGroup 'limit;
};

public type PullRequestHeadRepoOwner record {
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    string login;
    string 'type;
    string url;
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    int id;
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
};

# Represents the Queries record for the operation: migrations/get-status-for-authenticated-user
public type MigrationsGetStatusForAuthenticatedUserQueries record {
    string[] exclude?;
};

public type CodeScanningAlertInstance record {
    # Classifications that have been applied to the file that triggered the alert.
    # For example identifying it as documentation, or a generated file
    CodeScanningAlertClassification[] classifications?;
    CodeScanningRef ref?;
    CodeScanningAlertEnvironment environment?;
    @jsondata:Name {value: "commit_sha"}
    string commitSha?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    CodeScanningAlertLocation location?;
    CodeScanningAlertState state?;
    @jsondata:Name {value: "analysis_key"}
    CodeScanningAnalysisAnalysisKey analysisKey?;
    CodeScanningAnalysisCategory category?;
    CodeScanningAlertInstanceMessage message?;
};

public type NotificationsBody record {
    # Whether the notification has been read
    boolean read?;
    # Describes the last point that notifications were checked. Anything updated since this time will not be marked as read. If you omit this parameter, all notifications are marked as read. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`. Default: The current timestamp
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
    boolean default?;
    string color?;
    string name?;
    string? description?;
    int id?;
    string url?;
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# Status Check Policy
public type StatusCheckPolicy record {
    StatusCheckPolicyChecks[] checks;
    @jsondata:Name {value: "contexts_url"}
    string contextsUrl;
    string[] contexts;
    boolean strict;
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
    @jsondata:Name {value: "default_workflow_permissions"}
    ActionsDefaultWorkflowPermissions defaultWorkflowPermissions;
    @jsondata:Name {value: "can_approve_pull_request_reviews"}
    ActionsCanApprovePullRequestReviews canApprovePullRequestReviews;
};

public type MembershipsusernameBody1 record {
    # The role that this user should have in the team
    "member"|"maintainer" role = "member";
};

public type ImportLfsBody record {
    # Whether to store large files during the import. `opt_in` means large files will be stored using Git LFS. `opt_out` means large files will be removed during the import
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
    # The `internal` visibility is only supported for GitHub Packages registries that allow for granular permissions. For other ecosystems `internal` is synonymous with `private`.
    # For the list of GitHub Packages registries that support granular permissions, see "[About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages#granular-permissions-for-userorganization-scoped-packages)."
    "public"|"private"|"internal" visibility?;
    # Page number of the results to fetch
    int page = 1;
    # The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    @http:Query {name: "package_type"}
    "npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType;
};

# Installation
public type InstallationResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
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
    SecurityAdvisoryCreditTypes 'type;
    SimpleUser user;
|};

public type SimpleCommitStatus record {
    @jsondata:Name {value: "avatar_url"}
    string? avatarUrl;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "target_url"}
    string? targetUrl;
    string context;
    string? description;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string state;
    boolean? required?;
    string url;
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
    EventPayloadPages[] pages?;
    Issue issue?;
    string action?;
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
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "state_reason"}
    string? stateReason?;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
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
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
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
    string name;
    string label?;
};

public type ArtifactWorkflowRun record {
    @jsondata:Name {value: "head_branch"}
    string headBranch?;
    @jsondata:Name {value: "repository_id"}
    int repositoryId?;
    @jsondata:Name {value: "head_repository_id"}
    int headRepositoryId?;
    int id?;
    @jsondata:Name {value: "head_sha"}
    string headSha?;
};

public type ImportProjectChoices record {
    @jsondata:Name {value: "human_name"}
    string humanName?;
    @jsondata:Name {value: "tfvc_project"}
    string tfvcProject?;
    string vcs?;
};

# Code of Conduct Simple
public type CodeOfConductSimple record {
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    string name;
    string url;
    string 'key;
};

# A GitHub Classroom classroom
public type Classroom record {
    # Whether classroom is archived
    boolean archived;
    SimpleClassroomOrganization organization;
    # The name of the classroom
    string name;
    # Unique identifier of the classroom
    int id;
    # The URL of the classroom on GitHub Classroom
    string url;
};

public type GitBlobsBody record {
    # The encoding used for `content`. Currently, `"utf-8"` and `"base64"` are supported
    string encoding = "utf-8";
    # The new blob's content
    string content;
};

public type GistSimpleForks record {
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    string id?;
    PublicUser user?;
    string url?;
};

# Represents the Queries record for the operation: issues/list-comments
public type IssuesListCommentsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string since?;
};

# Secrets for a GitHub Codespace
public type CodespacesOrgSecretResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
    CodespacesOrgSecret[] secrets;
};

# Organization Invitation
public type OrganizationInvitation record {
    @jsondata:Name {value: "invitation_source"}
    string invitationSource?;
    string role;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    SimpleUser inviter;
    int id;
    @jsondata:Name {value: "failed_at"}
    string? failedAt?;
    string? login;
    @jsondata:Name {value: "invitation_teams_url"}
    string invitationTeamsUrl;
    string? email;
    @jsondata:Name {value: "failed_reason"}
    string? failedReason?;
    @jsondata:Name {value: "team_count"}
    int teamCount;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type RestrictionsAppsBody ReposownerrepobranchesbranchprotectionrestrictionsappsOneOf1|ReposownerrepobranchesbranchprotectionrestrictionsappsreposownerrepobranchesbranchprotectionrestrictionsappsOneOf12;

# Converted Note to Issue Issue Event
public type ConvertedNoteToIssueIssueEvent record {
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "performed_via_github_app"}
    Integration performedViaGithubApp;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
    @jsondata:Name {value: "project_card"}
    AddedToProjectIssueEventProjectCard projectCard?;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type GlobalAdvisoryVulnerabilities record {
    # The package version that resolve the vulnerability
    @jsondata:Name {value: "first_patched_version"}
    string? firstPatchedVersion;
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
    GistSimpleForks[]? forks?;
    SimpleUser owner?;
    @jsondata:Name {value: "commits_url"}
    string commitsUrl?;
    int comments?;
    @jsondata:Name {value: "forks_url"}
    string forksUrl?;
    @jsondata:Name {value: "git_push_url"}
    string gitPushUrl?;
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    string? description?;
    boolean truncated?;
    @jsondata:Name {value: "fork_of"}
    Gist? forkOf?;
    GistHistory[]? history?;
    string url?;
    boolean 'public?;
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    @jsondata:Name {value: "git_pull_url"}
    string gitPullUrl?;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl?;
    record {|GistSimpleFiles?...;|} files?;
    string id?;
    string? user?;
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# A schema for the SPDX JSON format returned by the Dependency Graph
public type DependencyGraphSpdxSbom record {
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
    @jsondata:Name {value: "seats_created"}
    int seatsCreated;
};

public type FeedLinks record {
    @jsondata:Name {value: "repository_discussions"}
    LinkWithType repositoryDiscussions?;
    @jsondata:Name {value: "current_user_organization"}
    LinkWithType currentUserOrganization?;
    @jsondata:Name {value: "current_user_organizations"}
    LinkWithType[] currentUserOrganizations?;
    @jsondata:Name {value: "current_user_actor"}
    LinkWithType currentUserActor?;
    LinkWithType timeline;
    LinkWithType user;
    @jsondata:Name {value: "security_advisories"}
    LinkWithType securityAdvisories?;
    @jsondata:Name {value: "current_user_public"}
    LinkWithType currentUserPublic?;
    @jsondata:Name {value: "repository_discussions_category"}
    LinkWithType repositoryDiscussionsCategory?;
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
    # If specified, only return advisories that affect any of `package` or `package@version`. A maximum of 1000 packages can be specified.
    # If the query parameter causes the URL to exceed the maximum URL length supported by your client, you must specify fewer packages.
    # 
    # Example: `affects=package1,package2@1.0.0,package3@^2.0.0` or `affects[]=package1&affects[]=package2@1.0.0`
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
    # Example: `cwes=79,284,22` or `cwes[]=79&cwes[]=284&cwes[]=22`
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
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "dismissed_review"}
    ReviewDismissedIssueEventDismissedReview dismissedReview;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
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
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string since?;
};

public type PublicUserPlan record {
    @jsondata:Name {value: "private_repos"}
    int privateRepos;
    string name;
    int collaborators;
    int space;
};

# License
public type License record {
    boolean featured;
    string implementation;
    string description;
    string body;
    @jsondata:Name {value: "spdx_id"}
    string? spdxId;
    string? url;
    string[] permissions;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    string name;
    string[] conditions;
    string 'key;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    string[] limitations;
};

public type PullRequestBaseRepo record {
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking?;
    @jsondata:Name {value: "is_template"}
    boolean isTemplate?;
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount;
    @jsondata:Name {value: "pushed_at"}
    string pushedAt;
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    string? language;
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge?;
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    FullRepositoryPermissions permissions?;
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    @jsondata:Name {value: "svn_url"}
    string svnUrl;
    int id;
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions;
    @jsondata:Name {value: "master_branch"}
    string masterBranch?;
    int forks;
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit?;
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The repository visibility: public, private, or internal
    string visibility?;
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    @jsondata:Name {value: "ssh_url"}
    string sshUrl;
    NullableLicenseSimple? license;
    @jsondata:Name {value: "full_name"}
    string fullName;
    int size;
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "clone_url"}
    string cloneUrl;
    string name;
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    @jsondata:Name {value: "default_branch"}
    string defaultBranch;
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    boolean 'private;
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads;
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount;
    string? description;
    int watchers;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects;
    boolean archived;
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    boolean disabled;
    @jsondata:Name {value: "git_url"}
    string gitUrl;
    @jsondata:Name {value: "has_pages"}
    boolean hasPages;
    PullRequestHeadRepoOwner owner;
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge?;
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    string[] topics?;
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues;
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    string url;
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl;
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    boolean 'fork;
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    @jsondata:Name {value: "watchers_count"}
    int watchersCount;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    @jsondata:Name {value: "forks_count"}
    int forksCount;
    string? homepage;
};

public type RepoImportBody record {
    # If authentication is required, the username to provide to `vcs_url`
    @jsondata:Name {value: "vcs_username"}
    string vcsUsername?;
    # If authentication is required, the password to provide to `vcs_url`
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
    @jsondata:Name {value: "duration_ms"}
    int durationMs;
    @jsondata:Name {value: "job_id"}
    int jobId;
};

# Milestoned Issue Event
public type MilestonedIssueEvent record {
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    MilestonedIssueEventMilestone milestone;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
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
    # The geographic area for this codespace. If not specified, the value is assigned by IP. This property replaces `location`, which is being deprecated
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
    @jsondata:Name {value: "total_count"}
    int totalCount;
    @jsondata:Name {value: "incomplete_results"}
    boolean incompleteResults;
    TopicSearchResultItem[] items;
};

public type GitRefObject record {
    string 'type;
    # SHA for the reference
    @constraint:String {maxLength: 40, minLength: 40}
    string sha;
    string url;
};

public type PullNumberRequestedReviewersBody1 record {
    # An array of team `slug`s that will be removed
    @jsondata:Name {value: "team_reviewers"}
    string[] teamReviewers?;
    # An array of user `login`s that will be removed
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
    "required_deployments" 'type;
    RepositoryRuleRequiredDeploymentsParameters parameters?;
};

# License Simple
public type NullableLicenseSimple record {
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    string name;
    @jsondata:Name {value: "spdx_id"}
    string? spdxId;
    string 'key;
    string? url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type ReactionRollup record {
    int confused;
    @jsondata:Name {value: "-1"}
    int param\-1;
    @jsondata:Name {value: "total_count"}
    int totalCount;
    @jsondata:Name {value: "+1"}
    int param\+1;
    int rocket;
    int hooray;
    int eyes;
    string url;
    int laugh;
    int heart;
};

# Hypermedia Link with Type
public type LinkWithType record {
    string href;
    string 'type;
};

# An object describing a symlink
public type ContentSymlink record {
    string path;
    int size;
    @jsondata:Name {value: "_links"}
    ContentTreeLinks links;
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    string name;
    @jsondata:Name {value: "download_url"}
    string? downloadUrl;
    "symlink" 'type;
    @jsondata:Name {value: "git_url"}
    string? gitUrl;
    string sha;
    string url;
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
    # Unique identifiers of the requests for access via fine-grained personal access token. Must be formed of between 1 and 100 `pat_request_id` values
    @jsondata:Name {value: "pat_request_ids"}
    int[] patRequestIds?;
    # Action to apply to the requests
    "approve"|"deny" action;
};

public type ReposownerrepobranchesbranchprotectionrestrictionsteamsOneOf12 record {
    # The slug values for teams
    string[] teams;
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
    string path;
    string ref?;
    string sha;
};

public type CollaboratorPermissions record {
    boolean pull;
    boolean maintain?;
    boolean admin;
    boolean triage?;
    boolean push;
};

public type ReposownerrepobranchesbranchprotectionrestrictionsteamsOneOf11 record {
    # The slug values for teams
    string[] teams;
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
    RepositoryRuleEnforcement enforcement?;
    # An array of rules within the ruleset
    RepositoryRule[] rules?;
    RepositoryRulesetConditions conditions?;
    # The target of the ruleset
    "branch"|"tag" target?;
};

public type ProtectionRulesAnyOf1 record {
    int id;
    @jsondata:Name {value: "wait_timer"}
    WaitTimer waitTimer?;
    string 'type;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# A self hosted runner
public type RunnerResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
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
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    # Specifies if repository projects are enabled for repositories that belong to this org
    @jsondata:Name {value: "has_repository_projects"}
    boolean hasRepositoryProjects;
    @jsondata:Name {value: "members_url"}
    string membersUrl;
    string? description;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Unique login name of the organization
    string login;
    # Display blog url for the organization
    string blog?;
    string 'type;
    @jsondata:Name {value: "public_members_url"}
    string publicMembersUrl;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Display company name for the organization
    string company?;
    int id;
    @jsondata:Name {value: "public_repos"}
    int publicRepos;
    OrganizationPlan plan?;
    # Display email for the organization
    string email?;
    @jsondata:Name {value: "is_verified"}
    boolean isVerified?;
    @jsondata:Name {value: "public_gists"}
    int publicGists;
    # URL for the organization
    string url;
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    int followers;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    # Specifies if organization projects are enabled for this org
    @jsondata:Name {value: "has_organization_projects"}
    boolean hasOrganizationProjects;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    int following;
    # Display name for the organization
    string name?;
    # Display location for the organization
    string location?;
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# A deployment created as the result of an Actions check run from a workflow that references an environment
public type DeploymentSimple record {
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    string? description;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    string url;
    # Name for the target deployment environment
    string environment;
    # Parameter to specify a task to execute
    string task;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    # Specifies if the given environment is will no longer exist at some point in the future. Default: false
    @jsondata:Name {value: "transient_environment"}
    boolean transientEnvironment?;
    @jsondata:Name {value: "original_environment"}
    string originalEnvironment?;
    # Unique identifier of the deployment
    int id;
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
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
    # The URL at which to download the CodeQL database. The `Accept` header must be set to the value of the `content_type` property
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
    @jsondata:Name {value: "issue_template"}
    NullableCommunityHealthFile? issueTemplate;
    NullableLicenseSimple? license;
    @jsondata:Name {value: "code_of_conduct_file"}
    NullableCommunityHealthFile? codeOfConductFile;
    NullableCommunityHealthFile? contributing;
    NullableCommunityHealthFile? readme;
    @jsondata:Name {value: "pull_request_template"}
    NullableCommunityHealthFile? pullRequestTemplate;
    @jsondata:Name {value: "code_of_conduct"}
    NullableCodeOfConductSimple? codeOfConduct;
};

# Unassigned Issue Event
public type UnassignedIssueEvent record {
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    SimpleUser assigner;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    SimpleUser assignee;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
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
    string? message;
};

# Information of a job execution in a workflow run
public type JobResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
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
    # Whether to set the branch as read-only. If this is true, users will not be able to push to the branch. Default: `false`
    @jsondata:Name {value: "lock_branch"}
    boolean lockBranch = false;
    @jsondata:Name {value: "required_pull_request_reviews"}
    ReposownerrepobranchesbranchprotectionRequiredPullRequestReviews? requiredPullRequestReviews;
    # If set to `true`, the `restrictions` branch protection settings which limits who can push will also block pushes which create new branches, unless the push is initiated by a user, team, or app which has the ability to push. Set to `true` to restrict new branch creation. Default: `false`
    @jsondata:Name {value: "block_creations"}
    boolean blockCreations?;
    # Requires all conversations on code to be resolved before a pull request can be merged into a branch that matches this rule. Set to `false` to disable. Default: `false`
    @jsondata:Name {value: "required_conversation_resolution"}
    boolean requiredConversationResolution?;
    @jsondata:Name {value: "required_status_checks"}
    ReposownerrepobranchesbranchprotectionRequiredStatusChecks? requiredStatusChecks;
    # Whether users can pull changes from upstream when the branch is locked. Set to `true` to allow fork syncing. Set to `false` to prevent fork syncing. Default: `false`
    @jsondata:Name {value: "allow_fork_syncing"}
    boolean allowForkSyncing = false;
    ReposownerrepobranchesbranchprotectionRestrictions? restrictions;
    # Enforces a linear commit Git history, which prevents anyone from pushing merge commits to a branch. Set to `true` to enforce a linear commit history. Set to `false` to disable a linear commit Git history. Your repository must allow squash merging or rebase merging before you can enable a linear commit history. Default: `false`. For more information, see "[Requiring a linear commit history](https://docs.github.com/github/administering-a-repository/requiring-a-linear-commit-history)" in the GitHub Help documentation
    @jsondata:Name {value: "required_linear_history"}
    boolean requiredLinearHistory?;
    # Enforce all configured restrictions for administrators. Set to `true` to enforce required status checks for repository administrators. Set to `null` to disable
    @jsondata:Name {value: "enforce_admins"}
    boolean? enforceAdmins;
    # Allows deletion of the protected branch by anyone with write access to the repository. Set to `false` to prevent deletion of the protected branch. Default: `false`. For more information, see "[Enabling force pushes to a protected branch](https://docs.github.com/github/administering-a-repository/enabling-force-pushes-to-a-protected-branch)" in the GitHub Help documentation
    @jsondata:Name {value: "allow_deletions"}
    boolean allowDeletions?;
    # Permits force pushes to the protected branch by anyone with write access to the repository. Set to `true` to allow force pushes. Set to `false` or `null` to block force pushes. Default: `false`. For more information, see "[Enabling force pushes to a protected branch](https://docs.github.com/github/administering-a-repository/enabling-force-pushes-to-a-protected-branch)" in the GitHub Help documentation."
    @jsondata:Name {value: "allow_force_pushes"}
    boolean? allowForcePushes?;
};

# Issue Search Result Item
public type IssueSearchResultItemResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
    @jsondata:Name {value: "incomplete_results"}
    boolean incompleteResults;
    IssueSearchResultItem[] items;
};

# Groups of organization members that gives permissions on specified repositories
public type NullableTeamSimple record {
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
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
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Name of the team
    string name;
    # Unique identifier of the team
    int id;
    string slug;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type OrgHookConfig record {
    @jsondata:Name {value: "content_type"}
    string contentType?;
    @jsondata:Name {value: "insecure_ssl"}
    string insecureSsl?;
    string secret?;
    string url?;
};

# Represents the Queries record for the operation: checks/list-for-suite
public type ChecksListForSuiteQueries record {
    # Filters check runs by their `completed_at` timestamp. `latest` returns the most recent check runs
    "latest"|"all" filter = "latest";
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Returns check runs with the specified `name`
    @http:Query {name: "check_name"}
    string checkName?;
    # Page number of the results to fetch
    int page = 1;
    # Returns check runs with the specified `status`
    "queued"|"in_progress"|"completed" status?;
};

# Represents the Queries record for the operation: actions/get-actions-cache-list
public type ActionsGetActionsCacheListQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The full Git reference for narrowing down the cache. The `ref` for a branch should be formatted as `refs/heads/<branch name>`. To reference a pull request use `refs/pull/<number>/merge`
    string ref?;
    # Page number of the results to fetch
    int page = 1;
    # The property to sort the results by. `created_at` means when the cache was created. `last_accessed_at` means when the cache was last accessed. `size_in_bytes` is the size of the cache in bytes
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
    "committer_email_pattern" 'type;
    RepositoryRuleCommitMessagePatternParameters parameters?;
};

# Unlabeled Issue Event
public type UnlabeledIssueEvent record {
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    LabeledIssueEventLabel label;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Pull Request Review Request
public type PullRequestReviewRequest record {
    Team[] teams;
    SimpleUser[] users;
};

public type OrganizationFullPlan record {
    @jsondata:Name {value: "private_repos"}
    int privateRepos;
    @jsondata:Name {value: "filled_seats"}
    int filledSeats?;
    string name;
    int seats?;
    int space;
};

public type CommitStats record {
    int total?;
    int additions?;
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

# Webhooks for repositories
public type Hook record {
    @jsondata:Name {value: "test_url"}
    string testUrl;
    # Determines whether the hook is actually triggered on pushes
    boolean active;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    string 'type;
    string url;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The name of a valid service, use 'web' for a webhook
    string name;
    # Unique identifier of the webhook
    int id;
    @jsondata:Name {value: "last_response"}
    HookResponse lastResponse;
    HookConfig config;
    @jsondata:Name {value: "ping_url"}
    string pingUrl;
    # Determines what events the hook is triggered for. Default: ['push']
    string[] events;
    @jsondata:Name {value: "deliveries_url"}
    string deliveriesUrl?;
};

# Installation
public type Installation record {
    @jsondata:Name {value: "access_tokens_url"}
    string accessTokensUrl;
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
    @jsondata:Name {value: "target_type"}
    string targetType;
    @jsondata:Name {value: "single_file_name"}
    string? singleFileName;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The ID of the user or organization this token is being scoped to
    @jsondata:Name {value: "target_id"}
    int targetId;
    @jsondata:Name {value: "contact_email"}
    string? contactEmail?;
    # Describe whether all repositories have been selected or there's a selection involved
    @jsondata:Name {value: "repository_selection"}
    "all"|"selected" repositorySelection;
    @jsondata:Name {value: "app_slug"}
    string appSlug;
    @jsondata:Name {value: "suspended_by"}
    NullableSimpleUser? suspendedBy;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    AppPermissions permissions;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "has_multiple_single_files"}
    boolean hasMultipleSingleFiles?;
    # The ID of the installation
    int id;
    @jsondata:Name {value: "app_id"}
    int appId;
    @jsondata:Name {value: "single_file_paths"}
    string[] singleFilePaths?;
    SimpleUser|Enterprise? account;
    string[] events;
    @jsondata:Name {value: "suspended_at"}
    string? suspendedAt;
};

# Runner Application
public type RunnerApplication record {
    @jsondata:Name {value: "sha256_checksum"}
    string sha256Checksum?;
    string filename;
    string os;
    # A short lived bearer token used to download the runner, if needed
    @jsondata:Name {value: "temp_download_token"}
    string tempDownloadToken?;
    @jsondata:Name {value: "download_url"}
    string downloadUrl;
    string architecture;
};

# Issue Event Milestone
public type IssueEventMilestone record {
    string title;
};

# Check suite configuration preferences for a repository
public type CheckSuitePreference record {
    CheckSuitePreferencePreferences preferences;
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
    # Sorts the results of your query by when the label was `created` or `updated`. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    "created"|"updated" sort?;
    # Page number of the results to fetch
    int page = 1;
    # Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`
    "desc"|"asc" 'order = "desc";
};

# Represents the Queries record for the operation: search/repos
public type SearchReposQueries record {
    # The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching for repositories](https://docs.github.com/articles/searching-for-repositories/)" for a detailed list of qualifiers
    string q;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Sorts the results of your query by number of `stars`, `forks`, or `help-wanted-issues` or how recently the items were `updated`. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    "stars"|"forks"|"help-wanted-issues"|"updated" sort?;
    # Page number of the results to fetch
    int page = 1;
    # Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`
    "desc"|"asc" 'order = "desc";
};

# Represents the Queries record for the operation: teams/list
public type TeamsListQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

public type MinimalRepositoryLicense record {
    string name?;
    @jsondata:Name {value: "spdx_id"}
    string spdxId?;
    string 'key?;
    string? url?;
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
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The name of the enterprise
    string name;
    # A short description of the enterprise
    string? description?;
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    # Unique identifier of the enterprise
    int id;
    # The slug url identifier for the enterprise
    string slug;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Whether users can pull changes from upstream when the branch is locked. Set to `true` to allow fork syncing. Set to `false` to prevent fork syncing
public type ProtectedBranchAllowForkSyncing record {|
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
    string address?;
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    WebhookConfigSecret secret?;
    WebhookConfigUrl url;
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
    @jsondata:Name {value: "is_installed"}
    boolean isInstalled?;
    @jsondata:Name {value: "effective_date"}
    string effectiveDate?;
    int id?;
    MarketplaceListingPlan plan?;
    @jsondata:Name {value: "unit_count"}
    int? unitCount?;
};

# Metaproperties for Git author/committer information
public type NullableGitUser record {
    string date?;
    string name?;
    string email?;
};

public type RunnerIdLabelsBody record {
    # The names of the custom labels to set for the runner. You can pass an empty array to remove all custom labels
    @constraint:Array {maxLength: 100}
    string[] labels;
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
    ReposownerrepogitcommitsCommitter committer?;
    # The [PGP signature](https://en.wikipedia.org/wiki/Pretty_Good_Privacy) of the commit. GitHub adds the signature to the `gpgsig` header of the created commit. For a commit signature to be verifiable by Git or GitHub, it must be an ASCII-armored detached PGP signature over the string commit as it would be written to the object database. To pass a `signature` parameter, you need to first manually create a valid PGP signature, which can be complicated. You may find it easier to [use the command line](https://git-scm.com/book/id/v2/Git-Tools-Signing-Your-Work) to create signed commits
    string signature?;
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
    #  * `off-topic`  
    #  * `too heated`  
    #  * `resolved`  
    #  * `spam`
    @jsondata:Name {value: "lock_reason"}
    "off-topic"|"too heated"|"resolved"|"spam" lockReason?;
};

public type OrgRulesetsBody record {
    # The actors that can bypass the rules in this ruleset
    @jsondata:Name {value: "bypass_actors"}
    RepositoryRulesetBypassActor[] bypassActors?;
    # The name of the ruleset
    string name;
    RepositoryRuleEnforcement enforcement;
    # An array of rules within the ruleset
    RepositoryRule[] rules?;
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

# Information about the author of the commit. By default, the `author` will be the authenticated user and the current date. See the `author` and `committer` object below for details
public type ReposownerrepogitcommitsAuthor record {
    # Indicates when this commit was authored (or committed). This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string date?;
    # The name of the author (or committer) of the commit
    string name;
    # The email of the author (or committer) of the commit
    string email;
};

public type ProtectionRequiredStatusChecksBody record {
    # The list of status checks to require in order to merge into this branch
    ReposownerrepobranchesbranchprotectionRequiredStatusChecksChecks[] checks?;
    # **Deprecated**: The list of status checks to require in order to merge into this branch. If any of these checks have recently been set by a particular GitHub App, they will be required to come from that app in future for the branch to merge. Use `checks` instead of `contexts` for more fine-grained control
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
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    string login;
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    string 'type;
    string url;
    @jsondata:Name {value: "role_name"}
    string roleName;
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    CollaboratorPermissions permissions?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    string? name?;
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    int id;
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    string? email?;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
};

public type GistsBody record {
    boolean|"true"|"false" 'public?;
    # Description of the gist
    string description?;
    # Names and content for the files that make up the gist
    record {|GistsFiles...;|} files;
};

# Represents the Queries record for the operation: actions/get-workflow-run-attempt
public type ActionsGetWorkflowRunAttemptQueries record {
    # If `true` pull requests are omitted from the response (empty array)
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
    @jsondata:Name {value: "security_advisories_url"}
    string securityAdvisoriesUrl?;
    @jsondata:Name {value: "_links"}
    FeedLinks links;
    @jsondata:Name {value: "current_user_url"}
    string currentUserUrl?;
    @jsondata:Name {value: "current_user_organization_url"}
    string currentUserOrganizationUrl?;
    @jsondata:Name {value: "current_user_organization_urls"}
    string[] currentUserOrganizationUrls?;
    @jsondata:Name {value: "user_url"}
    string userUrl;
    # A feed of discussions for a given repository
    @jsondata:Name {value: "repository_discussions_url"}
    string repositoryDiscussionsUrl?;
    @jsondata:Name {value: "current_user_actor_url"}
    string currentUserActorUrl?;
    # A feed of discussions for a given repository and category
    @jsondata:Name {value: "repository_discussions_category_url"}
    string repositoryDiscussionsCategoryUrl?;
    @jsondata:Name {value: "current_user_public_url"}
    string currentUserPublicUrl?;
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
    Devcontainers[] devcontainers;
    @jsondata:Name {value: "total_count"}
    int totalCount;
};

# Public User
public type PublicUser record {|
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    @jsondata:Name {value: "twitter_username"}
    string? twitterUsername?;
    string? bio;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    string login;
    string 'type;
    string? blog;
    @jsondata:Name {value: "private_gists"}
    int privateGists?;
    @jsondata:Name {value: "total_private_repos"}
    int totalPrivateRepos?;
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    @jsondata:Name {value: "disk_usage"}
    int diskUsage?;
    int collaborators?;
    string? company;
    @jsondata:Name {value: "owned_private_repos"}
    int ownedPrivateRepos?;
    int id;
    @jsondata:Name {value: "public_repos"}
    int publicRepos;
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    PublicUserPlan plan?;
    string? email;
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
    boolean? hireable;
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    @jsondata:Name {value: "public_gists"}
    int publicGists;
    string url;
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    int followers;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    int following;
    string? name;
    string? location;
    @jsondata:Name {value: "node_id"}
    string nodeId;
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
    @jsondata:Name {value: "created_at"}
    string createdAt;
    @jsondata:Name {value: "browser_download_url"}
    string browserDownloadUrl;
    string? label;
    string url;
    @jsondata:Name {value: "download_count"}
    int downloadCount;
    @jsondata:Name {value: "content_type"}
    string contentType;
    int size;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    NullableSimpleUser? uploader;
    # The file name of the asset
    string name;
    int id;
    # State of the release asset
    "uploaded"|"open" state;
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
    @jsondata:Name {value: "total_count"}
    int totalCount;
    @jsondata:Name {value: "incomplete_results"}
    boolean incompleteResults;
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

public type ReviewCommentLinks record {
    @jsondata:Name {value: "pull_request"}
    Link pullRequest;
    Link self;
    Link html;
};

# Minimal Repository
public type NullableMinimalRepository record {
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking?;
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount?;
    @jsondata:Name {value: "is_template"}
    boolean isTemplate?;
    @jsondata:Name {value: "pushed_at"}
    string? pushedAt?;
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    string? language?;
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    RepositoryTemplateRepositoryPermissions permissions?;
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    @jsondata:Name {value: "svn_url"}
    string svnUrl?;
    @jsondata:Name {value: "subscribers_count"}
    int subscribersCount?;
    int id;
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions?;
    int forks?;
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    string visibility?;
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    @jsondata:Name {value: "network_count"}
    int networkCount?;
    @jsondata:Name {value: "ssh_url"}
    string sshUrl?;
    @jsondata:Name {value: "role_name"}
    string roleName?;
    NullableMinimalRepositoryLicense? license?;
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0
    int size?;
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    @jsondata:Name {value: "clone_url"}
    string cloneUrl?;
    string name;
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    @jsondata:Name {value: "default_branch"}
    string defaultBranch?;
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    boolean 'private;
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads?;
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount?;
    string? description;
    @jsondata:Name {value: "created_at"}
    string? createdAt?;
    int watchers?;
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects?;
    boolean archived?;
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki?;
    @jsondata:Name {value: "updated_at"}
    string? updatedAt?;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    boolean disabled?;
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge?;
    @jsondata:Name {value: "git_url"}
    string gitUrl?;
    @jsondata:Name {value: "has_pages"}
    boolean hasPages?;
    SimpleUser owner;
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    string[] topics?;
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues?;
    @jsondata:Name {value: "code_of_conduct"}
    CodeOfConduct codeOfConduct?;
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    string url;
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl?;
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    @jsondata:Name {value: "security_and_analysis"}
    SecurityAndAnalysis? securityAndAnalysis?;
    boolean 'fork;
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    @jsondata:Name {value: "open_issues"}
    int openIssues?;
    @jsondata:Name {value: "watchers_count"}
    int watchersCount?;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    string? homepage?;
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
    NullableSimpleCommitCommitter? committer;
    # SHA for the commit's tree
    @jsondata:Name {value: "tree_id"}
    string treeId;
    NullableSimpleCommitAuthor? author;
    # SHA for the commit
    string id;
    # Message describing the purpose of the commit
    string message;
    # Timestamp of the commit
    string timestamp;
};

# A self hosted runner
public type Runner record {
    # The Operating System of the runner
    string os;
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
    RunnerLabel[] labels;
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

# The security alert number
public type AlertNumber int;

public type RepoMilestonesBody record {
    # A description of the milestone
    string description?;
    # The state of the milestone. Either `open` or `closed`
    "open"|"closed" state = "open";
    # The title of the milestone
    string title;
    # The milestone due date. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    @jsondata:Name {value: "due_on"}
    string dueOn?;
};

# Parameters to be used for the commit_author_email_pattern rule
public type RepositoryRuleCommitAuthorEmailPattern record {
    "commit_author_email_pattern" 'type;
    RepositoryRuleCommitMessagePatternParameters parameters?;
};

public type ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf1 record {
    # The name of the status checks
    string[] contexts;
};

# A Dependabot alert
public type DependabotAlertWithRepository record {|
    DependabotAlertWithRepositoryDependency dependency;
    @jsondata:Name {value: "security_advisory"}
    DependabotAlertSecurityAdvisory securityAdvisory;
    @jsondata:Name {value: "security_vulnerability"}
    DependabotAlertSecurityVulnerability securityVulnerability;
    @jsondata:Name {value: "created_at"}
    AlertCreatedAt createdAt;
    # An optional comment associated with the alert's dismissal
    @jsondata:Name {value: "dismissed_comment"}
    string? dismissedComment;
    SimpleRepository repository;
    @jsondata:Name {value: "auto_dismissed_at"}
    AlertAutoDismissedAt? autoDismissedAt?;
    AlertUrl url;
    AlertNumber number;
    @jsondata:Name {value: "updated_at"}
    AlertUpdatedAt updatedAt;
    @jsondata:Name {value: "html_url"}
    AlertHtmlUrl htmlUrl;
    @jsondata:Name {value: "fixed_at"}
    AlertFixedAt? fixedAt;
    # The state of the Dependabot alert
    "auto_dismissed"|"dismissed"|"fixed"|"open" state;
    @jsondata:Name {value: "dismissed_by"}
    NullableSimpleUser? dismissedBy;
    # The reason that the alert was dismissed
    @jsondata:Name {value: "dismissed_reason"}
    "fix_started"|"inaccurate"|"no_bandwidth"|"not_used"|"tolerable_risk"? dismissedReason;
    @jsondata:Name {value: "dismissed_at"}
    AlertDismissedAt? dismissedAt;
|};

public type HookshookIdBody record {
    string name?;
    # Determines if notifications are sent when the webhook is triggered. Set to `true` to send notifications
    boolean active = true;
    OrgsorghookshookIdConfig config?;
    # Determines what [events](https://docs.github.com/webhooks/event-payloads) the hook is triggered for
    string[] events = ["push"];
};

public type RateLimit record {
    int 'limit;
    int reset;
    int used;
    int remaining;
};

# Thread Subscription
public type ThreadSubscription record {
    boolean subscribed;
    boolean ignored;
    string? reason;
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    @jsondata:Name {value: "thread_url"}
    string threadUrl?;
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl?;
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
    @jsondata:Name {value: "selected_repositories_url"}
    string selectedRepositoriesUrl?;
    # The date and time at which the variable was created, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The value of the variable
    string value;
};

public type CheckRunOutput record {
    string? summary;
    @jsondata:Name {value: "annotations_url"}
    string annotationsUrl;
    string? text;
    string? title;
    @jsondata:Name {value: "annotations_count"}
    int annotationsCount;
};

# A topic aggregates entities that are related to a subject
public type Topic record {
    string[] names;
};

public type ReposownerrepobranchesbranchprotectionrestrictionsusersreposownerrepobranchesbranchprotectionrestrictionsusersOneOf122 string[];

# Represents the Queries record for the operation: repos/list-pages-builds
public type ReposListPagesBuildsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# Whether users can pull changes from upstream when the branch is locked. Set to `true` to allow fork syncing. Set to `false` to prevent fork syncing
public type BranchProtectionAllowForkSyncing record {
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
    @jsondata:Name {value: "app_id"}
    int appId;
    boolean setting;
};

# Commit Comment
public type CommitComment record {
    int? line;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    string body;
    string url;
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    string? path;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    ReactionRollup reactions?;
    int id;
    int? position;
    @jsondata:Name {value: "commit_id"}
    string commitId;
    NullableSimpleUser? user;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Specify which users, teams, and apps can dismiss pull request reviews. Pass an empty `dismissal_restrictions` object to disable. User and team `dismissal_restrictions` are only available for organization-owned repositories. Omit this parameter for personal repositories
public type ReposownerrepobranchesbranchprotectionRequiredPullRequestReviewsDismissalRestrictions record {
    # The list of team `slug`s with dismissal access
    string[] teams?;
    # The list of user `login`s with dismissal access
    string[] users?;
    # The list of app `slug`s with dismissal access
    string[] apps?;
};

public type Manifest record {|
    Metadata metadata?;
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
    # The order to sort by. Default: `asc` when using `full_name`, otherwise `desc`
    "asc"|"desc" direction?;
};

public type RulesetsrulesetIdBody record {
    # The actors that can bypass the rules in this ruleset
    @jsondata:Name {value: "bypass_actors"}
    RepositoryRulesetBypassActor[] bypassActors?;
    # The name of the ruleset
    string name?;
    RepositoryRuleEnforcement enforcement?;
    # An array of rules within the ruleset
    RepositoryRule[] rules?;
    OrgRulesetConditions conditions?;
    # The target of the ruleset
    "branch"|"tag" target?;
};

# Protected Branch Pull Request Review
public type ProtectedBranchPullRequestReview record {
    @jsondata:Name {value: "dismissal_restrictions"}
    ProtectedBranchPullRequestReviewDismissalRestrictions dismissalRestrictions?;
    @jsondata:Name {value: "required_approving_review_count"}
    int requiredApprovingReviewCount?;
    @jsondata:Name {value: "require_code_owner_reviews"}
    boolean requireCodeOwnerReviews;
    @jsondata:Name {value: "dismiss_stale_reviews"}
    boolean dismissStaleReviews;
    @jsondata:Name {value: "bypass_pull_request_allowances"}
    ProtectedBranchPullRequestReviewBypassPullRequestAllowances bypassPullRequestAllowances?;
    # Whether the most recent push must be approved by someone other than the person who pushed it
    @jsondata:Name {value: "require_last_push_approval"}
    boolean requireLastPushApproval = false;
    string url?;
};

# Branch protections protect branches
public type ProtectedBranch record {
    @jsondata:Name {value: "required_pull_request_reviews"}
    ProtectedBranchRequiredPullRequestReviews requiredPullRequestReviews?;
    @jsondata:Name {value: "required_signatures"}
    BranchProtectionRequiredSignatures requiredSignatures?;
    @jsondata:Name {value: "required_status_checks"}
    StatusCheckPolicy requiredStatusChecks?;
    @jsondata:Name {value: "allow_fork_syncing"}
    ProtectedBranchAllowForkSyncing allowForkSyncing?;
    @jsondata:Name {value: "required_linear_history"}
    ProtectedBranchRequiredLinearHistory requiredLinearHistory?;
    BranchRestrictionPolicy restrictions?;
    @jsondata:Name {value: "enforce_admins"}
    ProtectedBranchEnforceAdmins enforceAdmins?;
    string url;
    @jsondata:Name {value: "allow_force_pushes"}
    ProtectedBranchRequiredLinearHistory allowForcePushes?;
    @jsondata:Name {value: "lock_branch"}
    ProtectedBranchLockBranch lockBranch?;
    @jsondata:Name {value: "required_conversation_resolution"}
    ProtectedBranchRequiredConversationResolution requiredConversationResolution?;
    @jsondata:Name {value: "block_creations"}
    ProtectedBranchRequiredLinearHistory blockCreations?;
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

# Identifying information for the git-user
public type GitCommitAuthor record {
    # Timestamp of the commit
    string date;
    # Name of the git user
    string name;
    # Git email address of the user
    string email;
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
    # Set to `open` or `resolved` to only list secret scanning alerts in a specific state
    "open"|"resolved" state?;
    # The property to sort the results by. `created` means when the alert was created. `updated` means when the alert was updated or resolved
    "created"|"updated" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for events after this cursor.  To receive an initial cursor on your first request, include an empty "after" query string
    string after?;
    # A comma-separated list of resolutions. Only secret scanning alerts with one of these resolutions are listed. Valid resolutions are `false_positive`, `wont_fix`, `revoked`, `pattern_edited`, `pattern_deleted` or `used_in_tests`
    string resolution?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

public type OwnerrepoBody record {
    # The permission to grant the team on this repository. We accept the following permissions to be set: `pull`, `triage`, `push`, `maintain`, `admin` and you can also specify a custom repository role name, if the owning organization has defined any. If no permission is specified, the team's `permission` attribute will be used to determine what permission to grant the team on this repository
    string permission = "push";
};

# A GitHub Actions workflow
public type WorkflowResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
    Workflow[] workflows;
};

public type RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf1234567891011121314 record {
    *RepositoryRuleTagNamePattern;
    *RepositoryRuleRulesetInfo;
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

public type ReposownerrepobranchesbranchprotectionrestrictionsusersreposownerrepobranchesbranchprotectionrestrictionsusersOneOf112 string[];

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
    "required_linear_history" 'type;
};

public type LabeledIssueEventLabel record {
    string color;
    string name;
};

public type RepositoryRuleDetailedRepositoryRuleDetailedOneOf12 record {
    *RepositoryRuleUpdate;
    *RepositoryRuleRulesetInfo;
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
    # A branch, tag or commit name used to determine which version of the CODEOWNERS file to use. Default: the repository's default branch (e.g. `main`)
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
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    # Whether to allow rebase merges for pull requests
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge = true;
    RepositoryPermissions permissions?;
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    # The default value for a squash merge commit message:
    # 
    # - `PR_BODY` - default to the pull request's body.
    # - `COMMIT_MESSAGES` - default to the branch's commit messages.
    # - `BLANK` - default to a blank commit message
    @jsondata:Name {value: "squash_merge_commit_message"}
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squashMergeCommitMessage?;
    @jsondata:Name {value: "subscribers_count"}
    int subscribersCount?;
    # Unique identifier of the repository
    int id;
    # Whether discussions are enabled
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions = false;
    int forks;
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    @jsondata:Name {value: "ssh_url"}
    string sshUrl;
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0
    int size;
    @jsondata:Name {value: "template_repository"}
    RepositoryTemplateRepository? templateRepository?;
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    @jsondata:Name {value: "clone_url"}
    string cloneUrl;
    # The default branch of the repository
    @jsondata:Name {value: "default_branch"}
    string defaultBranch;
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    # Whether downloads are enabled
    # 
    # # Deprecated
    @jsondata:Name {value: "has_downloads"}
    @deprecated
    boolean hasDownloads = true;
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    int watchers;
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    # Whether the repository is archived
    boolean archived = false;
    # Whether the wiki is enabled
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki = true;
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    # Returns whether or not this repository disabled
    boolean disabled;
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    string[] topics?;
    # Whether or not a pull request head branch that is behind its base branch can always be updated even if it is not required to be up to date before merging
    @jsondata:Name {value: "allow_update_branch"}
    boolean allowUpdateBranch = false;
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    @jsondata:Name {value: "starred_at"}
    string starredAt?;
    string url;
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # Whether a squash merge commit can use the pull request title as default. **This property has been deprecated. Please use `squash_merge_commit_title` instead
    # 
    # # Deprecated
    @jsondata:Name {value: "use_squash_pr_title_as_default"}
    @deprecated
    boolean useSquashPrTitleAsDefault = false;
    NullableSimpleUser? organization?;
    # The default value for a merge commit message.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `PR_BODY` - default to the pull request's body.
    # - `BLANK` - default to a blank commit message
    @jsondata:Name {value: "merge_commit_message"}
    "PR_BODY"|"PR_TITLE"|"BLANK" mergeCommitMessage?;
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    # The default value for a squash merge commit title:
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `COMMIT_OR_PR_TITLE` - default to the commit's title (if only one commit) or the pull request's title (when more than one commit)
    @jsondata:Name {value: "squash_merge_commit_title"}
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squashMergeCommitTitle?;
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount;
    # Whether this repository acts as a template that can be used to generate new repositories
    @jsondata:Name {value: "is_template"}
    boolean isTemplate = false;
    @jsondata:Name {value: "pushed_at"}
    string? pushedAt;
    string? language;
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    @jsondata:Name {value: "svn_url"}
    string svnUrl;
    @jsondata:Name {value: "master_branch"}
    string masterBranch?;
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    # Whether to allow merge commits for pull requests
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit = true;
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The repository visibility: public, private, or internal
    string visibility = "public";
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    @jsondata:Name {value: "network_count"}
    int networkCount?;
    NullableLicenseSimple? license;
    # Whether to allow Auto-merge to be used on pull requests
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge = false;
    # The name of the repository
    string name;
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    # Whether the repository is private or public
    boolean 'private = false;
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount;
    string? description;
    # Whether projects are enabled
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects = true;
    # The default value for a merge commit title.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `MERGE_MESSAGE` - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name)
    @jsondata:Name {value: "merge_commit_title"}
    "PR_TITLE"|"MERGE_MESSAGE" mergeCommitTitle?;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    # Whether to delete head branches when pull requests are merged
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge = false;
    @jsondata:Name {value: "git_url"}
    string gitUrl;
    @jsondata:Name {value: "has_pages"}
    boolean hasPages;
    SimpleUser owner;
    # Whether to allow squash merges for pull requests
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge = true;
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    # Whether issues are enabled
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues = true;
    # Whether to require contributors to sign off on web-based commits
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired = false;
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl;
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    boolean 'fork;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    @jsondata:Name {value: "watchers_count"}
    int watchersCount;
    string? homepage;
    @jsondata:Name {value: "forks_count"}
    int forksCount;
};

# Represents the Queries record for the operation: code-scanning/list-alert-instances
public type CodeScanningListAlertInstancesQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The Git reference for the results you want to list. The `ref` for a branch can be formatted either as `refs/heads/<branch name>` or simply `<branch name>`. To reference a pull request use `refs/pull/<number>/merge`
    CodeScanningRef ref?;
    # Page number of the results to fetch
    int page = 1;
};

public type PullRequestReviewCommentLinksHtml record {
    string href;
};

public type OrgInvitationsBody record {
    # The role for the new member. 
    #  * `admin` - Organization owners with full administrative rights to the organization and complete access to all repositories and teams.  
    #  * `direct_member` - Non-owner organization members with ability to see other members and join teams by invitation.  
    #  * `billing_manager` - Non-owner organization members with ability to manage the billing settings of your organization
    "admin"|"direct_member"|"billing_manager" role = "direct_member";
    # Specify IDs for the teams you want to invite new members to
    @jsondata:Name {value: "team_ids"}
    int[] teamIds?;
    # **Required unless you provide `email`**. GitHub user ID for the person you are inviting
    @jsondata:Name {value: "invitee_id"}
    int inviteeId?;
    # **Required unless you provide `invitee_id`**. Email address of the person you are inviting, which can be an existing GitHub user
    string email?;
};

# Represents the Queries record for the operation: activity/list-repos-starred-by-user
public type ActivityListReposStarredByUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The property to sort the results by. `created` means when the repository was starred. `updated` means when the repository was last pushed to
    "created"|"updated" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub
public type NullableIntegration record {
    NullableSimpleUser? owner;
    # The number of installations associated with the GitHub app
    @jsondata:Name {value: "installations_count"}
    int installationsCount?;
    string? description;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    @jsondata:Name {value: "client_id"}
    string clientId?;
    @jsondata:Name {value: "external_url"}
    string externalUrl;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    IntegrationPermissions permissions;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The name of the GitHub app
    string name;
    @jsondata:Name {value: "webhook_secret"}
    string? webhookSecret?;
    string pem?;
    # Unique identifier of the GitHub app
    int id;
    @jsondata:Name {value: "client_secret"}
    string clientSecret?;
    # The slug name of the GitHub app
    string slug?;
    # The list of events for the GitHub app
    string[] events;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# GitHub Actions Cache Usage by repository
public type ActionsCacheUsageByRepositoryResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
    @jsondata:Name {value: "repository_cache_usages"}
    ActionsCacheUsageByRepository[] repositoryCacheUsages;
};

# Actor
public type Actor record {
    @jsondata:Name {value: "display_login"}
    string displayLogin?;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    int id;
    string login;
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
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
    @jsondata:Name {value: "UBUNTU"}
    WorkflowRunUsageBillableUBUNTU uBUNTU?;
    @jsondata:Name {value: "MACOS"}
    WorkflowRunUsageBillableUBUNTU mACOS?;
    @jsondata:Name {value: "WINDOWS"}
    WorkflowRunUsageBillableUBUNTU wINDOWS?;
};

public type SecretScanningAlert record {
    # The type of secret that secret scanning detected
    @jsondata:Name {value: "secret_type"}
    string secretType?;
    @jsondata:Name {value: "push_protection_bypassed_by"}
    NullableSimpleUser? pushProtectionBypassedBy?;
    # The time that push protection was bypassed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`
    @jsondata:Name {value: "push_protection_bypassed_at"}
    string? pushProtectionBypassedAt?;
    @jsondata:Name {value: "created_at"}
    AlertCreatedAt createdAt?;
    # User-friendly name for the detected secret, matching the `secret_type`.
    # For a list of built-in patterns, see "[Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns#supported-secrets-for-advanced-security)."
    @jsondata:Name {value: "secret_type_display_name"}
    string secretTypeDisplayName?;
    # The secret that was detected
    string secret?;
    SecretScanningAlertResolution? resolution?;
    AlertUrl url?;
    AlertNumber number?;
    @jsondata:Name {value: "resolved_by"}
    NullableSimpleUser? resolvedBy?;
    @jsondata:Name {value: "updated_at"}
    NullableAlertUpdatedAt? updatedAt?;
    # The REST API URL of the code locations for this alert
    @jsondata:Name {value: "locations_url"}
    string locationsUrl?;
    # An optional comment to resolve an alert
    @jsondata:Name {value: "resolution_comment"}
    string? resolutionComment?;
    # The time that the alert was resolved in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`
    @jsondata:Name {value: "resolved_at"}
    string? resolvedAt?;
    @jsondata:Name {value: "html_url"}
    AlertHtmlUrl htmlUrl?;
    # Whether push protection was bypassed for the detected secret
    @jsondata:Name {value: "push_protection_bypassed"}
    boolean? pushProtectionBypassed?;
    SecretScanningAlertState state?;
};

public type TopicSearchResultItemRelated record {
    @jsondata:Name {value: "topic_relation"}
    TopicSearchResultItemTopicRelation topicRelation?;
};

public type GpgKeySubkeys record {
    @jsondata:Name {value: "public_key"}
    string publicKey?;
    @jsondata:Name {value: "key_id"}
    string keyId?;
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    boolean revoked?;
    @jsondata:Name {value: "raw_key"}
    string? rawKey?;
    GpgKeyEmails[] emails?;
    @jsondata:Name {value: "can_certify"}
    boolean canCertify?;
    @jsondata:Name {value: "expires_at"}
    string? expiresAt?;
    @jsondata:Name {value: "can_encrypt_comms"}
    boolean canEncryptComms?;
    @jsondata:Name {value: "can_encrypt_storage"}
    boolean canEncryptStorage?;
    @jsondata:Name {value: "can_sign"}
    boolean canSign?;
    int id?;
    anydata[] subkeys?;
    @jsondata:Name {value: "primary_key_id"}
    int primaryKeyId?;
};

# Key/value pairs to provide settings for this webhook
public type OrgsorghooksConfig record {
    string password?;
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    WebhookConfigSecret secret?;
    WebhookConfigUrl url;
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

# **Required when the `state` is `resolved`.** The reason for resolving the alert
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
    # Wildcard characters will not match `/`. For example, to match branches that begin with `release/` and contain an additional single slash, use `release/*/*`.
    # For more information about pattern matching syntax, see the [Ruby File.fnmatch documentation](https://ruby-doc.org/core-2.5.1/File.html#method-c-fnmatch)
    string name;
    # Whether this rule targets a branch or tag
    "branch"|"tag" 'type?;
};

# Represents the Queries record for the operation: repos/list-webhook-deliveries
public type ReposListWebhookDeliveriesQueries record {
    # Used for pagination: the starting delivery from which the page of deliveries is fetched. Refer to the `link` header for the next and previous page cursors
    string cursor?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    boolean redelivery?;
};

public type TimelineReviewedEventLinksHtml record {
    string href;
};

public type StargazerResponseStargazerResponseAnyOf12 Stargazer[];

# Commit Search Result Item
public type CommitSearchResultItem record {
    decimal score;
    NullableGitUser? committer;
    NullableSimpleUser? author;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "text_matches"}
    SearchResultTextMatches textMatches?;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    CommitSearchResultItemCommit 'commit;
    MinimalRepository repository;
    string sha;
    string url;
    FileCommitCommitParents[] parents;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type Dependency record {|
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
    string? reason?;
    @jsondata:Name {value: "is_cloudflare_ip"}
    boolean? isCloudflareIp?;
    @jsondata:Name {value: "enforces_https"}
    boolean enforcesHttps?;
    @jsondata:Name {value: "is_pointed_to_github_pages_ip"}
    boolean? isPointedToGithubPagesIp?;
    @jsondata:Name {value: "is_served_by_pages"}
    boolean? isServedByPages?;
    @jsondata:Name {value: "is_fastly_ip"}
    boolean? isFastlyIp?;
    @jsondata:Name {value: "is_apex_domain"}
    boolean isApexDomain?;
    string host?;
    @jsondata:Name {value: "responds_to_https"}
    boolean respondsToHttps?;
    @jsondata:Name {value: "is_cname_to_pages_dot_github_dot_com"}
    boolean? isCnameToPagesDotGithubDotCom?;
    @jsondata:Name {value: "is_a_record"}
    boolean? isARecord?;
    @jsondata:Name {value: "is_cname_to_github_user_domain"}
    boolean? isCnameToGithubUserDomain?;
    @jsondata:Name {value: "is_pages_domain"}
    boolean isPagesDomain?;
    @jsondata:Name {value: "is_old_ip_address"}
    boolean? isOldIpAddress?;
    @jsondata:Name {value: "has_cname_record"}
    boolean? hasCnameRecord?;
    @jsondata:Name {value: "is_cname_to_fastly"}
    boolean? isCnameToFastly?;
    @jsondata:Name {value: "dns_resolves"}
    boolean dnsResolves?;
    @jsondata:Name {value: "is_https_eligible"}
    boolean? isHttpsEligible?;
    @jsondata:Name {value: "caa_error"}
    string? caaError?;
    @jsondata:Name {value: "is_proxied"}
    boolean? isProxied?;
    @jsondata:Name {value: "is_valid_domain"}
    boolean isValidDomain?;
    @jsondata:Name {value: "is_non_github_pages_ip_present"}
    boolean? isNonGithubPagesIpPresent?;
    string uri?;
    @jsondata:Name {value: "should_be_a_record"}
    boolean? shouldBeARecord?;
    string nameservers?;
    @jsondata:Name {value: "has_mx_records_present"}
    boolean? hasMxRecordsPresent?;
    @jsondata:Name {value: "is_valid"}
    boolean isValid?;
    @jsondata:Name {value: "https_error"}
    string? httpsError?;
};

# Key/value pairs to provide settings for this webhook
public type OrgsorghookshookIdConfig record {
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    WebhookConfigSecret secret?;
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
    @jsondata:Name {value: "columns_url"}
    string columnsUrl;
    NullableSimpleUser? creator;
    # Whether or not this project can be seen by everyone. Only present if owner is an organization
    boolean 'private?;
    # The baseline permission that all organization members have on this project. Only present if owner is an organization
    @jsondata:Name {value: "organization_permission"}
    "read"|"write"|"admin"|"none" organizationPermission?;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Body of the project
    string? body;
    string url;
    @jsondata:Name {value: "owner_url"}
    string ownerUrl;
    int number;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Name of the project
    string name;
    int id;
    # State of the project; either 'open' or 'closed'
    string state;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type IssueNumberLabelsBody1 ReposownerrepoissuesissueNumberlabelsOneOf11|ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf112|ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf1123|ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf11234|ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf112345;

# Conditions to target repositories by id and refs by name
public type RepositoryIdAndRefName record {
    *RepositoryRulesetConditions;
    *RepositoryRulesetConditionsRepositoryIdTarget;
};

public type RefsrefBody record {
    # Indicates whether to force the update or to make sure the update is a fast-forward update. Leaving this out or setting it to `false` will make sure you're not overwriting work
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
    # **This field is deprecated.** Sorts the results of your query. Can only be `indexed`, which indicates how recently a file has been indexed by the GitHub search infrastructure. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    # 
    # # Deprecated
    @deprecated
    "indexed" sort?;
    # Page number of the results to fetch
    int page = 1;
    # **This field is deprecated.** Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`. 
    # 
    # # Deprecated
    @deprecated
    "desc"|"asc" 'order = "desc";
};

# Topic Search Result Item
public type TopicSearchResultItem record {
    @jsondata:Name {value: "short_description"}
    string? shortDescription;
    boolean featured;
    TopicSearchResultItemRelated[]? aliases?;
    @jsondata:Name {value: "logo_url"}
    string? logoUrl?;
    string? description;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    @jsondata:Name {value: "display_name"}
    string? displayName;
    @jsondata:Name {value: "created_by"}
    string? createdBy;
    decimal score;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    TopicSearchResultItemRelated[]? related?;
    boolean curated;
    @jsondata:Name {value: "text_matches"}
    SearchResultTextMatches textMatches?;
    string name;
    @jsondata:Name {value: "repository_count"}
    int? repositoryCount?;
    string? released;
};

# Set secrets for GitHub Actions
public type ActionsSecretResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
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
    @jsondata:Name {value: "billable_owner"}
    SimpleUser billableOwner;
    # API URL to start this codespace
    @jsondata:Name {value: "start_url"}
    string startUrl;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # API URL to stop this codespace
    @jsondata:Name {value: "stop_url"}
    string stopUrl;
    MinimalRepository repository;
    # Last known time this codespace was started
    @jsondata:Name {value: "last_used_at"}
    string lastUsedAt;
    # Whether the codespace was created from a prebuild
    boolean? prebuild;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # When a codespace will be auto-deleted based on the "retention_period_minutes" and "last_used_at"
    @jsondata:Name {value: "retention_expires_at"}
    string? retentionExpiresAt?;
    int id;
    # State of this codespace
    "Unknown"|"Created"|"Queued"|"Provisioning"|"Available"|"Awaiting"|"Unavailable"|"Deleted"|"Moved"|"Shutdown"|"Archived"|"Starting"|"ShuttingDown"|"Failed"|"Exporting"|"Updating"|"Rebuilding" state;
    @jsondata:Name {value: "git_status"}
    CodespaceGitStatus gitStatus;
    # API URL to publish this codespace to a new repository
    @jsondata:Name {value: "publish_url"}
    string? publishUrl?;
    # API URL to access available alternate machine types for this codespace
    @jsondata:Name {value: "machines_url"}
    string machinesUrl;
    SimpleUser owner;
    @jsondata:Name {value: "runtime_constraints"}
    CodespaceRuntimeConstraints runtimeConstraints?;
    # The text to display to a user when a codespace has been stopped for a potentially actionable reason
    @jsondata:Name {value: "last_known_stop_notice"}
    string? lastKnownStopNotice?;
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
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    LabeledIssueEventLabel label;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Tag protection
public type TagProtection record {
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    string pattern;
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    int id?;
    boolean enabled?;
};

public type NotificationThreadSubject record {
    @jsondata:Name {value: "latest_comment_url"}
    string latestCommentUrl;
    string title;
    string 'type;
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
    int uniques;
    int count;
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
    @jsondata:Name {value: "minutes_used_breakdown"}
    ActionsBillingUsageMinutesUsedBreakdown minutesUsedBreakdown;
};

public type ProtectionRulesProtectionRulesAnyOf12 record {
    # Whether deployments to this environment can be approved by the user who created the deployment
    @jsondata:Name {value: "prevent_self_review"}
    boolean preventSelfReview?;
    int id;
    string 'type;
    # The people or teams that may approve jobs that reference the environment. You can list up to six users or teams as reviewers. The reviewers must have at least read access to the repository. Only one of the required reviewers needs to approve the job for it to proceed
    PendingDeploymentReviewers[] reviewers?;
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
    @jsondata:Name {value: "role_name"}
    string roleName;
    string permission;
    NullableCollaborator? user;
};

public type PullNumberUpdateBranchBody record {
    # The expected SHA of the pull request's HEAD ref. This is the most recent commit on the pull request's branch. If the expected SHA does not match the pull request's HEAD, you will receive a `422 Unprocessable Entity` status. You can use the "[List commits](https://docs.github.com/rest/commits/commits#list-commits)" endpoint to find the most recent commit SHA. Default: SHA of the pull request's current HEAD ref
    @jsondata:Name {value: "expected_head_sha"}
    string expectedHeadSha?;
};

public type PullNumberReviewsBody record {
    # Use the following table to specify the location, destination, and contents of the draft review comment
    ReposownerrepopullspullNumberreviewsComments[] comments?;
    # **Required** when using `REQUEST_CHANGES` or `COMMENT` for the `event` parameter. The body text of the pull request review
    string body?;
    # The review action you want to perform. The review actions include: `APPROVE`, `REQUEST_CHANGES`, or `COMMENT`. By leaving this blank, you set the review action state to `PENDING`, which means you will need to [submit the pull request review](https://docs.github.com/rest/pulls/reviews#submit-a-review-for-a-pull-request) when you are ready
    "APPROVE"|"REQUEST_CHANGES"|"COMMENT" event?;
    # The SHA of the commit that needs a review. Not using the latest commit SHA may render your review comment outdated if a subsequent commit modifies the line you specify as the `position`. Defaults to the most recent commit in the pull request when you do not specify a value
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
    # The name of a code scanning tool. Only results by this tool will be listed. You can specify the tool by using either `tool_name` or `tool_guid`, but not both
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
    # The GUID of a code scanning tool. Only results by this tool will be listed. Note that some code scanning tools may not include a GUID in their analysis data. You can specify the tool by using either `tool_guid` or `tool_name`, but not both
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
    string path?;
    int size?;
    @jsondata:Name {value: "_links"}
    FileCommitContentLinks links?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    string name?;
    @jsondata:Name {value: "download_url"}
    string downloadUrl?;
    @jsondata:Name {value: "git_url"}
    string gitUrl?;
    string 'type?;
    string sha?;
    string url?;
};

public type ReviewIdDismissalsBody record {
    # The message for the pull request review dismissal
    string message;
    "DISMISS" event?;
};

# Rate Limit Overview
public type RateLimitOverview record {
    RateLimit rate;
    RateLimitOverviewResources resources;
};

# A repository rule
public type RepositoryRule RepositoryRuleCreation|RepositoryRuleUpdate|RepositoryRuleDeletion|RepositoryRuleRequiredLinearHistory|RepositoryRuleRequiredDeployments|RepositoryRuleRequiredSignatures|RepositoryRulePullRequest|RepositoryRuleRequiredStatusChecks|RepositoryRuleNonFastForward|RepositoryRuleCommitMessagePattern|RepositoryRuleCommitAuthorEmailPattern|RepositoryRuleCommitterEmailPattern|RepositoryRuleBranchNamePattern|RepositoryRuleTagNamePattern;

public type PullRequestReviewCommentLinksSelf record {
    string href;
};

# Sets the state of the secret scanning alert. You must provide `resolution` when you set the state to `resolved`
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
    "commit_message_pattern" 'type;
    RepositoryRuleCommitMessagePatternParameters parameters?;
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
    # Setting to `true` returns only protected branches. When set to `false`, only unprotected branches are returned. Omitting this parameter returns all branches
    boolean protected?;
    # Page number of the results to fetch
    int page = 1;
};

# Represents the Queries record for the operation: apps/list-installations
public type AppsListInstallationsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    string outdated?;
    # Page number of the results to fetch
    int page = 1;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string since?;
};

public type RepoNotificationsBody record {
    # Describes the last point that notifications were checked. Anything updated since this time will not be marked as read. If you omit this parameter, all notifications are marked as read. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`. Default: The current timestamp
    @jsondata:Name {value: "last_read_at"}
    string lastReadAt?;
};

# Deletes one or more email addresses from your GitHub account. Must contain at least one email address. **Note:** Alternatively, you can pass a single email address or an `array` of emails addresses directly, but we recommend that you pass an object using the `emails` key
public type UseremailsOneOf11 record {
    # Email addresses associated with the GitHub user account
    string[] emails;
};

public type PullRequestHeadRepo record {
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking?;
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount;
    @jsondata:Name {value: "is_template"}
    boolean isTemplate?;
    @jsondata:Name {value: "pushed_at"}
    string pushedAt;
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    string? language;
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge?;
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    FullRepositoryPermissions permissions?;
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    @jsondata:Name {value: "svn_url"}
    string svnUrl;
    int id;
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions;
    @jsondata:Name {value: "master_branch"}
    string masterBranch?;
    int forks;
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit?;
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The repository visibility: public, private, or internal
    string visibility?;
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    @jsondata:Name {value: "ssh_url"}
    string sshUrl;
    PullRequestHeadRepoLicense? license;
    @jsondata:Name {value: "full_name"}
    string fullName;
    int size;
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "clone_url"}
    string cloneUrl;
    string name;
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    @jsondata:Name {value: "default_branch"}
    string defaultBranch;
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    boolean 'private;
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads;
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount;
    string? description;
    int watchers;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects;
    boolean archived;
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    boolean disabled;
    @jsondata:Name {value: "git_url"}
    string gitUrl;
    @jsondata:Name {value: "has_pages"}
    boolean hasPages;
    PullRequestHeadRepoOwner owner;
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge?;
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    string[] topics?;
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues;
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    string url;
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl;
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    boolean 'fork;
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    @jsondata:Name {value: "watchers_count"}
    int watchersCount;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    @jsondata:Name {value: "forks_count"}
    int forksCount;
    string? homepage;
};

# A unique encryption key
public type GpgKey record {
    @jsondata:Name {value: "public_key"}
    string publicKey;
    @jsondata:Name {value: "key_id"}
    string keyId;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    boolean revoked;
    @jsondata:Name {value: "raw_key"}
    string? rawKey;
    GpgKeyEmails[] emails;
    @jsondata:Name {value: "can_certify"}
    boolean canCertify;
    @jsondata:Name {value: "expires_at"}
    string? expiresAt;
    @jsondata:Name {value: "can_encrypt_comms"}
    boolean canEncryptComms;
    string? name?;
    @jsondata:Name {value: "can_encrypt_storage"}
    boolean canEncryptStorage;
    @jsondata:Name {value: "can_sign"}
    boolean canSign;
    int id;
    GpgKeySubkeys[] subkeys;
    @jsondata:Name {value: "primary_key_id"}
    int? primaryKeyId;
};

public type ContentTreeLinks record {
    string? git;
    string self;
    string? html;
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
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string since?;
};

# Color-coded labels help you categorize and filter your issues (just like labels in Gmail)
public type Label record {
    boolean default;
    # 6-character hex code, without the leading #, identifying the color
    string color;
    # The name of the label
    string name;
    string? description;
    int id;
    # URL for the label
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type StarredRepositoryResponseAnyOf1 StarredRepository[];

public type FileCommitCommit record {
    FileCommitCommitAuthor committer?;
    FileCommitCommitAuthor author?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    FileCommitCommitTree tree?;
    string message?;
    string sha?;
    string url?;
    FileCommitCommitVerification verification?;
    @jsondata:Name {value: "node_id"}
    string nodeId?;
    FileCommitCommitParents[] parents?;
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
    @jsondata:Name {value: "_links"}
    ContentTreeLinks links;
    string 'type;
    string encoding;
    string sha;
    string url;
    string content;
    string path;
    NullableLicenseSimple? license;
    int size;
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    string name;
    @jsondata:Name {value: "download_url"}
    string? downloadUrl;
    @jsondata:Name {value: "git_url"}
    string? gitUrl;
};

# A label for a self hosted runner
public type RunnerLabelResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
    RunnerLabel[] labels;
};

public type ActionsRepositoryPermissions record {
    @jsondata:Name {value: "allowed_actions"}
    AllowedActions allowedActions?;
    @jsondata:Name {value: "selected_actions_url"}
    SelectedActionsUrl selectedActionsUrl?;
    ActionsEnabled enabled;
};

public type RepoCheckRunsBody record {"completed" status;}|record {"queued"|"in_progress" status?;};

# Whether to set the branch as read-only. If this is true, users will not be able to push to the branch
public type ProtectedBranchLockBranch record {|
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
    # The geographic area for this codespace. If not specified, the value is assigned by IP. This property replaces `location`, which is being deprecated
    "EuropeWest"|"SoutheastAsia"|"UsEast"|"UsWest" geo?;
    # Path to devcontainer.json config to use for this codespace
    @jsondata:Name {value: "devcontainer_path"}
    string devcontainerPath?;
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
    @jsondata:Name {value: "instances_url"}
    AlertInstancesUrl instancesUrl;
    @jsondata:Name {value: "created_at"}
    AlertCreatedAt createdAt;
    @jsondata:Name {value: "dismissed_comment"}
    CodeScanningAlertDismissedComment? dismissedComment?;
    CodeScanningAlertRule rule;
    AlertUrl url;
    CodeScanningAnalysisTool tool;
    AlertNumber number;
    @jsondata:Name {value: "updated_at"}
    AlertUpdatedAt updatedAt?;
    @jsondata:Name {value: "html_url"}
    AlertHtmlUrl htmlUrl;
    @jsondata:Name {value: "fixed_at"}
    AlertFixedAt? fixedAt?;
    @jsondata:Name {value: "most_recent_instance"}
    CodeScanningAlertInstance mostRecentInstance;
    CodeScanningAlertState state;
    @jsondata:Name {value: "dismissed_by"}
    NullableSimpleUser? dismissedBy;
    @jsondata:Name {value: "dismissed_reason"}
    CodeScanningAlertDismissedReason? dismissedReason;
    @jsondata:Name {value: "dismissed_at"}
    AlertDismissedAt? dismissedAt;
};

# A GitHub user simplified for Classroom
public type SimpleClassroomUser record {
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    int id;
    string login;
};

# Set secrets for Dependabot
public type DependabotSecretResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
    DependabotSecret[] secrets;
};

# Interaction limit settings
public type InteractionLimitResponseAny InteractionLimitResponse|InteractionLimitResponseAnyAnyOf2;

public type FileCommitContentLinks record {
    string git?;
    string self?;
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
    @jsondata:Name {value: "_links"}
    RepositoryRulesetLinks links?;
    RepositoryRuleEnforcement enforcement;
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    # The type of the source of the ruleset
    @jsondata:Name {value: "source_type"}
    "Repository"|"Organization" sourceType?;
    RepositoryRule[] rules?;
    # The name of the source
    string 'source;
    # The target of the ruleset
    "branch"|"tag" target?;
    # The actors that can bypass the rules in this ruleset
    @jsondata:Name {value: "bypass_actors"}
    RepositoryRulesetBypassActor[] bypassActors?;
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
    RepositoryRulesetConditions|OrgRulesetConditions conditions?;
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# The full Git reference, formatted as `refs/heads/<branch name>`,
# `refs/pull/<number>/merge`, or `refs/pull/<number>/head`
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
    @jsondata:Name {value: "SHA256_RSA"}
    string sHA256RSA?;
    @jsondata:Name {value: "SHA256_DSA"}
    string sHA256DSA?;
    @jsondata:Name {value: "SHA256_ECDSA"}
    string sHA256ECDSA?;
    @jsondata:Name {value: "SHA256_ED25519"}
    string sHA256ED25519?;
};

# Clone Traffic
public type CloneTraffic record {
    Traffic[] clones;
    int count;
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
    string href;
};

public type GitCommitParents record {
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # SHA for the commit
    string sha;
    string url;
};

public type PullspullNumberBody record {
    # Indicates whether [maintainers can modify](https://docs.github.com/articles/allowing-changes-to-a-pull-request-branch-created-from-a-fork/) the pull request
    @jsondata:Name {value: "maintainer_can_modify"}
    boolean maintainerCanModify?;
    # State of this Pull Request. Either `open` or `closed`
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
    # The permission to grant the collaborator. **Only valid on organization-owned repositories.** We accept the following permissions to be set: `pull`, `triage`, `push`, `maintain`, `admin` and you can also specify a custom repository role name, if the owning organization has defined any
    string permission = "push";
};

public type RepositoryAdvisoryCreate record {|
    # A short summary of the advisory
    @constraint:String {maxLength: 1024}
    string summary;
    # The severity of the advisory. You must choose between setting this field or `cvss_vector_string`
    "critical"|"high"|"medium"|"low"? severity?;
    # The Common Vulnerabilities and Exposures (CVE) ID
    @jsondata:Name {value: "cve_id"}
    string? cveId?;
    # A list of users receiving credit for their participation in the security advisory
    RepositoryAdvisoryCreateCredits[]? credits?;
    # The CVSS vector that calculates the severity of the advisory. You must choose between setting this field or `severity`
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
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    string name;
    string body?;
    string 'key;
    string url;
};

# Minimal representation of an organization programmatic access grant request for enumerations
public type OrganizationProgrammaticAccessGrantRequest record {
    SimpleUser owner;
    # Reason for requesting access
    string? reason;
    # Type of repository selection requested
    @jsondata:Name {value: "repository_selection"}
    "none"|"all"|"subset" repositorySelection;
    # URL to the list of repositories requested to be accessed via fine-grained personal access token. Should only be followed when `repository_selection` is `subset`
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
    # Date and time when the associated fine-grained personal access token expires
    @jsondata:Name {value: "token_expires_at"}
    string? tokenExpiresAt;
    OrganizationProgrammaticAccessGrantRequestPermissions permissions;
    # Date and time when the associated fine-grained personal access token was last used for authentication
    @jsondata:Name {value: "token_last_used_at"}
    string? tokenLastUsedAt;
    # Date and time when the request for access was created
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Unique identifier of the request for access via fine-grained personal access token. The `pat_request_id` used to review PAT requests
    int id;
    # Whether the associated fine-grained personal access token has expired
    @jsondata:Name {value: "token_expired"}
    boolean tokenExpired;
};

public type RepoKeysBody record {
    # If `true`, the key will only be able to read repository contents. Otherwise, the key will be able to read and write.  
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
    @jsondata:Name {value: "default_workflow_permissions"}
    ActionsDefaultWorkflowPermissions defaultWorkflowPermissions?;
    @jsondata:Name {value: "can_approve_pull_request_reviews"}
    ActionsCanApprovePullRequestReviews canApprovePullRequestReviews?;
};

public type InstallationIdAccessTokensBody record {
    # List of repository IDs that the token should have access to
    @jsondata:Name {value: "repository_ids"}
    int[] repositoryIds?;
    # List of repository names that the token should have access to
    string[] repositories?;
    AppPermissions permissions?;
};

public type RequiredStatusChecksContextsBody2 ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf12|ReposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsreposownerrepobranchesbranchprotectionrequiredStatusCheckscontextsOneOf122;

# Set repository secrets for GitHub Codespaces
public type RepoCodespacesSecretResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
    RepoCodespacesSecret[] secrets;
};

public type RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf12345678910111213 record {
    *RepositoryRuleBranchNamePattern;
    *RepositoryRuleRulesetInfo;
};

# Contributor
public type Contributor record {
    @jsondata:Name {value: "gists_url"}
    string gistsUrl?;
    @jsondata:Name {value: "repos_url"}
    string reposUrl?;
    @jsondata:Name {value: "following_url"}
    string followingUrl?;
    @jsondata:Name {value: "starred_url"}
    string starredUrl?;
    string login?;
    @jsondata:Name {value: "followers_url"}
    string followersUrl?;
    string 'type;
    string url?;
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl?;
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl?;
    int contributions;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl?;
    @jsondata:Name {value: "events_url"}
    string eventsUrl?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin?;
    string name?;
    int id?;
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId?;
    string email?;
    @jsondata:Name {value: "node_id"}
    string nodeId?;
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl?;
};

# Results of a successful merge upstream request
public type MergedUpstream record {
    @jsondata:Name {value: "base_branch"}
    string baseBranch?;
    @jsondata:Name {value: "merge_type"}
    "merge"|"fast-forward"|"none" mergeType?;
    string message?;
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
    # The direction to sort results. Ignored without `sort` parameter
    "asc"|"desc" direction?;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string since?;
};

public type RepositoryAdvisoryUpdate record {|
    # A short summary of the advisory
    @constraint:String {maxLength: 1024}
    string summary?;
    # The severity of the advisory. You must choose between setting this field or `cvss_vector_string`
    "critical"|"high"|"medium"|"low"? severity?;
    # The Common Vulnerabilities and Exposures (CVE) ID
    @jsondata:Name {value: "cve_id"}
    string? cveId?;
    # A list of users receiving credit for their participation in the security advisory
    RepositoryAdvisoryCreateCredits[]? credits?;
    # The CVSS vector that calculates the severity of the advisory. You must choose between setting this field or `severity`
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
    # Filter the list of outside collaborators. `2fa_disabled` means that only outside collaborators without [two-factor authentication](https://github.com/blog/1614-two-factor-authentication) enabled will be returned
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

public type AddedToProjectIssueEventProjectCard record {
    @jsondata:Name {value: "project_id"}
    int projectId;
    @jsondata:Name {value: "column_name"}
    string columnName;
    @jsondata:Name {value: "project_url"}
    string projectUrl;
    int id;
    @jsondata:Name {value: "previous_column_name"}
    string previousColumnName?;
    string url;
};

public type PullRequestMinimalHeadRepo record {
    string name;
    int id;
    string url;
};

# Information about the Git author
public type NullableSimpleCommitAuthor record {
    # Name of the commit's author
    string name;
    # Git email address of the commit's author
    string email;
};

# Social media account
public type SocialAccount record {
    string provider;
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
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "performed_via_github_app"}
    Integration performedViaGithubApp;
    SimpleUser assigner;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    SimpleUser assignee;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type UserResponse PrivateUser|PublicUser;

# Branch With Protection
public type BranchWithProtection record {
    boolean protected;
    @jsondata:Name {value: "_links"}
    BranchWithProtectionLinks links;
    @jsondata:Name {value: "required_approving_review_count"}
    int requiredApprovingReviewCount?;
    string name;
    Commit 'commit;
    string pattern?;
    BranchProtection protection;
    @jsondata:Name {value: "protection_url"}
    string protectionUrl;
};

# Collaborator
public type Collaborator record {
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    string login;
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    string 'type;
    string url;
    @jsondata:Name {value: "role_name"}
    string roleName;
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    CollaboratorPermissions permissions?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    string? name?;
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    int id;
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    string? email?;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
};

public type LabelsnameBody record {
    # The [hexadecimal color code](http://www.color-hex.com/) for the label, without the leading `#`
    string color?;
    # A short description of the label. Must be 100 characters or fewer
    string description?;
    # The new name of the label. Emoji can be added to label names, using either native emoji or colon-style markup. For example, typing `:strawberry:` will render the emoji ![:strawberry:](https://github.githubassets.com/images/icons/emoji/unicode/1f353.png ":strawberry:"). For a full list of available emoji and codes, see "[Emoji cheat sheet](https://github.com/ikatyang/emoji-cheat-sheet)."
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
    string sha?;
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
    string name;
};

public type OrgHooksBody record {
    # Must be passed as "web"
    string name;
    # Determines if notifications are sent when the webhook is triggered. Set to `true` to send notifications
    boolean active = true;
    OrgsorghooksConfig config;
    # Determines what [events](https://docs.github.com/webhooks/event-payloads) the hook is triggered for. Set to `["*"]` to receive all possible events
    string[] events = ["push"];
};

public type PullNumberCommentsBody record {
    # The relative path to the file that necessitates a comment
    string path;
    # In a split diff view, the side of the diff that the pull request's changes appear on. Can be `LEFT` or `RIGHT`. Use `LEFT` for deletions that appear in red. Use `RIGHT` for additions that appear in green or unchanged lines that appear in white and are shown for context. For a multi-line comment, side represents whether the last line of the comment range is a deletion or addition. For more information, see "[Diff view options](https://docs.github.com/articles/about-comparing-branches-in-pull-requests#diff-view-options)" in the GitHub Help documentation
    "LEFT"|"RIGHT" side?;
    # The level at which the comment is targeted
    @jsondata:Name {value: "subject_type"}
    "line"|"file" subjectType?;
    # **Required unless using `subject_type:file`**. The line of the blob in the pull request diff that the comment applies to. For a multi-line comment, the last line of the range that your comment applies to
    int line?;
    # **Required when using multi-line comments unless using `in_reply_to`**. The `start_line` is the first line in the pull request diff that your multi-line comment applies to. To learn more about multi-line comments, see "[Commenting on a pull request](https://docs.github.com/articles/commenting-on-a-pull-request#adding-line-comments-to-a-pull-request)" in the GitHub Help documentation
    @jsondata:Name {value: "start_line"}
    int startLine?;
    # **This parameter is deprecated. Use `line` instead**. The position in the diff where you want to add a review comment. Note this value is not the same as the line number in the file. For help finding the position value, read the note above
    # 
    # # Deprecated
    @deprecated
    int position?;
    # The text of the review comment
    string body;
    # The SHA of the commit needing a comment. Not using the latest commit SHA may render your comment outdated if a subsequent commit modifies the line you specify as the `position`
    @jsondata:Name {value: "commit_id"}
    string commitId;
    # **Required when using multi-line comments unless using `in_reply_to`**. The `start_side` is the starting side of the diff that the comment applies to. Can be `LEFT` or `RIGHT`. To learn more about multi-line comments, see "[Commenting on a pull request](https://docs.github.com/articles/commenting-on-a-pull-request#adding-line-comments-to-a-pull-request)" in the GitHub Help documentation. See `side` in this table for additional context
    @jsondata:Name {value: "start_side"}
    "LEFT"|"RIGHT"|"side" startSide?;
    # The ID of the review comment to reply to. To find the ID of a review comment with ["List review comments on a pull request"](#list-review-comments-on-a-pull-request). When specified, all parameters other than `body` in the request body are ignored
    @jsondata:Name {value: "in_reply_to"}
    int inReplyTo?;
};

# Issue Event Rename
public type IssueEventRename record {
    string 'from;
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
    string reason?;
    string? signature?;
    string? payload?;
    boolean verified?;
};

public type ReposownerrepocheckSuitespreferencesAutoTriggerChecks record {
    # The `id` of the GitHub App
    @jsondata:Name {value: "app_id"}
    int appId;
    # Set to `true` to enable automatic creation of CheckSuite events upon pushes to the repository, or `false` to disable them
    boolean setting = true;
};

# Repository invitations let you manage who you collaborate with
public type RepositoryInvitation record {
    # Whether or not the invitation has expired
    boolean expired?;
    # The permission associated with the invitation
    "read"|"write"|"admin"|"triage"|"maintain" permissions;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    NullableSimpleUser? inviter;
    # Unique identifier of the repository invitation
    int id;
    MinimalRepository repository;
    # URL for the repository invitation
    string url;
    NullableSimpleUser? invitee;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Issue Event Project Card
public type IssueEventProjectCard record {
    @jsondata:Name {value: "project_id"}
    int projectId;
    @jsondata:Name {value: "column_name"}
    string columnName;
    @jsondata:Name {value: "project_url"}
    string projectUrl;
    int id;
    @jsondata:Name {value: "previous_column_name"}
    string previousColumnName?;
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
    # Sorts the results of your query by `author-date` or `committer-date`. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    "author-date"|"committer-date" sort?;
    # Page number of the results to fetch
    int page = 1;
    # Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`
    "desc"|"asc" 'order = "desc";
};

# Request to install an integration on a target
public type IntegrationInstallationRequest record {
    SimpleUser requester;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Unique identifier of the request installation
    int id;
    SimpleUser|Enterprise account;
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

public type RepoCodespacesBody record {
    # The geographic area for this codespace. If not specified, the value is assigned by IP. This property replaces `location`, which is being deprecated
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
    string[] tags;
};

# Demilestoned Issue Event
public type DemilestonedIssueEvent record {
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    MilestonedIssueEventMilestone milestone;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Commit Search Result Item
public type CommitSearchResultItemResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
    @jsondata:Name {value: "incomplete_results"}
    boolean incompleteResults;
    CommitSearchResultItem[] items;
};

public type ReposownerrepoenvironmentsenvironmentNameReviewers record {
    # The id of the user or team who can review the deployment
    int id?;
    DeploymentReviewerType 'type?;
};

# Represents the Queries record for the operation: packages/list-packages-for-organization
public type PackagesListPackagesForOrganizationQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The selected visibility of the packages.  This parameter is optional and only filters an existing result set.
    # 
    # The `internal` visibility is only supported for GitHub Packages registries that allow for granular permissions. For other ecosystems `internal` is synonymous with `private`.
    # For the list of GitHub Packages registries that support granular permissions, see "[About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages#granular-permissions-for-userorganization-scoped-packages)."
    "public"|"private"|"internal" visibility?;
    # Page number of the results to fetch
    int page = 1;
    # The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    @http:Query {name: "package_type"}
    "npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType;
};

public type CodeScanningSarifsReceipt record {
    CodeScanningAnalysisSarifId id?;
    # The REST API URL for checking the status of the upload
    string url?;
};

# The time that the alert was no longer detected and was considered fixed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`
public type AlertFixedAt string?;

public type UseremailsuseremailsOneOf12 string[];

# Branch Restriction Policy
public type BranchRestrictionPolicy record {
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    BranchRestrictionPolicyTeams[] teams;
    @jsondata:Name {value: "users_url"}
    string usersUrl;
    string url;
    @jsondata:Name {value: "apps_url"}
    string appsUrl;
    RepositoryTemplateRepositoryOwner[] users;
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
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    string name;
    @jsondata:Name {value: "spdx_id"}
    string? spdxId;
    string 'key;
    string? url;
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
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    @jsondata:Name {value: "two_factor_authentication"}
    boolean twoFactorAuthentication;
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    @jsondata:Name {value: "twitter_username"}
    string? twitterUsername?;
    string? bio;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    string login;
    string 'type;
    string? blog;
    @jsondata:Name {value: "private_gists"}
    int privateGists;
    @jsondata:Name {value: "total_private_repos"}
    int totalPrivateRepos;
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    @jsondata:Name {value: "disk_usage"}
    int diskUsage;
    int collaborators;
    string? company;
    @jsondata:Name {value: "owned_private_repos"}
    int ownedPrivateRepos;
    int id;
    @jsondata:Name {value: "public_repos"}
    int publicRepos;
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    PublicUserPlan plan?;
    string? email;
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
    boolean? hireable;
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    @jsondata:Name {value: "public_gists"}
    int publicGists;
    string url;
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    @jsondata:Name {value: "ldap_dn"}
    string ldapDn?;
    int followers;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "business_plus"}
    boolean businessPlus?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    int following;
    string? name;
    string? location;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    @jsondata:Name {value: "suspended_at"}
    string? suspendedAt?;
};

public type ReposownerrepobranchesbranchprotectionrestrictionsappsOneOf11 record {
    # The GitHub Apps that have push access to this branch. Use the slugified version of the app name. **Note**: The list of users, apps, and teams in total is limited to 100 items
    string[] apps;
};

# The time that the analysis was created in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`
public type CodeScanningAnalysisCreatedAt string;

public type ReposownerrepobranchesbranchprotectionrestrictionsappsOneOf12 record {
    # The GitHub Apps that have push access to this branch. Use the slugified version of the app name. **Note**: The list of users, apps, and teams in total is limited to 100 items
    string[] apps;
};

# Thread
public type NotificationThread record {
    string reason;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    boolean unread;
    NotificationThreadSubject subject;
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    string id;
    MinimalRepository repository;
    @jsondata:Name {value: "last_read_at"}
    string? lastReadAt;
    string url;
};

public type HovercardContexts record {
    string message;
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
    SimpleClassroomAssignment assignment;
    # Most recent grade
    string grade;
    SimpleClassroomUser[] students;
    # Unique identifier of the repository
    int id;
    # Whether a submission passed
    boolean passing;
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

# Use the `status` property to enable or disable secret scanning for this repository. For more information, see "[About secret scanning](/code-security/secret-security/about-secret-scanning)."
public type ReposownerrepoSecurityAndAnalysisSecretScanning record {
    # Can be `enabled` or `disabled`
    string status?;
};

# Pull Request Simple
public type PullRequestSimple record {
    @jsondata:Name {value: "issue_url"}
    string issueUrl;
    @jsondata:Name {value: "_links"}
    PullRequestSimpleLinks links;
    @jsondata:Name {value: "diff_url"}
    string diffUrl;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    SimpleUser[]? assignees?;
    @jsondata:Name {value: "requested_reviewers"}
    SimpleUser[]? requestedReviewers?;
    string title;
    string? body;
    @jsondata:Name {value: "requested_teams"}
    Team[]? requestedTeams?;
    PullRequestSimpleHead head;
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    int number;
    @jsondata:Name {value: "patch_url"}
    string patchUrl;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Indicates whether or not the pull request is a draft
    boolean draft?;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    @jsondata:Name {value: "merge_commit_sha"}
    string? mergeCommitSha;
    @jsondata:Name {value: "review_comment_url"}
    string reviewCommentUrl;
    @jsondata:Name {value: "active_lock_reason"}
    string? activeLockReason?;
    int id;
    string state;
    boolean locked;
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    @jsondata:Name {value: "closed_at"}
    string? closedAt;
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    @jsondata:Name {value: "merged_at"}
    string? mergedAt;
    @jsondata:Name {value: "auto_merge"}
    AutoMerge? autoMerge;
    string url;
    PullRequestSimpleLabels[] labels;
    NullableMilestone? milestone;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "review_comments_url"}
    string reviewCommentsUrl;
    NullableSimpleUser? assignee;
    NullableSimpleUser? user;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    PullRequestSimpleHead base;
};

# An optional comment when closing an alert. Cannot be updated or deleted. Must be `null` when changing `state` to `open`
public type SecretScanningAlertResolutionComment string?;

public type WorkflowRunUsageBillableUBUNTU record {
    @jsondata:Name {value: "job_runs"}
    WorkflowRunUsageBillableUBUNTUJobRuns[] jobRuns?;
    @jsondata:Name {value: "total_ms"}
    int totalMs;
    int jobs;
};

public type PullRequestMinimalHead record {
    string ref;
    PullRequestMinimalHeadRepo repo;
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
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    int id?;
    string title?;
    # The Base64 encoded public key
    string 'key;
    string url?;
};

public type PendingDeploymentReviewers record {
    SimpleUser|Team reviewer?;
    DeploymentReviewerType 'type?;
};

# Represents the Queries record for the operation: search/issues-and-pull-requests
public type SearchIssuesAndPullRequestsQueries record {
    # The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching issues and pull requests](https://docs.github.com/search-github/searching-on-github/searching-issues-and-pull-requests)" for a detailed list of qualifiers
    string q;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Sorts the results of your query by the number of `comments`, `reactions`, `reactions-+1`, `reactions--1`, `reactions-smile`, `reactions-thinking_face`, `reactions-heart`, `reactions-tada`, or `interactions`. You can also sort results by how recently the items were `created` or `updated`, Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    "comments"|"reactions"|"reactions-+1"|"reactions--1"|"reactions-smile"|"reactions-thinking_face"|"reactions-heart"|"reactions-tada"|"interactions"|"created"|"updated" sort?;
    # Page number of the results to fetch
    int page = 1;
    # Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`
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
    # To return the oldest accounts first, set to `asc`. Ignored without the `sort` parameter
    "asc"|"desc" direction?;
};

public type CommentIdReactionsBody2 record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the pull request review comment
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

# Permissions requested, categorized by type of permission
public type OrganizationProgrammaticAccessGrantRequestPermissions record {
    record {|string...;|} other?;
    record {|string...;|} organization?;
    record {|string...;|} repository?;
};

public type BranchRestrictionPolicyApps record {
    BranchRestrictionPolicyOwner owner?;
    @jsondata:Name {value: "external_url"}
    string externalUrl?;
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    BranchRestrictionPolicyPermissions permissions?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    string name?;
    string description?;
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    int id?;
    string slug?;
    string[] events?;
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
    # Input keys and values configured in the workflow file. The maximum number of properties is 10. Any default properties configured in the workflow file will be used when `inputs` are omitted
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
    NullableSimpleCommitCommitter? committer;
    # SHA for the commit's tree
    @jsondata:Name {value: "tree_id"}
    string treeId;
    NullableSimpleCommitAuthor? author;
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
    # The full Git reference for narrowing down the cache. The `ref` for a branch should be formatted as `refs/heads/<branch name>`. To reference a pull request use `refs/pull/<number>/merge`
    string ref?;
    # A key for identifying the cache
    string 'key;
};

# Sets the state of the code scanning alert. You must provide `dismissed_reason` when you set the state to `dismissed`
public type CodeScanningAlertSetState "open"|"dismissed";

public type CodeScanningAnalysis record {
    boolean deletable;
    @jsondata:Name {value: "created_at"}
    CodeScanningAnalysisCreatedAt createdAt;
    # The total number of rules used in the analysis
    @jsondata:Name {value: "rules_count"}
    int rulesCount;
    @jsondata:Name {value: "analysis_key"}
    CodeScanningAnalysisAnalysisKey analysisKey;
    string 'error;
    CodeScanningAnalysisUrl url;
    CodeScanningAnalysisTool tool;
    CodeScanningRef ref;
    @jsondata:Name {value: "commit_sha"}
    CodeScanningAnalysisCommitSha commitSha;
    CodeScanningAnalysisEnvironment environment;
    # The total number of results in the analysis
    @jsondata:Name {value: "results_count"}
    int resultsCount;
    # Warning generated when processing the analysis
    string warning;
    @jsondata:Name {value: "sarif_id"}
    CodeScanningAnalysisSarifId sarifId;
    # Unique identifier for this analysis
    int id;
    CodeScanningAnalysisCategory category?;
};

public type RepositoryTemplateRepositoryOwner record {
    @jsondata:Name {value: "gists_url"}
    string gistsUrl?;
    @jsondata:Name {value: "repos_url"}
    string reposUrl?;
    @jsondata:Name {value: "following_url"}
    string followingUrl?;
    @jsondata:Name {value: "starred_url"}
    string starredUrl?;
    string login?;
    @jsondata:Name {value: "followers_url"}
    string followersUrl?;
    string 'type?;
    string url?;
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl?;
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl?;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl?;
    @jsondata:Name {value: "events_url"}
    string eventsUrl?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin?;
    int id?;
    @jsondata:Name {value: "gravatar_id"}
    string gravatarId?;
    @jsondata:Name {value: "node_id"}
    string nodeId?;
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
    # Set to `open` or `resolved` to only list secret scanning alerts in a specific state
    "open"|"resolved" state?;
    # The property to sort the results by. `created` means when the alert was created. `updated` means when the alert was updated or resolved
    "created"|"updated" sort = "created";
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor
    string after?;
    # A comma-separated list of resolutions. Only secret scanning alerts with one of these resolutions are listed. Valid resolutions are `false_positive`, `wont_fix`, `revoked`, `pattern_edited`, `pattern_deleted` or `used_in_tests`
    string resolution?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# A codespace
public type CodespaceResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
    Codespace[] codespaces;
};

# Secrets for GitHub Dependabot for an organization
public type OrganizationDependabotSecret record {
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Visibility of a secret
    "all"|"private"|"selected" visibility;
    # The name of the secret
    string name;
    @jsondata:Name {value: "selected_repositories_url"}
    string selectedRepositoriesUrl?;
    @jsondata:Name {value: "created_at"}
    string createdAt;
};

# An object with information about the individual creating the tag
public type ReposownerrepogittagsTagger record {
    # When this object was tagged. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string date?;
    # The name of the author of the tag
    string name;
    # The email of the author of the tag
    string email;
};

public type JobSteps record {
    # The outcome of the job
    string? conclusion;
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
    string reason;
    string? payload;
    string? signature;
    boolean verified;
};

# Restrict who can push to the protected branch. User, app, and team `restrictions` are only available for organization-owned repositories. Set to `null` to disable
public type ReposownerrepobranchesbranchprotectionRestrictions record {
    # The list of team `slug`s with push access
    string[] teams;
    # The list of user `login`s with push access
    string[] users;
    # The list of app `slug`s with push access
    string[] apps?;
};

# Review Request Removed Issue Event
public type ReviewRequestRemovedIssueEvent record {
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "requested_team"}
    Team requestedTeam?;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    @jsondata:Name {value: "review_requester"}
    SimpleUser reviewRequester;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    @jsondata:Name {value: "requested_reviewer"}
    SimpleUser requestedReviewer?;
    int id;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# An artifact
public type Artifact record {
    @jsondata:Name {value: "archive_download_url"}
    string archiveDownloadUrl;
    # Whether or not the artifact has expired
    boolean expired;
    @jsondata:Name {value: "expires_at"}
    string? expiresAt;
    @jsondata:Name {value: "workflow_run"}
    ArtifactWorkflowRun? workflowRun?;
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    # The name of the artifact
    string name;
    # The size in bytes of the artifact
    @jsondata:Name {value: "size_in_bytes"}
    int sizeInBytes;
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    int id;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type AffectsOneOf1 string;

# Authentication token for a GitHub App installed on a user or org
public type InstallationToken record {
    @jsondata:Name {value: "repository_selection"}
    "all"|"selected" repositorySelection?;
    @jsondata:Name {value: "single_file"}
    string singleFile?;
    @jsondata:Name {value: "expires_at"}
    string expiresAt;
    Repository[] repositories?;
    AppPermissions permissions?;
    @jsondata:Name {value: "has_multiple_single_files"}
    boolean hasMultipleSingleFiles?;
    @jsondata:Name {value: "single_file_paths"}
    string[] singleFilePaths?;
    string token;
};

# The API URL to use to get or set the actions and reusable workflows that are allowed to run, when `allowed_actions` is set to `selected`
public type SelectedActionsUrl string;

public type RepositoryRulesetConditionsRepositoryIdTargetRepositoryId record {
    # The repository IDs that the ruleset applies to. One of these IDs must match for the condition to pass
    @jsondata:Name {value: "repository_ids"}
    int[] repositoryIds?;
};

# Describe a region within a file for the alert
public type CodeScanningAlertLocation record {
    string path?;
    @jsondata:Name {value: "start_column"}
    int startColumn?;
    @jsondata:Name {value: "start_line"}
    int startLine?;
    @jsondata:Name {value: "end_line"}
    int endLine?;
    @jsondata:Name {value: "end_column"}
    int endColumn?;
};

public type CodeScanningSarifsBody record {
    # The name of the tool used to generate the code scanning analysis. If this parameter is not used, the tool name defaults to "API". If the uploaded SARIF contains a tool GUID, this will be available for filtering using the `tool_guid` parameter of operations such as `GET /repos/{owner}/{repo}/code-scanning/alerts`
    @jsondata:Name {value: "tool_name"}
    string toolName?;
    @jsondata:Name {value: "commit_sha"}
    CodeScanningAnalysisCommitSha commitSha;
    CodeScanningRef ref;
    CodeScanningAnalysisSarifFile sarif;
    # The base directory used in the analysis, as it appears in the SARIF file.
    # This property is used to convert file paths from absolute to relative, so that alerts can be mapped to their correct location in the repository
    @jsondata:Name {value: "checkout_uri"}
    string checkoutUri?;
    # The time that the analysis run began. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
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
    # Name for the target deployment environment, which can be changed when setting a deploy status. For example, `production`, `staging`, or `qa`. If not defined, the environment of the previous status on the deployment will be used, if it exists. Otherwise, the environment of the deployment will be used
    string environment?;
    # Sets the URL for accessing your environment. Default: `""`
    @jsondata:Name {value: "environment_url"}
    string environmentUrl = "";
    # The target URL to associate with this status. This URL should contain output to keep the user updated while the task is running or serve as historical information for what happened in the deployment. **Note:** It's recommended to use the `log_url` parameter, which replaces `target_url`
    @jsondata:Name {value: "target_url"}
    string targetUrl = "";
    # The full URL of the deployment's output. This parameter replaces `target_url`. We will continue to accept `target_url` to support legacy uses, but we recommend replacing `target_url` with `log_url`. Setting `log_url` will automatically set `target_url` to the same value. Default: `""`
    @jsondata:Name {value: "log_url"}
    string logUrl = "";
    # Adds a new `inactive` status to all prior non-transient, non-production environment deployments with the same repository and `environment` name as the created status's deployment. An `inactive` status is only added to deployments that had a `success` state. Default: `true`
    @jsondata:Name {value: "auto_inactive"}
    boolean autoInactive?;
    # A short description of the status. The maximum description length is 140 characters
    string description = "";
    # The state of the status. When you set a transient deployment to `inactive`, the deployment will be shown as `destroyed` in GitHub
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

# Identifies the variable values associated with the environment in which the analysis that generated this alert instance was performed, such as the language that was analyzed
public type CodeScanningAlertEnvironment string;

public type OrgPersonalAccessTokensBody record {
    # The IDs of the fine-grained personal access tokens
    @jsondata:Name {value: "pat_ids"}
    int[] patIds;
    # Action to apply to the fine-grained personal access token
    "revoke" action;
};

public type FullRepositoryPermissions record {
    boolean pull;
    boolean maintain?;
    boolean admin;
    boolean triage?;
    boolean push;
};

public type HookResponse record {
    int? code;
    string? message;
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
    # If `true`, show notifications marked as read
    boolean all = false;
    # The number of results per page (max 50)
    @http:Query {name: "per_page"}
    int perPage = 50;
    # Only show notifications updated before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string before?;
    # If `true`, only shows notifications in which the user is directly participating or mentioned
    boolean participating = false;
    # Page number of the results to fetch
    int page = 1;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
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
    string url;
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
    string url;
    @jsondata:Name {value: "check_run_url"}
    string checkRunUrl;
    # Labels for the workflow job. Specified by the "runs_on" attribute in the action's workflow file
    string[] labels;
    # The outcome of the job
    "success"|"failure"|"neutral"|"cancelled"|"skipped"|"timed_out"|"action_required"? conclusion;
    # The time that the job finished, in ISO 8601 format
    @jsondata:Name {value: "completed_at"}
    string? completedAt;
    @jsondata:Name {value: "run_url"}
    string runUrl;
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
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The phase of the lifecycle that the job is currently in
    "queued"|"in_progress"|"completed" status;
};

# Branch Protection
public type BranchProtection record {
    @jsondata:Name {value: "required_pull_request_reviews"}
    ProtectedBranchPullRequestReview requiredPullRequestReviews?;
    @jsondata:Name {value: "required_signatures"}
    BranchProtectionRequiredSignatures requiredSignatures?;
    @jsondata:Name {value: "required_status_checks"}
    ProtectedBranchRequiredStatusCheck requiredStatusChecks?;
    @jsondata:Name {value: "allow_fork_syncing"}
    BranchProtectionAllowForkSyncing allowForkSyncing?;
    BranchRestrictionPolicy restrictions?;
    @jsondata:Name {value: "required_linear_history"}
    BranchProtectionRequiredLinearHistory requiredLinearHistory?;
    @jsondata:Name {value: "enforce_admins"}
    ProtectedBranchAdminEnforced enforceAdmins?;
    string url?;
    boolean enabled?;
    @jsondata:Name {value: "allow_force_pushes"}
    BranchProtectionRequiredLinearHistory allowForcePushes?;
    @jsondata:Name {value: "lock_branch"}
    BranchProtectionLockBranch lockBranch?;
    @jsondata:Name {value: "block_creations"}
    BranchProtectionRequiredLinearHistory blockCreations?;
    @jsondata:Name {value: "required_conversation_resolution"}
    BranchProtectionRequiredLinearHistory requiredConversationResolution?;
    string name?;
    @jsondata:Name {value: "allow_deletions"}
    BranchProtectionRequiredLinearHistory allowDeletions?;
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
    string filename?;
    int size?;
    boolean truncated?;
    string language?;
    string 'type?;
    @jsondata:Name {value: "raw_url"}
    string rawUrl?;
    string content?;
};

public type GitCommitTree record {
    # SHA for the commit
    string sha;
    string url;
};

# The person that committed the file. Default: the authenticated user
public type ReposownerrepocontentspathCommitter record {
    string date?;
    # The name of the author or committer of the commit. You'll receive a `422` status code if `name` is omitted
    string name;
    # The email of the author or committer of the commit. You'll receive a `422` status code if `email` is omitted
    string email;
};

# Commit Activity
public type CommitActivity record {
    int total;
    int week;
    int[] days;
};

# Blob
public type Blob record {
    int? size;
    string encoding;
    string sha;
    @jsondata:Name {value: "highlighted_content"}
    string highlightedContent?;
    string content;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Timeline Unassigned Issue Event
public type TimelineUnassignedIssueEvent record {
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    SimpleUser assignee;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type PendingDeploymentEnvironment record {
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The name of the environment
    string name?;
    # The id of the environment
    int id?;
    string url?;
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# Set repository secrets for GitHub Codespaces
public type RepoCodespacesSecret record {
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The name of the secret
    string name;
    @jsondata:Name {value: "created_at"}
    string createdAt;
};

public type RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf1234567 record {
    *RepositoryRulePullRequest;
    *RepositoryRuleRulesetInfo;
};

# Secrets for a GitHub Codespace
public type CodespacesSecretResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
    CodespacesSecret[] secrets;
};

public type ContentspathBody1 record {
    ReposownerrepocontentspathCommitter1 committer?;
    ReposownerrepocontentspathAuthor1 author?;
    # The commit message
    string message;
    # The blob SHA of the file being deleted
    string sha;
    # The branch name. Default: the repository’s default branch
    string branch?;
};

public type RepoHooksBody record {|
    # Use `web` to create a webhook. Default: `web`. This parameter only accepts the value `web`
    string name?;
    # Determines if notifications are sent when the webhook is triggered. Set to `true` to send notifications
    boolean active = true;
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
    @jsondata:Name {value: "available_custom_deployment_protection_rule_integrations"}
    CustomDeploymentRuleApp[] availableCustomDeploymentProtectionRuleIntegrations?;
    # The total number of custom deployment protection rule integrations available for this environment
    @jsondata:Name {value: "total_count"}
    int totalCount?;
};

public type RestrictionsUsersBody2 ReposownerrepobranchesbranchprotectionrestrictionsusersOneOf12|ReposownerrepobranchesbranchprotectionrestrictionsusersreposownerrepobranchesbranchprotectionrestrictionsusersOneOf122;

public type RestrictionsUsersBody1 ReposownerrepobranchesbranchprotectionrestrictionsusersOneOf11|ReposownerrepobranchesbranchprotectionrestrictionsusersreposownerrepobranchesbranchprotectionrestrictionsusersOneOf112;

# The set of permissions for the GitHub app
public type IntegrationPermissions record {|
    string issues?;
    string checks?;
    string metadata?;
    string contents?;
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
    # Either `asc` or `desc`. Ignored without the `sort` parameter
    "asc"|"desc" direction?;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string since?;
};

public type RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf12345678910 record {
    *RepositoryRuleCommitMessagePattern;
    *RepositoryRuleRulesetInfo;
};

# The public key used for setting Actions Secrets
public type ActionsPublicKey record {
    # The identifier for the key
    @jsondata:Name {value: "key_id"}
    string keyId;
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    int id?;
    string title?;
    # The Base64 encoded public key
    string 'key;
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
    @jsondata:Name {value: "organization_url"}
    string organizationUrl;
    # The user's membership type in the organization
    "admin"|"member"|"billing_manager" role;
    OrgMembershipPermissions permissions?;
    OrganizationSimple organization;
    # The state of the member in the organization. The `pending` state indicates the user has not yet accepted an invitation
    "active"|"pending" state;
    NullableSimpleUser? user;
    string url;
};

public type OrgsorgBody1 record {
    # The state that the membership should be in. Only `"active"` will be accepted
    "active" state;
};

public type TeamSlugDiscussionsBody record {
    # Private posts are only visible to team members, organization owners, and team maintainers. Public posts are visible to all members of the organization. Set to `true` to create a private post
    boolean 'private = false;
    # The discussion post's title
    string title;
    # The discussion post's body text
    string body;
};

# Workflow Run Usage
public type WorkflowRunUsage record {
    @jsondata:Name {value: "run_duration_ms"}
    int runDurationMs?;
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
    string? license;
    string ecosystem;
    @jsondata:Name {value: "package_url"}
    string? packageUrl;
    string manifest;
    # Where the dependency is utilized. `development` means that the dependency is only utilized in the development environment. `runtime` means that the dependency is utilized at runtime and in the development environment
    "unknown"|"runtime"|"development" scope;
    string name;
    DependencyGraphDiffInner_vulnerabilities[] vulnerabilities;
    @jsondata:Name {value: "change_type"}
    "added"|"removed" changeType;
    @jsondata:Name {value: "source_repository_url"}
    string? sourceRepositoryUrl;
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
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    # The name of the tag
    @jsondata:Name {value: "tag_name"}
    string tagName;
    SimpleUser author;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    @jsondata:Name {value: "mentions_count"}
    int mentionsCount?;
    string? body?;
    string url;
    @jsondata:Name {value: "assets_url"}
    string assetsUrl;
    ReleaseAsset[] assets;
    # Whether to identify the release as a prerelease or a full release
    boolean prerelease;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "zipball_url"}
    string? zipballUrl;
    # Specifies the commitish value that determines where the Git tag is created from
    @jsondata:Name {value: "target_commitish"}
    string targetCommitish;
    # true to create a draft (unpublished) release, false to create a published one
    boolean draft;
    string? name;
    @jsondata:Name {value: "upload_url"}
    string uploadUrl;
    ReactionRollup reactions?;
    int id;
    @jsondata:Name {value: "tarball_url"}
    string? tarballUrl;
    @jsondata:Name {value: "published_at"}
    string? publishedAt;
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
    boolean truncated;
    string sha;
    string url;
};

public type ProjectscolumnscolumnIdcardsOneOf1 record {
    # The project card's note
    string? note;
};

public type StatusesshaBody record {
    # The target URL to associate with this status. This URL will be linked from the GitHub UI to allow users to easily see the source of the status.  
    # For example, if your continuous integration system is posting build status, you would want to provide the deep link for the build output for this specific SHA:  
    # `http://ci.example.com/user/repo/build/sha`
    @jsondata:Name {value: "target_url"}
    string? targetUrl?;
    # A string label to differentiate this status from the status of other systems. This field is case-insensitive
    string context = "default";
    # A short description of the status
    string? description?;
    # The state of the status
    "error"|"failure"|"pending"|"success" state;
};

public type RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf123456 record {
    *RepositoryRuleRequiredSignatures;
    *RepositoryRuleRulesetInfo;
};

public type FileCommitCommitAuthor record {
    string date?;
    string name?;
    string email?;
};

# The enforcement level of the ruleset. `evaluate` allows admins to test rules before enforcing them. Admins can view insights on the Rule Insights page (`evaluate` is only available with GitHub Enterprise)
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

# An autolink reference
public type Autolink record {
    # The prefix of a key that is linkified
    @jsondata:Name {value: "key_prefix"}
    string keyPrefix;
    # A template for the target URL that is generated if a key was found
    @jsondata:Name {value: "url_template"}
    string urlTemplate;
    int id;
    # Whether this autolink reference matches alphanumeric characters. If false, this autolink reference only matches numeric characters
    @jsondata:Name {value: "is_alphanumeric"}
    boolean isAlphanumeric;
};

# Issue Event Label
public type IssueEventLabel record {
    string? color;
    string? name;
};

public type GitTreesBody record {
    # The SHA1 of an existing Git tree object which will be used as the base for the new tree. If provided, a new Git tree object will be created from entries in the Git tree object pointed to by `base_tree` and entries defined in the `tree` parameter. Entries defined in the `tree` parameter will overwrite items from `base_tree` with the same `path`. If you're creating new changes on a branch, then normally you'd set `base_tree` to the SHA1 of the Git tree object of the current latest commit on the branch you're working on.
    # If not provided, GitHub will create a new Git tree object from only the entries defined in the `tree` parameter. If you create a new commit pointing to such a tree, then all files which were a part of the parent commit's tree and were not defined in the `tree` parameter will be listed as deleted by the new commit
    @jsondata:Name {value: "base_tree"}
    string baseTree?;
    # Objects (of `path`, `mode`, `type`, and `sha`) specifying a tree structure
    ReposownerrepogittreesTree[] tree;
};

public type CodeScanningAnalysisTool record {
    CodeScanningAnalysisToolName name?;
    CodeScanningAnalysisToolGuid? guid?;
    CodeScanningAnalysisToolVersion? version?;
};

# A check performed on the code of a given code change
public type CheckRun record {
    NullableIntegration? app;
    @jsondata:Name {value: "external_id"}
    string? externalId;
    @jsondata:Name {value: "details_url"}
    string? detailsUrl;
    # The SHA of the commit that is being checked
    @jsondata:Name {value: "head_sha"}
    string headSha;
    string url;
    "success"|"failure"|"neutral"|"cancelled"|"skipped"|"timed_out"|"action_required"? conclusion;
    CheckRunOutput output;
    @jsondata:Name {value: "completed_at"}
    string? completedAt;
    # Pull requests that are open with a `head_sha` or `head_branch` that matches the check. The returned pull requests do not necessarily indicate pull requests that triggered the check
    @jsondata:Name {value: "pull_requests"}
    PullRequestMinimal[] pullRequests;
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    # The name of the check
    string name;
    @jsondata:Name {value: "started_at"}
    string? startedAt;
    # The id of the check
    int id;
    @jsondata:Name {value: "check_suite"}
    CheckRunCheckSuite? checkSuite;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The phase of the lifecycle that the check is currently in
    "queued"|"in_progress"|"completed" status;
    DeploymentSimple deployment?;
};

# Porter Large File
public type PorterLargeFile record {
    @jsondata:Name {value: "ref_name"}
    string refName;
    string path;
    int size;
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
    @jsondata:Name {value: "instances_url"}
    AlertInstancesUrl instancesUrl;
    @jsondata:Name {value: "created_at"}
    AlertCreatedAt createdAt;
    @jsondata:Name {value: "dismissed_comment"}
    CodeScanningAlertDismissedComment? dismissedComment?;
    CodeScanningAlertRuleSummary rule;
    AlertUrl url;
    CodeScanningAnalysisTool tool;
    AlertNumber number;
    @jsondata:Name {value: "updated_at"}
    AlertUpdatedAt updatedAt?;
    @jsondata:Name {value: "html_url"}
    AlertHtmlUrl htmlUrl;
    @jsondata:Name {value: "fixed_at"}
    AlertFixedAt? fixedAt?;
    @jsondata:Name {value: "most_recent_instance"}
    CodeScanningAlertInstance mostRecentInstance;
    CodeScanningAlertState state;
    @jsondata:Name {value: "dismissed_by"}
    NullableSimpleUser? dismissedBy;
    @jsondata:Name {value: "dismissed_reason"}
    CodeScanningAlertDismissedReason? dismissedReason;
    @jsondata:Name {value: "dismissed_at"}
    AlertDismissedAt? dismissedAt;
};

public type LabelsLabelsOneOf122 record {
    boolean default?;
    string? color?;
    string name?;
    string? description?;
    int id?;
    string url?;
    @jsondata:Name {value: "node_id"}
    string nodeId?;
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
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "cards_url"}
    string cardsUrl;
    # Name of the project column
    string name;
    @jsondata:Name {value: "project_url"}
    string projectUrl;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The unique identifier of the project column
    int id;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type NullableCommunityHealthFile record {
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
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
    # The order to sort by. Default: `asc` when using `full_name`, otherwise `desc`
    "asc"|"desc" direction?;
};

public type ReleasesreleaseIdBody record {
    # If specified, a discussion of the specified category is created and linked to the release. The value must be a category that already exists in the repository. If there is already a discussion linked to the release, this parameter is ignored. For more information, see "[Managing categories for discussions in your repository](https://docs.github.com/discussions/managing-discussions-for-your-community/managing-categories-for-discussions-in-your-repository)."
    @jsondata:Name {value: "discussion_category_name"}
    string discussionCategoryName?;
    # Specifies whether this release should be set as the latest release for the repository. Drafts and prereleases cannot be set as latest. Defaults to `true` for newly published releases. `legacy` specifies that the latest release should be determined based on the release creation date and higher semantic version
    @jsondata:Name {value: "make_latest"}
    "true"|"false"|"legacy" makeLatest = "true";
    # The name of the tag
    @jsondata:Name {value: "tag_name"}
    string tagName?;
    # `true` to identify the release as a prerelease, `false` to identify the release as a full release
    boolean prerelease?;
    # Specifies the commitish value that determines where the Git tag is created from. Can be any branch or commit SHA. Unused if the Git tag already exists. Default: the repository's default branch
    @jsondata:Name {value: "target_commitish"}
    string targetCommitish?;
    # `true` makes the release a draft, and `false` publishes the release
    boolean draft?;
    # The name of the release
    string name?;
    # Text describing the contents of the tag
    string body?;
};

public type PackageVersionMetadata record {
    ContainerMetadata container?;
    @jsondata:Name {value: "package_type"}
    "npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType;
    DockerMetadata docker?;
};

public type RepoReleasesBody record {
    # If specified, a discussion of the specified category is created and linked to the release. The value must be a category that already exists in the repository. For more information, see "[Managing categories for discussions in your repository](https://docs.github.com/discussions/managing-discussions-for-your-community/managing-categories-for-discussions-in-your-repository)."
    @jsondata:Name {value: "discussion_category_name"}
    string discussionCategoryName?;
    # Specifies whether this release should be set as the latest release for the repository. Drafts and prereleases cannot be set as latest. Defaults to `true` for newly published releases. `legacy` specifies that the latest release should be determined based on the release creation date and higher semantic version
    @jsondata:Name {value: "make_latest"}
    "true"|"false"|"legacy" makeLatest = "true";
    # The name of the tag
    @jsondata:Name {value: "tag_name"}
    string tagName;
    # `true` to identify the release as a prerelease. `false` to identify the release as a full release
    boolean prerelease = false;
    # Specifies the commitish value that determines where the Git tag is created from. Can be any branch or commit SHA. Unused if the Git tag already exists. Default: the repository's default branch
    @jsondata:Name {value: "target_commitish"}
    string targetCommitish?;
    # `true` to create a draft (unpublished) release, `false` to create a published one
    boolean draft = false;
    # The name of the release
    string name?;
    # Text describing the contents of the tag
    string body?;
    # Whether to automatically generate the name and body for this release. If `name` is specified, the specified name will be used; otherwise, a name will be automatically generated. If `body` is specified, the body will be pre-pended to the automatically generated notes
    @jsondata:Name {value: "generate_release_notes"}
    boolean generateReleaseNotes = false;
};

public type RepoPagesBody anydata;

public type CodeScanningSarifsStatus record {
    # `pending` files have not yet been processed, while `complete` means results from the SARIF have been stored. `failed` files have either not been processed at all, or could only be partially processed
    @jsondata:Name {value: "processing_status"}
    "pending"|"complete"|"failed" processingStatus?;
    # The REST API URL for getting the analyses associated with the upload
    @jsondata:Name {value: "analyses_url"}
    string? analysesUrl?;
    # Any errors that ocurred during processing of the delivery
    string[]? errors?;
};

public type ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf1123 record {
    @constraint:Array {minLength: 1}
    ReposownerrepoissuesissueNumberlabelsLabels[] labels?;
};

# A Base64 string representing the SARIF file to upload. You must first compress your SARIF file using [`gzip`](http://www.gnu.org/software/gzip/manual/gzip.html) and then translate the contents of the file into a Base64 encoding string. For more information, see "[SARIF support for code scanning](https://docs.github.com/code-security/secure-coding/sarif-support-for-code-scanning)."
public type CodeScanningAnalysisSarifFile string;

public type RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf12345 record {
    *RepositoryRuleRequiredDeployments;
    *RepositoryRuleRulesetInfo;
};

# An actor that can bypass rules in a ruleset
public type RepositoryRulesetBypassActor record {
    # The type of actor that can bypass a ruleset
    @jsondata:Name {value: "actor_type"}
    "RepositoryRole"|"Team"|"Integration"|"OrganizationAdmin" actorType;
    # When the specified actor can bypass the ruleset. `pull_request` means that an actor can only bypass rules on pull requests
    @jsondata:Name {value: "bypass_mode"}
    "always"|"pull_request" bypassMode;
    # The ID of the actor that can bypass a ruleset. If `actor_type` is `OrganizationAdmin`, this should be `1`
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
    # Suggested action to fix the error. This will usually be `null`, but is provided for some common errors
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
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The name of the secret
    string name;
    @jsondata:Name {value: "created_at"}
    string createdAt;
};

# Diff Entry
public type DiffEntry record {
    string patch?;
    string filename;
    int additions;
    int deletions;
    int changes;
    @jsondata:Name {value: "previous_filename"}
    string previousFilename?;
    string sha;
    @jsondata:Name {value: "blob_url"}
    string blobUrl;
    @jsondata:Name {value: "raw_url"}
    string rawUrl;
    "added"|"removed"|"modified"|"renamed"|"copied"|"changed"|"unchanged" status;
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
};

public type LabelsLabelsOneOf132 record {
    boolean default?;
    string? color?;
    string name?;
    string? description?;
    int id?;
    string url?;
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

# Timeline Cross Referenced Event
public type TimelineCrossReferencedEvent record {
    SimpleUser actor?;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    TimelineCrossReferencedEventSource 'source;
    string event;
};

public type CheckSuitesPreferencesBody record {
    # Enables or disables automatic creation of CheckSuite events upon pushes to the repository. Enabled by default
    @jsondata:Name {value: "auto_trigger_checks"}
    ReposownerrepocheckSuitespreferencesAutoTriggerChecks[] autoTriggerChecks?;
};

public type SearchResultTextMatchesInner record {
    string fragment?;
    @jsondata:Name {value: "object_url"}
    string objectUrl?;
    @jsondata:Name {value: "object_type"}
    string? objectType?;
    string property?;
    SearchResultTextMatchesInner_matches[] matches?;
};

# Determines whether the SSL certificate of the host for `url` will be verified when delivering payloads. Supported values include `0` (verification is performed) and `1` (verification is not performed). The default is `0`. **We strongly recommend not setting this to `1` as you are subject to man-in-the-middle and other attacks.**
public type WebhookConfigInsecureSslOneOf1 string;

public type ActionsVariableResponse record {
    ActionsVariable[] variables;
    @jsondata:Name {value: "total_count"}
    int totalCount;
};

# Dev Containers
public type Devcontainers record {
    string path;
    string name?;
    @jsondata:Name {value: "display_name"}
    string displayName?;
};

# Represents the Queries record for the operation: projects/list-collaborators
public type ProjectsListCollaboratorsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Filters the collaborators by their affiliation. `outside` means outside collaborators of a project that are not a member of the project's organization. `direct` means collaborators with permissions to a project, regardless of organization membership status. `all` means all collaborators the authenticated user can see
    "outside"|"direct"|"all" affiliation = "all";
    # Page number of the results to fetch
    int page = 1;
};

# Parameters to be used for the branch_name_pattern rule
public type RepositoryRuleBranchNamePattern record {
    "branch_name_pattern" 'type;
    RepositoryRuleCommitMessagePatternParameters parameters?;
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
    # Set to `open` or `resolved` to only list secret scanning alerts in a specific state
    "open"|"resolved" state?;
    # The property to sort the results by. `created` means when the alert was created. `updated` means when the alert was updated or resolved
    "created"|"updated" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for events after this cursor.  To receive an initial cursor on your first request, include an empty "after" query string
    string after?;
    # A comma-separated list of resolutions. Only secret scanning alerts with one of these resolutions are listed. Valid resolutions are `false_positive`, `wont_fix`, `revoked`, `pattern_edited`, `pattern_deleted` or `used_in_tests`
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
    boolean verified?;
    string email?;
};

public type UseremailsOneOf1 record {
    # Adds one or more email addresses to your GitHub account. Must contain at least one email address. **Note:** Alternatively, you can pass a single email address or an `array` of emails addresses directly, but we recommend that you pass an object using the `emails` key
    string[] emails;
};

# Hypermedia Link
public type Link record {
    string href;
};

public type CodespacesAccessBody record {
    # Which users can access codespaces in the organization. `disabled` means that no users can access codespaces in the organization
    "disabled"|"selected_members"|"all_members"|"all_members_and_outside_collaborators" visibility;
    # The usernames of the organization members who should have access to codespaces in the organization. Required when `visibility` is `selected_members`. The provided list of usernames will replace any existing value
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
    ReposownerrepocontentspathCommitter committer?;
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
    boolean protected;
    string name;
    BranchShortCommit 'commit;
};

# A version of a software package
public type PackageVersion record {
    string license?;
    PackageVersionMetadata metadata?;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The name of the package version
    string name;
    string description?;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Unique identifier of the package version
    int id;
    @jsondata:Name {value: "deleted_at"}
    string deletedAt?;
    string url;
    @jsondata:Name {value: "package_html_url"}
    string packageHtmlUrl;
};

# Repo Search Result Item
public type RepoSearchResultItem record {
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking?;
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount;
    @jsondata:Name {value: "is_template"}
    boolean isTemplate?;
    @jsondata:Name {value: "pushed_at"}
    string pushedAt;
    string? language;
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge?;
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    decimal score;
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    FullRepositoryPermissions permissions?;
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    @jsondata:Name {value: "svn_url"}
    string svnUrl;
    int id;
    @jsondata:Name {value: "master_branch"}
    string masterBranch?;
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions?;
    int forks;
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit?;
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The repository visibility: public, private, or internal
    string visibility?;
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    @jsondata:Name {value: "ssh_url"}
    string sshUrl;
    NullableLicenseSimple? license;
    @jsondata:Name {value: "full_name"}
    string fullName;
    int size;
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge?;
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    @jsondata:Name {value: "clone_url"}
    string cloneUrl;
    string name;
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    @jsondata:Name {value: "default_branch"}
    string defaultBranch;
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    boolean 'private;
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads;
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount;
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    string? description;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int watchers;
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects;
    boolean archived;
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    # Returns whether or not this repository disabled
    boolean disabled;
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge?;
    @jsondata:Name {value: "git_url"}
    string gitUrl;
    @jsondata:Name {value: "has_pages"}
    boolean hasPages;
    NullableSimpleUser? owner;
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge?;
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    string[] topics?;
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues;
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    string url;
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl;
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    boolean 'fork;
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    @jsondata:Name {value: "text_matches"}
    SearchResultTextMatches textMatches?;
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    @jsondata:Name {value: "watchers_count"}
    int watchersCount;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    string? homepage;
    @jsondata:Name {value: "forks_count"}
    int forksCount;
};

public type ActionsOrganizationPermissions record {
    @jsondata:Name {value: "enabled_repositories"}
    EnabledRepositories enabledRepositories;
    @jsondata:Name {value: "allowed_actions"}
    AllowedActions allowedActions?;
    # The API URL to use to get or set the selected repositories that are allowed to run GitHub Actions, when `enabled_repositories` is set to `selected`
    @jsondata:Name {value: "selected_repositories_url"}
    string selectedRepositoriesUrl?;
    @jsondata:Name {value: "selected_actions_url"}
    SelectedActionsUrl selectedActionsUrl?;
};

# Use the `status` property to enable or disable GitHub Advanced Security for this repository. For more information, see "[About GitHub Advanced Security](/github/getting-started-with-github/learning-about-github/about-github-advanced-security)."
public type ReposownerrepoSecurityAndAnalysisAdvancedSecurity record {
    # Can be `enabled` or `disabled`
    string status?;
};

# Represents the Queries record for the operation: codespaces/check-permissions-for-devcontainer
public type CodespacesCheckPermissionsForDevcontainerQueries record {
    # Path to the devcontainer.json configuration to use for the permission check
    @http:Query {name: "devcontainer_path"}
    string devcontainerPath;
    # The git reference that points to the location of the devcontainer configuration to use for the permission check. The value of `ref` will typically be a branch name (`heads/BRANCH_NAME`). For more information, see "[Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)" in the Git documentation
    string ref;
};

public type TimelineReviewedEventLinks record {
    @jsondata:Name {value: "pull_request"}
    TimelineReviewedEventLinksHtml pullRequest;
    TimelineReviewedEventLinksHtml html;
};

# The slug values for teams
public type ReposownerrepobranchesbranchprotectionrestrictionsteamsreposownerrepobranchesbranchprotectionrestrictionsteamsOneOf122 string[];

public type EventRepo record {
    string name;
    int id;
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
    string text?;
};

# Specify which security and analysis features to enable or disable for the repository.
# 
# To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
# 
# For example, to enable GitHub Advanced Security, use this data in the body of the `PATCH` request:
# `{ "security_and_analysis": {"advanced_security": { "status": "enabled" } } }`.
# 
# You can check which security and analysis features are currently enabled by using a `GET /repos/{owner}/{repo}` request
public type ReposownerrepoSecurityAndAnalysis record {
    @jsondata:Name {value: "secret_scanning_push_protection"}
    ReposownerrepoSecurityAndAnalysisSecretScanningPushProtection secretScanningPushProtection?;
    @jsondata:Name {value: "secret_scanning"}
    ReposownerrepoSecurityAndAnalysisSecretScanning secretScanning?;
    @jsondata:Name {value: "advanced_security"}
    ReposownerrepoSecurityAndAnalysisAdvancedSecurity advancedSecurity?;
};

public type LabelsLabelsOneOf112 record {
    string? color?;
    string name?;
    string? description?;
    int id?;
};

public type RepositoryRuleDetailedOneOf1 record {
    *RepositoryRuleCreation;
    *RepositoryRuleRulesetInfo;
};

public type SelectedActions record {
    # Specifies a list of string-matching patterns to allow specific action(s) and reusable workflow(s). Wildcards, tags, and SHAs are allowed. For example, `monalisa/octocat@*`, `monalisa/octocat@v2`, `monalisa/*`.
    # 
    # **Note**: The `patterns_allowed` setting only applies to public repositories
    @jsondata:Name {value: "patterns_allowed"}
    string[] patternsAllowed?;
    # Whether actions from GitHub Marketplace verified creators are allowed. Set to `true` to allow all actions by GitHub Marketplace verified creators
    @jsondata:Name {value: "verified_allowed"}
    boolean verifiedAllowed?;
    # Whether GitHub-owned actions are allowed. For example, this includes the actions in the `actions` organization
    @jsondata:Name {value: "github_owned_allowed"}
    boolean githubOwnedAllowed?;
};

public type ReposownerrepoissuesLabels LabelsOneOf1|LabelsLabelsOneOf12;

public type CardIdMovesBody record {
    # The unique identifier of the column the card should be moved to
    @jsondata:Name {value: "column_id"}
    int columnId?;
    # The position of the card in a column. Can be one of: `top`, `bottom`, or `after:<card_id>` to place after the specified card
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
    string title;
};

# Base Gist
public type BaseGist record {
    SimpleUser owner?;
    anydata[] forks?;
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    int comments;
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    @jsondata:Name {value: "git_push_url"}
    string gitPushUrl;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    string? description;
    boolean truncated?;
    anydata[] history?;
    string url;
    boolean 'public;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "git_pull_url"}
    string gitPullUrl;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    record {|BaseGistFiles...;|} files;
    string id;
    NullableSimpleUser? user;
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
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    SimpleUser[]? assignees?;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    string title;
    string body?;
    Repository repository?;
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    int number;
    decimal score;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    boolean draft?;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    @jsondata:Name {value: "active_lock_reason"}
    string? activeLockReason?;
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    int id;
    string state;
    boolean locked;
    @jsondata:Name {value: "timeline_url"}
    string timelineUrl?;
    @jsondata:Name {value: "state_reason"}
    string? stateReason?;
    @jsondata:Name {value: "pull_request"}
    IssuePullRequest pullRequest?;
    int comments;
    @jsondata:Name {value: "closed_at"}
    string? closedAt;
    string url;
    IssueSearchResultItemLabels[] labels;
    NullableMilestone? milestone;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "text_matches"}
    SearchResultTextMatches textMatches?;
    ReactionRollup reactions?;
    NullableSimpleUser? assignee;
    NullableSimpleUser? user;
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
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    # Whether to allow rebase merges for pull requests
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge = true;
    RepositoryPermissions permissions?;
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    # The default value for a squash merge commit message:
    # 
    # - `PR_BODY` - default to the pull request's body.
    # - `COMMIT_MESSAGES` - default to the branch's commit messages.
    # - `BLANK` - default to a blank commit message
    @jsondata:Name {value: "squash_merge_commit_message"}
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squashMergeCommitMessage?;
    @jsondata:Name {value: "subscribers_count"}
    int subscribersCount?;
    # Unique identifier of the repository
    int id;
    # Whether discussions are enabled
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions = false;
    int forks;
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    @jsondata:Name {value: "ssh_url"}
    string sshUrl;
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0
    int size;
    @jsondata:Name {value: "template_repository"}
    RepositoryTemplateRepository? templateRepository?;
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    @jsondata:Name {value: "clone_url"}
    string cloneUrl;
    # The default branch of the repository
    @jsondata:Name {value: "default_branch"}
    string defaultBranch;
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    # Whether downloads are enabled
    # 
    # # Deprecated
    @jsondata:Name {value: "has_downloads"}
    @deprecated
    boolean hasDownloads = true;
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    int watchers;
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    # Whether the repository is archived
    boolean archived = false;
    # Whether the wiki is enabled
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki = true;
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    # Returns whether or not this repository disabled
    boolean disabled;
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    string[] topics?;
    # Whether or not a pull request head branch that is behind its base branch can always be updated even if it is not required to be up to date before merging
    @jsondata:Name {value: "allow_update_branch"}
    boolean allowUpdateBranch = false;
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    @jsondata:Name {value: "starred_at"}
    string starredAt?;
    string url;
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    # Whether a squash merge commit can use the pull request title as default. **This property has been deprecated. Please use `squash_merge_commit_title` instead
    # 
    # # Deprecated
    @jsondata:Name {value: "use_squash_pr_title_as_default"}
    @deprecated
    boolean useSquashPrTitleAsDefault = false;
    NullableSimpleUser? organization?;
    # The default value for a merge commit message.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `PR_BODY` - default to the pull request's body.
    # - `BLANK` - default to a blank commit message
    @jsondata:Name {value: "merge_commit_message"}
    "PR_BODY"|"PR_TITLE"|"BLANK" mergeCommitMessage?;
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    # The default value for a squash merge commit title:
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `COMMIT_OR_PR_TITLE` - default to the commit's title (if only one commit) or the pull request's title (when more than one commit)
    @jsondata:Name {value: "squash_merge_commit_title"}
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squashMergeCommitTitle?;
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount;
    # Whether this repository acts as a template that can be used to generate new repositories
    @jsondata:Name {value: "is_template"}
    boolean isTemplate = false;
    @jsondata:Name {value: "pushed_at"}
    string? pushedAt;
    string? language;
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    @jsondata:Name {value: "svn_url"}
    string svnUrl;
    @jsondata:Name {value: "master_branch"}
    string masterBranch?;
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    # Whether to allow merge commits for pull requests
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit = true;
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The repository visibility: public, private, or internal
    string visibility = "public";
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    @jsondata:Name {value: "network_count"}
    int networkCount?;
    NullableLicenseSimple? license;
    # Whether to allow Auto-merge to be used on pull requests
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge = false;
    # The name of the repository
    string name;
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    # Whether the repository is private or public
    boolean 'private = false;
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount;
    string? description;
    # Whether projects are enabled
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects = true;
    # The default value for a merge commit title.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `MERGE_MESSAGE` - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name)
    @jsondata:Name {value: "merge_commit_title"}
    "PR_TITLE"|"MERGE_MESSAGE" mergeCommitTitle?;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    # Whether to delete head branches when pull requests are merged
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge = false;
    @jsondata:Name {value: "git_url"}
    string gitUrl;
    @jsondata:Name {value: "has_pages"}
    boolean hasPages;
    SimpleUser owner;
    # Whether to allow squash merges for pull requests
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge = true;
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    # Whether issues are enabled
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues = true;
    # Whether to require contributors to sign off on web-based commits
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired = false;
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl;
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    boolean 'fork;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    @jsondata:Name {value: "watchers_count"}
    int watchersCount;
    string? homepage;
    @jsondata:Name {value: "forks_count"}
    int forksCount;
};

# Minimal Repository
public type MinimalRepository record {
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking?;
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount?;
    @jsondata:Name {value: "is_template"}
    boolean isTemplate?;
    @jsondata:Name {value: "pushed_at"}
    string? pushedAt?;
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    string? language?;
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    RepositoryTemplateRepositoryPermissions permissions?;
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    @jsondata:Name {value: "svn_url"}
    string svnUrl?;
    @jsondata:Name {value: "subscribers_count"}
    int subscribersCount?;
    int id;
    @jsondata:Name {value: "has_discussions"}
    boolean hasDiscussions?;
    int forks?;
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    string visibility?;
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    @jsondata:Name {value: "network_count"}
    int networkCount?;
    @jsondata:Name {value: "ssh_url"}
    string sshUrl?;
    @jsondata:Name {value: "role_name"}
    string roleName?;
    MinimalRepositoryLicense? license?;
    @jsondata:Name {value: "full_name"}
    string fullName;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0
    int size?;
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    @jsondata:Name {value: "clone_url"}
    string cloneUrl?;
    string name;
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    @jsondata:Name {value: "default_branch"}
    string defaultBranch?;
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    boolean 'private;
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads?;
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount?;
    string? description;
    @jsondata:Name {value: "created_at"}
    string? createdAt?;
    int watchers?;
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects?;
    boolean archived?;
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki?;
    @jsondata:Name {value: "updated_at"}
    string? updatedAt?;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    boolean disabled?;
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge?;
    @jsondata:Name {value: "git_url"}
    string gitUrl?;
    @jsondata:Name {value: "has_pages"}
    boolean hasPages?;
    SimpleUser owner;
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    string[] topics?;
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues?;
    @jsondata:Name {value: "code_of_conduct"}
    CodeOfConduct codeOfConduct?;
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    string url;
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl?;
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    @jsondata:Name {value: "security_and_analysis"}
    SecurityAndAnalysis? securityAndAnalysis?;
    boolean 'fork;
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    @jsondata:Name {value: "open_issues"}
    int openIssues?;
    @jsondata:Name {value: "watchers_count"}
    int watchersCount?;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    string? homepage?;
    @jsondata:Name {value: "forks_count"}
    int forksCount?;
};

# Timeline Assigned Issue Event
public type TimelineAssignedIssueEvent record {
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    SimpleUser assignee;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type UserCodespacesBody UsercodespacesOneOf1|UsercodespacesusercodespacesOneOf12;

# Represents the Queries record for the operation: issues/list-for-org
public type IssuesListForOrgQueries record {
    # Indicates which sorts of issues to return. `assigned` means issues assigned to you. `created` means issues created by you. `mentioned` means issues mentioning you. `subscribed` means issues you're subscribed to updates for. `all` or `repos` means all issues you can see, regardless of participation or creation
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
    # A list of comma separated label names. Example: `bug,ui,@high`
    string labels?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string since?;
};

# Starred Repository
public type StarredRepository record {
    Repository repo;
    @jsondata:Name {value: "starred_at"}
    string starredAt;
};

# The slug values for teams
public type ReposownerrepobranchesbranchprotectionrestrictionsteamsreposownerrepobranchesbranchprotectionrestrictionsteamsOneOf112 string[];

# The time that the alert was last updated in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`
public type AlertUpdatedAt string;

public type PullRequestHead record {
    string ref;
    PullRequestHeadRepo? repo;
    string label;
    string sha;
    PullRequestHeadRepoOwner user;
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
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    SimpleUser[]? assignees?;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Title of the issue
    string title;
    # Contents of the issue
    string? body?;
    Repository repository?;
    @jsondata:Name {value: "closed_by"}
    NullableSimpleUser? closedBy?;
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # Number uniquely identifying the issue within its repository
    int number;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    boolean draft?;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    @jsondata:Name {value: "active_lock_reason"}
    string? activeLockReason?;
    int id;
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    # State of the issue; either 'open' or 'closed'
    string state;
    boolean locked;
    @jsondata:Name {value: "timeline_url"}
    string timelineUrl?;
    # The reason for the current state
    @jsondata:Name {value: "state_reason"}
    "completed"|"reopened"|"not_planned"? stateReason?;
    @jsondata:Name {value: "pull_request"}
    IssuePullRequest pullRequest?;
    int comments;
    @jsondata:Name {value: "closed_at"}
    string? closedAt;
    # URL for the issue
    string url;
    # Labels to associate with this issue; pass one or more label names to replace the set of labels on this issue; send an empty array to clear all labels from the issue; note that the labels are silently dropped for users without push access to the repository
    IssueLabels[] labels;
    NullableMilestone? milestone;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    ReactionRollup reactions?;
    NullableSimpleUser? assignee;
    NullableSimpleUser? user;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Minimal representation of an organization programmatic access grant for enumerations
public type OrganizationProgrammaticAccessGrant record {
    SimpleUser owner;
    # Type of repository selection requested
    @jsondata:Name {value: "repository_selection"}
    "none"|"all"|"subset" repositorySelection;
    # URL to the list of repositories the fine-grained personal access token can access. Only follow when `repository_selection` is `subset`
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
    # Date and time when the associated fine-grained personal access token expires
    @jsondata:Name {value: "token_expires_at"}
    string? tokenExpiresAt;
    OrganizationProgrammaticAccessGrantRequestPermissions permissions;
    # Date and time when the associated fine-grained personal access token was last used for authentication
    @jsondata:Name {value: "token_last_used_at"}
    string? tokenLastUsedAt;
    # Unique identifier of the fine-grained personal access token. The `pat_id` used to get details about an approved fine-grained personal access token
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
    string? reason;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
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
    NullableSimpleUser? creator;
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    string? description;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    string sha;
    string url;
    # The ref to deploy. This can be a branch, tag, or sha
    string ref;
    # Name for the target deployment environment
    string environment;
    # Parameter to specify a task to execute
    string task;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    record {}|string payload;
    # Specifies if the given environment is will no longer exist at some point in the future. Default: false
    @jsondata:Name {value: "transient_environment"}
    boolean transientEnvironment?;
    @jsondata:Name {value: "original_environment"}
    string originalEnvironment?;
    # Unique identifier of the deployment
    int id;
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # Specifies if the given environment is one that end-users directly interact with. Default: false
    @jsondata:Name {value: "production_environment"}
    boolean productionEnvironment?;
};

# Whether to set the branch as read-only. If this is true, users will not be able to push to the branch
public type BranchProtectionLockBranch record {
    boolean enabled = false;
};

public type RestrictionsTeamsBody1 ReposownerrepobranchesbranchprotectionrestrictionsteamsOneOf11|ReposownerrepobranchesbranchprotectionrestrictionsteamsreposownerrepobranchesbranchprotectionrestrictionsteamsOneOf112;

public type RestrictionsTeamsBody2 ReposownerrepobranchesbranchprotectionrestrictionsteamsOneOf12|ReposownerrepobranchesbranchprotectionrestrictionsteamsreposownerrepobranchesbranchprotectionrestrictionsteamsOneOf122;

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
    string sha;
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

public type NullableMinimalRepositoryLicense record {
    string name?;
    @jsondata:Name {value: "spdx_id"}
    string spdxId?;
    string 'key?;
    string url?;
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

public type CommitSearchResultItemCommitAuthor record {
    string date;
    string name;
    string email;
};

public type ParticipationStats record {
    int[] all;
    int[] owner;
};

public type ColumnIdMovesBody record {
    # The position of the column in a project. Can be one of: `first`, `last`, or `after:<column_id>` to place after the specified column
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
    string ref;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    GitRefObject 'object;
};

# User Search Result Item
public type UserSearchResultItem record {
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    string? bio?;
    string login;
    string 'type;
    string? blog?;
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    decimal score;
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    string? company?;
    int id;
    @jsondata:Name {value: "public_repos"}
    int publicRepos?;
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    string? email?;
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
    boolean? hireable?;
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    @jsondata:Name {value: "public_gists"}
    int publicGists?;
    string url;
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    int followers?;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    int following?;
    @jsondata:Name {value: "text_matches"}
    SearchResultTextMatches textMatches?;
    string? name?;
    string? location?;
    @jsondata:Name {value: "node_id"}
    string nodeId;
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
    @jsondata:Name {value: "enabled_repositories"}
    EnabledRepositories enabledRepositories;
    @jsondata:Name {value: "allowed_actions"}
    AllowedActions allowedActions?;
};

public type GlobalAdvisoryCredits record {
    SecurityAdvisoryCreditTypes 'type;
    SimpleUser user;
};

# Timeline Reviewed Event
public type TimelineReviewedEvent record {
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    @jsondata:Name {value: "_links"}
    TimelineReviewedEventLinks links;
    @jsondata:Name {value: "submitted_at"}
    string submittedAt?;
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    @jsondata:Name {value: "pull_request_url"}
    string pullRequestUrl;
    # The text of the review
    string? body;
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Unique identifier of the review
    int id;
    string state;
    string event;
    SimpleUser user;
    # A commit SHA for the review
    @jsondata:Name {value: "commit_id"}
    string commitId;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type RepositoryRulesetLinksSelf record {
    # The URL of the ruleset
    string href?;
};

# The time that the alert was created in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`
public type AlertCreatedAt string;

public type BranchRestrictionPolicyOwner record {
    @jsondata:Name {value: "repos_url"}
    string reposUrl?;
    @jsondata:Name {value: "gists_url"}
    string gistsUrl?;
    @jsondata:Name {value: "members_url"}
    string membersUrl?;
    @jsondata:Name {value: "following_url"}
    string followingUrl?;
    string description?;
    @jsondata:Name {value: "starred_url"}
    string starredUrl?;
    string login?;
    @jsondata:Name {value: "followers_url"}
    string followersUrl?;
    string 'type?;
    string url?;
    @jsondata:Name {value: "public_members_url"}
    string publicMembersUrl?;
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl?;
    @jsondata:Name {value: "issues_url"}
    string issuesUrl?;
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl?;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl?;
    @jsondata:Name {value: "events_url"}
    string eventsUrl?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin?;
    int id?;
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl?;
    @jsondata:Name {value: "gravatar_id"}
    string gravatarId?;
    @jsondata:Name {value: "node_id"}
    string nodeId?;
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
    @jsondata:Name {value: "repository_name"}
    RepositoryRulesetConditionsRepositoryNameTargetRepositoryName repositoryName;
};

public type SecretNameRepositoriesBody record {
    # An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the `visibility` is set to `selected`. You can add and remove individual repositories using the [Add selected repository to an organization secret](https://docs.github.com/rest/actions/secrets#add-selected-repository-to-an-organization-secret) and [Remove selected repository from an organization secret](https://docs.github.com/rest/actions/secrets#remove-selected-repository-from-an-organization-secret) endpoints
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds;
};

# Deployment protection rule
public type DeploymentProtectionRuleResponse record {
    # The number of enabled custom deployment protection rules for this environment
    @jsondata:Name {value: "total_count"}
    int totalCount?;
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
    GitCommitAuthor committer;
    GitCommitAuthor author;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    GitCommitTree tree;
    # Message describing the purpose of the commit
    string message;
    # SHA for the commit
    string sha;
    string url;
    GitCommitVerification verification;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    GitCommitParents[] parents;
};

public type SecretssecretNameBody1 record {
    # An array of repository IDs that can access the organization secret. You can only provide a list of repository IDs when the `visibility` is set to `selected`. You can manage the list of selected repositories using the [List selected repositories for an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#list-selected-repositories-for-an-organization-secret), [Set selected repositories for an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#set-selected-repositories-for-an-organization-secret), and [Remove selected repository from an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#remove-selected-repository-from-an-organization-secret) endpoints
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds?;
    # Which type of organization repositories have access to the organization secret. `selected` means only the repositories specified by `selected_repository_ids` can access the secret
    "all"|"private"|"selected" visibility;
    # The ID of the key you used to encrypt the secret
    @jsondata:Name {value: "key_id"}
    string keyId?;
    # The value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get an organization public key](https://docs.github.com/rest/codespaces/organization-secrets#get-an-organization-public-key) endpoint
    @jsondata:Name {value: "encrypted_value"}
    string encryptedValue?;
};

public type SecretssecretNameBody2 record {
    # An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the `visibility` is set to `selected`. You can manage the list of selected repositories using the [List selected repositories for an organization secret](https://docs.github.com/rest/dependabot/secrets#list-selected-repositories-for-an-organization-secret), [Set selected repositories for an organization secret](https://docs.github.com/rest/dependabot/secrets#set-selected-repositories-for-an-organization-secret), and [Remove selected repository from an organization secret](https://docs.github.com/rest/dependabot/secrets#remove-selected-repository-from-an-organization-secret) endpoints
    @jsondata:Name {value: "selected_repository_ids"}
    string[] selectedRepositoryIds?;
    # Which type of organization repositories have access to the organization secret. `selected` means only the repositories specified by `selected_repository_ids` can access the secret
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
    ReposownerrepogittagsTagger tagger?;
    # The tag's name. This is typically a version (e.g., "v0.0.1")
    string tag;
    # The tag message
    string message;
    # The type of the object we're tagging. Normally this is a `commit` but it can also be a `tree` or a `blob`
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
    @jsondata:Name {value: "total_count"}
    int totalCount;
    @jsondata:Name {value: "check_suites"}
    CheckSuite[] checkSuites;
};

# Represents the Queries record for the operation: pulls/list
public type PullsListQueries record {
    # Filter pulls by head user or head organization and branch name in the format of `user:ref-name` or `organization:ref-name`. For example: `github:new-script-format` or `octocat:test-branch`
    string head?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Either `open`, `closed`, or `all` to filter by state
    "open"|"closed"|"all" state = "open";
    # What to sort results by. `popularity` will sort by the number of comments. `long-running` will sort by date created and will limit the results to pull requests that have been open for more than a month and have had activity within the past month
    "created"|"updated"|"popularity"|"long-running" sort = "created";
    # Page number of the results to fetch
    int page = 1;
    # Filter pulls by base branch name. Example: `gh-pages`
    string base?;
    # The direction of the sort. Default: `desc` when sort is `created` or sort is not specified, otherwise `asc`
    "asc"|"desc" direction?;
};

# A reply to a discussion within a team
public type TeamDiscussionComment record {
    @jsondata:Name {value: "body_html"}
    string bodyHtml;
    # The current version of the body content. If provided, this update operation will be rejected if the given version does not match the latest version on the server
    @jsondata:Name {value: "body_version"}
    string bodyVersion;
    NullableSimpleUser? author;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The main text of the comment
    string body;
    string url;
    # The unique sequence number of a team discussion comment
    int number;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "last_edited_at"}
    string? lastEditedAt;
    ReactionRollup reactions?;
    @jsondata:Name {value: "discussion_url"}
    string discussionUrl;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type RunIdDeploymentProtectionRuleBody ReviewCustomGatesCommentRequired|ReviewCustomGatesStateRequired;

# Gitignore Template
public type GitignoreTemplate record {
    string name;
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
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
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
    @jsondata:Name {value: "commit_url"}
    string commitUrl;
    @jsondata:Name {value: "total_count"}
    int totalCount;
    SimpleCommitStatus[] statuses;
    string state;
    MinimalRepository repository;
    string sha;
    string url;
};

# Delivery made by a webhook
public type HookDelivery record {
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
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    @jsondata:Name {value: "lock_reason"}
    string? lockReason;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type WorkflowUsageBillable record {
    @jsondata:Name {value: "UBUNTU"}
    WorkflowUsageBillableUBUNTU uBUNTU?;
    @jsondata:Name {value: "MACOS"}
    WorkflowUsageBillableUBUNTU mACOS?;
    @jsondata:Name {value: "WINDOWS"}
    WorkflowUsageBillableUBUNTU wINDOWS?;
};

public type OrgMembershipPermissions record {
    @jsondata:Name {value: "can_create_repository"}
    boolean canCreateRepository;
};

# Hovercard
public type Hovercard record {
    HovercardContexts[] contexts;
};

# Actions OIDC subject customization for a repository
public type ActionsOIDCSubjectCustomizationForARepository record {
    # Array of unique strings. Each claim key can only contain alphanumeric characters and underscores
    @jsondata:Name {value: "include_claim_keys"}
    string[] includeClaimKeys?;
    # Whether to use the default template or not. If `true`, the `include_claim_keys` field is ignored
    @jsondata:Name {value: "use_default"}
    boolean useDefault;
};

# Legacy Review Comment
public type ReviewComment record {
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    @jsondata:Name {value: "original_commit_id"}
    string originalCommitId;
    @jsondata:Name {value: "_links"}
    ReviewCommentLinks links;
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    @jsondata:Name {value: "in_reply_to_id"}
    int inReplyToId?;
    # The line of the blob to which the comment applies. The last line of the range for a multi-line comment
    int line?;
    @jsondata:Name {value: "diff_hunk"}
    string diffHunk;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The first line of the range for a multi-line comment
    @jsondata:Name {value: "start_line"}
    int? startLine?;
    string body;
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    string path;
    @jsondata:Name {value: "original_position"}
    int originalPosition;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "pull_request_review_id"}
    int? pullRequestReviewId;
    int id;
    # The side of the first line of the range for a multi-line comment
    "LEFT"|"RIGHT" side = "RIGHT";
    @jsondata:Name {value: "pull_request_url"}
    string pullRequestUrl;
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
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    ReactionRollup reactions?;
    int? position;
    @jsondata:Name {value: "commit_id"}
    string commitId;
    NullableSimpleUser? user;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# A team's access to a repository
public type TeamRepository record {
    # Whether to allow forking this repo
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking = false;
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount;
    # Whether this repository acts as a template that can be used to generate new repositories
    @jsondata:Name {value: "is_template"}
    boolean isTemplate = false;
    @jsondata:Name {value: "pushed_at"}
    string? pushedAt;
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl;
    string? language;
    @jsondata:Name {value: "branches_url"}
    string branchesUrl;
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl;
    # Whether to allow rebase merges for pull requests
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge = true;
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    RepositoryPermissions permissions?;
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl;
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    @jsondata:Name {value: "releases_url"}
    string releasesUrl;
    @jsondata:Name {value: "svn_url"}
    string svnUrl;
    @jsondata:Name {value: "subscribers_count"}
    int subscribersCount?;
    # Unique identifier of the repository
    int id;
    @jsondata:Name {value: "master_branch"}
    string masterBranch?;
    int forks;
    @jsondata:Name {value: "archive_url"}
    string archiveUrl;
    # Whether to allow merge commits for pull requests
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit = true;
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl;
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    # The repository visibility: public, private, or internal
    string visibility = "public";
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    @jsondata:Name {value: "network_count"}
    int networkCount?;
    @jsondata:Name {value: "ssh_url"}
    string sshUrl;
    @jsondata:Name {value: "role_name"}
    string roleName?;
    NullableLicenseSimple? license;
    @jsondata:Name {value: "full_name"}
    string fullName;
    int size;
    @jsondata:Name {value: "template_repository"}
    NullableRepository? templateRepository?;
    # Whether to allow Auto-merge to be used on pull requests
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge = false;
    @jsondata:Name {value: "languages_url"}
    string languagesUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl;
    @jsondata:Name {value: "clone_url"}
    string cloneUrl;
    # The name of the repository
    string name;
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl;
    # The default branch of the repository
    @jsondata:Name {value: "default_branch"}
    string defaultBranch;
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    @jsondata:Name {value: "trees_url"}
    string treesUrl;
    @jsondata:Name {value: "tags_url"}
    string tagsUrl;
    # Whether the repository is private or public
    boolean 'private = false;
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl;
    # Whether downloads are enabled
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads = true;
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount;
    string? description;
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    int watchers;
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl;
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
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl;
    # Returns whether or not this repository disabled
    boolean disabled;
    # Whether to delete head branches when pull requests are merged
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge = false;
    @jsondata:Name {value: "git_url"}
    string gitUrl;
    @jsondata:Name {value: "has_pages"}
    boolean hasPages;
    NullableSimpleUser? owner;
    # Whether to allow squash merges for pull requests
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge = true;
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    @jsondata:Name {value: "compare_url"}
    string compareUrl;
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl;
    string[] topics?;
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl;
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl;
    @jsondata:Name {value: "merges_url"}
    string mergesUrl;
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl;
    # Whether issues are enabled
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues = true;
    # Whether to require contributors to sign off on web-based commits
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired = false;
    string url;
    @jsondata:Name {value: "contents_url"}
    string contentsUrl;
    @jsondata:Name {value: "mirror_url"}
    string? mirrorUrl;
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl;
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    boolean 'fork;
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl;
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl;
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    @jsondata:Name {value: "watchers_count"}
    int watchersCount;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    string? homepage;
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

# Require status checks to pass before merging. Set to `null` to disable
public type ReposownerrepobranchesbranchprotectionRequiredStatusChecks record {
    # The list of status checks to require in order to merge into this branch
    ReposownerrepobranchesbranchprotectionRequiredStatusChecksChecks[] checks?;
    # **Deprecated**: The list of status checks to require in order to merge into this branch. If any of these checks have recently been set by a particular GitHub App, they will be required to come from that app in future for the branch to merge. Use `checks` instead of `contexts` for more fine-grained control
    # 
    # # Deprecated
    @deprecated
    string[] contexts;
    # Require branches to be up to date before merging
    boolean strict;
};

# Represents the Queries record for the operation: apps/list-webhook-deliveries
public type AppsListWebhookDeliveriesQueries record {
    # Used for pagination: the starting delivery from which the page of deliveries is fetched. Refer to the `link` header for the next and previous page cursors
    string cursor?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    boolean redelivery?;
};

public type RestrictionsAppsBody1 ReposownerrepobranchesbranchprotectionrestrictionsappsOneOf11|ReposownerrepobranchesbranchprotectionrestrictionsappsreposownerrepobranchesbranchprotectionrestrictionsappsOneOf112;

public type RestrictionsAppsBody2 ReposownerrepobranchesbranchprotectionrestrictionsappsOneOf12|ReposownerrepobranchesbranchprotectionrestrictionsappsreposownerrepobranchesbranchprotectionrestrictionsappsOneOf122;

public type IssueNumberReactionsBody record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the issue
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

# A GitHub user
public type NullableSimpleUser record {
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    string login;
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    string 'type;
    @jsondata:Name {value: "starred_at"}
    string starredAt?;
    string url;
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    string? name?;
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    int id;
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    string? email?;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
};

public type RepoDeploymentsBody record {
    # The ref to deploy. This can be a branch, tag, or SHA
    string ref;
    # Name for the target deployment environment (e.g., `production`, `staging`, `qa`)
    string environment = "production";
    # Specifies a task to execute (e.g., `deploy` or `deploy:migrations`)
    string task = "deploy";
    # The [status](https://docs.github.com/rest/commits/statuses) contexts to verify against commit status checks. If you omit this parameter, GitHub verifies all unique contexts before creating a deployment. To bypass checking entirely, pass an empty array. Defaults to all unique contexts
    @jsondata:Name {value: "required_contexts"}
    string[] requiredContexts?;
    record {}|string payload?;
    # Specifies if the given environment is specific to the deployment and will no longer exist at some point in the future. Default: `false`
    @jsondata:Name {value: "transient_environment"}
    boolean transientEnvironment = false;
    # Short description of the deployment
    string? description = "";
    # Attempts to automatically merge the default branch into the requested ref, if it's behind the default branch
    @jsondata:Name {value: "auto_merge"}
    boolean autoMerge = true;
    # Specifies if the given environment is one that end-users directly interact with. Default: `true` when `environment` is `production` and `false` otherwise
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
    # Wildcard characters will not match `/`. For example, to match branches that begin with `release/` and contain an additional single slash, use `release/*/*`.
    # For more information about pattern matching syntax, see the [Ruby File.fnmatch documentation](https://ruby-doc.org/core-2.5.1/File.html#method-c-fnmatch)
    string name;
};

# Represents the Queries record for the operation: activity/list-repos-starred-by-authenticated-user
public type ActivityListReposStarredByAuthenticatedUserQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The property to sort the results by. `created` means when the repository was starred. `updated` means when the repository was last pushed to
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
    "required_signatures" 'type;
};

# Gist History
public type GistHistory record {
    @jsondata:Name {value: "committed_at"}
    string committedAt?;
    @jsondata:Name {value: "change_status"}
    GistHistoryChangeStatus changeStatus?;
    NullableSimpleUser? user?;
    string version?;
    string url?;
};

# Represents the Queries record for the operation: dependabot/list-alerts-for-org
public type DependabotListAlertsForOrgQueries record {
    # A comma-separated list of severities. If specified, only alerts with these severities will be returned.
    # 
    # Can be: `low`, `medium`, `high`, `critical`
    string severity?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # A comma-separated list of package names. If specified, only alerts for these packages will be returned
    string package?;
    # A comma-separated list of ecosystems. If specified, only alerts for these ecosystems will be returned.
    # 
    # Can be: `composer`, `go`, `maven`, `npm`, `nuget`, `pip`, `pub`, `rubygems`, `rust`
    string ecosystem?;
    # **Deprecated**. The number of results per page (max 100), starting from the last matching result.
    # This parameter must not be used in combination with `first`.
    # Instead, use `per_page` in combination with `before` to fetch the last page of results
    @constraint:Int {minValue: 1, maxValue: 100}
    int last?;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor
    string before?;
    # The scope of the vulnerable dependency. If specified, only alerts with this scope will be returned
    "development"|"runtime" scope?;
    # A comma-separated list of states. If specified, only alerts with these states will be returned.
    # 
    # Can be: `auto_dismissed`, `dismissed`, `fixed`, `open`
    string state?;
    # The property by which to sort the results.
    # `created` means when the alert was created.
    # `updated` means when the alert's state last changed
    "created"|"updated" sort = "created";
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor
    string after?;
    # **Deprecated**. The number of results per page (max 100), starting from the first matching result.
    # This parameter must not be used in combination with `last`.
    # Instead, use `per_page` in combination with `after` to fetch the first page of results
    @constraint:Int {minValue: 1, maxValue: 100}
    int first = 30;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

public type OrganizationSecretScanningAlert record {
    # The type of secret that secret scanning detected
    @jsondata:Name {value: "secret_type"}
    string secretType?;
    @jsondata:Name {value: "push_protection_bypassed_by"}
    NullableSimpleUser? pushProtectionBypassedBy?;
    # The time that push protection was bypassed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`
    @jsondata:Name {value: "push_protection_bypassed_at"}
    string? pushProtectionBypassedAt?;
    @jsondata:Name {value: "created_at"}
    AlertCreatedAt createdAt?;
    # User-friendly name for the detected secret, matching the `secret_type`.
    # For a list of built-in patterns, see "[Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns#supported-secrets-for-advanced-security)."
    @jsondata:Name {value: "secret_type_display_name"}
    string secretTypeDisplayName?;
    # The secret that was detected
    string secret?;
    SimpleRepository repository?;
    SecretScanningAlertResolution? resolution?;
    AlertUrl url?;
    AlertNumber number?;
    @jsondata:Name {value: "resolved_by"}
    NullableSimpleUser? resolvedBy?;
    @jsondata:Name {value: "updated_at"}
    NullableAlertUpdatedAt? updatedAt?;
    # The REST API URL of the code locations for this alert
    @jsondata:Name {value: "locations_url"}
    string locationsUrl?;
    # The comment that was optionally added when this alert was closed
    @jsondata:Name {value: "resolution_comment"}
    string? resolutionComment?;
    # The time that the alert was resolved in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`
    @jsondata:Name {value: "resolved_at"}
    string? resolvedAt?;
    @jsondata:Name {value: "html_url"}
    AlertHtmlUrl htmlUrl?;
    # Whether push protection was bypassed for the detected secret
    @jsondata:Name {value: "push_protection_bypassed"}
    boolean? pushProtectionBypassed?;
    SecretScanningAlertState state?;
};

# A repository import from an external source
public type Import record {
    @jsondata:Name {value: "failed_step"}
    string? failedStep?;
    @jsondata:Name {value: "error_message"}
    string? errorMessage?;
    @jsondata:Name {value: "push_percent"}
    int? pushPercent?;
    @jsondata:Name {value: "large_files_count"}
    int largeFilesCount?;
    # The URL of the originating repository
    @jsondata:Name {value: "vcs_url"}
    string vcsUrl;
    string? vcs;
    @jsondata:Name {value: "svc_root"}
    string svcRoot?;
    @jsondata:Name {value: "authors_url"}
    string authorsUrl;
    string message?;
    @jsondata:Name {value: "project_choices"}
    ImportProjectChoices[] projectChoices?;
    string url;
    @jsondata:Name {value: "commit_count"}
    int? commitCount?;
    @jsondata:Name {value: "use_lfs"}
    boolean useLfs?;
    @jsondata:Name {value: "tfvc_project"}
    string tfvcProject?;
    @jsondata:Name {value: "authors_count"}
    int? authorsCount?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "import_percent"}
    int? importPercent?;
    @jsondata:Name {value: "has_large_files"}
    boolean hasLargeFiles?;
    @jsondata:Name {value: "status_text"}
    string? statusText?;
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    @jsondata:Name {value: "svn_root"}
    string svnRoot?;
    @jsondata:Name {value: "large_files_size"}
    int largeFilesSize?;
    "auth"|"error"|"none"|"detecting"|"choose"|"auth_failed"|"importing"|"mapping"|"waiting_to_push"|"pushing"|"complete"|"setup"|"unknown"|"detection_found_multiple"|"detection_found_nothing"|"detection_needs_auth" status;
};

# Marketplace Purchase
public type MarketplacePurchase record {
    @jsondata:Name {value: "marketplace_pending_change"}
    MarketplacePurchaseMarketplacePendingChange? marketplacePendingChange?;
    @jsondata:Name {value: "organization_billing_email"}
    string organizationBillingEmail?;
    int id;
    @jsondata:Name {value: "marketplace_purchase"}
    MarketplacePurchaseMarketplacePurchase marketplacePurchase;
    string 'type;
    string login;
    string url;
    string? email?;
};

# Codespace default attributes
public type CodespaceDefault record {
    @jsondata:Name {value: "devcontainer_path"}
    string? devcontainerPath;
    string location;
};

public type ThreadIdSubscriptionBody record {
    # Whether to block all notifications from a thread
    boolean ignored = false;
};

public type IssueEventDismissedReview record {
    @jsondata:Name {value: "review_id"}
    int reviewId;
    string state;
    @jsondata:Name {value: "dismissal_commit_id"}
    string? dismissalCommitId?;
    @jsondata:Name {value: "dismissal_message"}
    string? dismissalMessage;
};

# Pull requests let you tell others about changes you've pushed to a repository on GitHub. Once a pull request is sent, interested parties can review the set of changes, discuss potential modifications, and even push follow-up commits if necessary
public type PullRequest record {
    @jsondata:Name {value: "issue_url"}
    string issueUrl;
    boolean? rebaseable?;
    @jsondata:Name {value: "_links"}
    PullRequestSimpleLinks links;
    int deletions;
    @jsondata:Name {value: "diff_url"}
    string diffUrl;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    SimpleUser[]? assignees?;
    @jsondata:Name {value: "requested_reviewers"}
    SimpleUser[]? requestedReviewers?;
    @jsondata:Name {value: "merged_by"}
    NullableSimpleUser? mergedBy;
    # The title of the pull request
    string title;
    string? body;
    @jsondata:Name {value: "requested_teams"}
    TeamSimple[]? requestedTeams?;
    PullRequestHead head;
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # Number uniquely identifying the pull request within its repository
    int number;
    boolean? mergeable;
    @jsondata:Name {value: "patch_url"}
    string patchUrl;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Indicates whether or not the pull request is a draft
    boolean draft?;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    @jsondata:Name {value: "merge_commit_sha"}
    string? mergeCommitSha;
    @jsondata:Name {value: "review_comment_url"}
    string reviewCommentUrl;
    @jsondata:Name {value: "active_lock_reason"}
    string? activeLockReason?;
    int id;
    # State of this Pull Request. Either `open` or `closed`
    "open"|"closed" state;
    boolean locked;
    @jsondata:Name {value: "mergeable_state"}
    string mergeableState;
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    @jsondata:Name {value: "closed_at"}
    string? closedAt;
    int comments;
    int additions;
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl;
    @jsondata:Name {value: "merged_at"}
    string? mergedAt;
    boolean merged;
    @jsondata:Name {value: "review_comments"}
    int reviewComments;
    @jsondata:Name {value: "auto_merge"}
    AutoMerge? autoMerge;
    @jsondata:Name {value: "changed_files"}
    int changedFiles;
    string url;
    PullRequestSimpleLabels[] labels;
    NullableMilestone? milestone;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "review_comments_url"}
    string reviewCommentsUrl;
    # Indicates whether maintainers can modify the pull request
    @jsondata:Name {value: "maintainer_can_modify"}
    boolean maintainerCanModify;
    int commits;
    NullableSimpleUser? assignee;
    SimpleUser user;
    @jsondata:Name {value: "node_id"}
    string nodeId;
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
    # For example, `day` will filter for rule suites that occurred in the past 24 hours, and `week` will filter for insights that occurred in the past 7 days (168 hours)
    @http:Query {name: "time_period"}
    "hour"|"day"|"week"|"month" timePeriod = "day";
    # The rule results to filter on. When specified, only suites with this result will be returned
    @http:Query {name: "rule_suite_result"}
    "pass"|"fail"|"bypass"|"all" ruleSuiteResult = "all";
};

# Represents the Queries record for the operation: orgs/list-webhook-deliveries
public type OrgsListWebhookDeliveriesQueries record {
    # Used for pagination: the starting delivery from which the page of deliveries is fetched. Refer to the `link` header for the next and previous page cursors
    string cursor?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
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

public type IssuePullRequest record {
    @jsondata:Name {value: "patch_url"}
    string? patchUrl;
    @jsondata:Name {value: "merged_at"}
    string? mergedAt?;
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    @jsondata:Name {value: "diff_url"}
    string? diffUrl;
    string? url;
};

# A public SSH key used to sign Git commits
public type SshSigningKey record {
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string title;
    string 'key;
};

public type Root record {
    @jsondata:Name {value: "label_search_url"}
    string labelSearchUrl;
    @jsondata:Name {value: "organization_repositories_url"}
    string organizationRepositoriesUrl;
    @jsondata:Name {value: "user_repositories_url"}
    string userRepositoriesUrl;
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl;
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    @jsondata:Name {value: "keys_url"}
    string keysUrl;
    @jsondata:Name {value: "user_search_url"}
    string userSearchUrl;
    @jsondata:Name {value: "feeds_url"}
    string feedsUrl;
    @jsondata:Name {value: "topic_search_url"}
    string topicSearchUrl?;
    @jsondata:Name {value: "starred_gists_url"}
    string starredGistsUrl;
    @jsondata:Name {value: "user_url"}
    string userUrl;
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    @jsondata:Name {value: "user_organizations_url"}
    string userOrganizationsUrl;
    @jsondata:Name {value: "current_user_authorizations_html_url"}
    string currentUserAuthorizationsHtmlUrl;
    @jsondata:Name {value: "emojis_url"}
    string emojisUrl;
    @jsondata:Name {value: "organization_url"}
    string organizationUrl;
    @jsondata:Name {value: "hub_url"}
    string hubUrl;
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    @jsondata:Name {value: "emails_url"}
    string emailsUrl;
    @jsondata:Name {value: "rate_limit_url"}
    string rateLimitUrl;
    @jsondata:Name {value: "commit_search_url"}
    string commitSearchUrl;
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    @jsondata:Name {value: "organization_teams_url"}
    string organizationTeamsUrl;
    @jsondata:Name {value: "public_gists_url"}
    string publicGistsUrl;
    @jsondata:Name {value: "authorizations_url"}
    string authorizationsUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "current_user_url"}
    string currentUserUrl;
    @jsondata:Name {value: "current_user_repositories_url"}
    string currentUserRepositoriesUrl;
    @jsondata:Name {value: "issue_search_url"}
    string issueSearchUrl;
    @jsondata:Name {value: "code_search_url"}
    string codeSearchUrl;
    @jsondata:Name {value: "repository_search_url"}
    string repositorySearchUrl;
};

public type MembershipsusernameBody record {
    # The role to give the user in the organization. Can be one of:  
    #  * `admin` - The user will become an owner of the organization.  
    #  * `member` - The user will become a non-owner member of the organization
    "admin"|"member" role = "member";
};

public type GitTreeTree record {
    string mode?;
    string path?;
    int size?;
    string 'type?;
    string sha?;
    string url?;
};

public type RepositoryRulesetConditionsRefName record {
    # Array of ref names or patterns to include. One of these patterns must match for the condition to pass. Also accepts `~DEFAULT_BRANCH` to include the default branch or `~ALL` to include all branches
    string[] include?;
    # Array of ref names or patterns to exclude. The condition will not pass if any of these patterns match
    string[] exclude?;
};

# If provided, the `secret` will be used as the `key` to generate the HMAC hex digest value for [delivery signature headers](https://docs.github.com/webhooks/event-payloads/#delivery-headers)
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
    # Filters check runs by their `completed_at` timestamp. `latest` returns the most recent check runs
    "latest"|"all" filter = "latest";
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Returns check runs with the specified `name`
    @http:Query {name: "check_name"}
    string checkName?;
    # Page number of the results to fetch
    int page = 1;
    @http:Query {name: "app_id"}
    int appId?;
    # Returns check runs with the specified `status`
    "queued"|"in_progress"|"completed" status?;
};

# Create a new snapshot of a repository's dependencies
public type Snapshot record {|
    # The repository branch that triggered this snapshot
    @constraint:String {pattern: re `^refs/`}
    string ref;
    Metadata metadata?;
    # The time at which the snapshot was scanned
    string scanned;
    # A collection of package manifests, which are a collection of related dependencies declared in a file or representing a logical group of dependencies
    record {|Manifest...;|} manifests?;
    SnapshotJob job;
    # The version of the repository snapshot submission
    int version;
    # The commit SHA associated with this dependency snapshot. Maximum length: 40 characters
    @constraint:String {maxLength: 40, minLength: 40}
    string sha;
    SnapshotDetector detector;
|};

# Label Search Result Item
public type LabelSearchResultItem record {
    decimal score;
    boolean default;
    string color;
    @jsondata:Name {value: "text_matches"}
    SearchResultTextMatches textMatches?;
    string name;
    string? description;
    int id;
    string url;
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
    # Whether to use the default template or not. If `true`, the `include_claim_keys` field is ignored
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
    string side?;
    int line?;
    @jsondata:Name {value: "start_line"}
    int startLine?;
    # The position in the diff where you want to add a review comment. Note this value is not the same as the line number in the file. For help finding the position value, read the note below
    int position?;
    # Text of the review comment
    string body;
    @jsondata:Name {value: "start_side"}
    string startSide?;
};

public type CodeScanningOrganizationAlertItems record {
    @jsondata:Name {value: "instances_url"}
    AlertInstancesUrl instancesUrl;
    @jsondata:Name {value: "created_at"}
    AlertCreatedAt createdAt;
    @jsondata:Name {value: "dismissed_comment"}
    CodeScanningAlertDismissedComment? dismissedComment?;
    CodeScanningAlertRule rule;
    SimpleRepository repository;
    AlertUrl url;
    CodeScanningAnalysisTool tool;
    AlertNumber number;
    @jsondata:Name {value: "updated_at"}
    AlertUpdatedAt updatedAt?;
    @jsondata:Name {value: "html_url"}
    AlertHtmlUrl htmlUrl;
    @jsondata:Name {value: "fixed_at"}
    AlertFixedAt? fixedAt?;
    @jsondata:Name {value: "most_recent_instance"}
    CodeScanningAlertInstance mostRecentInstance;
    CodeScanningAlertState state;
    @jsondata:Name {value: "dismissed_by"}
    NullableSimpleUser? dismissedBy;
    @jsondata:Name {value: "dismissed_reason"}
    CodeScanningAlertDismissedReason? dismissedReason;
    @jsondata:Name {value: "dismissed_at"}
    AlertDismissedAt? dismissedAt;
};

# Merged branch response message
public type MergedBranchResponse record {
    string message?;
};

public type TemplateRepoGenerateBody record {
    # The organization or person who will own the new repository. To create a new repository in an organization, the authenticated user must be a member of the specified organization
    string owner?;
    # Either `true` to create a new private repository or `false` to create a new public one
    boolean 'private = false;
    # Set to `true` to include the directory structure and files from all branches in the template repository, and not just the default branch. Default: `false`
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

public type RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf123456789101112 record {
    *RepositoryRuleCommitterEmailPattern;
    *RepositoryRuleRulesetInfo;
};

public type RestrictionsUsersBody ReposownerrepobranchesbranchprotectionrestrictionsusersOneOf1|ReposownerrepobranchesbranchprotectionrestrictionsusersreposownerrepobranchesbranchprotectionrestrictionsusersOneOf12;

# Content File
public type ContentFile record {
    @jsondata:Name {value: "_links"}
    ContentTreeLinks links;
    @jsondata:Name {value: "submodule_git_url"}
    string submoduleGitUrl?;
    "file" 'type;
    string encoding;
    string sha;
    string content;
    string url;
    string target?;
    string path;
    int size;
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    string name;
    @jsondata:Name {value: "download_url"}
    string? downloadUrl;
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
    string context;
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
    int id;
    string 'type;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# The authorization for an OAuth app, GitHub App, or a Personal Access Token
public type Authorization record {
    AuthorizationApp app;
    string? note;
    @jsondata:Name {value: "note_url"}
    string? noteUrl;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    string url;
    string token;
    @jsondata:Name {value: "hashed_token"}
    string? hashedToken;
    @jsondata:Name {value: "expires_at"}
    string? expiresAt;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    NullableScopedInstallation? installation?;
    @jsondata:Name {value: "token_last_eight"}
    string? tokenLastEight;
    string? fingerprint;
    int id;
    # A list of scopes that this authorization is in
    string[]? scopes;
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

# Require at least one approving review on a pull request, before merging. Set to `null` to disable
public type ReposownerrepobranchesbranchprotectionRequiredPullRequestReviews record {
    @jsondata:Name {value: "dismissal_restrictions"}
    ReposownerrepobranchesbranchprotectionRequiredPullRequestReviewsDismissalRestrictions dismissalRestrictions?;
    # Specify the number of reviewers required to approve pull requests. Use a number between 1 and 6 or 0 to not require reviewers
    @jsondata:Name {value: "required_approving_review_count"}
    int requiredApprovingReviewCount?;
    # Blocks merging pull requests until [code owners](https://docs.github.com/articles/about-code-owners/) review them
    @jsondata:Name {value: "require_code_owner_reviews"}
    boolean requireCodeOwnerReviews?;
    # Set to `true` if you want to automatically dismiss approving reviews when someone pushes a new commit
    @jsondata:Name {value: "dismiss_stale_reviews"}
    boolean dismissStaleReviews?;
    @jsondata:Name {value: "bypass_pull_request_allowances"}
    ReposownerrepobranchesbranchprotectionRequiredPullRequestReviewsBypassPullRequestAllowances bypassPullRequestAllowances?;
    # Whether the most recent push must be approved by someone other than the person who pushed it. Default: `false`
    @jsondata:Name {value: "require_last_push_approval"}
    boolean requireLastPushApproval = false;
};

# Represents the Queries record for the operation: dependabot/list-alerts-for-repo
public type DependabotListAlertsForRepoQueries record {
    # A comma-separated list of severities. If specified, only alerts with these severities will be returned.
    # 
    # Can be: `low`, `medium`, `high`, `critical`
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
    # Can be: `composer`, `go`, `maven`, `npm`, `nuget`, `pip`, `pub`, `rubygems`, `rust`
    string ecosystem?;
    # **Deprecated**. The number of results per page (max 100), starting from the last matching result.
    # This parameter must not be used in combination with `first`.
    # Instead, use `per_page` in combination with `before` to fetch the last page of results
    @constraint:Int {minValue: 1, maxValue: 100}
    int last?;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor
    string before?;
    # A comma-separated list of full manifest paths. If specified, only alerts for these manifests will be returned
    string manifest?;
    # The property by which to sort the results.
    # `created` means when the alert was created.
    # `updated` means when the alert's state last changed
    "created"|"updated" sort = "created";
    # The scope of the vulnerable dependency. If specified, only alerts with this scope will be returned
    "development"|"runtime" scope?;
    # A comma-separated list of states. If specified, only alerts with these states will be returned.
    # 
    # Can be: `auto_dismissed`, `dismissed`, `fixed`, `open`
    string state?;
    # **Deprecated**. Page number of the results to fetch. Use cursor-based pagination with `before` or `after` instead
    # 
    # # Deprecated
    @deprecated
    int page = 1;
    # A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor
    string after?;
    # **Deprecated**. The number of results per page (max 100), starting from the first matching result.
    # This parameter must not be used in combination with `last`.
    # Instead, use `per_page` in combination with `after` to fetch the first page of results
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
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    string name;
    boolean active;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string 'type;
    @jsondata:Name {value: "ping_url"}
    string pingUrl;
    OrgHookConfig config;
    string url;
    @jsondata:Name {value: "deliveries_url"}
    string deliveriesUrl?;
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
    int total?;
    int additions?;
    int deletions?;
};

public type SecurityProductenablementBody record {
    # CodeQL query suite to be used. If you specify the `query_suite` parameter, the default setup will be configured with this query suite only on all repositories that didn't have default setup already configured. It will not change the query suite on repositories that already have default setup configured.
    # If you don't specify any `query_suite` in your request, the preferred query suite of the organization will be applied.
    "default"|"extended" query_suite?;
};

# An object describing a submodule
public type ContentSubmodule record {
    string path;
    int size;
    @jsondata:Name {value: "submodule_git_url"}
    string submoduleGitUrl;
    @jsondata:Name {value: "_links"}
    ContentTreeLinks links;
    @jsondata:Name {value: "html_url"}
    string? htmlUrl;
    string name;
    @jsondata:Name {value: "download_url"}
    string? downloadUrl;
    "submodule" 'type;
    @jsondata:Name {value: "git_url"}
    string? gitUrl;
    string sha;
    string url;
};

# Represents the Queries record for the operation: licenses/get-all-commonly-used
public type LicensesGetAllCommonlyUsedQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
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
    "pull_request" 'type;
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
    string context;
    @jsondata:Name {value: "app_id"}
    int? appId;
};

# The status of a deployment
public type DeploymentStatus record {
    NullableSimpleUser? creator;
    # Deprecated: the URL to associate with this status
    @jsondata:Name {value: "target_url"}
    string targetUrl = "";
    @jsondata:Name {value: "deployment_url"}
    string deploymentUrl;
    # A short description of the status
    @constraint:String {maxLength: 140}
    string description = "";
    @jsondata:Name {value: "created_at"}
    string createdAt;
    string url;
    # The environment of the deployment that the status is for
    string environment = "";
    # The URL for accessing your environment
    @jsondata:Name {value: "environment_url"}
    string environmentUrl = "";
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    # The URL to associate with this status
    @jsondata:Name {value: "log_url"}
    string logUrl = "";
    int id;
    # The state of the status
    "error"|"failure"|"inactive"|"pending"|"success"|"queued"|"in_progress" state;
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Secrets for GitHub Actions for an organization
public type OrganizationActionsSecret record {
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # Visibility of a secret
    "all"|"private"|"selected" visibility;
    # The name of the secret
    string name;
    @jsondata:Name {value: "selected_repositories_url"}
    string selectedRepositoriesUrl?;
    @jsondata:Name {value: "created_at"}
    string createdAt;
};

# Timeline Committed Event
public type TimelineCommittedEvent record {
    GitCommitAuthor committer;
    GitCommitAuthor author;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    GitCommitTree tree;
    string event?;
    # Message describing the purpose of the commit
    string message;
    # SHA for the commit
    string sha;
    string url;
    GitCommitVerification verification;
    @jsondata:Name {value: "node_id"}
    string nodeId;
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

# The GUID of the tool used to generate the code scanning analysis, if provided in the uploaded SARIF data
public type CodeScanningAnalysisToolGuid string?;

public type CollaboratorsusernameBody record {
    # The permission to grant the collaborator
    "read"|"write"|"admin" permission = "write";
};

public type MilestonesmilestoneNumberBody record {
    # A description of the milestone
    string description?;
    # The state of the milestone. Either `open` or `closed`
    "open"|"closed" state = "open";
    # The title of the milestone
    string title?;
    # The milestone due date. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    @jsondata:Name {value: "due_on"}
    string dueOn?;
};

# Secrets for GitHub Dependabot for an organization
public type OrganizationDependabotSecretResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
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

# Information about the Git committer
public type NullableSimpleCommitCommitter record {
    # Name of the commit's committer
    string name;
    # Git email address of the commit's committer
    string email;
};

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
    @jsondata:Name {value: "alt_domain"}
    PagesHealthCheckAltDomain? altDomain?;
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
    string path;
    @jsondata:Name {value: "start_column"}
    int? startColumn;
    @jsondata:Name {value: "annotation_level"}
    string? annotationLevel;
    @jsondata:Name {value: "blob_href"}
    string blobHref;
    @jsondata:Name {value: "raw_details"}
    string? rawDetails;
    @jsondata:Name {value: "start_line"}
    int startLine;
    string? title;
    string? message;
    @jsondata:Name {value: "end_line"}
    int endLine;
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
    @jsondata:Name {value: "body_html"}
    string bodyHtml;
    # Whether or not this discussion should be pinned for easy retrieval
    boolean pinned;
    # Whether or not this discussion should be restricted to team members and organization administrators
    boolean 'private;
    # The current version of the body content. If provided, this update operation will be rejected if the given version does not match the latest version on the server
    @jsondata:Name {value: "body_version"}
    string bodyVersion;
    NullableSimpleUser? author;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The main text of the discussion
    string body;
    # The title of the discussion
    string title;
    string url;
    # The unique sequence number of a team discussion
    int number;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "comments_count"}
    int commentsCount;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    @jsondata:Name {value: "last_edited_at"}
    string? lastEditedAt;
    ReactionRollup reactions?;
    @jsondata:Name {value: "team_url"}
    string teamUrl;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type ActionsCacheListActionsCaches record {
    string ref?;
    @jsondata:Name {value: "size_in_bytes"}
    int sizeInBytes?;
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    int id?;
    @jsondata:Name {value: "last_accessed_at"}
    string lastAccessedAt?;
    string version?;
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
    # The pending cancellation date for the seat, in `YYYY-MM-DD` format. This will be null unless the assignee's Copilot access has been canceled during the current billing cycle. If the seat has been cancelled, this corresponds to the start of the organization's next billing cycle
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
    string sha;
    string url;
};

public type VariablesnameBody record {
    # An array of repository ids that can access the organization variable. You can only provide a list of repository ids when the `visibility` is set to `selected`
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds?;
    # The type of repositories in the organization that can access the variable. `selected` means only the repositories specified by `selected_repository_ids` can access the variable
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
    # The `ref` for a branch can be formatted either as `refs/heads/BRANCH_NAME` or `BRANCH_NAME`, where `BRANCH_NAME` is the name of your branch
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
    # For example, `day` will filter for activity that occurred in the past 24 hours, and `week` will filter for activity that occurred in the past 7 days (168 hours)
    @http:Query {name: "time_period"}
    "day"|"week"|"month"|"quarter"|"year" timePeriod?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

# Metadata for a Git tag
public type GitTag record {
    GitTagTagger tagger;
    # Name of the tag
    string tag;
    # Message describing the purpose of the tag
    string message;
    string sha;
    # URL for the tag
    string url;
    Verification verification?;
    @jsondata:Name {value: "node_id"}
    string nodeId;
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

public type PullRequestSimpleLabels record {
    boolean default;
    string color;
    string name;
    string? description;
    int id;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf123 record {
    *RepositoryRuleDeletion;
    *RepositoryRuleRulesetInfo;
};

public type RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf1234 record {
    *RepositoryRuleRequiredLinearHistory;
    *RepositoryRuleRulesetInfo;
};

# A suite of checks performed on the code of a given code change
public type CheckSuite record {
    NullableIntegration? app;
    @jsondata:Name {value: "head_commit"}
    SimpleCommit headCommit;
    @jsondata:Name {value: "head_branch"}
    string? headBranch;
    string? before;
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    MinimalRepository repository;
    # The SHA of the head commit that is being checked
    @jsondata:Name {value: "head_sha"}
    string headSha;
    string? url;
    "success"|"failure"|"neutral"|"cancelled"|"skipped"|"timed_out"|"action_required"|"startup_failure"|"stale"? conclusion;
    @jsondata:Name {value: "pull_requests"}
    PullRequestMinimal[]? pullRequests;
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    @jsondata:Name {value: "latest_check_runs_count"}
    int latestCheckRunsCount;
    boolean rerequestable?;
    @jsondata:Name {value: "runs_rerequestable"}
    boolean runsRerequestable?;
    int id;
    string? after;
    @jsondata:Name {value: "check_runs_url"}
    string checkRunsUrl;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    "queued"|"in_progress"|"completed"? status;
};

# Represents the Queries record for the operation: orgs/list-members
public type OrgsListMembersQueries record {
    # Filter members returned in the list. `2fa_disabled` means that only members without [two-factor authentication](https://github.com/blog/1614-two-factor-authentication) enabled will be returned. This options is only available for organization owners
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
    SecurityAdvisoryEcosystems ecosystem;
    # The unique package name within its ecosystem
    string? name?;
};

public type PullRequestSimpleLinks record {
    Link comments;
    Link issue;
    Link commits;
    Link statuses;
    @jsondata:Name {value: "review_comments"}
    Link reviewComments;
    Link self;
    Link html;
    @jsondata:Name {value: "review_comment"}
    Link reviewComment;
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
    # The time that the advisory was last modified in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The unique CVE ID assigned to the advisory
    @jsondata:Name {value: "cve_id"}
    string? cveId;
    # Vulnerable version range information for the advisory
    DependabotAlertSecurityVulnerability[] vulnerabilities;
    # The time that the advisory was withdrawn in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`
    @jsondata:Name {value: "withdrawn_at"}
    string? withdrawnAt;
    # The time that the advisory was published in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`
    @jsondata:Name {value: "published_at"}
    string publishedAt;
    DependabotAlertSecurityAdvisoryCvss cvss;
|};

# Details of a deployment environment
public type EnvironmentResponse record {
    Environment[] environments?;
    # The number of environments in this repository
    @jsondata:Name {value: "total_count"}
    int totalCount?;
};

# The total number of seat assignments cancelled
public type CopilotSeatCancelled record {
    @jsondata:Name {value: "seats_cancelled"}
    int seatsCancelled;
};

# Referrer Traffic
public type ReferrerTraffic record {
    string referrer;
    int count;
    int uniques;
};

public type RuleSuitesInner record {
    # The result of the rule evaluations for rules with the `active` enforcement status
    "pass"|"fail"|"bypass" result?;
    # The first commit sha before the push evaluation
    @jsondata:Name {value: "before_sha"}
    string beforeSha?;
    # The ref name that the evaluation ran on
    string ref?;
    # The result of the rule evaluations for rules with the `active` and `evaluate` enforcement statuses, demonstrating whether rules would pass or fail if all rules in the rule suite were `active`
    @jsondata:Name {value: "evaluation_result"}
    "pass"|"fail" evaluationResult?;
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
    # The name of the repository without the `.git` extension
    @jsondata:Name {value: "repository_name"}
    string repositoryName?;
};

# A GitHub user
public type SimpleUser record {
    @jsondata:Name {value: "gists_url"}
    string gistsUrl;
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    @jsondata:Name {value: "following_url"}
    string followingUrl;
    @jsondata:Name {value: "starred_url"}
    string starredUrl;
    string login;
    @jsondata:Name {value: "followers_url"}
    string followersUrl;
    string 'type;
    @jsondata:Name {value: "starred_at"}
    string starredAt?;
    string url;
    @jsondata:Name {value: "subscriptions_url"}
    string subscriptionsUrl;
    @jsondata:Name {value: "received_events_url"}
    string receivedEventsUrl;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    string? name?;
    @jsondata:Name {value: "site_admin"}
    boolean siteAdmin;
    int id;
    @jsondata:Name {value: "gravatar_id"}
    string? gravatarId;
    string? email?;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    @jsondata:Name {value: "organizations_url"}
    string organizationsUrl;
};

public type GistsgistIdBody record {
    # The description of the gist
    string description?;
    # The gist files to be updated, renamed, or deleted. Each `key` must match the current filename
    # (including extension) of the targeted gist file. For example: `hello.py`.
    # 
    # To delete a file, set the whole file to null. For example: `hello.py : null`. The file will also be
    # deleted if the specified object does not contain at least one of `content` or `filename`
    record {|GistsgistIdFiles?...;|} files?;
};

public type SecurityAndAnalysisAdvancedSecurity record {
    "enabled"|"disabled" status?;
};

public type WorkflowUsageBillableUBUNTU record {
    @jsondata:Name {value: "total_ms"}
    int totalMs?;
};

public type BranchRestrictionPolicyTeams record {
    string? parent?;
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl?;
    @jsondata:Name {value: "members_url"}
    string membersUrl?;
    string? description?;
    string privacy?;
    string permission?;
    string url?;
    @jsondata:Name {value: "notification_setting"}
    string notificationSetting?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    string name?;
    int id?;
    string slug?;
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
    boolean enabled;
|};

# Represents the Queries record for the operation: repos/list-deployments
public type ReposListDeploymentsQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The name of the ref. This can be a branch, tag, or SHA
    string ref = "none";
    # The name of the environment that was deployed to (e.g., `staging` or `production`)
    string? environment = "none";
    # The name of the task for the deployment (e.g., `deploy` or `deploy:migrations`)
    string task = "none";
    # Page number of the results to fetch
    int page = 1;
    # The SHA recorded at creation time
    string sha = "none";
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

public type RepositoryRuleCommitMessagePatternParameters record {
    # If true, the rule will fail if the pattern matches
    boolean negate?;
    # How this rule will appear to users
    string name?;
    # The pattern to match with
    string pattern;
    # The operator to use for matching
    "starts_with"|"ends_with"|"contains"|"regex" operator;
};

public type BranchRestrictionPolicyPermissions record {
    string metadata?;
    @jsondata:Name {value: "single_file"}
    string singleFile?;
    string contents?;
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
    boolean merged;
    string message;
    string sha;
};

# The time that the alert was auto-dismissed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`
public type AlertAutoDismissedAt string?;

# Represents the Queries record for the operation: issues/list
public type IssuesListQueries record {
    # Indicates which sorts of issues to return. `assigned` means issues assigned to you. `created` means issues created by you. `mentioned` means issues mentioning you. `subscribed` means issues you're subscribed to updates for. `all` or `repos` means all issues you can see, regardless of participation or creation
    "assigned"|"created"|"mentioned"|"subscribed"|"repos"|"all" filter = "assigned";
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    boolean collab?;
    boolean owned?;
    # Indicates the state of the issues to return
    "open"|"closed"|"all" state = "open";
    # What to sort results by
    "created"|"updated"|"comments" sort = "created";
    boolean orgs?;
    # Page number of the results to fetch
    int page = 1;
    # A list of comma separated label names. Example: `bug,ui,@high`
    string labels?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string since?;
    boolean pulls?;
};

# Label Search Result Item
public type LabelSearchResultItemResponse record {
    @jsondata:Name {value: "total_count"}
    int totalCount;
    @jsondata:Name {value: "incomplete_results"}
    boolean incompleteResults;
    LabelSearchResultItem[] items;
};

public type NullableIssueLabels LabelsOneOf13|LabelsLabelsOneOf132;

# GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub
public type Integration record {
    NullableSimpleUser? owner;
    # The number of installations associated with the GitHub app
    @jsondata:Name {value: "installations_count"}
    int installationsCount?;
    string? description;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    @jsondata:Name {value: "client_id"}
    string clientId?;
    @jsondata:Name {value: "external_url"}
    string externalUrl;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    IntegrationPermissions permissions;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The name of the GitHub app
    string name;
    @jsondata:Name {value: "webhook_secret"}
    string? webhookSecret?;
    string pem?;
    # Unique identifier of the GitHub app
    int id;
    @jsondata:Name {value: "client_secret"}
    string clientSecret?;
    # The slug name of the GitHub app
    string slug?;
    # The list of events for the GitHub app
    string[] events;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents the Queries record for the operation: code-scanning/delete-analysis
public type CodeScanningDeleteAnalysisQueries record {
    # Allow deletion if the specified analysis is the last in a set. If you attempt to delete the final analysis in a set without setting this parameter to `true`, you'll get a 400 response with the message: `Analysis is last of its type and deletion may result in the loss of historical alert data. Please specify confirm_delete.`
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
    "required_status_checks" 'type;
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
    # Only show fine-grained personal access tokens used before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    @http:Query {name: "last_used_before"}
    string lastUsedBefore?;
    # Only show fine-grained personal access tokens used after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
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
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
    AppPermissions permissions;
    @jsondata:Name {value: "single_file_name"}
    string? singleFileName;
    @jsondata:Name {value: "has_multiple_single_files"}
    boolean hasMultipleSingleFiles?;
    @jsondata:Name {value: "single_file_paths"}
    string[] singleFilePaths?;
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
    NullableSimpleUser? committer;
    CommitStats stats?;
    NullableSimpleUser? author;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    CommitCommit 'commit;
    DiffEntry[] files?;
    string sha;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    CommitParents[] parents;
};

public type ProtectedBranchRequiredPullRequestReviewsDismissalRestrictions record {
    @jsondata:Name {value: "teams_url"}
    string teamsUrl;
    Team[] teams;
    @jsondata:Name {value: "users_url"}
    string usersUrl;
    string url;
    SimpleUser[] users;
    Integration[] apps?;
};

# Details pertaining to one vulnerable version range for the advisory
public type DependabotAlertSecurityVulnerability record {|
    # The severity of the vulnerability
    "low"|"medium"|"high"|"critical" severity;
    @jsondata:Name {value: "first_patched_version"}
    DependabotAlertSecurityVulnerabilityFirstPatchedVersion? firstPatchedVersion;
    DependabotAlertPackage package;
    # Conditions that identify vulnerable versions of this vulnerability's package
    @jsondata:Name {value: "vulnerable_version_range"}
    string vulnerableVersionRange;
|};

# Parameters for a repository ruleset ref name condition
public type RepositoryRulesetConditions record {
    @jsondata:Name {value: "ref_name"}
    RepositoryRulesetConditionsRefName refName?;
};

# You can use `run_url` to track the status of the run. This includes a property status and conclusion.
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
    CommitComment[] comments?;
    string event?;
    @jsondata:Name {value: "commit_id"}
    string commitId?;
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
    #  * `owner`: Repositories that are owned by the authenticated user.  
    #  * `collaborator`: Repositories that the user has been added to as a collaborator.  
    #  * `organization_member`: Repositories that the user has access to through being a member of an organization. This includes every repository on every team that the user is on
    string affiliation = "owner,collaborator,organization_member";
    # Only show repositories updated before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string before?;
    # The property to sort the results by
    "created"|"updated"|"pushed"|"full_name" sort = "full_name";
    # Page number of the results to fetch
    int page = 1;
    # Limit results to repositories of the specified type. Will cause a `422` error if used in the same request as **visibility** or **affiliation**
    "all"|"owner"|"public"|"private"|"member" 'type = "all";
    # The order to sort by. Default: `asc` when using `full_name`, otherwise `desc`
    "asc"|"desc" direction?;
    # Only show repositories updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string since?;
};

# Represents the Queries record for the operation: pulls/list-review-comments-for-repo
public type PullsListReviewCommentsForRepoQueries record {
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    "created"|"updated"|"created_at" sort?;
    # Page number of the results to fetch
    int page = 1;
    # The direction to sort results. Ignored without `sort` parameter
    "asc"|"desc" direction?;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
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
    string[] website?;
    string[] copilot?;
    string[] codespaces?;
    string[] packages?;
};

# A Dependabot alert
public type DependabotAlert record {|
    DependabotAlertWithRepositoryDependency dependency;
    @jsondata:Name {value: "security_advisory"}
    DependabotAlertSecurityAdvisory securityAdvisory;
    @jsondata:Name {value: "security_vulnerability"}
    DependabotAlertSecurityVulnerability securityVulnerability;
    @jsondata:Name {value: "created_at"}
    AlertCreatedAt createdAt;
    # An optional comment associated with the alert's dismissal
    @jsondata:Name {value: "dismissed_comment"}
    string? dismissedComment;
    @jsondata:Name {value: "auto_dismissed_at"}
    AlertAutoDismissedAt? autoDismissedAt?;
    AlertUrl url;
    AlertNumber number;
    @jsondata:Name {value: "updated_at"}
    AlertUpdatedAt updatedAt;
    @jsondata:Name {value: "html_url"}
    AlertHtmlUrl htmlUrl;
    @jsondata:Name {value: "fixed_at"}
    AlertFixedAt? fixedAt;
    # The state of the Dependabot alert
    "auto_dismissed"|"dismissed"|"fixed"|"open" state;
    @jsondata:Name {value: "dismissed_by"}
    NullableSimpleUser? dismissedBy;
    # The reason that the alert was dismissed
    @jsondata:Name {value: "dismissed_reason"}
    "fix_started"|"inaccurate"|"no_bandwidth"|"not_used"|"tolerable_risk"? dismissedReason;
    @jsondata:Name {value: "dismissed_at"}
    AlertDismissedAt? dismissedAt;
|};

# Team Organization
public type TeamOrganization record {
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    @jsondata:Name {value: "members_can_create_internal_repositories"}
    boolean membersCanCreateInternalRepositories?;
    @jsondata:Name {value: "members_can_create_public_pages"}
    boolean membersCanCreatePublicPages?;
    string blog?;
    string 'type;
    @jsondata:Name {value: "public_members_url"}
    string publicMembersUrl;
    @jsondata:Name {value: "private_gists"}
    int? privateGists?;
    @jsondata:Name {value: "default_repository_permission"}
    string? defaultRepositoryPermission?;
    @jsondata:Name {value: "billing_email"}
    string? billingEmail?;
    @jsondata:Name {value: "disk_usage"}
    int? diskUsage?;
    int? collaborators?;
    int id;
    OrganizationFullPlan plan?;
    @jsondata:Name {value: "members_can_create_private_pages"}
    boolean membersCanCreatePrivatePages?;
    @jsondata:Name {value: "members_can_create_repositories"}
    boolean? membersCanCreateRepositories?;
    @jsondata:Name {value: "members_can_create_private_repositories"}
    boolean membersCanCreatePrivateRepositories?;
    @jsondata:Name {value: "public_gists"}
    int publicGists;
    int followers;
    @jsondata:Name {value: "has_organization_projects"}
    boolean hasOrganizationProjects;
    int following;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    string name?;
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    @jsondata:Name {value: "has_repository_projects"}
    boolean hasRepositoryProjects;
    @jsondata:Name {value: "members_url"}
    string membersUrl;
    @jsondata:Name {value: "twitter_username"}
    string? twitterUsername?;
    string? description;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    string login;
    @jsondata:Name {value: "total_private_repos"}
    int totalPrivateRepos?;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "members_allowed_repository_creation_type"}
    string membersAllowedRepositoryCreationType?;
    @jsondata:Name {value: "members_can_fork_private_repositories"}
    boolean? membersCanForkPrivateRepositories?;
    string company?;
    @jsondata:Name {value: "owned_private_repos"}
    int ownedPrivateRepos?;
    @jsondata:Name {value: "public_repos"}
    int publicRepos;
    string email?;
    @jsondata:Name {value: "two_factor_requirement_enabled"}
    boolean? twoFactorRequirementEnabled?;
    @jsondata:Name {value: "archived_at"}
    string? archivedAt;
    @jsondata:Name {value: "is_verified"}
    boolean isVerified?;
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    string url;
    @jsondata:Name {value: "members_can_create_public_repositories"}
    boolean membersCanCreatePublicRepositories?;
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "members_can_create_pages"}
    boolean membersCanCreatePages?;
    string location?;
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

# Represents the Queries record for the operation: issues/list-for-authenticated-user
public type IssuesListForAuthenticatedUserQueries record {
    # Indicates which sorts of issues to return. `assigned` means issues assigned to you. `created` means issues created by you. `mentioned` means issues mentioning you. `subscribed` means issues you're subscribed to updates for. `all` or `repos` means all issues you can see, regardless of participation or creation
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
    # A list of comma separated label names. Example: `bug,ui,@high`
    string labels?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
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
    NullableSimpleUser? actor;
    # The full Git reference, formatted as `refs/heads/<branch name>`
    string ref;
    # The SHA of the commit before the activity
    string before;
    # The type of the activity that was performed
    @jsondata:Name {value: "activity_type"}
    "push"|"force_push"|"branch_deletion"|"branch_creation"|"pr_merge"|"merge_queue_merge" activityType;
    int id;
    # The SHA of the commit after the activity
    string after;
    @jsondata:Name {value: "node_id"}
    string nodeId;
    # The time when the activity occurred
    string timestamp;
};

public type ProjectsprojectIdBody2 record {
    # The permission to grant to the team for this project. Default: the team's `permission` attribute will be used to determine what permission to grant the team on this project. Note that, if you choose not to pass any parameters, you'll need to set `Content-Length` to zero when calling this endpoint. For more information, see "[HTTP verbs](https://docs.github.com/rest/overview/resources-in-the-rest-api#http-verbs)."
    "read"|"write"|"admin" permission?;
};

public type RepositoryTemplateRepositoryPermissions record {
    boolean pull?;
    boolean maintain?;
    boolean admin?;
    boolean triage?;
    boolean push?;
};

public type CommitCommit record {
    @jsondata:Name {value: "comment_count"}
    int commentCount;
    NullableGitUser? committer;
    NullableGitUser? author;
    CommitCommitTree tree;
    string message;
    string url;
    Verification verification?;
};

public type BaseGistFiles record {
    string filename?;
    int size?;
    string language?;
    string 'type?;
    @jsondata:Name {value: "raw_url"}
    string rawUrl?;
};

public type HookIdConfigBody record {|
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    WebhookConfigSecret secret?;
    WebhookConfigUrl url?;
|};

# Issue Event
public type IssueEvent record {
    @jsondata:Name {value: "requested_team"}
    Team requestedTeam?;
    @jsondata:Name {value: "dismissed_review"}
    IssueEventDismissedReview dismissedReview?;
    NullableIssue? issue?;
    @jsondata:Name {value: "lock_reason"}
    string? lockReason?;
    NullableSimpleUser? assigner?;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    @jsondata:Name {value: "requested_reviewer"}
    NullableSimpleUser? requestedReviewer?;
    IssueEventLabel label?;
    string url;
    @jsondata:Name {value: "project_card"}
    IssueEventProjectCard projectCard?;
    NullableSimpleUser? actor;
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation?;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "review_requester"}
    NullableSimpleUser? reviewRequester?;
    IssueEventMilestone milestone?;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    IssueEventRename rename?;
    int id;
    NullableSimpleUser? assignee?;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Timeline Comment Event
public type TimelineCommentEvent record {
    @jsondata:Name {value: "issue_url"}
    string issueUrl;
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Contents of the issue comment
    string body?;
    # URL for the issue comment
    string url;
    SimpleUser actor;
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    ReactionRollup reactions?;
    # Unique identifier of the issue comment
    int id;
    string event;
    SimpleUser user;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Timeline Line Commented Event
public type TimelineLineCommentedEvent record {
    PullRequestReviewComment[] comments?;
    string event?;
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
    string[]? references;
    # The API URL for the repository advisory
    @jsondata:Name {value: "repository_advisory_url"}
    string? repositoryAdvisoryUrl;
    GlobalAdvisoryIdentifiers[]? identifiers;
    # A detailed description of what the advisory entails
    string? description;
    # The type of advisory
    "reviewed"|"unreviewed"|"malware" 'type;
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
    GlobalAdvisoryCvss? cvss;
|};

public type TeamProjectPermissions record {
    boolean read;
    boolean admin;
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
    WorkflowUsageBillable billable;
};

public type ReposownerrepogittreesTree record {
    # The file mode; one of `100644` for file (blob), `100755` for executable (blob), `040000` for subdirectory (tree), `160000` for submodule (commit), or `120000` for a blob that specifies the path of a symlink
    "100644"|"100755"|"040000"|"160000"|"120000" mode?;
    # The file referenced in the tree
    string path?;
    # Either `blob`, `tree`, or `commit`
    "blob"|"tree"|"commit" 'type?;
    # The SHA1 checksum ID of the object in the tree. Also called `tree.sha`. If the value is `null` then the file will be deleted.  
    #   
    # **Note:** Use either `tree.sha` or `content` to specify the contents of the entry. Using both `tree.sha` and `content` will return an error
    string? sha?;
    # The content you want this file to have. GitHub will write this blob out and use that SHA for this entry. Use either this, or `tree.sha`.  
    #   
    # **Note:** Use either `tree.sha` or `content` to specify the contents of the entry. Using both `tree.sha` and `content` will return an error
    string content?;
};

public type AlertsalertNumberBody record {
    @jsondata:Name {value: "dismissed_comment"}
    CodeScanningAlertDismissedComment? dismissedComment?;
    CodeScanningAlertSetState state;
    @jsondata:Name {value: "dismissed_reason"}
    CodeScanningAlertDismissedReason? dismissedReason?;
};

# A GitHub Actions workflow
public type Workflow record {
    @jsondata:Name {value: "badge_url"}
    string badgeUrl;
    string path;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    string name;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    "active"|"deleted"|"disabled_fork"|"disabled_inactivity"|"disabled_manually" state;
    @jsondata:Name {value: "deleted_at"}
    string deletedAt?;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type BranchProtectionRequiredLinearHistory record {
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

# Information about the person who is making the commit. By default, `committer` will use the information set in `author`. See the `author` and `committer` object below for details
public type ReposownerrepogitcommitsCommitter record {
    # Indicates when this commit was authored (or committed). This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
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
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    @jsondata:Name {value: "members_can_create_internal_repositories"}
    boolean membersCanCreateInternalRepositories?;
    # An optional URL string to display to contributors who are blocked from pushing a secret
    @jsondata:Name {value: "secret_scanning_push_protection_custom_link"}
    string? secretScanningPushProtectionCustomLink?;
    @jsondata:Name {value: "members_can_create_public_pages"}
    boolean membersCanCreatePublicPages?;
    string blog?;
    string 'type;
    @jsondata:Name {value: "public_members_url"}
    string publicMembersUrl;
    @jsondata:Name {value: "private_gists"}
    int? privateGists?;
    @jsondata:Name {value: "default_repository_permission"}
    string? defaultRepositoryPermission?;
    @jsondata:Name {value: "billing_email"}
    string? billingEmail?;
    @jsondata:Name {value: "disk_usage"}
    int? diskUsage?;
    int? collaborators?;
    int id;
    # Whether secret scanning push protection is automatically enabled for new repositories and repositories
    # transferred to this organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role
    @jsondata:Name {value: "secret_scanning_push_protection_enabled_for_new_repositories"}
    boolean secretScanningPushProtectionEnabledForNewRepositories?;
    OrganizationFullPlan plan?;
    @jsondata:Name {value: "members_can_create_private_pages"}
    boolean membersCanCreatePrivatePages?;
    @jsondata:Name {value: "members_can_create_repositories"}
    boolean? membersCanCreateRepositories?;
    @jsondata:Name {value: "members_can_create_private_repositories"}
    boolean membersCanCreatePrivateRepositories?;
    @jsondata:Name {value: "public_gists"}
    int publicGists;
    int followers;
    @jsondata:Name {value: "has_organization_projects"}
    boolean hasOrganizationProjects;
    int following;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    string name?;
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
    @jsondata:Name {value: "has_repository_projects"}
    boolean hasRepositoryProjects;
    @jsondata:Name {value: "members_url"}
    string membersUrl;
    @jsondata:Name {value: "twitter_username"}
    string? twitterUsername?;
    string? description;
    # Whether GitHub Advanced Security is enabled for new repositories and repositories transferred to this organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role
    @jsondata:Name {value: "advanced_security_enabled_for_new_repositories"}
    boolean advancedSecurityEnabledForNewRepositories?;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    string login;
    # Whether dependency graph is automatically enabled for new repositories and repositories transferred to this
    # organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role
    @jsondata:Name {value: "dependency_graph_enabled_for_new_repositories"}
    boolean dependencyGraphEnabledForNewRepositories?;
    @jsondata:Name {value: "total_private_repos"}
    int totalPrivateRepos?;
    # Whether secret scanning is automatically enabled for new repositories and repositories transferred to this
    # organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role
    @jsondata:Name {value: "secret_scanning_enabled_for_new_repositories"}
    boolean secretScanningEnabledForNewRepositories?;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "members_allowed_repository_creation_type"}
    string membersAllowedRepositoryCreationType?;
    @jsondata:Name {value: "members_can_fork_private_repositories"}
    boolean? membersCanForkPrivateRepositories?;
    string? company?;
    @jsondata:Name {value: "owned_private_repos"}
    int ownedPrivateRepos?;
    @jsondata:Name {value: "public_repos"}
    int publicRepos;
    string? email?;
    @jsondata:Name {value: "two_factor_requirement_enabled"}
    boolean? twoFactorRequirementEnabled?;
    @jsondata:Name {value: "archived_at"}
    string? archivedAt;
    @jsondata:Name {value: "is_verified"}
    boolean isVerified?;
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired?;
    string url;
    @jsondata:Name {value: "members_can_create_public_repositories"}
    boolean membersCanCreatePublicRepositories?;
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "members_can_create_pages"}
    boolean membersCanCreatePages?;
    string location?;
    # Whether a custom link is shown to contributors who are blocked from pushing a secret by push protection
    @jsondata:Name {value: "secret_scanning_push_protection_custom_link_enabled"}
    boolean secretScanningPushProtectionCustomLinkEnabled?;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type PagesSourceHash record {
    string path;
    string branch;
};

public type MarkdownBody record {
    # The rendering mode
    "markdown"|"gfm" mode = "markdown";
    # The repository context to use when creating references in `gfm` mode.  For example, setting `context` to `octo-org/octo-repo` will change the text `#42` into an HTML link to issue 42 in the `octo-org/octo-repo` repository
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
    @jsondata:Name {value: "read_only"}
    boolean readOnly;
    boolean verified;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string title;
    string 'key;
    string url;
};

# The type of deployment branch policy for this environment. To allow all branches to deploy, set to `null`
public type DeploymentBranchPolicySettings record {
    # Whether only branches that match the specified name patterns can deploy to this environment.  If `custom_branch_policies` is `true`, `protected_branches` must be `false`; if `custom_branch_policies` is `false`, `protected_branches` must be `true`
    @jsondata:Name {value: "custom_branch_policies"}
    boolean customBranchPolicies;
    # Whether only branches with branch protection rules can deploy to this environment. If `protected_branches` is `true`, `custom_branch_policies` must be `false`; if `protected_branches` is `false`, `custom_branch_policies` must be `true`
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
    "creation" 'type;
};

public type ProjectsprojectIdBody record {
    # The permission to grant to the team for this project. Default: the team's `permission` attribute will be used to determine what permission to grant the team on this project. Note that, if you choose not to pass any parameters, you'll need to set `Content-Length` to zero when calling this endpoint. For more information, see "[HTTP verbs](https://docs.github.com/rest/overview/resources-in-the-rest-api#http-verbs)."
    "read"|"write"|"admin" permission?;
};

# User-defined metadata to store domain-specific information limited to 8 keys with scalar values
public type Metadata record {
};

# Short Branch
public type ShortBranch record {
    boolean protected;
    string name;
    ShortBranchCommit 'commit;
    BranchProtection protection?;
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
    # Filters jobs by their `completed_at` timestamp. `latest` returns jobs from the most recent execution of the workflow run. `all` returns all jobs for a workflow run, including from old executions of the workflow run
    "latest"|"all" filter = "latest";
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Page number of the results to fetch
    int page = 1;
};

# A list of errors found in a repo's CODEOWNERS file
public type CodeownersErrors record {
    CodeownersErrorsErrors[] errors;
};

public type ShortBranchCommit record {
    string sha;
    string url;
};

# Issue Event for Issue
public type IssueEventForIssue LabeledIssueEvent|UnlabeledIssueEvent|AssignedIssueEvent|UnassignedIssueEvent|MilestonedIssueEvent|DemilestonedIssueEvent|RenamedIssueEvent|ReviewRequestedIssueEvent|ReviewRequestRemovedIssueEvent|ReviewDismissedIssueEvent|LockedIssueEvent|AddedToProjectIssueEvent|MovedColumnInProjectIssueEvent|RemovedFromProjectIssueEvent|ConvertedNoteToIssueIssueEvent;

public type AssetsassetIdBody record {
    # The file name of the asset
    string name?;
    # An alternate short description of the asset. Used in place of the filename
    string label?;
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
    # The [hexadecimal color code](http://www.color-hex.com/) for the label, without the leading `#`
    string color?;
    # The name of the label. Emoji can be added to label names, using either native emoji or colon-style markup. For example, typing `:strawberry:` will render the emoji ![:strawberry:](https://github.githubassets.com/images/icons/emoji/unicode/1f353.png ":strawberry:"). For a full list of available emoji and codes, see "[Emoji cheat sheet](https://github.com/ikatyang/emoji-cheat-sheet)."
    string name;
    # A short description of the label. Must be 100 characters or fewer
    string description?;
};

# Configuration object of the webhook
public type WebhookConfig record {
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    WebhookConfigSecret secret?;
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
    # An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the `visibility` is set to `selected`. You can manage the list of selected repositories using the [List selected repositories for an organization secret](https://docs.github.com/rest/actions/secrets#list-selected-repositories-for-an-organization-secret), [Set selected repositories for an organization secret](https://docs.github.com/rest/actions/secrets#set-selected-repositories-for-an-organization-secret), and [Remove selected repository from an organization secret](https://docs.github.com/rest/actions/secrets#remove-selected-repository-from-an-organization-secret) endpoints
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds?;
    # Which type of organization repositories have access to the organization secret. `selected` means only the repositories specified by `selected_repository_ids` can access the secret
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
    NullableTeamSimple? parent;
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
    @jsondata:Name {value: "members_url"}
    string membersUrl;
    string? description;
    string privacy?;
    string permission;
    string url;
    @jsondata:Name {value: "notification_setting"}
    string notificationSetting?;
    TeamPermissions permissions?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    string name;
    int id;
    string slug;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# A GitHub organization
public type SimpleClassroomOrganization record {
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    string? name;
    int id;
    string login;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Represents the Queries record for the operation: actions/get-workflow-run
public type ActionsGetWorkflowRunQueries record {
    # If `true` pull requests are omitted from the response (empty array)
    @http:Query {name: "exclude_pull_requests"}
    boolean excludePullRequests = false;
};

public type SnapshotJob record {|
    # Correlator provides a key that is used to group snapshots submitted over time. Only the "latest" submitted snapshot for a given combination of `job.correlator` and `detector.name` will be considered when calculating a repository's current dependencies. Correlator should be as unique as it takes to distinguish all detection runs for a given "wave" of CI workflow you run. If you're using GitHub Actions, a good default value for this could be the environment variables GITHUB_WORKFLOW and GITHUB_JOB concatenated together. If you're using a build matrix, then you'll also need to add additional key(s) to distinguish between each submission inside a matrix variation
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
    # The level of privacy this team should have. Editing teams without specifying this parameter leaves `privacy` intact. The options are:  
    # **For a non-nested team:**  
    #  * `secret` - only visible to organization owners and members of this team.  
    #  * `closed` - visible to all members of this organization.  
    # **For a parent or child team:**  
    #  * `closed` - visible to all members of this organization
    "secret"|"closed" privacy?;
    # **Deprecated**. The permission that new repositories will be added to the team with when none is specified
    "pull"|"push"|"admin" permission = "pull";
    # The notification setting the team has chosen. Editing teams without specifying this parameter leaves `notification_setting` intact. The options are: 
    #  * `notifications_enabled` - team members receive notifications when the team is @mentioned.  
    #  * `notifications_disabled` - no one receives notifications
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
    "deletion" 'type;
};

# Represents the Queries record for the operation: actions/list-workflow-runs
public type ActionsListWorkflowRunsQueries record {
    # Returns someone's workflow runs. Use the login for the user who created the `push` associated with the check suite or workflow run
    string actor?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Returns workflow runs with the `check_suite_id` that you specify
    @http:Query {name: "check_suite_id"}
    int checkSuiteId?;
    # Returns workflow runs created within the given date-time range. For more information on the syntax, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    string created?;
    # If `true` pull requests are omitted from the response (empty array)
    @http:Query {name: "exclude_pull_requests"}
    boolean excludePullRequests = false;
    # Page number of the results to fetch
    int page = 1;
    # Returns workflow run triggered by the event you specify. For example, `push`, `pull_request` or `issue`. For more information, see "[Events that trigger workflows](https://docs.github.com/actions/automating-your-workflow-with-github-actions/events-that-trigger-workflows)."
    string event?;
    # Returns workflow runs associated with a branch. Use the name of the branch of the `push`
    string branch?;
    # Only returns workflow runs that are associated with the specified `head_sha`
    @http:Query {name: "head_sha"}
    string headSha?;
    # Returns workflow runs with the check run `status` or `conclusion` that you specify. For example, a conclusion can be `success` or a status can be `in_progress`. Only GitHub can set a status of `waiting` or `requested`
    "completed"|"action_required"|"cancelled"|"failure"|"neutral"|"skipped"|"stale"|"success"|"timed_out"|"in_progress"|"queued"|"requested"|"waiting"|"pending" status?;
};

# Porter Author
public type PorterAuthor record {
    @jsondata:Name {value: "remote_name"}
    string remoteName;
    @jsondata:Name {value: "remote_id"}
    string remoteId;
    @jsondata:Name {value: "import_url"}
    string importUrl;
    string name;
    int id;
    string email;
    string url;
};

public type UserSocialAccountsBody1 record {
    # Full URLs for the social media profiles to delete
    @jsondata:Name {value: "account_urls"}
    string[] accountUrls;
};

# Reactions to conversations provide a way to help people express their feelings more simply and effectively
public type Reaction record {
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    NullableSimpleUser? user;
    # The reaction to use
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# A collection of related issues and pull requests
public type NullableMilestone record {
    NullableSimpleUser? creator;
    @jsondata:Name {value: "closed_at"}
    string? closedAt;
    string? description;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The title of the milestone
    string title;
    @jsondata:Name {value: "closed_issues"}
    int closedIssues;
    string url;
    @jsondata:Name {value: "due_on"}
    string? dueOn;
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # The number of the milestone
    int number;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    int id;
    # The state of the milestone
    "open"|"closed" state = "open";
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Pull Request Review Comments are comments on a portion of the Pull Request's diff
public type PullRequestReviewComment record {
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    # The SHA of the original commit to which the comment applies
    @jsondata:Name {value: "original_commit_id"}
    string originalCommitId;
    @jsondata:Name {value: "_links"}
    PullRequestReviewCommentLinks links;
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
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The first line of the range for a multi-line comment
    @jsondata:Name {value: "start_line"}
    int? startLine?;
    # The text of the comment
    string body;
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # The relative path of the file to which the comment applies
    string path;
    # The index of the original line in the diff to which the comment applies. This field is deprecated; use `original_line` instead
    @jsondata:Name {value: "original_position"}
    int originalPosition?;
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
    ReactionRollup reactions?;
    # The line index in the diff to which the comment applies. This field is deprecated; use `line` instead
    int position?;
    # The SHA of the commit to which the comment applies
    @jsondata:Name {value: "commit_id"}
    string commitId;
    SimpleUser user;
    # The node ID of the pull request review comment
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# The time that the alert was last updated in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`
public type NullableAlertUpdatedAt string?;

public type ProtectedBranchRequiredPullRequestReviewsBypassPullRequestAllowances record {
    Team[] teams;
    SimpleUser[] users;
    Integration[] apps?;
};

# Gist Commit
public type GistCommit record {
    @jsondata:Name {value: "committed_at"}
    string committedAt;
    @jsondata:Name {value: "change_status"}
    GistHistoryChangeStatus changeStatus;
    string version;
    NullableSimpleUser? user;
    string url;
};

# Only allow users with bypass permission to update matching refs
public type RepositoryRuleUpdate record {
    "update" 'type;
    RepositoryRuleUpdateParameters parameters?;
};

# Page Build
public type PageBuild record {
    int duration;
    NullableSimpleUser? pusher;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    string 'commit;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    PageBuildError 'error;
    string url;
    string status;
};

# Event
public type Event record {
    Actor actor;
    boolean 'public;
    Actor org?;
    EventPayload payload;
    EventRepo repo;
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    string id;
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
    @jsondata:Name {value: "total_count"}
    int totalCount;
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
    @jsondata:Name {value: "credits_detailed"}
    RepositoryAdvisoryCredit[]? creditsDetailed;
    # A detailed description of what the advisory entails
    string? description;
    # The date and time of when the advisory was created, in ISO 8601 format
    @jsondata:Name {value: "created_at"}
    string? createdAt;
    GlobalAdvisoryCwes[]? cwes;
    # The date and time of when the advisory was last updated, in ISO 8601 format
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
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
    RepositoryAdvisoryVulnerability[]? vulnerabilities;
    RepositoryAdvisorySubmission? submission;
    GlobalAdvisoryCvss? cvss;
    # A list of only the CWE IDs
    @jsondata:Name {value: "cwe_ids"}
    string[]? cweIds;
|};

public type HookConfigBody record {
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    WebhookConfigSecret secret?;
    WebhookConfigUrl url?;
};

public type UserMigrationsBody record {
    # Indicates whether metadata should be excluded and only git source should be included for the migration
    @jsondata:Name {value: "exclude_metadata"}
    boolean excludeMetadata?;
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
    # The sort order. `stargazers` will sort by star count
    "newest"|"oldest"|"stargazers"|"watchers" sort = "newest";
    # Page number of the results to fetch
    int page = 1;
};

# Organization variable for GitHub Actions
public type OrganizationActionsVariableResponse record {
    OrganizationActionsVariable[] variables;
    @jsondata:Name {value: "total_count"}
    int totalCount;
};

public type RepoAutolinksBody record {
    # This prefix appended by certain characters will generate a link any time it is found in an issue, pull request, or commit
    @jsondata:Name {value: "key_prefix"}
    string keyPrefix;
    # The URL must contain `<num>` for the reference number. `<num>` matches different characters depending on the value of `is_alphanumeric`
    @jsondata:Name {value: "url_template"}
    string urlTemplate;
    # Whether this autolink reference matches alphanumeric characters. If true, the `<num>` parameter of the `url_template` matches alphanumeric characters `A-Z` (case insensitive), `0-9`, and `-`. If false, this autolink reference only matches numeric characters
    @jsondata:Name {value: "is_alphanumeric"}
    boolean isAlphanumeric = true;
};

# An SSH key granting access to a single repository
public type DeployKey record {
    @jsondata:Name {value: "read_only"}
    boolean readOnly;
    @jsondata:Name {value: "added_by"}
    string? addedBy?;
    @jsondata:Name {value: "last_used"}
    string? lastUsed?;
    boolean verified;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string title;
    string 'key;
    string url;
};

# Parameters for a repository ID condition
public type RepositoryRulesetConditionsRepositoryIdTarget record {
    @jsondata:Name {value: "repository_id"}
    RepositoryRulesetConditionsRepositoryIdTargetRepositoryId repositoryId;
};

# Code Frequency Stat
public type CodeFrequencyStat int[];

# The configuration for GitHub Pages for a repository
public type Page record {
    # Whether the GitHub Pages site is publicly visible. If set to `true`, the site is accessible to anyone on the internet. If set to `false`, the site will only be accessible to users who have at least `read` access to the repository that published the site
    boolean 'public;
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
    # The state of the milestone. Either `open`, `closed`, or `all`
    "open"|"closed"|"all" state = "open";
    # What to sort results by. Either `due_on` or `completeness`
    "due_on"|"completeness" sort = "due_on";
    # Page number of the results to fetch
    int page = 1;
    # The direction of the sort. Either `asc` or `desc`
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
    NullableSimpleUser? creator;
    @jsondata:Name {value: "closed_at"}
    string? closedAt;
    string? description;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The title of the milestone
    string title;
    @jsondata:Name {value: "closed_issues"}
    int closedIssues;
    string url;
    @jsondata:Name {value: "due_on"}
    string? dueOn;
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    # The number of the milestone
    int number;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    int id;
    # The state of the milestone
    "open"|"closed" state = "open";
    @jsondata:Name {value: "open_issues"}
    int openIssues;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Stargazer
public type StargazerResponse StargazerResponseAnyOf1|StargazerResponseStargazerResponseAnyOf12;

public type SecretNameRepositoriesBody1 record {
    # An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the `visibility` is set to `selected`. You can add and remove individual repositories using the [Set selected repositories for an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#set-selected-repositories-for-an-organization-secret) and [Remove selected repository from an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#remove-selected-repository-from-an-organization-secret) endpoints
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds;
};

public type SecretNameRepositoriesBody2 record {
    # An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the `visibility` is set to `selected`. You can add and remove individual repositories using the [Set selected repositories for an organization secret](https://docs.github.com/rest/dependabot/secrets#set-selected-repositories-for-an-organization-secret) and [Remove selected repository from an organization secret](https://docs.github.com/rest/dependabot/secrets#remove-selected-repository-from-an-organization-secret) endpoints
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds;
};

public type SecretNameRepositoriesBody3 record {
    # An array of repository ids for which a codespace can access the secret. You can manage the list of selected repositories using the [List selected repositories for a user secret](https://docs.github.com/rest/codespaces/secrets#list-selected-repositories-for-a-user-secret), [Add a selected repository to a user secret](https://docs.github.com/rest/codespaces/secrets#add-a-selected-repository-to-a-user-secret), and [Remove a selected repository from a user secret](https://docs.github.com/rest/codespaces/secrets#remove-a-selected-repository-from-a-user-secret) endpoints
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds;
};

public type MarketplaceAccount record {
    @jsondata:Name {value: "organization_billing_email"}
    string? organizationBillingEmail?;
    int id;
    string 'type;
    string login;
    string url;
    string? email?;
    @jsondata:Name {value: "node_id"}
    string nodeId?;
};

public type OwnerrepoBody2 record {
    # The permission to grant the team on this repository. If no permission is specified, the team's `permission` attribute will be used to determine what permission to grant the team on this repository
    "pull"|"push"|"admin" permission?;
};

public type OwnerrepoBody1 record {
    # Either `true` to make the repository private or `false` to make it public. Default: `false`.  
    # **Note**: You will get a `422` error if the organization restricts [changing repository visibility](https://docs.github.com/articles/repository-permission-levels-for-an-organization#changing-the-visibility-of-repositories) to organization owners and a non-owner tries to change the value of private
    boolean 'private = false;
    # Either `true` to allow private forks, or `false` to prevent private forks
    @jsondata:Name {value: "allow_forking"}
    boolean allowForking = false;
    # Either `true` to make this repo available as a template repository or `false` to prevent it
    @jsondata:Name {value: "is_template"}
    boolean isTemplate = false;
    # A short description of the repository
    string description?;
    # Either `true` to allow rebase-merging pull requests, or `false` to prevent rebase-merging
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge = true;
    # Either `true` to enable projects for this repository or `false` to disable them. **Note:** If you're creating a repository in an organization that has disabled repository projects, the default is `false`, and if you pass `true`, the API returns an error
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects = true;
    # Whether to archive this repository. `false` will unarchive a previously archived repository
    boolean archived = false;
    # Either `true` to enable the wiki for this repository or `false` to disable it
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki = true;
    # The default value for a merge commit title.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `MERGE_MESSAGE` - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name)
    @jsondata:Name {value: "merge_commit_title"}
    "PR_TITLE"|"MERGE_MESSAGE" mergeCommitTitle?;
    # The default value for a squash merge commit message:
    # 
    # - `PR_BODY` - default to the pull request's body.
    # - `COMMIT_MESSAGES` - default to the branch's commit messages.
    # - `BLANK` - default to a blank commit message
    @jsondata:Name {value: "squash_merge_commit_message"}
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squashMergeCommitMessage?;
    # Either `true` to allow automatically deleting head branches when pull requests are merged, or `false` to prevent automatic deletion
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge = false;
    # Either `true` to allow squash-merging pull requests, or `false` to prevent squash-merging
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge = true;
    # Either `true` to allow merging pull requests with a merge commit, or `false` to prevent merging pull requests with merge commits
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit = true;
    # The visibility of the repository
    "public"|"private" visibility?;
    # Either `true` to always allow a pull request head branch that is behind its base branch to be updated even if it is not required to be up to date before merging, or false otherwise
    @jsondata:Name {value: "allow_update_branch"}
    boolean allowUpdateBranch = false;
    # Either `true` to enable issues for this repository or `false` to disable them
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues = true;
    # Either `true` to require contributors to sign off on web-based commits, or `false` to not require contributors to sign off on web-based commits
    @jsondata:Name {value: "web_commit_signoff_required"}
    boolean webCommitSignoffRequired = false;
    @jsondata:Name {value: "security_and_analysis"}
    ReposownerrepoSecurityAndAnalysis? securityAndAnalysis?;
    # Either `true` to allow auto-merge on pull requests, or `false` to disallow auto-merge
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge = false;
    # Either `true` to allow squash-merge commits to use pull request title, or `false` to use commit message. **This property has been deprecated. Please use `squash_merge_commit_title` instead
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
    # - `PR_TITLE` - default to the pull request's title.
    # - `PR_BODY` - default to the pull request's body.
    # - `BLANK` - default to a blank commit message
    @jsondata:Name {value: "merge_commit_message"}
    "PR_BODY"|"PR_TITLE"|"BLANK" mergeCommitMessage?;
    # The default value for a squash merge commit title:
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `COMMIT_OR_PR_TITLE` - default to the commit's title (if only one commit) or the pull request's title (when more than one commit)
    @jsondata:Name {value: "squash_merge_commit_title"}
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squashMergeCommitTitle?;
    # A URL with more information about the repository
    string homepage?;
};

# Protected Branch Admin Enforced
public type ProtectedBranchAdminEnforced record {
    string url;
    boolean enabled;
};

# The REST API URL of the alert resource
public type AlertUrl string;

# Set secrets for Dependabot
public type DependabotSecret record {
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The name of the secret
    string name;
    @jsondata:Name {value: "created_at"}
    string createdAt;
};

# Issues are a great way to keep track of tasks, enhancements, and bugs for your projects
public type NullableIssue record {
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    SimpleUser[]? assignees?;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Title of the issue
    string title;
    # Contents of the issue
    string? body?;
    Repository repository?;
    @jsondata:Name {value: "closed_by"}
    NullableSimpleUser? closedBy?;
    @jsondata:Name {value: "labels_url"}
    string labelsUrl;
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    # Number uniquely identifying the issue within its repository
    int number;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    boolean draft?;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    @jsondata:Name {value: "active_lock_reason"}
    string? activeLockReason?;
    int id;
    @jsondata:Name {value: "repository_url"}
    string repositoryUrl;
    # State of the issue; either 'open' or 'closed'
    string state;
    boolean locked;
    @jsondata:Name {value: "timeline_url"}
    string timelineUrl?;
    # The reason for the current state
    @jsondata:Name {value: "state_reason"}
    "completed"|"reopened"|"not_planned"? stateReason?;
    @jsondata:Name {value: "pull_request"}
    IssuePullRequest pullRequest?;
    int comments;
    @jsondata:Name {value: "closed_at"}
    string? closedAt;
    # URL for the issue
    string url;
    # Labels to associate with this issue; pass one or more label names to replace the set of labels on this issue; send an empty array to clear all labels from the issue; note that the labels are silently dropped for users without push access to the repository
    NullableIssueLabels[] labels;
    NullableMilestone? milestone;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    ReactionRollup reactions?;
    NullableSimpleUser? assignee;
    NullableSimpleUser? user;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Content Traffic
public type ContentTraffic record {
    string path;
    int count;
    int uniques;
    string title;
};

# The author of the file. Default: The `committer` or the authenticated user if you omit `committer`
public type ReposownerrepocontentspathAuthor record {
    string date?;
    # The name of the author or committer of the commit. You'll receive a `422` status code if `name` is omitted
    string name;
    # The email of the author or committer of the commit. You'll receive a `422` status code if `email` is omitted
    string email;
};

public type TimelineCrossReferencedEventSource record {
    Issue issue?;
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
    @jsondata:Name {value: "free_trial_ends_on"}
    string? freeTrialEndsOn;
    @jsondata:Name {value: "on_free_trial"}
    boolean onFreeTrial;
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    @jsondata:Name {value: "billing_cycle"}
    string billingCycle;
    MarketplaceListingPlan plan;
    @jsondata:Name {value: "unit_count"}
    int? unitCount;
    MarketplaceAccount account;
    @jsondata:Name {value: "next_billing_date"}
    string? nextBillingDate;
};

public type GitTagObject record {
    string 'type;
    string sha;
    string url;
};

# Gist
public type Gist record {
    NullableSimpleUser? owner?;
    anydata[] forks?;
    @jsondata:Name {value: "commits_url"}
    string commitsUrl;
    int comments;
    @jsondata:Name {value: "forks_url"}
    string forksUrl;
    @jsondata:Name {value: "git_push_url"}
    string gitPushUrl;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    string? description;
    boolean truncated?;
    anydata[] history?;
    string url;
    boolean 'public;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    @jsondata:Name {value: "git_pull_url"}
    string gitPullUrl;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl;
    record {|BaseGistFiles...;|} files;
    string id;
    NullableSimpleUser? user;
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
    # Sorts the results of your query by number of `followers` or `repositories`, or when the person `joined` GitHub. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    "followers"|"repositories"|"joined" sort?;
    # Page number of the results to fetch
    int page = 1;
    # Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`
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
    string name;
    @jsondata:Name {value: "client_id"}
    string clientId;
    string url;
};

public type EnvironmentNameDeploymentProtectionRulesBody record {
    # The ID of the custom app that will be enabled on the environment
    @jsondata:Name {value: "integration_id"}
    int integrationId?;
};

# A product affected by the vulnerability detailed in a repository security advisory
public type RepositoryAdvisoryVulnerability record {|
    GlobalAdvisoryPackage? package;
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

public type BranchProtectionRequiredSignatures record {
    string url;
    boolean enabled;
};

# A repository rule with ruleset details
public type RepositoryRuleDetailed RepositoryRuleDetailedOneOf1|RepositoryRuleDetailedRepositoryRuleDetailedOneOf12|RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf123|RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf1234|RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf12345|RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf123456|RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf1234567|RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf12345678|RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf123456789|RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf12345678910|RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf1234567891011|RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf123456789101112|RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf12345678910111213|RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf1234567891011121314;

public type ProtectionRequiredPullRequestReviewsBody record {
    @jsondata:Name {value: "dismissal_restrictions"}
    ReposownerrepobranchesbranchprotectionRequiredPullRequestReviewsDismissalRestrictions dismissalRestrictions?;
    # Specifies the number of reviewers required to approve pull requests. Use a number between 1 and 6 or 0 to not require reviewers
    @jsondata:Name {value: "required_approving_review_count"}
    int requiredApprovingReviewCount?;
    # Blocks merging pull requests until [code owners](https://docs.github.com/articles/about-code-owners/) have reviewed
    @jsondata:Name {value: "require_code_owner_reviews"}
    boolean requireCodeOwnerReviews?;
    # Set to `true` if you want to automatically dismiss approving reviews when someone pushes a new commit
    @jsondata:Name {value: "dismiss_stale_reviews"}
    boolean dismissStaleReviews?;
    @jsondata:Name {value: "bypass_pull_request_allowances"}
    ReposownerrepobranchesbranchprotectionRequiredPullRequestReviewsBypassPullRequestAllowances bypassPullRequestAllowances?;
    # Whether the most recent push must be approved by someone other than the person who pushed it. Default: `false`
    @jsondata:Name {value: "require_last_push_approval"}
    boolean requireLastPushApproval = false;
};

public type PrivateVulnerabilityReportCreate record {|
    # A short summary of the advisory
    @constraint:String {maxLength: 1024}
    string summary;
    # The severity of the advisory. You must choose between setting this field or `cvss_vector_string`
    "critical"|"high"|"medium"|"low"? severity?;
    # The CVSS vector that calculates the severity of the advisory. You must choose between setting this field or `severity`
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

public type RepositoryTemplateRepository record {
    @jsondata:Name {value: "stargazers_count"}
    int stargazersCount?;
    @jsondata:Name {value: "is_template"}
    boolean isTemplate?;
    @jsondata:Name {value: "pushed_at"}
    string pushedAt?;
    @jsondata:Name {value: "subscription_url"}
    string subscriptionUrl?;
    string language?;
    @jsondata:Name {value: "branches_url"}
    string branchesUrl?;
    @jsondata:Name {value: "issue_comment_url"}
    string issueCommentUrl?;
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge?;
    @jsondata:Name {value: "labels_url"}
    string labelsUrl?;
    @jsondata:Name {value: "subscribers_url"}
    string subscribersUrl?;
    RepositoryTemplateRepositoryPermissions permissions?;
    @jsondata:Name {value: "temp_clone_token"}
    string tempCloneToken?;
    @jsondata:Name {value: "releases_url"}
    string releasesUrl?;
    @jsondata:Name {value: "svn_url"}
    string svnUrl?;
    # The default value for a squash merge commit message:
    # 
    # - `PR_BODY` - default to the pull request's body.
    # - `COMMIT_MESSAGES` - default to the branch's commit messages.
    # - `BLANK` - default to a blank commit message
    @jsondata:Name {value: "squash_merge_commit_message"}
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squashMergeCommitMessage?;
    @jsondata:Name {value: "subscribers_count"}
    int subscribersCount?;
    int id?;
    @jsondata:Name {value: "archive_url"}
    string archiveUrl?;
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit?;
    @jsondata:Name {value: "git_refs_url"}
    string gitRefsUrl?;
    @jsondata:Name {value: "forks_url"}
    string forksUrl?;
    string visibility?;
    @jsondata:Name {value: "statuses_url"}
    string statusesUrl?;
    @jsondata:Name {value: "network_count"}
    int networkCount?;
    @jsondata:Name {value: "ssh_url"}
    string sshUrl?;
    @jsondata:Name {value: "full_name"}
    string fullName?;
    int size?;
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge?;
    @jsondata:Name {value: "languages_url"}
    string languagesUrl?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    @jsondata:Name {value: "collaborators_url"}
    string collaboratorsUrl?;
    @jsondata:Name {value: "clone_url"}
    string cloneUrl?;
    string name?;
    @jsondata:Name {value: "pulls_url"}
    string pullsUrl?;
    @jsondata:Name {value: "default_branch"}
    string defaultBranch?;
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl?;
    @jsondata:Name {value: "trees_url"}
    string treesUrl?;
    @jsondata:Name {value: "tags_url"}
    string tagsUrl?;
    boolean 'private?;
    @jsondata:Name {value: "contributors_url"}
    string contributorsUrl?;
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads?;
    @jsondata:Name {value: "notifications_url"}
    string notificationsUrl?;
    @jsondata:Name {value: "open_issues_count"}
    int openIssuesCount?;
    string description?;
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    @jsondata:Name {value: "deployments_url"}
    string deploymentsUrl?;
    @jsondata:Name {value: "keys_url"}
    string keysUrl?;
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects?;
    boolean archived?;
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki?;
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    # The default value for a merge commit title.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `MERGE_MESSAGE` - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name)
    @jsondata:Name {value: "merge_commit_title"}
    "PR_TITLE"|"MERGE_MESSAGE" mergeCommitTitle?;
    @jsondata:Name {value: "comments_url"}
    string commentsUrl?;
    @jsondata:Name {value: "stargazers_url"}
    string stargazersUrl?;
    boolean disabled?;
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge?;
    @jsondata:Name {value: "git_url"}
    string gitUrl?;
    @jsondata:Name {value: "has_pages"}
    boolean hasPages?;
    RepositoryTemplateRepositoryOwner owner?;
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge?;
    @jsondata:Name {value: "commits_url"}
    string commitsUrl?;
    @jsondata:Name {value: "compare_url"}
    string compareUrl?;
    @jsondata:Name {value: "git_commits_url"}
    string gitCommitsUrl?;
    string[] topics?;
    @jsondata:Name {value: "blobs_url"}
    string blobsUrl?;
    @jsondata:Name {value: "allow_update_branch"}
    boolean allowUpdateBranch?;
    @jsondata:Name {value: "git_tags_url"}
    string gitTagsUrl?;
    @jsondata:Name {value: "merges_url"}
    string mergesUrl?;
    @jsondata:Name {value: "downloads_url"}
    string downloadsUrl?;
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues?;
    string url?;
    @jsondata:Name {value: "contents_url"}
    string contentsUrl?;
    @jsondata:Name {value: "mirror_url"}
    string mirrorUrl?;
    @jsondata:Name {value: "milestones_url"}
    string milestonesUrl?;
    @jsondata:Name {value: "teams_url"}
    string teamsUrl?;
    boolean 'fork?;
    @jsondata:Name {value: "issues_url"}
    string issuesUrl?;
    @jsondata:Name {value: "events_url"}
    string eventsUrl?;
    @jsondata:Name {value: "use_squash_pr_title_as_default"}
    boolean useSquashPrTitleAsDefault?;
    @jsondata:Name {value: "issue_events_url"}
    string issueEventsUrl?;
    # The default value for a merge commit message.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `PR_BODY` - default to the pull request's body.
    # - `BLANK` - default to a blank commit message
    @jsondata:Name {value: "merge_commit_message"}
    "PR_BODY"|"PR_TITLE"|"BLANK" mergeCommitMessage?;
    @jsondata:Name {value: "assignees_url"}
    string assigneesUrl?;
    # The default value for a squash merge commit title:
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `COMMIT_OR_PR_TITLE` - default to the commit's title (if only one commit) or the pull request's title (when more than one commit)
    @jsondata:Name {value: "squash_merge_commit_title"}
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squashMergeCommitTitle?;
    @jsondata:Name {value: "watchers_count"}
    int watchersCount?;
    @jsondata:Name {value: "node_id"}
    string nodeId?;
    string homepage?;
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
    CodespaceDefault defaults?;
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
    # The `internal` visibility is only supported for GitHub Packages registries that allow for granular permissions. For other ecosystems `internal` is synonymous with `private`.
    # For the list of GitHub Packages registries that support granular permissions, see "[About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages#granular-permissions-for-userorganization-scoped-packages)."
    "public"|"private"|"internal" visibility?;
    # Page number of the results to fetch
    int page = 1;
    # The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry
    @http:Query {name: "package_type"}
    "npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType;
};

# Page Build Status
public type PageBuildStatus record {
    string url;
    string status;
};

public type DockerMetadata record {
    string[] tag?;
};

public type RepositoryRuleUpdateParameters record {
    # Branch can pull changes from its upstream repository
    @jsondata:Name {value: "update_allows_fetch_and_merge"}
    boolean updateAllowsFetchAndMerge;
};

# Groups of organization members that gives permissions on specified repositories
public type TeamFull record {
    NullableTeamSimple? parent?;
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
    @jsondata:Name {value: "repos_count"}
    int reposCount;
    @jsondata:Name {value: "members_url"}
    string membersUrl;
    string? description;
    # The level of privacy this team should have
    "closed"|"secret" privacy?;
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
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    TeamOrganization organization;
    # Name of the team
    string name;
    @jsondata:Name {value: "members_count"}
    int membersCount;
    # Unique identifier of the team
    int id;
    string slug;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

# Project cards represent a scope of work
public type ProjectCard record {
    @jsondata:Name {value: "column_url"}
    string columnUrl;
    string? note;
    NullableSimpleUser? creator;
    @jsondata:Name {value: "column_name"}
    string columnName?;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    @jsondata:Name {value: "project_url"}
    string projectUrl;
    string url;
    # Whether or not the card is archived
    boolean archived?;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "project_id"}
    string projectId?;
    @jsondata:Name {value: "content_url"}
    string contentUrl?;
    # The project card's ID
    int id;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type PullNumberCodespacesBody record {
    # The geographic area for this codespace. If not specified, the value is assigned by IP. This property replaces `location`, which is being deprecated
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
    # The name of a code scanning tool. Only results by this tool will be listed. You can specify the tool by using either `tool_name` or `tool_guid`, but not both
    @http:Query {name: "tool_name"}
    CodeScanningAnalysisToolName toolName?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The Git reference for the analyses you want to list. The `ref` for a branch can be formatted either as `refs/heads/<branch name>` or simply `<branch name>`. To reference a pull request use `refs/pull/<number>/merge`
    CodeScanningRef ref?;
    # Filter analyses belonging to the same SARIF upload
    @http:Query {name: "sarif_id"}
    CodeScanningAnalysisSarifId sarifId?;
    # Page number of the results to fetch
    int page = 1;
    # The property by which to sort the results
    "created" sort = "created";
    # The GUID of a code scanning tool. Only results by this tool will be listed. Note that some code scanning tools may not include a GUID in their analysis data. You can specify the tool by using either `tool_guid` or `tool_name`, but not both
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
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    # The name of the environment
    string name?;
    # The time that the environment was created, in ISO 8601 format
    @jsondata:Name {value: "created_at"}
    string createdAt?;
    # The id of the environment
    int id?;
    string url?;
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
    NullableSimpleUser? owner;
    @jsondata:Name {value: "archive_url"}
    string archiveUrl?;
    @jsondata:Name {value: "exclude_git_data"}
    boolean excludeGitData;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    @jsondata:Name {value: "exclude_releases"}
    boolean excludeReleases;
    @jsondata:Name {value: "exclude_owner_projects"}
    boolean excludeOwnerProjects;
    @jsondata:Name {value: "lock_repositories"}
    boolean lockRepositories;
    string url;
    @jsondata:Name {value: "exclude_metadata"}
    boolean excludeMetadata;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The repositories included in the migration. Only returned for export migrations
    Repository[] repositories;
    string guid;
    @jsondata:Name {value: "exclude_attachments"}
    boolean excludeAttachments;
    @jsondata:Name {value: "org_metadata_only"}
    boolean orgMetadataOnly;
    # Exclude related items from being returned in the response in order to improve performance of the request. The array can include any of: `"repositories"`
    string[] exclude?;
    int id;
    string state;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf12345678 record {
    *RepositoryRuleRequiredStatusChecks;
    *RepositoryRuleRulesetInfo;
};

# Identifies the variable values associated with the environment in which this analysis was performed
public type CodeScanningAnalysisEnvironment string;

public type RepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedRepositoryRuleDetailedOneOf1234567891011 record {
    *RepositoryRuleCommitAuthorEmailPattern;
    *RepositoryRuleRulesetInfo;
};

public type RepositoryPermissions record {
    boolean pull;
    boolean maintain?;
    boolean admin;
    boolean triage?;
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
    @jsondata:Name {value: "expires_at"}
    string expiresAt?;
    string description;
    # Array of the domain set and its alternate name (if it is configured)
    string[] domains;
    "new"|"authorization_created"|"authorization_pending"|"authorized"|"authorization_revoked"|"issued"|"uploaded"|"approved"|"errored"|"bad_authz"|"destroy_pending"|"dns_changed" state;
};

public type CommitSearchResultItemCommit record {
    @jsondata:Name {value: "comment_count"}
    int commentCount;
    NullableGitUser? committer;
    CommitSearchResultItemCommitAuthor author;
    ShortBranchCommit tree;
    string message;
    string url;
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
    string url;
};

public type ManifestConversions record {
    *Integration;
    *ManifestConversionsAllOf2;
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
    #  * `secret` - only visible to organization owners and members of this team.  
    #  * `closed` - visible to all members of this organization.  
    # Default: `secret`  
    # **For a parent or child team:**  
    #  * `closed` - visible to all members of this organization.  
    # Default for child team: `closed`
    "secret"|"closed" privacy?;
    # **Deprecated**. The permission that new repositories will be added to the team with when none is specified
    "pull"|"push" permission = "pull";
    # The notification setting the team has chosen. The options are:  
    #  * `notifications_enabled` - team members receive notifications when the team is @mentioned.  
    #  * `notifications_disabled` - no one receives notifications.  
    # Default: `notifications_enabled`
    @jsondata:Name {value: "notification_setting"}
    "notifications_enabled"|"notifications_disabled" notificationSetting?;
};

# The media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`
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
    # The result of the rule evaluations for rules with the `active` enforcement status
    "pass"|"fail"|"bypass" result?;
    # The first commit sha before the push evaluation
    @jsondata:Name {value: "before_sha"}
    string beforeSha?;
    # The ref name that the evaluation ran on
    string ref?;
    # The result of the rule evaluations for rules with the `active` and `evaluate` enforcement statuses, demonstrating whether rules would pass or fail if all rules in the rule suite were `active`
    @jsondata:Name {value: "evaluation_result"}
    "pass"|"fail" evaluationResult?;
    # Details on the evaluated rules
    @jsondata:Name {value: "rule_evaluations"}
    RuleSuiteRuleEvaluations[] ruleEvaluations?;
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
    # The name of the repository without the `.git` extension
    @jsondata:Name {value: "repository_name"}
    string repositoryName?;
};

public type ReposownerrepoissuesissueNumberlabelsOneOf11 record {
    # The names of the labels to add to the issue's existing labels. You can pass an empty array to remove all labels. Alternatively, you can pass a single label as a `string` or an `array` of labels directly, but GitHub recommends passing an object with the `labels` key. You can also replace all of the labels for an issue. For more information, see "[Set labels for an issue](https://docs.github.com/rest/issues/labels#set-labels-for-an-issue)."
    @constraint:Array {minLength: 1}
    string[] labels?;
};

# Information about a Copilot for Business seat assignment for a user, team, or organization
public type CopilotSeatDetailsResponse record {
    # Total number of Copilot For Business seats for the organization currently being billed
    @jsondata:Name {value: "total_seats"}
    int totalSeats?;
    CopilotSeatDetails[] seats?;
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
    @jsondata:Name {value: "issue_url"}
    string issueUrl;
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Contents of the issue comment
    string body?;
    # URL for the issue comment
    string url;
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp?;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    ReactionRollup reactions?;
    # Unique identifier of the issue comment
    int id;
    NullableSimpleUser? user;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type LabelsLabelsOneOf12 record {
    string? color?;
    string name?;
    string? description?;
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
    NullableSimpleUser? owner?;
    "private"|"public" visibility;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The name of the package
    string name;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # Unique identifier of the package
    int id;
    @jsondata:Name {value: "package_type"}
    "npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" packageType;
    NullableMinimalRepository? repository?;
    # The number of versions of the package
    @jsondata:Name {value: "version_count"}
    int versionCount;
    string url;
};

# Represents the Queries record for the operation: code-scanning/list-alerts-for-repo
public type CodeScanningListAlertsForRepoQueries record {
    # The name of a code scanning tool. Only results by this tool will be listed. You can specify the tool by using either `tool_name` or `tool_guid`, but not both
    @http:Query {name: "tool_name"}
    CodeScanningAnalysisToolName toolName?;
    # If specified, only code scanning alerts with this severity will be returned
    CodeScanningAlertSeverity severity?;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # The Git reference for the results you want to list. The `ref` for a branch can be formatted either as `refs/heads/<branch name>` or simply `<branch name>`. To reference a pull request use `refs/pull/<number>/merge`
    CodeScanningRef ref?;
    # Page number of the results to fetch
    int page = 1;
    # The property by which to sort the results
    "created"|"updated" sort = "created";
    # If specified, only code scanning alerts with this state will be returned
    CodeScanningAlertStateQuery state?;
    # The GUID of a code scanning tool. Only results by this tool will be listed. Note that some code scanning tools may not include a GUID in their analysis data. You can specify the tool by using either `tool_guid` or `tool_name`, but not both
    @http:Query {name: "tool_guid"}
    CodeScanningAnalysisToolGuid? toolGuid?;
    # The direction to sort the results by
    "asc"|"desc" direction = "desc";
};

public type InvitationsinvitationIdBody record {
    # The permissions that the associated user will have on the repository. Valid values are `read`, `write`, `maintain`, `triage`, and `admin`
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

public type GitCommitVerification record {
    string reason;
    string? signature;
    string? payload;
    boolean verified;
};

public type ReviewDismissedIssueEventDismissedReview record {
    @jsondata:Name {value: "review_id"}
    int reviewId;
    string state;
    @jsondata:Name {value: "dismissal_commit_id"}
    string dismissalCommitId?;
    @jsondata:Name {value: "dismissal_message"}
    string? dismissalMessage;
};

public type ActionsWorkflowAccessToRepository record {
    # Defines the level of access that workflows outside of the repository have to actions and reusable workflows within the
    # repository.
    # 
    # `none` means the access is only possible from workflows in this repository. `user` level access allows sharing across user owned private repos only. `organization` level access allows sharing across the organization
    @jsondata:Name {value: "access_level"}
    "none"|"user"|"organization" accessLevel;
};

# Represents the Queries record for the operation: migrations/get-status-for-org
public type MigrationsGetStatusForOrgQueries record {
    # Exclude attributes from the API response to improve performance
    ("repositories")[] exclude?;
};

public type ManifestConversionsAllOf2 record {
    string client_id;
    string client_secret;
    string? webhook_secret;
    string pem;
};

public type BranchWithProtectionLinks record {
    string self;
    string html;
};

public type CheckRunCheckSuite record {
    int id;
};

public type StargazerResponseAnyOf1 SimpleUser[];

public type IssuesissueNumberBody record {
    # The reason for the state change. Ignored unless `state` is changed
    @jsondata:Name {value: "state_reason"}
    "completed"|"not_planned"|"reopened"? stateReason?;
    string|int? milestone?;
    # Usernames to assign to this issue. Pass one or more user logins to _replace_ the set of assignees on this issue. Send an empty array (`[]`) to clear all assignees from the issue. Only users with push access can set assignees for new issues. Without push access to the repository, assignee changes are silently dropped
    string[] assignees?;
    # Username to assign to this issue. **This field is deprecated.**
    string? assignee?;
    # The open or closed state of the issue
    "open"|"closed" state?;
    # The title of the issue
    string|int? title?;
    # The contents of the issue
    string? body?;
    # Labels to associate with this issue. Pass one or more labels to _replace_ the set of labels on this issue. Send an empty array (`[]`) to clear all labels from the issue. Only users with push access can set labels for issues. Without push access to the repository, label changes are silently dropped
    ReposownerrepoissuesissueNumberLabels[] labels?;
};

# Conditions for an organization ruleset. The conditions object should contain both `repository_name` and `ref_name` properties or both `repository_id` and `ref_name` properties
public type OrgRulesetConditions RepositoryNameAndRefName|RepositoryIdAndRefName;

public type CommitParents record {
    @jsondata:Name {value: "html_url"}
    string htmlUrl?;
    string sha;
    string url;
};

public type PullRequestBase record {
    string ref;
    PullRequestBaseRepo repo;
    string label;
    string sha;
    PullRequestHeadRepoOwner user;
};

# Renamed Issue Event
public type RenamedIssueEvent record {
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    RenamedIssueEventRename rename;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
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
    # - `PR_TITLE` - default to the pull request's title.
    # - `MERGE_MESSAGE` - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name)
    @jsondata:Name {value: "merge_commit_title"}
    "PR_TITLE"|"MERGE_MESSAGE" mergeCommitTitle?;
    # The name of the repository
    string name;
    # The default value for a squash merge commit message:
    # 
    # - `PR_BODY` - default to the pull request's body.
    # - `COMMIT_MESSAGES` - default to the branch's commit messages.
    # - `BLANK` - default to a blank commit message
    @jsondata:Name {value: "squash_merge_commit_message"}
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squashMergeCommitMessage?;
    # Whether to delete head branches when pull requests are merged
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge = false;
    # The default value for a merge commit message.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `PR_BODY` - default to the pull request's body.
    # - `BLANK` - default to a blank commit message
    @jsondata:Name {value: "merge_commit_message"}
    "PR_BODY"|"PR_TITLE"|"BLANK" mergeCommitMessage?;
    # The default value for a squash merge commit title:
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `COMMIT_OR_PR_TITLE` - default to the commit's title (if only one commit) or the pull request's title (when more than one commit)
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
    @jsondata:Name {value: "prevent_self_review"}
    PreventSelfReview preventSelfReview?;
    @jsondata:Name {value: "deployment_branch_policy"}
    DeploymentBranchPolicySettings? deploymentBranchPolicy?;
    @jsondata:Name {value: "wait_timer"}
    WaitTimer waitTimer?;
    # The people or teams that may review jobs that reference the environment. You can list up to six users or teams as reviewers. The reviewers must have at least read access to the repository. Only one of the required reviewers needs to approve the job for it to proceed
    ReposownerrepoenvironmentsenvironmentNameReviewers[]? reviewers?;
|};

public type AlertsalertNumberBody2 record {
    @jsondata:Name {value: "resolution_comment"}
    SecretScanningAlertResolutionComment? resolutionComment?;
    SecretScanningAlertState state;
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
    "non_fast_forward" 'type;
};

public type ProtectedBranchRequiredPullRequestReviews record {
    @jsondata:Name {value: "dismissal_restrictions"}
    ProtectedBranchRequiredPullRequestReviewsDismissalRestrictions dismissalRestrictions?;
    @jsondata:Name {value: "required_approving_review_count"}
    int requiredApprovingReviewCount?;
    @jsondata:Name {value: "require_code_owner_reviews"}
    boolean requireCodeOwnerReviews?;
    @jsondata:Name {value: "dismiss_stale_reviews"}
    boolean dismissStaleReviews?;
    @jsondata:Name {value: "bypass_pull_request_allowances"}
    ProtectedBranchRequiredPullRequestReviewsBypassPullRequestAllowances bypassPullRequestAllowances?;
    # Whether the most recent push must be approved by someone other than the person who pushed it
    @jsondata:Name {value: "require_last_push_approval"}
    boolean requireLastPushApproval = false;
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
    # A `dismissed_reason` must be provided when setting the state to `dismissed`
    "dismissed"|"open" state;
    # **Required when `state` is `dismissed`.** A reason for dismissing the alert
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
    @jsondata:Name {value: "total_count"}
    int totalCount;
    OrganizationActionsSecret[] secrets;
};

public type UseremailsuseremailsuseremailsOneOf123 string;

# A check performed on the code of a given code change
public type CheckRunResponse record {
    @jsondata:Name {value: "check_runs"}
    CheckRun[] checkRuns;
    @jsondata:Name {value: "total_count"}
    int totalCount;
};

# Limit interactions to a specific type of user for a specified duration
public type InteractionLimit record {
    InteractionGroup 'limit;
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
    DependencyGraphSpdxSbomSbomPackages[] packages;
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
    # To return the oldest accounts first, set to `asc`. Ignored without the `sort` parameter
    "asc"|"desc" direction?;
};

# File Commit
public type FileCommit record {
    FileCommitCommit 'commit;
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
    @jsondata:Name {value: "zipball_url"}
    string zipballUrl;
    string name;
    ShortBranchCommit 'commit;
    @jsondata:Name {value: "tarball_url"}
    string tarballUrl;
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
    @jsondata:Name {value: "repositories_url"}
    string repositoriesUrl;
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
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Name of the team
    string name;
    # Unique identifier of the team
    int id;
    string slug;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type DiscussionNumberCommentsBody record {
    # The discussion comment's body text
    string body;
};

public type GitTagTagger record {
    string date;
    string name;
    string email;
};

public type MarketplacePurchaseMarketplacePurchase record {
    @jsondata:Name {value: "is_installed"}
    boolean isInstalled?;
    @jsondata:Name {value: "free_trial_ends_on"}
    string? freeTrialEndsOn?;
    @jsondata:Name {value: "on_free_trial"}
    boolean onFreeTrial?;
    @jsondata:Name {value: "updated_at"}
    string updatedAt?;
    @jsondata:Name {value: "billing_cycle"}
    string billingCycle?;
    MarketplaceListingPlan plan?;
    @jsondata:Name {value: "unit_count"}
    int? unitCount?;
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

# Represents the Queries record for the operation: repos/get-clones
public type ReposGetClonesQueries record {
    # The time frame to display results for
    "day"|"week" per = "day";
};

# Stargazer
public type Stargazer record {
    @jsondata:Name {value: "starred_at"}
    string starredAt;
    NullableSimpleUser? user;
};

# Protected Branch Required Status Check
public type ProtectedBranchRequiredStatusCheck record {
    @jsondata:Name {value: "enforcement_level"}
    string enforcementLevel?;
    ProtectedBranchRequiredStatusCheckChecks[] checks;
    @jsondata:Name {value: "contexts_url"}
    string contextsUrl?;
    string[] contexts;
    boolean strict?;
    string url?;
};

public type OrgReposBody record {
    # Pass `true` to create an initial commit with empty README
    @jsondata:Name {value: "auto_init"}
    boolean autoInit = false;
    # Desired language or platform [.gitignore template](https://github.com/github/gitignore) to apply. Use the name of the template without the extension. For example, "Haskell"
    @jsondata:Name {value: "gitignore_template"}
    string gitignoreTemplate?;
    # Either `true` to allow squash-merging pull requests, or `false` to prevent squash-merging
    @jsondata:Name {value: "allow_squash_merge"}
    boolean allowSquashMerge = true;
    # Either `true` to allow merging pull requests with a merge commit, or `false` to prevent merging pull requests with merge commits
    @jsondata:Name {value: "allow_merge_commit"}
    boolean allowMergeCommit = true;
    # Whether the repository is private
    boolean 'private = false;
    # Whether downloads are enabled
    @jsondata:Name {value: "has_downloads"}
    boolean hasDownloads = true;
    # The visibility of the repository
    "public"|"private" visibility?;
    # Either `true` to make this repo available as a template repository or `false` to prevent it
    @jsondata:Name {value: "is_template"}
    boolean isTemplate = false;
    # A short description of the repository
    string description?;
    # The id of the team that will be granted access to this repository. This is only valid when creating a repository in an organization
    @jsondata:Name {value: "team_id"}
    int teamId?;
    # Either `true` to allow rebase-merging pull requests, or `false` to prevent rebase-merging
    @jsondata:Name {value: "allow_rebase_merge"}
    boolean allowRebaseMerge = true;
    # Either `true` to enable issues for this repository or `false` to disable them
    @jsondata:Name {value: "has_issues"}
    boolean hasIssues = true;
    # Either `true` to enable projects for this repository or `false` to disable them. **Note:** If you're creating a repository in an organization that has disabled repository projects, the default is `false`, and if you pass `true`, the API returns an error
    @jsondata:Name {value: "has_projects"}
    boolean hasProjects = true;
    # Choose an [open source license template](https://choosealicense.com/) that best suits your needs, and then use the [license keyword](https://docs.github.com/articles/licensing-a-repository/#searching-github-by-license-type) as the `license_template` string. For example, "mit" or "mpl-2.0"
    @jsondata:Name {value: "license_template"}
    string licenseTemplate?;
    # Either `true` to enable the wiki for this repository or `false` to disable it
    @jsondata:Name {value: "has_wiki"}
    boolean hasWiki = true;
    # Either `true` to allow auto-merge on pull requests, or `false` to disallow auto-merge
    @jsondata:Name {value: "allow_auto_merge"}
    boolean allowAutoMerge = false;
    # Either `true` to allow squash-merge commits to use pull request title, or `false` to use commit message. **This property has been deprecated. Please use `squash_merge_commit_title` instead
    # 
    # # Deprecated
    @jsondata:Name {value: "use_squash_pr_title_as_default"}
    @deprecated
    boolean useSquashPrTitleAsDefault = false;
    # The default value for a merge commit title.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `MERGE_MESSAGE` - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name)
    @jsondata:Name {value: "merge_commit_title"}
    "PR_TITLE"|"MERGE_MESSAGE" mergeCommitTitle?;
    # The name of the repository
    string name;
    # The default value for a squash merge commit message:
    # 
    # - `PR_BODY` - default to the pull request's body.
    # - `COMMIT_MESSAGES` - default to the branch's commit messages.
    # - `BLANK` - default to a blank commit message
    @jsondata:Name {value: "squash_merge_commit_message"}
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squashMergeCommitMessage?;
    # Either `true` to allow automatically deleting head branches when pull requests are merged, or `false` to prevent automatic deletion. **The authenticated user must be an organization owner to set this property to `true`.**
    @jsondata:Name {value: "delete_branch_on_merge"}
    boolean deleteBranchOnMerge = false;
    # The default value for a merge commit message.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `PR_BODY` - default to the pull request's body.
    # - `BLANK` - default to a blank commit message
    @jsondata:Name {value: "merge_commit_message"}
    "PR_BODY"|"PR_TITLE"|"BLANK" mergeCommitMessage?;
    # The default value for a squash merge commit title:
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `COMMIT_OR_PR_TITLE` - default to the commit's title (if only one commit) or the pull request's title (when more than one commit)
    @jsondata:Name {value: "squash_merge_commit_title"}
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squashMergeCommitTitle?;
    # A URL with more information about the repository
    string homepage?;
};

public type ReviewIdEventsBody record {
    # The body text of the pull request review
    string body?;
    # The review action you want to perform. The review actions include: `APPROVE`, `REQUEST_CHANGES`, or `COMMENT`. When you leave this blank, the API returns _HTTP 422 (Unrecognizable entity)_ and sets the review action state to `PENDING`, which means you will need to re-submit the pull request review using a review action
    "APPROVE"|"REQUEST_CHANGES"|"COMMENT" event;
};

public type SearchResultTextMatchesInner_matches record {
    string text?;
    int[] indices?;
};

# A repository on GitHub
public type RepositoryResponse record {
    @jsondata:Name {value: "repository_selection"}
    string repositorySelection?;
    Repository[] repositories;
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
    # An array of repository ids that can access the organization variable. You can only provide a list of repository ids when the `visibility` is set to `selected`
    @jsondata:Name {value: "selected_repository_ids"}
    int[] selectedRepositoryIds?;
    # The type of repositories in the organization that can access the variable. `selected` means only the repositories specified by `selected_repository_ids` can access the variable
    "all"|"private"|"selected" visibility;
    # The name of the variable
    string name;
    # The value of the variable
    string value;
};

public type PullRequestHeadRepoLicense record {
    string name;
    @jsondata:Name {value: "spdx_id"}
    string? spdxId;
    string 'key;
    string? url;
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
    @jsondata:Name {value: "billable_owner"}
    SimpleUser billableOwner;
    # API URL to start this codespace
    @jsondata:Name {value: "start_url"}
    string startUrl;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # API URL to stop this codespace
    @jsondata:Name {value: "stop_url"}
    string stopUrl;
    FullRepository repository;
    # Last known time this codespace was started
    @jsondata:Name {value: "last_used_at"}
    string lastUsedAt;
    # Whether the codespace was created from a prebuild
    boolean? prebuild;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # When a codespace will be auto-deleted based on the "retention_period_minutes" and "last_used_at"
    @jsondata:Name {value: "retention_expires_at"}
    string? retentionExpiresAt?;
    int id;
    # State of this codespace
    "Unknown"|"Created"|"Queued"|"Provisioning"|"Available"|"Awaiting"|"Unavailable"|"Deleted"|"Moved"|"Shutdown"|"Archived"|"Starting"|"ShuttingDown"|"Failed"|"Exporting"|"Updating"|"Rebuilding" state;
    @jsondata:Name {value: "git_status"}
    CodespaceGitStatus gitStatus;
    # API URL to publish this codespace to a new repository
    @jsondata:Name {value: "publish_url"}
    string? publishUrl?;
    # API URL to access available alternate machine types for this codespace
    @jsondata:Name {value: "machines_url"}
    string machinesUrl;
    SimpleUser owner;
    @jsondata:Name {value: "runtime_constraints"}
    CodespaceRuntimeConstraints runtimeConstraints?;
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
    # An array of topics to add to the repository. Pass one or more topics to _replace_ the set of existing topics. Send an empty array (`[]`) to clear all topics from the repository. **Note:** Topic `names` cannot contain uppercase letters
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

public type OrganizationPlan record {
    @jsondata:Name {value: "private_repos"}
    int privateRepos?;
    @jsondata:Name {value: "filled_seats"}
    int filledSeats?;
    string name?;
    int seats?;
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
    # Uses the ID for the `subject_type` you specified. **Required** when using `subject_type`
    @http:Query {name: "subject_id"}
    string subjectId?;
    # Identifies which additional information you'd like to receive about the person's hovercard. Can be `organization`, `repository`, `issue`, `pull_request`. **Required** when using `subject_id`
    @http:Query {name: "subject_type"}
    "organization"|"repository"|"issue"|"pull_request" subjectType?;
};

public type RepoRulesetsBody record {
    # The actors that can bypass the rules in this ruleset
    @jsondata:Name {value: "bypass_actors"}
    RepositoryRulesetBypassActor[] bypassActors?;
    # The name of the ruleset
    string name;
    RepositoryRuleEnforcement enforcement;
    # An array of rules within the ruleset
    RepositoryRule[] rules?;
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
    @jsondata:Name {value: "head_commit"}
    NullableSimpleCommit? headCommit;
    # The start time of the latest run. Resets on re-run
    @jsondata:Name {value: "run_started_at"}
    string runStartedAt?;
    @jsondata:Name {value: "head_branch"}
    string? headBranch;
    # The URL to the associated check suite
    @jsondata:Name {value: "check_suite_url"}
    string checkSuiteUrl;
    # The URL to the artifacts for the workflow run
    @jsondata:Name {value: "artifacts_url"}
    string artifactsUrl;
    # The event-specific title associated with the run or the run-name if set, or the value of `run-name` if it is set in the workflow
    @jsondata:Name {value: "display_title"}
    string displayTitle;
    # The URL to download the logs for the workflow run
    @jsondata:Name {value: "logs_url"}
    string logsUrl;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The URL to the jobs for the workflow run
    @jsondata:Name {value: "jobs_url"}
    string jobsUrl;
    MinimalRepository repository;
    # The SHA of the head commit that points to the version of the workflow being run
    @jsondata:Name {value: "head_sha"}
    string headSha;
    string? conclusion;
    # The URL to rerun the workflow run
    @jsondata:Name {value: "rerun_url"}
    string rerunUrl;
    # The full path of the workflow
    string path;
    # Pull requests that are open with a `head_sha` or `head_branch` that matches the workflow run. The returned pull requests do not necessarily indicate pull requests that triggered the run
    @jsondata:Name {value: "pull_requests"}
    PullRequestMinimal[]? pullRequests;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    # The URL to the previous attempted run of this workflow, if one exists
    @jsondata:Name {value: "previous_attempt_url"}
    string? previousAttemptUrl?;
    # The ID of the workflow run
    int id;
    @jsondata:Name {value: "head_repository"}
    MinimalRepository headRepository;
    string event;
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
    @jsondata:Name {value: "head_repository_id"}
    int headRepositoryId?;
    # The URL to the workflow run
    string url;
    SimpleUser actor?;
    @jsondata:Name {value: "referenced_workflows"}
    ReferencedWorkflow[]? referencedWorkflows?;
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
    @jsondata:Name {value: "node_id"}
    string nodeId;
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
    string password?;
    @jsondata:Name {value: "content_type"}
    WebhookConfigContentType contentType?;
    @jsondata:Name {value: "insecure_ssl"}
    WebhookConfigInsecureSsl insecureSsl?;
    string digest?;
    string subdomain?;
    WebhookConfigSecret secret?;
    string email?;
    string room?;
    WebhookConfigUrl url?;
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
    int a?;
    int c?;
    int d?;
    int w?;
};

# A GitHub organization
public type OrganizationSimple record {
    @jsondata:Name {value: "issues_url"}
    string issuesUrl;
    @jsondata:Name {value: "repos_url"}
    string reposUrl;
    @jsondata:Name {value: "avatar_url"}
    string avatarUrl;
    @jsondata:Name {value: "events_url"}
    string eventsUrl;
    @jsondata:Name {value: "members_url"}
    string membersUrl;
    string? description;
    int id;
    @jsondata:Name {value: "hooks_url"}
    string hooksUrl;
    string login;
    string url;
    @jsondata:Name {value: "node_id"}
    string nodeId;
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
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # The name of the environment
    string name;
    # Built-in deployment protection rules for the environment
    @jsondata:Name {value: "protection_rules"}
    EnvironmentProtectionRules[] protectionRules?;
    @jsondata:Name {value: "deployment_branch_policy"}
    DeploymentBranchPolicySettings? deploymentBranchPolicy?;
    # The time that the environment was created, in ISO 8601 format
    @jsondata:Name {value: "created_at"}
    string createdAt;
    # The id of the environment
    int id;
    string url;
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
    PullRequestMinimalHead head;
    int number;
    int id;
    string url;
    PullRequestMinimalHead base;
};

public type ReposownerrepoissuesissueNumberlabelsOneOf1 record {
    # The names of the labels to set for the issue. The labels you set replace any existing labels. You can pass an empty array to remove all labels. Alternatively, you can pass a single label as a `string` or an `array` of labels directly, but GitHub recommends passing an object with the `labels` key. You can also add labels to the existing labels for an issue. For more information, see "[Add labels to an issue](https://docs.github.com/rest/issues/labels#add-labels-to-an-issue)."
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
    # If `true`, show notifications marked as read
    boolean all = false;
    # The number of results per page (max 100)
    @http:Query {name: "per_page"}
    int perPage = 30;
    # Only show notifications updated before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
    string before?;
    # If `true`, only shows notifications in which the user is directly participating or mentioned
    boolean participating = false;
    # Page number of the results to fetch
    int page = 1;
    # Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`
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
    @jsondata:Name {value: "body_html"}
    string bodyHtml?;
    @jsondata:Name {value: "_links"}
    TimelineReviewedEventLinks links;
    @jsondata:Name {value: "submitted_at"}
    string submittedAt?;
    @jsondata:Name {value: "body_text"}
    string bodyText?;
    @jsondata:Name {value: "pull_request_url"}
    string pullRequestUrl;
    # The text of the review
    string body;
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    @jsondata:Name {value: "html_url"}
    string htmlUrl;
    # Unique identifier of the review
    int id;
    string state;
    NullableSimpleUser? user;
    # A commit SHA for the review. If the commit object was garbage collected or forcibly deleted, then it no longer exists in Git and this value will be `null`
    @jsondata:Name {value: "commit_id"}
    string? commitId;
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
    # Returns check runs with the specified `name`
    @http:Query {name: "check_name"}
    string checkName?;
    # Page number of the results to fetch
    int page = 1;
    # Filters check suites by GitHub App `id`
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
    @jsondata:Name {value: "total_count"}
    int totalCount;
    @jsondata:Name {value: "incomplete_results"}
    boolean incompleteResults;
    CodeSearchResultItem[] items;
};

@constraint:Array {minLength: 1}
public type ReposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsreposownerrepoissuesissueNumberlabelsOneOf1234 ReposownerrepoissuesissueNumberlabelsLabels[];

# A comment made to a gist
public type GistComment record {
    @jsondata:Name {value: "author_association"}
    AuthorAssociation authorAssociation;
    @jsondata:Name {value: "updated_at"}
    string updatedAt;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    # The comment text
    @constraint:String {maxLength: 65535}
    string body;
    NullableSimpleUser? user;
    string url;
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
    SimpleUser actor;
    @jsondata:Name {value: "commit_url"}
    string? commitUrl;
    @jsondata:Name {value: "performed_via_github_app"}
    NullableIntegration? performedViaGithubApp;
    @jsondata:Name {value: "created_at"}
    string createdAt;
    int id;
    string event;
    @jsondata:Name {value: "commit_id"}
    string? commitId;
    string url;
    @jsondata:Name {value: "project_card"}
    AddedToProjectIssueEventProjectCard projectCard?;
    @jsondata:Name {value: "node_id"}
    string nodeId;
};

public type HookshookIdBody1 record {
    # Determines a list of events to be removed from the list of events that the Hook triggers for
    @jsondata:Name {value: "remove_events"}
    string[] removeEvents?;
    # Determines if notifications are sent when the webhook is triggered. Set to `true` to send notifications
    boolean active = true;
    # Determines a list of events to be added to the list of events that the Hook triggers for
    @jsondata:Name {value: "add_events"}
    string[] addEvents?;
    ReposownerrepohookshookIdConfig config?;
    # Determines what [events](https://docs.github.com/webhooks/event-payloads) the hook is triggered for. This replaces the entire array of events
    string[] events = ["push"];
};

public type ContentDirectoryInner__links record {
    string? git;
    string? html;
    string self;
};

public type GitRefsBody record {
    # The name of the fully qualified reference (ie: `refs/heads/master`). If it doesn't start with 'refs' and have at least two slashes, it will be rejected
    string ref;
    # The SHA1 value for this reference
    string sha;
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

# Parameters to be used for the tag_name_pattern rule
public type RepositoryRuleTagNamePattern record {
    "tag_name_pattern" 'type;
    RepositoryRuleCommitMessagePatternParameters parameters?;
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
    int total;
    ContributorActivityWeeks[] weeks;
    NullableSimpleUser? author;
};

public type TokenScopedBody record {
    # The access token used to authenticate to the GitHub API
    @jsondata:Name {value: "access_token"}
    string accessToken;
    # The list of repository IDs to scope the user access token to. `repository_ids` may not be specified if `repositories` is specified
    @jsondata:Name {value: "repository_ids"}
    int[] repositoryIds?;
    # The list of repository names to scope the user access token to. `repositories` may not be specified if `repository_ids` is specified
    string[] repositories?;
    AppPermissions permissions?;
    # The ID of the user or organization to scope the user access token to. **Required** unless `target` is specified
    @jsondata:Name {value: "target_id"}
    int targetId?;
    # The name of the user or organization to scope the user access token to. **Required** unless `target_id` is specified
    string target?;
};

# Represents the Queries record for the operation: git/get-tree
public type GitGetTreeQueries record {
    # Setting this parameter to any value returns the objects or subtrees referenced by the tree specified in `:tree_sha`. For example, setting `recursive` to any of the following will enable returning objects or subtrees: `0`, `1`, `"true"`, and `"false"`. Omit this parameter to prevent recursively returning objects or subtrees
    string recursive?;
};

public type RenamedIssueEventRename record {
    string 'from;
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
    Classroom classroom;
    # Assignment title
    string title;
    # Whether it's a group assignment or individual assignment
    "individual"|"group" 'type;
    # The link that a student can use to accept the assignment
    @jsondata:Name {value: "invite_link"}
    string inviteLink;
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
    # Filter collaborators returned by their affiliation. `outside` means all outside collaborators of an organization-owned repository. `direct` means all collaborators with permissions to an organization-owned repository, regardless of organization membership status. `all` means all collaborators the authenticated user can see
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
    @jsondata:Name {value: "health_percentage"}
    int healthPercentage;
    @jsondata:Name {value: "updated_at"}
    string? updatedAt;
    string? documentation;
    string? description;
    CommunityProfileFiles files;
    @jsondata:Name {value: "content_reports_enabled"}
    boolean contentReportsEnabled?;
};

# Represents the Queries record for the operation: repos/list-contributors
public type ReposListContributorsQueries record {
    # Set to `1` or `true` to include anonymous contributors in results
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
    # The level of privacy this team should have. Editing teams without specifying this parameter leaves `privacy` intact. When a team is nested, the `privacy` for parent teams cannot be `secret`. The options are:  
    # **For a non-nested team:**  
    #  * `secret` - only visible to organization owners and members of this team.  
    #  * `closed` - visible to all members of this organization.  
    # **For a parent or child team:**  
    #  * `closed` - visible to all members of this organization
    "secret"|"closed" privacy?;
    # **Deprecated**. The permission that new repositories will be added to the team with when none is specified
    "pull"|"push"|"admin" permission = "pull";
    # The notification setting the team has chosen. Editing teams without specifying this parameter leaves `notification_setting` intact. The options are: 
    #  * `notifications_enabled` - team members receive notifications when the team is @mentioned.  
    #  * `notifications_disabled` - no one receives notifications
    @jsondata:Name {value: "notification_setting"}
    "notifications_enabled"|"notifications_disabled" notificationSetting?;
};

public type ClientIdGrantBody record {
    # The OAuth access token used to authenticate to the GitHub API
    @jsondata:Name {value: "access_token"}
    string accessToken;
};
