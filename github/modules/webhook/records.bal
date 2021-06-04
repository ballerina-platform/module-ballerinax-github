//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

# Represent the GitHub User payload.
#
# + login - The username used to login.
# + id - User ID
# + node_id - Node ID
# + avatar_url - A URL pointing to the user's public avatar.
# + gravatar_id - Graveter ID
# + url - The HTTP URL for this user
# + html_url - HTML url
# + followers_url - Followers URL
# + following_url - Following URL
# + gists_url - Gists URL
# + starred_url - Starred URL
# + subscriptions_url - Subscription URL
# + organizations_url - Organization URL
# + repos_url - Repositories URL
# + events_url - Events URL
# + received_events_url - Received events URL.
# + type - User type
# + site_admin - is the user is Site Admin
# + name - Name of the user
# + email - Email of the user.
public type User record {
    string login;
    int id;
    string node_id?;
    string avatar_url;
    string gravatar_id;
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
    string 'type; //"type" in payload
    boolean site_admin;
    string name?;
    string email?;
};

# Represent the GitHub Repository payload.
#
# + id - ID o fthe Repository
# + node_id - Node ID of the repository
# + name - Name of the Repository
# + full_name - Full name of the Repository
# + owner - Owner of the repository
# + private - Is the repository is private
# + html_url - HTML URL of the repository.
# + description - Description of the repository.
# + fork - Is the repository is a fork
# + url - URL of the repository
# + forks_url - Fork URL of the repository.
# + keys_url - Keys URl of the repository
# + collaborators_url - Collaborators URL of the repository
# + teams_url - Teams URL of the repository
# + hooks_url - Hooks URL
# + issue_events_url - Issue events URL
# + events_url - Events URl
# + assignees_url - Assignees URL
# + branches_url - Branches URL
# + tags_url - Tags URL
# + blobs_url - Blobs URL
# + git_tags_url - Git Tags URL
# + git_refs_url - Git Refs URL
# + trees_url - Trees URL
# + statuses_url - Statuses URL
# + languages_url - Languages URL.
# + stargazers_url - Stargazers URL
# + contributors_url - Contributors URL
# + subscribers_url - Subscribers URL
# + subscription_url - Subscription URL.
# + commits_url - Commits URL
# + git_commits_url - Git Commits URL
# + comments_url - Comments URL
# + issue_comment_url - Issue Comments URL
# + contents_url - Contents URL
# + compare_url - Compare URL
# + merges_url - Merges URL
# + archive_url - Archieve URL
# + downloads_url - Downloads URL
# + issues_url - Issues URL
# + pulls_url - Pulls URL
# + milestones_url - Milestone URLs
# + notifications_url - Notification URLs
# + labels_url - Labels URLs
# + releases_url - Releases URL
# + created_at - Created time
# + pushed_at - Pushed time
# + updated_at - Updated time
# + git_url - Git URL
# + ssh_url - SSH URL
# + clone_url - Clone URL
# + svn_url - SVN URL
# + homepage - Home page URL
# + size - Size of the repository 
# + stargazers_count - Stargazers count
# + watchers_count - Watchers count
# + language - Language
# + has_issues - Whether issues are available
# + has_downloads - Whether downloads are available
# + has_wiki - Wther Wikis are available
# + has_pages - Whether GitHub pages available
# + forks_count - Number of forks
# + mirror_url - Mirror URl
# + deployments_url - Deployment URL
# + open_issues_count - Open issues count
# + license - Licence URl
# + forks - Forks
# + open_issues - Open Issues
# + watchers - Watches
# + default_branch - Default branch
# + archived - Whether archieved
# + disabled - Whether disabled
# + has_projects - Whether includes projects
# + allow_squash_merge - Whether allow squash and merge
# + allow_merge_commit - Whether allow merge commits
# + allow_rebase_merge - Whether allow rebase merge
# + delete_branch_on_merge - Whether delete branch on merge
# + stargazers - Stargazers
# + master_branch - Refrence to master branch
public type Repository record {
    int id;
    string node_id;
    string name;
    string full_name;
    User owner;
    boolean 'private; //"private" in payload
    string html_url;
    string? description;
    boolean 'fork;
    string url;
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
    string|int created_at;
    string updated_at;
    string|int pushed_at;
    string git_url;
    string ssh_url;
    string clone_url;
    string svn_url;
    string? homepage;
    int size;
    int stargazers_count;
    int watchers_count;
    string? language;
    boolean has_issues;
    boolean has_downloads;
    boolean has_wiki;
    boolean has_pages;
    int forks_count;
    string? mirror_url;
    string deployments_url?;
    int open_issues_count;
    string? license;
    int forks;
    int open_issues;
    int watchers;
    string default_branch;
    boolean archived?;
    boolean disabled?;
    boolean has_projects?;
    boolean allow_squash_merge?;
    boolean allow_merge_commit?;
    boolean allow_rebase_merge?;
    boolean delete_branch_on_merge?;
    int stargazers?;
    string master_branch?;
};

# Represents the Page payload.
#
# + page_name - Name of the page
# + title - Title of the page
# + summary - Summery
# + action - Action
# + sha - Sha of the page
# + html_url - HTML URL of the page
public type Page record {|
    string page_name;
    string title;
    string? summary;
    string action;
    string sha;
    string html_url;
|};

# Represents the GitHub Issue payload.
#
# + url - Url of the payload
# + repository_url - Repository URl
# + labels_url - Labels URl
# + comments_url - Comments URl
# + events_url - Events URL
# + html_url - HTML URL
# + id - ID
# + node_id - Node ID
# + number - Issue number
# + title - Issue title
# + user - Author of the issue
# + labels - Labels assigned to the issue
# + state - State of the issue.
# + locked - Whether the issue is locked
# + assignee - Assigne of the issue.
# + assignees - Assignes of the issue.
# + milestone - Milestone of the issue
# + comments - Comments for the issue
# + created_at - Created at date time
# + updated_at - Updated date time
# + closed_at - Closed date time
# + author_association - Author associations
# + active_lock_reason - Active lock reasons
# + body - Description of the Issue
# + performed_via_github_app -
public type Issue record {
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
    User user;
    Label[] labels;
    string state;
    boolean locked;
    User? assignee;
    User[] assignees;
    Milestone? milestone;
    int comments;
    string created_at;
    string updated_at;
    string? closed_at;
    string author_association;
    string? active_lock_reason;
    string? body;
    string? performed_via_github_app;
};

# Represents the GitHub issue comment payload
#
# + url - Issue comment url
# + html_url - HTML url for the issue comment
# + issue_url - Issue URL
# + id - ID
# + node_id - Node ID
# + user - Author of the comment
# + created_at -  Created date time
# + updated_at - Updated date time
# + author_association - Author association
# + body - Description of the issue comment
# + performed_via_github_app - Whether performed via GitHub Apps
public type IssueComment record {|
    string url;
    string html_url;
    string issue_url;
    int id;
    string node_id;
    User user;
    string created_at;
    string updated_at;
    string author_association;
    string body;
    string? performed_via_github_app;
|};

# Represents the GitHub Label payload.
#
# + id - Label ID
# + node_id - Node ID of the label
# + url - Label URL
# + name - Name of the label
# + color - Color of the label
# + description - Description of the label
# + default - Whether a default label
public type Label record {
    int id;
    string node_id;
    string url;
    string name;
    string color;
    string? description;
    boolean 'default;
};

# Represents the GitHub Milestone payload.
#
# + url - Milestone URL
# + html_url - HTML URL
# + labels_url - Lables URL
# + id - ID
# + node_id - Node ID
# + number - Milestone number
# + title - Title of the milestone
# + description - Description of the milestone
# + creator - Author of the milestone
# + open_issues - Number of open issues
# + closed_issues - Number of closed issues
# + state - State of the milestone
# + created_at - Created date time
# + updated_at - Updated date time
# + due_on - Due of date time
# + closed_at - Closed date time
public type Milestone record {
    string url;
    string html_url;
    string labels_url;
    int id;
    string node_id;
    int number;
    string title;
    string? description;
    User creator;
    int open_issues;
    int closed_issues;
    string state;
    string created_at;
    string updated_at;
    string? due_on;
    string? closed_at;
};

# Represents the Change payload.
#
# + name - Name of the Change
# + title - Title of the Change
# + body - Body of the Change
# + color - Color of the Change
# + permission - Permission of the Change
# + description - Description of the Change
# + due_on - Due on date time
# + note - Notes of the Change
public type Changes record {
    Name name?;
    Title title?;
    Body body?;
    Color color?;
    Permission permission?;
    Description description?;
    DueOn due_on?;
    Note note?;
};

# Represents the title of a Change
#
# + from - From reference 
public type Title record {|
    string 'from;
|};

# Represents body of a Change occured
#
# + from - From reference
public type Body record {|
    string 'from;
|};

# Represents name of a Change occured
#
# + from - From reference
public type Name record {|
    string 'from;
|};

# Represents color of a Change occured
#
# + from - From reference
public type Color record {|
    string 'from;
|};

# Represents permission of a Change occured
#
# + from - From reference
public type Permission record {|
    string 'from;
|};

# Represents description of a Change occured
#
# + from - From reference
public type Description record {
    string 'from;
};

# Represents due on of a Change occured
#
# + from - From reference
public type DueOn record {|
    string 'from;
|};

# Represents note of a Change occured
#
# + from - From reference
public type Note record {|
    string 'from;
|};

# Represent Team payload.
#
# + name - Name of the Team
# + id - ID
# + node_id - Node ID
# + slug - Slug of the Team
# + description - Description of the Team
# + privacy - Privacy link of the Team
# + url - URL of the Team
# + members_url - Members URL of the team
# + repositories_url - Repositories URL of the Team
# + permission - Permissions of the Team
public type Team record {|
    string name;
    int id;
    string node_id;
    string slug;
    string? description;
    string privacy;
    string url;
    string members_url;
    string repositories_url;
    string permission;
|};

# Represents the payload of an Organization
#
# + login - Login name of the Organization
# + id - ID of the organization
# + node_id - Node ID
# + url - URL of the organization
# + name - Name of the organization
# + repos_url - Reposiotries URL
# + events_url - Events URL
# + hooks_url - Hooks URL
# + issues_url - Issues URL
# + members_url - Members URl
# + public_members_url - Public members URl
# + avatar_url - Avatar URl
# + description - Description URL
public type Organization record {|
    string login;
    int id;
    string node_id;
    string url;
    string name;
    string repos_url;
    string events_url;
    string hooks_url;
    string issues_url;
    string members_url;
    string public_members_url;
    string avatar_url;
    string? description;
|};

# Represent the payload of GitHub Invitation
#
# + id - ID
# + login - Login name for Invitation
# + email - Email of the Invitation
# + role - Role of the Invitation
# + created_at - Created date time
# + inviter - Inviter 
# + team_count - Team count
# + invitation_team_url - Invitation team url
public type Invitation record {|
    int id;
    string login;
    string email;
    string role;
    string created_at;
    User inviter;
    int team_count;
    string invitation_team_url;
|};

# Represent the payload of GitHub Branch
#
# + label - Label name
# + ref - Reference link
# + sha - Sha of the branch
# + user - Auther of the branch
# + repo - Repository name
public type Branch record {|
    string label;
    string ref;
    string sha;
    User user;
    Repository repo;
|};

# Represent the payload of Github Links
#
# + self - Self link
# + html - Html Link
# + issue - Issue link
# + comments - Comments link
# + review_comments - Review comments link
# + review_comment - Review comment
# + commits - Commits 
# + statuses - Statuses
# + pull_request - Pull request
public type Links record {|
    SelfLink 'self?;
    HtmlLink html?;
    IssueLink issue?;
    CommentsLink comments?;
    ReviewCommentsLink review_comments?;
    ReviewCommentLink review_comment?;
    CommitsLink commits?;
    StatusesLink statuses?;
    PullRequestLink pull_request?;
|};

# Represent self link of GitHub Link
#
# + href - Hyper-reference of the Link 
public type SelfLink record {|
    string href;
|};

# Represent html link of GitHub Link
#
# + href - Hyper-reference of the Link
public type HtmlLink record {|
    string href;
|};

# Represent issue link of GitHub Link
#
# + href - Hyper-reference of the Link
public type IssueLink record {|
    string href;
|};

# Represent comments link of GitHub Link
#
# + href - Hyper-reference of the Link
public type CommentsLink record {|
    string href;
|};

# Represent review comments link of GitHub Link
#
# + href - Hyper-reference of the Link
public type ReviewCommentsLink record {|
    string href;
|};

# Represent a review comment link of GitHub Link
#
# + href - Hyper-reference of the Link
public type ReviewCommentLink record {|
    string href;
|};

# Represent commits link of GitHub Link
#
# + href - Hyper-reference of the Link
public type CommitsLink record {|
    string href;
|};

# Represent statuses link of GitHub Link
#
# + href - Hyper-reference of the Link
public type StatusesLink record {|
    string href;
|};

# Represent pull request link of GitHub Link
#
# + href - Hyper-reference of the Link
public type PullRequestLink record {|
    string href;
|};

# Represent payload of GitHub payload.
#
# + url - Pull request URL
# + id - ID
# + node_id - Node ID
# + html_url - Html Url
# + diff_url - Diff URL
# + patch_url - Patch URl 
# + issue_url - Issues URL
# + number - Pull Request number
# + state - State of the PR
# + locked - Whether merge locked
# + title - Title of the Pull Request
# + user - Auther of the Pull Request
# + body - Body of the pull request
# + created_at - Created date time
# + updated_at - Updated date time
# + closed_at - Closed date time
# + merged_at - Merged date time
# + merge_commit_sha - Merge commit sha
# + assignee - Assignee of the PR
# + assignees - Assignees of the PR
# + requested_reviewers - Requested reviewers list
# + requested_teams - Requested Items
# + labels - Labels list
# + milestone - Milestone of the PR
# + draft -  Whether the PR is a draft
# + commits_url - Commits URL of the PR
# + review_comments_url - Revew comments URL of the PR
# + review_comment_url - Review comment URL
# + comments_url - Comments URL
# + statuses_url - Statuses URL
# + head - Head ref of the PR
# + base - base Ref of the PR
# + _links - Links of the Pr
# + author_association - Author association
# + merged - Whether the PR is merged
# + mergeable - Whether the PR is mergeable
# + rebaseable - Whether the PR is rebaseble
# + mergeable_state - Mergeable state of the PR
# + merged_by - Merged User
# + comments - List of comments
# + review_comments - Review comments
# + maintainer_can_modify - Whether maintainer can modify the PR
# + commits - Commits
# + additions - Addition changes
# + deletions - Deletion changes
# + changed_files - Change files references
# + active_lock_reason - Active lock reason
public type PullRequest record {
    string url;
    int id;
    string node_id;
    string html_url;
    string diff_url;
    string patch_url;
    string? issue_url;
    int number;
    string state;
    boolean locked;
    string title;
    User user;
    string? body;
    string created_at;
    string updated_at;
    string? closed_at;
    string? merged_at;
    string? merge_commit_sha;
    User? assignee;
    User[] assignees;
    User[] requested_reviewers;
    Team[] requested_teams;
    Label[] labels;
    Milestone? milestone;
    boolean draft;
    string commits_url;
    string review_comments_url;
    string review_comment_url;
    string comments_url;
    string statuses_url;
    Branch head;
    Branch base;
    Links _links;
    string author_association;
    boolean merged?;
    boolean? mergeable?;
    boolean? rebaseable?;
    string mergeable_state?;
    User? merged_by?;
    int comments?;
    int review_comments?;
    boolean maintainer_can_modify?;
    int commits?;
    int additions?;
    int deletions?;
    int changed_files?;
    string? active_lock_reason;
};

# Represents GitHub Review payload.
#
# + id - ID of the Review
# + node_id - Node ID
# + user - Auther of the review
# + body - Body of the review
# + commit_id - Commit
# + submitted_at - Submitted date time
# + state - State of the review
# + html_url - HTML of the Review
# + pull_request_url - Pull request URL
# + author_association - Author association
# + _links - Links associations
public type Review record {|
    int id;
    string node_id;
    User user;
    string? body;
    string commit_id;
    string submitted_at;
    string state;
    string html_url;
    string pull_request_url;
    string author_association;
    Links _links;
|};

# Represent GitHub pull request review comment payload.
#
# + url - URL of the pull request review commment
# + pull_request_review_id - Pull Request review id
# + id - ID
# + node_id - Node ID
# + diff_hunk - Diff hunk of the PR review
# + path - Path for the Pull Request Review Comment
# + position - Position of the Review
# + original_position - Original posiiton of the Change
# + commit_id - Commit ID of the PR
# + original_commit_id - Original commit id
# + user - Author of the Pull Request Review
# + body - Body of the Pull Request Review
# + created_at - Created date time
# + updated_at - Updated date time
# + html_url - HTML url for the review
# + pull_request_url - URL for the Pull Request
# + author_association - Author association
# + _links - Links associates
# + start_line - Start line number of the review
# + original_start_line - Original start line
# + start_side - Start side of the review
# + line - Line number
# + original_line - Original line
# + side - Side of the Pull Request Review
# + in_reply_to_id - Reply to the PR ID
public type PullRequestReviewComment record {|
    string url;
    int pull_request_review_id;
    int id;
    string node_id;
    string diff_hunk;
    string path;
    int position;
    int original_position;
    string commit_id;
    string original_commit_id;
    User user;
    string body;
    string created_at;
    string updated_at;
    string html_url;
    string pull_request_url;
    string author_association;
    Links _links;
    string? start_line;
    string? original_start_line;
    string? start_side;
    int line;
    int original_line;
    string side;
    int in_reply_to_id?;
|};

# Represent GitHub commit payload.
#
# + id - ID
# + sha - Commit sha
# + message - Commit message
# + author - Author of the commit
# + url - Commit URL
# + distinct - Whether the commit is distinct
# + committer - Commit author
# + tree_id - Tree Id
# + timestamp - Timestamp of the commit
# + added - Added changes
# + removed - Removed parts 
# + modified - Modified parts
public type Commit record {|
    string id?;
    string sha?;
    string message;
    CommitAuthor author;
    string url;
    boolean 'distinct;
    CommitAuthor committer?;
    string tree_id?;
    string timestamp?;
    string[] added?;
    string[] removed?;
    string[] modified?;
|};

# Represent payload of GitHub commit author.
#
# + name - Name of the commit author
# + email - Email of the commit author
# + username - GitHub username of the commit author
public type CommitAuthor record {|
    string name;
    string email;
    string username?;
|};

# Represent GitHub Release payload.
#
# + url - Release URL
# + assets_url - Assets URL
# + upload_url - Upload URL 
# + html_url - HTML URL
# + id - ID
# + node_id - Node ID
# + tag_name - Tag name
# + target_commitish - Target commitsh
# + name - Name of the release
# + draft - Whether release is in draft state
# + author - Author of the release
# + prerelease - Whether release is a pre-release
# + created_at - Created date time
# + published_at - Published date time
# + assets - Release artifacts
# + tarball_url - Tarball URL
# + zipball_url - Zipball URL
# + body - Release body
public type Release record {|
    string url;
    string assets_url;
    string upload_url;
    string html_url;
    int id;
    string node_id;
    string tag_name;
    string target_commitish;
    string? name;
    boolean draft;
    User author;
    boolean prerelease;
    string created_at;
    string published_at;
    Asset[] assets;
    string tarball_url;
    string zipball_url;
    string? body;
|};

# Represent GitHub Asset payload.
#
# + url - Asset URL 
# + browser_download_url - Download URL for assets
# + id - Asset ID
# + node_id - Node ID
# + name - Name of the Asset
# + label - Label name
# + state - State of the assets
# + content_type - Content-Type of the Asset
# + size - Size of the asset
# + download_count - Downloaded count
# + created_at - Created date time
# + updated_at - Updated date time
# + uploader - Uploaded user
public type Asset record {|
    string url;
    string browser_download_url;
    int id;
    string node_id;
    string name;
    string? label;
    string state;
    string content_type;
    int size;
    int download_count;
    string created_at;
    string updated_at;
    User uploader;
|};

# Represent GitHub Hook payload.
#
# + type - Type of the Hook
# + id - ID
# + name - Name of the Hook
# + active - Whether the Hook is active
# + events - Events associated with the Hook
# + config - Hook configuration
# + updated_at - Updated date time
# + created_at - Created date time
# + url - Hook URL
# + test_url - test URL
# + ping_url - Ping URL
# + last_response - Last Hook response
public type Hook record {|
    string 'type;
    int id;
    string name;
    boolean active;
    string[] events;
    HookConfig config;
    string updated_at;
    string created_at;
    string url;
    string test_url;
    string ping_url;
    HookLastResponse last_response;
|};

# Represent GitHub Hook config payload.
#
# + content_type - Content Type of the Hook request
# + secret - Hook secret
# + url - Hook registration URL
# + insecure_ssl - Insecure SSL
public type HookConfig record {|
    string content_type;
    string secret?;
    string url;
    string insecure_ssl;
|};

# Represent GitHub Hook last response.
#
# + code - Code associated with HookLastResponse
# + status - Hook status
# + message - Hook message
public type HookLastResponse record {|
    string? code;
    string status;
    string? message;
|};

# Represent GitHub fork event.
#
# + forkee - Forkee repository
# + repository - Fork repository
# + sender - Fork send user
public type ForkEvent record {|
    Repository forkee;
    Repository repository;
    User sender;
|};

# Repesent GitHub issue comment event.
#
# + action - Issue comment event action
# + issue - Associated issue.
# + changes - Changes associated to the Issue comment
# + comment - Comment
# + repository - Issue comment associated repository
# + sender - Issue comment send user
public type IssueCommentEvent record {|
    IssueCommentActions action;
    Issue issue;
    Changes changes?;
    IssueComment comment;
    Repository repository;
    User sender;
|};

# Represent GitHub issue event.
#
# + action -Issue event action
# + issue - Issue associated 
# + changes - Changes associated with the issue
# + label - Label of the issue event
# + assignee - assignee of the issue event
# + milestone - Milestone associated with
# + repository - Repository of the issue events
# + sender - User associated with issue event
public type IssuesEvent record {|
    IssuesActions action;
    Issue issue;
    Changes changes?;
    Label label?;
    User assignee?;
    Milestone milestone?;
    Repository repository;
    User sender;
|};

# Repesent GitHub label event.
#
# + action - Label event action
# + label - Label payload
# + issue - Issue associated with
# + changes - Changes associated with
# + repository - Repository associated with
# + sender - Sender of the label event
public type LabelEvent record {|
    LabelActions action;
    Label label;
    Issue issue?;
    Changes changes?;
    Repository repository;
    User sender;
|};

# Represent GitHub milestone event.
#
# + action - Milestone event action
# + milestone - Milestone payload
# + changes - Changes associated with 
# + repository - Repository associated with
# + sender - Sender of the label event
public type MilestoneEvent record {|
    MilestoneActions action;
    Milestone milestone;
    Changes changes?;
    Repository repository;
    User sender;
|};

# Represent GitHub Pull request event
#
# + action - Pull Request Event action
# + number - Pull request number
# + changes - Changes associated with
# + pull_request - Pull Request payload
# + assignee - Associated assignee to the Pull Request
# + label - Labels associated with
# + requested_reviewer - Requested reviewer 
# + repository - Repository associated with
# + sender - Pull request sender
public type PullRequestEvent record {
    PullRequestActions action;
    int number;
    Changes changes?;
    PullRequest pull_request;
    User assignee?;
    Label label?;
    User requested_reviewer?;
    Repository repository;
    User sender;
};

# Represent GitHub pull request review event.
#
# + action - Pull Request Review Event action
# + review - Pull Request Review payload.
# + pull_request - Pull Request associated with
# + changes - Changes associated with
# + repository - Repository associated with
# + sender - Sender associated with
public type PullRequestReviewEvent record {|
    PullRequestReviewActions action;
    Review review;
    PullRequest pull_request;
    Changes changes?;
    Repository repository;
    User sender;
|};

# Represent GitHub pull request review comment event.
#
# + action - Pull request review comment event action
# + changes - Changes associated with
# + pull_request - Pull request associated with
# + comment - Comments associated with
# + repository - Repository associated with
# + sender - Pull request review comment sender
public type PullRequestReviewCommentEvent record {|
    string action;
    Changes changes?;
    PullRequest pull_request;
    PullRequestReviewComment comment;
    Repository repository;
    User sender;
|};

# Represent GitHub push event
#
# + ref - The full git ref that was pushed. Example: 
# + before - The SHA of the most recent commit on ref before the push.
# + after - The SHA of the most recent commit on ref after the push.
# + created - Created date time
# + deleted - Deleted date time
# + forced - Forced psuh
# + base_ref - Base git ref
# + compare - Comparison
# + commits - Array of commits
# + head_commit - Head ref commit
# + repository - The repository where the event occurred.
# + pusher - The user who pushed the commits.
# + sender - The user that triggered the event.
public type PushEvent record {|
    string ref;
    string before;
    string after;
    boolean created;
    boolean deleted;
    boolean forced;
    string? base_ref;
    string compare;
    Commit[] commits;
    Commit? head_commit;
    Repository repository;
    CommitAuthor pusher;
    User sender;
|};

# Represent GitHub release event.
#
# + action - The action that was performed.
# + release - The release object.
# + repository - The repository where the event occurred.
# + sender - The user that triggered the event.
# + changes - The previous version of the body if the action was edited.
public type ReleaseEvent record {
    ReleaseActions action;
    Release release;
    Repository repository;
    User sender;
    Changes changes?;
};

# Represent GitHub watch event.
#
# + action - The action that was performed. Currently, can only be started.
# + repository - The repository where the event occurred.
# + sender - The user that triggered the event.
public type WatchEvent record {|
    WatchActions action;
    Repository repository;
    User sender;
|};

# Represent GitHub ping event.
#
# + zen - Random string of GitHub zen.
# + hook_id - The ID of the webhook that triggered the ping.
# + hook - The webhook configuration.
# + repository - The repository where the event occurred.
# + sender - The user that triggered the event.
public type PingEvent record {|
    string zen;
    int hook_id;
    Hook hook;
    Repository repository;
    User sender;
|};

# Represent GitHub create event.
#
# + ref - The git ref resource.
# + ref_type - The type of Git ref object created in the repository. Can be either branch or tag.
# + master_branch - The name of the repository's default branch (usually main).
# + description - The repository's current description.
# + repository - The repository where the event occurred.
# + organization - Webhook payloads contain the organization object when the webhook is configured for an organization or the event occurs from activity in a repository owned by an organization.
# + sender - The user that triggered the event.
public type CreateEvent record {
    string ref;
    string ref_type;
    string master_branch;
    string? description;
    Repository repository;
    Organization organization?;
    User sender;
};

# Represent all events from GitHub.
public type GitHubEvent PingEvent|WatchEvent|ReleaseEvent|PushEvent|PullRequestReviewCommentEvent
                        |PullRequestReviewEvent|PullRequestEvent|ForkEvent|IssueCommentEvent|IssuesEvent|LabelEvent
                        |MilestoneEvent|CreateEvent;

# Represent issue event action types.
#
# + ISSUE_OPENED - Issue opened
# + ISSUE_ASSIGNED - Issue assigned
# + ISSUE_UNASSIGNED - Issued unassigned
# + ISSUE_LABELED - Issue labeled
# + ISSUE_UNLABELED - Issue un-labeled
# + ISSUE_EDITED - Issue edited
# + ISSUE_MILESTONED - Issue milestoned
# + ISSUE_DEMILESTONED - Issue de-milestoned
# + ISSUE_CLOSED - Issue closed
# + ISSUE_REOPENED - Issue re-opened
public enum IssuesActions {
    ISSUE_OPENED = "opened",
    ISSUE_ASSIGNED = "assigned",
    ISSUE_UNASSIGNED = "unassigned",
    ISSUE_LABELED = "labeled",
    ISSUE_UNLABELED = "unlabeled",
    ISSUE_EDITED = "edited",
    ISSUE_MILESTONED = "milestoned",
    ISSUE_DEMILESTONED = "demilestoned",
    ISSUE_CLOSED = "closed",
    ISSUE_REOPENED = "reopened"
}
# Represent label event action types.
#
# + LABEL_CREATED - Label created
# + LABEL_EDITED - Label edited
# + LABEL_DELETED - Label deleted
public enum LabelActions {
    LABEL_CREATED = "created",
    LABEL_EDITED = "edited",
    LABEL_DELETED = "deleted"
}

# Represent issue comment event action types.
#
# + ISSUE_COMMENT_CREATED - Issue comment created
# + ISSUE_COMMENT_EDITED - Issue comment edited
# + ISSUE_COMMENT_DELETED - Issue comment deleted
public enum IssueCommentActions {
    ISSUE_COMMENT_CREATED = "created",
    ISSUE_COMMENT_EDITED = "edited",
    ISSUE_COMMENT_DELETED = "deleted"
}

# Represent milestone event action types.
#
# + MILESTONE_CREATED - Milestone created
# + MILESTONE_CLOSED - Milestone closed
# + MILESTONE_OPENED - Milestone opened
# + MILESTONE_EDITED - Milestone edited
# + MILESTONE_DELETED - Milestone deleted
public enum MilestoneActions {
    MILESTONE_CREATED = "created",
    MILESTONE_CLOSED = "closed",
    MILESTONE_OPENED = "opened",
    MILESTONE_EDITED = "edited",
    MILESTONE_DELETED = "deleted"
}

# Represent pull request event action types.
#
# + PULL_REQUEST_ASSIGNED - Pull request assigned
# + PULL_REQUEST_UNASSIGNED - Pull request un-assigned
# + PULL_REQUEST_REVIEW_REQUESTED - Pull request review requested
# + PULL_REQUEST_REVIEW_REQUEST_REMOVED - Pull request review request removed
# + PULL_REQUEST_LABELED - Pull request labeled
# + PULL_REQUEST_UNLABELED - Pull request un-labeled
# + PULL_REQUEST_OPENED - Pull request opened
# + PULL_REQUEST_EDITED - Pull request edited
# + PULL_REQUEST_CLOSED - Pull request closed
# + PULL_REQUEST_REOPENED - Pull request re-opened
public enum PullRequestActions {
    PULL_REQUEST_ASSIGNED = "assigned",
    PULL_REQUEST_UNASSIGNED = "unassigned",
    PULL_REQUEST_REVIEW_REQUESTED = "review_requested",
    PULL_REQUEST_REVIEW_REQUEST_REMOVED = "review_request_removed",
    PULL_REQUEST_LABELED = "labeled",
    PULL_REQUEST_UNLABELED = "unlabeled",
    PULL_REQUEST_OPENED = "opened",
    PULL_REQUEST_EDITED = "edited",
    PULL_REQUEST_CLOSED = "closed",
    PULL_REQUEST_REOPENED = "reopened"
}

# Represent pull request review event action types.
#
# + PULL_REQUEST_REVIEW_SUBMITTED - Pull request review submitted
# + PULL_REQUEST_REVIEW_EDITED - Pull request review edited
# + PULL_REQUEST_REVIEW_DISMISSED - Pull request review dismissed
public enum PullRequestReviewActions {
    PULL_REQUEST_REVIEW_SUBMITTED = "submitted",
    PULL_REQUEST_REVIEW_EDITED = "edited",
    PULL_REQUEST_REVIEW_DISMISSED = "dismissed"
}

# Represent pull request review comment event action types.
#
# + PULL_REQUEST_REVIEW_COMMENT_CREATED - Pull request review comment created
# + PULL_REQUEST_REVIEW_COMMENT_EDITED - Pull request reveiw comment edited
# + PULL_REQUEST_REVIEW_COMMENT_DELETED - Pull request review comment deleted
public enum PullRequestReviewCommentActions {
    PULL_REQUEST_REVIEW_COMMENT_CREATED = "created",
    PULL_REQUEST_REVIEW_COMMENT_EDITED = "edited",
    PULL_REQUEST_REVIEW_COMMENT_DELETED = "deleted"
}

# Represent release event action types.
#
# + RELEASE_PUBLISHED - Released published
# + RELEASE_UNPUBLISHED - Release un-published
# + RELEASE_CREATED - Release created
# + RELEASE_EDITED - Release edited
# + RELEASE_DELETED - Release deleted
# + RELEASE_PRE_RELEASED - Release pre-released.
# + RELEASE_RELEASED - Release released.
public enum ReleaseActions {
    RELEASE_PUBLISHED = "published",
    RELEASE_UNPUBLISHED = "unpublished",
    RELEASE_CREATED = "created",
    RELEASE_EDITED = "edited",
    RELEASE_DELETED = "deleted",
    RELEASE_PRE_RELEASED = "prereleased",
    RELEASE_RELEASED = "released"
}

# Represent watch event action types.
#
# + WATCH_STARTED - Watch started 
public enum WatchActions {
    WATCH_STARTED = "started"
}

# Represent event Payload
#
# + eventType - Event type.
# + eventData - Event data.
public type Payload record {|
    string eventType;
    json eventData;
|};

# Represent event startup message.
#
# + hubName - Hub name
# + subscriberId - Subscriber Id
public type StartupMessage record {
    string hubName;
    string subscriberId;
};

# Represent event notification payload.
#
# + hubName - Hub name
# + eventId - Event Id
# + message - Message
public type EventNotification record {
    string hubName;
    string eventId;
    string message;
};

# Represent common response payload.
#
# + headers - Headers
# + body - Body
type CommonResponse record {|
    map<string|string[]> headers?;
    map<string> body?;
|};

# Represent webhook acknowledgement
public type Acknowledgement record {
    *CommonResponse;
};