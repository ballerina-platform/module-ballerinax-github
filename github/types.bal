//// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
////
//// WSO2 Inc. licenses this file to you under the Apache License,
//// Version 2.0 (the "License"); you may not use this file except
//// in compliance with the License.
//// You may obtain a copy of the License at
////
//// http://www.apache.org/licenses/LICENSE-2.0
////
//// Unless required by applicable law or agreed to in writing,
//// software distributed under the License is distributed on an
//// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//// KIND, either express or implied.  See the License for the
//// specific language governing permissions and limitations
//// under the License.

import ballerina/http;

public type User record {
    boolean anyPinnableItems?;
    string avatarUrl?;
    string? bio?;
    string bioHTML?;
    string? company?;
    string companyHTML?;
    string createdAt?;
    int? databaseId?;
    string email?;
    boolean hasSponsorsListing?;
    string id;
    boolean isBountyHunter?;
    boolean isCampusExpert?;
    boolean isDeveloperProgramMember?;
    boolean isEmployee?;
    boolean isGitHubStar?;
    boolean isSiteAdmin?;
    boolean isViewer?;
    string? location?;
    string login;
    string projectsUrl?;
    string resourcePath?;
    string? twitterUsername?;
    string updatedAt?;
    string url?;
    string? websiteUrl?;
    string? name?;
};

public type RepositoryOwner record {
    string id;
    string login;
    string resourcePath?;
    string url?;
    string avatarUrl?;
};

public type Actor record {
   string login;
   string resourcePath?;
   string url?;
   string avatarUrl?;
};

public type Repository record {
  string createdAt;
  int? databaseId?;
  boolean deleteBranchOnMerge?;
  string? description?;
  string descriptionHTML?;
  int? diskUsage?;
  int forkCount?;
  boolean hasIssuesEnabled?;
  boolean hasProjectsEnabled?;
  boolean hasWikiEnabled?;
  string? homepageUrl?;
  string id;
  boolean isArchived?;
  boolean isBlankIssuesEnabled?;
  boolean isDisabled?;
  boolean isEmpty?;
  boolean isFork?;
  boolean isInOrganization?;
  boolean isLocked?;
  boolean isMirror?;
  boolean isPrivate?;
  boolean? isSecurityPolicyEnabled?;
  boolean isTemplate?;
  boolean isUserConfigurationRepository?;
  boolean mergeCommitAllowed?;
  string? mirrorUrl?;
  string name;
  string nameWithOwner;
  RepositoryOwner owner;
  string projectsResourcePath?;
  string projectsUrl?;
  string? pushedAt?;
  boolean rebaseMergeAllowed?;
  string resourcePath?;
  string? securityPolicy?;
  string sshUrl?;
  int stargazerCount?;
  string? tempCloneToken?;
  string updatedAt?;
  string url?;
  boolean viewerCanAdminister?;
  boolean viewerCanCreateProjects?;
  boolean viewerCanSubscribe?;
};

public type Branch record {
  string id;
  string name;
  string prefix;
};

public type Issue record {
    Actor? author?;
    string body?;
    string bodyHTML?;
    string bodyResourcePath?;
    string bodyText?;
    string bodyUrl?;
    boolean closed?;
    string? closedAt?;
    string createdAt?;
    boolean createdViaEmail?;
    int? databaseId?;
    Actor? editor?;
    string id;
    boolean? isPinned?;
    boolean? isReadByViewer?;
    string? lastEditedAt?;
    boolean locked?;
    int number;
    string? publishedAt?;
    string resourcePath?;
    IssueState state?;
    string title?;
    string updatedAt?;
    string url?;
    boolean viewerDidAuthor?;
    boolean viewerCanUpdate?;
};

public type IssueComment record {
    Actor? author?;
    string body?;
    string bodyHTML?;
    string bodyText?;
    string createdAt?;
    int? databaseId?;
    Actor? editor?;
    string id;
    boolean isMinimized?;
    string? lastEditedAt?;
    string? minimizedReason?;
    string? publishedAt?;
    string url?;
    boolean viewerCanDelete?;
    boolean viewerCanUpdate?;
    boolean viewerDidAuthor?;
};

public type Label record {
    string color?;
    string? createdAt?;
    string? description?;
    string id;
    boolean isDefault?;
    string name;
    string updatedAt?;
    string url?;
};

public type Milestone record {
    string id;
    int number;
    boolean closed?;
    string? closedAt?;
    string createdAt?;
    Actor? creator?;
    string? description?;
    string? dueOn?;
    float progressPercentage?;
    string resourcePath?;
    string title?;
    string updatedAt?;
    string url?;
};

public type PageInfo record {
    string startCursor;
    string endCursor;
    boolean hasNextPage;
    boolean hasPreviousPage;
};

public type Ref record {
    string id;
    string name;
    string prefix;
};

public type PullRequest record {
    int additions?;
    Actor? author?;
    Ref? baseRef?;
    string baseRefName?;
    string body?;
    string bodyHTML?;
    string bodyText?;
    int changedFiles?;
    string checksResourcePath?;
    string checksUrl?;
    boolean closed?;
    string? closedAt?;
    string createdAt?;
    boolean createdViaEmail?;
    int? databaseId?;
    int deletions?;
    Actor? editor?;
    Ref? headRef?;
    string headRefName?;
    RepositoryOwner? headRepositoryOwner?;
    string id;
    boolean isDraft?;
    string? lastEditedAt?;
    boolean locked?;
    boolean merged?;
    Actor? mergedBy?;
    int number;
    string? publishedAt?;
    string resourcePath?;
    string revertUrl?;
    PullRequestState state?;
    string title?;
    string updatedAt?;
    string url?;
};

public enum PullRequestReviewState {
    PR_REVIEW_PENDING = "PENDING",
    PR_REVIEW_COMMENTED = "COMMENTED",
    PR_REVIEW_APPROVED = "APPROVED",
    PR_REVIEW_CHANGES_REQUESTED = "CHANGES_REQUESTED",
    PR_REVIEW_DISMISSED = "DISMISSED"
}

public enum ProjectState {
    PROJECT_OPEN = "OPEN",
    PROJECT_CLOSED = "CLOSED"
}

public type PullRequestReview record {
    string body?;
    string createdAt?;
    string id;
    string? lastEditedAt?;
    string url?;
    PullRequestReviewState state?;
    string? publishedAt?;
};

public type Project record {
    string id;
    string name;
    string? body?;
    boolean closed?;
    string? closedAt?;
    string createdAt?;
    Actor? creator?;
    int? databaseId?;
    int number?;
    ProjectState state?;
    string updatedAt?;
    string url?;
};

public type Organization record {
    string avatarUrl?;
    string? description?;
    string? email?;
    string id;
    string? location?;
    string login;
    string name;
    string projectsResourcePath?;
    string projectsUrl?;
    string resourcePath?;
    string url?;
    string? websiteUrl?;
};

//public type RepositoryList Repository[];
public type RepositoryList record {
    Repository[] nodes;
    PageInfo pageInfo;
    int totalCount;
};
//public type CollaboratorList User[];
public type CollaboratorList record {
    User[] nodes;
    PageInfo pageInfo;
    int totalCount;
};
public type BranchList record {
    Branch[] nodes;
    PageInfo pageInfo;
    int totalCount;
};
public type IssueList record {
    Issue[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

public type IssueCommentList record {
    IssueComment[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

public type LabelList record {
    Label[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

public type MilestoneList record {
    Milestone[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

public type PullRequestList record {
    PullRequest[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

public type PullRequestReviewList record {
    PullRequestReview[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

public type ProjectList record {
    Project[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

public type OrganizationList record {
    Organization[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

public type UserList record {
    User[] nodes;
    PageInfo pageInfo;
    int totalCount;
};


# Represents the Github Client Connector Endpoint configuration.
# + clientConfig - HTTP client endpoint configuration
# + accessToken - The access token of the Github account
public type Configuration record {
    http:ClientConfiguration clientConfig = {};
    string accessToken;
};

public type UpdateRepositoryInput record {
    string clientMutationId?;
    string description?;
    boolean hasIssuesEnabled?;
    boolean hasProjectsEnabled?;
    boolean hasWikiEnabled?;
    string homePageUrl?;
    string name?;
    string repositoryId?;
    boolean template?;
};

public type CreateIssueInput record {
    string repositoryId?;
    string title;
    string body?;
    string[] assigneeIds?;
    string milestoneId?;
    string[] labelIds?;
    string[] projectIds?;
    string issueTemplate?;
    string clientMutationId?;
};

public type UpdateIssueInput record {
    string id?;
    string title?;
    string body?;
    string[] assigneeIds?;
    string milestoneId?;
    string[] labelIds?;
    IssueState state?;
    string[] projectIds?;
    string clientMutationId?;
};

public enum IssueState {
    ISSUE_OPEN="OPEN",
    ISSUE_CLOSED="CLOSED"
}

public type AddCommentInput record {
    string subjectId;
    string body;
    string clientMutationId?;
};

public type UpdateIssueCommentInput record {
    string id;
    string body;
    string clientMutationId?;
};

public type DeleteIssueCommentInput record {
    string id;
    string clientMutationId?;
};

public type CreateLabelInput record {
    string name;
    string description;
    string color;
    string repositoryId;
    string clientMutationId?;
};

public type UpdateLabelInput record {
    string id;
    string name?;
    string description?;
    string color?;
    string clientMutationId?;
};

public type DeleteLabelInput record {
    string id;
    string clientMutationId?;
};

public type AddLabelsToLabelableInput record {
    string labelableId?;
    string[] labelIds?;
    string clientMutationId?;
};

public type RemoveLabelsFromLabelableInput record {
    string labelableId;
    string[] labelIds;
    string clientMutationId?;
};

public type CreatePullRequestInput record {
    string repositoryId?;
    string title;
    string baseRefName;
    string headRefName;
    string body?;
    boolean maintainerCanModify = false;
    boolean draft = false;
    string clientMutationId?;
};

public type UpdatePullRequestInput record {
    string pullRequestId?;
    string baseRefName?;
    string title?;
    string body?;
    PullRequestState state?;
    boolean maintainerCanModify?;
    string[] assigneeIds?;
    string milestoneId?;
    string labelId?;
    string[] projectIds?;
    string clientMutationId?;
};

public enum PullRequestState {
    PULL_REQUEST_OPEN="OPEN",
    PULL_REQUEST_CLOSED="CLOSED"
}

public type AddPullRequestReviewInput record {
    string pullRequestId?;
    string commitOID?;
    string body?;
    PullRequestReviewEvent event?;
    DraftPullRequestReviewComment[] comments?;
    DraftPullRequestReviewThread[] threads?;
    string clientMutationId?;
};

public type DraftPullRequestReviewComment record {
    string path;
    int position;
    string body;
};

public type DraftPullRequestReviewThread record {
    string path;
    int line;
    DiffSide side = DIFF_SIDE_RIGHT;
    int startLine?;
    DiffSide startSide = DIFF_SIDE_RIGHT;
    string body;
};

public enum PullRequestReviewEvent {
    PULL_REQUEST_REVIEW_COMMENT="COMMENT",
    PULL_REQUEST_REVIEW_APPROVE="APPROVE",
    PULL_REQUEST_REVIEW_REQUEST_CHANGES="REQUEST_CHANGES",
    PULL_REQUEST_REVIEW_DISMISS="DISMISS"
}

public enum DiffSide {
    DIFF_SIDE_RIGHT="RIGHT",
    DIFF_SIDE_LEFT="LEFT"
}


public type UpdatePullRequestReviewInput record {
    string pullRequestReviewId;
    string body;
    string clientMutationId?;
};

public type DeletePullRequestReviewInput record {
    string pullRequestReviewId;
    string clientMutationId?;
};


public enum ProjectTemplate {
    PROJECT_TEMPLATE_AUTOMATED_KANBAN_V2 = "AUTOMATED_KANBAN_V2",
    PROJECT_TEMPLATE_AUTOMATED_REVIEWS_KANBAN = "AUTOMATED_REVIEWS_KANBAN",
    PROJECT_TEMPLATE_BASIC_KANBAN = "BASIC_KANBAN",
    PROJECT_TEMPLATE_BUG_TRIAGE = "BUG_TRIAGE"
}

public type CreateProjectInput record {
    string ownerId;
    string name;
    string body?;
    string[] repositoryIds?;
    string clientMutationId?;
    ProjectTemplate template?;
};

public type UpdateProjectInput record {
    string projectId?;
    string body?;
    string name?;
    boolean 'public?;
    ProjectState state?;
    string updateClientMutationId?;
};

public type DeleteProjectInput record {
    string projectId?;
    string clientMutationId?;
};