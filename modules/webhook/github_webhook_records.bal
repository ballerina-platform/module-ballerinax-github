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

public type User record {|
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
|};

public type Repository record {|
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
    string created_at;
    string updated_at;
    string pushed_at;
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
|};

public type Page record {|
    string page_name;
    string title;
    string? summary;
    string action;
    string sha;
    string html_url;
|};

public type Issue record {|
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
    string body;
    string? performed_via_github_app;
|};

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

public type Label record {|
    int id;
    string node_id;
    string url;
    string name;
    string color;
    string? description;
    boolean 'default;
|};

public type Milestone record {|
    string url;
    string html_url;
    string labels_url;
    int id;
    string node_id;
    int number;
    string title;
    string description;
    User creator;
    int open_issues;
    int closed_issues;
    string state;
    string created_at;
    string updated_at;
    string due_on;
    string? closed_at;
|};

public type Changes record {|
    Name name?;
    Title title?;
    Body body;
    Color color?;
    Permission permission?;
    Description description?;
    DueOn due_on?;
    Note note?;
|};

public type Title record {|
    string 'from;
|};

public type Body record {|
    string 'from;
|};

public type Name record {|
    string 'from;
|};

public type Color record {|
    string 'from;
|};

public type Permission record {|
    string 'from;
|};

public type Description record {
    string 'from;
};

public type DueOn record {|
    string 'from;
|};

public type Note record {|
    string 'from;
|};

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

public type Branch record {|
    string label;
    string ref;
    string sha;
    User user;
    Repository repo;
|};

public type Links record {|
    SelfLink? selfLink; // issue here; needs to be self
    HtmlLink? html;
    IssueLink? issue;
    CommentsLink? comments;
    ReviewCommentsLink? review_comments;
    ReviewCommentLink? review_comment;
    CommitsLink? commits;
    StatusesLink? statuses;
    PullRequestLink? pull_request;
|};

public type SelfLink record {|
    string href;
|};

public type HtmlLink record {|
    string href;
|};

public type IssueLink record {|
    string href;
|};

public type CommentsLink record {|
    string href;
|};

public type ReviewCommentsLink record {|
    string href;
|};

public type ReviewCommentLink record {|
    string href;
|};

public type CommitsLink record {|
    string href;
|};

public type StatusesLink record {|
    string href;
|};

public type PullRequestLink record {|
    string href;
|};

public type PullRequest record {|
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
    string commits_url;
    string review_comments_url;
    string review_comment_url;
    string comments_url;
    string statuses_url;
    Branch head;
    Branch base;
    Links _links;
    string author_association;
    boolean merged;
    boolean? mergeable;
    boolean? rebaseable;
    string mergeable_state;
    User? merged_by;
    int comments;
    int review_comments;
    boolean maintainer_can_modify;
    int commits;
    int additions;
    int deletions;
    int changed_files;
|};

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
|};

public type Commit record {|
    string sha;
    string message;
    CommitAuthor author;
    string url;
    boolean 'distinct;
|};

public type CommitAuthor record {|
    string name;
    string email;
|};

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

public type HookConfig record {|
    string content_type;
    string secret?;
    string url;
    string insecure_ssl;
|};

public type HookLastResponse record {|
    string? code;
    string status;
    string? message;
|};

public type ForkEvent record {|
    Repository forkee;
    Repository repository;
    User sender;
|};

public type IssueCommentEvent record {|
    string action;
    Issue issue;
    IssueComment comment;
    Repository repository;
    User sender;
|};

public type IssuesEvent record {|
    string action;
    Issue issue;
    Changes changes?;
    Label label?;
    User assignee?;
    Repository repository;
    User sender;
|};

public type LabelEvent record {|
    string action;
    Label label;
    Issue issue;
    Changes changes?;
    Repository repository;
    User sender;
|};

public type MilestoneEvent record {|
    string action;
    Milestone milestone;
    Changes? changes;
    Repository repository;
    User sender;
|};

public type PullRequestEvent record {|
    string action;
    int number;
    Changes changes?;
    PullRequest pull_request;
    Repository repository;
    User sender;
|};

public type PullRequestReviewEvent record {|
    string action;
    Review review;
    PullRequest pull_request;
    Repository repository;
    User sender;
|};

public type PullRequestReviewCommentEvent record {|
    string action;
    Changes changes?;
    PullRequest pull_request;
    PullRequestReviewComment comment;
    Repository repository;
    User sender;
|};

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

public type ReleaseEvent record {|
    string action;
    Release release;
    Repository repository;
    User sender;
    Changes changes;
|};

public type WatchEvent record {|
    string action;
    Repository repository;
    User sender;
|};

public type PingEvent record {|
    string zen;
    int hook_id;
    Hook hook;
    Repository repository;
    User sender;
|};
