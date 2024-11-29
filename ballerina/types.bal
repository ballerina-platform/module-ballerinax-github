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
import ballerina/http;

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Configurations related to client authentication
    http:BearerTokenConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
|};

# Provides settings related to HTTP/1.x protocol.
public type ClientHttp1Settings record {|
    # Specifies whether to reuse a connection for multiple requests
    http:KeepAlive keepAlive = http:KEEPALIVE_AUTO;
    # The chunking behaviour of the request
    http:Chunking chunking = http:CHUNKING_AUTO;
    # Proxy server related options
    ProxyConfig proxy?;
|};

# Proxy server configurations to be used with the HTTP client endpoint.
public type ProxyConfig record {|
    # Host name of the proxy server
    string host = "";
    # Proxy server port
    int port = 0;
    # Proxy server username
    string userName = "";
    # Proxy server password
    @display {label: "", kind: "password"}
    string password = "";
|};

public type GlobalAdvisoryArr GlobalAdvisory[];

public type HookDeliveryItemArr HookDeliveryItem[];

public type IntegrationInstallationRequestArr IntegrationInstallationRequest[];

public type InstallationArr Installation[];

public type ClassroomAcceptedAssignmentArr ClassroomAcceptedAssignment[];

public type ClassroomAssignmentGradeArr ClassroomAssignmentGrade[];

public type SimpleClassroomArr SimpleClassroom[];

public type SimpleClassroomAssignmentArr SimpleClassroomAssignment[];

public type CodeOfConductArr CodeOfConduct[];

public type DependabotAlertWithRepositoryArr DependabotAlertWithRepository[];

public type OrganizationSecretScanningAlertArr OrganizationSecretScanningAlert[];

public type EventArr Event[];

public type BaseGistArr BaseGist[];

public type GistCommentArr GistComment[];

public type GistCommitArr GistCommit[];

public type GistSimpleArr GistSimple[];

public type StringArr string[];

public type IssueArr Issue[];

public type LicenseSimpleArr LicenseSimple[];

public type MarketplaceListingPlanArr MarketplaceListingPlan[];

public type MarketplacePurchaseArr MarketplacePurchase[];

public type NotificationThreadArr NotificationThread[];

public type OrganizationSimpleArr OrganizationSimple[];

public type RunnerApplicationArr RunnerApplication[];

public type SimpleUserArr SimpleUser[];

public type CodeScanningOrganizationAlertItemsArr CodeScanningOrganizationAlertItems[];

public type PackageArr Package[];

public type OrganizationInvitationArr OrganizationInvitation[];

public type OrgHookArr OrgHook[];

public type TeamArr Team[];

public type MigrationArr Migration[];

public type MinimalRepositoryArr MinimalRepository[];

public type PackageVersionArr PackageVersion[];

public type OrganizationProgrammaticAccessGrantRequestArr OrganizationProgrammaticAccessGrantRequest[];

public type OrganizationProgrammaticAccessGrantArr OrganizationProgrammaticAccessGrant[];

public type ProjectArr Project[];

public type RepositoryRulesetArr RepositoryRuleset[];

public type RepositoryAdvisoryArr RepositoryAdvisory[];

public type TeamSimpleArr TeamSimple[];

public type TeamDiscussionArr TeamDiscussion[];

public type TeamDiscussionCommentArr TeamDiscussionComment[];

public type ReactionArr Reaction[];

public type TeamProjectArr TeamProject[];

public type ProjectCardArr ProjectCard[];

public type ProjectColumnArr ProjectColumn[];

public type EnvironmentApprovalsArr EnvironmentApprovals[];

public type PendingDeploymentArr PendingDeployment[];

public type DeploymentArr Deployment[];

public type ActivityArr Activity[];

public type AutolinkArr Autolink[];

public type ShortBranchArr ShortBranch[];

public type IntegrationArr Integration[];

public type CheckAnnotationArr CheckAnnotation[];

public type CodeScanningAlertItemsArr CodeScanningAlertItems[];

public type CodeScanningAlertInstanceArr CodeScanningAlertInstance[];

public type CodeScanningAnalysisArr CodeScanningAnalysis[];

public type CodeScanningCodeqlDatabaseArr CodeScanningCodeqlDatabase[];

public type CollaboratorArr Collaborator[];

public type CommitCommentArr CommitComment[];

public type CommitArr Commit[];

public type BranchShortArr BranchShort[];

public type PullRequestSimpleArr PullRequestSimple[];

public type StatusArr Status[];

public type ContentTreeArr ContentTree[];

public type ContributorArr Contributor[];

public type DependabotAlertArr DependabotAlert[];

public type DeploymentStatusArr DeploymentStatus[];

public type GitRefArr GitRef[];

public type HookArr Hook[];

public type PorterAuthorArr PorterAuthor[];

public type PorterLargeFileArr PorterLargeFile[];

public type RepositoryInvitationArr RepositoryInvitation[];

public type IssueCommentArr IssueComment[];

public type IssueEventArr IssueEvent[];

public type IssueEventForIssueArr IssueEventForIssue[];

public type LabelArr Label[];

public type TimelineIssueEventsArr TimelineIssueEvents[];

public type DeployKeyArr DeployKey[];

public type MilestoneArr Milestone[];

public type PageBuildArr PageBuild[];

public type PullRequestReviewCommentArr PullRequestReviewComment[];

public type DiffEntryArr DiffEntry[];

public type PullRequestReviewArr PullRequestReview[];

public type ReviewCommentArr ReviewComment[];

public type ReleaseArr Release[];

public type ReleaseAssetArr ReleaseAsset[];

public type RepositoryRuleDetailedArr RepositoryRuleDetailed[];

public type SecretScanningAlertArr SecretScanningAlert[];

public type SecretScanningLocationArr SecretScanningLocation[];

public type CodeFrequencyStatArr CodeFrequencyStat[];

public type CommitActivityArr CommitActivity[];

public type ContributorActivityArr ContributorActivity[];

public type TagArr Tag[];

public type TagProtectionArr TagProtection[];

public type ContentTrafficArr ContentTraffic[];

public type ReferrerTrafficArr ReferrerTraffic[];

public type EmailArr Email[];

public type GpgKeyArr GpgKey[];

public type KeyArr Key[];

public type UserMarketplacePurchaseArr UserMarketplacePurchase[];

public type OrgMembershipArr OrgMembership[];

public type RepositoryArr Repository[];

public type SocialAccountArr SocialAccount[];

public type SshSigningKeyArr SshSigningKey[];

public type TeamFullArr TeamFull[];

public type KeySimpleArr KeySimple[];

public type Outside_collaborators_username_body record {
    # When set to `true`, the request will be performed asynchronously. Returns a 202 status code when the job is successfully queued.
    boolean async?;
};

public type Release_id_reactions_body record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the release.
    "+1"|"laugh"|"heart"|"hooray"|"rocket"|"eyes" content;
};

public type SecurityAndAnalysis record {
    Securityandanalysis_advanced_security advanced_security?;
    # Enable or disable Dependabot security updates for the repository.
    Securityandanalysis_dependabot_security_updates dependabot_security_updates?;
    Securityandanalysis_advanced_security secret_scanning?;
    Securityandanalysis_advanced_security secret_scanning_push_protection?;
};

# Authentication Token
public type AuthenticationToken record {
    # The token used for authentication
    string token;
    # The time this token expires
    string expires_at;
    record {} permissions?;
    # The repositories this token has access to
    Repository[] repositories?;
    string? single_file?;
    # Describe whether all repositories have been selected or there's a selection involved
    "all"|"selected" repository_selection?;
};

# Code Search Result Item
public type CodeSearchResultItem record {
    string name;
    string path;
    string sha;
    string url;
    string git_url;
    string html_url;
    # Minimal Repository
    MinimalRepository repository;
    decimal score;
    int file_size?;
    string? language?;
    string last_modified_at?;
    string[] line_numbers?;
    SearchResultTextMatches text_matches?;
};

public type Branch_rename_body record {
    # The new name of the branch.
    string new_name;
};

public type Git_trees_body record {
    # Objects (of `path`, `mode`, `type`, and `sha`) specifying a tree structure.
    Reposownerrepogittrees_tree[] tree;
    # The SHA1 of an existing Git tree object which will be used as the base for the new tree. If provided, a new Git tree object will be created from entries in the Git tree object pointed to by `base_tree` and entries defined in the `tree` parameter. Entries defined in the `tree` parameter will overwrite items from `base_tree` with the same `path`. If you're creating new changes on a branch, then normally you'd set `base_tree` to the SHA1 of the Git tree object of the current latest commit on the branch you're working on.
    # If not provided, GitHub will create a new Git tree object from only the entries defined in the `tree` parameter. If you create a new commit pointing to such a tree, then all files which were a part of the parent commit's tree and were not defined in the `tree` parameter will be listed as deleted by the new commit.
    string base_tree?;
};

# Minimal Repository
public type MinimalRepositoryResponse record {
    int total_count;
    MinimalRepository[] repositories;
};

public type Hook_id_config_body_1 record {|
    # The URL to which the payloads will be delivered.
    WebhookConfigUrl url?;
    # The media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`.
    WebhookConfigContentType content_type?;
    # If provided, the `secret` will be used as the `key` to generate the HMAC hex digest value for [delivery signature headers](https://docs.github.com/webhooks/event-payloads/#delivery-headers).
    WebhookConfigSecret secret?;
    WebhookConfigInsecureSsl insecure_ssl?;
|};

# Information about the seat breakdown and policies set for an organization with a Copilot for Business subscription.
public type CopilotOrganizationDetails record {
    # The breakdown of Copilot for Business seats for the organization.
    CopilotSeatBreakdown seat_breakdown;
    # The organization policy for allowing or disallowing Copilot to make suggestions that match public code.
    "allow"|"block"|"unconfigured"|"unknown" public_code_suggestions;
    # The organization policy for allowing or disallowing organization members to use Copilot Chat within their editor.
    "enabled"|"disabled"|"unconfigured" copilot_chat?;
    # The mode of assigning new seats.
    "assign_all"|"assign_selected"|"disabled"|"unconfigured" seat_management_setting;
};

public type Pullrequest_head_repo record {
    string archive_url;
    string assignees_url;
    string blobs_url;
    string branches_url;
    string collaborators_url;
    string comments_url;
    string commits_url;
    string compare_url;
    string contents_url;
    string contributors_url;
    string deployments_url;
    string? description;
    string downloads_url;
    string events_url;
    boolean 'fork;
    string forks_url;
    string full_name;
    string git_commits_url;
    string git_refs_url;
    string git_tags_url;
    string hooks_url;
    string html_url;
    int id;
    string node_id;
    string issue_comment_url;
    string issue_events_url;
    string issues_url;
    string keys_url;
    string labels_url;
    string languages_url;
    string merges_url;
    string milestones_url;
    string name;
    string notifications_url;
    Pullrequest_head_repo_owner owner;
    boolean 'private;
    string pulls_url;
    string releases_url;
    string stargazers_url;
    string statuses_url;
    string subscribers_url;
    string subscription_url;
    string tags_url;
    string teams_url;
    string trees_url;
    string url;
    string clone_url;
    string default_branch;
    int forks;
    int forks_count;
    string git_url;
    boolean has_downloads;
    boolean has_issues;
    boolean has_projects;
    boolean has_wiki;
    boolean has_pages;
    boolean has_discussions;
    string? homepage;
    string? language;
    string master_branch?;
    boolean archived;
    boolean disabled;
    # The repository visibility: public, private, or internal.
    string visibility?;
    string? mirror_url;
    int open_issues;
    int open_issues_count;
    Fullrepository_permissions permissions?;
    string temp_clone_token?;
    boolean allow_merge_commit?;
    boolean allow_squash_merge?;
    boolean allow_rebase_merge?;
    Pullrequest_head_repo_license? license;
    string pushed_at;
    int size;
    string ssh_url;
    int stargazers_count;
    string svn_url;
    string[] topics?;
    int watchers;
    int watchers_count;
    string created_at;
    string updated_at;
    boolean allow_forking?;
    boolean is_template?;
    boolean web_commit_signoff_required?;
};

# Removed from Project Issue Event
public type RemovedFromProjectIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    Addedtoprojectissueevent_project_card project_card?;
};

# A GitHub App that is providing a custom deployment protection rule.
public type CustomDeploymentRuleApp record {
    # The unique identifier of the deployment protection rule integration.
    int id;
    # The slugified name of the deployment protection rule integration.
    string slug;
    # The URL for the endpoint to get details about the app.
    string integration_url;
    # The node ID for the deployment protection rule integration.
    string node_id;
};

# The status of a commit.
public type Status record {
    string url;
    string? avatar_url;
    int id;
    string node_id;
    string state;
    string? description;
    string? target_url;
    string context;
    string created_at;
    string updated_at;
    # A GitHub user.
    NullableSimpleUser? creator;
};

# Api Overview
public type ApiOverview record {
    boolean verifiable_password_authentication;
    Apioverview_ssh_key_fingerprints ssh_key_fingerprints?;
    string[] ssh_keys?;
    string[] hooks?;
    string[] github_enterprise_importer?;
    string[] web?;
    string[] api?;
    string[] git?;
    string[] packages?;
    string[] pages?;
    string[] importer?;
    string[] actions?;
    string[] dependabot?;
    Apioverview_domains domains?;
};

public type Repo_issues_body record {
    # The title of the issue.
    string|int title;
    # The contents of the issue.
    string body?;
    # Login for the user that this issue should be assigned to. _NOTE: Only users with push access can set the assignee for new issues. The assignee is silently dropped otherwise. **This field is deprecated.**_
    string? assignee?;
    string|int? milestone?;
    # Labels to associate with this issue. _NOTE: Only users with push access can set labels for new issues. Labels are silently dropped otherwise._
    (string|record {int id?; string name?; string? description?; string? color?;})[] labels?;
    # Logins for Users to assign to this issue. _NOTE: Only users with push access can set assignees for new issues. Assignees are silently dropped otherwise._
    string[] assignees?;
};

# Review Requested Issue Event
public type ReviewRequestedIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    # A GitHub user.
    SimpleUser review_requester;
    # Groups of organization members that gives permissions on specified repositories.
    Team requested_team?;
    # A GitHub user.
    SimpleUser requested_reviewer?;
};

public type Thread_id_subscription_body record {
    # Whether to block all notifications from a thread.
    boolean ignored?;
};

public type Gitref_object record {
    string 'type;
    # SHA for the reference
    @constraint:String {maxLength: 40, minLength: 40}
    string sha;
    string url;
};

public type Protectedbranch_required_conversation_resolution record {|
    boolean enabled?;
|};

# A GitHub repository view for Classroom
public type SimpleClassroomRepository record {
    # A unique identifier of the repository.
    int id;
    # The full, globally unique name of the repository.
    string full_name;
    # The URL to view the repository on GitHub.com.
    string html_url;
    # The GraphQL identifier of the repository.
    string node_id;
    # Whether the repository is private.
    boolean 'private;
    # The default branch for the repository.
    string default_branch;
};

# User Search Result Item
public type UserSearchResultItemResponse record {
    int total_count;
    boolean incomplete_results;
    UserSearchResultItem[] items;
};

# An artifact
public type ArtifactResponse record {
    int total_count;
    Artifact[] artifacts;
};

public type Branchprotection_required_signatures record {
    string url;
    boolean enabled;
};

public type Timelinecrossreferencedevent_source record {
    string 'type?;
    # Issues are a great way to keep track of tasks, enhancements, and bugs for your projects.
    Issue issue?;
};

public type Inline_response_403_2_errors record {
    string code?;
    string message?;
    string 'resource?;
    string 'field?;
};

# Information about the author of the commit. By default, the `author` will be the authenticated user and the current date. See the `author` and `committer` object below for details.
public type Reposownerrepogitcommits_author record {
    # The name of the author (or committer) of the commit
    string name;
    # The email of the author (or committer) of the commit
    string email;
    # Indicates when this commit was authored (or committed). This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    string date?;
};

# Code of Conduct Simple
public type NullableCodeOfConductSimple record {
    string url;
    string 'key;
    string name;
    string? html_url;
};

# View Traffic
public type ViewTraffic record {
    int count;
    int uniques;
    Traffic[] views;
};

# A description of the machine powering a codespace.
public type CodespaceMachineResponse record {
    int total_count;
    CodespaceMachine[] machines;
};

# Commit Comparison
public type CommitComparison record {
    string url;
    string html_url;
    string permalink_url;
    string diff_url;
    string patch_url;
    # Commit
    Commit base_commit;
    # Commit
    Commit merge_base_commit;
    "diverged"|"ahead"|"behind"|"identical" status;
    int ahead_by;
    int behind_by;
    int total_commits;
    Commit[] commits;
    DiffEntry[] files?;
};

# Details of a deployment branch or tag policy.
public type DeploymentBranchPolicy record {
    # The unique identifier of the branch or tag policy.
    int id?;
    string node_id?;
    # The name pattern that branches or tags must match in order to deploy to the environment.
    string name?;
    # Whether this rule targets a branch or tag.
    "branch"|"tag" 'type?;
};

# A team's access to a project.
public type TeamProject record {
    string owner_url;
    string url;
    string html_url;
    string columns_url;
    int id;
    string node_id;
    string name;
    string? body;
    int number;
    string state;
    # A GitHub user.
    SimpleUser creator;
    string created_at;
    string updated_at;
    # The organization permission for this project. Only present when owner is an organization.
    string organization_permission?;
    # Whether the project is private or not. Only present when owner is an organization.
    boolean 'private?;
    Teamproject_permissions permissions;
};

# Marketplace Listing Plan
public type MarketplaceListingPlan record {
    string url;
    string accounts_url;
    int id;
    int number;
    string name;
    string description;
    int monthly_price_in_cents;
    int yearly_price_in_cents;
    "FREE"|"FLAT_RATE"|"PER_UNIT" price_model;
    boolean has_free_trial;
    string? unit_name;
    string state;
    string[] bullets;
};

public type Protectedbranch_required_pull_request_reviews_bypass_pull_request_allowances record {
    SimpleUser[] users;
    Team[] teams;
    Integration[] apps?;
};

# Full Repository
public type FullRepository record {
    int id;
    string node_id;
    string name;
    string full_name;
    # A GitHub user.
    SimpleUser owner;
    boolean 'private;
    string html_url;
    string? description;
    boolean 'fork;
    string url;
    string archive_url;
    string assignees_url;
    string blobs_url;
    string branches_url;
    string collaborators_url;
    string comments_url;
    string commits_url;
    string compare_url;
    string contents_url;
    string contributors_url;
    string deployments_url;
    string downloads_url;
    string events_url;
    string forks_url;
    string git_commits_url;
    string git_refs_url;
    string git_tags_url;
    string git_url;
    string issue_comment_url;
    string issue_events_url;
    string issues_url;
    string keys_url;
    string labels_url;
    string languages_url;
    string merges_url;
    string milestones_url;
    string notifications_url;
    string pulls_url;
    string releases_url;
    string ssh_url;
    string stargazers_url;
    string statuses_url;
    string subscribers_url;
    string subscription_url;
    string tags_url;
    string teams_url;
    string trees_url;
    string clone_url;
    string? mirror_url;
    string hooks_url;
    string svn_url;
    string? homepage;
    string? language;
    int forks_count;
    int stargazers_count;
    int watchers_count;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0.
    int size;
    string default_branch;
    int open_issues_count;
    boolean is_template?;
    string[] topics?;
    boolean has_issues;
    boolean has_projects;
    boolean has_wiki;
    boolean has_pages;
    boolean has_downloads?;
    boolean has_discussions;
    boolean archived;
    # Returns whether or not this repository disabled.
    boolean disabled;
    # The repository visibility: public, private, or internal.
    string visibility?;
    string pushed_at;
    string created_at;
    string updated_at;
    Fullrepository_permissions permissions?;
    boolean allow_rebase_merge?;
    # A repository on GitHub.
    NullableRepository? template_repository?;
    string? temp_clone_token?;
    boolean allow_squash_merge?;
    boolean allow_auto_merge?;
    boolean delete_branch_on_merge?;
    boolean allow_merge_commit?;
    boolean allow_update_branch?;
    boolean use_squash_pr_title_as_default?;
    # The default value for a squash merge commit title:
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `COMMIT_OR_PR_TITLE` - default to the commit's title (if only one commit) or the pull request's title (when more than one commit).
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squash_merge_commit_title?;
    # The default value for a squash merge commit message:
    # 
    # - `PR_BODY` - default to the pull request's body.
    # - `COMMIT_MESSAGES` - default to the branch's commit messages.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squash_merge_commit_message?;
    # The default value for a merge commit title.
    # 
    #   - `PR_TITLE` - default to the pull request's title.
    #   - `MERGE_MESSAGE` - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name).
    "PR_TITLE"|"MERGE_MESSAGE" merge_commit_title?;
    # The default value for a merge commit message.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `PR_BODY` - default to the pull request's body.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"PR_TITLE"|"BLANK" merge_commit_message?;
    boolean allow_forking?;
    boolean web_commit_signoff_required?;
    int subscribers_count;
    int network_count;
    # License Simple
    NullableLicenseSimple? license;
    # A GitHub user.
    NullableSimpleUser? organization?;
    # A repository on GitHub.
    Repository parent?;
    # A repository on GitHub.
    Repository 'source?;
    int forks;
    string master_branch?;
    int open_issues;
    int watchers;
    # Whether anonymous git access is allowed.
    boolean anonymous_access_enabled = true;
    # Code of Conduct Simple
    CodeOfConductSimple code_of_conduct?;
    SecurityAndAnalysis? security_and_analysis?;
};

public type Globaladvisory_cwes record {
    # The Common Weakness Enumeration (CWE) identifier.
    string cwe_id;
    # The name of the CWE.
    string name;
};

public type Pullrequest_head_repo_owner record {
    string avatar_url;
    string events_url;
    string followers_url;
    string following_url;
    string gists_url;
    string? gravatar_id;
    string html_url;
    int id;
    string node_id;
    string login;
    string organizations_url;
    string received_events_url;
    string repos_url;
    boolean site_admin;
    string starred_url;
    string subscriptions_url;
    string 'type;
    string url;
};

public type Filecommit_commit_parents record {
    string url?;
    string html_url?;
    string sha?;
};

# The duration of the interaction restriction. Default: `one_day`.
public type InteractionExpiry "one_day"|"three_days"|"one_week"|"one_month"|"six_months";

# A link to additional advisory information.
public type Dependabotalertsecurityadvisory_references record {|
    # The URL of the reference.
    string url;
|};

# The name of the package affected by the vulnerability.
public type Repositoryadvisorycreate_package record {
    # The package's language or package management ecosystem.
    SecurityAdvisoryEcosystems ecosystem;
    # The unique package name within its ecosystem.
    string? name?;
};

public type Cwes string|string[];

public type User_emails_body record {
    # Adds one or more email addresses to your GitHub account. Must contain at least one email address. **Note:** Alternatively, you can pass a single email address or an `array` of emails addresses directly, but we recommend that you pass an object using the `emails` key.
    string[] emails;
}|string[]|string;

public type Branch_protection_body record {
    # Require status checks to pass before merging. Set to `null` to disable.
    Reposownerrepobranchesbranchprotection_required_status_checks? required_status_checks;
    # Enforce all configured restrictions for administrators. Set to `true` to enforce required status checks for repository administrators. Set to `null` to disable.
    boolean? enforce_admins;
    # Require at least one approving review on a pull request, before merging. Set to `null` to disable.
    Reposownerrepobranchesbranchprotection_required_pull_request_reviews? required_pull_request_reviews;
    # Restrict who can push to the protected branch. User, app, and team `restrictions` are only available for organization-owned repositories. Set to `null` to disable.
    Reposownerrepobranchesbranchprotection_restrictions? restrictions;
    # Enforces a linear commit Git history, which prevents anyone from pushing merge commits to a branch. Set to `true` to enforce a linear commit history. Set to `false` to disable a linear commit Git history. Your repository must allow squash merging or rebase merging before you can enable a linear commit history. Default: `false`. For more information, see "[Requiring a linear commit history](https://docs.github.com/github/administering-a-repository/requiring-a-linear-commit-history)" in the GitHub Help documentation.
    boolean required_linear_history?;
    # Permits force pushes to the protected branch by anyone with write access to the repository. Set to `true` to allow force pushes. Set to `false` or `null` to block force pushes. Default: `false`. For more information, see "[Enabling force pushes to a protected branch](https://docs.github.com/github/administering-a-repository/enabling-force-pushes-to-a-protected-branch)" in the GitHub Help documentation."
    boolean? allow_force_pushes?;
    # Allows deletion of the protected branch by anyone with write access to the repository. Set to `false` to prevent deletion of the protected branch. Default: `false`. For more information, see "[Enabling force pushes to a protected branch](https://docs.github.com/github/administering-a-repository/enabling-force-pushes-to-a-protected-branch)" in the GitHub Help documentation.
    boolean allow_deletions?;
    # If set to `true`, the `restrictions` branch protection settings which limits who can push will also block pushes which create new branches, unless the push is initiated by a user, team, or app which has the ability to push. Set to `true` to restrict new branch creation. Default: `false`.
    boolean block_creations?;
    # Requires all conversations on code to be resolved before a pull request can be merged into a branch that matches this rule. Set to `false` to disable. Default: `false`.
    boolean required_conversation_resolution?;
    # Whether to set the branch as read-only. If this is true, users will not be able to push to the branch. Default: `false`.
    boolean lock_branch = false;
    # Whether users can pull changes from upstream when the branch is locked. Set to `true` to allow fork syncing. Set to `false` to prevent fork syncing. Default: `false`.
    boolean allow_fork_syncing = false;
};

# Whether GitHub Actions can approve pull requests. Enabling this can be a security risk.
public type ActionsCanApprovePullRequestReviews boolean;

public type Commit_parents record {
    string sha;
    string url;
    string html_url?;
};

# Severity of a code scanning alert.
public type CodeScanningAlertSeverity "critical"|"high"|"medium"|"low"|"warning"|"note"|"error";

public type Org_personalaccesstokens_body record {
    # Action to apply to the fine-grained personal access token.
    "revoke" action;
    # The IDs of the fine-grained personal access tokens.
    @constraint:Array {maxLength: 100, minLength: 1}
    int[] pat_ids;
};

public type Comment_id_replies_body record {
    # The text of the review comment.
    string body;
};

# Deployment protection rule
public type DeploymentProtectionRule record {
    # The unique identifier for the deployment protection rule.
    int id;
    # The node ID for the deployment protection rule.
    string node_id;
    # Whether the deployment protection rule is enabled for the environment.
    boolean enabled;
    # A GitHub App that is providing a custom deployment protection rule.
    CustomDeploymentRuleApp app;
};

# A diff of the dependencies between two commits.
public type DependencyGraphDiff Dependencygraphdiff_inner[];

public type Feed__links record {
    # Hypermedia Link with Type
    LinkWithType timeline;
    # Hypermedia Link with Type
    LinkWithType user;
    # Hypermedia Link with Type
    LinkWithType security_advisories?;
    # Hypermedia Link with Type
    LinkWithType current_user?;
    # Hypermedia Link with Type
    LinkWithType current_user_public?;
    # Hypermedia Link with Type
    LinkWithType current_user_actor?;
    # Hypermedia Link with Type
    LinkWithType current_user_organization?;
    LinkWithType[] current_user_organizations?;
    # Hypermedia Link with Type
    LinkWithType repository_discussions?;
    # Hypermedia Link with Type
    LinkWithType repository_discussions_category?;
};

# The time that the alert was dismissed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
public type AlertDismissedAt string?;

public type Reposownerrepocheckruns_output_annotations record {
    # The path of the file to add an annotation to. For example, `assets/css/main.css`.
    string path;
    # The start line of the annotation. Line numbers start at 1.
    int start_line;
    # The end line of the annotation.
    int end_line;
    # The start column of the annotation. Annotations only support `start_column` and `end_column` on the same line. Omit this parameter if `start_line` and `end_line` have different values. Column numbers start at 1.
    int start_column?;
    # The end column of the annotation. Annotations only support `start_column` and `end_column` on the same line. Omit this parameter if `start_line` and `end_line` have different values.
    int end_column?;
    # The level of the annotation.
    "notice"|"warning"|"failure" annotation_level;
    # A short description of the feedback for these lines of code. The maximum size is 64 KB.
    string message;
    # The title that represents the annotation. The maximum size is 255 characters.
    string title?;
    # Details about this annotation. The maximum size is 64 KB.
    string raw_details?;
};

# Moved Column in Project Issue Event
public type MovedColumnInProjectIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    Addedtoprojectissueevent_project_card project_card?;
};

# The public key used for setting user Codespaces' Secrets.
public type CodespacesUserPublicKey record {
    # The identifier for the key.
    string key_id;
    # The Base64 encoded public key.
    string 'key;
};

# Email
public type Email record {
    string email;
    boolean primary;
    boolean verified;
    string? visibility;
};

# Key Simple
public type KeySimple record {
    int id;
    string 'key;
};

public type Hook_config_body record {
    # The URL to which the payloads will be delivered.
    WebhookConfigUrl url?;
    # The media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`.
    WebhookConfigContentType content_type?;
    # If provided, the `secret` will be used as the `key` to generate the HMAC hex digest value for [delivery signature headers](https://docs.github.com/webhooks/event-payloads/#delivery-headers).
    WebhookConfigSecret secret?;
    WebhookConfigInsecureSsl insecure_ssl?;
};

# Project Collaborator Permission
public type ProjectCollaboratorPermission record {
    string permission;
    # A GitHub user.
    NullableSimpleUser? user;
};

# Whether to set the branch as read-only. If this is true, users will not be able to push to the branch.
public type Branchprotection_lock_branch record {
    boolean enabled?;
};

public type Repo_subscription_body record {
    # Determines if notifications should be received from this repository.
    boolean subscribed?;
    # Determines if all notifications should be blocked from this repository.
    boolean ignored?;
};

public type Reposownerrepoenvironmentsenvironment_name_reviewers record {
    # The type of reviewer.
    DeploymentReviewerType 'type?;
    # The id of the user or team who can review the deployment
    int id?;
};

# Actions OIDC subject customization for a repository
public type ActionsOidcSubjectCustomizationForARepository record {
    # Whether to use the default template or not. If `true`, the `include_claim_keys` field is ignored.
    boolean use_default;
    # Array of unique strings. Each claim key can only contain alphanumeric characters and underscores.
    string[] include_claim_keys?;
};

public type NotificationRead record {
    string message?;
    string url?;
};

# Details of a deployment that is waiting for protection rules to pass
public type PendingDeployment record {
    Pendingdeployment_environment environment;
    # The set duration of the wait timer
    int wait_timer;
    # The time that the wait timer began.
    string? wait_timer_started_at;
    # Whether the currently authenticated user can approve the deployment
    boolean current_user_can_approve;
    # The people or teams that may approve jobs that reference the environment. You can list up to six users or teams as reviewers. The reviewers must have at least read access to the repository. Only one of the required reviewers needs to approve the job for it to proceed.
    Pendingdeployment_reviewers[] reviewers;
};

# The permissions granted to the user access token.
public type AppPermissions record {
    # The level of permission to grant the access token for GitHub Actions workflows, workflow runs, and artifacts.
    "read"|"write" actions?;
    # The level of permission to grant the access token for repository creation, deletion, settings, teams, and collaborators creation.
    "read"|"write" administration?;
    # The level of permission to grant the access token for checks on code.
    "read"|"write" checks?;
    # The level of permission to grant the access token for repository contents, commits, branches, downloads, releases, and merges.
    "read"|"write" contents?;
    # The level of permission to grant the access token for deployments and deployment statuses.
    "read"|"write" deployments?;
    # The level of permission to grant the access token for managing repository environments.
    "read"|"write" environments?;
    # The level of permission to grant the access token for issues and related comments, assignees, labels, and milestones.
    "read"|"write" issues?;
    # The level of permission to grant the access token to search repositories, list collaborators, and access repository metadata.
    "read"|"write" metadata?;
    # The level of permission to grant the access token for packages published to GitHub Packages.
    "read"|"write" packages?;
    # The level of permission to grant the access token to retrieve Pages statuses, configuration, and builds, as well as create new builds.
    "read"|"write" pages?;
    # The level of permission to grant the access token for pull requests and related comments, assignees, labels, milestones, and merges.
    "read"|"write" pull_requests?;
    # The level of permission to grant the access token to manage the post-receive hooks for a repository.
    "read"|"write" repository_hooks?;
    # The level of permission to grant the access token to manage repository projects, columns, and cards.
    "read"|"write"|"admin" repository_projects?;
    # The level of permission to grant the access token to view and manage secret scanning alerts.
    "read"|"write" secret_scanning_alerts?;
    # The level of permission to grant the access token to manage repository secrets.
    "read"|"write" secrets?;
    # The level of permission to grant the access token to view and manage security events like code scanning alerts.
    "read"|"write" security_events?;
    # The level of permission to grant the access token to manage just a single file.
    "read"|"write" single_file?;
    # The level of permission to grant the access token for commit statuses.
    "read"|"write" statuses?;
    # The level of permission to grant the access token to manage Dependabot alerts.
    "read"|"write" vulnerability_alerts?;
    # The level of permission to grant the access token to update GitHub Actions workflow files.
    "write" workflows?;
    # The level of permission to grant the access token for organization teams and members.
    "read"|"write" members?;
    # The level of permission to grant the access token to manage access to an organization.
    "read"|"write" organization_administration?;
    # The level of permission to grant the access token for custom repository roles management. This property is in beta and is subject to change.
    "read"|"write" organization_custom_roles?;
    # The level of permission to grant the access token to view and manage announcement banners for an organization.
    "read"|"write" organization_announcement_banners?;
    # The level of permission to grant the access token to manage the post-receive hooks for an organization.
    "read"|"write" organization_hooks?;
    # The level of permission to grant the access token for viewing and managing fine-grained personal access token requests to an organization.
    "read"|"write" organization_personal_access_tokens?;
    # The level of permission to grant the access token for viewing and managing fine-grained personal access tokens that have been approved by an organization.
    "read"|"write" organization_personal_access_token_requests?;
    # The level of permission to grant the access token for viewing an organization's plan.
    "read" organization_plan?;
    # The level of permission to grant the access token to manage organization projects and projects beta (where available).
    "read"|"write"|"admin" organization_projects?;
    # The level of permission to grant the access token for organization packages published to GitHub Packages.
    "read"|"write" organization_packages?;
    # The level of permission to grant the access token to manage organization secrets.
    "read"|"write" organization_secrets?;
    # The level of permission to grant the access token to view and manage GitHub Actions self-hosted runners available to an organization.
    "read"|"write" organization_self_hosted_runners?;
    # The level of permission to grant the access token to view and manage users blocked by the organization.
    "read"|"write" organization_user_blocking?;
    # The level of permission to grant the access token to manage team discussions and related comments.
    "read"|"write" team_discussions?;
};

public type Collaborators_username_body_1 record {
    # The permission to grant the collaborator. **Only valid on organization-owned repositories.** We accept the following permissions to be set: `pull`, `triage`, `push`, `maintain`, `admin` and you can also specify a custom repository role name, if the owning organization has defined any.
    string permission?;
};

# Interaction limit settings.
public type InteractionLimitResponse record {
    # The type of GitHub user that can comment, open issues, or create pull requests while the interaction limit is in effect.
    InteractionGroup 'limit;
    string origin;
    string expires_at;
};

public type Branchrestrictionpolicy_permissions record {
    string metadata?;
    string contents?;
    string issues?;
    string single_file?;
};

public type Milestonedissueevent_milestone record {
    string title;
};

public type Repo_labels_body record {
    # The name of the label. Emoji can be added to label names, using either native emoji or colon-style markup. For example, typing `:strawberry:` will render the emoji ![:strawberry:](https://github.githubassets.com/images/icons/emoji/unicode/1f353.png ":strawberry:"). For a full list of available emoji and codes, see "[Emoji cheat sheet](https://github.com/ikatyang/emoji-cheat-sheet)."
    string name;
    # The [hexadecimal color code](http://www.color-hex.com/) for the label, without the leading `#`.
    string color?;
    # A short description of the label. Must be 100 characters or fewer.
    string description?;
};

public type CodeScanningAlertInstance record {
    # The full Git reference, formatted as `refs/heads/<branch name>`,
    # `refs/pull/<number>/merge`, or `refs/pull/<number>/head`.
    CodeScanningRef ref?;
    # Identifies the configuration under which the analysis was executed. For example, in GitHub Actions this includes the workflow filename and job name.
    CodeScanningAnalysisAnalysisKey analysis_key?;
    # Identifies the variable values associated with the environment in which the analysis that generated this alert instance was performed, such as the language that was analyzed.
    CodeScanningAlertEnvironment environment?;
    # Identifies the configuration under which the analysis was executed. Used to distinguish between multiple analyses for the same tool and commit, but performed on different languages or different parts of the code.
    CodeScanningAnalysisCategory category?;
    # State of a code scanning alert.
    CodeScanningAlertState state?;
    string commit_sha?;
    Codescanningalertinstance_message message?;
    # Describe a region within a file for the alert.
    CodeScanningAlertLocation location?;
    string html_url?;
    # Classifications that have been applied to the file that triggered the alert.
    # For example identifying it as documentation, or a generated file.
    CodeScanningAlertClassification[] classifications?;
};

public type Repo_deployments_body record {
    # The ref to deploy. This can be a branch, tag, or SHA.
    string ref;
    # Specifies a task to execute (e.g., `deploy` or `deploy:migrations`).
    string task = "deploy";
    # Attempts to automatically merge the default branch into the requested ref, if it's behind the default branch.
    boolean auto_merge = true;
    # The [status](https://docs.github.com/rest/commits/statuses) contexts to verify against commit status checks. If you omit this parameter, GitHub verifies all unique contexts before creating a deployment. To bypass checking entirely, pass an empty array. Defaults to all unique contexts.
    string[] required_contexts?;
    record {}|string payload?;
    # Name for the target deployment environment (e.g., `production`, `staging`, `qa`).
    string environment = "production";
    # Short description of the deployment.
    string? description = "";
    # Specifies if the given environment is specific to the deployment and will no longer exist at some point in the future. Default: `false`
    boolean transient_environment = false;
    # Specifies if the given environment is one that end-users directly interact with. Default: `true` when `environment` is `production` and `false` otherwise.
    boolean production_environment?;
};

# Status Check Policy
public type StatusCheckPolicy record {
    string url;
    boolean strict;
    string[] contexts;
    Statuscheckpolicy_checks[] checks;
    string contexts_url;
};

public type Snapshot_job record {|
    # The external ID of the job.
    string id;
    # Correlator provides a key that is used to group snapshots submitted over time. Only the "latest" submitted snapshot for a given combination of `job.correlator` and `detector.name` will be considered when calculating a repository's current dependencies. Correlator should be as unique as it takes to distinguish all detection runs for a given "wave" of CI workflow you run. If you're using GitHub Actions, a good default value for this could be the environment variables GITHUB_WORKFLOW and GITHUB_JOB concatenated together. If you're using a build matrix, then you'll also need to add additional key(s) to distinguish between each submission inside a matrix variation.
    string correlator;
    # The url for the job.
    string html_url?;
|};

public type Comments_comment_number_body_1 record {
    # The discussion comment's body text.
    string body;
};

# A classification of the file. For example to identify it as generated.
public type CodeScanningAlertClassification "source"|"generated"|"test"|"library";

public type ActionsGetDefaultWorkflowPermissions record {
    # The default workflow permissions granted to the GITHUB_TOKEN when running workflows.
    ActionsDefaultWorkflowPermissions default_workflow_permissions;
    # Whether GitHub Actions can approve pull requests. Enabling this can be a security risk.
    ActionsCanApprovePullRequestReviews can_approve_pull_request_reviews;
};

public type Org_migrations_body record {
    # A list of arrays indicating which repositories should be migrated.
    string[] repositories;
    # Indicates whether repositories should be locked (to prevent manipulation) while migrating data.
    boolean lock_repositories = false;
    # Indicates whether metadata should be excluded and only git source should be included for the migration.
    boolean exclude_metadata = false;
    # Indicates whether the repository git data should be excluded from the migration.
    boolean exclude_git_data = false;
    # Indicates whether attachments should be excluded from the migration (to reduce migration archive file size).
    boolean exclude_attachments = false;
    # Indicates whether releases should be excluded from the migration (to reduce migration archive file size).
    boolean exclude_releases = false;
    # Indicates whether projects owned by the organization or users should be excluded. from the migration.
    boolean exclude_owner_projects = false;
    # Indicates whether this should only include organization metadata (repositories array should be empty and will ignore other flags).
    boolean org_metadata_only = false;
    # Exclude related items from being returned in the response in order to improve performance of the request.
    ("repositories")[] exclude?;
};

public type Pullrequestreviewcomment__links_pull_request record {
    string href;
};

public type Repositoryrulerequiredstatuschecks_parameters record {
    # Status checks that are required.
    RepositoryRuleParamsStatusCheckConfiguration[] required_status_checks;
    # Whether pull requests targeting a matching branch must be tested with the latest code. This setting will not take effect unless at least one status check is enabled.
    boolean strict_required_status_checks_policy;
};

public type Milestones_milestone_number_body record {
    # The title of the milestone.
    string title?;
    # The state of the milestone. Either `open` or `closed`.
    "open"|"closed" state?;
    # A description of the milestone.
    string description?;
    # The milestone due date. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    string due_on?;
};

# Installation
public type InstallationResponse record {
    int total_count;
    Installation[] installations;
};

# A credit given to a user for a repository security advisory.
public type RepositoryAdvisoryCredit record {|
    # A GitHub user.
    SimpleUser user;
    # The type of credit the user is receiving.
    SecurityAdvisoryCreditTypes 'type;
    # The state of the user's acceptance of the credit.
    "accepted"|"declined"|"pending" state;
|};

public type SimpleCommitStatus record {
    string? description;
    int id;
    string node_id;
    string state;
    string context;
    string? target_url;
    boolean? required?;
    string? avatar_url;
    string url;
    string created_at;
    string updated_at;
};

public type Statuscheckpolicy_checks record {
    string context;
    int? app_id;
};

public type Repo_releases_body record {
    # The name of the tag.
    string tag_name;
    # Specifies the commitish value that determines where the Git tag is created from. Can be any branch or commit SHA. Unused if the Git tag already exists. Default: the repository's default branch.
    string target_commitish?;
    # The name of the release.
    string name?;
    # Text describing the contents of the tag.
    string body?;
    # `true` to create a draft (unpublished) release, `false` to create a published one.
    boolean draft = false;
    # `true` to identify the release as a prerelease. `false` to identify the release as a full release.
    boolean prerelease = false;
    # If specified, a discussion of the specified category is created and linked to the release. The value must be a category that already exists in the repository. For more information, see "[Managing categories for discussions in your repository](https://docs.github.com/discussions/managing-discussions-for-your-community/managing-categories-for-discussions-in-your-repository)."
    string discussion_category_name?;
    # Whether to automatically generate the name and body for this release. If `name` is specified, the specified name will be used; otherwise, a name will be automatically generated. If `body` is specified, the body will be pre-pended to the automatically generated notes.
    boolean generate_release_notes = false;
    # Specifies whether this release should be set as the latest release for the repository. Drafts and prereleases cannot be set as latest. Defaults to `true` for newly published releases. `legacy` specifies that the latest release should be determined based on the release creation date and higher semantic version.
    "true"|"false"|"legacy" make_latest = "true";
};

# The GitHub Pages deployment status.
public type PageDeployment record {
    # The URI to monitor GitHub Pages deployment status.
    string status_url;
    # The URI to the deployed GitHub Pages.
    string page_url;
    # The URI to the deployed GitHub Pages preview.
    string preview_url?;
};

# State Change Issue Event
public type StateChangeIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    string? state_reason?;
};

public type Publicuser_plan record {
    int collaborators;
    string name;
    int space;
    int private_repos;
};

public type Renamedissueevent_rename record {
    string 'from;
    string to;
};

public type Hooks_hook_id_body record {
    # Key/value pairs to provide settings for this webhook.
    Orgsorghookshook_id_config config?;
    # Determines what [events](https://docs.github.com/webhooks/event-payloads) the hook is triggered for.
    string[] events?;
    # Determines if notifications are sent when the webhook is triggered. Set to `true` to send notifications.
    boolean active?;
    string name?;
};

public type Restrictions_users_body record {
    # The username for users
    string[] users;
}|string[];

# Code of Conduct Simple
public type CodeOfConductSimple record {
    string url;
    string 'key;
    string name;
    string? html_url;
};

# A GitHub Classroom classroom
public type Classroom record {
    # Unique identifier of the classroom.
    int id;
    # The name of the classroom.
    string name;
    # Whether classroom is archived.
    boolean archived;
    # A GitHub organization.
    SimpleClassroomOrganization organization;
    # The URL of the classroom on GitHub Classroom.
    string url;
};

# The name of the package affected by the vulnerability.
public type Globaladvisory_package record {
    # The package's language or package management ecosystem.
    SecurityAdvisoryEcosystems ecosystem;
    # The unique package name within its ecosystem.
    string? name;
};

public type Cards_card_id_body record {
    # The project card's note
    string? note?;
    # Whether or not the card is archived
    boolean archived?;
};

# object containing information about the author.
public type Reposownerrepocontentspath_author_1 record {
    # The name of the author (or committer) of the commit
    string name?;
    # The email of the author (or committer) of the commit
    string email?;
};

public type Protection_required_status_checks_body record {
    # Require branches to be up to date before merging.
    boolean strict?;
    # **Deprecated**: The list of status checks to require in order to merge into this branch. If any of these checks have recently been set by a particular GitHub App, they will be required to come from that app in future for the branch to merge. Use `checks` instead of `contexts` for more fine-grained control.
    string[] contexts?;
    # The list of status checks to require in order to merge into this branch.
    Reposownerrepobranchesbranchprotection_required_status_checks_checks[] checks?;
};

# Secrets for a GitHub Codespace.
public type CodespacesOrgSecretResponse record {
    int total_count;
    CodespacesOrgSecret[] secrets;
};

# Organization Invitation
public type OrganizationInvitation record {
    int id;
    string? login;
    string? email;
    string role;
    string created_at;
    string? failed_at?;
    string? failed_reason?;
    # A GitHub user.
    SimpleUser inviter;
    int team_count;
    string node_id;
    string invitation_teams_url;
    string invitation_source?;
};

# Converted Note to Issue Issue Event
public type ConvertedNoteToIssueIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    Integration performed_via_github_app;
    Addedtoprojectissueevent_project_card project_card?;
};

public type Inline_response_503_1_errors record {
    string code?;
    string message?;
};

public type Contentdirectory_inner record {
    "dir"|"file"|"submodule"|"symlink" 'type;
    int size;
    string name;
    string path;
    string content?;
    string sha;
    string url;
    string? git_url;
    string? html_url;
    string? download_url;
    record {string? git; string? html; string self;} _links;
};

# Gist Simple
public type GistSimple record {
    Gistsimple_forks[]? forks?;
    GistHistory[]? history?;
    # Gist
    Gist? fork_of?;
    string url?;
    string forks_url?;
    string commits_url?;
    string id?;
    string node_id?;
    string git_pull_url?;
    string git_push_url?;
    string html_url?;
    record {|Gistsimple_files?...;|} files?;
    boolean 'public?;
    string created_at?;
    string updated_at?;
    string? description?;
    int comments?;
    string? user?;
    string comments_url?;
    # A GitHub user.
    SimpleUser owner?;
    boolean truncated?;
};

# A schema for the SPDX JSON format returned by the Dependency Graph.
public type DependencyGraphSpdxSbom record {
    Dependencygraphspdxsbom_sbom sbom;
};

# The total number of seat assignments created.
public type CopilotSeatCreated record {
    int seats_created;
};

public type Protectedbranchrequiredstatuscheck_checks record {
    string context;
    int? app_id;
};

public type Contents_path_body_1 record {
    # The commit message.
    string message;
    # The blob SHA of the file being deleted.
    string sha;
    # The branch name. Default: the repository’s default branch
    string branch?;
    # object containing information about the committer.
    Reposownerrepocontentspath_committer_1 committer?;
    # object containing information about the author.
    Reposownerrepocontentspath_author_1 author?;
};

# The policy that controls the repositories in the organization that are allowed to run GitHub Actions.
public type EnabledRepositories "all"|"none"|"selected";

public type Runner_id_labels_body record {
    # The names of the custom labels to set for the runner. You can pass an empty array to remove all custom labels.
    @constraint:Array {maxLength: 100}
    string[] labels;
};

public type Codescanningalertinstance_message record {
    string text?;
};

public type Dependencygraphspdxsbom_sbom record {
    # The SPDX identifier for the SPDX document.
    string SPDXID;
    # The version of the SPDX specification that this document conforms to.
    string spdxVersion;
    Dependencygraphspdxsbom_sbom_creationInfo creationInfo;
    # The name of the SPDX document.
    string name;
    # The license under which the SPDX document is licensed.
    string dataLicense;
    # The name of the repository that the SPDX document describes.
    string[] documentDescribes;
    # The namespace for the SPDX document.
    string documentNamespace;
    Dependencygraphspdxsbom_sbom_packages[] packages;
};

# Review Dismissed Issue Event
public type ReviewDismissedIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    Reviewdismissedissueevent_dismissed_review dismissed_review;
};

# A CWE weakness assigned to the advisory.
public type Dependabotalertsecurityadvisory_cwes record {|
    # The unique CWE ID.
    string cwe_id;
    # The short, plain text name of the CWE.
    string name;
|};

# License
public type License record {
    string 'key;
    string name;
    string? spdx_id;
    string? url;
    string node_id;
    string html_url;
    string description;
    string implementation;
    string[] permissions;
    string[] conditions;
    string[] limitations;
    string body;
    boolean featured;
};

public type Actionsbillingusage_minutes_used_breakdown record {
    # Total minutes used on Ubuntu runner machines.
    int UBUNTU?;
    # Total minutes used on macOS runner machines.
    int MACOS?;
    # Total minutes used on Windows runner machines.
    int WINDOWS?;
    # Total minutes used on Ubuntu 4 core runner machines.
    int ubuntu_4_core?;
    # Total minutes used on Ubuntu 8 core runner machines.
    int ubuntu_8_core?;
    # Total minutes used on Ubuntu 16 core runner machines.
    int ubuntu_16_core?;
    # Total minutes used on Ubuntu 32 core runner machines.
    int ubuntu_32_core?;
    # Total minutes used on Ubuntu 64 core runner machines.
    int ubuntu_64_core?;
    # Total minutes used on Windows 4 core runner machines.
    int windows_4_core?;
    # Total minutes used on Windows 8 core runner machines.
    int windows_8_core?;
    # Total minutes used on Windows 16 core runner machines.
    int windows_16_core?;
    # Total minutes used on Windows 32 core runner machines.
    int windows_32_core?;
    # Total minutes used on Windows 64 core runner machines.
    int windows_64_core?;
    # Total minutes used on macOS 12 core runner machines.
    int macos_12_core?;
    # Total minutes used on all runner machines.
    int total?;
};

public type Actions_variables_body_1 record {
    # The name of the variable.
    string name;
    # The value of the variable.
    string value;
};

public type Org_projects_body record {
    # The name of the project.
    string name;
    # The description of the project.
    string body?;
};

# Milestoned Issue Event
public type MilestonedIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    Milestonedissueevent_milestone milestone;
};

public type Restrictions_teams_body record {
    # The slug values for teams
    string[] teams;
}|string[];

public type Commit_sha_comments_body record {
    # The contents of the comment.
    string body;
    # Relative path of the file to comment on.
    string path?;
    # Line index in the diff to comment on.
    int position?;
    # **Deprecated**. Use **position** parameter instead. Line number in the file to comment on.
    int line?;
};

# Secrets for a GitHub Codespace.
public type CodespacesOrgSecret record {
    # The name of the secret
    string name;
    # The date and time at which the secret was created, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ.
    string created_at;
    # The date and time at which the secret was created, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ.
    string updated_at;
    # The type of repositories in the organization that the secret is visible to
    "all"|"private"|"selected" visibility;
    # The API URL at which the list of repositories this secret is visible to can be retrieved
    string selected_repositories_url?;
};

# Topic Search Result Item
public type TopicSearchResultItemResponse record {
    int total_count;
    boolean incomplete_results;
    TopicSearchResultItem[] items;
};

# An export of a codespace. Also, latest export details for a codespace can be fetched with id = latest
public type CodespaceExportDetails record {
    # State of the latest export
    string? state?;
    # Completion time of the last export operation
    string? completed_at?;
    # Name of the exported branch
    string? branch?;
    # Git commit SHA of the exported branch
    string? sha?;
    # Id for the export details
    string id?;
    # Url for fetching export details
    string export_url?;
    # Web url for the exported branch
    string? html_url?;
};

# Choose which environments must be successfully deployed to before refs can be merged into a branch that matches this rule.
public type RepositoryRuleRequiredDeployments record {
    "required_deployments" 'type;
    Repositoryrulerequireddeployments_parameters parameters?;
};

# License Simple
public type NullableLicenseSimple record {
    string 'key;
    string name;
    string? url;
    string? spdx_id;
    string node_id;
    string html_url?;
};

public type ReactionRollup record {
    string url;
    int total_count;
    int \+1;
    int \-1;
    int laugh;
    int confused;
    int heart;
    int hooray;
    int eyes;
    int rocket;
};

# Hypermedia Link with Type
public type LinkWithType record {
    string href;
    string 'type;
};

# Details of a Personal Access Token Request.
public type PersonalAccessTokenRequest record {
    # Unique identifier of the request for access via fine-grained personal access token. Used as the `pat_request_id` parameter in the list and review API calls.
    int id;
    # A GitHub user.
    SimpleUser owner;
    # New requested permissions, categorized by type of permission.
    Personalaccesstokenrequest_permissions_added permissions_added;
    # Requested permissions that elevate access for a previously approved request for access, categorized by type of permission.
    Personalaccesstokenrequest_permissions_upgraded permissions_upgraded;
    # Permissions requested, categorized by type of permission. This field incorporates `permissions_added` and `permissions_upgraded`.
    Personalaccesstokenrequest_permissions_result permissions_result;
    # Type of repository selection requested.
    "none"|"all"|"subset" repository_selection;
    # The number of repositories the token is requesting access to. This field is only populated when `repository_selection` is `subset`.
    int? repository_count;
    # An array of repository objects the token is requesting access to. This field is only populated when `repository_selection` is `subset`.
    Personalaccesstokenrequest_repositories[]? repositories;
    # Date and time when the request for access was created.
    string created_at;
    # Whether the associated fine-grained personal access token has expired.
    boolean token_expired;
    # Date and time when the associated fine-grained personal access token expires.
    string? token_expires_at;
    # Date and time when the associated fine-grained personal access token was last used for authentication.
    string? token_last_used_at;
};

public type Run_id_rerun_body record {
    # Whether to enable debug logging for the re-run.
    boolean enable_debug_logging?;
};

# An object describing a symlink
public type ContentSymlink record {
    "symlink" 'type;
    string target;
    int size;
    string name;
    string path;
    string sha;
    string url;
    string? git_url;
    string? html_url;
    string? download_url;
    Contenttree__links _links;
};

public type User_codespaces_body record {
    # Repository id for this codespace
    int repository_id;
    # Git ref (typically a branch name) for this codespace
    string ref?;
    # The requested location for a new codespace. Best efforts are made to respect this upon creation. Assigned by IP if not provided.
    string location?;
    # The geographic area for this codespace. If not specified, the value is assigned by IP. This property replaces `location`, which is being deprecated.
    "EuropeWest"|"SoutheastAsia"|"UsEast"|"UsWest" geo?;
    # IP for location auto-detection when proxying a request
    string client_ip?;
    # Machine type to use for this codespace
    string machine?;
    # Path to devcontainer.json config to use for this codespace
    string devcontainer_path?;
    # Whether to authorize requested permissions from devcontainer.json
    boolean multi_repo_permissions_opt_out?;
    # Working directory for this codespace
    string working_directory?;
    # Time in minutes before codespace stops from inactivity
    int idle_timeout_minutes?;
    # Display name for this codespace
    string display_name?;
    # Duration in minutes after codespace has gone idle in which it will be deleted. Must be integer minutes between 0 and 43200 (30 days).
    int retention_period_minutes?;
}|record {
    # Pull request number for this codespace
    Usercodespaces_pull_request pull_request;
    # The requested location for a new codespace. Best efforts are made to respect this upon creation. Assigned by IP if not provided.
    string location?;
    # The geographic area for this codespace. If not specified, the value is assigned by IP. This property replaces `location`, which is being deprecated.
    "EuropeWest"|"SoutheastAsia"|"UsEast"|"UsWest" geo?;
    # Machine type to use for this codespace
    string machine?;
    # Path to devcontainer.json config to use for this codespace
    string devcontainer_path?;
    # Working directory for this codespace
    string working_directory?;
    # Time in minutes before codespace stops from inactivity
    int idle_timeout_minutes?;
};

# A workflow referenced/reused by the initial caller workflow
public type ReferencedWorkflow record {
    string path;
    string sha;
    string ref?;
};

public type Searchresulttextmatches_inner record {
    string object_url?;
    string? object_type?;
    string property?;
    string fragment?;
    record {string text?; int[] indices?;}[] matches?;
};

# A label for a self hosted runner
public type RunnerLabel record {
    # Unique identifier of the label.
    int id?;
    # Name of the label.
    string name;
    # The type of label. Read-only labels are applied automatically when the runner is configured.
    "read-only"|"custom" 'type?;
};

public type Owner_repo_body_1 record {
    # The name of the repository.
    string name?;
    # A short description of the repository.
    string description?;
    # A URL with more information about the repository.
    string homepage?;
    # Either `true` to make the repository private or `false` to make it public. Default: `false`.  
    # **Note**: You will get a `422` error if the organization restricts [changing repository visibility](https://docs.github.com/articles/repository-permission-levels-for-an-organization#changing-the-visibility-of-repositories) to organization owners and a non-owner tries to change the value of private.
    boolean 'private?;
    # The visibility of the repository.
    "public"|"private" visibility?;
    # Specify which security and analysis features to enable or disable for the repository.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # For example, to enable GitHub Advanced Security, use this data in the body of the `PATCH` request:
    # `{ "security_and_analysis": {"advanced_security": { "status": "enabled" } } }`.
    # 
    # You can check which security and analysis features are currently enabled by using a `GET /repos/{owner}/{repo}` request.
    Reposownerrepo_security_and_analysis? security_and_analysis?;
    # Either `true` to enable issues for this repository or `false` to disable them.
    boolean has_issues?;
    # Either `true` to enable projects for this repository or `false` to disable them. **Note:** If you're creating a repository in an organization that has disabled repository projects, the default is `false`, and if you pass `true`, the API returns an error.
    boolean has_projects?;
    # Either `true` to enable the wiki for this repository or `false` to disable it.
    boolean has_wiki?;
    # Either `true` to make this repo available as a template repository or `false` to prevent it.
    boolean is_template?;
    # Updates the default branch for this repository.
    string default_branch?;
    # Either `true` to allow squash-merging pull requests, or `false` to prevent squash-merging.
    boolean allow_squash_merge?;
    # Either `true` to allow merging pull requests with a merge commit, or `false` to prevent merging pull requests with merge commits.
    boolean allow_merge_commit?;
    # Either `true` to allow rebase-merging pull requests, or `false` to prevent rebase-merging.
    boolean allow_rebase_merge?;
    # Either `true` to allow auto-merge on pull requests, or `false` to disallow auto-merge.
    boolean allow_auto_merge?;
    # Either `true` to allow automatically deleting head branches when pull requests are merged, or `false` to prevent automatic deletion.
    boolean delete_branch_on_merge?;
    # Either `true` to always allow a pull request head branch that is behind its base branch to be updated even if it is not required to be up to date before merging, or false otherwise.
    boolean allow_update_branch?;
    # Either `true` to allow squash-merge commits to use pull request title, or `false` to use commit message. **This property has been deprecated. Please use `squash_merge_commit_title` instead.
    boolean use_squash_pr_title_as_default?;
    # The default value for a squash merge commit title:
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `COMMIT_OR_PR_TITLE` - default to the commit's title (if only one commit) or the pull request's title (when more than one commit).
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squash_merge_commit_title?;
    # The default value for a squash merge commit message:
    # 
    # - `PR_BODY` - default to the pull request's body.
    # - `COMMIT_MESSAGES` - default to the branch's commit messages.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squash_merge_commit_message?;
    # The default value for a merge commit title.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `MERGE_MESSAGE` - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name).
    "PR_TITLE"|"MERGE_MESSAGE" merge_commit_title?;
    # The default value for a merge commit message.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `PR_BODY` - default to the pull request's body.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"PR_TITLE"|"BLANK" merge_commit_message?;
    # Whether to archive this repository. `false` will unarchive a previously archived repository.
    boolean archived?;
    # Either `true` to allow private forks, or `false` to prevent private forks.
    boolean allow_forking?;
    # Either `true` to require contributors to sign off on web-based commits, or `false` to not require contributors to sign off on web-based commits.
    boolean web_commit_signoff_required?;
};

public type Owner_repo_body_2 record {
    # The permission to grant the team on this repository. If no permission is specified, the team's `permission` attribute will be used to determine what permission to grant the team on this repository.
    "pull"|"push"|"admin" permission?;
};

public type Personalaccesstokenrequest_repositories record {
    string full_name;
    # Unique identifier of the repository
    int id;
    # The name of the repository.
    string name;
    string node_id;
    # Whether the repository is private or public.
    boolean 'private;
};

public type Reviews_review_id_body record {
    # The body text of the pull request review.
    string body;
};

# A self hosted runner
public type RunnerResponse record {
    int total_count;
    Runner[] runners;
};

# Require at least one approving review on a pull request, before merging. Set to `null` to disable.
public type Reposownerrepobranchesbranchprotection_required_pull_request_reviews record {
    # Specify which users, teams, and apps can dismiss pull request reviews. Pass an empty `dismissal_restrictions` object to disable. User and team `dismissal_restrictions` are only available for organization-owned repositories. Omit this parameter for personal repositories.
    Reposownerrepobranchesbranchprotection_required_pull_request_reviews_dismissal_restrictions dismissal_restrictions?;
    # Set to `true` if you want to automatically dismiss approving reviews when someone pushes a new commit.
    boolean dismiss_stale_reviews?;
    # Blocks merging pull requests until [code owners](https://docs.github.com/articles/about-code-owners/) review them.
    boolean require_code_owner_reviews?;
    # Specify the number of reviewers required to approve pull requests. Use a number between 1 and 6 or 0 to not require reviewers.
    int required_approving_review_count?;
    # Whether the most recent push must be approved by someone other than the person who pushed it. Default: `false`.
    boolean require_last_push_approval?;
    # Allow specific users, teams, or apps to bypass pull request requirements.
    Reposownerrepobranchesbranchprotection_required_pull_request_reviews_bypass_pull_request_allowances bypass_pull_request_allowances?;
};

# GitHub account for managing multiple users, teams, and repositories
public type Organization record {
    # Unique login name of the organization
    string login;
    # URL for the organization
    string url;
    int id;
    string node_id;
    string repos_url;
    string events_url;
    string hooks_url;
    string issues_url;
    string members_url;
    string public_members_url;
    string avatar_url;
    string? description;
    # Display blog url for the organization
    string blog?;
    string html_url;
    # Display name for the organization
    string name?;
    # Display company name for the organization
    string company?;
    # Display location for the organization
    string location?;
    # Display email for the organization
    string email?;
    # Specifies if organization projects are enabled for this org
    boolean has_organization_projects;
    # Specifies if repository projects are enabled for repositories that belong to this org
    boolean has_repository_projects;
    boolean is_verified?;
    int public_repos;
    int public_gists;
    int followers;
    int following;
    string 'type;
    string created_at;
    string updated_at;
    Organization_plan plan?;
};

# A deployment created as the result of an Actions check run from a workflow that references an environment
public type DeploymentSimple record {
    string url;
    # Unique identifier of the deployment
    int id;
    string node_id;
    # Parameter to specify a task to execute
    string task;
    string original_environment?;
    # Name for the target deployment environment.
    string environment;
    string? description;
    string created_at;
    string updated_at;
    string statuses_url;
    string repository_url;
    # Specifies if the given environment is will no longer exist at some point in the future. Default: false.
    boolean transient_environment?;
    # Specifies if the given environment is one that end-users directly interact with. Default: false.
    boolean production_environment?;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app?;
};

# A CodeQL database.
public type CodeScanningCodeqlDatabase record {
    # The ID of the CodeQL database.
    int id;
    # The name of the CodeQL database.
    string name;
    # The language of the CodeQL database.
    string language;
    # A GitHub user.
    SimpleUser uploader;
    # The MIME type of the CodeQL database file.
    string content_type;
    # The size of the CodeQL database file in bytes.
    int size;
    # The date and time at which the CodeQL database was created, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ.
    string created_at;
    # The date and time at which the CodeQL database was last updated, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ.
    string updated_at;
    # The URL at which to download the CodeQL database. The `Accept` header must be set to the value of the `content_type` property.
    string url;
    # The commit SHA of the repository at the time the CodeQL database was created.
    string? commit_oid?;
};

# Unassigned Issue Event
public type UnassignedIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    # A GitHub user.
    SimpleUser assignee;
    # A GitHub user.
    SimpleUser assigner;
};

# Information of a job execution in a workflow run
public type JobResponse record {
    int total_count;
    Job[] jobs;
};

public type PackagesBillingUsage record {
    # Sum of the free and paid storage space (GB) for GitHuub Packages.
    int total_gigabytes_bandwidth_used;
    # Total paid storage space (GB) for GitHuub Packages.
    int total_paid_gigabytes_bandwidth_used;
    # Free storage space (GB) for GitHub Packages.
    int included_gigabytes_bandwidth;
};

# Issue Search Result Item
public type IssueSearchResultItemResponse record {
    int total_count;
    boolean incomplete_results;
    IssueSearchResultItem[] items;
};

# Groups of organization members that gives permissions on specified repositories.
public type NullableTeamSimple record {
    # Unique identifier of the team
    int id;
    string node_id;
    # URL for the team
    string url;
    string members_url;
    # Name of the team
    string name;
    # Description of the team
    string? description;
    # Permission that the team will have for its repositories
    string permission;
    # The level of privacy this team should have
    string privacy?;
    # The notification setting the team has set
    string notification_setting?;
    string html_url;
    string repositories_url;
    string slug;
    # Distinguished Name (DN) that team maps to within LDAP environment
    string ldap_dn?;
};

public type Name_repositories_body record {
    # The IDs of the repositories that can access the organization variable.
    int[] selected_repository_ids;
};

# Parameters to be used for the committer_email_pattern rule
public type RepositoryRuleCommitterEmailPattern record {
    "committer_email_pattern" 'type;
    Repositoryrulecommitmessagepattern_parameters parameters?;
};

# Unlabeled Issue Event
public type UnlabeledIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    Labeledissueevent_label label;
};

# Pull Request Review Request
public type PullRequestReviewRequest record {
    SimpleUser[] users;
    Team[] teams;
};

public type Discussion_number_reactions_body record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the team discussion.
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

# State of a code scanning alert.
public type CodeScanningAlertState "open"|"dismissed"|"fixed";

# Webhooks for repositories.
public type Hook record {
    string 'type;
    # Unique identifier of the webhook.
    int id;
    # The name of a valid service, use 'web' for a webhook.
    string name;
    # Determines whether the hook is actually triggered on pushes.
    boolean active;
    # Determines what events the hook is triggered for. Default: ['push'].
    string[] events;
    Hook_config config;
    string updated_at;
    string created_at;
    string url;
    string test_url;
    string ping_url;
    string deliveries_url?;
    HookResponse last_response;
};

# Installation
public type Installation record {
    # The ID of the installation.
    int id;
    SimpleUser|Enterprise? account;
    # Describe whether all repositories have been selected or there's a selection involved
    "all"|"selected" repository_selection;
    string access_tokens_url;
    string repositories_url;
    string html_url;
    int app_id;
    # The ID of the user or organization this token is being scoped to.
    int target_id;
    string target_type;
    # The permissions granted to the user access token.
    AppPermissions permissions;
    string[] events;
    string created_at;
    string updated_at;
    string? single_file_name;
    boolean has_multiple_single_files?;
    string[] single_file_paths?;
    string app_slug;
    # A GitHub user.
    NullableSimpleUser? suspended_by;
    string? suspended_at;
    string? contact_email?;
};

# Runner Application
public type RunnerApplication record {
    string os;
    string architecture;
    string download_url;
    string filename;
    # A short lived bearer token used to download the runner, if needed.
    string temp_download_token?;
    string sha256_checksum?;
};

# Issue Event Milestone
public type IssueEventMilestone record {
    string title;
};

public type Discussion_number_comments_body record {
    # The discussion comment's body text.
    string body;
};

# Check suite configuration preferences for a repository.
public type CheckSuitePreference record {
    Checksuitepreference_preferences preferences;
    # Minimal Repository
    MinimalRepository repository;
};

public type Repo_dispatches_body record {
    # A custom webhook event name. Must be 100 characters or fewer.
    @constraint:String {maxLength: 100, minLength: 1}
    string event_type;
    # JSON payload with extra information about the webhook event that your action or workflow may use. The maximum number of top-level properties is 10.
    record {} client_payload?;
};

public type Organizationfull_plan record {
    string name;
    int space;
    int private_repos;
    int filled_seats?;
    int seats?;
};

public type Repositoryruleupdate_parameters record {
    # Branch can pull changes from its upstream repository
    boolean update_allows_fetch_and_merge;
};

public type Checksuitepreference_preferences record {
    Checksuitepreference_preferences_auto_trigger_checks[] auto_trigger_checks?;
};

public type Repo_pulls_body record {
    # The title of the new pull request. Required unless `issue` is specified.
    string title?;
    # The name of the branch where your changes are implemented. For cross-repository pull requests in the same network, namespace `head` with a user like this: `username:branch`.
    string head;
    # The name of the repository where the changes in the pull request were made. This field is required for cross-repository pull requests if both repositories are owned by the same organization.
    string head_repo?;
    # The name of the branch you want the changes pulled into. This should be an existing branch on the current repository. You cannot submit a pull request to one repository that requests a merge to a base of another repository.
    string base;
    # The contents of the pull request.
    string body?;
    # Indicates whether [maintainers can modify](https://docs.github.com/articles/allowing-changes-to-a-pull-request-branch-created-from-a-fork/) the pull request.
    boolean maintainer_can_modify?;
    # Indicates whether the pull request is a draft. See "[Draft Pull Requests](https://docs.github.com/articles/about-pull-requests#draft-pull-requests)" in the GitHub Help documentation to learn more.
    boolean draft?;
    # An issue in the repository to convert to a pull request. The issue title, body, and comments will become the title, body, and comments on the new pull request. Required unless `title` is specified.
    int issue?;
};

public type Repo_mergeupstream_body record {
    # The name of the branch which should be updated to match upstream.
    string branch;
};

public type Repositoryruleset__links record {
    Repositoryruleset__links_self self?;
    Repositoryruleset__links_html html?;
};

# An enterprise on GitHub.
public type Enterprise record {
    # A short description of the enterprise.
    string? description?;
    string html_url;
    # The enterprise's website URL.
    string? website_url?;
    # Unique identifier of the enterprise
    int id;
    string node_id;
    # The name of the enterprise.
    string name;
    # The slug url identifier for the enterprise.
    string slug;
    string? created_at;
    string? updated_at;
    string avatar_url;
};

public type Git_commits_body record {
    # The commit message
    string message;
    # The SHA of the tree object this commit points to
    string tree;
    # The SHAs of the commits that were the parents of this commit. If omitted or empty, the commit will be written as a root commit. For a single parent, an array of one SHA should be provided; for a merge commit, an array of more than one should be provided.
    string[] parents?;
    # Information about the author of the commit. By default, the `author` will be the authenticated user and the current date. See the `author` and `committer` object below for details.
    Reposownerrepogitcommits_author author?;
    # Information about the person who is making the commit. By default, `committer` will use the information set in `author`. See the `author` and `committer` object below for details.
    Reposownerrepogitcommits_committer committer?;
    # The [PGP signature](https://en.wikipedia.org/wiki/Pretty_Good_Privacy) of the commit. GitHub adds the signature to the `gpgsig` header of the created commit. For a commit signature to be verifiable by Git or GitHub, it must be an ASCII-armored detached PGP signature over the string commit as it would be written to the object database. To pass a `signature` parameter, you need to first manually create a valid PGP signature, which can be complicated. You may find it easier to [use the command line](https://git-scm.com/book/id/v2/Git-Tools-Signing-Your-Work) to create signed commits.
    string signature?;
};

public type Git_blobs_body record {
    # The new blob's content.
    string content;
    # The encoding used for `content`. Currently, `"utf-8"` and `"base64"` are supported.
    string encoding = "utf-8";
};

# Metaproperties for Git author/committer information.
public type NullableGitUser record {
    string name?;
    string email?;
    string date?;
};

# The name of the tool used to generate the code scanning analysis.
public type CodeScanningAnalysisToolName string;

public type Secret_name_repositories_body record {
    # An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the `visibility` is set to `selected`. You can add and remove individual repositories using the [Add selected repository to an organization secret](https://docs.github.com/rest/actions/secrets#add-selected-repository-to-an-organization-secret) and [Remove selected repository from an organization secret](https://docs.github.com/rest/actions/secrets#remove-selected-repository-from-an-organization-secret) endpoints.
    int[] selected_repository_ids;
};

public type Comment_id_reactions_body record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the commit comment.
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

public type Affects string|string[];

public type Org_teams_body record {
    # The name of the team.
    string name;
    # The description of the team.
    string description?;
    # List GitHub IDs for organization members who will become team maintainers.
    string[] maintainers?;
    # The full name (e.g., "organization-name/repository-name") of repositories to add the team to.
    string[] repo_names?;
    # The level of privacy this team should have. The options are:  
    # **For a non-nested team:**  
    #  * `secret` - only visible to organization owners and members of this team.  
    #  * `closed` - visible to all members of this organization.  
    # Default: `secret`  
    # **For a parent or child team:**  
    #  * `closed` - visible to all members of this organization.  
    # Default for child team: `closed`
    "secret"|"closed" privacy?;
    # The notification setting the team has chosen. The options are:  
    #  * `notifications_enabled` - team members receive notifications when the team is @mentioned.  
    #  * `notifications_disabled` - no one receives notifications.  
    # Default: `notifications_enabled`
    "notifications_enabled"|"notifications_disabled" notification_setting?;
    # **Deprecated**. The permission that new repositories will be added to the team with when none is specified.
    "pull"|"push" permission = "pull";
    # The ID of a team to set as the parent team.
    int parent_team_id?;
};

# The URL to which the payloads will be delivered.
public type WebhookConfigUrl string;

# Required status check
public type RepositoryRuleParamsStatusCheckConfiguration record {
    # The status check context name that must be present on the commit.
    string context;
    # The optional integration ID that this status check must originate from.
    int integration_id?;
};

public type Installation_id_access_tokens_body record {
    # List of repository names that the token should have access to
    string[] repositories?;
    # List of repository IDs that the token should have access to
    int[] repository_ids?;
    # The permissions granted to the user access token.
    AppPermissions permissions?;
};

# Whether to set the branch as read-only. If this is true, users will not be able to push to the branch.
public type Protectedbranch_lock_branch record {|
    boolean enabled?;
|};

# Collaborator
public type NullableCollaborator record {
    string login;
    int id;
    string? email?;
    string? name?;
    string node_id;
    string avatar_url;
    string? gravatar_id;
    string url;
    string html_url;
    string followers_url;
    string following_url;
    string gists_url;
    string starred_url;
    string subscriptions_url;
    string organizations_url;
    string repos_url;
    string events_url;
    string received_events_url;
    string 'type;
    boolean site_admin;
    Collaborator_permissions permissions?;
    string role_name;
};

public type Hook_id_config_body record {
    # The URL to which the payloads will be delivered.
    WebhookConfigUrl url?;
    # The media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`.
    WebhookConfigContentType content_type?;
    # If provided, the `secret` will be used as the `key` to generate the HMAC hex digest value for [delivery signature headers](https://docs.github.com/webhooks/event-payloads/#delivery-headers).
    WebhookConfigSecret secret?;
    WebhookConfigInsecureSsl insecure_ssl?;
};

public type Inline_response_422_1 record {
    string message?;
    string documentation_url?;
};

# Specify which users, teams, and apps can dismiss pull request reviews. Pass an empty `dismissal_restrictions` object to disable. User and team `dismissal_restrictions` are only available for organization-owned repositories. Omit this parameter for personal repositories.
public type Reposownerrepobranchesbranchprotection_required_pull_request_reviews_dismissal_restrictions record {
    # The list of user `login`s with dismissal access
    string[] users?;
    # The list of team `slug`s with dismissal access
    string[] teams?;
    # The list of app `slug`s with dismissal access
    string[] apps?;
};

# Feed
public type Feed record {
    string timeline_url;
    string user_url;
    string current_user_public_url?;
    string current_user_url?;
    string current_user_actor_url?;
    string current_user_organization_url?;
    string[] current_user_organization_urls?;
    string security_advisories_url?;
    # A feed of discussions for a given repository.
    string repository_discussions_url?;
    # A feed of discussions for a given repository and category.
    string repository_discussions_category_url?;
    Feed__links _links;
};

# Dev Containers
public type DevcontainersResponse record {
    int total_count;
    Devcontainers[] devcontainers;
};

# Public User
public type PublicUser record {|
    string login;
    int id;
    string node_id;
    string avatar_url;
    string? gravatar_id;
    string url;
    string html_url;
    string followers_url;
    string following_url;
    string gists_url;
    string starred_url;
    string subscriptions_url;
    string organizations_url;
    string repos_url;
    string events_url;
    string received_events_url;
    string 'type;
    boolean site_admin;
    string? name;
    string? company;
    string? blog;
    string? location;
    string? email;
    boolean? hireable;
    string? bio;
    string? twitter_username?;
    int public_repos;
    int public_gists;
    int followers;
    int following;
    string created_at;
    string updated_at;
    Publicuser_plan plan?;
    string? suspended_at?;
    int private_gists?;
    int total_private_repos?;
    int owned_private_repos?;
    int disk_usage?;
    int collaborators?;
|};

# Details about the codespace's git repository.
public type Codespace_git_status record {
    # The number of commits the local repository is ahead of the remote.
    int ahead?;
    # The number of commits the local repository is behind the remote.
    int behind?;
    # Whether the local repository has unpushed changes.
    boolean has_unpushed_changes?;
    # Whether the local repository has uncommitted changes.
    boolean has_uncommitted_changes?;
    # The current branch (or SHA if in detached HEAD state) of the local repository.
    string ref?;
};

public type Topicsearchresultitem_related record {
    Topicsearchresultitem_topic_relation topic_relation?;
};

# Data related to a release.
public type ReleaseAsset record {
    string url;
    string browser_download_url;
    int id;
    string node_id;
    # The file name of the asset.
    string name;
    string? label;
    # State of the release asset.
    "uploaded"|"open" state;
    string content_type;
    int size;
    int download_count;
    string created_at;
    string updated_at;
    # A GitHub user.
    NullableSimpleUser? uploader;
};

# Represents an 'issue_title' secret scanning location type. This location type shows that a secret was detected in the title of an issue.
public type SecretScanningLocationIssueTitle record {
    # The API URL to get the issue where the secret was detected.
    string issue_title_url;
};

public type Org_invitations_body record {
    # **Required unless you provide `email`**. GitHub user ID for the person you are inviting.
    int invitee_id?;
    # **Required unless you provide `invitee_id`**. Email address of the person you are inviting, which can be an existing GitHub user.
    string email?;
    # The role for the new member. 
    #  * `admin` - Organization owners with full administrative rights to the organization and complete access to all repositories and teams.  
    #  * `direct_member` - Non-owner organization members with ability to see other members and join teams by invitation.  
    #  * `billing_manager` - Non-owner organization members with ability to manage the billing settings of your organization.
    "admin"|"direct_member"|"billing_manager" role?;
    # Specify IDs for the teams you want to invite new members to.
    int[] team_ids?;
};

public type Environments_environment_name_body record {|
    # The amount of time to delay a job after the job is initially triggered. The time (in minutes) must be an integer between 0 and 43,200 (30 days).
    WaitTimer wait_timer?;
    # Whether or not a user who created the job is prevented from approving their own job.
    PreventSelfReview prevent_self_review?;
    # The people or teams that may review jobs that reference the environment. You can list up to six users or teams as reviewers. The reviewers must have at least read access to the repository. Only one of the required reviewers needs to approve the job for it to proceed.
    Reposownerrepoenvironmentsenvironment_name_reviewers[]? reviewers?;
    # The type of deployment branch policy for this environment. To allow all branches to deploy, set to `null`.
    DeploymentBranchPolicySettings? deployment_branch_policy?;
|};

# Repo Search Result Item
public type RepoSearchResultItemResponse record {
    int total_count;
    boolean incomplete_results;
    RepoSearchResultItem[] items;
};

# Minimal Repository
public type NullableMinimalRepository record {
    int id;
    string node_id;
    string name;
    string full_name;
    # A GitHub user.
    SimpleUser owner;
    boolean 'private;
    string html_url;
    string? description;
    boolean 'fork;
    string url;
    string archive_url;
    string assignees_url;
    string blobs_url;
    string branches_url;
    string collaborators_url;
    string comments_url;
    string commits_url;
    string compare_url;
    string contents_url;
    string contributors_url;
    string deployments_url;
    string downloads_url;
    string events_url;
    string forks_url;
    string git_commits_url;
    string git_refs_url;
    string git_tags_url;
    string git_url?;
    string issue_comment_url;
    string issue_events_url;
    string issues_url;
    string keys_url;
    string labels_url;
    string languages_url;
    string merges_url;
    string milestones_url;
    string notifications_url;
    string pulls_url;
    string releases_url;
    string ssh_url?;
    string stargazers_url;
    string statuses_url;
    string subscribers_url;
    string subscription_url;
    string tags_url;
    string teams_url;
    string trees_url;
    string clone_url?;
    string? mirror_url?;
    string hooks_url;
    string svn_url?;
    string? homepage?;
    string? language?;
    int forks_count?;
    int stargazers_count?;
    int watchers_count?;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0.
    int size?;
    string default_branch?;
    int open_issues_count?;
    boolean is_template?;
    string[] topics?;
    boolean has_issues?;
    boolean has_projects?;
    boolean has_wiki?;
    boolean has_pages?;
    boolean has_downloads?;
    boolean has_discussions?;
    boolean archived?;
    boolean disabled?;
    string visibility?;
    string? pushed_at?;
    string? created_at?;
    string? updated_at?;
    Repository_template_repository_permissions permissions?;
    string role_name?;
    string temp_clone_token?;
    boolean delete_branch_on_merge?;
    int subscribers_count?;
    int network_count?;
    # Code Of Conduct
    CodeOfConduct code_of_conduct?;
    Minimalrepository_license? license?;
    int forks?;
    int open_issues?;
    int watchers?;
    boolean allow_forking?;
    boolean web_commit_signoff_required?;
    SecurityAndAnalysis? security_and_analysis?;
};

# A commit.
public type SimpleCommit record {
    # SHA for the commit
    string id;
    # SHA for the commit's tree
    string tree_id;
    # Message describing the purpose of the commit
    string message;
    # Timestamp of the commit
    string timestamp;
    # Information about the Git author
    Nullablesimplecommit_author? author;
    # Information about the Git committer
    Nullablesimplecommit_committer? committer;
};

public type Pullrequestminimal_head record {
    string ref;
    string sha;
    Pullrequestminimal_head_repo repo;
};

# A self hosted runner
public type Runner record {
    # The id of the runner.
    int id;
    # The id of the runner group.
    int runner_group_id?;
    # The name of the runner.
    string name;
    # The Operating System of the runner.
    string os;
    # The status of the runner.
    string status;
    boolean busy;
    RunnerLabel[] labels;
};

public type Restrictions_teams_body_1 record {
    # The slug values for teams
    string[] teams;
}|string[];

public type Restrictions_teams_body_2 record {
    # The slug values for teams
    string[] teams;
}|string[];

# The security alert number.
public type AlertNumber int;

# Parameters to be used for the commit_author_email_pattern rule
public type RepositoryRuleCommitAuthorEmailPattern record {
    "commit_author_email_pattern" 'type;
    Repositoryrulecommitmessagepattern_parameters parameters?;
};

# A Dependabot alert.
public type DependabotAlertWithRepository record {|
    # The security alert number.
    AlertNumber number;
    # The state of the Dependabot alert.
    "auto_dismissed"|"dismissed"|"fixed"|"open" state;
    # Details for the vulnerable dependency.
    Dependabotalertwithrepository_dependency dependency;
    # Details for the GitHub Security Advisory.
    DependabotAlertSecurityAdvisory security_advisory;
    # Details pertaining to one vulnerable version range for the advisory.
    DependabotAlertSecurityVulnerability security_vulnerability;
    # The REST API URL of the alert resource.
    AlertUrl url;
    # The GitHub URL of the alert resource.
    AlertHtmlUrl html_url;
    # The time that the alert was created in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertCreatedAt created_at;
    # The time that the alert was last updated in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertUpdatedAt updated_at;
    # The time that the alert was dismissed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertDismissedAt? dismissed_at;
    # A GitHub user.
    NullableSimpleUser? dismissed_by;
    # The reason that the alert was dismissed.
    "fix_started"|"inaccurate"|"no_bandwidth"|"not_used"|"tolerable_risk" dismissed_reason;
    # An optional comment associated with the alert's dismissal.
    string? dismissed_comment;
    # The time that the alert was no longer detected and was considered fixed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertFixedAt? fixed_at;
    # The time that the alert was auto-dismissed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertAutoDismissedAt? auto_dismissed_at?;
    # A GitHub repository.
    SimpleRepository repository;
|};

# A projects v2 project
public type ProjectsV2 record {
    decimal id;
    string node_id;
    # A GitHub user.
    SimpleUser owner;
    # A GitHub user.
    SimpleUser creator;
    string title;
    string? description;
    boolean 'public;
    string? closed_at;
    string created_at;
    string updated_at;
    int number;
    string? short_description;
    string? deleted_at;
    # A GitHub user.
    NullableSimpleUser? deleted_by;
};

public type RateLimit record {
    int 'limit;
    int remaining;
    int reset;
    int used;
};

# Thread Subscription
public type ThreadSubscription record {
    boolean subscribed;
    boolean ignored;
    string? reason;
    string? created_at;
    string url;
    string thread_url?;
    string repository_url?;
};

# Organization variable for GitHub Actions.
public type OrganizationActionsVariable record {
    # The name of the variable.
    string name;
    # The value of the variable.
    string value;
    # The date and time at which the variable was created, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ.
    string created_at;
    # The date and time at which the variable was last updated, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ.
    string updated_at;
    # Visibility of a variable
    "all"|"private"|"selected" visibility;
    string selected_repositories_url?;
};

# A topic aggregates entities that are related to a subject.
public type Topic record {
    string[] names;
};

public type Billing_selected_users_body record {
    # The usernames of the organization members to be granted access to GitHub Copilot.
    @constraint:Array {minLength: 1}
    string[] selected_usernames;
};

# Commit Comment
public type CommitComment record {
    string html_url;
    string url;
    int id;
    string node_id;
    string body;
    string? path;
    int? position;
    int? line;
    string commit_id;
    # A GitHub user.
    NullableSimpleUser? user;
    string created_at;
    string updated_at;
    # How the author is associated with the repository.
    AuthorAssociation author_association;
    ReactionRollup reactions?;
};

public type Manifest record {|
    # The name of the manifest.
    string name;
    Manifest_file file?;
    # User-defined metadata to store domain-specific information limited to 8 keys with scalar values.
    Metadata metadata?;
    # A collection of resolved package dependencies.
    record {|Dependency...;|} resolved?;
|};

public type Labeledissueevent_label record {
    string name;
    string color;
};

# Protected Branch Pull Request Review
public type ProtectedBranchPullRequestReview record {
    string url?;
    Protectedbranchpullrequestreview_dismissal_restrictions dismissal_restrictions?;
    # Allow specific users, teams, or apps to bypass pull request requirements.
    Protectedbranchpullrequestreview_bypass_pull_request_allowances bypass_pull_request_allowances?;
    boolean dismiss_stale_reviews;
    boolean require_code_owner_reviews;
    @constraint:Int {minValue: 0, maxValue: 6}
    int required_approving_review_count?;
    # Whether the most recent push must be approved by someone other than the person who pushed it.
    boolean require_last_push_approval = false;
};

# Branch protections protect branches
public type ProtectedBranch record {
    string url;
    # Status Check Policy
    StatusCheckPolicy required_status_checks?;
    Protectedbranch_required_pull_request_reviews required_pull_request_reviews?;
    Branchprotection_required_signatures required_signatures?;
    Protectedbranch_enforce_admins enforce_admins?;
    Protectedbranch_required_linear_history required_linear_history?;
    Protectedbranch_required_linear_history allow_force_pushes?;
    Protectedbranch_required_linear_history allow_deletions?;
    # Branch Restriction Policy
    BranchRestrictionPolicy restrictions?;
    Protectedbranch_required_conversation_resolution required_conversation_resolution?;
    Protectedbranch_required_linear_history block_creations?;
    # Whether to set the branch as read-only. If this is true, users will not be able to push to the branch.
    Protectedbranch_lock_branch lock_branch?;
    # Whether users can pull changes from upstream when the branch is locked. Set to `true` to allow fork syncing. Set to `false` to prevent fork syncing.
    Protectedbranch_allow_fork_syncing allow_fork_syncing?;
};

# Information about the Git committer
public type Nullablesimplecommit_committer record {
    # Name of the commit's committer
    string name;
    # Git email address of the commit's committer
    string email;
};

# Pull request number for this codespace
public type Usercodespaces_pull_request record {
    # Pull request number
    int pull_request_number;
    # Repository id for this codespace
    int repository_id;
};

# A GitHub Actions workflow
public type WorkflowResponse record {
    int total_count;
    Workflow[] workflows;
};

public type Timelinereviewedevent__links_html record {
    string href;
};

# The package's language or package management ecosystem.
public type SecurityAdvisoryEcosystems "rubygems"|"npm"|"pip"|"maven"|"nuget"|"composer"|"go"|"rust"|"erlang"|"actions"|"pub"|"other"|"swift";

# Represents a 'commit' secret scanning location type. This location type shows that a secret was detected inside a commit to a repository.
public type SecretScanningLocationCommit record {
    # The file path in the repository
    string path;
    # Line number at which the secret starts in the file
    decimal start_line;
    # Line number at which the secret ends in the file
    decimal end_line;
    # The column at which the secret starts within the start line when the file is interpreted as 8BIT ASCII
    decimal start_column;
    # The column at which the secret ends within the end line when the file is interpreted as 8BIT ASCII
    decimal end_column;
    # SHA-1 hash ID of the associated blob
    string blob_sha;
    # The API URL to get the associated blob resource
    string blob_url;
    # SHA-1 hash ID of the associated commit
    string commit_sha;
    # The API URL to get the associated commit resource
    string commit_url;
};

# Prevent merge commits from being pushed to matching refs.
public type RepositoryRuleRequiredLinearHistory record {
    "required_linear_history" 'type;
};

# Check runs can accept a variety of data in the `output` object, including a `title` and `summary` and can optionally provide descriptive details about the run.
public type Reposownerrepocheckrunscheck_run_id_output record {
    # **Required**.
    string title?;
    # Can contain Markdown.
    @constraint:String {maxLength: 65535}
    string summary;
    # Can contain Markdown.
    @constraint:String {maxLength: 65535}
    string text?;
    # Adds information from your analysis to specific lines of code. Annotations are visible in GitHub's pull request UI. Annotations are visible in GitHub's pull request UI. The Checks API limits the number of annotations to a maximum of 50 per API request. To create more than 50 annotations, you have to make multiple requests to the [Update a check run](https://docs.github.com/rest/checks/runs#update-a-check-run) endpoint. Each time you update the check run, annotations are appended to the list of annotations that already exist for the check run. GitHub Actions are limited to 10 warning annotations and 10 error annotations per step. For details about annotations in the UI, see "[About status checks](https://docs.github.com/articles/about-status-checks#checks)".
    @constraint:Array {maxLength: 50}
    Reposownerrepocheckruns_output_annotations[] annotations?;
    # Adds images to the output displayed in the GitHub pull request UI.
    Reposownerrepocheckruns_output_images[] images?;
};

# The object used to create GitHub Pages deployment
public type Pages_deployment_body record {
    # The URL of an artifact that contains the .zip or .tar of static assets to deploy. The artifact belongs to the repository.
    string artifact_url;
    # The target environment for this GitHub Pages deployment.
    string environment = "github-pages";
    # A unique string that represents the version of the build for this deployment.
    string pages_build_version;
    # The OIDC token issued by GitHub Actions certifying the origin of the deployment.
    string oidc_token;
};

public type Inline_response_403 record {
    Inline_response_403_block block?;
    string message?;
    string documentation_url?;
};

# A repository on GitHub.
public type NullableRepository record {
    # Unique identifier of the repository
    int id;
    string node_id;
    # The name of the repository.
    string name;
    string full_name;
    # License Simple
    NullableLicenseSimple? license;
    # A GitHub user.
    NullableSimpleUser? organization?;
    int forks;
    Repository_permissions permissions?;
    # A GitHub user.
    SimpleUser owner;
    # Whether the repository is private or public.
    boolean 'private;
    string html_url;
    string? description;
    boolean 'fork;
    string url;
    string archive_url;
    string assignees_url;
    string blobs_url;
    string branches_url;
    string collaborators_url;
    string comments_url;
    string commits_url;
    string compare_url;
    string contents_url;
    string contributors_url;
    string deployments_url;
    string downloads_url;
    string events_url;
    string forks_url;
    string git_commits_url;
    string git_refs_url;
    string git_tags_url;
    string git_url;
    string issue_comment_url;
    string issue_events_url;
    string issues_url;
    string keys_url;
    string labels_url;
    string languages_url;
    string merges_url;
    string milestones_url;
    string notifications_url;
    string pulls_url;
    string releases_url;
    string ssh_url;
    string stargazers_url;
    string statuses_url;
    string subscribers_url;
    string subscription_url;
    string tags_url;
    string teams_url;
    string trees_url;
    string clone_url;
    string? mirror_url;
    string hooks_url;
    string svn_url;
    string? homepage;
    string? language;
    int forks_count;
    int stargazers_count;
    int watchers_count;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0.
    int size;
    # The default branch of the repository.
    string default_branch;
    int open_issues_count;
    # Whether this repository acts as a template that can be used to generate new repositories.
    boolean is_template = false;
    string[] topics?;
    # Whether issues are enabled.
    boolean has_issues;
    # Whether projects are enabled.
    boolean has_projects;
    # Whether the wiki is enabled.
    boolean has_wiki;
    boolean has_pages;
    # Whether downloads are enabled.
    boolean has_downloads;
    # Whether discussions are enabled.
    boolean has_discussions = false;
    # Whether the repository is archived.
    boolean archived;
    # Returns whether or not this repository disabled.
    boolean disabled;
    # The repository visibility: public, private, or internal.
    string visibility = "public";
    string? pushed_at;
    string? created_at;
    string? updated_at;
    # Whether to allow rebase merges for pull requests.
    boolean allow_rebase_merge = true;
    Repository_template_repository? template_repository?;
    string temp_clone_token?;
    # Whether to allow squash merges for pull requests.
    boolean allow_squash_merge = true;
    # Whether to allow Auto-merge to be used on pull requests.
    boolean allow_auto_merge = false;
    # Whether to delete head branches when pull requests are merged
    boolean delete_branch_on_merge = false;
    # Whether or not a pull request head branch that is behind its base branch can always be updated even if it is not required to be up to date before merging.
    boolean allow_update_branch = false;
    # Whether a squash merge commit can use the pull request title as default. **This property has been deprecated. Please use `squash_merge_commit_title` instead.
    boolean use_squash_pr_title_as_default = false;
    # The default value for a squash merge commit title:
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `COMMIT_OR_PR_TITLE` - default to the commit's title (if only one commit) or the pull request's title (when more than one commit).
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squash_merge_commit_title?;
    # The default value for a squash merge commit message:
    # 
    # - `PR_BODY` - default to the pull request's body.
    # - `COMMIT_MESSAGES` - default to the branch's commit messages.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squash_merge_commit_message?;
    # The default value for a merge commit title.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `MERGE_MESSAGE` - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name).
    "PR_TITLE"|"MERGE_MESSAGE" merge_commit_title?;
    # The default value for a merge commit message.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `PR_BODY` - default to the pull request's body.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"PR_TITLE"|"BLANK" merge_commit_message?;
    # Whether to allow merge commits for pull requests.
    boolean allow_merge_commit = true;
    # Whether to allow forking this repo
    boolean allow_forking?;
    # Whether to require contributors to sign off on web-based commits
    boolean web_commit_signoff_required = false;
    int subscribers_count?;
    int network_count?;
    int open_issues;
    int watchers;
    string master_branch?;
    string starred_at?;
    # Whether anonymous git access is enabled for this repository
    boolean anonymous_access_enabled?;
};

public type Gistsimple_files record {
    string filename?;
    string 'type?;
    string language?;
    string raw_url?;
    int size?;
    boolean truncated?;
    string content?;
};

public type Topicsearchresultitem_topic_relation record {
    int id?;
    string name?;
    int topic_id?;
    string relation_type?;
};

public type Gists_gist_id_body record {
    # The description of the gist.
    string description?;
    # The gist files to be updated, renamed, or deleted. Each `key` must match the current filename
    # (including extension) of the targeted gist file. For example: `hello.py`.
    # 
    # To delete a file, set the whole file to null. For example: `hello.py : null`. The file will also be
    # deleted if the specified object does not contain at least one of `content` or `filename`.
    record {|Gistsgist_id_files?...;|} files?;
};

public type Timelinereviewedevent__links record {
    Timelinereviewedevent__links_html html;
    Timelinereviewedevent__links_html pull_request;
};

# GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
public type NullableIntegration record {
    # Unique identifier of the GitHub app
    int id;
    # The slug name of the GitHub app
    string slug?;
    string node_id;
    # A GitHub user.
    NullableSimpleUser? owner;
    # The name of the GitHub app
    string name;
    string? description;
    string external_url;
    string html_url;
    string created_at;
    string updated_at;
    # The set of permissions for the GitHub app
    Integration_permissions permissions;
    # The list of events for the GitHub app
    string[] events;
    # The number of installations associated with the GitHub app
    int installations_count?;
    string client_id?;
    string client_secret?;
    string? webhook_secret?;
    string pem?;
};

# GitHub Actions Cache Usage by repository.
public type ActionsCacheUsageByRepositoryResponse record {
    int total_count;
    ActionsCacheUsageByRepository[] repository_cache_usages;
};

# Actor
public type Actor record {
    int id;
    string login;
    string display_login?;
    string? gravatar_id;
    string url;
    string avatar_url;
};

# Validation Error
public type ValidationError record {
    string message;
    string documentation_url;
    Validationerror_errors[] errors?;
};

public type SecretScanningAlert record {
    # The security alert number.
    AlertNumber number?;
    # The time that the alert was created in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertCreatedAt created_at?;
    # The time that the alert was last updated in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    NullableAlertUpdatedAt? updated_at?;
    # The REST API URL of the alert resource.
    AlertUrl url?;
    # The GitHub URL of the alert resource.
    AlertHtmlUrl html_url?;
    # The REST API URL of the code locations for this alert.
    string locations_url?;
    # Sets the state of the secret scanning alert. You must provide `resolution` when you set the state to `resolved`.
    SecretScanningAlertState state?;
    # **Required when the `state` is `resolved`.** The reason for resolving the alert.
    SecretScanningAlertResolution? resolution?;
    # The time that the alert was resolved in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    string? resolved_at?;
    # A GitHub user.
    NullableSimpleUser? resolved_by?;
    # An optional comment to resolve an alert.
    string? resolution_comment?;
    # The type of secret that secret scanning detected.
    string secret_type?;
    # User-friendly name for the detected secret, matching the `secret_type`.
    # For a list of built-in patterns, see "[Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns#supported-secrets-for-advanced-security)."
    string secret_type_display_name?;
    # The secret that was detected.
    string secret?;
    # Whether push protection was bypassed for the detected secret.
    boolean? push_protection_bypassed?;
    # A GitHub user.
    NullableSimpleUser? push_protection_bypassed_by?;
    # The time that push protection was bypassed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    string? push_protection_bypassed_at?;
};

public type Actions_permissions_body_1 record {
    # Whether GitHub Actions is enabled on the repository.
    ActionsEnabled enabled;
    # The permissions policy that controls the actions and reusable workflows that are allowed to run.
    AllowedActions allowed_actions?;
};

public type Gpgkey_emails record {
    string email?;
    boolean verified?;
};

public type Orgs_org_body_1 record {
    # The state that the membership should be in. Only `"active"` will be accepted.
    "active" state;
};

public type Pull_number_comments_body record {
    # The text of the review comment.
    string body;
    # The SHA of the commit needing a comment. Not using the latest commit SHA may render your comment outdated if a subsequent commit modifies the line you specify as the `position`.
    string commit_id;
    # The relative path to the file that necessitates a comment.
    string path;
    # **This parameter is deprecated. Use `line` instead**. The position in the diff where you want to add a review comment. Note this value is not the same as the line number in the file. For help finding the position value, read the note above.
    int position?;
    # In a split diff view, the side of the diff that the pull request's changes appear on. Can be `LEFT` or `RIGHT`. Use `LEFT` for deletions that appear in red. Use `RIGHT` for additions that appear in green or unchanged lines that appear in white and are shown for context. For a multi-line comment, side represents whether the last line of the comment range is a deletion or addition. For more information, see "[Diff view options](https://docs.github.com/articles/about-comparing-branches-in-pull-requests#diff-view-options)" in the GitHub Help documentation.
    "LEFT"|"RIGHT" side?;
    # **Required unless using `subject_type:file`**. The line of the blob in the pull request diff that the comment applies to. For a multi-line comment, the last line of the range that your comment applies to.
    int line?;
    # **Required when using multi-line comments unless using `in_reply_to`**. The `start_line` is the first line in the pull request diff that your multi-line comment applies to. To learn more about multi-line comments, see "[Commenting on a pull request](https://docs.github.com/articles/commenting-on-a-pull-request#adding-line-comments-to-a-pull-request)" in the GitHub Help documentation.
    int start_line?;
    # **Required when using multi-line comments unless using `in_reply_to`**. The `start_side` is the starting side of the diff that the comment applies to. Can be `LEFT` or `RIGHT`. To learn more about multi-line comments, see "[Commenting on a pull request](https://docs.github.com/articles/commenting-on-a-pull-request#adding-line-comments-to-a-pull-request)" in the GitHub Help documentation. See `side` in this table for additional context.
    "LEFT"|"RIGHT"|"side" start_side?;
    # The ID of the review comment to reply to. To find the ID of a review comment with ["List review comments on a pull request"](#list-review-comments-on-a-pull-request). When specified, all parameters other than `body` in the request body are ignored.
    int in_reply_to?;
    # The level at which the comment is targeted.
    "line"|"file" subject_type?;
};

# **Required when the `state` is `resolved`.** The reason for resolving the alert.
public type SecretScanningAlertResolution "false_positive"|"wont_fix"|"revoked"|"used_in_tests";

public type DeploymentBranchPolicyNamePatternWithType record {
    # The name pattern that branches or tags must match in order to deploy to the environment.
    # 
    # Wildcard characters will not match `/`. For example, to match branches that begin with `release/` and contain an additional single slash, use `release/*/*`.
    # For more information about pattern matching syntax, see the [Ruby File.fnmatch documentation](https://ruby-doc.org/core-2.5.1/File.html#method-c-fnmatch).
    string name;
    # Whether this rule targets a branch or tag
    "branch"|"tag" 'type?;
};

public type Authorization_app record {
    string client_id;
    string name;
    string url;
};

# Commit Search Result Item
public type CommitSearchResultItem record {
    string url;
    string sha;
    string html_url;
    string comments_url;
    Commitsearchresultitem_commit 'commit;
    # A GitHub user.
    NullableSimpleUser? author;
    # Metaproperties for Git author/committer information.
    NullableGitUser? committer;
    Filecommit_commit_parents[] parents;
    # Minimal Repository
    MinimalRepository repository;
    decimal score;
    string node_id;
    SearchResultTextMatches text_matches?;
};

public type Dependency record {|
    # Package-url (PURL) of dependency. See https://github.com/package-url/purl-spec for more details.
    @constraint:String {pattern: re `^pkg`}
    string package_url?;
    # User-defined metadata to store domain-specific information limited to 8 keys with scalar values.
    Metadata metadata?;
    # A notation of whether a dependency is requested directly by this manifest or is a dependency of another dependency.
    "direct"|"indirect" relationship?;
    # A notation of whether the dependency is required for the primary build artifact (runtime) or is only used for development. Future versions of this specification may allow for more granular scopes.
    "runtime"|"development" scope?;
    # Array of package-url (PURLs) of direct child dependencies.
    string[] dependencies?;
|};

public type Restrictions_apps_body record {
    # The GitHub Apps that have push access to this branch. Use the slugified version of the app name. **Note**: The list of users, apps, and teams in total is limited to 100 items.
    string[] apps;
}|string[];

public type ReviewCustomGatesStateRequired record {
    # The name of the environment to approve or reject.
    string environment_name;
    # Whether to approve or reject deployment to the specified environments.
    "approved"|"rejected" state;
    # Optional comment to include with the review.
    string comment?;
};

# Projects are a way to organize columns and cards of work.
public type Project record {
    string owner_url;
    string url;
    string html_url;
    string columns_url;
    int id;
    string node_id;
    # Name of the project
    string name;
    # Body of the project
    string? body;
    int number;
    # State of the project; either 'open' or 'closed'
    string state;
    # A GitHub user.
    NullableSimpleUser? creator;
    string created_at;
    string updated_at;
    # The baseline permission that all organization members have on this project. Only present if owner is an organization.
    "read"|"write"|"admin"|"none" organization_permission?;
    # Whether or not this project can be seen by everyone. Only present if owner is an organization.
    boolean 'private?;
};

public type Pull_number_merge_body record {
    # Title for the automatic commit message.
    string commit_title?;
    # Extra detail to append to automatic commit message.
    string commit_message?;
    # SHA that pull request head must match to allow merge.
    string sha?;
    # The merge method to use.
    "merge"|"squash"|"rebase" merge_method?;
};

# Topic Search Result Item
public type TopicSearchResultItem record {
    string name;
    string? display_name;
    string? short_description;
    string? description;
    string? created_by;
    string? released;
    string created_at;
    string updated_at;
    boolean featured;
    boolean curated;
    decimal score;
    int? repository_count?;
    string? logo_url?;
    SearchResultTextMatches text_matches?;
    Topicsearchresultitem_related[]? related?;
    Topicsearchresultitem_related[]? aliases?;
};

public type Pullrequestsimple__links record {
    # Hypermedia Link
    Link comments;
    # Hypermedia Link
    Link commits;
    # Hypermedia Link
    Link statuses;
    # Hypermedia Link
    Link html;
    # Hypermedia Link
    Link issue;
    # Hypermedia Link
    Link review_comments;
    # Hypermedia Link
    Link review_comment;
    # Hypermedia Link
    Link self;
};

public type Comment_number_reactions_body_1 record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the team discussion comment.
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

public type Teams_team_slug_body record {
    # The name of the team.
    string name?;
    # The description of the team.
    string description?;
    # The level of privacy this team should have. Editing teams without specifying this parameter leaves `privacy` intact. When a team is nested, the `privacy` for parent teams cannot be `secret`. The options are:  
    # **For a non-nested team:**  
    #  * `secret` - only visible to organization owners and members of this team.  
    #  * `closed` - visible to all members of this organization.  
    # **For a parent or child team:**  
    #  * `closed` - visible to all members of this organization.
    "secret"|"closed" privacy?;
    # The notification setting the team has chosen. Editing teams without specifying this parameter leaves `notification_setting` intact. The options are: 
    #  * `notifications_enabled` - team members receive notifications when the team is @mentioned.  
    #  * `notifications_disabled` - no one receives notifications.
    "notifications_enabled"|"notifications_disabled" notification_setting?;
    # **Deprecated**. The permission that new repositories will be added to the team with when none is specified.
    "pull"|"push"|"admin" permission?;
    # The ID of a team to set as the parent team.
    int? parent_team_id?;
};

public type User_social_accounts_body_1 record {
    # Full URLs for the social media profiles to delete.
    string[] account_urls;
};

public type Pullrequestsimple_head record {
    string label;
    string ref;
    # A repository on GitHub.
    Repository? repo;
    string sha;
    # A GitHub user.
    NullableSimpleUser? user;
};

# Set secrets for GitHub Actions.
public type ActionsSecretResponse record {
    int total_count;
    ActionsSecret[] secrets;
};

public type Dependencygraphspdxsbom_sbom_externalRefs record {
    # The category of reference to an external resource this reference refers to.
    string referenceCategory;
    # A locator for the particular external resource this reference refers to.
    string referenceLocator;
    # The category of reference to an external resource this reference refers to.
    string referenceType;
};

# A codespace.
public type Codespace record {
    int id;
    # Automatically generated name of this codespace.
    string name;
    # Display name for this codespace.
    string? display_name?;
    # UUID identifying this codespace's environment.
    string? environment_id;
    # A GitHub user.
    SimpleUser owner;
    # A GitHub user.
    SimpleUser billable_owner;
    # Minimal Repository
    MinimalRepository repository;
    # A description of the machine powering a codespace.
    NullableCodespaceMachine? machine;
    # Path to devcontainer.json from repo root used to create Codespace.
    string? devcontainer_path?;
    # Whether the codespace was created from a prebuild.
    boolean? prebuild;
    string created_at;
    string updated_at;
    # Last known time this codespace was started.
    string last_used_at;
    # State of this codespace.
    "Unknown"|"Created"|"Queued"|"Provisioning"|"Available"|"Awaiting"|"Unavailable"|"Deleted"|"Moved"|"Shutdown"|"Archived"|"Starting"|"ShuttingDown"|"Failed"|"Exporting"|"Updating"|"Rebuilding" state;
    # API URL for this codespace.
    string url;
    # Details about the codespace's git repository.
    Codespace_git_status git_status;
    # The initally assigned location of a new codespace.
    "EastUs"|"SouthEastAsia"|"WestEurope"|"WestUs2" location;
    # The number of minutes of inactivity after which this codespace will be automatically stopped.
    int? idle_timeout_minutes;
    # URL to access this codespace on the web.
    string web_url;
    # API URL to access available alternate machine types for this codespace.
    string machines_url;
    # API URL to start this codespace.
    string start_url;
    # API URL to stop this codespace.
    string stop_url;
    # API URL to publish this codespace to a new repository.
    string? publish_url?;
    # API URL for the Pull Request associated with this codespace, if any.
    string? pulls_url;
    string[] recent_folders;
    Codespace_runtime_constraints runtime_constraints?;
    # Whether or not a codespace has a pending async operation. This would mean that the codespace is temporarily unavailable. The only thing that you can do with a codespace in this state is delete it.
    boolean? pending_operation?;
    # Text to show user when codespace is disabled by a pending operation
    string? pending_operation_disabled_reason?;
    # Text to show user when codespace idle timeout minutes has been overriden by an organization policy
    string? idle_timeout_notice?;
    # Duration in minutes after codespace has gone idle in which it will be deleted. Must be integer minutes between 0 and 43200 (30 days).
    int? retention_period_minutes?;
    # When a codespace will be auto-deleted based on the "retention_period_minutes" and "last_used_at"
    string? retention_expires_at?;
    # The text to display to a user when a codespace has been stopped for a potentially actionable reason.
    string? last_known_stop_notice?;
};

# Labeled Issue Event
public type LabeledIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    Labeledissueevent_label label;
};

# Tag protection
public type TagProtection record {
    int id?;
    string created_at?;
    string updated_at?;
    boolean enabled?;
    string pattern;
};

public type Traffic record {
    string timestamp;
    int uniques;
    int count;
};

public type ActionsBillingUsage record {
    # The sum of the free and paid GitHub Actions minutes used.
    int total_minutes_used;
    # The total paid GitHub Actions minutes used.
    int total_paid_minutes_used;
    # The amount of free GitHub Actions minutes available.
    int included_minutes;
    Actionsbillingusage_minutes_used_breakdown minutes_used_breakdown;
};

public type Discussion_number_reactions_body_1 record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the team discussion.
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

public type Pullrequestreviewcomment__links_self record {
    string href;
};

public type Repository_permissions record {
    boolean admin;
    boolean pull;
    boolean triage?;
    boolean push;
    boolean maintain?;
};

# Response
public type RuleSuites Rulesuites_inner[];

public type Repo_projects_body record {
    # The name of the project.
    string name;
    # The description of the project.
    string body?;
};

# Repository Collaborator Permission
public type RepositoryCollaboratorPermission record {
    string permission;
    string role_name;
    # Collaborator
    NullableCollaborator? user;
};

public type Template_repo_generate_body record {
    # The organization or person who will own the new repository. To create a new repository in an organization, the authenticated user must be a member of the specified organization.
    string owner?;
    # The name of the new repository.
    string name;
    # A short description of the new repository.
    string description?;
    # Set to `true` to include the directory structure and files from all branches in the template repository, and not just the default branch. Default: `false`.
    boolean include_all_branches = false;
    # Either `true` to create a new private repository or `false` to create a new public one.
    boolean 'private = false;
};

public type Repo_import_body record {
    # The URL of the originating repository.
    string vcs_url;
    # The originating VCS type. Without this parameter, the import job will take additional time to detect the VCS type before beginning the import. This detection step will be reflected in the response.
    "subversion"|"git"|"mercurial"|"tfvc" vcs?;
    # If authentication is required, the username to provide to `vcs_url`.
    string vcs_username?;
    # If authentication is required, the password to provide to `vcs_url`.
    string vcs_password?;
    # For a tfvc import, the name of the project that is being imported.
    string tfvc_project?;
};

public type User_ssh_signing_keys_body record {
    # A descriptive name for the new key.
    string title?;
    # The public SSH key to add to your GitHub account. For more information, see "[Checking for existing SSH keys](https://docs.github.com/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys)."
    @constraint:String {pattern: re `^ssh-(rsa|dss|ed25519) |^ecdsa-sha2-nistp(256|384|521) |^(sk-ssh-ed25519|sk-ecdsa-sha2-nistp256)@openssh.com `}
    string 'key;
};

# Rate Limit Overview
public type RateLimitOverview record {
    Ratelimitoverview_resources resources;
    RateLimit rate;
};

# A repository rule.
public type RepositoryRule RepositoryRuleCreation|RepositoryRuleUpdate|RepositoryRuleDeletion|RepositoryRuleRequiredLinearHistory|RepositoryRuleRequiredDeployments|RepositoryRuleRequiredSignatures|RepositoryRulePullRequest|RepositoryRuleRequiredStatusChecks|RepositoryRuleNonFastForward|RepositoryRuleCommitMessagePattern|RepositoryRuleCommitAuthorEmailPattern|RepositoryRuleCommitterEmailPattern|RepositoryRuleBranchNamePattern|RepositoryRuleTagNamePattern;

# Sets the state of the secret scanning alert. You must provide `resolution` when you set the state to `resolved`.
public type SecretScanningAlertState "open"|"resolved";

public type Pendingdeployment_reviewers record {
    # The type of reviewer.
    DeploymentReviewerType 'type?;
    SimpleUser|Team reviewer?;
};

public type Reposownerrepogittrees_tree record {
    # The file referenced in the tree.
    string path?;
    # The file mode; one of `100644` for file (blob), `100755` for executable (blob), `040000` for subdirectory (tree), `160000` for submodule (commit), or `120000` for a blob that specifies the path of a symlink.
    "100644"|"100755"|"040000"|"160000"|"120000" mode?;
    # Either `blob`, `tree`, or `commit`.
    "blob"|"tree"|"commit" 'type?;
    # The SHA1 checksum ID of the object in the tree. Also called `tree.sha`. If the value is `null` then the file will be deleted.  
    #   
    # **Note:** Use either `tree.sha` or `content` to specify the contents of the entry. Using both `tree.sha` and `content` will return an error.
    string? sha?;
    # The content you want this file to have. GitHub will write this blob out and use that SHA for this entry. Use either this, or `tree.sha`.  
    #   
    # **Note:** Use either `tree.sha` or `content` to specify the contents of the entry. Using both `tree.sha` and `content` will return an error.
    string content?;
};

public type Deployment_id_statuses_body record {
    # The state of the status. When you set a transient deployment to `inactive`, the deployment will be shown as `destroyed` in GitHub.
    "error"|"failure"|"inactive"|"in_progress"|"queued"|"pending"|"success" state;
    # The target URL to associate with this status. This URL should contain output to keep the user updated while the task is running or serve as historical information for what happened in the deployment. **Note:** It's recommended to use the `log_url` parameter, which replaces `target_url`.
    string target_url = "";
    # The full URL of the deployment's output. This parameter replaces `target_url`. We will continue to accept `target_url` to support legacy uses, but we recommend replacing `target_url` with `log_url`. Setting `log_url` will automatically set `target_url` to the same value. Default: `""`
    string log_url = "";
    # A short description of the status. The maximum description length is 140 characters.
    string description = "";
    # Name for the target deployment environment, which can be changed when setting a deploy status. For example, `production`, `staging`, or `qa`. If not defined, the environment of the previous status on the deployment will be used, if it exists. Otherwise, the environment of the deployment will be used.
    string environment?;
    # Sets the URL for accessing your environment. Default: `""`
    string environment_url = "";
    # Adds a new `inactive` status to all prior non-transient, non-production environment deployments with the same repository and `environment` name as the created status's deployment. An `inactive` status is only added to deployments that had a `success` state. Default: `true`
    boolean auto_inactive?;
};

public type Basegist_files record {
    string filename?;
    string 'type?;
    string language?;
    string raw_url?;
    int size?;
};

public type Filecommit_content__links record {
    string self?;
    string git?;
    string html?;
};

# Parameters to be used for the commit_message_pattern rule
public type RepositoryRuleCommitMessagePattern record {
    "commit_message_pattern" 'type;
    Repositoryrulecommitmessagepattern_parameters parameters?;
};

# The amount of time to delay a job after the job is initially triggered. The time (in minutes) must be an integer between 0 and 43,200 (30 days).
public type WaitTimer int;

public type Repositoryrulepullrequest_parameters record {
    # New, reviewable commits pushed will dismiss previous pull request review approvals.
    boolean dismiss_stale_reviews_on_push;
    # Require an approving review in pull requests that modify files that have a designated code owner.
    boolean require_code_owner_review;
    # Whether the most recent reviewable push must be approved by someone other than the person who pushed it.
    boolean require_last_push_approval;
    # The number of approving reviews that are required before a pull request can be merged.
    @constraint:Int {minValue: 0, maxValue: 10}
    int required_approving_review_count;
    # All conversations on code must be resolved before a pull request can be merged.
    boolean required_review_thread_resolution;
};

public type Globaladvisory_vulnerabilities record {
    # The name of the package affected by the vulnerability.
    Globaladvisory_package? package;
    # The range of the package versions affected by the vulnerability.
    string? vulnerable_version_range;
    # The package version that resolve the vulnerability.
    string? first_patched_version;
    # The functions in the package that are affected by the vulnerability.
    string[]? vulnerable_functions;
};

# Requested permissions that elevate access for a previously approved request for access, categorized by type of permission.
public type Personalaccesstokenrequest_permissions_upgraded record {
    record {|string...;|} organization?;
    record {|string...;|} repository?;
    record {|string...;|} other?;
};

public type Inline_response_403_2 record {
    string message?;
    string documentation_url?;
    Inline_response_403_2_errors[] errors?;
};

# A unique encryption key
public type GpgKey record {
    int id;
    string? name?;
    int? primary_key_id;
    string key_id;
    string public_key;
    Gpgkey_emails[] emails;
    Gpgkey_subkeys[] subkeys;
    boolean can_sign;
    boolean can_encrypt_comms;
    boolean can_encrypt_storage;
    boolean can_certify;
    string created_at;
    string? expires_at;
    boolean revoked;
    string? raw_key;
};

public type Inline_response_403_1 record {
    string message?;
    string documentation_url?;
    string[] errors?;
};

public type Owner_repo_body record {
    # The permission to grant the team on this repository. We accept the following permissions to be set: `pull`, `triage`, `push`, `maintain`, `admin` and you can also specify a custom repository role name, if the owning organization has defined any. If no permission is specified, the team's `permission` attribute will be used to determine what permission to grant the team on this repository.
    string permission?;
};

public type Globaladvisory_identifiers record {
    # The type of identifier.
    "CVE"|"GHSA" 'type;
    # The identifier value.
    string value;
};

public type Marketplacepurchase_marketplace_purchase record {
    string billing_cycle?;
    string? next_billing_date?;
    boolean is_installed?;
    int? unit_count?;
    boolean on_free_trial?;
    string? free_trial_ends_on?;
    string updated_at?;
    # Marketplace Listing Plan
    MarketplaceListingPlan plan?;
};

# Color-coded labels help you categorize and filter your issues (just like labels in Gmail).
public type Label record {
    int id;
    string node_id;
    # URL for the label
    string url;
    # The name of the label.
    string name;
    string? description;
    # 6-character hex code, without the leading #, identifying the color
    string color;
    boolean default;
};

# License Content
public type LicenseContent record {
    string name;
    string path;
    string sha;
    int size;
    string url;
    string? html_url;
    string? git_url;
    string? download_url;
    string 'type;
    string content;
    string encoding;
    Contenttree__links _links;
    # License Simple
    NullableLicenseSimple? license;
};

# A label for a self hosted runner
public type RunnerLabelResponse record {
    int total_count;
    RunnerLabel[] labels;
};

public type ActionsRepositoryPermissions record {
    # Whether GitHub Actions is enabled on the repository.
    ActionsEnabled enabled;
    # The permissions policy that controls the actions and reusable workflows that are allowed to run.
    AllowedActions allowed_actions?;
    # The API URL to use to get or set the actions and reusable workflows that are allowed to run, when `allowed_actions` is set to `selected`.
    SelectedActionsUrl selected_actions_url?;
};

public type Repositoryrulesetconditionsrepositoryidtarget_repository_id record {
    # The repository IDs that the ruleset applies to. One of these IDs must match for the condition to pass.
    int[] repository_ids?;
};

public type Contenttree__links record {
    string? git;
    string? html;
    string self;
};

public type Issue_pull_request record {
    string? merged_at?;
    string? diff_url;
    string? html_url;
    string? patch_url;
    string? url;
};

public type CodeScanningAlert record {
    # The security alert number.
    AlertNumber number;
    # The time that the alert was created in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertCreatedAt created_at;
    # The time that the alert was last updated in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertUpdatedAt updated_at?;
    # The REST API URL of the alert resource.
    AlertUrl url;
    # The GitHub URL of the alert resource.
    AlertHtmlUrl html_url;
    # The REST API URL for fetching the list of instances for an alert.
    AlertInstancesUrl instances_url;
    # State of a code scanning alert.
    CodeScanningAlertState state;
    # The time that the alert was no longer detected and was considered fixed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertFixedAt? fixed_at?;
    # A GitHub user.
    NullableSimpleUser? dismissed_by;
    # The time that the alert was dismissed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertDismissedAt? dismissed_at;
    # **Required when the state is dismissed.** The reason for dismissing or closing the alert.
    CodeScanningAlertDismissedReason? dismissed_reason;
    # The dismissal comment associated with the dismissal of the alert.
    CodeScanningAlertDismissedComment? dismissed_comment?;
    CodeScanningAlertRule rule;
    CodeScanningAnalysisTool tool;
    CodeScanningAlertInstance most_recent_instance;
};

public type Billing_selected_teams_body record {
    # List of team names within the organization to which to grant access to GitHub Copilot.
    @constraint:Array {minLength: 1}
    string[] selected_teams;
};

public type Collaborators_username_body record {
    # The permission to grant the collaborator.
    "read"|"write"|"admin" permission?;
};

public type Repo_hooks_body record {|
    # Use `web` to create a webhook. Default: `web`. This parameter only accepts the value `web`.
    string name?;
    # Key/value pairs to provide settings for this webhook.
    Reposownerrepohooks_config config?;
    # Determines what [events](https://docs.github.com/webhooks/event-payloads) the hook is triggered for.
    string[] events?;
    # Determines if notifications are sent when the webhook is triggered. Set to `true` to send notifications.
    boolean active?;
|};

# A GitHub user simplified for Classroom.
public type SimpleClassroomUser record {
    int id;
    string login;
    string avatar_url;
    string html_url;
};

# Set secrets for Dependabot.
public type DependabotSecretResponse record {
    int total_count;
    DependabotSecret[] secrets;
};

public type Memberships_username_body_1 record {
    # The role that this user should have in the team.
    "member"|"maintainer" role?;
};

# Interaction limit settings.
public type InteractionLimitResponseAny InteractionLimitResponse|record {||};

public type Memberships_username_body_2 record {
    # The role that this user should have in the team.
    "member"|"maintainer" role?;
};

# Actions OIDC Subject customization
public type OidcCustomSub record {
    # Array of unique strings. Each claim key can only contain alphanumeric characters and underscores.
    string[] include_claim_keys;
};

public type Issue_number_reactions_body record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the issue.
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

# A set of rules to apply when specified conditions are met.
public type RepositoryRuleset record {
    # The ID of the ruleset
    int id;
    # The name of the ruleset
    string name;
    # The target of the ruleset
    "branch"|"tag" target?;
    # The type of the source of the ruleset
    "Repository"|"Organization" source_type?;
    # The name of the source
    string 'source;
    # The enforcement level of the ruleset. `evaluate` allows admins to test rules before enforcing them. Admins can view insights on the Rule Insights page (`evaluate` is only available with GitHub Enterprise).
    RepositoryRuleEnforcement enforcement;
    # The actors that can bypass the rules in this ruleset
    RepositoryRulesetBypassActor[] bypass_actors?;
    # The bypass type of the user making the API request for this ruleset. This field is only returned when
    # querying the repository-level endpoint.
    "always"|"pull_requests_only"|"never" current_user_can_bypass?;
    string node_id?;
    Repositoryruleset__links _links?;
    RepositoryRulesetConditions|OrgRulesetConditions conditions?;
    RepositoryRule[] rules?;
    string created_at?;
    string updated_at?;
};

public type Pageshealthcheck_domain record {
    string host?;
    string uri?;
    string nameservers?;
    boolean dns_resolves?;
    boolean? is_proxied?;
    boolean? is_cloudflare_ip?;
    boolean? is_fastly_ip?;
    boolean? is_old_ip_address?;
    boolean? is_a_record?;
    boolean? has_cname_record?;
    boolean? has_mx_records_present?;
    boolean is_valid_domain?;
    boolean is_apex_domain?;
    boolean? should_be_a_record?;
    boolean? is_cname_to_github_user_domain?;
    boolean? is_cname_to_pages_dot_github_dot_com?;
    boolean? is_cname_to_fastly?;
    boolean? is_pointed_to_github_pages_ip?;
    boolean? is_non_github_pages_ip_present?;
    boolean is_pages_domain?;
    boolean? is_served_by_pages?;
    boolean is_valid?;
    string? reason?;
    boolean responds_to_https?;
    boolean enforces_https?;
    string? https_error?;
    boolean? is_https_eligible?;
    string? caa_error?;
};

# The full Git reference, formatted as `refs/heads/<branch name>`,
# `refs/pull/<number>/merge`, or `refs/pull/<number>/head`.
public type CodeScanningRef string;

# Check Automated Security Fixes
public type CheckAutomatedSecurityFixes record {
    # Whether automated security fixes are enabled for the repository.
    boolean enabled;
    # Whether automated security fixes are paused for the repository.
    boolean paused;
};

public type Gisthistory_change_status record {
    int total?;
    int additions?;
    int deletions?;
};

# Clone Traffic
public type CloneTraffic record {
    int count;
    int uniques;
    Traffic[] clones;
};

public type Email_visibility_body record {
    # Denotes whether an email is publicly visible.
    "public"|"private" visibility;
};

public type Access_selected_users_body_1 record {
    # The usernames of the organization members whose codespaces should not be billed to the organization.
    @constraint:Array {maxLength: 100}
    string[] selected_usernames;
};

public type Inline_response_403_block record {
    string reason?;
    string created_at?;
    string? html_url?;
};

public type RepositoryAdvisoryCreate record {|
    # A short summary of the advisory.
    @constraint:String {maxLength: 1024}
    string summary;
    # A detailed description of what the advisory impacts.
    @constraint:String {maxLength: 65535}
    string description;
    # The Common Vulnerabilities and Exposures (CVE) ID.
    string? cve_id?;
    # A product affected by the vulnerability detailed in a repository security advisory.
    Repositoryadvisorycreate_vulnerabilities[] vulnerabilities;
    # A list of Common Weakness Enumeration (CWE) IDs.
    string[]? cwe_ids?;
    # A list of users receiving credit for their participation in the security advisory.
    Repositoryadvisorycreate_credits[]? credits?;
    # The severity of the advisory. You must choose between setting this field or `cvss_vector_string`.
    "critical"|"high"|"medium"|"low" severity?;
    # The CVSS vector that calculates the severity of the advisory. You must choose between setting this field or `severity`.
    string? cvss_vector_string?;
|};

# Code Of Conduct
public type CodeOfConduct record {
    string 'key;
    string name;
    string url;
    string body?;
    string? html_url;
};

# Minimal representation of an organization programmatic access grant request for enumerations
public type OrganizationProgrammaticAccessGrantRequest record {
    # Unique identifier of the request for access via fine-grained personal access token. The `pat_request_id` used to review PAT requests.
    int id;
    # Reason for requesting access.
    string? reason;
    # A GitHub user.
    SimpleUser owner;
    # Type of repository selection requested.
    "none"|"all"|"subset" repository_selection;
    # URL to the list of repositories requested to be accessed via fine-grained personal access token. Should only be followed when `repository_selection` is `subset`.
    string repositories_url;
    # Permissions requested, categorized by type of permission.
    Organizationprogrammaticaccessgrantrequest_permissions permissions;
    # Date and time when the request for access was created.
    string created_at;
    # Whether the associated fine-grained personal access token has expired.
    boolean token_expired;
    # Date and time when the associated fine-grained personal access token expires.
    string? token_expires_at;
    # Date and time when the associated fine-grained personal access token was last used for authentication.
    string? token_last_used_at;
};

public type Workflow_id_dispatches_body record {
    # The git reference for the workflow. The reference can be a branch or tag name.
    string ref;
    # Input keys and values configured in the workflow file. The maximum number of properties is 10. Any default properties configured in the workflow file will be used when `inputs` are omitted.
    record {} inputs?;
};

public type Gists_files record {
    # Content of the file
    string content;
};

public type ActionsSetDefaultWorkflowPermissions record {
    # The default workflow permissions granted to the GITHUB_TOKEN when running workflows.
    ActionsDefaultWorkflowPermissions default_workflow_permissions?;
    # Whether GitHub Actions can approve pull requests. Enabling this can be a security risk.
    ActionsCanApprovePullRequestReviews can_approve_pull_request_reviews?;
};

public type Repositoryrulecommitmessagepattern_parameters record {
    # How this rule will appear to users.
    string name?;
    # If true, the rule will fail if the pattern matches.
    boolean negate?;
    # The operator to use for matching.
    "starts_with"|"ends_with"|"contains"|"regex" operator;
    # The pattern to match with.
    string pattern;
};

# Set repository secrets for GitHub Codespaces.
public type RepoCodespacesSecretResponse record {
    int total_count;
    RepoCodespacesSecret[] secrets;
};

# Contributor
public type Contributor record {
    string login?;
    int id?;
    string node_id?;
    string avatar_url?;
    string? gravatar_id?;
    string url?;
    string html_url?;
    string followers_url?;
    string following_url?;
    string gists_url?;
    string starred_url?;
    string subscriptions_url?;
    string organizations_url?;
    string repos_url?;
    string events_url?;
    string received_events_url?;
    string 'type;
    boolean site_admin?;
    int contributions;
    string email?;
    string name?;
};

# Results of a successful merge upstream request
public type MergedUpstream record {
    string message?;
    "merge"|"fast-forward"|"none" merge_type?;
    string base_branch?;
};

public type Releases_release_id_body record {
    # The name of the tag.
    string tag_name?;
    # Specifies the commitish value that determines where the Git tag is created from. Can be any branch or commit SHA. Unused if the Git tag already exists. Default: the repository's default branch.
    string target_commitish?;
    # The name of the release.
    string name?;
    # Text describing the contents of the tag.
    string body?;
    # `true` makes the release a draft, and `false` publishes the release.
    boolean draft?;
    # `true` to identify the release as a prerelease, `false` to identify the release as a full release.
    boolean prerelease?;
    # Specifies whether this release should be set as the latest release for the repository. Drafts and prereleases cannot be set as latest. Defaults to `true` for newly published releases. `legacy` specifies that the latest release should be determined based on the release creation date and higher semantic version.
    "true"|"false"|"legacy" make_latest?;
    # If specified, a discussion of the specified category is created and linked to the release. The value must be a category that already exists in the repository. If there is already a discussion linked to the release, this parameter is ignored. For more information, see "[Managing categories for discussions in your repository](https://docs.github.com/discussions/managing-discussions-for-your-community/managing-categories-for-discussions-in-your-repository)."
    string discussion_category_name?;
};

public type Pullrequestreviewcomment__links_html record {
    string href;
};

# Whether users can pull changes from upstream when the branch is locked. Set to `true` to allow fork syncing. Set to `false` to prevent fork syncing.
public type Protectedbranch_allow_fork_syncing record {|
    boolean enabled?;
|};

public type RepositoryAdvisoryUpdate record {|
    # A short summary of the advisory.
    @constraint:String {maxLength: 1024}
    string summary?;
    # A detailed description of what the advisory impacts.
    @constraint:String {maxLength: 65535}
    string description?;
    # The Common Vulnerabilities and Exposures (CVE) ID.
    string? cve_id?;
    # A product affected by the vulnerability detailed in a repository security advisory.
    Repositoryadvisorycreate_vulnerabilities[] vulnerabilities?;
    # A list of Common Weakness Enumeration (CWE) IDs.
    string[]? cwe_ids?;
    # A list of users receiving credit for their participation in the security advisory.
    Repositoryadvisorycreate_credits[]? credits?;
    # The severity of the advisory. You must choose between setting this field or `cvss_vector_string`.
    "critical"|"high"|"medium"|"low" severity?;
    # The CVSS vector that calculates the severity of the advisory. You must choose between setting this field or `severity`.
    string? cvss_vector_string?;
    # The state of the advisory.
    "published"|"closed"|"draft" state?;
    # A list of usernames who have been granted write access to the advisory.
    string[]? collaborating_users?;
    # A list of team slugs which have been granted write access to the advisory.
    string[]? collaborating_teams?;
|};

# The status of auto merging a pull request.
public type AutoMerge record {
    # A GitHub user.
    SimpleUser enabled_by;
    # The merge method to use.
    "merge"|"squash"|"rebase" merge_method;
    # Title for the merge commit message.
    string commit_title;
    # Commit message for the merge commit.
    string commit_message;
};

# Key/value pairs to provide settings for this webhook.
public type Orgsorghookshook_id_config record {
    # The URL to which the payloads will be delivered.
    WebhookConfigUrl url;
    # The media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`.
    WebhookConfigContentType content_type?;
    # If provided, the `secret` will be used as the `key` to generate the HMAC hex digest value for [delivery signature headers](https://docs.github.com/webhooks/event-payloads/#delivery-headers).
    WebhookConfigSecret secret?;
    WebhookConfigInsecureSsl insecure_ssl?;
};

public type User_migrations_body record {
    # Lock the repositories being migrated at the start of the migration
    boolean lock_repositories?;
    # Indicates whether metadata should be excluded and only git source should be included for the migration.
    boolean exclude_metadata?;
    # Indicates whether the repository git data should be excluded from the migration.
    boolean exclude_git_data?;
    # Do not include attachments in the migration
    boolean exclude_attachments?;
    # Do not include releases in the migration
    boolean exclude_releases?;
    # Indicates whether projects owned by the organization or users should be excluded.
    boolean exclude_owner_projects?;
    # Indicates whether this should only include organization metadata (repositories array should be empty and will ignore other flags).
    boolean org_metadata_only = false;
    # Exclude attributes from the API response to improve performance
    ("repositories")[] exclude?;
    string[] repositories;
};

public type Comments_comment_id_body_1 record {
    # The contents of the comment
    string body;
};

public type Releases_generatenotes_body record {
    # The tag name for the release. This can be an existing tag or a new one.
    string tag_name;
    # Specifies the commitish value that will be the target for the release's tag. Required if the supplied tag_name does not reference an existing tag. Ignored if the tag_name already exists.
    string target_commitish?;
    # The name of the previous tag to use as the starting point for the release notes. Use to manually specify the range for the set of changes considered as part this release.
    string previous_tag_name?;
    # Specifies a path to a file in the repository containing configuration settings used for generating the release notes. If unspecified, the configuration file located in the repository at '.github/release.yml' or '.github/release.yaml' will be used. If that is not present, the default configuration will be used.
    string configuration_file_path?;
};

public type Environment_name_variables_body record {
    # The name of the variable.
    string name;
    # The value of the variable.
    string value;
};

public type Comments_comment_id_body_3 record {
    # The text of the reply to the review comment.
    string body;
};

public type Comments_comment_id_body_2 record {
    # The contents of the comment.
    string body;
};

public type Org_repos_body record {
    # The name of the repository.
    string name;
    # A short description of the repository.
    string description?;
    # A URL with more information about the repository.
    string homepage?;
    # Whether the repository is private.
    boolean 'private = false;
    # The visibility of the repository.
    "public"|"private" visibility?;
    # Either `true` to enable issues for this repository or `false` to disable them.
    boolean has_issues = true;
    # Either `true` to enable projects for this repository or `false` to disable them. **Note:** If you're creating a repository in an organization that has disabled repository projects, the default is `false`, and if you pass `true`, the API returns an error.
    boolean has_projects = true;
    # Either `true` to enable the wiki for this repository or `false` to disable it.
    boolean has_wiki = true;
    # Whether downloads are enabled.
    boolean has_downloads = true;
    # Either `true` to make this repo available as a template repository or `false` to prevent it.
    boolean is_template = false;
    # The id of the team that will be granted access to this repository. This is only valid when creating a repository in an organization.
    int team_id?;
    # Pass `true` to create an initial commit with empty README.
    boolean auto_init = false;
    # Desired language or platform [.gitignore template](https://github.com/github/gitignore) to apply. Use the name of the template without the extension. For example, "Haskell".
    string gitignore_template?;
    # Choose an [open source license template](https://choosealicense.com/) that best suits your needs, and then use the [license keyword](https://docs.github.com/articles/licensing-a-repository/#searching-github-by-license-type) as the `license_template` string. For example, "mit" or "mpl-2.0".
    string license_template?;
    # Either `true` to allow squash-merging pull requests, or `false` to prevent squash-merging.
    boolean allow_squash_merge = true;
    # Either `true` to allow merging pull requests with a merge commit, or `false` to prevent merging pull requests with merge commits.
    boolean allow_merge_commit = true;
    # Either `true` to allow rebase-merging pull requests, or `false` to prevent rebase-merging.
    boolean allow_rebase_merge = true;
    # Either `true` to allow auto-merge on pull requests, or `false` to disallow auto-merge.
    boolean allow_auto_merge = false;
    # Either `true` to allow automatically deleting head branches when pull requests are merged, or `false` to prevent automatic deletion. **The authenticated user must be an organization owner to set this property to `true`.**
    boolean delete_branch_on_merge = false;
    # Either `true` to allow squash-merge commits to use pull request title, or `false` to use commit message. **This property has been deprecated. Please use `squash_merge_commit_title` instead.
    boolean use_squash_pr_title_as_default = false;
    # The default value for a squash merge commit title:
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `COMMIT_OR_PR_TITLE` - default to the commit's title (if only one commit) or the pull request's title (when more than one commit).
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squash_merge_commit_title?;
    # The default value for a squash merge commit message:
    # 
    # - `PR_BODY` - default to the pull request's body.
    # - `COMMIT_MESSAGES` - default to the branch's commit messages.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squash_merge_commit_message?;
    # The default value for a merge commit title.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `MERGE_MESSAGE` - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name).
    "PR_TITLE"|"MERGE_MESSAGE" merge_commit_title?;
    # The default value for a merge commit message.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `PR_BODY` - default to the pull request's body.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"PR_TITLE"|"BLANK" merge_commit_message?;
};

# Social media account
public type SocialAccount record {
    string provider;
    string url;
};

# Assigned Issue Event
public type AssignedIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    Integration performed_via_github_app;
    # A GitHub user.
    SimpleUser assignee;
    # A GitHub user.
    SimpleUser assigner;
};

public type UserResponse PrivateUser|PublicUser;

public type Pull_number_requested_reviewers_body_1 record {
    # An array of user `login`s that will be removed.
    string[] reviewers;
    # An array of team `slug`s that will be removed.
    string[] team_reviewers?;
};

public type Inline_response_503_1 record {
    string code?;
    string message?;
    string documentation_url?;
    Inline_response_503_1_errors[] errors?;
};

# Branch With Protection
public type BranchWithProtection record {
    string name;
    # Commit
    Commit 'commit;
    Branchwithprotection__links _links;
    boolean protected;
    # Branch Protection
    BranchProtection protection;
    string protection_url;
    string pattern?;
    int required_approving_review_count?;
};

# Collaborator
public type Collaborator record {
    string login;
    int id;
    string? email?;
    string? name?;
    string node_id;
    string avatar_url;
    string? gravatar_id;
    string url;
    string html_url;
    string followers_url;
    string following_url;
    string gists_url;
    string starred_url;
    string subscriptions_url;
    string organizations_url;
    string repos_url;
    string events_url;
    string received_events_url;
    string 'type;
    boolean site_admin;
    Collaborator_permissions permissions?;
    string role_name;
};

# User-defined metadata to store domain-specific information limited to 8 keys with scalar values.
public type RepositoryRuleRulesetInfo record {
    # The type of source for the ruleset that includes this rule.
    "Repository"|"Organization" ruleset_source_type?;
    # The name of the source of the ruleset that includes this rule.
    string ruleset_source?;
    # The ID of the ruleset that includes this rule.
    int ruleset_id?;
};

# Permissions requested, categorized by type of permission. This field incorporates `permissions_added` and `permissions_upgraded`.
public type Personalaccesstokenrequest_permissions_result record {
    record {|string...;|} organization?;
    record {|string...;|} repository?;
    record {|string...;|} other?;
};

# Issue Event Rename
public type IssueEventRename record {
    string 'from;
    string to;
};

public type Filecommit_commit_tree record {
    string url?;
    string sha?;
};

# Repository invitations let you manage who you collaborate with.
public type RepositoryInvitation record {
    # Unique identifier of the repository invitation.
    int id;
    # Minimal Repository
    MinimalRepository repository;
    # A GitHub user.
    NullableSimpleUser? invitee;
    # A GitHub user.
    NullableSimpleUser? inviter;
    # The permission associated with the invitation.
    "read"|"write"|"admin"|"triage"|"maintain" permissions;
    string created_at;
    # Whether or not the invitation has expired
    boolean expired?;
    # URL for the repository invitation
    string url;
    string html_url;
    string node_id;
};

# Issue Event Project Card
public type IssueEventProjectCard record {
    string url;
    int id;
    string project_url;
    int project_id;
    string column_name;
    string previous_column_name?;
};

public type Commit_commit_tree record {
    string sha;
    string url;
};

# Request to install an integration on a target
public type IntegrationInstallationRequest record {
    # Unique identifier of the request installation.
    int id;
    string node_id?;
    SimpleUser|Enterprise account;
    # A GitHub user.
    SimpleUser requester;
    string created_at;
};

public type Git_tags_body record {
    # The tag's name. This is typically a version (e.g., "v0.0.1").
    string tag;
    # The tag message.
    string message;
    # The SHA of the git object this is tagging.
    string 'object;
    # The type of the object we're tagging. Normally this is a `commit` but it can also be a `tree` or a `blob`.
    "commit"|"tree"|"blob" 'type;
    # An object with information about the individual creating the tag.
    Reposownerrepogittags_tagger tagger?;
};

public type Repo_notifications_body record {
    # Describes the last point that notifications were checked. Anything updated since this time will not be marked as read. If you omit this parameter, all notifications are marked as read. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`. Default: The current timestamp.
    string last_read_at?;
};

# Demilestoned Issue Event
public type DemilestonedIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    Milestonedissueevent_milestone milestone;
};

# Commit Search Result Item
public type CommitSearchResultItemResponse record {
    int total_count;
    boolean incomplete_results;
    CommitSearchResultItem[] items;
};

public type ContainerMetadata record {
    string[] tags;
};

public type User_emails_body_1 record {
    # Email addresses associated with the GitHub user account.
    string[] emails;
}|string[]|string;

public type Hookdelivery_request record {
    # The request headers sent with the webhook delivery.
    record {}? headers;
    # The webhook payload.
    record {}? payload;
};

# Information about the Git author
public type Nullablesimplecommit_author record {
    # Name of the commit's author
    string name;
    # Git email address of the commit's author
    string email;
};

public type CodeScanningSarifsReceipt record {
    # An identifier for the upload.
    CodeScanningAnalysisSarifId id?;
    # The REST API URL for checking the status of the upload.
    string url?;
};

# The time that the alert was no longer detected and was considered fixed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
public type AlertFixedAt string?;

public type Reposownerrepochecksuitespreferences_auto_trigger_checks record {
    # The `id` of the GitHub App.
    int app_id;
    # Set to `true` to enable automatic creation of CheckSuite events upon pushes to the repository, or `false` to disable them.
    boolean setting;
};

# Branch Restriction Policy
public type BranchRestrictionPolicy record {
    string url;
    string users_url;
    string teams_url;
    string apps_url;
    Repository_template_repository_owner[] users;
    Branchrestrictionpolicy_teams[] teams;
    Branchrestrictionpolicy_apps[] apps;
};

# License Simple
public type LicenseSimple record {
    string 'key;
    string name;
    string? url;
    string? spdx_id;
    string node_id;
    string html_url?;
};

# Private User
public type PrivateUser record {
    string login;
    int id;
    string node_id;
    string avatar_url;
    string? gravatar_id;
    string url;
    string html_url;
    string followers_url;
    string following_url;
    string gists_url;
    string starred_url;
    string subscriptions_url;
    string organizations_url;
    string repos_url;
    string events_url;
    string received_events_url;
    string 'type;
    boolean site_admin;
    string? name;
    string? company;
    string? blog;
    string? location;
    string? email;
    boolean? hireable;
    string? bio;
    string? twitter_username?;
    int public_repos;
    int public_gists;
    int followers;
    int following;
    string created_at;
    string updated_at;
    int private_gists;
    int total_private_repos;
    int owned_private_repos;
    int disk_usage;
    int collaborators;
    boolean two_factor_authentication;
    Publicuser_plan plan?;
    string? suspended_at?;
    boolean business_plus?;
    string ldap_dn?;
};

# The time that the analysis was created in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
public type CodeScanningAnalysisCreatedAt string;

# Thread
public type NotificationThread record {
    string id;
    # Minimal Repository
    MinimalRepository repository;
    Notificationthread_subject subject;
    string reason;
    boolean unread;
    string updated_at;
    string? last_read_at;
    string url;
    string subscription_url;
};

public type Client_id_grant_body record {
    # The OAuth access token used to authenticate to the GitHub API.
    string access_token;
};

# A GitHub Classroom accepted assignment
public type ClassroomAcceptedAssignment record {
    # Unique identifier of the repository.
    int id;
    # Whether an accepted assignment has been submitted.
    boolean submitted;
    # Whether a submission passed.
    boolean passing;
    # Count of student commits.
    int commit_count;
    # Most recent grade.
    string grade;
    SimpleClassroomUser[] students;
    # A GitHub repository view for Classroom
    SimpleClassroomRepository repository;
    # A GitHub Classroom assignment
    SimpleClassroomAssignment assignment;
};

public type Repo_pages_body anydata|anydata|anydata|anydata|anydata;

public type Codespace_name_publish_body record {
    # A name for the new repository.
    string name?;
    # Whether the new repository should be private.
    boolean 'private?;
};

# GitHub Actions Cache Usage by repository.
public type ActionsCacheUsageByRepository record {
    # The repository owner and name for the cache usage being shown.
    string full_name;
    # The sum of the size in bytes of all the active cache items in the repository.
    int active_caches_size_in_bytes;
    # The number of active caches in the repository.
    int active_caches_count;
};

public type Fullrepository_permissions record {
    boolean admin;
    boolean maintain?;
    boolean push;
    boolean triage?;
    boolean pull;
};

public type Actions_permissions_body record {
    # The policy that controls the repositories in the organization that are allowed to run GitHub Actions.
    EnabledRepositories enabled_repositories;
    # The permissions policy that controls the actions and reusable workflows that are allowed to run.
    AllowedActions allowed_actions?;
};

# Pull Request Simple
public type PullRequestSimple record {
    string url;
    int id;
    string node_id;
    string html_url;
    string diff_url;
    string patch_url;
    string issue_url;
    string commits_url;
    string review_comments_url;
    string review_comment_url;
    string comments_url;
    string statuses_url;
    int number;
    string state;
    boolean locked;
    string title;
    # A GitHub user.
    NullableSimpleUser? user;
    string? body;
    Pullrequestsimple_labels[] labels;
    # A collection of related issues and pull requests.
    NullableMilestone? milestone;
    string? active_lock_reason?;
    string created_at;
    string updated_at;
    string? closed_at;
    string? merged_at;
    string? merge_commit_sha;
    # A GitHub user.
    NullableSimpleUser? assignee;
    SimpleUser[]? assignees?;
    SimpleUser[]? requested_reviewers?;
    Team[]? requested_teams?;
    Pullrequestsimple_head head;
    Pullrequestsimple_head base;
    Pullrequestsimple__links _links;
    # How the author is associated with the repository.
    AuthorAssociation author_association;
    # The status of auto merging a pull request.
    AutoMerge? auto_merge;
    # Indicates whether or not the pull request is a draft.
    boolean draft?;
};

# An optional comment when closing an alert. Cannot be updated or deleted. Must be `null` when changing `state` to `open`.
public type SecretScanningAlertResolutionComment string?;

# Specify which security and analysis features to enable or disable for the repository.
# 
# To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
# 
# For example, to enable GitHub Advanced Security, use this data in the body of the `PATCH` request:
# `{ "security_and_analysis": {"advanced_security": { "status": "enabled" } } }`.
# 
# You can check which security and analysis features are currently enabled by using a `GET /repos/{owner}/{repo}` request.
public type Reposownerrepo_security_and_analysis record {
    # Use the `status` property to enable or disable GitHub Advanced Security for this repository. For more information, see "[About GitHub Advanced Security](/github/getting-started-with-github/learning-about-github/about-github-advanced-security)."
    Reposownerrepo_security_and_analysis_advanced_security advanced_security?;
    # Use the `status` property to enable or disable secret scanning for this repository. For more information, see "[About secret scanning](/code-security/secret-security/about-secret-scanning)."
    Reposownerrepo_security_and_analysis_secret_scanning secret_scanning?;
    # Use the `status` property to enable or disable secret scanning push protection for this repository. For more information, see "[Protecting pushes with secret scanning](/code-security/secret-scanning/protecting-pushes-with-secret-scanning)."
    Reposownerrepo_security_and_analysis_secret_scanning_push_protection secret_scanning_push_protection?;
};

# The public key used for setting Codespaces secrets.
public type CodespacesPublicKey record {
    # The identifier for the key.
    string key_id;
    # The Base64 encoded public key.
    string 'key;
    int id?;
    string url?;
    string title?;
    string created_at?;
};

public type Pageshealthcheck_alt_domain record {
    string host?;
    string uri?;
    string nameservers?;
    boolean dns_resolves?;
    boolean? is_proxied?;
    boolean? is_cloudflare_ip?;
    boolean? is_fastly_ip?;
    boolean? is_old_ip_address?;
    boolean? is_a_record?;
    boolean? has_cname_record?;
    boolean? has_mx_records_present?;
    boolean is_valid_domain?;
    boolean is_apex_domain?;
    boolean? should_be_a_record?;
    boolean? is_cname_to_github_user_domain?;
    boolean? is_cname_to_pages_dot_github_dot_com?;
    boolean? is_cname_to_fastly?;
    boolean? is_pointed_to_github_pages_ip?;
    boolean? is_non_github_pages_ip_present?;
    boolean is_pages_domain?;
    boolean? is_served_by_pages?;
    boolean is_valid?;
    string? reason?;
    boolean responds_to_https?;
    boolean enforces_https?;
    string? https_error?;
    boolean? is_https_eligible?;
    string? caa_error?;
};

public type Issue_number_assignees_body_1 record {
    # Usernames of assignees to remove from an issue. _NOTE: Only users with push access can remove assignees from an issue. Assignees are silently ignored otherwise._
    string[] assignees?;
};

# A commit.
public type NullableSimpleCommit record {
    # SHA for the commit
    string id;
    # SHA for the commit's tree
    string tree_id;
    # Message describing the purpose of the commit
    string message;
    # Timestamp of the commit
    string timestamp;
    # Information about the Git author
    Nullablesimplecommit_author? author;
    # Information about the Git committer
    Nullablesimplecommit_committer? committer;
};

public type Filecommit_commit record {
    string sha?;
    string node_id?;
    string url?;
    string html_url?;
    Filecommit_commit_author author?;
    Filecommit_commit_author committer?;
    string message?;
    Filecommit_commit_tree tree?;
    Filecommit_commit_parents[] parents?;
    Filecommit_commit_verification verification?;
};

public type Ratelimitoverview_resources record {
    RateLimit core;
    RateLimit graphql?;
    RateLimit search;
    RateLimit code_search?;
    RateLimit source_import?;
    RateLimit integration_manifest?;
    RateLimit code_scanning_upload?;
    RateLimit actions_runner_registration?;
    RateLimit scim?;
    RateLimit dependency_snapshots?;
};

# Sets the state of the code scanning alert. You must provide `dismissed_reason` when you set the state to `dismissed`.
public type CodeScanningAlertSetState "open"|"dismissed";

public type CodeScanningAnalysis record {
    # The full Git reference, formatted as `refs/heads/<branch name>`,
    # `refs/pull/<number>/merge`, or `refs/pull/<number>/head`.
    CodeScanningRef ref;
    # The SHA of the commit to which the analysis you are uploading relates.
    CodeScanningAnalysisCommitSha commit_sha;
    # Identifies the configuration under which the analysis was executed. For example, in GitHub Actions this includes the workflow filename and job name.
    CodeScanningAnalysisAnalysisKey analysis_key;
    # Identifies the variable values associated with the environment in which this analysis was performed.
    CodeScanningAnalysisEnvironment environment;
    # Identifies the configuration under which the analysis was executed. Used to distinguish between multiple analyses for the same tool and commit, but performed on different languages or different parts of the code.
    CodeScanningAnalysisCategory category?;
    string 'error;
    # The time that the analysis was created in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    CodeScanningAnalysisCreatedAt created_at;
    # The total number of results in the analysis.
    int results_count;
    # The total number of rules used in the analysis.
    int rules_count;
    # Unique identifier for this analysis.
    int id;
    # The REST API URL of the analysis resource.
    CodeScanningAnalysisUrl url;
    # An identifier for the upload.
    CodeScanningAnalysisSarifId sarif_id;
    CodeScanningAnalysisTool tool;
    boolean deletable;
    # Warning generated when processing the analysis
    string warning;
};

# A codespace.
public type CodespaceResponse record {
    int total_count;
    Codespace[] codespaces;
};

# Secrets for GitHub Dependabot for an organization.
public type OrganizationDependabotSecret record {
    # The name of the secret.
    string name;
    string created_at;
    string updated_at;
    # Visibility of a secret
    "all"|"private"|"selected" visibility;
    string selected_repositories_url?;
};

public type Gpgkey_subkeys record {
    int id?;
    int primary_key_id?;
    string key_id?;
    string public_key?;
    Gpgkey_emails[] emails?;
    anydata[] subkeys?;
    boolean can_sign?;
    boolean can_encrypt_comms?;
    boolean can_encrypt_storage?;
    boolean can_certify?;
    string created_at?;
    string? expires_at?;
    string? raw_key?;
    boolean revoked?;
};

public type Verification record {
    boolean verified;
    string reason;
    string? payload;
    string? signature;
};

public type Gittree_tree record {
    string path?;
    string mode?;
    string 'type?;
    string sha?;
    int size?;
    string url?;
};

# Review Request Removed Issue Event
public type ReviewRequestRemovedIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    # A GitHub user.
    SimpleUser review_requester;
    # Groups of organization members that gives permissions on specified repositories.
    Team requested_team?;
    # A GitHub user.
    SimpleUser requested_reviewer?;
};

public type User_repos_body record {
    # The name of the repository.
    string name;
    # A short description of the repository.
    string description?;
    # A URL with more information about the repository.
    string homepage?;
    # Whether the repository is private.
    boolean 'private = false;
    # Whether issues are enabled.
    boolean has_issues = true;
    # Whether projects are enabled.
    boolean has_projects = true;
    # Whether the wiki is enabled.
    boolean has_wiki = true;
    # Whether discussions are enabled.
    boolean has_discussions = false;
    # The id of the team that will be granted access to this repository. This is only valid when creating a repository in an organization.
    int team_id?;
    # Whether the repository is initialized with a minimal README.
    boolean auto_init = false;
    # The desired language or platform to apply to the .gitignore.
    string gitignore_template?;
    # The license keyword of the open source license for this repository.
    string license_template?;
    # Whether to allow squash merges for pull requests.
    boolean allow_squash_merge = true;
    # Whether to allow merge commits for pull requests.
    boolean allow_merge_commit = true;
    # Whether to allow rebase merges for pull requests.
    boolean allow_rebase_merge = true;
    # Whether to allow Auto-merge to be used on pull requests.
    boolean allow_auto_merge = false;
    # Whether to delete head branches when pull requests are merged
    boolean delete_branch_on_merge = false;
    # The default value for a squash merge commit title:
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `COMMIT_OR_PR_TITLE` - default to the commit's title (if only one commit) or the pull request's title (when more than one commit).
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squash_merge_commit_title?;
    # The default value for a squash merge commit message:
    # 
    # - `PR_BODY` - default to the pull request's body.
    # - `COMMIT_MESSAGES` - default to the branch's commit messages.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squash_merge_commit_message?;
    # The default value for a merge commit title.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `MERGE_MESSAGE` - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name).
    "PR_TITLE"|"MERGE_MESSAGE" merge_commit_title?;
    # The default value for a merge commit message.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `PR_BODY` - default to the pull request's body.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"PR_TITLE"|"BLANK" merge_commit_message?;
    # Whether downloads are enabled.
    boolean has_downloads = true;
    # Whether this repository acts as a template that can be used to generate new repositories.
    boolean is_template = false;
};

# An artifact
public type Artifact record {
    int id;
    string node_id;
    # The name of the artifact.
    string name;
    # The size in bytes of the artifact.
    int size_in_bytes;
    string url;
    string archive_download_url;
    # Whether or not the artifact has expired.
    boolean expired;
    string? created_at;
    string? expires_at;
    string? updated_at;
    Artifact_workflow_run? workflow_run?;
};

public type Gitcommit_verification record {
    boolean verified;
    string reason;
    string? signature;
    string? payload;
};

# Authentication token for a GitHub App installed on a user or org.
public type InstallationToken record {
    string token;
    string expires_at;
    # The permissions granted to the user access token.
    AppPermissions permissions?;
    "all"|"selected" repository_selection?;
    Repository[] repositories?;
    string single_file?;
    boolean has_multiple_single_files?;
    string[] single_file_paths?;
};

# The API URL to use to get or set the actions and reusable workflows that are allowed to run, when `allowed_actions` is set to `selected`.
public type SelectedActionsUrl string;

public type Actionscachelist_actions_caches record {
    int id?;
    string ref?;
    string 'key?;
    string version?;
    string last_accessed_at?;
    string created_at?;
    int size_in_bytes?;
};

# Describe a region within a file for the alert.
public type CodeScanningAlertLocation record {
    string path?;
    int start_line?;
    int end_line?;
    int start_column?;
    int end_column?;
};

public type Gittag_tagger record {
    string date;
    string email;
    string name;
};

public type Restrictions_users_body_2 record {
    # The username for users
    string[] users;
}|string[];

public type Gistsimple_forks record {
    string id?;
    string url?;
    # Public User
    PublicUser user?;
    string created_at?;
    string updated_at?;
};

public type Workflowrunusage_billable record {
    Workflowrunusage_billable_UBUNTU UBUNTU?;
    Workflowrunusage_billable_UBUNTU MACOS?;
    Workflowrunusage_billable_UBUNTU WINDOWS?;
};

# Identifies the variable values associated with the environment in which the analysis that generated this alert instance was performed, such as the language that was analyzed.
public type CodeScanningAlertEnvironment string;

public type HookResponse record {
    int? code;
    string? status;
    string? message;
};

public type Restrictions_users_body_1 record {
    # The username for users
    string[] users;
}|string[];

# Delivery made by a webhook, without request and response information.
public type HookDeliveryItem record {
    # Unique identifier of the webhook delivery.
    int id;
    # Unique identifier for the event (shared with all deliveries for all webhooks that subscribe to this event).
    string guid;
    # Time when the webhook delivery occurred.
    string delivered_at;
    # Whether the webhook delivery is a redelivery.
    boolean redelivery;
    # Time spent delivering.
    decimal duration;
    # Describes the response returned after attempting the delivery.
    string status;
    # Status code received when delivery was made.
    int status_code;
    # The event that triggered the delivery.
    string event;
    # The type of activity for the event that triggered the delivery.
    string? action;
    # The id of the GitHub App installation associated with this event.
    int? installation_id;
    # The id of the repository associated with this event.
    int? repository_id;
};

public type Repositoryrulesetconditionsrepositorynametarget_repository_name record {
    # Array of repository names or patterns to include. One of these patterns must match for the condition to pass. Also accepts `~ALL` to include all repositories.
    string[] include?;
    # Array of repository names or patterns to exclude. The condition will not pass if any of these patterns match.
    string[] exclude?;
    # Whether renaming of target repositories is prevented.
    boolean protected?;
};

public type Rulesets_ruleset_id_body record {
    # The name of the ruleset.
    string name?;
    # The target of the ruleset.
    "branch"|"tag" target?;
    # The enforcement level of the ruleset. `evaluate` allows admins to test rules before enforcing them. Admins can view insights on the Rule Insights page (`evaluate` is only available with GitHub Enterprise).
    RepositoryRuleEnforcement enforcement?;
    # The actors that can bypass the rules in this ruleset
    RepositoryRulesetBypassActor[] bypass_actors?;
    # Conditions for an organization ruleset. The conditions object should contain both `repository_name` and `ref_name` properties or both `repository_id` and `ref_name` properties.
    OrgRulesetConditions conditions?;
    # An array of rules within the ruleset.
    RepositoryRule[] rules?;
};

public type Repository_template_repository_owner record {
    string login?;
    int id?;
    string node_id?;
    string avatar_url?;
    string gravatar_id?;
    string url?;
    string html_url?;
    string followers_url?;
    string following_url?;
    string gists_url?;
    string starred_url?;
    string subscriptions_url?;
    string organizations_url?;
    string repos_url?;
    string events_url?;
    string received_events_url?;
    string 'type?;
    boolean site_admin?;
};

public type Codescanning_sarifs_body record {
    # The SHA of the commit to which the analysis you are uploading relates.
    CodeScanningAnalysisCommitSha commit_sha;
    # The full Git reference, formatted as `refs/heads/<branch name>`,
    # `refs/pull/<number>/merge`, or `refs/pull/<number>/head`.
    CodeScanningRef ref;
    # A Base64 string representing the SARIF file to upload. You must first compress your SARIF file using [`gzip`](http://www.gnu.org/software/gzip/manual/gzip.html) and then translate the contents of the file into a Base64 encoding string. For more information, see "[SARIF support for code scanning](https://docs.github.com/code-security/secure-coding/sarif-support-for-code-scanning)."
    CodeScanningAnalysisSarifFile sarif;
    # The base directory used in the analysis, as it appears in the SARIF file.
    # This property is used to convert file paths from absolute to relative, so that alerts can be mapped to their correct location in the repository.
    string checkout_uri?;
    # The time that the analysis run began. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    string started_at?;
    # The name of the tool used to generate the code scanning analysis. If this parameter is not used, the tool name defaults to "API". If the uploaded SARIF contains a tool GUID, this will be available for filtering using the `tool_guid` parameter of operations such as `GET /repos/{owner}/{repo}/code-scanning/alerts`.
    string tool_name?;
    # Whether the SARIF file will be validated according to the code scanning specifications.
    # This parameter is intended to help integrators ensure that the uploaded SARIF files are correctly rendered by code scanning.
    boolean validate?;
};

# The permissions policy that controls the actions and reusable workflows that are allowed to run.
public type AllowedActions "all"|"local_only"|"selected";

public type Reposownerrepoissuesissue_numberlabels_labels record {
    string name;
};

# Information of a job execution in a workflow run
public type Job record {
    # The id of the job.
    int id;
    # The id of the associated workflow run.
    int run_id;
    string run_url;
    # Attempt number of the associated workflow run, 1 for first attempt and higher if the workflow was re-run.
    int run_attempt?;
    string node_id;
    # The SHA of the commit that is being run.
    string head_sha;
    string url;
    string? html_url;
    # The phase of the lifecycle that the job is currently in.
    "queued"|"in_progress"|"completed" status;
    # The outcome of the job.
    "success"|"failure"|"neutral"|"cancelled"|"skipped"|"timed_out"|"action_required" conclusion;
    # The time that the job created, in ISO 8601 format.
    string created_at;
    # The time that the job started, in ISO 8601 format.
    string started_at;
    # The time that the job finished, in ISO 8601 format.
    string? completed_at;
    # The name of the job.
    string name;
    # Steps in this job.
    Job_steps[] steps?;
    string check_run_url;
    # Labels for the workflow job. Specified by the "runs_on" attribute in the action's workflow file.
    string[] labels;
    # The ID of the runner to which this job has been assigned. (If a runner hasn't yet been assigned, this will be null.)
    int? runner_id;
    # The name of the runner to which this job has been assigned. (If a runner hasn't yet been assigned, this will be null.)
    string? runner_name;
    # The ID of the runner group to which this job has been assigned. (If a runner hasn't yet been assigned, this will be null.)
    int? runner_group_id;
    # The name of the runner group to which this job has been assigned. (If a runner hasn't yet been assigned, this will be null.)
    string? runner_group_name;
    # The name of the workflow.
    string? workflow_name;
    # The name of the current branch.
    string? head_branch;
};

# Branch Protection
public type BranchProtection record {
    string url?;
    boolean enabled?;
    # Protected Branch Required Status Check
    ProtectedBranchRequiredStatusCheck required_status_checks?;
    # Protected Branch Admin Enforced
    ProtectedBranchAdminEnforced enforce_admins?;
    # Protected Branch Pull Request Review
    ProtectedBranchPullRequestReview required_pull_request_reviews?;
    # Branch Restriction Policy
    BranchRestrictionPolicy restrictions?;
    Branchprotection_required_linear_history required_linear_history?;
    Branchprotection_required_linear_history allow_force_pushes?;
    Branchprotection_required_linear_history allow_deletions?;
    Branchprotection_required_linear_history block_creations?;
    Branchprotection_required_linear_history required_conversation_resolution?;
    string name?;
    string protection_url?;
    Branchprotection_required_signatures required_signatures?;
    # Whether to set the branch as read-only. If this is true, users will not be able to push to the branch.
    Branchprotection_lock_branch lock_branch?;
    # Whether users can pull changes from upstream when the branch is locked. Set to `true` to allow fork syncing. Set to `false` to prevent fork syncing.
    Branchprotection_allow_fork_syncing allow_fork_syncing?;
};

# Content Tree
public type ContentTree record {
    string 'type;
    int size;
    string name;
    string path;
    string sha;
    string url;
    string? git_url;
    string? html_url;
    string? download_url;
    Contenttree_entries[] entries?;
    Contenttree__links _links;
};

# Commit Activity
public type CommitActivity record {
    int[] days;
    int total;
    int week;
};

# Blob
public type Blob record {
    string content;
    string encoding;
    string url;
    string sha;
    int? size;
    string node_id;
    string highlighted_content?;
};

# Timeline Unassigned Issue Event
public type TimelineUnassignedIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    # A GitHub user.
    SimpleUser assignee;
};

# Set repository secrets for GitHub Codespaces.
public type RepoCodespacesSecret record {
    # The name of the secret.
    string name;
    string created_at;
    string updated_at;
};

# Validation Error Simple
public type ValidationErrorSimple record {
    string message;
    string documentation_url;
    string[] errors?;
};

# Secrets for a GitHub Codespace.
public type CodespacesSecretResponse record {
    int total_count;
    CodespacesSecret[] secrets;
};

public type User_gpg_keys_body record {
    # A descriptive name for the new key.
    string name?;
    # A GPG key in ASCII-armored format.
    string armored_public_key;
};

# A GitHub App that is providing a custom deployment protection rule.
public type CustomDeploymentRuleAppResponse record {
    # The total number of custom deployment protection rule integrations available for this environment.
    int total_count?;
    CustomDeploymentRuleApp[] available_custom_deployment_protection_rule_integrations?;
};

public type Run_id_deployment_protection_rule_body ReviewCustomGatesCommentRequired|ReviewCustomGatesStateRequired;

# The public key used for setting Actions Secrets.
public type ActionsPublicKey record {
    # The identifier for the key.
    string key_id;
    # The Base64 encoded public key.
    string 'key;
    int id?;
    string url?;
    string title?;
    string created_at?;
};

public type Memberships_username_body record {
    # The role to give the user in the organization. Can be one of:  
    #  * `admin` - The user will become an owner of the organization.  
    #  * `member` - The user will become a non-owner member of the organization.
    "admin"|"member" role?;
};

# Org Membership
public type OrgMembership record {
    string url;
    # The state of the member in the organization. The `pending` state indicates the user has not yet accepted an invitation.
    "active"|"pending" state;
    # The user's membership type in the organization.
    "admin"|"member"|"billing_manager" role;
    string organization_url;
    # A GitHub organization.
    OrganizationSimple organization;
    # A GitHub user.
    NullableSimpleUser? user;
    Orgmembership_permissions permissions?;
};

# The set of permissions for the GitHub app
public type Integration_permissions record {|
    string issues?;
    string checks?;
    string metadata?;
    string contents?;
    string deployments?;
    string...;
|};

# Workflow Run Usage
public type WorkflowRunUsage record {
    Workflowrunusage_billable billable;
    int run_duration_ms?;
};

public type User_social_accounts_body record {
    # Full URLs for the social media profiles to add.
    string[] account_urls;
};

# The version of the tool used to generate the code scanning analysis.
public type CodeScanningAnalysisToolVersion string?;

public type Review_id_events_body record {
    # The body text of the pull request review
    string body?;
    # The review action you want to perform. The review actions include: `APPROVE`, `REQUEST_CHANGES`, or `COMMENT`. When you leave this blank, the API returns _HTTP 422 (Unrecognizable entity)_ and sets the review action state to `PENDING`, which means you will need to re-submit the pull request review using a review action.
    "APPROVE"|"REQUEST_CHANGES"|"COMMENT" event;
};

# A release.
public type Release record {
    string url;
    string html_url;
    string assets_url;
    string upload_url;
    string? tarball_url;
    string? zipball_url;
    int id;
    string node_id;
    # The name of the tag.
    string tag_name;
    # Specifies the commitish value that determines where the Git tag is created from.
    string target_commitish;
    string? name;
    string? body?;
    # true to create a draft (unpublished) release, false to create a published one.
    boolean draft;
    # Whether to identify the release as a prerelease or a full release.
    boolean prerelease;
    string created_at;
    string? published_at;
    # A GitHub user.
    SimpleUser author;
    ReleaseAsset[] assets;
    string body_html?;
    string body_text?;
    int mentions_count?;
    # The URL of the release discussion.
    string discussion_url?;
    ReactionRollup reactions?;
};

# The hierarchy between files in a Git repository.
public type GitTree record {
    string sha;
    string url;
    boolean truncated;
    # Objects specifying a tree structure
    Gittree_tree[] tree;
};

# The enforcement level of the ruleset. `evaluate` allows admins to test rules before enforcing them. Admins can view insights on the Rule Insights page (`evaluate` is only available with GitHub Enterprise).
public type RepositoryRuleEnforcement "disabled"|"active"|"evaluate";

public type Checkruns_check_run_id_body record {"completed" status?;}|record {"queued"|"in_progress" status?;};

public type Pullrequest_labels record {
    int id;
    string node_id;
    string url;
    string name;
    string? description;
    string color;
    boolean default;
};

# An autolink reference.
public type Autolink record {
    int id;
    # The prefix of a key that is linkified.
    string key_prefix;
    # A template for the target URL that is generated if a key was found.
    string url_template;
    # Whether this autolink reference matches alphanumeric characters. If false, this autolink reference only matches numeric characters.
    boolean is_alphanumeric;
};

public type Apioverview_domains record {
    string[] website?;
    string[] codespaces?;
    string[] copilot?;
    string[] packages?;
};

# Issue Event Label
public type IssueEventLabel record {
    string? name;
    string? color;
};

public type CodeScanningAnalysisTool record {
    # The name of the tool used to generate the code scanning analysis.
    CodeScanningAnalysisToolName name?;
    # The version of the tool used to generate the code scanning analysis.
    CodeScanningAnalysisToolVersion? version?;
    # The GUID of the tool used to generate the code scanning analysis, if provided in the uploaded SARIF data.
    CodeScanningAnalysisToolGuid? guid?;
};

# A check performed on the code of a given code change
public type CheckRun record {
    # The id of the check.
    int id;
    # The SHA of the commit that is being checked.
    string head_sha;
    string node_id;
    string? external_id;
    string url;
    string? html_url;
    string? details_url;
    # The phase of the lifecycle that the check is currently in.
    "queued"|"in_progress"|"completed" status;
    "success"|"failure"|"neutral"|"cancelled"|"skipped"|"timed_out"|"action_required" conclusion;
    string? started_at;
    string? completed_at;
    Checkrun_output output;
    # The name of the check.
    string name;
    Checkrun_check_suite? check_suite;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? app;
    # Pull requests that are open with a `head_sha` or `head_branch` that matches the check. The returned pull requests do not necessarily indicate pull requests that triggered the check.
    PullRequestMinimal[] pull_requests;
    # A deployment created as the result of an Actions check run from a workflow that references an environment
    DeploymentSimple deployment?;
};

# Porter Large File
public type PorterLargeFile record {
    string ref_name;
    string path;
    string oid;
    int size;
};

public type Checksuites_preferences_body record {
    # Enables or disables automatic creation of CheckSuite events upon pushes to the repository. Enabled by default.
    Reposownerrepochecksuitespreferences_auto_trigger_checks[] auto_trigger_checks?;
};

public type SecretScanningLocation record {
    # The location type. Because secrets may be found in different types of resources (ie. code, comments, issues), this field identifies the type of resource where the secret was found.
    "commit"|"issue_title"|"issue_body"|"issue_comment" 'type;
    SecretScanningLocationCommit|SecretScanningLocationIssueTitle|SecretScanningLocationIssueBody|SecretScanningLocationIssueComment details;
};

public type CodeScanningAlertItems record {
    # The security alert number.
    AlertNumber number;
    # The time that the alert was created in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertCreatedAt created_at;
    # The time that the alert was last updated in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertUpdatedAt updated_at?;
    # The REST API URL of the alert resource.
    AlertUrl url;
    # The GitHub URL of the alert resource.
    AlertHtmlUrl html_url;
    # The REST API URL for fetching the list of instances for an alert.
    AlertInstancesUrl instances_url;
    # State of a code scanning alert.
    CodeScanningAlertState state;
    # The time that the alert was no longer detected and was considered fixed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertFixedAt? fixed_at?;
    # A GitHub user.
    NullableSimpleUser? dismissed_by;
    # The time that the alert was dismissed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertDismissedAt? dismissed_at;
    # **Required when the state is dismissed.** The reason for dismissing or closing the alert.
    CodeScanningAlertDismissedReason? dismissed_reason;
    # The dismissal comment associated with the dismissal of the alert.
    CodeScanningAlertDismissedComment? dismissed_comment?;
    CodeScanningAlertRuleSummary rule;
    CodeScanningAnalysisTool tool;
    CodeScanningAlertInstance most_recent_instance;
};

public type Required_status_checks_contexts_body record {
    # The name of the status checks
    string[] contexts;
}|string[];

public type Hovercard_contexts record {
    string message;
    string octicon;
};

# Configuration for code scanning default setup.
public type CodeScanningDefaultSetupUpdate record {
    # Whether code scanning default setup has been configured or not.
    "configured"|"not-configured" state;
    # CodeQL query suite to be used.
    "default"|"extended" query_suite?;
    # CodeQL languages to be analyzed.
    ("c-cpp"|"csharp"|"go"|"java-kotlin"|"javascript-typescript"|"python"|"ruby"|"swift")[] languages?;
};

# Project columns contain cards of work.
public type ProjectColumn record {
    string url;
    string project_url;
    string cards_url;
    # The unique identifier of the project column
    int id;
    string node_id;
    # Name of the project column
    string name;
    string created_at;
    string updated_at;
};

public type NullableCommunityHealthFile record {
    string url;
    string html_url;
};

public type Communityprofile_files record {
    # Code of Conduct Simple
    NullableCodeOfConductSimple? code_of_conduct;
    NullableCommunityHealthFile? code_of_conduct_file;
    # License Simple
    NullableLicenseSimple? license;
    NullableCommunityHealthFile? contributing;
    NullableCommunityHealthFile? readme;
    NullableCommunityHealthFile? issue_template;
    NullableCommunityHealthFile? pull_request_template;
};

public type PackageVersionMetadata record {
    "npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type;
    ContainerMetadata container?;
    DockerMetadata docker?;
};

public type Variables_name_body record {
    # The name of the variable.
    string name?;
    # The value of the variable.
    string value?;
    # The type of repositories in the organization that can access the variable. `selected` means only the repositories specified by `selected_repository_ids` can access the variable.
    "all"|"private"|"selected" visibility?;
    # An array of repository ids that can access the organization variable. You can only provide a list of repository ids when the `visibility` is set to `selected`.
    int[] selected_repository_ids?;
};

public type CodeScanningSarifsStatus record {
    # `pending` files have not yet been processed, while `complete` means results from the SARIF have been stored. `failed` files have either not been processed at all, or could only be partially processed.
    "pending"|"complete"|"failed" processing_status?;
    # The REST API URL for getting the analyses associated with the upload.
    string? analyses_url?;
    # Any errors that ocurred during processing of the delivery.
    string[]? errors?;
};

public type Codespace_runtime_constraints record {
    # The privacy settings a user can select from when forwarding a port.
    string[]? allowed_port_privacy_settings?;
};

# Key/value pairs to provide settings for this webhook.
public type Reposownerrepohookshook_id_config record {
    # The URL to which the payloads will be delivered.
    WebhookConfigUrl url;
    # The media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`.
    WebhookConfigContentType content_type?;
    # If provided, the `secret` will be used as the `key` to generate the HMAC hex digest value for [delivery signature headers](https://docs.github.com/webhooks/event-payloads/#delivery-headers).
    WebhookConfigSecret secret?;
    WebhookConfigInsecureSsl insecure_ssl?;
    string address?;
    string room?;
};

# A Base64 string representing the SARIF file to upload. You must first compress your SARIF file using [`gzip`](http://www.gnu.org/software/gzip/manual/gzip.html) and then translate the contents of the file into a Base64 encoding string. For more information, see "[SARIF support for code scanning](https://docs.github.com/code-security/secure-coding/sarif-support-for-code-scanning)."
public type CodeScanningAnalysisSarifFile string;

public type Commitsearchresultitem_commit_author record {
    string name;
    string email;
    string date;
};

public type Pull_number_codespaces_body record {
    # The requested location for a new codespace. Best efforts are made to respect this upon creation. Assigned by IP if not provided.
    string location?;
    # The geographic area for this codespace. If not specified, the value is assigned by IP. This property replaces `location`, which is being deprecated.
    "EuropeWest"|"SoutheastAsia"|"UsEast"|"UsWest" geo?;
    # IP for location auto-detection when proxying a request
    string client_ip?;
    # Machine type to use for this codespace
    string machine?;
    # Path to devcontainer.json config to use for this codespace
    string devcontainer_path?;
    # Whether to authorize requested permissions from devcontainer.json
    boolean multi_repo_permissions_opt_out?;
    # Working directory for this codespace
    string working_directory?;
    # Time in minutes before codespace stops from inactivity
    int idle_timeout_minutes?;
    # Display name for this codespace
    string display_name?;
    # Duration in minutes after codespace has gone idle in which it will be deleted. Must be integer minutes between 0 and 43200 (30 days).
    int retention_period_minutes?;
};

# An actor that can bypass rules in a ruleset
public type RepositoryRulesetBypassActor record {
    # The ID of the actor that can bypass a ruleset. If `actor_type` is `OrganizationAdmin`, this should be `1`.
    int actor_id;
    # The type of actor that can bypass a ruleset
    "RepositoryRole"|"Team"|"Integration"|"OrganizationAdmin" actor_type;
    # When the specified actor can bypass the ruleset. `pull_request` means that an actor can only bypass rules on pull requests.
    "always"|"pull_request" bypass_mode;
};

public type Secrets_secret_name_body record {
    # Value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get an organization public key](https://docs.github.com/rest/actions/secrets#get-an-organization-public-key) endpoint.
    @constraint:String {pattern: re `^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$`}
    string encrypted_value?;
    # ID of the key you used to encrypt the secret.
    string key_id?;
    # Which type of organization repositories have access to the organization secret. `selected` means only the repositories specified by `selected_repository_ids` can access the secret.
    "all"|"private"|"selected" visibility;
    # An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the `visibility` is set to `selected`. You can manage the list of selected repositories using the [List selected repositories for an organization secret](https://docs.github.com/rest/actions/secrets#list-selected-repositories-for-an-organization-secret), [Set selected repositories for an organization secret](https://docs.github.com/rest/actions/secrets#set-selected-repositories-for-an-organization-secret), and [Remove selected repository from an organization secret](https://docs.github.com/rest/actions/secrets#remove-selected-repository-from-an-organization-secret) endpoints.
    int[] selected_repository_ids?;
};

public type Import_lfs_body record {
    # Whether to store large files during the import. `opt_in` means large files will be stored using Git LFS. `opt_out` means large files will be removed during the import.
    "opt_in"|"opt_out" use_lfs;
};

public type Hook_config record {
    string email?;
    string password?;
    string room?;
    string subdomain?;
    # The URL to which the payloads will be delivered.
    WebhookConfigUrl url?;
    WebhookConfigInsecureSsl insecure_ssl?;
    # The media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`.
    WebhookConfigContentType content_type?;
    string digest?;
    # If provided, the `secret` will be used as the `key` to generate the HMAC hex digest value for [delivery signature headers](https://docs.github.com/webhooks/event-payloads/#delivery-headers).
    WebhookConfigSecret secret?;
    string token?;
};

# Set secrets for GitHub Actions.
public type ActionsSecret record {
    # The name of the secret.
    string name;
    string created_at;
    string updated_at;
};

# Diff Entry
public type DiffEntry record {
    string sha;
    string filename;
    "added"|"removed"|"modified"|"renamed"|"copied"|"changed"|"unchanged" status;
    int additions;
    int deletions;
    int changes;
    string blob_url;
    string raw_url;
    string contents_url;
    string patch?;
    string previous_filename?;
};

# Key/value pairs to provide settings for this webhook.
public type Orgsorghooks_config record {
    # The URL to which the payloads will be delivered.
    WebhookConfigUrl url;
    # The media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`.
    WebhookConfigContentType content_type?;
    # If provided, the `secret` will be used as the `key` to generate the HMAC hex digest value for [delivery signature headers](https://docs.github.com/webhooks/event-payloads/#delivery-headers).
    WebhookConfigSecret secret?;
    WebhookConfigInsecureSsl insecure_ssl?;
    string username?;
    string password?;
};

# Timeline Cross Referenced Event
public type TimelineCrossReferencedEvent record {
    string event;
    # A GitHub user.
    SimpleUser actor?;
    string created_at;
    string updated_at;
    Timelinecrossreferencedevent_source 'source;
};

# Details pertaining to the package version that patches this vulnerability.
public type Dependabotalertsecurityvulnerability_first_patched_version record {|
    # The package version that patches this vulnerability.
    string identifier;
|};

public type Token_scoped_body record {
    # The access token used to authenticate to the GitHub API.
    string access_token;
    # The name of the user or organization to scope the user access token to. **Required** unless `target_id` is specified.
    string target?;
    # The ID of the user or organization to scope the user access token to. **Required** unless `target` is specified.
    int target_id?;
    # The list of repository names to scope the user access token to. `repositories` may not be specified if `repository_ids` is specified.
    string[] repositories?;
    # The list of repository IDs to scope the user access token to. `repository_ids` may not be specified if `repositories` is specified.
    int[] repository_ids?;
    # The permissions granted to the user access token.
    AppPermissions permissions?;
};

public type Comment_id_reactions_body_2 record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the pull request review comment.
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

# Dev Containers
public type Devcontainers record {
    string path;
    string name?;
    string display_name?;
};

public type ActionsVariableResponse record {
    int total_count;
    ActionsVariable[] variables;
};

public type Repo_topics_body record {
    # An array of topics to add to the repository. Pass one or more topics to _replace_ the set of existing topics. Send an empty array (`[]`) to clear all topics from the repository. **Note:** Topic `names` cannot contain uppercase letters.
    string[] names;
};

public type Comment_id_reactions_body_1 record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the issue comment.
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

# Parameters to be used for the branch_name_pattern rule
public type RepositoryRuleBranchNamePattern record {
    "branch_name_pattern" 'type;
    Repositoryrulecommitmessagepattern_parameters parameters?;
};

public type Environmentapprovals_environments record {
    # The id of the environment.
    int id?;
    string node_id?;
    # The name of the environment.
    string name?;
    string url?;
    string html_url?;
    # The time that the environment was created, in ISO 8601 format.
    string created_at?;
    # The time that the environment was last updated, in ISO 8601 format.
    string updated_at?;
};

# Represents an 'issue_comment' secret scanning location type. This location type shows that a secret was detected in a comment on an issue.
public type SecretScanningLocationIssueComment record {
    # The API URL to get the issue comment where the secret was detected.
    string issue_comment_url;
};

public type Checkrun_check_suite record {
    int id;
};

public type Pullrequest_base record {
    string label;
    string ref;
    Pullrequest_base_repo repo;
    string sha;
    Pullrequest_head_repo_owner user;
};

# Hypermedia Link
public type Link record {
    string href;
};

public type Branchrestrictionpolicy_teams record {
    int id?;
    string node_id?;
    string url?;
    string html_url?;
    string name?;
    string slug?;
    string? description?;
    string privacy?;
    string notification_setting?;
    string permission?;
    string members_url?;
    string repositories_url?;
    string? parent?;
};

public type CodeScanningAlertRuleSummary record {
    # A unique identifier for the rule used to detect the alert.
    string? id?;
    # The name of the rule used to detect the alert.
    string name?;
    # A set of tags applicable for the rule.
    string[]? tags?;
    # The severity of the alert.
    "none"|"note"|"warning"|"error" severity?;
    # A short description of the rule used to detect the alert.
    string description?;
};

# The type of reviewer.
public type DeploymentReviewerType "User"|"Team";

# Branch Short
public type BranchShort record {
    string name;
    Branchshort_commit 'commit;
    boolean protected;
};

# Use the `status` property to enable or disable secret scanning for this repository. For more information, see "[About secret scanning](/code-security/secret-security/about-secret-scanning)."
public type Reposownerrepo_security_and_analysis_secret_scanning record {
    # Can be `enabled` or `disabled`.
    string status?;
};

# An advisory identifier.
public type Dependabotalertsecurityadvisory_identifiers record {|
    # The type of advisory identifier.
    "CVE"|"GHSA" 'type;
    # The value of the advisory identifer.
    string value;
|};

# A version of a software package
public type PackageVersion record {
    # Unique identifier of the package version.
    int id;
    # The name of the package version.
    string name;
    string url;
    string package_html_url;
    string html_url?;
    string license?;
    string description?;
    string created_at;
    string updated_at;
    string deleted_at?;
    PackageVersionMetadata metadata?;
};

public type Pull_number_reviews_body record {
    # The SHA of the commit that needs a review. Not using the latest commit SHA may render your review comment outdated if a subsequent commit modifies the line you specify as the `position`. Defaults to the most recent commit in the pull request when you do not specify a value.
    string commit_id?;
    # **Required** when using `REQUEST_CHANGES` or `COMMENT` for the `event` parameter. The body text of the pull request review.
    string body?;
    # The review action you want to perform. The review actions include: `APPROVE`, `REQUEST_CHANGES`, or `COMMENT`. By leaving this blank, you set the review action state to `PENDING`, which means you will need to [submit the pull request review](https://docs.github.com/rest/pulls/reviews#submit-a-review-for-a-pull-request) when you are ready.
    "APPROVE"|"REQUEST_CHANGES"|"COMMENT" event?;
    # Use the following table to specify the location, destination, and contents of the draft review comment.
    Reposownerrepopullspull_numberreviews_comments[] comments?;
};

# Repo Search Result Item
public type RepoSearchResultItem record {
    int id;
    string node_id;
    string name;
    string full_name;
    # A GitHub user.
    NullableSimpleUser? owner;
    boolean 'private;
    string html_url;
    string? description;
    boolean 'fork;
    string url;
    string created_at;
    string updated_at;
    string pushed_at;
    string? homepage;
    int size;
    int stargazers_count;
    int watchers_count;
    string? language;
    int forks_count;
    int open_issues_count;
    string master_branch?;
    string default_branch;
    decimal score;
    string forks_url;
    string keys_url;
    string collaborators_url;
    string teams_url;
    string hooks_url;
    string issue_events_url;
    string events_url;
    string assignees_url;
    string branches_url;
    string tags_url;
    string blobs_url;
    string git_tags_url;
    string git_refs_url;
    string trees_url;
    string statuses_url;
    string languages_url;
    string stargazers_url;
    string contributors_url;
    string subscribers_url;
    string subscription_url;
    string commits_url;
    string git_commits_url;
    string comments_url;
    string issue_comment_url;
    string contents_url;
    string compare_url;
    string merges_url;
    string archive_url;
    string downloads_url;
    string issues_url;
    string pulls_url;
    string milestones_url;
    string notifications_url;
    string labels_url;
    string releases_url;
    string deployments_url;
    string git_url;
    string ssh_url;
    string clone_url;
    string svn_url;
    int forks;
    int open_issues;
    int watchers;
    string[] topics?;
    string? mirror_url;
    boolean has_issues;
    boolean has_projects;
    boolean has_pages;
    boolean has_wiki;
    boolean has_downloads;
    boolean has_discussions?;
    boolean archived;
    # Returns whether or not this repository disabled.
    boolean disabled;
    # The repository visibility: public, private, or internal.
    string visibility?;
    # License Simple
    NullableLicenseSimple? license;
    Fullrepository_permissions permissions?;
    SearchResultTextMatches text_matches?;
    string temp_clone_token?;
    boolean allow_merge_commit?;
    boolean allow_squash_merge?;
    boolean allow_rebase_merge?;
    boolean allow_auto_merge?;
    boolean delete_branch_on_merge?;
    boolean allow_forking?;
    boolean is_template?;
    boolean web_commit_signoff_required?;
};

public type ActionsOrganizationPermissions record {
    # The policy that controls the repositories in the organization that are allowed to run GitHub Actions.
    EnabledRepositories enabled_repositories;
    # The API URL to use to get or set the selected repositories that are allowed to run GitHub Actions, when `enabled_repositories` is set to `selected`.
    string selected_repositories_url?;
    # The permissions policy that controls the actions and reusable workflows that are allowed to run.
    AllowedActions allowed_actions?;
    # The API URL to use to get or set the actions and reusable workflows that are allowed to run, when `allowed_actions` is set to `selected`.
    SelectedActionsUrl selected_actions_url?;
};

public type Workflowusage_billable record {
    Workflowusage_billable_UBUNTU UBUNTU?;
    Workflowusage_billable_UBUNTU MACOS?;
    Workflowusage_billable_UBUNTU WINDOWS?;
};

# Scim Error
public type ScimError record {
    string? message?;
    string? documentation_url?;
    string? detail?;
    int status?;
    string? scimType?;
    string[] schemas?;
};

public type Contributoractivity_weeks record {
    int w?;
    int a?;
    int d?;
    int c?;
};

public type SelectedActions record {
    # Whether GitHub-owned actions are allowed. For example, this includes the actions in the `actions` organization.
    boolean github_owned_allowed?;
    # Whether actions from GitHub Marketplace verified creators are allowed. Set to `true` to allow all actions by GitHub Marketplace verified creators.
    boolean verified_allowed?;
    # Specifies a list of string-matching patterns to allow specific action(s) and reusable workflow(s). Wildcards, tags, and SHAs are allowed. For example, `monalisa/octocat@*`, `monalisa/octocat@v2`, `monalisa/*`.
    # 
    # **Note**: The `patterns_allowed` setting only applies to public repositories.
    string[] patterns_allowed?;
};

public type Teamproject_permissions record {
    boolean read;
    boolean write;
    boolean admin;
};

public type Gitcommit_tree record {
    # SHA for the commit
    string sha;
    string url;
};

public type Addedtoprojectissueevent_project_card record {
    int id;
    string url;
    int project_id;
    string project_url;
    string column_name;
    string previous_column_name?;
};

# Base Gist
public type BaseGist record {
    string url;
    string forks_url;
    string commits_url;
    string id;
    string node_id;
    string git_pull_url;
    string git_push_url;
    string html_url;
    record {|Basegist_files...;|} files;
    boolean 'public;
    string created_at;
    string updated_at;
    string? description;
    int comments;
    # A GitHub user.
    NullableSimpleUser? user;
    string comments_url;
    # A GitHub user.
    SimpleUser owner?;
    boolean truncated?;
    anydata[] forks?;
    anydata[] history?;
};

# Issue Search Result Item
public type IssueSearchResultItem record {
    string url;
    string repository_url;
    string labels_url;
    string comments_url;
    string events_url;
    string html_url;
    int id;
    string node_id;
    int number;
    string title;
    boolean locked;
    string? active_lock_reason?;
    SimpleUser[]? assignees?;
    # A GitHub user.
    NullableSimpleUser? user;
    Issuesearchresultitem_labels[] labels;
    string state;
    string? state_reason?;
    # A GitHub user.
    NullableSimpleUser? assignee;
    # A collection of related issues and pull requests.
    NullableMilestone? milestone;
    int comments;
    string created_at;
    string updated_at;
    string? closed_at;
    SearchResultTextMatches text_matches?;
    Issue_pull_request pull_request?;
    string body?;
    decimal score;
    # How the author is associated with the repository.
    AuthorAssociation author_association;
    boolean draft?;
    # A repository on GitHub.
    Repository repository?;
    string body_html?;
    string body_text?;
    string timeline_url?;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app?;
    ReactionRollup reactions?;
};

# A repository on GitHub.
public type Repository record {
    # Unique identifier of the repository
    int id;
    string node_id;
    # The name of the repository.
    string name;
    string full_name;
    # License Simple
    NullableLicenseSimple? license;
    # A GitHub user.
    NullableSimpleUser? organization?;
    int forks;
    Repository_permissions permissions?;
    # A GitHub user.
    SimpleUser owner;
    # Whether the repository is private or public.
    boolean 'private;
    string html_url;
    string? description;
    boolean 'fork;
    string url;
    string archive_url;
    string assignees_url;
    string blobs_url;
    string branches_url;
    string collaborators_url;
    string comments_url;
    string commits_url;
    string compare_url;
    string contents_url;
    string contributors_url;
    string deployments_url;
    string downloads_url;
    string events_url;
    string forks_url;
    string git_commits_url;
    string git_refs_url;
    string git_tags_url;
    string git_url;
    string issue_comment_url;
    string issue_events_url;
    string issues_url;
    string keys_url;
    string labels_url;
    string languages_url;
    string merges_url;
    string milestones_url;
    string notifications_url;
    string pulls_url;
    string releases_url;
    string ssh_url;
    string stargazers_url;
    string statuses_url;
    string subscribers_url;
    string subscription_url;
    string tags_url;
    string teams_url;
    string trees_url;
    string clone_url;
    string? mirror_url;
    string hooks_url;
    string svn_url;
    string? homepage;
    string? language;
    int forks_count;
    int stargazers_count;
    int watchers_count;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0.
    int size;
    # The default branch of the repository.
    string default_branch;
    int open_issues_count;
    # Whether this repository acts as a template that can be used to generate new repositories.
    boolean is_template = false;
    string[] topics?;
    # Whether issues are enabled.
    boolean has_issues;
    # Whether projects are enabled.
    boolean has_projects;
    # Whether the wiki is enabled.
    boolean has_wiki;
    boolean has_pages;
    # Whether downloads are enabled.
    boolean has_downloads;
    # Whether discussions are enabled.
    boolean has_discussions = false;
    # Whether the repository is archived.
    boolean archived;
    # Returns whether or not this repository disabled.
    boolean disabled;
    # The repository visibility: public, private, or internal.
    string visibility = "public";
    string? pushed_at;
    string? created_at;
    string? updated_at;
    # Whether to allow rebase merges for pull requests.
    boolean allow_rebase_merge = true;
    Repository_template_repository? template_repository?;
    string temp_clone_token?;
    # Whether to allow squash merges for pull requests.
    boolean allow_squash_merge = true;
    # Whether to allow Auto-merge to be used on pull requests.
    boolean allow_auto_merge = false;
    # Whether to delete head branches when pull requests are merged
    boolean delete_branch_on_merge = false;
    # Whether or not a pull request head branch that is behind its base branch can always be updated even if it is not required to be up to date before merging.
    boolean allow_update_branch = false;
    # Whether a squash merge commit can use the pull request title as default. **This property has been deprecated. Please use `squash_merge_commit_title` instead.
    boolean use_squash_pr_title_as_default = false;
    # The default value for a squash merge commit title:
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `COMMIT_OR_PR_TITLE` - default to the commit's title (if only one commit) or the pull request's title (when more than one commit).
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squash_merge_commit_title?;
    # The default value for a squash merge commit message:
    # 
    # - `PR_BODY` - default to the pull request's body.
    # - `COMMIT_MESSAGES` - default to the branch's commit messages.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squash_merge_commit_message?;
    # The default value for a merge commit title.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `MERGE_MESSAGE` - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name).
    "PR_TITLE"|"MERGE_MESSAGE" merge_commit_title?;
    # The default value for a merge commit message.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `PR_BODY` - default to the pull request's body.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"PR_TITLE"|"BLANK" merge_commit_message?;
    # Whether to allow merge commits for pull requests.
    boolean allow_merge_commit = true;
    # Whether to allow forking this repo
    boolean allow_forking?;
    # Whether to require contributors to sign off on web-based commits
    boolean web_commit_signoff_required = false;
    int subscribers_count?;
    int network_count?;
    int open_issues;
    int watchers;
    string master_branch?;
    string starred_at?;
    # Whether anonymous git access is enabled for this repository
    boolean anonymous_access_enabled?;
};

# Minimal Repository
public type MinimalRepository record {
    int id;
    string node_id;
    string name;
    string full_name;
    # A GitHub user.
    SimpleUser owner;
    boolean 'private;
    string html_url;
    string? description;
    boolean 'fork;
    string url;
    string archive_url;
    string assignees_url;
    string blobs_url;
    string branches_url;
    string collaborators_url;
    string comments_url;
    string commits_url;
    string compare_url;
    string contents_url;
    string contributors_url;
    string deployments_url;
    string downloads_url;
    string events_url;
    string forks_url;
    string git_commits_url;
    string git_refs_url;
    string git_tags_url;
    string git_url?;
    string issue_comment_url;
    string issue_events_url;
    string issues_url;
    string keys_url;
    string labels_url;
    string languages_url;
    string merges_url;
    string milestones_url;
    string notifications_url;
    string pulls_url;
    string releases_url;
    string ssh_url?;
    string stargazers_url;
    string statuses_url;
    string subscribers_url;
    string subscription_url;
    string tags_url;
    string teams_url;
    string trees_url;
    string clone_url?;
    string? mirror_url?;
    string hooks_url;
    string svn_url?;
    string? homepage?;
    string? language?;
    int forks_count?;
    int stargazers_count?;
    int watchers_count?;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0.
    int size?;
    string default_branch?;
    int open_issues_count?;
    boolean is_template?;
    string[] topics?;
    boolean has_issues?;
    boolean has_projects?;
    boolean has_wiki?;
    boolean has_pages?;
    boolean has_downloads?;
    boolean has_discussions?;
    boolean archived?;
    boolean disabled?;
    string visibility?;
    string? pushed_at?;
    string? created_at?;
    string? updated_at?;
    Repository_template_repository_permissions permissions?;
    string role_name?;
    string temp_clone_token?;
    boolean delete_branch_on_merge?;
    int subscribers_count?;
    int network_count?;
    # Code Of Conduct
    CodeOfConduct code_of_conduct?;
    Minimalrepository_license? license?;
    int forks?;
    int open_issues?;
    int watchers?;
    boolean allow_forking?;
    boolean web_commit_signoff_required?;
    SecurityAndAnalysis? security_and_analysis?;
};

# Timeline Assigned Issue Event
public type TimelineAssignedIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    # A GitHub user.
    SimpleUser assignee;
};

# Starred Repository
public type StarredRepository record {
    string starred_at;
    # A repository on GitHub.
    Repository repo;
};

# The time that the alert was last updated in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
public type AlertUpdatedAt string;

public type Projects_project_id_body_1 record {
    # Name of the project
    string name?;
    # Body of the project
    string? body?;
    # State of the project; either 'open' or 'closed'
    string state?;
    # The baseline permission that all organization members have on this project
    "read"|"write"|"admin"|"none" organization_permission?;
    # Whether or not this project can be seen by everyone.
    boolean 'private?;
};

# Starred Repository
public type StarredRepositoryResponse StarredRepository[]|Repository[];

public type Projects_project_id_body_2 record {
    # The permission to grant to the team for this project. Default: the team's `permission` attribute will be used to determine what permission to grant the team on this project. Note that, if you choose not to pass any parameters, you'll need to set `Content-Length` to zero when calling this endpoint. For more information, see "[HTTP verbs](https://docs.github.com/rest/overview/resources-in-the-rest-api#http-verbs)."
    "read"|"write"|"admin" permission?;
};

# Issues are a great way to keep track of tasks, enhancements, and bugs for your projects.
public type Issue record {
    int id;
    string node_id;
    # URL for the issue
    string url;
    string repository_url;
    string labels_url;
    string comments_url;
    string events_url;
    string html_url;
    # Number uniquely identifying the issue within its repository
    int number;
    # State of the issue; either 'open' or 'closed'
    string state;
    # The reason for the current state
    "completed"|"reopened"|"not_planned"? state_reason?;
    # Title of the issue
    string title;
    # Contents of the issue
    string? body?;
    # A GitHub user.
    NullableSimpleUser? user;
    # Labels to associate with this issue; pass one or more label names to replace the set of labels on this issue; send an empty array to clear all labels from the issue; note that the labels are silently dropped for users without push access to the repository
    (string|record {int id?; string node_id?; string url?; string name?; string? description?; string? color?; boolean default?;})[] labels;
    # A GitHub user.
    NullableSimpleUser? assignee;
    SimpleUser[]? assignees?;
    # A collection of related issues and pull requests.
    NullableMilestone? milestone;
    boolean locked;
    string? active_lock_reason?;
    int comments;
    Issue_pull_request pull_request?;
    string? closed_at;
    string created_at;
    string updated_at;
    boolean draft?;
    # A GitHub user.
    NullableSimpleUser? closed_by?;
    string body_html?;
    string body_text?;
    string timeline_url?;
    # A repository on GitHub.
    Repository repository?;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app?;
    # How the author is associated with the repository.
    AuthorAssociation author_association;
    ReactionRollup reactions?;
};

public type Rulesets_ruleset_id_body_1 record {
    # The name of the ruleset.
    string name?;
    # The target of the ruleset.
    "branch"|"tag" target?;
    # The enforcement level of the ruleset. `evaluate` allows admins to test rules before enforcing them. Admins can view insights on the Rule Insights page (`evaluate` is only available with GitHub Enterprise).
    RepositoryRuleEnforcement enforcement?;
    # The actors that can bypass the rules in this ruleset
    RepositoryRulesetBypassActor[] bypass_actors?;
    # Parameters for a repository ruleset ref name condition
    RepositoryRulesetConditions conditions?;
    # An array of rules within the ruleset.
    RepositoryRule[] rules?;
};

# Minimal representation of an organization programmatic access grant for enumerations
public type OrganizationProgrammaticAccessGrant record {
    # Unique identifier of the fine-grained personal access token. The `pat_id` used to get details about an approved fine-grained personal access token.
    int id;
    # A GitHub user.
    SimpleUser owner;
    # Type of repository selection requested.
    "none"|"all"|"subset" repository_selection;
    # URL to the list of repositories the fine-grained personal access token can access. Only follow when `repository_selection` is `subset`.
    string repositories_url;
    # Permissions requested, categorized by type of permission.
    Organizationprogrammaticaccessgrantrequest_permissions permissions;
    # Date and time when the fine-grained personal access token was approved to access the organization.
    string access_granted_at;
    # Whether the associated fine-grained personal access token has expired.
    boolean token_expired;
    # Date and time when the associated fine-grained personal access token expires.
    string? token_expires_at;
    # Date and time when the associated fine-grained personal access token was last used for authentication.
    string? token_last_used_at;
};

# Repository invitations let you manage who you collaborate with.
public type RepositorySubscription record {
    # Determines if notifications should be received from this repository.
    boolean subscribed;
    # Determines if all notifications should be blocked from this repository.
    boolean ignored;
    string? reason;
    string created_at;
    string url;
    string repository_url;
};

# A request for a specific ref(branch,sha,tag) to be deployed
public type Deployment record {
    string url;
    # Unique identifier of the deployment
    int id;
    string node_id;
    string sha;
    # The ref to deploy. This can be a branch, tag, or sha.
    string ref;
    # Parameter to specify a task to execute
    string task;
    record {}|string payload;
    string original_environment?;
    # Name for the target deployment environment.
    string environment;
    string? description;
    # A GitHub user.
    NullableSimpleUser? creator;
    string created_at;
    string updated_at;
    string statuses_url;
    string repository_url;
    # Specifies if the given environment is will no longer exist at some point in the future. Default: false.
    boolean transient_environment?;
    # Specifies if the given environment is one that end-users directly interact with. Default: false.
    boolean production_environment?;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app?;
};

public type Notifications_body record {
    # Describes the last point that notifications were checked. Anything updated since this time will not be marked as read. If you omit this parameter, all notifications are marked as read. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`. Default: The current timestamp.
    string last_read_at?;
    # Whether the notification has been read.
    boolean read?;
};

# Short Blob
public type ShortBlob record {
    string url;
    string sha;
};

# The type of GitHub user that can comment, open issues, or create pull requests while the interaction limit is in effect.
public type InteractionGroup "existing_users"|"contributors_only"|"collaborators_only";

# Configuration for code scanning default setup.
public type CodeScanningDefaultSetup record {
    # Code scanning default setup has been configured or not.
    "configured"|"not-configured" state?;
    # Languages to be analyzed.
    ("c-cpp"|"csharp"|"go"|"java-kotlin"|"javascript-typescript"|"javascript"|"python"|"ruby"|"typescript"|"swift")[] languages?;
    # CodeQL query suite to be used.
    "default"|"extended" query_suite?;
    # Timestamp of latest configuration update.
    string? updated_at?;
    # The frequency of the periodic analysis.
    "weekly" schedule?;
};

public type ParticipationStats record {
    int[] all;
    int[] owner;
};

public type Variables_name_body_1 record {
    # The name of the variable.
    string name?;
    # The value of the variable.
    string value?;
};

public type Issue_number_labels_body_1 record {
    # The names of the labels to add to the issue's existing labels. You can pass an empty array to remove all labels. Alternatively, you can pass a single label as a `string` or an `array` of labels directly, but GitHub recommends passing an object with the `labels` key. You can also replace all of the labels for an issue. For more information, see "[Set labels for an issue](https://docs.github.com/rest/issues/labels#set-labels-for-an-issue)."
    @constraint:Array {minLength: 1}
    string[] labels?;
}|string[]|record {@constraint:Array {minLength: 1}
    Reposownerrepoissuesissue_numberlabels_labels[] labels?;}|record {string name;}[]|string;

public type Commit_commit record {
    string url;
    # Metaproperties for Git author/committer information.
    NullableGitUser? author;
    # Metaproperties for Git author/committer information.
    NullableGitUser? committer;
    string message;
    int comment_count;
    Commit_commit_tree tree;
    Verification verification?;
};

public type Variables_name_body_2 record {
    # The name of the variable.
    string name?;
    # The value of the variable.
    string value?;
};

# A list of directory items
public type ContentDirectory Contentdirectory_inner[];

# Git references within a repository
public type GitRef record {
    string ref;
    string node_id;
    string url;
    Gitref_object 'object;
};

# User Search Result Item
public type UserSearchResultItem record {
    string login;
    int id;
    string node_id;
    string avatar_url;
    string? gravatar_id;
    string url;
    string html_url;
    string followers_url;
    string subscriptions_url;
    string organizations_url;
    string repos_url;
    string received_events_url;
    string 'type;
    decimal score;
    string following_url;
    string gists_url;
    string starred_url;
    string events_url;
    int public_repos?;
    int public_gists?;
    int followers?;
    int following?;
    string created_at?;
    string updated_at?;
    string? name?;
    string? bio?;
    string? email?;
    string? location?;
    boolean site_admin;
    boolean? hireable?;
    SearchResultTextMatches text_matches?;
    string? blog?;
    string? company?;
    string? suspended_at?;
};

public type Pullrequestreviewcomment__links record {
    Pullrequestreviewcomment__links_self self;
    Pullrequestreviewcomment__links_html html;
    Pullrequestreviewcomment__links_pull_request pull_request;
};

# Use the `status` property to enable or disable secret scanning push protection for this repository. For more information, see "[Protecting pushes with secret scanning](/code-security/secret-scanning/protecting-pushes-with-secret-scanning)."
public type Reposownerrepo_security_and_analysis_secret_scanning_push_protection record {
    # Can be `enabled` or `disabled`.
    string status?;
};

# Timeline Reviewed Event
public type TimelineReviewedEvent record {
    string event;
    # Unique identifier of the review
    int id;
    string node_id;
    # A GitHub user.
    SimpleUser user;
    # The text of the review.
    string? body;
    string state;
    string html_url;
    string pull_request_url;
    Timelinereviewedevent__links _links;
    string submitted_at?;
    # A commit SHA for the review.
    string commit_id;
    string body_html?;
    string body_text?;
    # How the author is associated with the repository.
    AuthorAssociation author_association;
};

# The time that the alert was created in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
public type AlertCreatedAt string;

# Parameters for a repository name condition
public type RepositoryRulesetConditionsRepositoryNameTarget record {
    Repositoryrulesetconditionsrepositorynametarget_repository_name repository_name;
};

# A Discussion in a repository.
public type Discussion record {
    string? active_lock_reason;
    string? answer_chosen_at;
    User? answer_chosen_by;
    string? answer_html_url;
    # How the author is associated with the repository.
    "COLLABORATOR"|"CONTRIBUTOR"|"FIRST_TIMER"|"FIRST_TIME_CONTRIBUTOR"|"MANNEQUIN"|"MEMBER"|"NONE"|"OWNER" author_association;
    string body;
    Discussion_category category;
    int comments;
    string created_at;
    string html_url;
    int id;
    boolean locked;
    string node_id;
    int number;
    Reactions reactions?;
    string repository_url;
    # The current state of the discussion.
    # `converting` means that the discussion is being converted from an issue.
    # `transferring` means that the discussion is being transferred from another repository.
    "open"|"closed"|"locked"|"converting"|"transferring" state;
    # The reason for the current state
    "resolved"|"outdated"|"duplicate"|"reopened" state_reason;
    string timeline_url?;
    string title;
    string updated_at;
    User? user;
};

# Deployment protection rule
public type DeploymentProtectionRuleResponse record {
    # The number of enabled custom deployment protection rules for this environment
    int total_count?;
    DeploymentProtectionRule[] custom_deployment_protection_rules?;
};

# Low-level Git commit operations within a repository
public type GitCommit record {
    # SHA for the commit
    string sha;
    string node_id;
    string url;
    # Identifying information for the git-user
    Gitcommit_author author;
    # Identifying information for the git-user
    Gitcommit_author committer;
    # Message describing the purpose of the commit
    string message;
    Gitcommit_tree tree;
    Gitcommit_parents[] parents;
    Gitcommit_verification verification;
    string html_url;
};

public type Repo_autolinks_body record {
    # This prefix appended by certain characters will generate a link any time it is found in an issue, pull request, or commit.
    string key_prefix;
    # The URL must contain `<num>` for the reference number. `<num>` matches different characters depending on the value of `is_alphanumeric`.
    string url_template;
    # Whether this autolink reference matches alphanumeric characters. If true, the `<num>` parameter of the `url_template` matches alphanumeric characters `A-Z` (case insensitive), `0-9`, and `-`. If false, this autolink reference only matches numeric characters.
    boolean is_alphanumeric = true;
};

public type Column_id_moves_body record {
    # The position of the column in a project. Can be one of: `first`, `last`, or `after:<column_id>` to place after the specified column.
    @constraint:String {pattern: re `^(?:first|last|after:\d+)$`}
    string position;
};

# A suite of checks performed on the code of a given code change
public type CheckSuiteResponse record {
    int total_count;
    CheckSuite[] check_suites;
};

public type Labels_name_body record {
    # The new name of the label. Emoji can be added to label names, using either native emoji or colon-style markup. For example, typing `:strawberry:` will render the emoji ![:strawberry:](https://github.githubassets.com/images/icons/emoji/unicode/1f353.png ":strawberry:"). For a full list of available emoji and codes, see "[Emoji cheat sheet](https://github.com/ikatyang/emoji-cheat-sheet)."
    string new_name?;
    # The [hexadecimal color code](http://www.color-hex.com/) for the label, without the leading `#`.
    string color?;
    # A short description of the label. Must be 100 characters or fewer.
    string description?;
};

public type Repositoryadvisorycreate_credits record {|
    # The username of the user credited.
    string login;
    # The type of credit the user is receiving.
    SecurityAdvisoryCreditTypes 'type;
|};

# A reply to a discussion within a team.
public type TeamDiscussionComment record {
    # A GitHub user.
    NullableSimpleUser? author;
    # The main text of the comment.
    string body;
    string body_html;
    # The current version of the body content. If provided, this update operation will be rejected if the given version does not match the latest version on the server.
    string body_version;
    string created_at;
    string? last_edited_at;
    string discussion_url;
    string html_url;
    string node_id;
    # The unique sequence number of a team discussion comment.
    int number;
    string updated_at;
    string url;
    ReactionRollup reactions?;
};

# Gitignore Template
public type GitignoreTemplate record {
    string name;
    string 'source;
};

# The source branch and directory used to publish your Pages site.
public type Reposownerrepopages_source record {
    # The repository branch used to publish your site's source files.
    string branch;
    # The repository directory that includes the source files for the Pages site. Allowed paths are `/` or `/docs`. Default: `/`
    "/"|"/docs" path = "/";
};

public type Reposownerrepocheckruns_output_images record {
    # The alternative text for the image.
    string alt;
    # The full URL of the image.
    string image_url;
    # A short image description.
    string caption?;
};

public type Commit_stats record {
    int additions?;
    int deletions?;
    int total?;
};

# An entry in the reviews log for environment deployments
public type EnvironmentApprovals record {
    # The list of environments that were approved or rejected
    Environmentapprovals_environments[] environments;
    # Whether deployment to the environment(s) was approved or rejected or pending (with comments)
    "approved"|"rejected"|"pending" state;
    # A GitHub user.
    SimpleUser user;
    # The comment submitted with the deployment review
    string comment;
};

# Language
public type Language record {|
    int...;
|};

# An object without any properties.
public type EmptyObject record {|
|};

# Combined Commit Status
public type CombinedCommitStatus record {
    string state;
    SimpleCommitStatus[] statuses;
    string sha;
    int total_count;
    # Minimal Repository
    MinimalRepository repository;
    string commit_url;
    string url;
};

# Delivery made by a webhook.
public type HookDelivery record {
    # Unique identifier of the delivery.
    int id;
    # Unique identifier for the event (shared with all deliveries for all webhooks that subscribe to this event).
    string guid;
    # Time when the delivery was delivered.
    string delivered_at;
    # Whether the delivery is a redelivery.
    boolean redelivery;
    # Time spent delivering.
    decimal duration;
    # Description of the status of the attempted delivery
    string status;
    # Status code received when delivery was made.
    int status_code;
    # The event that triggered the delivery.
    string event;
    # The type of activity for the event that triggered the delivery.
    string? action;
    # The id of the GitHub App installation associated with this event.
    int? installation_id;
    # The id of the repository associated with this event.
    int? repository_id;
    # The URL target of the delivery.
    string url?;
    Hookdelivery_request request;
    Hookdelivery_response response;
};

# Locked Issue Event
public type LockedIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    string? lock_reason;
};

public type Review_id_dismissals_body record {
    # The message for the pull request review dismissal
    string message;
    "DISMISS" event?;
};

# Hovercard
public type Hovercard record {
    Hovercard_contexts[] contexts;
};

public type Restrictions_apps_body_1 record {
    # The GitHub Apps that have push access to this branch. Use the slugified version of the app name. **Note**: The list of users, apps, and teams in total is limited to 100 items.
    string[] apps;
}|string[];

# Legacy Review Comment
public type ReviewComment record {
    string url;
    int? pull_request_review_id;
    int id;
    string node_id;
    string diff_hunk;
    string path;
    int? position;
    int original_position;
    string commit_id;
    string original_commit_id;
    int in_reply_to_id?;
    # A GitHub user.
    NullableSimpleUser? user;
    string body;
    string created_at;
    string updated_at;
    string html_url;
    string pull_request_url;
    # How the author is associated with the repository.
    AuthorAssociation author_association;
    Reviewcomment__links _links;
    string body_text?;
    string body_html?;
    ReactionRollup reactions?;
    # The side of the first line of the range for a multi-line comment.
    "LEFT"|"RIGHT" side = "RIGHT";
    # The side of the first line of the range for a multi-line comment.
    "LEFT"|"RIGHT" start_side = "RIGHT";
    # The line of the blob to which the comment applies. The last line of the range for a multi-line comment
    int line?;
    # The original line of the blob to which the comment applies. The last line of the range for a multi-line comment
    int original_line?;
    # The first line of the range for a multi-line comment.
    int? start_line?;
    # The original first line of the range for a multi-line comment.
    int? original_start_line?;
};

public type Comments_comment_id_body record {
    # The comment text.
    @constraint:String {maxLength: 65535}
    string body;
};

# A team's access to a repository.
public type TeamRepository record {
    # Unique identifier of the repository
    int id;
    string node_id;
    # The name of the repository.
    string name;
    string full_name;
    # License Simple
    NullableLicenseSimple? license;
    int forks;
    Repository_permissions permissions?;
    string role_name?;
    # A GitHub user.
    NullableSimpleUser? owner;
    # Whether the repository is private or public.
    boolean 'private;
    string html_url;
    string? description;
    boolean 'fork;
    string url;
    string archive_url;
    string assignees_url;
    string blobs_url;
    string branches_url;
    string collaborators_url;
    string comments_url;
    string commits_url;
    string compare_url;
    string contents_url;
    string contributors_url;
    string deployments_url;
    string downloads_url;
    string events_url;
    string forks_url;
    string git_commits_url;
    string git_refs_url;
    string git_tags_url;
    string git_url;
    string issue_comment_url;
    string issue_events_url;
    string issues_url;
    string keys_url;
    string labels_url;
    string languages_url;
    string merges_url;
    string milestones_url;
    string notifications_url;
    string pulls_url;
    string releases_url;
    string ssh_url;
    string stargazers_url;
    string statuses_url;
    string subscribers_url;
    string subscription_url;
    string tags_url;
    string teams_url;
    string trees_url;
    string clone_url;
    string? mirror_url;
    string hooks_url;
    string svn_url;
    string? homepage;
    string? language;
    int forks_count;
    int stargazers_count;
    int watchers_count;
    int size;
    # The default branch of the repository.
    string default_branch;
    int open_issues_count;
    # Whether this repository acts as a template that can be used to generate new repositories.
    boolean is_template = false;
    string[] topics?;
    # Whether issues are enabled.
    boolean has_issues;
    # Whether projects are enabled.
    boolean has_projects;
    # Whether the wiki is enabled.
    boolean has_wiki;
    boolean has_pages;
    # Whether downloads are enabled.
    boolean has_downloads;
    # Whether the repository is archived.
    boolean archived;
    # Returns whether or not this repository disabled.
    boolean disabled;
    # The repository visibility: public, private, or internal.
    string visibility = "public";
    string? pushed_at;
    string? created_at;
    string? updated_at;
    # Whether to allow rebase merges for pull requests.
    boolean allow_rebase_merge = true;
    # A repository on GitHub.
    NullableRepository? template_repository?;
    string temp_clone_token?;
    # Whether to allow squash merges for pull requests.
    boolean allow_squash_merge = true;
    # Whether to allow Auto-merge to be used on pull requests.
    boolean allow_auto_merge = false;
    # Whether to delete head branches when pull requests are merged
    boolean delete_branch_on_merge = false;
    # Whether to allow merge commits for pull requests.
    boolean allow_merge_commit = true;
    # Whether to allow forking this repo
    boolean allow_forking = false;
    # Whether to require contributors to sign off on web-based commits
    boolean web_commit_signoff_required = false;
    int subscribers_count?;
    int network_count?;
    int open_issues;
    int watchers;
    string master_branch?;
};

public type Restrictions_apps_body_2 record {
    # The GitHub Apps that have push access to this branch. Use the slugified version of the app name. **Note**: The list of users, apps, and teams in total is limited to 100 items.
    string[] apps;
}|string[];

public type Orghook_config record {
    string url?;
    string insecure_ssl?;
    string content_type?;
    string secret?;
};

public type Repo_milestones_body record {
    # The title of the milestone.
    string title;
    # The state of the milestone. Either `open` or `closed`.
    "open"|"closed" state = "open";
    # A description of the milestone.
    string description?;
    # The milestone due date. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    string due_on?;
};

# Details of a deployment branch or tag policy.
public type DeploymentBranchPolicyResponse record {
    # The number of deployment branch policies for the environment.
    int total_count;
    DeploymentBranchPolicy[] branch_policies;
};

# A GitHub repository.
public type SimpleRepository record {
    # A unique identifier of the repository.
    int id;
    # The GraphQL identifier of the repository.
    string node_id;
    # The name of the repository.
    string name;
    # The full, globally unique, name of the repository.
    string full_name;
    # A GitHub user.
    SimpleUser owner;
    # Whether the repository is private.
    boolean 'private;
    # The URL to view the repository on GitHub.com.
    string html_url;
    # The repository description.
    string? description;
    # Whether the repository is a fork.
    boolean 'fork;
    # The URL to get more information about the repository from the GitHub API.
    string url;
    # A template for the API URL to download the repository as an archive.
    string archive_url;
    # A template for the API URL to list the available assignees for issues in the repository.
    string assignees_url;
    # A template for the API URL to create or retrieve a raw Git blob in the repository.
    string blobs_url;
    # A template for the API URL to get information about branches in the repository.
    string branches_url;
    # A template for the API URL to get information about collaborators of the repository.
    string collaborators_url;
    # A template for the API URL to get information about comments on the repository.
    string comments_url;
    # A template for the API URL to get information about commits on the repository.
    string commits_url;
    # A template for the API URL to compare two commits or refs.
    string compare_url;
    # A template for the API URL to get the contents of the repository.
    string contents_url;
    # A template for the API URL to list the contributors to the repository.
    string contributors_url;
    # The API URL to list the deployments of the repository.
    string deployments_url;
    # The API URL to list the downloads on the repository.
    string downloads_url;
    # The API URL to list the events of the repository.
    string events_url;
    # The API URL to list the forks of the repository.
    string forks_url;
    # A template for the API URL to get information about Git commits of the repository.
    string git_commits_url;
    # A template for the API URL to get information about Git refs of the repository.
    string git_refs_url;
    # A template for the API URL to get information about Git tags of the repository.
    string git_tags_url;
    # A template for the API URL to get information about issue comments on the repository.
    string issue_comment_url;
    # A template for the API URL to get information about issue events on the repository.
    string issue_events_url;
    # A template for the API URL to get information about issues on the repository.
    string issues_url;
    # A template for the API URL to get information about deploy keys on the repository.
    string keys_url;
    # A template for the API URL to get information about labels of the repository.
    string labels_url;
    # The API URL to get information about the languages of the repository.
    string languages_url;
    # The API URL to merge branches in the repository.
    string merges_url;
    # A template for the API URL to get information about milestones of the repository.
    string milestones_url;
    # A template for the API URL to get information about notifications on the repository.
    string notifications_url;
    # A template for the API URL to get information about pull requests on the repository.
    string pulls_url;
    # A template for the API URL to get information about releases on the repository.
    string releases_url;
    # The API URL to list the stargazers on the repository.
    string stargazers_url;
    # A template for the API URL to get information about statuses of a commit.
    string statuses_url;
    # The API URL to list the subscribers on the repository.
    string subscribers_url;
    # The API URL to subscribe to notifications for this repository.
    string subscription_url;
    # The API URL to get information about tags on the repository.
    string tags_url;
    # The API URL to list the teams on the repository.
    string teams_url;
    # A template for the API URL to create or retrieve a raw Git tree of the repository.
    string trees_url;
    # The API URL to list the hooks on the repository.
    string hooks_url;
};

# A GitHub user.
public type NullableSimpleUser record {
    string? name?;
    string? email?;
    string login;
    int id;
    string node_id;
    string avatar_url;
    string? gravatar_id;
    string url;
    string html_url;
    string followers_url;
    string following_url;
    string gists_url;
    string starred_url;
    string subscriptions_url;
    string organizations_url;
    string repos_url;
    string events_url;
    string received_events_url;
    string 'type;
    boolean site_admin;
    string starred_at?;
};

# Successful deletion of a code scanning analysis
public type CodeScanningAnalysisDeletion record {
    # Next deletable analysis in chain, without last analysis deletion confirmation
    string? next_analysis_url;
    # Next deletable analysis in chain, with last analysis deletion confirmation
    string? confirm_delete_url;
};

public type DeploymentBranchPolicyNamePattern record {
    # The name pattern that branches must match in order to deploy to the environment.
    # 
    # Wildcard characters will not match `/`. For example, to match branches that begin with `release/` and contain an additional single slash, use `release/*/*`.
    # For more information about pattern matching syntax, see the [Ruby File.fnmatch documentation](https://ruby-doc.org/core-2.5.1/File.html#method-c-fnmatch).
    string name;
};

# Commits pushed to matching refs must have verified signatures.
public type RepositoryRuleRequiredSignatures record {
    "required_signatures" 'type;
};

public type Workflow_id int|string;

# Gist History
public type GistHistory record {
    # A GitHub user.
    NullableSimpleUser? user?;
    string version?;
    string committed_at?;
    Gisthistory_change_status change_status?;
    string url?;
};

# Basic Error
public type BasicError record {
    string message?;
    string documentation_url?;
    string url?;
    string status?;
};

public type OrganizationSecretScanningAlert record {
    # The security alert number.
    AlertNumber number?;
    # The time that the alert was created in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertCreatedAt created_at?;
    # The time that the alert was last updated in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    NullableAlertUpdatedAt? updated_at?;
    # The REST API URL of the alert resource.
    AlertUrl url?;
    # The GitHub URL of the alert resource.
    AlertHtmlUrl html_url?;
    # The REST API URL of the code locations for this alert.
    string locations_url?;
    # Sets the state of the secret scanning alert. You must provide `resolution` when you set the state to `resolved`.
    SecretScanningAlertState state?;
    # **Required when the `state` is `resolved`.** The reason for resolving the alert.
    SecretScanningAlertResolution? resolution?;
    # The time that the alert was resolved in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    string? resolved_at?;
    # A GitHub user.
    NullableSimpleUser? resolved_by?;
    # The type of secret that secret scanning detected.
    string secret_type?;
    # User-friendly name for the detected secret, matching the `secret_type`.
    # For a list of built-in patterns, see "[Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns#supported-secrets-for-advanced-security)."
    string secret_type_display_name?;
    # The secret that was detected.
    string secret?;
    # A GitHub repository.
    SimpleRepository repository?;
    # Whether push protection was bypassed for the detected secret.
    boolean? push_protection_bypassed?;
    # A GitHub user.
    NullableSimpleUser? push_protection_bypassed_by?;
    # The time that push protection was bypassed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    string? push_protection_bypassed_at?;
    # The comment that was optionally added when this alert was closed
    string? resolution_comment?;
};

public type Team_permissions record {
    boolean pull;
    boolean triage;
    boolean push;
    boolean maintain;
    boolean admin;
};

# A repository import from an external source.
public type Import record {
    string? vcs;
    boolean use_lfs?;
    # The URL of the originating repository.
    string vcs_url;
    string svc_root?;
    string tfvc_project?;
    "auth"|"error"|"none"|"detecting"|"choose"|"auth_failed"|"importing"|"mapping"|"waiting_to_push"|"pushing"|"complete"|"setup"|"unknown"|"detection_found_multiple"|"detection_found_nothing"|"detection_needs_auth" status;
    string? status_text?;
    string? failed_step?;
    string? error_message?;
    int? import_percent?;
    int? commit_count?;
    int? push_percent?;
    boolean has_large_files?;
    int large_files_size?;
    int large_files_count?;
    Import_project_choices[] project_choices?;
    string message?;
    int? authors_count?;
    string url;
    string html_url;
    string authors_url;
    string repository_url;
    string svn_root?;
};

public type Protectedbranch_required_linear_history record {|
    boolean enabled;
|};

# Marketplace Purchase
public type MarketplacePurchase record {
    string url;
    string 'type;
    int id;
    string login;
    string organization_billing_email?;
    string? email?;
    Marketplacepurchase_marketplace_pending_change? marketplace_pending_change?;
    Marketplacepurchase_marketplace_purchase marketplace_purchase;
};

# Codespace default attributes
public type CodespaceDefault record {
    string location;
    string? devcontainer_path;
};

public type Branchrestrictionpolicy_owner record {
    string login?;
    int id?;
    string node_id?;
    string url?;
    string repos_url?;
    string events_url?;
    string hooks_url?;
    string issues_url?;
    string members_url?;
    string public_members_url?;
    string avatar_url?;
    string description?;
    string gravatar_id?;
    string html_url?;
    string followers_url?;
    string following_url?;
    string gists_url?;
    string starred_url?;
    string subscriptions_url?;
    string organizations_url?;
    string received_events_url?;
    string 'type?;
    boolean site_admin?;
};

public type IssueEventDismissedReview record {
    string state;
    int review_id;
    string? dismissal_message;
    string? dismissal_commit_id?;
};

# Pull requests let you tell others about changes you've pushed to a repository on GitHub. Once a pull request is sent, interested parties can review the set of changes, discuss potential modifications, and even push follow-up commits if necessary.
public type PullRequest record {
    string url;
    int id;
    string node_id;
    string html_url;
    string diff_url;
    string patch_url;
    string issue_url;
    string commits_url;
    string review_comments_url;
    string review_comment_url;
    string comments_url;
    string statuses_url;
    # Number uniquely identifying the pull request within its repository.
    int number;
    # State of this Pull Request. Either `open` or `closed`.
    "open"|"closed" state;
    boolean locked;
    # The title of the pull request.
    string title;
    # A GitHub user.
    SimpleUser user;
    string? body;
    Pullrequest_labels[] labels;
    # A collection of related issues and pull requests.
    NullableMilestone? milestone;
    string? active_lock_reason?;
    string created_at;
    string updated_at;
    string? closed_at;
    string? merged_at;
    string? merge_commit_sha;
    # A GitHub user.
    NullableSimpleUser? assignee;
    SimpleUser[]? assignees?;
    SimpleUser[]? requested_reviewers?;
    TeamSimple[]? requested_teams?;
    Pullrequest_head head;
    Pullrequest_base base;
    Pullrequestsimple__links _links;
    # How the author is associated with the repository.
    AuthorAssociation author_association;
    # The status of auto merging a pull request.
    AutoMerge? auto_merge;
    # Indicates whether or not the pull request is a draft.
    boolean draft?;
    boolean merged;
    boolean? mergeable;
    boolean? rebaseable?;
    string mergeable_state;
    # A GitHub user.
    NullableSimpleUser? merged_by;
    int comments;
    int review_comments;
    # Indicates whether maintainers can modify the pull request.
    boolean maintainer_can_modify;
    int commits;
    int additions;
    int deletions;
    int changed_files;
};

# The author of the file. Default: The `committer` or the authenticated user if you omit `committer`.
public type Reposownerrepocontentspath_author record {
    # The name of the author or committer of the commit. You'll receive a `422` status code if `name` is omitted.
    string name;
    # The email of the author or committer of the commit. You'll receive a `422` status code if `email` is omitted.
    string email;
    string date?;
};

public type Billing_selected_teams_body_1 record {
    # The names of teams from which to revoke access to GitHub Copilot.
    @constraint:Array {minLength: 1}
    string[] selected_teams;
};

public type Repo_merges_body record {
    # The name of the base branch that the head will be merged into.
    string base;
    # The head to merge. This can be a branch name or a commit SHA1.
    string head;
    # Commit message to use for the merge commit. If omitted, a default message will be used.
    string commit_message?;
};

public type Branchrestrictionpolicy_apps record {
    int id?;
    string slug?;
    string node_id?;
    Branchrestrictionpolicy_owner owner?;
    string name?;
    string description?;
    string external_url?;
    string html_url?;
    string created_at?;
    string updated_at?;
    Branchrestrictionpolicy_permissions permissions?;
    string[] events?;
};

public type Client_id_token_body_1 record {
    # The OAuth access token used to authenticate to the GitHub API.
    string access_token;
};

public type Client_id_token_body_2 record {
    # The access_token of the OAuth or GitHub application.
    string access_token;
};

public type Workflowrunusage_billable_UBUNTU record {
    int total_ms;
    int jobs;
    Workflowrunusage_billable_UBUNTU_job_runs[] job_runs?;
};

public type Commitsearchresultitem_commit record {
    Commitsearchresultitem_commit_author author;
    # Metaproperties for Git author/committer information.
    NullableGitUser? committer;
    int comment_count;
    string message;
    Shortbranch_commit tree;
    string url;
    Verification verification?;
};

public type Repositoryadvisory_submission record {
    # Whether a private vulnerability report was accepted by the repository's administrators.
    boolean accepted;
};

public type Globaladvisory_credits record {
    # A GitHub user.
    SimpleUser user;
    # The type of credit the user is receiving.
    SecurityAdvisoryCreditTypes 'type;
};

# A public SSH key used to sign Git commits
public type SshSigningKey record {
    string 'key;
    int id;
    string title;
    string created_at;
};

public type User_keys_body record {
    # A descriptive name for the new key.
    string title?;
    # The public SSH key to add to your GitHub account.
    @constraint:String {pattern: re `^ssh-(rsa|dss|ed25519) |^ecdsa-sha2-nistp(256|384|521) `}
    string 'key;
};

# Identifying information for the git-user
public type Gitcommit_author record {
    # Timestamp of the commit
    string date;
    # Git email address of the user
    string email;
    # Name of the git user
    string name;
};

public type Root record {
    string current_user_url;
    string current_user_authorizations_html_url;
    string authorizations_url;
    string code_search_url;
    string commit_search_url;
    string emails_url;
    string emojis_url;
    string events_url;
    string feeds_url;
    string followers_url;
    string following_url;
    string gists_url;
    string hub_url;
    string issue_search_url;
    string issues_url;
    string keys_url;
    string label_search_url;
    string notifications_url;
    string organization_url;
    string organization_repositories_url;
    string organization_teams_url;
    string public_gists_url;
    string rate_limit_url;
    string repository_url;
    string repository_search_url;
    string current_user_repositories_url;
    string starred_url;
    string starred_gists_url;
    string topic_search_url?;
    string user_url;
    string user_organizations_url;
    string user_repositories_url;
    string user_search_url;
};

public type Org_personalaccesstokenrequests_body record {
    # Unique identifiers of the requests for access via fine-grained personal access token. Must be formed of between 1 and 100 `pat_request_id` values.
    @constraint:Array {maxLength: 100, minLength: 1}
    int[] pat_request_ids?;
    # Action to apply to the requests.
    "approve"|"deny" action;
    # Reason for approving or denying the requests. Max 1024 characters.
    string? reason?;
};

public type Pullrequest_head record {
    string label;
    string ref;
    Pullrequest_head_repo? repo;
    string sha;
    Pullrequest_head_repo_owner user;
};

public type Issue_number_labels_body record {
    # The names of the labels to set for the issue. The labels you set replace any existing labels. You can pass an empty array to remove all labels. Alternatively, you can pass a single label as a `string` or an `array` of labels directly, but GitHub recommends passing an object with the `labels` key. You can also add labels to the existing labels for an issue. For more information, see "[Add labels to an issue](https://docs.github.com/rest/issues/labels#add-labels-to-an-issue)."
    @constraint:Array {minLength: 1}
    string[] labels?;
}|string[]|record {@constraint:Array {minLength: 1}
    Reposownerrepoissuesissue_numberlabels_labels[] labels?;}|record {string name;}[]|string;

# If provided, the `secret` will be used as the `key` to generate the HMAC hex digest value for [delivery signature headers](https://docs.github.com/webhooks/event-payloads/#delivery-headers).
public type WebhookConfigSecret string;

# Create a new snapshot of a repository's dependencies.
public type Snapshot record {|
    # The version of the repository snapshot submission.
    int version;
    Snapshot_job job;
    # The commit SHA associated with this dependency snapshot. Maximum length: 40 characters.
    @constraint:String {maxLength: 40, minLength: 40}
    string sha;
    # The repository branch that triggered this snapshot.
    @constraint:String {pattern: re `^refs/`}
    string ref;
    # A description of the detector used.
    Snapshot_detector detector;
    # User-defined metadata to store domain-specific information limited to 8 keys with scalar values.
    Metadata metadata?;
    # A collection of package manifests, which are a collection of related dependencies declared in a file or representing a logical group of dependencies.
    record {|Manifest...;|} manifests?;
    # The time at which the snapshot was scanned.
    string scanned;
|};

# Label Search Result Item
public type LabelSearchResultItem record {
    int id;
    string node_id;
    string url;
    string name;
    string color;
    boolean default;
    string? description;
    decimal score;
    SearchResultTextMatches text_matches?;
};

public type Required_status_checks_contexts_body_1 record {
    # The name of the status checks
    string[] contexts;
}|string[];

# Actions OIDC subject customization for a repository
public type OidcCustomSubRepo record {
    # Whether to use the default template or not. If `true`, the `include_claim_keys` field is ignored.
    boolean use_default;
    # Array of unique strings. Each claim key can only contain alphanumeric characters and underscores.
    string[] include_claim_keys?;
};

public type Required_status_checks_contexts_body_2 record {
    # The name of the status checks
    string[] contexts;
}|string[];

public type Protectedbranchpullrequestreview_dismissal_restrictions record {
    # The list of users with review dismissal access.
    SimpleUser[] users?;
    # The list of teams with review dismissal access.
    Team[] teams?;
    # The list of apps with review dismissal access.
    Integration[] apps?;
    string url?;
    string users_url?;
    string teams_url?;
};

public type CodeScanningOrganizationAlertItems record {
    # The security alert number.
    AlertNumber number;
    # The time that the alert was created in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertCreatedAt created_at;
    # The time that the alert was last updated in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertUpdatedAt updated_at?;
    # The REST API URL of the alert resource.
    AlertUrl url;
    # The GitHub URL of the alert resource.
    AlertHtmlUrl html_url;
    # The REST API URL for fetching the list of instances for an alert.
    AlertInstancesUrl instances_url;
    # State of a code scanning alert.
    CodeScanningAlertState state;
    # The time that the alert was no longer detected and was considered fixed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertFixedAt? fixed_at?;
    # A GitHub user.
    NullableSimpleUser? dismissed_by;
    # The time that the alert was dismissed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertDismissedAt? dismissed_at;
    # **Required when the state is dismissed.** The reason for dismissing or closing the alert.
    CodeScanningAlertDismissedReason? dismissed_reason;
    # The dismissal comment associated with the dismissal of the alert.
    CodeScanningAlertDismissedComment? dismissed_comment?;
    CodeScanningAlertRule rule;
    CodeScanningAnalysisTool tool;
    CodeScanningAlertInstance most_recent_instance;
    # A GitHub repository.
    SimpleRepository repository;
};

# Merged branch response message
public type MergedBranchResponse record {
    string message?;
};

public type Alerts_alert_number_body record {
    # Sets the state of the code scanning alert. You must provide `dismissed_reason` when you set the state to `dismissed`.
    CodeScanningAlertSetState state;
    # **Required when the state is dismissed.** The reason for dismissing or closing the alert.
    CodeScanningAlertDismissedReason? dismissed_reason?;
    # The dismissal comment associated with the dismissal of the alert.
    CodeScanningAlertDismissedComment? dismissed_comment?;
};

# Content File
public type ContentFile record {
    "file" 'type;
    string encoding;
    int size;
    string name;
    string path;
    string content;
    string sha;
    string url;
    string? git_url;
    string? html_url;
    string? download_url;
    Contenttree__links _links;
    string target?;
    string submodule_git_url?;
};

public type Notificationthread_subject record {
    string title;
    string url;
    string latest_comment_url;
    string 'type;
};

public type Shortbranch_commit record {
    string sha;
    string url;
};

public type CodeScanningAlertRule record {
    # A unique identifier for the rule used to detect the alert.
    string? id?;
    # The name of the rule used to detect the alert.
    string name?;
    # The severity of the alert.
    "none"|"note"|"warning"|"error" severity?;
    # The security severity of the alert.
    "low"|"medium"|"high"|"critical" security_severity_level?;
    # A short description of the rule used to detect the alert.
    string description?;
    # description of the rule used to detect the alert.
    string full_description?;
    # A set of tags applicable for the rule.
    string[]? tags?;
    # Detailed documentation for the rule as GitHub Flavored Markdown.
    string? help?;
    # A link to the documentation for the rule used to detect the alert.
    string? help_uri?;
};

# The type of credit the user is receiving.
public type SecurityAdvisoryCreditTypes "analyst"|"finder"|"reporter"|"coordinator"|"remediation_developer"|"remediation_reviewer"|"remediation_verifier"|"tool"|"sponsor"|"other";

public type Runners_generatejitconfig_body record {
    # The name of the new runner.
    string name;
    # The ID of the runner group to register the runner to.
    int runner_group_id;
    # The names of the custom labels to add to the runner. **Minimum items**: 1. **Maximum items**: 100.
    @constraint:Array {maxLength: 100, minLength: 1}
    string[] labels;
    # The working directory to be used for job execution, relative to the runner install directory.
    string work_folder = "_work";
};

public type Invitations_invitation_id_body record {
    # The permissions that the associated user will have on the repository. Valid values are `read`, `write`, `maintain`, `triage`, and `admin`.
    "read"|"write"|"maintain"|"triage"|"admin" permissions?;
};

# The authorization for an OAuth app, GitHub App, or a Personal Access Token.
public type Authorization record {
    int id;
    string url;
    # A list of scopes that this authorization is in.
    string[]? scopes;
    string token;
    string? token_last_eight;
    string? hashed_token;
    Authorization_app app;
    string? note;
    string? note_url;
    string updated_at;
    string created_at;
    string? fingerprint;
    # A GitHub user.
    NullableSimpleUser? user?;
    NullableScopedInstallation? installation?;
    string? expires_at;
};

# A description of the machine powering a codespace.
public type NullableCodespaceMachine record {
    # The name of the machine.
    string name;
    # The display name of the machine includes cores, memory, and storage.
    string display_name;
    # The operating system of the machine.
    string operating_system;
    # How much storage is available to the codespace.
    int storage_in_bytes;
    # How much memory is available to the codespace.
    int memory_in_bytes;
    # How many cores are available to the codespace.
    int cpus;
    # Whether a prebuild is currently available when creating a codespace for this machine and repository. If a branch was not specified as a ref, the default branch will be assumed. Value will be "null" if prebuilds are not supported or prebuild availability could not be determined. Value will be "none" if no prebuild is available. Latest values "ready" and "in_progress" indicate the prebuild availability status.
    "none"|"ready"|"in_progress" prebuild_availability;
};

# Whether GitHub Actions is enabled on the repository.
public type ActionsEnabled boolean;

public type Repositoryruleset__links_html record {
    # The html URL of the ruleset
    string href?;
};

public type Run_id_pending_deployments_body record {
    # The list of environment ids to approve or reject
    int[] environment_ids;
    # Whether to approve or reject deployment to the specified environments.
    "approved"|"rejected" state;
    # A comment to accompany the deployment review
    string comment;
};

public type Pull_number_updatebranch_body record {
    # The expected SHA of the pull request's HEAD ref. This is the most recent commit on the pull request's branch. If the expected SHA does not match the pull request's HEAD, you will receive a `422 Unprocessable Entity` status. You can use the "[List commits](https://docs.github.com/rest/commits/commits#list-commits)" endpoint to find the most recent commit SHA. Default: SHA of the pull request's current HEAD ref.
    string expected_head_sha?;
};

# A GitHub Classroom classroom
public type SimpleClassroom record {
    # Unique identifier of the classroom.
    int id;
    # The name of the classroom.
    string name;
    # Returns whether classroom is archived or not.
    boolean archived;
    # The url of the classroom on GitHub Classroom.
    string url;
};

public type Event_payload_pages record {
    string page_name?;
    string title?;
    string? summary?;
    string action?;
    string sha?;
    string html_url?;
};

public type Repo_checksuites_body record {
    # The sha of the head commit.
    string head_sha;
};

# Org Hook
public type OrgHook record {
    int id;
    string url;
    string ping_url;
    string deliveries_url?;
    string name;
    string[] events;
    boolean active;
    Orghook_config config;
    string updated_at;
    string created_at;
    string 'type;
};

public type Repo_keys_body record {
    # A name for the key.
    string title?;
    # The contents of the key.
    string 'key;
    # If `true`, the key will only be able to read repository contents. Otherwise, the key will be able to read and write.  
    #   
    # Deploy keys with write access can perform the same actions as an organization member with admin access, or a collaborator on a personal repository. For more information, see "[Repository permission levels for an organization](https://docs.github.com/articles/repository-permission-levels-for-an-organization/)" and "[Permission levels for a user account repository](https://docs.github.com/articles/permission-levels-for-a-user-account-repository/)."
    boolean read_only?;
};

public type Import_project_choices record {
    string vcs?;
    string tfvc_project?;
    string human_name?;
};

public type Protectedbranch_required_pull_request_reviews record {
    string url;
    boolean dismiss_stale_reviews?;
    boolean require_code_owner_reviews?;
    int required_approving_review_count?;
    # Whether the most recent push must be approved by someone other than the person who pushed it.
    boolean require_last_push_approval = false;
    Protectedbranch_required_pull_request_reviews_dismissal_restrictions dismissal_restrictions?;
    Protectedbranch_required_pull_request_reviews_bypass_pull_request_allowances bypass_pull_request_allowances?;
};

# An object describing a submodule
public type ContentSubmodule record {
    "submodule" 'type;
    string submodule_git_url;
    int size;
    string name;
    string path;
    string sha;
    string url;
    string? git_url;
    string? html_url;
    string? download_url;
    Contenttree__links _links;
};

public type Authors_author_id_body record {|
    # The new Git author email.
    string email?;
    # The new Git author name.
    string name?;
|};

# Require all commits be made to a non-target branch and submitted via a pull request before they can be merged.
public type RepositoryRulePullRequest record {
    "pull_request" 'type;
    Repositoryrulepullrequest_parameters parameters?;
};

public type Personalaccesstokenrequests_pat_request_id_body record {
    # Action to apply to the request.
    "approve"|"deny" action;
    # Reason for approving or denying the request. Max 1024 characters.
    string? reason?;
};

# The status of a deployment.
public type DeploymentStatus record {
    string url;
    int id;
    string node_id;
    # The state of the status.
    "error"|"failure"|"inactive"|"pending"|"success"|"queued"|"in_progress" state;
    # A GitHub user.
    NullableSimpleUser? creator;
    # A short description of the status.
    @constraint:String {maxLength: 140}
    string description;
    # The environment of the deployment that the status is for.
    string environment = "";
    # Deprecated: the URL to associate with this status.
    string target_url;
    string created_at;
    string updated_at;
    string deployment_url;
    string repository_url;
    # The URL for accessing your environment.
    string environment_url = "";
    # The URL to associate with this status.
    string log_url = "";
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app?;
};

# Secrets for GitHub Actions for an organization.
public type OrganizationActionsSecret record {
    # The name of the secret.
    string name;
    string created_at;
    string updated_at;
    # Visibility of a secret
    "all"|"private"|"selected" visibility;
    string selected_repositories_url?;
};

# A description of the detector used.
public type Snapshot_detector record {|
    # The name of the detector used.
    string name;
    # The version of the detector used.
    string version;
    # The url of the detector used.
    string url;
|};

# Timeline Committed Event
public type TimelineCommittedEvent record {
    string event?;
    # SHA for the commit
    string sha;
    string node_id;
    string url;
    # Identifying information for the git-user
    Gitcommit_author author;
    # Identifying information for the git-user
    Gitcommit_author committer;
    # Message describing the purpose of the commit
    string message;
    Gitcommit_tree tree;
    Gitcommit_parents[] parents;
    Gitcommit_verification verification;
    string html_url;
};

# The GUID of the tool used to generate the code scanning analysis, if provided in the uploaded SARIF data.
public type CodeScanningAnalysisToolGuid string?;

public type Projects_project_id_body record {
    # The permission to grant to the team for this project. Default: the team's `permission` attribute will be used to determine what permission to grant the team on this project. Note that, if you choose not to pass any parameters, you'll need to set `Content-Length` to zero when calling this endpoint. For more information, see "[HTTP verbs](https://docs.github.com/rest/overview/resources-in-the-rest-api#http-verbs)."
    "read"|"write"|"admin" permission?;
};

public type Repositoryadvisory_credits record {
    # The username of the user credited.
    string login?;
    # The type of credit the user is receiving.
    SecurityAdvisoryCreditTypes 'type?;
};

# Secrets for GitHub Dependabot for an organization.
public type OrganizationDependabotSecretResponse record {
    int total_count;
    OrganizationDependabotSecret[] secrets;
};

# Generated name and body describing a release
public type ReleaseNotesContent record {
    # The generated name of the release
    string name;
    # The generated body describing the contents of the release supporting markdown formatting
    string body;
};

public type Inline_response_200 ContentDirectory|ContentFile|ContentSymlink|ContentSubmodule;

# **Required when the state is dismissed.** The reason for dismissing or closing the alert.
public type CodeScanningAlertDismissedReason "false positive"|"won't fix"|"used in tests";

public type Pagebuild_error record {
    string? message;
};

# Permission check result for a given devcontainer config.
public type CodespacesPermissionsCheckForDevcontainer record {
    # Whether the user has accepted the permissions defined by the devcontainer config
    boolean accepted;
};

# Pages Health Check Status
public type PagesHealthCheck record {
    Pageshealthcheck_domain domain?;
    Pageshealthcheck_alt_domain? alt_domain?;
};

# A GitHub Classroom assignment
public type SimpleClassroomAssignment record {
    # Unique identifier of the repository.
    int id;
    # Whether an accepted assignment creates a public repository.
    boolean public_repo;
    # Assignment title.
    string title;
    # Whether it's a Group Assignment or Individual Assignment.
    "individual"|"group" 'type;
    # The link that a student can use to accept the assignment.
    string invite_link;
    # Whether the invitation link is enabled. Visiting an enabled invitation link will accept the assignment.
    boolean invitations_enabled;
    # Sluggified name of the assignment.
    string slug;
    # Whether students are admins on created repository on accepted assignment.
    boolean students_are_repo_admins;
    # Whether feedback pull request will be created on assignment acceptance.
    boolean feedback_pull_requests_enabled;
    # The maximum allowable teams for the assignment.
    int? max_teams?;
    # The maximum allowable members per team.
    int? max_members?;
    # The selected editor for the assignment.
    string editor;
    # The number of students that have accepted the assignment.
    int accepted;
    # The number of students that have submitted the assignment.
    int submitted;
    # The number of students that have passed the assignment.
    int passing;
    # The programming language used in the assignment.
    string language;
    # The time at which the assignment is due.
    string? deadline;
    # A GitHub Classroom classroom
    SimpleClassroom classroom;
};

public type Runner_id_labels_body_1 record {
    # The names of the custom labels to add to the runner.
    @constraint:Array {maxLength: 100, minLength: 1}
    string[] labels;
};

# Check Annotation
public type CheckAnnotation record {
    string path;
    int start_line;
    int end_line;
    int? start_column;
    int? end_column;
    string? annotation_level;
    string? title;
    string? message;
    string? raw_details;
    string blob_href;
};

# A team discussion is a persistent record of a free-form conversation within a team.
public type TeamDiscussion record {
    # A GitHub user.
    NullableSimpleUser? author;
    # The main text of the discussion.
    string body;
    string body_html;
    # The current version of the body content. If provided, this update operation will be rejected if the given version does not match the latest version on the server.
    string body_version;
    int comments_count;
    string comments_url;
    string created_at;
    string? last_edited_at;
    string html_url;
    string node_id;
    # The unique sequence number of a team discussion.
    int number;
    # Whether or not this discussion should be pinned for easy retrieval.
    boolean pinned;
    # Whether or not this discussion should be restricted to team members and organization administrators.
    boolean 'private;
    string team_url;
    # The title of the discussion.
    string title;
    string updated_at;
    string url;
    ReactionRollup reactions?;
};

public type Dependencygraphspdxsbom_sbom_packages record {
    # A unique SPDX identifier for the package.
    string SPDXID?;
    # The name of the package.
    string name?;
    # The version of the package. If the package does not have an exact version specified,
    # a version range is given.
    string versionInfo?;
    # The location where the package can be downloaded,
    # or NOASSERTION if this has not been determined.
    string downloadLocation?;
    # Whether the package's file content has been subjected to
    # analysis during the creation of the SPDX document.
    boolean filesAnalyzed?;
    # The license of the package as determined while creating the SPDX document.
    string licenseConcluded?;
    # The license of the package as declared by its author, or NOASSERTION if this information
    # was not available when the SPDX document was created.
    string licenseDeclared?;
    # The distribution source of this package, or NOASSERTION if this was not determined.
    string supplier?;
    Dependencygraphspdxsbom_sbom_externalRefs[] externalRefs?;
};

# Information about a Copilot for Business seat assignment for a user, team, or organization.
public type CopilotSeatDetails record {|
    # The assignee that has been granted access to GitHub Copilot.
    SimpleUser|Team|Organization assignee;
    # The team that granted access to GitHub Copilot to the assignee. This will be null if the user was assigned a seat individually.
    Team? assigning_team?;
    # The pending cancellation date for the seat, in `YYYY-MM-DD` format. This will be null unless the assignee's Copilot access has been canceled during the current billing cycle. If the seat has been cancelled, this corresponds to the start of the organization's next billing cycle.
    string? pending_cancellation_date?;
    # Timestamp of user's last GitHub Copilot activity, in ISO 8601 format.
    string? last_activity_at?;
    # Last editor that was used by the user for a GitHub Copilot completion.
    string? last_activity_editor?;
    # Timestamp of when the assignee was last granted access to GitHub Copilot, in ISO 8601 format.
    string created_at;
    # Timestamp of when the assignee's GitHub Copilot access was last updated, in ISO 8601 format.
    string updated_at?;
|};

public type Minimalrepository_license record {
    string 'key?;
    string name?;
    string spdx_id?;
    string? url?;
    string node_id?;
};

public type Checkrun_output record {
    string? title;
    string? summary;
    string? text;
    int annotations_count;
    string annotations_url;
};

public type Comments_comment_number_body record {
    # The discussion comment's body text.
    string body;
};

public type Gittag_object record {
    string sha;
    string 'type;
    string url;
};

public type Gist_id_comments_body record {
    # The comment text.
    @constraint:String {maxLength: 65535}
    string body;
};

# Metadata for a Git tag
public type GitTag record {
    string node_id;
    # Name of the tag
    string tag;
    string sha;
    # URL for the tag
    string url;
    # Message describing the purpose of the tag
    string message;
    Gittag_tagger tagger;
    Gittag_object 'object;
    Verification verification?;
};

public type User_projects_body record {
    # Name of the project
    string name;
    # Body of the project
    string? body?;
};

# Grade for a student or groups GitHub Classroom assignment
public type ClassroomAssignmentGrade record {
    # Name of the assignment
    string assignment_name;
    # URL of the assignment
    string assignment_url;
    # URL of the starter code for the assignment
    string starter_code_url;
    # GitHub username of the student
    string github_username;
    # Roster identifier of the student
    string roster_identifier;
    # Name of the student's assignment repository
    string student_repository_name;
    # URL of the student's assignment repository
    string student_repository_url;
    # Timestamp of the student's assignment submission
    string submission_timestamp;
    # Number of points awarded to the student
    int points_awarded;
    # Number of points available for the assignment
    int points_available;
    # If a group assignment, name of the group the student is in
    string group_name?;
};

public type Securityandanalysis_advanced_security record {
    "enabled"|"disabled" status?;
};

# A suite of checks performed on the code of a given code change
public type CheckSuite record {
    int id;
    string node_id;
    string? head_branch;
    # The SHA of the head commit that is being checked.
    string head_sha;
    "queued"|"in_progress"|"completed" status;
    "success"|"failure"|"neutral"|"cancelled"|"skipped"|"timed_out"|"action_required"|"startup_failure"|"stale"? conclusion;
    string? url;
    string? before;
    string? after;
    PullRequestMinimal[]? pull_requests;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? app;
    # Minimal Repository
    MinimalRepository repository;
    string? created_at;
    string? updated_at;
    # A commit.
    SimpleCommit head_commit;
    int latest_check_runs_count;
    string check_runs_url;
    boolean rerequestable?;
    boolean runs_rerequestable?;
};

public type Gistsgist_id_files record {
    # The new content of the file.
    string content?;
    # The new filename for the file.
    string? filename?;
};

# Details for the GitHub Security Advisory.
public type DependabotAlertSecurityAdvisory record {|
    # The unique GitHub Security Advisory ID assigned to the advisory.
    string ghsa_id;
    # The unique CVE ID assigned to the advisory.
    string? cve_id;
    # A short, plain text summary of the advisory.
    @constraint:String {maxLength: 1024}
    string summary;
    # A long-form Markdown-supported description of the advisory.
    string description;
    # Vulnerable version range information for the advisory.
    DependabotAlertSecurityVulnerability[] vulnerabilities;
    # The severity of the advisory.
    "low"|"medium"|"high"|"critical" severity;
    # Details for the advisory pertaining to the Common Vulnerability Scoring System.
    Dependabotalertsecurityadvisory_cvss cvss;
    # Details for the advisory pertaining to Common Weakness Enumeration.
    Dependabotalertsecurityadvisory_cwes[] cwes;
    # Values that identify this advisory among security information sources.
    Dependabotalertsecurityadvisory_identifiers[] identifiers;
    # Links to additional advisory information.
    Dependabotalertsecurityadvisory_references[] references;
    # The time that the advisory was published in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    string published_at;
    # The time that the advisory was last modified in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    string updated_at;
    # The time that the advisory was withdrawn in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    string? withdrawn_at;
|};

# Details of a deployment environment
public type EnvironmentResponse record {
    # The number of environments in this repository
    int total_count?;
    Environment[] environments?;
};

public type Rulesuites_inner record {
    # The unique identifier of the rule insight.
    int id?;
    # The number that identifies the user.
    int actor_id?;
    # The handle for the GitHub user account.
    string actor_name?;
    # The first commit sha before the push evaluation.
    string before_sha?;
    # The last commit sha in the push evaluation.
    string after_sha?;
    # The ref name that the evaluation ran on.
    string ref?;
    # The ID of the repository associated with the rule evaluation.
    int repository_id?;
    # The name of the repository without the `.git` extension.
    string repository_name?;
    string pushed_at?;
    # The result of the rule evaluations for rules with the `active` enforcement status.
    "pass"|"fail"|"bypass" result?;
    # The result of the rule evaluations for rules with the `active` and `evaluate` enforcement statuses, demonstrating whether rules would pass or fail if all rules in the rule suite were `active`.
    "pass"|"fail" evaluation_result?;
};

public type Issue_number_lock_body record {
    # The reason for locking the issue or pull request conversation. Lock will fail if you don't use one of these reasons:  
    #  * `off-topic`  
    #  * `too heated`  
    #  * `resolved`  
    #  * `spam`
    "off-topic"|"too heated"|"resolved"|"spam" lock_reason?;
};

# The total number of seat assignments cancelled.
public type CopilotSeatCancelled record {
    int seats_cancelled;
};

# Referrer Traffic
public type ReferrerTraffic record {
    string referrer;
    int count;
    int uniques;
};

# A GitHub user.
public type SimpleUser record {
    string? name?;
    string? email?;
    string login;
    int id;
    string node_id;
    string avatar_url;
    string? gravatar_id;
    string url;
    string html_url;
    string followers_url;
    string following_url;
    string gists_url;
    string starred_url;
    string subscriptions_url;
    string organizations_url;
    string repos_url;
    string events_url;
    string received_events_url;
    string 'type;
    boolean site_admin;
    string starred_at?;
};

public type Discussions_discussion_number_body record {
    # The discussion post's title.
    string title?;
    # The discussion post's body text.
    string body?;
};

public type Inline_response_422 ValidationError|ValidationErrorSimple;

public type Statuses_sha_body record {
    # The state of the status.
    "error"|"failure"|"pending"|"success" state;
    # The target URL to associate with this status. This URL will be linked from the GitHub UI to allow users to easily see the source of the status.  
    # For example, if your continuous integration system is posting build status, you would want to provide the deep link for the build output for this specific SHA:  
    # `http://ci.example.com/user/repo/build/sha`
    string? target_url?;
    # A short description of the status.
    string? description?;
    # A string label to differentiate this status from the status of other systems. This field is case-insensitive.
    string context = "default";
};

public type WebhookConfigInsecureSsl string|decimal;

# Pull Request Merge Result
public type PullRequestMergeResult record {
    string sha;
    boolean merged;
    string message;
};

# The time that the alert was auto-dismissed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
public type AlertAutoDismissedAt string?;

# Label Search Result Item
public type LabelSearchResultItemResponse record {
    int total_count;
    boolean incomplete_results;
    LabelSearchResultItem[] items;
};

public type Dependencygraphspdxsbom_sbom_creationInfo record {
    # The date and time the SPDX document was created.
    string created;
    # The tools that were used to generate the SPDX document.
    string[] creators;
};

# GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
public type Integration record {
    # Unique identifier of the GitHub app
    int id;
    # The slug name of the GitHub app
    string slug?;
    string node_id;
    # A GitHub user.
    NullableSimpleUser? owner;
    # The name of the GitHub app
    string name;
    string? description;
    string external_url;
    string html_url;
    string created_at;
    string updated_at;
    # The set of permissions for the GitHub app
    Integration_permissions permissions;
    # The list of events for the GitHub app
    string[] events;
    # The number of installations associated with the GitHub app
    int installations_count?;
    string client_id?;
    string client_secret?;
    string? webhook_secret?;
    string pem?;
};

# A description of the machine powering a codespace.
public type CodespaceMachine record {
    # The name of the machine.
    string name;
    # The display name of the machine includes cores, memory, and storage.
    string display_name;
    # The operating system of the machine.
    string operating_system;
    # How much storage is available to the codespace.
    int storage_in_bytes;
    # How much memory is available to the codespace.
    int memory_in_bytes;
    # How many cores are available to the codespace.
    int cpus;
    # Whether a prebuild is currently available when creating a codespace for this machine and repository. If a branch was not specified as a ref, the default branch will be assumed. Value will be "null" if prebuilds are not supported or prebuild availability could not be determined. Value will be "none" if no prebuild is available. Latest values "ready" and "in_progress" indicate the prebuild availability status.
    "none"|"ready"|"in_progress" prebuild_availability;
};

public type Contenttree_entries record {
    string 'type;
    int size;
    string name;
    string path;
    string content?;
    string sha;
    string url;
    string? git_url;
    string? html_url;
    string? download_url;
    Contenttree__links _links;
};

# Choose which status checks must pass before branches can be merged into a branch that matches this rule. When enabled, commits must first be pushed to another branch, then merged or pushed directly to a ref that matches this rule after status checks have passed.
public type RepositoryRuleRequiredStatusChecks record {
    "required_status_checks" 'type;
    Repositoryrulerequiredstatuschecks_parameters parameters?;
};

public type Hookdelivery_response record {
    # The response headers received when the delivery was made.
    record {}? headers;
    # The response payload received.
    record {}? payload;
};

public type Repository_template_repository_permissions record {
    boolean admin?;
    boolean maintain?;
    boolean push?;
    boolean triage?;
    boolean pull?;
};

public type Refs_ref_body record {
    # The SHA1 value to set this reference to
    string sha;
    # Indicates whether to force the update or to make sure the update is a fast-forward update. Leaving this out or setting it to `false` will make sure you're not overwriting work.
    boolean force = false;
};

public type Filecommit_commit_verification record {
    boolean verified?;
    string reason?;
    string? signature?;
    string? payload?;
};

public type NullableScopedInstallation record {
    # The permissions granted to the user access token.
    AppPermissions permissions;
    # Describe whether all repositories have been selected or there's a selection involved
    "all"|"selected" repository_selection;
    string? single_file_name;
    boolean has_multiple_single_files?;
    string[] single_file_paths?;
    string repositories_url;
    # A GitHub user.
    SimpleUser account;
};

# object containing information about the committer.
public type Reposownerrepocontentspath_committer_1 record {
    # The name of the author (or committer) of the commit
    string name?;
    # The email of the author (or committer) of the commit
    string email?;
};

public type ActionsVariable record {
    # The name of the variable.
    string name;
    # The value of the variable.
    string value;
    # The date and time at which the variable was created, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ.
    string created_at;
    # The date and time at which the variable was last updated, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ.
    string updated_at;
};

public type Repositoryruleset__links_self record {
    # The URL of the ruleset
    string href?;
};

# Commit
public type Commit record {
    string url;
    string sha;
    string node_id;
    string html_url;
    string comments_url;
    Commit_commit 'commit;
    # A GitHub user.
    NullableSimpleUser? author;
    # A GitHub user.
    NullableSimpleUser? committer;
    Commit_parents[] parents;
    Commit_stats stats?;
    DiffEntry[] files?;
};

# Details pertaining to one vulnerable version range for the advisory.
public type DependabotAlertSecurityVulnerability record {|
    # Details for the vulnerable package.
    DependabotAlertPackage package;
    # The severity of the vulnerability.
    "low"|"medium"|"high"|"critical" severity;
    # Conditions that identify vulnerable versions of this vulnerability's package.
    string vulnerable_version_range;
    # Details pertaining to the package version that patches this vulnerability.
    Dependabotalertsecurityvulnerability_first_patched_version? first_patched_version;
|};

# Parameters for a repository ruleset ref name condition
public type RepositoryRulesetConditions record {
    Repositoryrulesetconditions_ref_name ref_name?;
};

# You can use `run_url` to track the status of the run. This includes a property status and conclusion.
# You should not rely on this always being an actions workflow run object.
public type CodeScanningDefaultSetupUpdateResponse record {
    # ID of the corresponding run.
    int run_id?;
    # URL of the corresponding run.
    string run_url?;
};

# Timeline Commit Commented Event
public type TimelineCommitCommentedEvent record {
    string event?;
    string node_id?;
    string commit_id?;
    CommitComment[] comments?;
};

# The source branch and directory used to publish your Pages site.
public type Repo_pages_body_1 anydata|anydata?;

# A Dependabot alert.
public type DependabotAlert record {|
    # The security alert number.
    AlertNumber number;
    # The state of the Dependabot alert.
    "auto_dismissed"|"dismissed"|"fixed"|"open" state;
    # Details for the vulnerable dependency.
    Dependabotalertwithrepository_dependency dependency;
    # Details for the GitHub Security Advisory.
    DependabotAlertSecurityAdvisory security_advisory;
    # Details pertaining to one vulnerable version range for the advisory.
    DependabotAlertSecurityVulnerability security_vulnerability;
    # The REST API URL of the alert resource.
    AlertUrl url;
    # The GitHub URL of the alert resource.
    AlertHtmlUrl html_url;
    # The time that the alert was created in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertCreatedAt created_at;
    # The time that the alert was last updated in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertUpdatedAt updated_at;
    # The time that the alert was dismissed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertDismissedAt? dismissed_at;
    # A GitHub user.
    NullableSimpleUser? dismissed_by;
    # The reason that the alert was dismissed.
    "fix_started"|"inaccurate"|"no_bandwidth"|"not_used"|"tolerable_risk" dismissed_reason;
    # An optional comment associated with the alert's dismissal.
    string? dismissed_comment;
    # The time that the alert was no longer detected and was considered fixed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertFixedAt? fixed_at;
    # The time that the alert was auto-dismissed in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
    AlertAutoDismissedAt? auto_dismissed_at?;
|};

# Team Organization
public type TeamOrganization record {
    string login;
    int id;
    string node_id;
    string url;
    string repos_url;
    string events_url;
    string hooks_url;
    string issues_url;
    string members_url;
    string public_members_url;
    string avatar_url;
    string? description;
    string name?;
    string company?;
    string blog?;
    string location?;
    string email?;
    string? twitter_username?;
    boolean is_verified?;
    boolean has_organization_projects;
    boolean has_repository_projects;
    int public_repos;
    int public_gists;
    int followers;
    int following;
    string html_url;
    string created_at;
    string 'type;
    int total_private_repos?;
    int owned_private_repos?;
    int? private_gists?;
    int? disk_usage?;
    int? collaborators?;
    string? billing_email?;
    Organizationfull_plan plan?;
    string? default_repository_permission?;
    boolean? members_can_create_repositories?;
    boolean? two_factor_requirement_enabled?;
    string members_allowed_repository_creation_type?;
    boolean members_can_create_public_repositories?;
    boolean members_can_create_private_repositories?;
    boolean members_can_create_internal_repositories?;
    boolean members_can_create_pages?;
    boolean members_can_create_public_pages?;
    boolean members_can_create_private_pages?;
    boolean? members_can_fork_private_repositories?;
    boolean web_commit_signoff_required?;
    string updated_at;
    string? archived_at;
};

public type Gists_body record {
    # Description of the gist
    string description?;
    # Names and content for the files that make up the gist
    record {|Gists_files...;|} files;
    boolean|"true"|"false" 'public?;
};

public type Repo_import_body_1 record {
    # The username to provide to the originating repository.
    string vcs_username?;
    # The password to provide to the originating repository.
    string vcs_password?;
    # The type of version control system you are migrating from.
    "subversion"|"tfvc"|"git"|"mercurial" vcs?;
    # For a tfvc import, the name of the project that is being imported.
    string tfvc_project?;
};

# An item belonging to a project
public type ProjectsV2Item record {
    decimal id;
    string node_id?;
    string project_node_id?;
    string content_node_id;
    # The type of content tracked in a project item
    ProjectsV2ItemContentType content_type;
    # A GitHub user.
    SimpleUser creator?;
    string created_at;
    string updated_at;
    string? archived_at;
};

# Activity
public type Activity record {
    int id;
    string node_id;
    # The SHA of the commit before the activity.
    string before;
    # The SHA of the commit after the activity.
    string after;
    # The full Git reference, formatted as `refs/heads/<branch name>`.
    string ref;
    # The time when the activity occurred.
    string timestamp;
    # The type of the activity that was performed.
    "push"|"force_push"|"branch_deletion"|"branch_creation"|"pr_merge"|"merge_queue_merge" activity_type;
    # A GitHub user.
    NullableSimpleUser? actor;
};

public type Org_hooks_body record {
    # Must be passed as "web".
    string name;
    # Key/value pairs to provide settings for this webhook.
    Orgsorghooks_config config;
    # Determines what [events](https://docs.github.com/webhooks/event-payloads) the hook is triggered for. Set to `["*"]` to receive all possible events.
    string[] events = ["push"];
    # Determines if notifications are sent when the webhook is triggered. Set to `true` to send notifications.
    boolean active = true;
};

public type Discussions_discussion_number_body_1 record {
    # The discussion post's title.
    string title?;
    # The discussion post's body text.
    string body?;
};

# Issue Event
public type IssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    NullableSimpleUser? actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # Issues are a great way to keep track of tasks, enhancements, and bugs for your projects.
    NullableIssue? issue?;
    # Issue Event Label
    IssueEventLabel label?;
    # A GitHub user.
    NullableSimpleUser? assignee?;
    # A GitHub user.
    NullableSimpleUser? assigner?;
    # A GitHub user.
    NullableSimpleUser? review_requester?;
    # A GitHub user.
    NullableSimpleUser? requested_reviewer?;
    # Groups of organization members that gives permissions on specified repositories.
    Team requested_team?;
    IssueEventDismissedReview dismissed_review?;
    # Issue Event Milestone
    IssueEventMilestone milestone?;
    # Issue Event Project Card
    IssueEventProjectCard project_card?;
    # Issue Event Rename
    IssueEventRename rename?;
    # How the author is associated with the repository.
    AuthorAssociation author_association?;
    string? lock_reason?;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app?;
};

public type Protectedbranch_enforce_admins record {|
    string url;
    boolean enabled;
|};

# Timeline Comment Event
public type TimelineCommentEvent record {
    string event;
    # A GitHub user.
    SimpleUser actor;
    # Unique identifier of the issue comment
    int id;
    string node_id;
    # URL for the issue comment
    string url;
    # Contents of the issue comment
    string body?;
    string body_text?;
    string body_html?;
    string html_url;
    # A GitHub user.
    SimpleUser user;
    string created_at;
    string updated_at;
    string issue_url;
    # How the author is associated with the repository.
    AuthorAssociation author_association;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app?;
    ReactionRollup reactions?;
};

# Timeline Line Commented Event
public type TimelineLineCommentedEvent record {
    string event?;
    string node_id?;
    PullRequestReviewComment[] comments?;
};

# A GitHub Security Advisory.
public type GlobalAdvisory record {|
    # The GitHub Security Advisory ID.
    string ghsa_id;
    # The Common Vulnerabilities and Exposures (CVE) ID.
    string? cve_id;
    # The API URL for the advisory.
    string url;
    # The URL for the advisory.
    string html_url;
    # The API URL for the repository advisory.
    string? repository_advisory_url;
    # A short summary of the advisory.
    @constraint:String {maxLength: 1024}
    string summary;
    # A detailed description of what the advisory entails.
    string? description;
    # The type of advisory.
    "reviewed"|"unreviewed"|"malware" 'type;
    # The severity of the advisory.
    "critical"|"high"|"medium"|"low"|"unknown" severity;
    # The URL of the advisory's source code.
    string? source_code_location;
    Globaladvisory_identifiers[]? identifiers;
    string[]? references;
    # The date and time of when the advisory was published, in ISO 8601 format.
    string published_at;
    # The date and time of when the advisory was last updated, in ISO 8601 format.
    string updated_at;
    # The date and time of when the advisory was reviewed by GitHub, in ISO 8601 format.
    string? github_reviewed_at;
    # The date and time when the advisory was published in the National Vulnerability Database, in ISO 8601 format.
    # This field is only populated when the advisory is imported from the National Vulnerability Database.
    string? nvd_published_at;
    # The date and time of when the advisory was withdrawn, in ISO 8601 format.
    string? withdrawn_at;
    # The products and respective version ranges affected by the advisory.
    Globaladvisory_vulnerabilities[]? vulnerabilities;
    Globaladvisory_cvss? cvss;
    Globaladvisory_cwes[]? cwes;
    # The users who contributed to the advisory.
    Globaladvisory_credits[]? credits;
|};

public type Contents_path_body record {
    # The commit message.
    string message;
    # The new file content, using Base64 encoding.
    string content;
    # **Required if you are updating a file**. The blob SHA of the file being replaced.
    string sha?;
    # The branch name. Default: the repository’s default branch.
    string branch?;
    # The person that committed the file. Default: the authenticated user.
    Reposownerrepocontentspath_committer committer?;
    # The author of the file. Default: The `committer` or the authenticated user if you omit `committer`.
    Reposownerrepocontentspath_author author?;
};

public type Reposownerrepobranchesbranchprotection_required_status_checks_checks record {
    # The name of the required check
    string context;
    # The ID of the GitHub App that must provide this check. Omit this field to automatically select the GitHub App that has recently provided this check, or any app if it was not set by a GitHub App. Pass -1 to explicitly allow any app to set the status.
    int app_id?;
};

public type Branchwithprotection__links record {
    string html;
    string self;
};

# The GitHub URL of the alert resource.
public type AlertHtmlUrl string;

# Workflow Usage
public type WorkflowUsage record {
    Workflowusage_billable billable;
};

public type Reviewcomment__links record {
    # Hypermedia Link
    Link self;
    # Hypermedia Link
    Link html;
    # Hypermedia Link
    Link pull_request;
};

public type Checksuitepreference_preferences_auto_trigger_checks record {
    int app_id;
    boolean setting;
};

# A GitHub Actions workflow
public type Workflow record {
    int id;
    string node_id;
    string name;
    string path;
    "active"|"deleted"|"disabled_fork"|"disabled_inactivity"|"disabled_manually" state;
    string created_at;
    string updated_at;
    string url;
    string html_url;
    string badge_url;
    string deleted_at?;
};

public type Codespaces_access_body record {
    # Which users can access codespaces in the organization. `disabled` means that no users can access codespaces in the organization.
    "disabled"|"selected_members"|"all_members"|"all_members_and_outside_collaborators" visibility;
    # The usernames of the organization members who should have access to codespaces in the organization. Required when `visibility` is `selected_members`. The provided list of usernames will replace any existing value.
    @constraint:Array {maxLength: 100}
    string[] selected_usernames?;
};

# The repository on GitHub where the event occurred. Webhook payloads contain the `repository` property
# when the event occurs from activity in a repository.
public type RepositoryWebhooks record {
    # Unique identifier of the repository
    int id;
    string node_id;
    # The name of the repository.
    string name;
    string full_name;
    # License Simple
    NullableLicenseSimple? license;
    # A GitHub user.
    NullableSimpleUser? organization?;
    int forks;
    Repository_permissions permissions?;
    # A GitHub user.
    SimpleUser owner;
    # Whether the repository is private or public.
    boolean 'private;
    string html_url;
    string? description;
    boolean 'fork;
    string url;
    string archive_url;
    string assignees_url;
    string blobs_url;
    string branches_url;
    string collaborators_url;
    string comments_url;
    string commits_url;
    string compare_url;
    string contents_url;
    string contributors_url;
    string deployments_url;
    string downloads_url;
    string events_url;
    string forks_url;
    string git_commits_url;
    string git_refs_url;
    string git_tags_url;
    string git_url;
    string issue_comment_url;
    string issue_events_url;
    string issues_url;
    string keys_url;
    string labels_url;
    string languages_url;
    string merges_url;
    string milestones_url;
    string notifications_url;
    string pulls_url;
    string releases_url;
    string ssh_url;
    string stargazers_url;
    string statuses_url;
    string subscribers_url;
    string subscription_url;
    string tags_url;
    string teams_url;
    string trees_url;
    string clone_url;
    string? mirror_url;
    string hooks_url;
    string svn_url;
    string? homepage;
    string? language;
    int forks_count;
    int stargazers_count;
    int watchers_count;
    # The size of the repository. Size is calculated hourly. When a repository is initially created, the size is 0.
    int size;
    # The default branch of the repository.
    string default_branch;
    int open_issues_count;
    # Whether this repository acts as a template that can be used to generate new repositories.
    boolean is_template = false;
    string[] topics?;
    # Whether issues are enabled.
    boolean has_issues;
    # Whether projects are enabled.
    boolean has_projects;
    # Whether the wiki is enabled.
    boolean has_wiki;
    boolean has_pages;
    # Whether downloads are enabled.
    boolean has_downloads;
    # Whether discussions are enabled.
    boolean has_discussions = false;
    # Whether the repository is archived.
    boolean archived;
    # Returns whether or not this repository disabled.
    boolean disabled;
    # The repository visibility: public, private, or internal.
    string visibility = "public";
    string? pushed_at;
    string? created_at;
    string? updated_at;
    # Whether to allow rebase merges for pull requests.
    boolean allow_rebase_merge = true;
    Repository_template_repository? template_repository?;
    string temp_clone_token?;
    # Whether to allow squash merges for pull requests.
    boolean allow_squash_merge = true;
    # Whether to allow Auto-merge to be used on pull requests.
    boolean allow_auto_merge = false;
    # Whether to delete head branches when pull requests are merged
    boolean delete_branch_on_merge = false;
    # Whether or not a pull request head branch that is behind its base branch can always be updated even if it is not required to be up to date before merging.
    boolean allow_update_branch = false;
    # Whether a squash merge commit can use the pull request title as default. **This property has been deprecated. Please use `squash_merge_commit_title` instead.
    boolean use_squash_pr_title_as_default = false;
    # The default value for a squash merge commit title:
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `COMMIT_OR_PR_TITLE` - default to the commit's title (if only one commit) or the pull request's title (when more than one commit).
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squash_merge_commit_title?;
    # The default value for a squash merge commit message:
    # 
    # - `PR_BODY` - default to the pull request's body.
    # - `COMMIT_MESSAGES` - default to the branch's commit messages.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squash_merge_commit_message?;
    # The default value for a merge commit title.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `MERGE_MESSAGE` - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name).
    "PR_TITLE"|"MERGE_MESSAGE" merge_commit_title?;
    # The default value for a merge commit message.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `PR_BODY` - default to the pull request's body.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"PR_TITLE"|"BLANK" merge_commit_message?;
    # Whether to allow merge commits for pull requests.
    boolean allow_merge_commit = true;
    # Whether to allow forking this repo
    boolean allow_forking?;
    # Whether to require contributors to sign off on web-based commits
    boolean web_commit_signoff_required = false;
    int subscribers_count?;
    int network_count?;
    int open_issues;
    int watchers;
    string master_branch?;
    string starred_at?;
    # Whether anonymous git access is enabled for this repository
    boolean anonymous_access_enabled?;
};

# The SHA of the commit to which the analysis you are uploading relates.
@constraint:String {maxLength: 40, minLength: 40, pattern: re `^[0-9a-fA-F]+$`}
public type CodeScanningAnalysisCommitSha string;

public type Repo_checkruns_body record {"completed" status;}|record {"queued"|"in_progress" status?;};

public type Inline_response_503 record {
    string code?;
    string message?;
    string documentation_url?;
};

# Organization Full
public type OrganizationFull record {
    string login;
    int id;
    string node_id;
    string url;
    string repos_url;
    string events_url;
    string hooks_url;
    string issues_url;
    string members_url;
    string public_members_url;
    string avatar_url;
    string? description;
    string name?;
    string? company?;
    string blog?;
    string location?;
    string? email?;
    string? twitter_username?;
    boolean is_verified?;
    boolean has_organization_projects;
    boolean has_repository_projects;
    int public_repos;
    int public_gists;
    int followers;
    int following;
    string html_url;
    string 'type;
    int total_private_repos?;
    int owned_private_repos?;
    int? private_gists?;
    int? disk_usage?;
    int? collaborators?;
    string? billing_email?;
    Organizationfull_plan plan?;
    string? default_repository_permission?;
    boolean? members_can_create_repositories?;
    boolean? two_factor_requirement_enabled?;
    string members_allowed_repository_creation_type?;
    boolean members_can_create_public_repositories?;
    boolean members_can_create_private_repositories?;
    boolean members_can_create_internal_repositories?;
    boolean members_can_create_pages?;
    boolean members_can_create_public_pages?;
    boolean members_can_create_private_pages?;
    boolean? members_can_fork_private_repositories?;
    boolean web_commit_signoff_required?;
    # Whether GitHub Advanced Security is enabled for new repositories and repositories transferred to this organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role.
    boolean advanced_security_enabled_for_new_repositories?;
    # Whether GitHub Advanced Security is automatically enabled for new repositories and repositories transferred to
    # this organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role.
    boolean dependabot_alerts_enabled_for_new_repositories?;
    # Whether dependabot security updates are automatically enabled for new repositories and repositories transferred
    # to this organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role.
    boolean dependabot_security_updates_enabled_for_new_repositories?;
    # Whether dependency graph is automatically enabled for new repositories and repositories transferred to this
    # organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role.
    boolean dependency_graph_enabled_for_new_repositories?;
    # Whether secret scanning is automatically enabled for new repositories and repositories transferred to this
    # organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role.
    boolean secret_scanning_enabled_for_new_repositories?;
    # Whether secret scanning push protection is automatically enabled for new repositories and repositories
    # transferred to this organization.
    # 
    # This field is only visible to organization owners or members of a team with the security manager role.
    boolean secret_scanning_push_protection_enabled_for_new_repositories?;
    # Whether a custom link is shown to contributors who are blocked from pushing a secret by push protection.
    boolean secret_scanning_push_protection_custom_link_enabled?;
    # An optional URL string to display to contributors who are blocked from pushing a secret.
    string? secret_scanning_push_protection_custom_link?;
    string created_at;
    string updated_at;
    string? archived_at;
};

public type PagesSourceHash record {
    string branch;
    string path;
};

# Key
public type Key record {
    string 'key;
    int id;
    string url;
    string title;
    string created_at;
    boolean verified;
    boolean read_only;
};

# The type of deployment branch policy for this environment. To allow all branches to deploy, set to `null`.
public type DeploymentBranchPolicySettings record {
    # Whether only branches with branch protection rules can deploy to this environment. If `protected_branches` is `true`, `custom_branch_policies` must be `false`; if `protected_branches` is `false`, `custom_branch_policies` must be `true`.
    boolean protected_branches;
    # Whether only branches that match the specified name patterns can deploy to this environment.  If `custom_branch_policies` is `true`, `protected_branches` must be `false`; if `custom_branch_policies` is `false`, `protected_branches` must be `true`.
    boolean custom_branch_policies;
};

public type Reposownerrepopullspull_numberreviews_comments record {
    # The relative path to the file that necessitates a review comment.
    string path;
    # The position in the diff where you want to add a review comment. Note this value is not the same as the line number in the file. For help finding the position value, read the note below.
    int position?;
    # Text of the review comment.
    string body;
    int line?;
    string side?;
    int start_line?;
    string start_side?;
};

# Only allow users with bypass permission to create matching refs.
public type RepositoryRuleCreation record {
    "creation" 'type;
};

# User-defined metadata to store domain-specific information limited to 8 keys with scalar values.
public type Metadata record {
};

public type Repositoryadvisorycreate_vulnerabilities record {|
    # The name of the package affected by the vulnerability.
    Repositoryadvisorycreate_package package;
    # The range of the package versions affected by the vulnerability.
    string? vulnerable_version_range?;
    # The package version(s) that resolve the vulnerability.
    string? patched_versions?;
    # The functions in the package that are affected.
    string[]? vulnerable_functions?;
|};

# Short Branch
public type ShortBranch record {
    string name;
    Shortbranch_commit 'commit;
    boolean protected;
    # Branch Protection
    BranchProtection protection?;
    string protection_url?;
};

public type Billing_selected_users_body_1 record {
    # The usernames of the organization members for which to revoke access to GitHub Copilot.
    @constraint:Array {minLength: 1}
    string[] selected_usernames;
};

# A list of errors found in a repo's CODEOWNERS file
public type CodeownersErrors record {
    Codeownerserrors_errors[] errors;
};

# Issue Event for Issue
public type IssueEventForIssue LabeledIssueEvent|UnlabeledIssueEvent|AssignedIssueEvent|UnassignedIssueEvent|MilestonedIssueEvent|DemilestonedIssueEvent|RenamedIssueEvent|ReviewRequestedIssueEvent|ReviewRequestRemovedIssueEvent|ReviewDismissedIssueEvent|LockedIssueEvent|AddedToProjectIssueEvent|MovedColumnInProjectIssueEvent|RemovedFromProjectIssueEvent|ConvertedNoteToIssueIssueEvent;

# Configuration object of the webhook
public type WebhookConfig record {
    # The URL to which the payloads will be delivered.
    WebhookConfigUrl url?;
    # The media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`.
    WebhookConfigContentType content_type?;
    # If provided, the `secret` will be used as the `key` to generate the HMAC hex digest value for [delivery signature headers](https://docs.github.com/webhooks/event-payloads/#delivery-headers).
    WebhookConfigSecret secret?;
    WebhookConfigInsecureSsl insecure_ssl?;
};

# State of a code scanning alert.
public type CodeScanningAlertStateQuery "open"|"closed"|"dismissed"|"fixed";

public type Columns_column_id_body record {
    # Name of the project column
    string name;
};

# Require status checks to pass before merging. Set to `null` to disable.
public type Reposownerrepobranchesbranchprotection_required_status_checks record {
    # Require branches to be up to date before merging.
    boolean strict;
    # **Deprecated**: The list of status checks to require in order to merge into this branch. If any of these checks have recently been set by a particular GitHub App, they will be required to come from that app in future for the branch to merge. Use `checks` instead of `contexts` for more fine-grained control.
    string[] contexts;
    # The list of status checks to require in order to merge into this branch.
    Reposownerrepobranchesbranchprotection_required_status_checks_checks[] checks?;
};

public type Pull_number_requested_reviewers_body anydata|anydata;

# Groups of organization members that gives permissions on specified repositories.
public type Team record {
    int id;
    string node_id;
    string name;
    string slug;
    string? description;
    string privacy?;
    string notification_setting?;
    string permission;
    Team_permissions permissions?;
    string url;
    string html_url;
    string members_url;
    string repositories_url;
    # Groups of organization members that gives permissions on specified repositories.
    NullableTeamSimple? parent;
};

public type Pendingdeployment_environment record {
    # The id of the environment.
    int id?;
    string node_id?;
    # The name of the environment.
    string name?;
    string url?;
    string html_url?;
};

# The person that committed the file. Default: the authenticated user.
public type Reposownerrepocontentspath_committer record {
    # The name of the author or committer of the commit. You'll receive a `422` status code if `name` is omitted.
    string name;
    # The email of the author or committer of the commit. You'll receive a `422` status code if `email` is omitted.
    string email;
    string date?;
};

# A GitHub organization.
public type SimpleClassroomOrganization record {
    int id;
    string login;
    string node_id;
    string html_url;
    string? name;
    string avatar_url;
};

# Only allow users with bypass permissions to delete matching refs.
public type RepositoryRuleDeletion record {
    "deletion" 'type;
};

# Porter Author
public type PorterAuthor record {
    int id;
    string remote_id;
    string remote_name;
    string email;
    string name;
    string url;
    string import_url;
};

public type Orgs_org_body record {
    # Billing email address. This address is not publicized.
    string billing_email?;
    # The company name.
    string company?;
    # The publicly visible email address.
    string email?;
    # The Twitter username of the company.
    string twitter_username?;
    # The location.
    string location?;
    # The shorthand name of the company.
    string name?;
    # The description of the company.
    string description?;
    # Whether an organization can use organization projects.
    boolean has_organization_projects?;
    # Whether repositories that belong to the organization can use repository projects.
    boolean has_repository_projects?;
    # Default permission level members have for organization repositories.
    "read"|"write"|"admin"|"none" default_repository_permission?;
    # Whether of non-admin organization members can create repositories. **Note:** A parameter can override this parameter. See `members_allowed_repository_creation_type` in this table for details.
    boolean members_can_create_repositories?;
    # Whether organization members can create internal repositories, which are visible to all enterprise members. You can only allow members to create internal repositories if your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+. For more information, see "[Restricting repository creation in your organization](https://docs.github.com/github/setting-up-and-managing-organizations-and-teams/restricting-repository-creation-in-your-organization)" in the GitHub Help documentation.
    boolean members_can_create_internal_repositories?;
    # Whether organization members can create private repositories, which are visible to organization members with permission. For more information, see "[Restricting repository creation in your organization](https://docs.github.com/github/setting-up-and-managing-organizations-and-teams/restricting-repository-creation-in-your-organization)" in the GitHub Help documentation.
    boolean members_can_create_private_repositories?;
    # Whether organization members can create public repositories, which are visible to anyone. For more information, see "[Restricting repository creation in your organization](https://docs.github.com/github/setting-up-and-managing-organizations-and-teams/restricting-repository-creation-in-your-organization)" in the GitHub Help documentation.
    boolean members_can_create_public_repositories?;
    # Specifies which types of repositories non-admin organization members can create. `private` is only available to repositories that are part of an organization on GitHub Enterprise Cloud. 
    # **Note:** This parameter is deprecated and will be removed in the future. Its return value ignores internal repositories. Using this parameter overrides values set in `members_can_create_repositories`. See the parameter deprecation notice in the operation description for details.
    "all"|"private"|"none" members_allowed_repository_creation_type?;
    # Whether organization members can create GitHub Pages sites. Existing published sites will not be impacted.
    boolean members_can_create_pages?;
    # Whether organization members can create public GitHub Pages sites. Existing published sites will not be impacted.
    boolean members_can_create_public_pages?;
    # Whether organization members can create private GitHub Pages sites. Existing published sites will not be impacted.
    boolean members_can_create_private_pages?;
    # Whether organization members can fork private organization repositories.
    boolean members_can_fork_private_repositories?;
    # Whether contributors to organization repositories are required to sign off on commits they make through GitHub's web interface.
    boolean web_commit_signoff_required?;
    string blog?;
    # Whether GitHub Advanced Security is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a `GET /orgs/{org}` request.
    boolean advanced_security_enabled_for_new_repositories?;
    # Whether Dependabot alerts is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a `GET /orgs/{org}` request.
    boolean dependabot_alerts_enabled_for_new_repositories?;
    # Whether Dependabot security updates is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a `GET /orgs/{org}` request.
    boolean dependabot_security_updates_enabled_for_new_repositories?;
    # Whether dependency graph is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a `GET /orgs/{org}` request.
    boolean dependency_graph_enabled_for_new_repositories?;
    # Whether secret scanning is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a `GET /orgs/{org}` request.
    boolean secret_scanning_enabled_for_new_repositories?;
    # Whether secret scanning push protection is automatically enabled for new repositories.
    # 
    # To use this parameter, you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."
    # 
    # You can check which security and analysis features are currently enabled by using a `GET /orgs/{org}` request.
    boolean secret_scanning_push_protection_enabled_for_new_repositories?;
    # Whether a custom link is shown to contributors who are blocked from pushing a secret by push protection.
    boolean secret_scanning_push_protection_custom_link_enabled?;
    # If `secret_scanning_push_protection_custom_link_enabled` is true, the URL that will be displayed to contributors who are blocked from pushing a secret.
    string secret_scanning_push_protection_custom_link?;
};

# Whether users can pull changes from upstream when the branch is locked. Set to `true` to allow fork syncing. Set to `false` to prevent fork syncing.
public type Branchprotection_allow_fork_syncing record {
    boolean enabled?;
};

# Reactions to conversations provide a way to help people express their feelings more simply and effectively.
public type Reaction record {
    int id;
    string node_id;
    # A GitHub user.
    NullableSimpleUser? user;
    # The reaction to use
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
    string created_at;
};

public type Runner_id_labels_body_3 record {
    # The names of the custom labels to add to the runner.
    @constraint:Array {maxLength: 100, minLength: 1}
    string[] labels;
};

public type Runner_id_labels_body_2 record {
    # The names of the custom labels to set for the runner. You can pass an empty array to remove all custom labels.
    @constraint:Array {maxLength: 100}
    string[] labels;
};

public type Card_id_moves_body record {
    # The position of the card in a column. Can be one of: `top`, `bottom`, or `after:<card_id>` to place after the specified card.
    @constraint:String {pattern: re `^(?:top|bottom|after:\d+)$`}
    string position;
    # The unique identifier of the column the card should be moved to
    int column_id?;
};

# A collection of related issues and pull requests.
public type NullableMilestone record {
    string url;
    string html_url;
    string labels_url;
    int id;
    string node_id;
    # The number of the milestone.
    int number;
    # The state of the milestone.
    "open"|"closed" state;
    # The title of the milestone.
    string title;
    string? description;
    # A GitHub user.
    NullableSimpleUser? creator;
    int open_issues;
    int closed_issues;
    string created_at;
    string updated_at;
    string? closed_at;
    string? due_on;
};

# Pull Request Review Comments are comments on a portion of the Pull Request's diff.
public type PullRequestReviewComment record {
    # URL for the pull request review comment
    string url;
    # The ID of the pull request review to which the comment belongs.
    int? pull_request_review_id;
    # The ID of the pull request review comment.
    int id;
    # The node ID of the pull request review comment.
    string node_id;
    # The diff of the line that the comment refers to.
    string diff_hunk;
    # The relative path of the file to which the comment applies.
    string path;
    # The line index in the diff to which the comment applies. This field is deprecated; use `line` instead.
    int position?;
    # The index of the original line in the diff to which the comment applies. This field is deprecated; use `original_line` instead.
    int original_position?;
    # The SHA of the commit to which the comment applies.
    string commit_id;
    # The SHA of the original commit to which the comment applies.
    string original_commit_id;
    # The comment ID to reply to.
    int in_reply_to_id?;
    # A GitHub user.
    SimpleUser user;
    # The text of the comment.
    string body;
    string created_at;
    string updated_at;
    # HTML URL for the pull request review comment.
    string html_url;
    # URL for the pull request that the review comment belongs to.
    string pull_request_url;
    # How the author is associated with the repository.
    AuthorAssociation author_association;
    Pullrequestreviewcomment__links _links;
    # The first line of the range for a multi-line comment.
    int? start_line?;
    # The first line of the range for a multi-line comment.
    int? original_start_line?;
    # The side of the first line of the range for a multi-line comment.
    "LEFT"|"RIGHT" start_side = "RIGHT";
    # The line of the blob to which the comment applies. The last line of the range for a multi-line comment
    int line?;
    # The line of the blob to which the comment applies. The last line of the range for a multi-line comment
    int original_line?;
    # The side of the diff to which the comment applies. The side of the last line of the range for a multi-line comment
    "LEFT"|"RIGHT" side = "RIGHT";
    # The level at which the comment is targeted, can be a diff line or a file.
    "line"|"file" subject_type?;
    ReactionRollup reactions?;
    string body_html?;
    string body_text?;
};

public type Pulls_pull_number_body record {
    # The title of the pull request.
    string title?;
    # The contents of the pull request.
    string body?;
    # State of this Pull Request. Either `open` or `closed`.
    "open"|"closed" state?;
    # The name of the branch you want your changes pulled into. This should be an existing branch on the current repository. You cannot update the base branch on a pull request to point to another repository.
    string base?;
    # Indicates whether [maintainers can modify](https://docs.github.com/articles/allowing-changes-to-a-pull-request-branch-created-from-a-fork/) the pull request.
    boolean maintainer_can_modify?;
};

# The time that the alert was last updated in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
public type NullableAlertUpdatedAt string?;

public type Runners_generatejitconfig_body_1 record {
    # The name of the new runner.
    string name;
    # The ID of the runner group to register the runner to.
    int runner_group_id;
    # The names of the custom labels to add to the runner. **Minimum items**: 1. **Maximum items**: 100.
    @constraint:Array {maxLength: 100, minLength: 1}
    string[] labels;
    # The working directory to be used for job execution, relative to the runner install directory.
    string work_folder = "_work";
};

# Gist Commit
public type GistCommit record {
    string url;
    string version;
    # A GitHub user.
    NullableSimpleUser? user;
    Gisthistory_change_status change_status;
    string committed_at;
};

# Only allow users with bypass permission to update matching refs.
public type RepositoryRuleUpdate record {
    "update" 'type;
    Repositoryruleupdate_parameters parameters?;
};

# Page Build
public type PageBuild record {
    string url;
    string status;
    Pagebuild_error 'error;
    # A GitHub user.
    NullableSimpleUser? pusher;
    string 'commit;
    int duration;
    string created_at;
    string updated_at;
};

# Event
public type Event record {
    string id;
    string? 'type;
    # Actor
    Actor actor;
    Event_repo repo;
    # Actor
    Actor org?;
    Event_payload payload;
    boolean 'public;
    string? created_at;
};

# An invocation of a workflow
public type WorkflowRunResponse record {
    int total_count;
    WorkflowRun[] workflow_runs;
};

public type Job_id_rerun_body record {
    # Whether to enable debug logging for the re-run.
    boolean enable_debug_logging?;
};

# A repository security advisory.
public type RepositoryAdvisory record {|
    # The GitHub Security Advisory ID.
    string ghsa_id;
    # The Common Vulnerabilities and Exposures (CVE) ID.
    string? cve_id;
    # The API URL for the advisory.
    string url;
    # The URL for the advisory.
    string html_url;
    # A short summary of the advisory.
    @constraint:String {maxLength: 1024}
    string summary;
    # A detailed description of what the advisory entails.
    string? description;
    # The severity of the advisory.
    "critical"|"high"|"medium"|"low" severity;
    # The author of the advisory.
    SimpleUser? author;
    # The publisher of the advisory.
    SimpleUser? publisher;
    Globaladvisory_identifiers[] identifiers;
    # The state of the advisory.
    "published"|"closed"|"withdrawn"|"draft"|"triage" state;
    # The date and time of when the advisory was created, in ISO 8601 format.
    string? created_at;
    # The date and time of when the advisory was last updated, in ISO 8601 format.
    string? updated_at;
    # The date and time of when the advisory was published, in ISO 8601 format.
    string? published_at;
    # The date and time of when the advisory was closed, in ISO 8601 format.
    string? closed_at;
    # The date and time of when the advisory was withdrawn, in ISO 8601 format.
    string? withdrawn_at;
    Repositoryadvisory_submission? submission;
    RepositoryAdvisoryVulnerability[]? vulnerabilities;
    Globaladvisory_cvss? cvss;
    Globaladvisory_cwes[]? cwes;
    # A list of only the CWE IDs.
    string[]? cwe_ids;
    Repositoryadvisory_credits[]? credits;
    RepositoryAdvisoryCredit[]? credits_detailed;
    # A list of users that collaborate on the advisory.
    SimpleUser[]? collaborating_users;
    # A list of teams that collaborate on the advisory.
    Team[]? collaborating_teams;
    # A temporary private fork of the advisory's repository for collaborating on a fix.
    SimpleRepository? private_fork;
|};

public type Pullrequest_head_repo_license record {
    string 'key;
    string name;
    string? url;
    string? spdx_id;
    string node_id;
};

# Organization variable for GitHub Actions.
public type OrganizationActionsVariableResponse record {
    int total_count;
    OrganizationActionsVariable[] variables;
};

# An SSH key granting access to a single repository.
public type DeployKey record {
    int id;
    string 'key;
    string url;
    string title;
    boolean verified;
    string created_at;
    boolean read_only;
    string? added_by?;
    string? last_used?;
};

# Parameters for a repository ID condition
public type RepositoryRulesetConditionsRepositoryIdTarget record {
    Repositoryrulesetconditionsrepositoryidtarget_repository_id repository_id;
};

# Code Frequency Stat
public type CodeFrequencyStat int[];

# The configuration for GitHub Pages for a repository.
public type Page record {
    # The API address for accessing this Page resource.
    string url;
    # The status of the most recent build of the Page.
    "built"|"building"|"errored" status;
    # The Pages site's custom domain
    string? cname;
    # The state if the domain is verified
    "pending"|"verified"|"unverified" protected_domain_state?;
    # The timestamp when a pending domain becomes unverified.
    string? pending_domain_unverified_at?;
    # Whether the Page has a custom 404 page.
    boolean custom_404;
    # The web address the Page can be accessed from.
    string html_url?;
    # The process in which the Page will be built.
    "legacy"|"workflow" build_type?;
    PagesSourceHash 'source?;
    # Whether the GitHub Pages site is publicly visible. If set to `true`, the site is accessible to anyone on the internet. If set to `false`, the site will only be accessible to users who have at least `read` access to the repository that published the site.
    boolean 'public;
    PagesHttpsCertificate https_certificate?;
    # Whether https is enabled on the domain
    boolean https_enforced?;
};

public type JitConfig record {
    # A self hosted runner
    Runner runner;
    # The base64 encoded runner configuration.
    string encoded_jit_config;
};

# Allow specific users, teams, or apps to bypass pull request requirements.
public type Protectedbranchpullrequestreview_bypass_pull_request_allowances record {
    # The list of users allowed to bypass pull request requirements.
    SimpleUser[] users?;
    # The list of teams allowed to bypass pull request requirements.
    Team[] teams?;
    # The list of apps allowed to bypass pull request requirements.
    Integration[] apps?;
};

public type Organization_plan record {
    string name?;
    int space?;
    int private_repos?;
    int filled_seats?;
    int seats?;
};

# Timeline Event
public type TimelineIssueEvents LabeledIssueEvent|UnlabeledIssueEvent|MilestonedIssueEvent|DemilestonedIssueEvent|RenamedIssueEvent|ReviewRequestedIssueEvent|ReviewRequestRemovedIssueEvent|ReviewDismissedIssueEvent|LockedIssueEvent|AddedToProjectIssueEvent|MovedColumnInProjectIssueEvent|RemovedFromProjectIssueEvent|ConvertedNoteToIssueIssueEvent|TimelineCommentEvent|TimelineCrossReferencedEvent|TimelineCommittedEvent|TimelineReviewedEvent|TimelineLineCommentedEvent|TimelineCommitCommentedEvent|TimelineAssignedIssueEvent|TimelineUnassignedIssueEvent|StateChangeIssueEvent;

public type Dependencygraphdiff_inner record {
    "added"|"removed" change_type;
    string manifest;
    string ecosystem;
    string name;
    string version;
    string? package_url;
    string? license;
    string? source_repository_url;
    record {string severity; string advisory_ghsa_id; string advisory_summary; string advisory_url;}[] vulnerabilities;
    # Where the dependency is utilized. `development` means that the dependency is only utilized in the development environment. `runtime` means that the dependency is utilized at runtime and in the development environment.
    "unknown"|"runtime"|"development" scope;
};

# Secrets for a GitHub Codespace.
public type CodespacesSecret record {
    # The name of the secret
    string name;
    # The date and time at which the secret was created, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ.
    string created_at;
    # The date and time at which the secret was last updated, in ISO 8601 format':' YYYY-MM-DDTHH:MM:SSZ.
    string updated_at;
    # The type of repositories in the organization that the secret is visible to
    "all"|"private"|"selected" visibility;
    # The API URL at which the list of repositories this secret is visible to can be retrieved
    string selected_repositories_url;
};

public type Secret_name_repositories_body_2 record {
    # An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the `visibility` is set to `selected`. You can add and remove individual repositories using the [Set selected repositories for an organization secret](https://docs.github.com/rest/dependabot/secrets#set-selected-repositories-for-an-organization-secret) and [Remove selected repository from an organization secret](https://docs.github.com/rest/dependabot/secrets#remove-selected-repository-from-an-organization-secret) endpoints.
    int[] selected_repository_ids;
};

public type Secret_name_repositories_body_1 record {
    # An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the `visibility` is set to `selected`. You can add and remove individual repositories using the [Set selected repositories for an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#set-selected-repositories-for-an-organization-secret) and [Remove selected repository from an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#remove-selected-repository-from-an-organization-secret) endpoints.
    int[] selected_repository_ids;
};

# A collection of related issues and pull requests.
public type Milestone record {
    string url;
    string html_url;
    string labels_url;
    int id;
    string node_id;
    # The number of the milestone.
    int number;
    # The state of the milestone.
    "open"|"closed" state;
    # The title of the milestone.
    string title;
    string? description;
    # A GitHub user.
    NullableSimpleUser? creator;
    int open_issues;
    int closed_issues;
    string created_at;
    string updated_at;
    string? closed_at;
    string? due_on;
};

public type Filecommit_content record {
    string name?;
    string path?;
    string sha?;
    int size?;
    string url?;
    string html_url?;
    string git_url?;
    string download_url?;
    string 'type?;
    Filecommit_content__links _links?;
};

# Stargazer
public type StargazerResponse SimpleUser[]|Stargazer[];

public type Comment_number_reactions_body record {
    # The [reaction type](https://docs.github.com/rest/reactions/reactions#about-reactions) to add to the team discussion comment.
    "+1"|"-1"|"laugh"|"confused"|"heart"|"hooray"|"rocket"|"eyes" content;
};

public type MarketplaceAccount record {
    string url;
    int id;
    string 'type;
    string node_id?;
    string login;
    string? email?;
    string? organization_billing_email?;
};

public type Secret_name_repositories_body_3 record {
    # An array of repository ids for which a codespace can access the secret. You can manage the list of selected repositories using the [List selected repositories for a user secret](https://docs.github.com/rest/codespaces/secrets#list-selected-repositories-for-a-user-secret), [Add a selected repository to a user secret](https://docs.github.com/rest/codespaces/secrets#add-a-selected-repository-to-a-user-secret), and [Remove a selected repository from a user secret](https://docs.github.com/rest/codespaces/secrets#remove-a-selected-repository-from-a-user-secret) endpoints.
    int[] selected_repository_ids;
};

# Protected Branch Admin Enforced
public type ProtectedBranchAdminEnforced record {
    string url;
    boolean enabled;
};

public type Access_selected_users_body record {
    # The usernames of the organization members whose codespaces be billed to the organization.
    @constraint:Array {maxLength: 100}
    string[] selected_usernames;
};

# The REST API URL of the alert resource.
public type AlertUrl string;

# Set secrets for Dependabot.
public type DependabotSecret record {
    # The name of the secret.
    string name;
    string created_at;
    string updated_at;
};

# Issues are a great way to keep track of tasks, enhancements, and bugs for your projects.
public type NullableIssue record {
    int id;
    string node_id;
    # URL for the issue
    string url;
    string repository_url;
    string labels_url;
    string comments_url;
    string events_url;
    string html_url;
    # Number uniquely identifying the issue within its repository
    int number;
    # State of the issue; either 'open' or 'closed'
    string state;
    # The reason for the current state
    "completed"|"reopened"|"not_planned" state_reason?;
    # Title of the issue
    string title;
    # Contents of the issue
    string? body?;
    # A GitHub user.
    NullableSimpleUser? user;
    # Labels to associate with this issue; pass one or more label names to replace the set of labels on this issue; send an empty array to clear all labels from the issue; note that the labels are silently dropped for users without push access to the repository
    (string|record {int id?; string node_id?; string url?; string name?; string? description?; string? color?; boolean default?;})[] labels;
    # A GitHub user.
    NullableSimpleUser? assignee;
    SimpleUser[]? assignees?;
    # A collection of related issues and pull requests.
    NullableMilestone? milestone;
    boolean locked;
    string? active_lock_reason?;
    int comments;
    Issue_pull_request pull_request?;
    string? closed_at;
    string created_at;
    string updated_at;
    boolean draft?;
    # A GitHub user.
    NullableSimpleUser? closed_by?;
    string body_html?;
    string body_text?;
    string timeline_url?;
    # A repository on GitHub.
    Repository repository?;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app?;
    # How the author is associated with the repository.
    AuthorAssociation author_association;
    ReactionRollup reactions?;
};

# Content Traffic
public type ContentTraffic record {
    string path;
    string title;
    int count;
    int uniques;
};

public type Repositoryrulesetconditions_ref_name record {
    # Array of ref names or patterns to include. One of these patterns must match for the condition to pass. Also accepts `~DEFAULT_BRANCH` to include the default branch or `~ALL` to include all branches.
    string[] include?;
    # Array of ref names or patterns to exclude. The condition will not pass if any of these patterns match.
    string[] exclude?;
};

public type Hooks_hook_id_body_1 record {
    # Key/value pairs to provide settings for this webhook.
    Reposownerrepohookshook_id_config config?;
    # Determines what [events](https://docs.github.com/webhooks/event-payloads) the hook is triggered for. This replaces the entire array of events.
    string[] events?;
    # Determines a list of events to be added to the list of events that the Hook triggers for.
    string[] add_events?;
    # Determines a list of events to be removed from the list of events that the Hook triggers for.
    string[] remove_events?;
    # Determines if notifications are sent when the webhook is triggered. Set to `true` to send notifications.
    boolean active?;
};

# An identifier for the upload.
public type CodeScanningAnalysisSarifId string;

# User Marketplace Purchase
public type UserMarketplacePurchase record {
    string billing_cycle;
    string? next_billing_date;
    int? unit_count;
    boolean on_free_trial;
    string? free_trial_ends_on;
    string? updated_at;
    MarketplaceAccount account;
    # Marketplace Listing Plan
    MarketplaceListingPlan plan;
};

# Permissions requested, categorized by type of permission.
public type Organizationprogrammaticaccessgrantrequest_permissions record {
    record {|string...;|} organization?;
    record {|string...;|} repository?;
    record {|string...;|} other?;
};

# Gist
public type Gist record {
    string url;
    string forks_url;
    string commits_url;
    string id;
    string node_id;
    string git_pull_url;
    string git_push_url;
    string html_url;
    record {|Basegist_files...;|} files;
    boolean 'public;
    string created_at;
    string updated_at;
    string? description;
    int comments;
    # A GitHub user.
    NullableSimpleUser? user;
    string comments_url;
    # A GitHub user.
    NullableSimpleUser? owner?;
    boolean truncated?;
    anydata[] forks?;
    anydata[] history?;
};

public type Alerts_alert_number_body_2 record {
    # Sets the state of the secret scanning alert. You must provide `resolution` when you set the state to `resolved`.
    SecretScanningAlertState state;
    # **Required when the `state` is `resolved`.** The reason for resolving the alert.
    SecretScanningAlertResolution? resolution?;
    # An optional comment when closing an alert. Cannot be updated or deleted. Must be `null` when changing `state` to `open`.
    SecretScanningAlertResolutionComment? resolution_comment?;
};

public type Reviewdismissedissueevent_dismissed_review record {
    string state;
    int review_id;
    string? dismissal_message;
    string dismissal_commit_id?;
};

public type Repository_template_repository record {
    int id?;
    string node_id?;
    string name?;
    string full_name?;
    Repository_template_repository_owner owner?;
    boolean 'private?;
    string html_url?;
    string description?;
    boolean 'fork?;
    string url?;
    string archive_url?;
    string assignees_url?;
    string blobs_url?;
    string branches_url?;
    string collaborators_url?;
    string comments_url?;
    string commits_url?;
    string compare_url?;
    string contents_url?;
    string contributors_url?;
    string deployments_url?;
    string downloads_url?;
    string events_url?;
    string forks_url?;
    string git_commits_url?;
    string git_refs_url?;
    string git_tags_url?;
    string git_url?;
    string issue_comment_url?;
    string issue_events_url?;
    string issues_url?;
    string keys_url?;
    string labels_url?;
    string languages_url?;
    string merges_url?;
    string milestones_url?;
    string notifications_url?;
    string pulls_url?;
    string releases_url?;
    string ssh_url?;
    string stargazers_url?;
    string statuses_url?;
    string subscribers_url?;
    string subscription_url?;
    string tags_url?;
    string teams_url?;
    string trees_url?;
    string clone_url?;
    string mirror_url?;
    string hooks_url?;
    string svn_url?;
    string homepage?;
    string language?;
    int forks_count?;
    int stargazers_count?;
    int watchers_count?;
    int size?;
    string default_branch?;
    int open_issues_count?;
    boolean is_template?;
    string[] topics?;
    boolean has_issues?;
    boolean has_projects?;
    boolean has_wiki?;
    boolean has_pages?;
    boolean has_downloads?;
    boolean archived?;
    boolean disabled?;
    string visibility?;
    string pushed_at?;
    string created_at?;
    string updated_at?;
    Repository_template_repository_permissions permissions?;
    boolean allow_rebase_merge?;
    string temp_clone_token?;
    boolean allow_squash_merge?;
    boolean allow_auto_merge?;
    boolean delete_branch_on_merge?;
    boolean allow_update_branch?;
    boolean use_squash_pr_title_as_default?;
    # The default value for a squash merge commit title:
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `COMMIT_OR_PR_TITLE` - default to the commit's title (if only one commit) or the pull request's title (when more than one commit).
    "PR_TITLE"|"COMMIT_OR_PR_TITLE" squash_merge_commit_title?;
    # The default value for a squash merge commit message:
    # 
    # - `PR_BODY` - default to the pull request's body.
    # - `COMMIT_MESSAGES` - default to the branch's commit messages.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"COMMIT_MESSAGES"|"BLANK" squash_merge_commit_message?;
    # The default value for a merge commit title.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `MERGE_MESSAGE` - default to the classic title for a merge message (e.g., Merge pull request #123 from branch-name).
    "PR_TITLE"|"MERGE_MESSAGE" merge_commit_title?;
    # The default value for a merge commit message.
    # 
    # - `PR_TITLE` - default to the pull request's title.
    # - `PR_BODY` - default to the pull request's body.
    # - `BLANK` - default to a blank commit message.
    "PR_BODY"|"PR_TITLE"|"BLANK" merge_commit_message?;
    boolean allow_merge_commit?;
    int subscribers_count?;
    int network_count?;
};

# A product affected by the vulnerability detailed in a repository security advisory.
public type RepositoryAdvisoryVulnerability record {|
    # The name of the package affected by the vulnerability.
    Globaladvisory_package? package;
    # The range of the package versions affected by the vulnerability.
    string? vulnerable_version_range;
    # The package version(s) that resolve the vulnerability.
    string? patched_versions;
    # The functions in the package that are affected.
    string[]? vulnerable_functions;
|};

# A repository rule with ruleset details.
public type RepositoryRuleDetailed record {*RepositoryRuleCreation; *RepositoryRuleRulesetInfo;}|record {*RepositoryRuleUpdate; *RepositoryRuleRulesetInfo;}|record {*RepositoryRuleDeletion; *RepositoryRuleRulesetInfo;}|record {*RepositoryRuleRequiredLinearHistory; *RepositoryRuleRulesetInfo;}|record {*RepositoryRuleRequiredDeployments; *RepositoryRuleRulesetInfo;}|record {*RepositoryRuleRequiredSignatures; *RepositoryRuleRulesetInfo;}|record {*RepositoryRulePullRequest; *RepositoryRuleRulesetInfo;}|record {*RepositoryRuleRequiredStatusChecks; *RepositoryRuleRulesetInfo;}|record {*RepositoryRuleNonFastForward; *RepositoryRuleRulesetInfo;}|record {*RepositoryRuleCommitMessagePattern; *RepositoryRuleRulesetInfo;}|record {*RepositoryRuleCommitAuthorEmailPattern; *RepositoryRuleRulesetInfo;}|record {*RepositoryRuleCommitterEmailPattern; *RepositoryRuleRulesetInfo;}|record {*RepositoryRuleBranchNamePattern; *RepositoryRuleRulesetInfo;}|record {*RepositoryRuleTagNamePattern; *RepositoryRuleRulesetInfo;};

public type User_body record {
    # The new name of the user.
    string name?;
    # The publicly visible email address of the user.
    string email?;
    # The new blog URL of the user.
    string blog?;
    # The new Twitter username of the user.
    string? twitter_username?;
    # The new company of the user.
    string company?;
    # The new location of the user.
    string location?;
    # The new hiring availability of the user.
    boolean hireable?;
    # The new short biography of the user.
    string bio?;
};

# Use the `status` property to enable or disable GitHub Advanced Security for this repository. For more information, see "[About GitHub Advanced Security](/github/getting-started-with-github/learning-about-github/about-github-advanced-security)."
public type Reposownerrepo_security_and_analysis_advanced_security record {
    # Can be `enabled` or `disabled`.
    string status?;
};

public type Reposownerrepocheckruns_actions record {
    # The text to be displayed on a button in the web UI. The maximum size is 20 characters.
    @constraint:String {maxLength: 20}
    string label;
    # A short explanation of what this action would do. The maximum size is 40 characters.
    @constraint:String {maxLength: 40}
    string description;
    # A reference for the action on the integrator's system. The maximum size is 20 characters.
    @constraint:String {maxLength: 20}
    string identifier;
};

public type Artifact_workflow_run record {
    int id?;
    int repository_id?;
    int head_repository_id?;
    string head_branch?;
    string head_sha?;
};

public type PrivateVulnerabilityReportCreate record {|
    # A short summary of the advisory.
    @constraint:String {maxLength: 1024}
    string summary;
    # A detailed description of what the advisory impacts.
    @constraint:String {maxLength: 65535}
    string description;
    # An array of products affected by the vulnerability detailed in a repository security advisory.
    Repositoryadvisorycreate_vulnerabilities[]? vulnerabilities?;
    # A list of Common Weakness Enumeration (CWE) IDs.
    string[]? cwe_ids?;
    # The severity of the advisory. You must choose between setting this field or `cvss_vector_string`.
    "critical"|"high"|"medium"|"low" severity?;
    # The CVSS vector that calculates the severity of the advisory. You must choose between setting this field or `severity`.
    string? cvss_vector_string?;
|};

public type Permissions_repositories_body record {
    # List of repository IDs to enable for GitHub Actions.
    int[] selected_repository_ids;
};

# Details for the vulnerable dependency.
public type Dependabotalertwithrepository_dependency record {
    # Details for the vulnerable package.
    DependabotAlertPackage package?;
    # The full path to the dependency manifest file, relative to the root of the repository.
    string manifest_path?;
    # The execution scope of the vulnerable dependency.
    "development"|"runtime" scope?;
};

# Codespace default attributes
public type CodespaceDefaultResponse record {
    # A GitHub user.
    SimpleUser billable_owner?;
    # Codespace default attributes
    CodespaceDefault defaults?;
};

public type Repo_rulesets_body record {
    # The name of the ruleset.
    string name;
    # The target of the ruleset.
    "branch"|"tag" target?;
    # The enforcement level of the ruleset. `evaluate` allows admins to test rules before enforcing them. Admins can view insights on the Rule Insights page (`evaluate` is only available with GitHub Enterprise).
    RepositoryRuleEnforcement enforcement;
    # The actors that can bypass the rules in this ruleset
    RepositoryRulesetBypassActor[] bypass_actors?;
    # Parameters for a repository ruleset ref name condition
    RepositoryRulesetConditions conditions?;
    # An array of rules within the ruleset.
    RepositoryRule[] rules?;
};

public type Collaborator_permissions record {
    boolean pull;
    boolean triage?;
    boolean push;
    boolean maintain?;
    boolean admin;
};

# The default workflow permissions granted to the GITHUB_TOKEN when running workflows.
public type ActionsDefaultWorkflowPermissions "read"|"write";

# The breakdown of Copilot for Business seats for the organization.
public type CopilotSeatBreakdown record {
    # The total number of seats being billed for the organization as of the current billing cycle.
    int total?;
    # Seats added during the current billing cycle.
    int added_this_cycle?;
    # The number of seats that are pending cancellation at the end of the current billing cycle.
    int pending_cancellation?;
    # The number of seats that have been assigned to users that have not yet accepted an invitation to this organization.
    int pending_invitation?;
    # The number of seats that have used Copilot during the current billing cycle.
    int active_this_cycle?;
    # The number of seats that have not used Copilot during the current billing cycle.
    int inactive_this_cycle?;
};

# Page Build Status
public type PageBuildStatus record {
    string url;
    string status;
};

public type DockerMetadata record {
    string[] tag?;
};

# Groups of organization members that gives permissions on specified repositories.
public type TeamFull record {
    # Unique identifier of the team
    int id;
    string node_id;
    # URL for the team
    string url;
    string html_url;
    # Name of the team
    string name;
    string slug;
    string? description;
    # The level of privacy this team should have
    "closed"|"secret" privacy?;
    # The notification setting the team has set
    "notifications_enabled"|"notifications_disabled" notification_setting?;
    # Permission that the team will have for its repositories
    string permission;
    string members_url;
    string repositories_url;
    # Groups of organization members that gives permissions on specified repositories.
    NullableTeamSimple? parent?;
    int members_count;
    int repos_count;
    string created_at;
    string updated_at;
    # Team Organization
    TeamOrganization organization;
    # Distinguished Name (DN) that team maps to within LDAP environment
    string ldap_dn?;
};

# Project cards represent a scope of work.
public type ProjectCard record {
    string url;
    # The project card's ID
    int id;
    string node_id;
    string? note;
    # A GitHub user.
    NullableSimpleUser? creator;
    string created_at;
    string updated_at;
    # Whether or not the card is archived
    boolean archived?;
    string column_name?;
    string project_id?;
    string column_url;
    string content_url?;
    string project_url;
};

public type Repo_codespaces_body record {
    # Git ref (typically a branch name) for this codespace
    string ref?;
    # The requested location for a new codespace. Best efforts are made to respect this upon creation. Assigned by IP if not provided.
    string location?;
    # The geographic area for this codespace. If not specified, the value is assigned by IP. This property replaces `location`, which is being deprecated.
    "EuropeWest"|"SoutheastAsia"|"UsEast"|"UsWest" geo?;
    # IP for location auto-detection when proxying a request
    string client_ip?;
    # Machine type to use for this codespace
    string machine?;
    # Path to devcontainer.json config to use for this codespace
    string devcontainer_path?;
    # Whether to authorize requested permissions from devcontainer.json
    boolean multi_repo_permissions_opt_out?;
    # Working directory for this codespace
    string working_directory?;
    # Time in minutes before codespace stops from inactivity
    int idle_timeout_minutes?;
    # Display name for this codespace
    string display_name?;
    # Duration in minutes after codespace has gone idle in which it will be deleted. Must be integer minutes between 0 and 43200 (30 days).
    int retention_period_minutes?;
};

public type Codeownerserrors_errors record {
    # The line number where this errors occurs.
    int line;
    # The column number where this errors occurs.
    int column;
    # The contents of the line where the error occurs.
    string 'source?;
    # The type of error.
    string kind;
    # Suggested action to fix the error. This will usually be `null`, but is provided for some common errors.
    string? suggestion?;
    # A human-readable description of the error, combining information from multiple fields, laid out for display in a monospaced typeface (for example, a command-line setting).
    string message;
    # The path of the file where the error occured.
    string path;
};

public type Security_product_enablement_body record {
    # CodeQL query suite to be used. If you specify the `query_suite` parameter, the default setup will be configured with this query suite only on all repositories that didn't have default setup already configured. It will not change the query suite on repositories that already have default setup configured.
    # If you don't specify any `query_suite` in your request, the preferred query suite of the organization will be applied.
    "default"|"extended" query_suite?;
};

public type Alerts_alert_number_body_1 record {|
    # The state of the Dependabot alert.
    # A `dismissed_reason` must be provided when setting the state to `dismissed`.
    "dismissed"|"open" state;
    # **Required when `state` is `dismissed`.** A reason for dismissing the alert.
    "fix_started"|"inaccurate"|"no_bandwidth"|"not_used"|"tolerable_risk" dismissed_reason?;
    # An optional comment associated with dismissing the alert.
    @constraint:String {maxLength: 280}
    string dismissed_comment?;
|};

# A migration.
public type Migration record {
    int id;
    # A GitHub user.
    NullableSimpleUser? owner;
    string guid;
    string state;
    boolean lock_repositories;
    boolean exclude_metadata;
    boolean exclude_git_data;
    boolean exclude_attachments;
    boolean exclude_releases;
    boolean exclude_owner_projects;
    boolean org_metadata_only;
    # The repositories included in the migration. Only returned for export migrations.
    Repository[] repositories;
    string url;
    string created_at;
    string updated_at;
    string node_id;
    string archive_url?;
    # Exclude related items from being returned in the response in order to improve performance of the request. The array can include any of: `"repositories"`.
    string[] exclude?;
};

public type Assets_asset_id_body record {
    # The file name of the asset.
    string name?;
    # An alternate short description of the asset. Used in place of the filename.
    string label?;
    string state?;
};

public type Personalaccesstokens_pat_id_body record {
    # Action to apply to the fine-grained personal access token.
    "revoke" action;
};

# Identifies the variable values associated with the environment in which this analysis was performed.
public type CodeScanningAnalysisEnvironment string;

public type Markdown_body record {
    # The Markdown text to render in HTML.
    string text;
    # The rendering mode.
    "markdown"|"gfm" mode = "markdown";
    # The repository context to use when creating references in `gfm` mode.  For example, setting `context` to `octo-org/octo-repo` will change the text `#42` into an HTML link to issue 42 in the `octo-org/octo-repo` repository.
    string context?;
};

# The dismissal comment associated with the dismissal of the alert.
public type CodeScanningAlertDismissedComment string?;

public type PagesHttpsCertificate record {
    "new"|"authorization_created"|"authorization_pending"|"authorized"|"authorization_revoked"|"issued"|"uploaded"|"approved"|"errored"|"bad_authz"|"destroy_pending"|"dns_changed" state;
    string description;
    # Array of the domain set and its alternate name (if it is configured)
    string[] domains;
    string expires_at?;
};

# Details for the advisory pertaining to the Common Vulnerability Scoring System.
public type Dependabotalertsecurityadvisory_cvss record {|
    # The overall CVSS score of the advisory.
    @constraint:Number {minValue: 0, maxValue: 10}
    decimal score;
    # The full CVSS vector string for the advisory.
    string? vector_string;
|};

public type Pullrequest_base_repo record {
    string archive_url;
    string assignees_url;
    string blobs_url;
    string branches_url;
    string collaborators_url;
    string comments_url;
    string commits_url;
    string compare_url;
    string contents_url;
    string contributors_url;
    string deployments_url;
    string? description;
    string downloads_url;
    string events_url;
    boolean 'fork;
    string forks_url;
    string full_name;
    string git_commits_url;
    string git_refs_url;
    string git_tags_url;
    string hooks_url;
    string html_url;
    int id;
    boolean is_template?;
    string node_id;
    string issue_comment_url;
    string issue_events_url;
    string issues_url;
    string keys_url;
    string labels_url;
    string languages_url;
    string merges_url;
    string milestones_url;
    string name;
    string notifications_url;
    Pullrequest_head_repo_owner owner;
    boolean 'private;
    string pulls_url;
    string releases_url;
    string stargazers_url;
    string statuses_url;
    string subscribers_url;
    string subscription_url;
    string tags_url;
    string teams_url;
    string trees_url;
    string url;
    string clone_url;
    string default_branch;
    int forks;
    int forks_count;
    string git_url;
    boolean has_downloads;
    boolean has_issues;
    boolean has_projects;
    boolean has_wiki;
    boolean has_pages;
    boolean has_discussions;
    string? homepage;
    string? language;
    string master_branch?;
    boolean archived;
    boolean disabled;
    # The repository visibility: public, private, or internal.
    string visibility?;
    string? mirror_url;
    int open_issues;
    int open_issues_count;
    Fullrepository_permissions permissions?;
    string temp_clone_token?;
    boolean allow_merge_commit?;
    boolean allow_squash_merge?;
    boolean allow_rebase_merge?;
    # License Simple
    NullableLicenseSimple? license;
    string pushed_at;
    int size;
    string ssh_url;
    int stargazers_count;
    string svn_url;
    string[] topics?;
    int watchers;
    int watchers_count;
    string created_at;
    string updated_at;
    boolean allow_forking?;
    boolean web_commit_signoff_required?;
};

public type CombinedBillingUsage record {
    # Numbers of days left in billing cycle.
    int days_left_in_billing_cycle;
    # Estimated storage space (GB) used in billing cycle.
    int estimated_paid_storage_for_month;
    # Estimated sum of free and paid storage space (GB) used in billing cycle.
    int estimated_storage_for_month;
};

# Team Membership
public type TeamMembership record {
    string url;
    # The role of the user in the team.
    "member"|"maintainer" role;
    # The state of the user's membership in the team.
    "active"|"pending" state;
};

public type ManifestConversions record {
    *Integration;
    string client_id;
    string client_secret;
    string? webhook_secret;
    string pem;
};

# The media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`.
public type WebhookConfigContentType string;

# Whether or not a user who created the job is prevented from approving their own job.
public type PreventSelfReview boolean;

public type SearchResultTextMatches Searchresulttextmatches_inner[];

# Information about the person who is making the commit. By default, `committer` will use the information set in `author`. See the `author` and `committer` object below for details.
public type Reposownerrepogitcommits_committer record {
    # The name of the author (or committer) of the commit
    string name?;
    # The email of the author (or committer) of the commit
    string email?;
    # Indicates when this commit was authored (or committed). This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    string date?;
};

public type Team_slug_discussions_body record {
    # The discussion post's title.
    string title;
    # The discussion post's body text.
    string body;
    # Private posts are only visible to team members, organization owners, and team maintainers. Public posts are visible to all members of the organization. Set to `true` to create a private post.
    boolean 'private = false;
};

# Response
public type RuleSuite record {
    # The unique identifier of the rule insight.
    int id?;
    # The number that identifies the user.
    int actor_id?;
    # The handle for the GitHub user account.
    string actor_name?;
    # The first commit sha before the push evaluation.
    string before_sha?;
    # The last commit sha in the push evaluation.
    string after_sha?;
    # The ref name that the evaluation ran on.
    string ref?;
    # The ID of the repository associated with the rule evaluation.
    int repository_id?;
    # The name of the repository without the `.git` extension.
    string repository_name?;
    string pushed_at?;
    # The result of the rule evaluations for rules with the `active` enforcement status.
    "pass"|"fail"|"bypass" result?;
    # The result of the rule evaluations for rules with the `active` and `evaluate` enforcement statuses, demonstrating whether rules would pass or fail if all rules in the rule suite were `active`.
    "pass"|"fail" evaluation_result?;
    # Details on the evaluated rules.
    Rulesuite_rule_evaluations[] rule_evaluations?;
};

# The type of content tracked in a project item
public type ProjectsV2ItemContentType "Issue"|"PullRequest"|"DraftIssue";

public type Filecommit_commit_author record {
    string date?;
    string name?;
    string email?;
};

# Information about a Copilot for Business seat assignment for a user, team, or organization.
public type CopilotSeatDetailsResponse record {
    # Total number of Copilot For Business seats for the organization currently being billed.
    int total_seats?;
    CopilotSeatDetails[] seats?;
};

public type Job_steps record {
    # The phase of the lifecycle that the job is currently in.
    "queued"|"in_progress"|"completed" status;
    # The outcome of the job.
    string? conclusion;
    # The name of the job.
    string name;
    int number;
    # The time that the step started, in ISO 8601 format.
    string? started_at?;
    # The time that the job finished, in ISO 8601 format.
    string? completed_at?;
};

public type Git_refs_body record {
    # The name of the fully qualified reference (ie: `refs/heads/master`). If it doesn't start with 'refs' and have at least two slashes, it will be rejected.
    string ref;
    # The SHA1 value for this reference.
    string sha;
};

# Comments provide a way for people to collaborate on an issue.
public type IssueComment record {
    # Unique identifier of the issue comment
    int id;
    string node_id;
    # URL for the issue comment
    string url;
    # Contents of the issue comment
    string body?;
    string body_text?;
    string body_html?;
    string html_url;
    # A GitHub user.
    NullableSimpleUser? user;
    string created_at;
    string updated_at;
    string issue_url;
    # How the author is associated with the repository.
    AuthorAssociation author_association;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app?;
    ReactionRollup reactions?;
};

# Repository actions caches
public type ActionsCacheList record {
    # Total number of caches
    int total_count;
    # Array of caches
    Actionscachelist_actions_caches[] actions_caches;
};

# A software package
public type Package record {
    # Unique identifier of the package.
    int id;
    # The name of the package.
    string name;
    "npm"|"maven"|"rubygems"|"docker"|"nuget"|"container" package_type;
    string url;
    string html_url;
    # The number of versions of the package.
    int version_count;
    "private"|"public" visibility;
    # A GitHub user.
    NullableSimpleUser? owner?;
    # Minimal Repository
    NullableMinimalRepository? repository?;
    string created_at;
    string updated_at;
};

public type Issuesearchresultitem_labels record {
    int id?;
    string node_id?;
    string url?;
    string name?;
    string color?;
    boolean default?;
    string? description?;
};

public type ActionsWorkflowAccessToRepository record {
    # Defines the level of access that workflows outside of the repository have to actions and reusable workflows within the
    # repository.
    # 
    # `none` means the access is only possible from workflows in this repository. `user` level access allows sharing across user owned private repos only. `organization` level access allows sharing across the organization.
    "none"|"user"|"organization" access_level;
};

# Conditions for an organization ruleset. The conditions object should contain both `repository_name` and `ref_name` properties or both `repository_id` and `ref_name` properties.
public type OrgRulesetConditions record {*RepositoryRulesetConditions; *RepositoryRulesetConditionsRepositoryNameTarget;}|record {*RepositoryRulesetConditions; *RepositoryRulesetConditionsRepositoryIdTarget;};

# Renamed Issue Event
public type RenamedIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    Renamedissueevent_rename rename;
};

public type Validationerror_errors record {
    string 'resource?;
    string 'field?;
    string message?;
    string code;
    int index?;
    string|int|string[]? value?;
};

# The REST API URL for fetching the list of instances for an alert.
public type AlertInstancesUrl string;

# Snapshot of a newly created repository's dependencies.
public type SnapshotResponse record {
    # ID of the created snapshot.
    int id;
    # The time at which the snapshot was created.
    string created_at;
    # Either "SUCCESS", "ACCEPTED", or "INVALID". "SUCCESS" indicates that the snapshot was successfully created and the repository's dependencies were updated. "ACCEPTED" indicates that the snapshot was successfully created, but the repository's dependencies were not updated. "INVALID" indicates that the snapshot was malformed.
    string result;
    # A message providing further details about the result, such as why the dependencies were not updated.
    string message;
};

# Prevent users with push access from force pushing to refs.
public type RepositoryRuleNonFastForward record {
    "non_fast_forward" 'type;
};

public type Marketplacepurchase_marketplace_pending_change record {
    boolean is_installed?;
    string effective_date?;
    int? unit_count?;
    int id?;
    # Marketplace Listing Plan
    MarketplaceListingPlan plan?;
};

# Details for the vulnerable package.
public type DependabotAlertPackage record {|
    # The package's language or package management ecosystem.
    string ecosystem;
    # The unique package name within its ecosystem.
    string name;
|};

public type Pullrequestminimal_head_repo record {
    int id;
    string url;
    string name;
};

# The public key used for setting Dependabot Secrets.
public type DependabotPublicKey record {
    # The identifier for the key.
    string key_id;
    # The Base64 encoded public key.
    string 'key;
};

# Enable or disable Dependabot security updates for the repository.
public type Securityandanalysis_dependabot_security_updates record {
    # The enablement status of Dependabot security updates for the repository.
    "enabled"|"disabled" status?;
};

# Secrets for GitHub Actions for an organization.
public type OrganizationActionsSecretResponse record {
    int total_count;
    OrganizationActionsSecret[] secrets;
};

public type Event_payload record {
    string action?;
    # Issues are a great way to keep track of tasks, enhancements, and bugs for your projects.
    Issue issue?;
    # Comments provide a way for people to collaborate on an issue.
    IssueComment comment?;
    Event_payload_pages[] pages?;
};

# A check performed on the code of a given code change
public type CheckRunResponse record {
    int total_count;
    CheckRun[] check_runs;
};

public type Repo_transfer_body record {
    # The username or organization name the repository will be transferred to.
    string new_owner;
    # The new name to be given to the repository.
    string new_name?;
    # ID of the team or teams to add to the repository. Teams can only be added to organization-owned repositories.
    int[] team_ids?;
};

# Limit interactions to a specific type of user for a specified duration
public type InteractionLimit record {
    # The type of GitHub user that can comment, open issues, or create pull requests while the interaction limit is in effect.
    InteractionGroup 'limit;
    # The duration of the interaction restriction. Default: `one_day`.
    InteractionExpiry expiry?;
};

# Check runs can accept a variety of data in the `output` object, including a `title` and `summary` and can optionally provide descriptive details about the run.
public type Reposownerrepocheckruns_output record {
    # The title of the check run.
    string title;
    # The summary of the check run. This parameter supports Markdown. **Maximum length**: 65535 characters.
    @constraint:String {maxLength: 65535}
    string summary;
    # The details of the check run. This parameter supports Markdown. **Maximum length**: 65535 characters.
    @constraint:String {maxLength: 65535}
    string text?;
    # Adds information from your analysis to specific lines of code. Annotations are visible on GitHub in the **Checks** and **Files changed** tab of the pull request. The Checks API limits the number of annotations to a maximum of 50 per API request. To create more than 50 annotations, you have to make multiple requests to the [Update a check run](https://docs.github.com/rest/checks/runs#update-a-check-run) endpoint. Each time you update the check run, annotations are appended to the list of annotations that already exist for the check run. GitHub Actions are limited to 10 warning annotations and 10 error annotations per step. For details about how you can view annotations on GitHub, see "[About status checks](https://docs.github.com/articles/about-status-checks#checks)".
    @constraint:Array {maxLength: 50}
    Reposownerrepocheckruns_output_annotations[] annotations?;
    # Adds images to the output displayed in the GitHub pull request UI.
    Reposownerrepocheckruns_output_images[] images?;
};

public type Event_repo record {
    int id;
    string name;
    string url;
};

# New requested permissions, categorized by type of permission.
public type Personalaccesstokenrequest_permissions_added record {
    record {|string...;|} organization?;
    record {|string...;|} repository?;
    record {|string...;|} other?;
};

# File Commit
public type FileCommit record {
    Filecommit_content? content;
    Filecommit_commit 'commit;
};

public type Manifest_file record {|
    # The path of the manifest file relative to the root of the Git repository.
    string source_location?;
|};

public type Gitcommit_parents record {
    # SHA for the commit
    string sha;
    string url;
    string html_url;
};

public type Branchprotection_required_linear_history record {
    boolean enabled?;
};

# Tag
public type Tag record {
    string name;
    Shortbranch_commit 'commit;
    string zipball_url;
    string tarball_url;
    string node_id;
};

# Groups of organization members that gives permissions on specified repositories.
public type TeamSimple record {
    # Unique identifier of the team
    int id;
    string node_id;
    # URL for the team
    string url;
    string members_url;
    # Name of the team
    string name;
    # Description of the team
    string? description;
    # Permission that the team will have for its repositories
    string permission;
    # The level of privacy this team should have
    string privacy?;
    # The notification setting the team has set
    string notification_setting?;
    string html_url;
    string repositories_url;
    string slug;
    # Distinguished Name (DN) that team maps to within LDAP environment
    string ldap_dn?;
};

# Allow specific users, teams, or apps to bypass pull request requirements.
public type Reposownerrepobranchesbranchprotection_required_pull_request_reviews_bypass_pull_request_allowances record {
    # The list of user `login`s allowed to bypass pull request requirements.
    string[] users?;
    # The list of team `slug`s allowed to bypass pull request requirements.
    string[] teams?;
    # The list of app `slug`s allowed to bypass pull request requirements.
    string[] apps?;
};

public type Discussion_category record {
    string created_at;
    string description;
    string emoji;
    int id;
    boolean is_answerable;
    string name;
    string node_id?;
    int repository_id;
    string slug;
    string updated_at;
};

public type Codespaces_codespace_name_body record {
    # A valid machine to transition this codespace to.
    string machine?;
    # Display name for this codespace
    string display_name?;
    # Recently opened folders inside the codespace. It is currently used by the clients to determine the folder path to load the codespace in.
    string[] recent_folders?;
};

public type Protectedbranch_required_pull_request_reviews_dismissal_restrictions record {
    string url;
    string users_url;
    string teams_url;
    SimpleUser[] users;
    Team[] teams;
    Integration[] apps?;
};

# Key/value pairs to provide settings for this webhook.
public type Reposownerrepohooks_config record {
    # The URL to which the payloads will be delivered.
    WebhookConfigUrl url?;
    # The media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`.
    WebhookConfigContentType content_type?;
    # If provided, the `secret` will be used as the `key` to generate the HMAC hex digest value for [delivery signature headers](https://docs.github.com/webhooks/event-payloads/#delivery-headers).
    WebhookConfigSecret secret?;
    WebhookConfigInsecureSsl insecure_ssl?;
    string token?;
    string digest?;
};

# Restrict who can push to the protected branch. User, app, and team `restrictions` are only available for organization-owned repositories. Set to `null` to disable.
public type Reposownerrepobranchesbranchprotection_restrictions record {
    # The list of user `login`s with push access
    string[] users;
    # The list of team `slug`s with push access
    string[] teams;
    # The list of app `slug`s with push access
    string[] apps?;
};

# Stargazer
public type Stargazer record {
    string starred_at;
    # A GitHub user.
    NullableSimpleUser? user;
};

# Protected Branch Required Status Check
public type ProtectedBranchRequiredStatusCheck record {
    string url?;
    string enforcement_level?;
    string[] contexts;
    Protectedbranchrequiredstatuscheck_checks[] checks;
    string contexts_url?;
    boolean strict?;
};

public type Protection_required_pull_request_reviews_body record {
    # Specify which users, teams, and apps can dismiss pull request reviews. Pass an empty `dismissal_restrictions` object to disable. User and team `dismissal_restrictions` are only available for organization-owned repositories. Omit this parameter for personal repositories.
    Reposownerrepobranchesbranchprotection_required_pull_request_reviews_dismissal_restrictions dismissal_restrictions?;
    # Set to `true` if you want to automatically dismiss approving reviews when someone pushes a new commit.
    boolean dismiss_stale_reviews?;
    # Blocks merging pull requests until [code owners](https://docs.github.com/articles/about-code-owners/) have reviewed.
    boolean require_code_owner_reviews?;
    # Specifies the number of reviewers required to approve pull requests. Use a number between 1 and 6 or 0 to not require reviewers.
    int required_approving_review_count?;
    # Whether the most recent push must be approved by someone other than the person who pushed it. Default: `false`
    boolean require_last_push_approval?;
    # Allow specific users, teams, or apps to bypass pull request requirements.
    Reposownerrepobranchesbranchprotection_required_pull_request_reviews_bypass_pull_request_allowances bypass_pull_request_allowances?;
};

public type Tags_protection_body record {
    # An optional glob pattern to match against when enforcing tag protection.
    string pattern;
};

public type Branchshort_commit record {
    string sha;
    string url;
};

# A repository on GitHub.
public type RepositoryResponse record {
    int total_count;
    string repository_selection?;
    Repository[] repositories;
};

# A codespace.
public type CodespaceWithFullRepository record {
    int id;
    # Automatically generated name of this codespace.
    string name;
    # Display name for this codespace.
    string? display_name?;
    # UUID identifying this codespace's environment.
    string? environment_id;
    # A GitHub user.
    SimpleUser owner;
    # A GitHub user.
    SimpleUser billable_owner;
    # Full Repository
    FullRepository repository;
    # A description of the machine powering a codespace.
    NullableCodespaceMachine? machine;
    # Path to devcontainer.json from repo root used to create Codespace.
    string? devcontainer_path?;
    # Whether the codespace was created from a prebuild.
    boolean? prebuild;
    string created_at;
    string updated_at;
    # Last known time this codespace was started.
    string last_used_at;
    # State of this codespace.
    "Unknown"|"Created"|"Queued"|"Provisioning"|"Available"|"Awaiting"|"Unavailable"|"Deleted"|"Moved"|"Shutdown"|"Archived"|"Starting"|"ShuttingDown"|"Failed"|"Exporting"|"Updating"|"Rebuilding" state;
    # API URL for this codespace.
    string url;
    # Details about the codespace's git repository.
    Codespace_git_status git_status;
    # The initally assigned location of a new codespace.
    "EastUs"|"SouthEastAsia"|"WestEurope"|"WestUs2" location;
    # The number of minutes of inactivity after which this codespace will be automatically stopped.
    int? idle_timeout_minutes;
    # URL to access this codespace on the web.
    string web_url;
    # API URL to access available alternate machine types for this codespace.
    string machines_url;
    # API URL to start this codespace.
    string start_url;
    # API URL to stop this codespace.
    string stop_url;
    # API URL to publish this codespace to a new repository.
    string? publish_url?;
    # API URL for the Pull Request associated with this codespace, if any.
    string? pulls_url;
    string[] recent_folders;
    Codespace_runtime_constraints runtime_constraints?;
    # Whether or not a codespace has a pending async operation. This would mean that the codespace is temporarily unavailable. The only thing that you can do with a codespace in this state is delete it.
    boolean? pending_operation?;
    # Text to show user when codespace is disabled by a pending operation
    string? pending_operation_disabled_reason?;
    # Text to show user when codespace idle timeout minutes has been overriden by an organization policy
    string? idle_timeout_notice?;
    # Duration in minutes after codespace has gone idle in which it will be deleted. Must be integer minutes between 0 and 43200 (30 days).
    int? retention_period_minutes?;
    # When a codespace will be auto-deleted based on the "retention_period_minutes" and "last_used_at"
    string? retention_expires_at?;
};

public type Org_rulesets_body record {
    # The name of the ruleset.
    string name;
    # The target of the ruleset.
    "branch"|"tag" target?;
    # The enforcement level of the ruleset. `evaluate` allows admins to test rules before enforcing them. Admins can view insights on the Rule Insights page (`evaluate` is only available with GitHub Enterprise).
    RepositoryRuleEnforcement enforcement;
    # The actors that can bypass the rules in this ruleset
    RepositoryRulesetBypassActor[] bypass_actors?;
    # Conditions for an organization ruleset. The conditions object should contain both `repository_name` and `ref_name` properties or both `repository_id` and `ref_name` properties.
    OrgRulesetConditions conditions?;
    # An array of rules within the ruleset.
    RepositoryRule[] rules?;
};

public type Environment_name_deployment_protection_rules_body record {
    # The ID of the custom app that will be enabled on the environment.
    int integration_id?;
};

# Identifies the configuration under which the analysis was executed. Used to distinguish between multiple analyses for the same tool and commit, but performed on different languages or different parts of the code.
public type CodeScanningAnalysisCategory string;

public type Secrets_secret_name_body_1 record {
    # The value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get an organization public key](https://docs.github.com/rest/codespaces/organization-secrets#get-an-organization-public-key) endpoint.
    @constraint:String {pattern: re `^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$`}
    string encrypted_value?;
    # The ID of the key you used to encrypt the secret.
    string key_id?;
    # Which type of organization repositories have access to the organization secret. `selected` means only the repositories specified by `selected_repository_ids` can access the secret.
    "all"|"private"|"selected" visibility;
    # An array of repository IDs that can access the organization secret. You can only provide a list of repository IDs when the `visibility` is set to `selected`. You can manage the list of selected repositories using the [List selected repositories for an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#list-selected-repositories-for-an-organization-secret), [Set selected repositories for an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#set-selected-repositories-for-an-organization-secret), and [Remove selected repository from an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#remove-selected-repository-from-an-organization-secret) endpoints.
    int[] selected_repository_ids?;
};

public type Issues_issue_number_body record {
    # The title of the issue.
    string|int? title?;
    # The contents of the issue.
    string? body?;
    # Username to assign to this issue. **This field is deprecated.**
    string? assignee?;
    # The open or closed state of the issue.
    "open"|"closed" state?;
    # The reason for the state change. Ignored unless `state` is changed.
    "completed"|"not_planned"|"reopened" state_reason?;
    string|int? milestone?;
    # Labels to associate with this issue. Pass one or more labels to _replace_ the set of labels on this issue. Send an empty array (`[]`) to clear all labels from the issue. Only users with push access can set labels for issues. Without push access to the repository, label changes are silently dropped.
    (string|record {int id?; string name?; string? description?; string? color?;})[] labels?;
    # Usernames to assign to this issue. Pass one or more user logins to _replace_ the set of assignees on this issue. Send an empty array (`[]`) to clear all assignees from the issue. Only users with push access can set assignees for new issues. Without push access to the repository, assignee changes are silently dropped.
    string[] assignees?;
};

public type Secrets_secret_name_body_2 record {
    # Value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get an organization public key](https://docs.github.com/rest/dependabot/secrets#get-an-organization-public-key) endpoint.
    @constraint:String {pattern: re `^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$`}
    string encrypted_value?;
    # ID of the key you used to encrypt the secret.
    string key_id?;
    # Which type of organization repositories have access to the organization secret. `selected` means only the repositories specified by `selected_repository_ids` can access the secret.
    "all"|"private"|"selected" visibility;
    # An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the `visibility` is set to `selected`. You can manage the list of selected repositories using the [List selected repositories for an organization secret](https://docs.github.com/rest/dependabot/secrets#list-selected-repositories-for-an-organization-secret), [Set selected repositories for an organization secret](https://docs.github.com/rest/dependabot/secrets#set-selected-repositories-for-an-organization-secret), and [Remove selected repository from an organization secret](https://docs.github.com/rest/dependabot/secrets#remove-selected-repository-from-an-organization-secret) endpoints.
    string[] selected_repository_ids?;
};

public type Repositoryrulerequireddeployments_parameters record {
    # The environments that must be successfully deployed to before branches can be merged.
    string[] required_deployment_environments;
};

public type Secrets_secret_name_body_3 record {
    # Value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get a repository public key](https://docs.github.com/rest/actions/secrets#get-a-repository-public-key) endpoint.
    @constraint:String {pattern: re `^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$`}
    string encrypted_value?;
    # ID of the key you used to encrypt the secret.
    string key_id?;
};

public type Apioverview_ssh_key_fingerprints record {
    string SHA256_RSA?;
    string SHA256_DSA?;
    string SHA256_ECDSA?;
    string SHA256_ED25519?;
};

public type Rulesuite_rule_evaluations record {
    Rulesuite_rule_source rule_source?;
    # The enforcement level of this rule source.
    "active"|"evaluate"|"deleted ruleset" enforcement?;
    # The result of the evaluation of the individual rule.
    "pass"|"fail" result?;
    # The type of rule.
    string rule_type?;
    # Any associated details with the rule evaluation.
    string details?;
};

public type Globaladvisory_cvss record {
    # The CVSS vector.
    string? vector_string;
    # The CVSS score.
    decimal? score;
};

public type Secrets_secret_name_body_4 record {
    # Value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get a repository public key](https://docs.github.com/rest/codespaces/repository-secrets#get-a-repository-public-key) endpoint.
    @constraint:String {pattern: re `^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$`}
    string encrypted_value?;
    # ID of the key you used to encrypt the secret.
    string key_id?;
};

public type Secrets_secret_name_body_5 record {
    # Value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get a repository public key](https://docs.github.com/rest/dependabot/secrets#get-a-repository-public-key) endpoint.
    @constraint:String {pattern: re `^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$`}
    string encrypted_value?;
    # ID of the key you used to encrypt the secret.
    string key_id?;
};

# An invocation of a workflow
public type WorkflowRun record {
    # The ID of the workflow run.
    int id;
    # The name of the workflow run.
    string? name?;
    string node_id;
    # The ID of the associated check suite.
    int check_suite_id?;
    # The node ID of the associated check suite.
    string check_suite_node_id?;
    string? head_branch;
    # The SHA of the head commit that points to the version of the workflow being run.
    string head_sha;
    # The full path of the workflow
    string path;
    # The auto incrementing run number for the workflow run.
    int run_number;
    # Attempt number of the run, 1 for first attempt and higher if the workflow was re-run.
    int run_attempt?;
    ReferencedWorkflow[]? referenced_workflows?;
    string event;
    string? status;
    string? conclusion;
    # The ID of the parent workflow.
    int workflow_id;
    # The URL to the workflow run.
    string url;
    string html_url;
    # Pull requests that are open with a `head_sha` or `head_branch` that matches the workflow run. The returned pull requests do not necessarily indicate pull requests that triggered the run.
    PullRequestMinimal[]? pull_requests;
    string created_at;
    string updated_at;
    # A GitHub user.
    SimpleUser actor?;
    # A GitHub user.
    SimpleUser triggering_actor?;
    # The start time of the latest run. Resets on re-run.
    string run_started_at?;
    # The URL to the jobs for the workflow run.
    string jobs_url;
    # The URL to download the logs for the workflow run.
    string logs_url;
    # The URL to the associated check suite.
    string check_suite_url;
    # The URL to the artifacts for the workflow run.
    string artifacts_url;
    # The URL to cancel the workflow run.
    string cancel_url;
    # The URL to rerun the workflow run.
    string rerun_url;
    # The URL to the previous attempted run of this workflow, if one exists.
    string? previous_attempt_url?;
    # The URL to the workflow.
    string workflow_url;
    # A commit.
    NullableSimpleCommit? head_commit;
    # Minimal Repository
    MinimalRepository repository;
    # Minimal Repository
    MinimalRepository head_repository;
    int head_repository_id?;
    # The event-specific title associated with the run or the run-name if set, or the value of `run-name` if it is set in the workflow.
    string display_title;
};

public type Secrets_secret_name_body_6 record {
    # Value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get an environment public key](https://docs.github.com/rest/actions/secrets#get-an-environment-public-key) endpoint.
    @constraint:String {pattern: re `^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$`}
    string encrypted_value;
    # ID of the key you used to encrypt the secret.
    string key_id;
};

public type Secrets_secret_name_body_7 record {
    # Value for your secret, encrypted with [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages) using the public key retrieved from the [Get the public key for the authenticated user](https://docs.github.com/rest/codespaces/secrets#get-public-key-for-the-authenticated-user) endpoint.
    @constraint:String {pattern: re `^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$`}
    string encrypted_value?;
    # ID of the key you used to encrypt the secret.
    string key_id;
    # An array of repository ids that can access the user secret. You can manage the list of selected repositories using the [List selected repositories for a user secret](https://docs.github.com/rest/codespaces/secrets#list-selected-repositories-for-a-user-secret), [Set selected repositories for a user secret](https://docs.github.com/rest/codespaces/secrets#set-selected-repositories-for-a-user-secret), and [Remove a selected repository from a user secret](https://docs.github.com/rest/codespaces/secrets#remove-a-selected-repository-from-a-user-secret) endpoints.
    (int|string)[] selected_repository_ids?;
};

# Identifies the configuration under which the analysis was executed. For example, in GitHub Actions this includes the workflow filename and job name.
public type CodeScanningAnalysisAnalysisKey string;

public type Issue_number_assignees_body record {
    # Usernames of people to assign this issue to. _NOTE: Only users with push access can add assignees to an issue. Assignees are silently ignored otherwise._
    string[] assignees?;
};

public type ActionsCacheUsageOrgEnterprise record {
    # The count of active caches across all repositories of an enterprise or an organization.
    int total_active_caches_count;
    # The total size in bytes of all active cache items across all repositories of an enterprise or an organization.
    int total_active_caches_size_in_bytes;
};

public type Team_id_discussions_body record {
    # The discussion post's title.
    string title;
    # The discussion post's body text.
    string body;
    # Private posts are only visible to team members, organization owners, and team maintainers. Public posts are visible to all members of the organization. Set to `true` to create a private post.
    boolean 'private = false;
};

# A GitHub organization.
public type OrganizationSimple record {
    string login;
    int id;
    string node_id;
    string url;
    string repos_url;
    string events_url;
    string hooks_url;
    string issues_url;
    string members_url;
    string public_members_url;
    string avatar_url;
    string? description;
};

# How the author is associated with the repository.
public type AuthorAssociation "COLLABORATOR"|"CONTRIBUTOR"|"FIRST_TIMER"|"FIRST_TIME_CONTRIBUTOR"|"MANNEQUIN"|"MEMBER"|"NONE"|"OWNER";

# Details of a deployment environment
public type Environment record {
    # The id of the environment.
    int id;
    string node_id;
    # The name of the environment.
    string name;
    string url;
    string html_url;
    # The time that the environment was created, in ISO 8601 format.
    string created_at;
    # The time that the environment was last updated, in ISO 8601 format.
    string updated_at;
    # Built-in deployment protection rules for the environment.
    (record {
        int id;
        string node_id;
        string 'type;
        # The amount of time to delay a job after the job is initially triggered. The time (in minutes) must be an integer between 0 and 43,200 (30 days).
        WaitTimer wait_timer?;
    }|record {
        int id;
        string node_id;
        # Whether deployments to this environment can be approved by the user who created the deployment.
        boolean prevent_self_review?;
        string 'type;
        # The people or teams that may approve jobs that reference the environment. You can list up to six users or teams as reviewers. The reviewers must have at least read access to the repository. Only one of the required reviewers needs to approve the job for it to proceed.
        record {
            # The type of reviewer.
            DeploymentReviewerType 'type?;
            SimpleUser|Team reviewer?;
        }[] reviewers?;
    }|record {int id; string node_id; string 'type;})[] protection_rules?;
    # The type of deployment branch policy for this environment. To allow all branches to deploy, set to `null`.
    DeploymentBranchPolicySettings? deployment_branch_policy?;
};

public type PullRequestMinimal record {
    int id;
    int number;
    string url;
    Pullrequestminimal_head head;
    Pullrequestminimal_head base;
};

public type Orgmembership_permissions record {
    boolean can_create_repository;
};

public type Workflowrunusage_billable_UBUNTU_job_runs record {
    int job_id;
    int duration_ms;
};

public type ReviewCustomGatesCommentRequired record {
    # The name of the environment to approve or reject.
    string environment_name;
    # Comment associated with the pending deployment protection rule. **Required when state is not provided.**
    string comment;
};

public type Actions_variables_body record {
    # The name of the variable.
    string name;
    # The value of the variable.
    string value;
    # The type of repositories in the organization that can access the variable. `selected` means only the repositories specified by `selected_repository_ids` can access the variable.
    "all"|"private"|"selected" visibility;
    # An array of repository ids that can access the organization variable. You can only provide a list of repository ids when the `visibility` is set to `selected`.
    int[] selected_repository_ids?;
};

# Pull Request Reviews are reviews on pull requests.
public type PullRequestReview record {
    # Unique identifier of the review
    int id;
    string node_id;
    # A GitHub user.
    NullableSimpleUser? user;
    # The text of the review.
    string body;
    string state;
    string html_url;
    string pull_request_url;
    Timelinereviewedevent__links _links;
    string submitted_at?;
    # A commit SHA for the review. If the commit object was garbage collected or forcibly deleted, then it no longer exists in Git and this value will be `null`.
    string? commit_id;
    string body_html?;
    string body_text?;
    # How the author is associated with the repository.
    AuthorAssociation author_association;
};

public type Rulesuite_rule_source record {
    # The type of rule source.
    string 'type?;
    # The ID of the rule source.
    int? id?;
    # The name of the rule source.
    string? name?;
};

public type User record {
    string avatar_url?;
    boolean deleted?;
    string? email?;
    string events_url?;
    string followers_url?;
    string following_url?;
    string gists_url?;
    string gravatar_id?;
    string html_url?;
    int id;
    string login;
    string name?;
    string node_id?;
    string organizations_url?;
    string received_events_url?;
    string repos_url?;
    boolean site_admin?;
    string starred_url?;
    string subscriptions_url?;
    "Bot"|"User"|"Organization" 'type?;
    string url?;
};

# Represents an 'issue_body' secret scanning location type. This location type shows that a secret was detected in the body of an issue.
public type SecretScanningLocationIssueBody record {
    # The API URL to get the issue where the secret was detected.
    string issue_body_url;
};

public type Reactions record {
    int \+1;
    int \-1;
    int confused;
    int eyes;
    int heart;
    int hooray;
    int laugh;
    int rocket;
    int total_count;
    string url;
};

# Code Search Result Item
public type CodeSearchResultItemResponse record {
    int total_count;
    boolean incomplete_results;
    CodeSearchResultItem[] items;
};

# A comment made to a gist.
public type GistComment record {
    int id;
    string node_id;
    string url;
    # The comment text.
    @constraint:String {maxLength: 65535}
    string body;
    # A GitHub user.
    NullableSimpleUser? user;
    string created_at;
    string updated_at;
    # How the author is associated with the repository.
    AuthorAssociation author_association;
};

# An object with information about the individual creating the tag.
public type Reposownerrepogittags_tagger record {
    # The name of the author of the tag
    string name;
    # The email of the author of the tag
    string email;
    # When this object was tagged. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    string date?;
};

# Added to Project Issue Event
public type AddedToProjectIssueEvent record {
    int id;
    string node_id;
    string url;
    # A GitHub user.
    SimpleUser actor;
    string event;
    string? commit_id;
    string? commit_url;
    string created_at;
    # GitHub apps are a new way to extend GitHub. They can be installed directly on organizations and user accounts and granted access to specific repositories. They come with granular permissions and built-in webhooks. GitHub apps are first class actors within GitHub.
    NullableIntegration? performed_via_github_app;
    Addedtoprojectissueevent_project_card project_card?;
};

public type Project_id_columns_body record {
    # Name of the project column
    string name;
};

public type Column_id_cards_body record {
    # The project card's note
    string? note;
}|record {
    # The unique identifier of the content associated with the card
    int content_id;
    # The piece of content associated with the card
    string content_type;
};

public type Workflowusage_billable_UBUNTU record {
    int total_ms?;
};

# The REST API URL of the analysis resource.
public type CodeScanningAnalysisUrl string;

public type Pullrequestsimple_labels record {
    int id;
    string node_id;
    string url;
    string name;
    string? description;
    string color;
    boolean default;
};

# Parameters to be used for the tag_name_pattern rule
public type RepositoryRuleTagNamePattern record {
    "tag_name_pattern" 'type;
    Repositoryrulecommitmessagepattern_parameters parameters?;
};

public type Issue_number_comments_body record {
    # The contents of the comment.
    string body;
};

# Contributor Activity
public type ContributorActivity record {
    # A GitHub user.
    NullableSimpleUser? author;
    int total;
    Contributoractivity_weeks[] weeks;
};

public type Repo_forks_body record {
    # Optional parameter to specify the organization name if forking into an organization.
    string organization?;
    # When forking from an existing repository, a new name for the fork.
    string name?;
    # When forking from an existing repository, fork with only the default branch.
    boolean default_branch_only?;
};

# A GitHub Classroom assignment
public type ClassroomAssignment record {
    # Unique identifier of the repository.
    int id;
    # Whether an accepted assignment creates a public repository.
    boolean public_repo;
    # Assignment title.
    string title;
    # Whether it's a group assignment or individual assignment.
    "individual"|"group" 'type;
    # The link that a student can use to accept the assignment.
    string invite_link;
    # Whether the invitation link is enabled. Visiting an enabled invitation link will accept the assignment.
    boolean invitations_enabled;
    # Sluggified name of the assignment.
    string slug;
    # Whether students are admins on created repository when a student accepts the assignment.
    boolean students_are_repo_admins;
    # Whether feedback pull request will be created when a student accepts the assignment.
    boolean feedback_pull_requests_enabled;
    # The maximum allowable teams for the assignment.
    int? max_teams;
    # The maximum allowable members per team.
    int? max_members;
    # The selected editor for the assignment.
    string editor;
    # The number of students that have accepted the assignment.
    int accepted;
    # The number of students that have submitted the assignment.
    int submitted;
    # The number of students that have passed the assignment.
    int passing;
    # The programming language used in the assignment.
    string language;
    # The time at which the assignment is due.
    string? deadline;
    # A GitHub repository view for Classroom
    SimpleClassroomRepository starter_code_repository;
    # A GitHub Classroom classroom
    Classroom classroom;
};

# Community Profile
public type CommunityProfile record {
    int health_percentage;
    string? description;
    string? documentation;
    Communityprofile_files files;
    string? updated_at;
    boolean content_reports_enabled?;
};

public type Client_id_token_body record {
    # The access_token of the OAuth or GitHub application.
    string access_token;
};

public type Discussion_number_comments_body_1 record {
    # The discussion comment's body text.
    string body;
};

public type Teams_team_id_body record {
    # The name of the team.
    string name;
    # The description of the team.
    string description?;
    # The level of privacy this team should have. Editing teams without specifying this parameter leaves `privacy` intact. The options are:  
    # **For a non-nested team:**  
    #  * `secret` - only visible to organization owners and members of this team.  
    #  * `closed` - visible to all members of this organization.  
    # **For a parent or child team:**  
    #  * `closed` - visible to all members of this organization.
    "secret"|"closed" privacy?;
    # The notification setting the team has chosen. Editing teams without specifying this parameter leaves `notification_setting` intact. The options are: 
    #  * `notifications_enabled` - team members receive notifications when the team is @mentioned.  
    #  * `notifications_disabled` - no one receives notifications.
    "notifications_enabled"|"notifications_disabled" notification_setting?;
    # **Deprecated**. The permission that new repositories will be added to the team with when none is specified.
    "pull"|"push"|"admin" permission = "pull";
    # The ID of a team to set as the parent team.
    int? parent_team_id?;
};

public type Run_id_rerunfailedjobs_body record {
    # Whether to enable debug logging for the re-run.
    boolean enable_debug_logging?;
};
