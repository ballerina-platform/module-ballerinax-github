// Copyright (c) 2018, WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
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

import ballerina/test;
import ballerina/os;

// Configurables
configurable boolean isLiveServer = false;
configurable string serviceUrl = isLiveServer ? "https://api.github.com" : string `http://localhost:${MOCK_SERVICE_PORT}`;
configurable string testOrganizationName = isLiveServer ? os:getEnv("ORG_NAME") : "test-org";
configurable string testUserRepositoryName = isLiveServer ? os:getEnv("REPO_NAME") : "test-repo";
configurable string testResourcePath = isLiveServer ? os:getEnv("RESOURCE_PATH") : "/test/path";
configurable string testIssueAssignee = isLiveServer ? os:getEnv("ASSIGNEE") : "testUser";
configurable string testUsername = isLiveServer ? os:getEnv("USERNAME") : "testUser";
configurable string authToken = isLiveServer ? os:getEnv("ACCESS_TOKEN") : "mock-token";
configurable string testTopicName = "language";
configurable string testGistName = "5a648dc78fd2d402ec484e2663282e6f";

// Constants
const REPO_BASE_URL = "https://api.github.com/repos/connector-ecosystem/github-connector/contents";
const REPO_FILE_PATH = "/src/db/resources/info1.txt";
const MASTER_BRANCH = "master";
const NEW_FEATURE_BRANCH = "feature/newFeature";
const LATEST_MASTER_COMMIT_HASH = "9e7ce2f52536e7c5b90f8fee35f129fb14d1631f";
const TEST_REPO_NAME = "ballerina-github-connector-test-repo";
string NEW_FEATURE_BRANCH_HEAD = string `heads/${NEW_FEATURE_BRANCH}`;
string NEW_FEATURE_BRANCH_REF = string `refs/${NEW_FEATURE_BRANCH_HEAD}`;

// Variables to hold intermediate results
int milestoneNumber = 2;
int fetchedProjectId = -1;
int fetchedProjectNumber = -1;
int createdIssueId = -1;
int createdIssueNumber = -1;
int createdIssueCommentId = -1;
int createdPullRequestId = -1;
int createdPullRequestNumber = -1;
int createdPullRequestReviewId = -1;
int createdPullRequestReviewIdWithPendingState = -1;

ConnectionConfig gitHubConfig = {
    auth: {
        token: authToken
    }
};
Client github = check new (gitHubConfig, serviceUrl);

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetUser() returns error? {
    UserResponse? response = check github->/user();
    if response is UserResponse {
        test:assertEquals(response.login, testUsername);
    } else {
        test:assertFail("Expected non-empty response from /user endpoint, but received ()");
    }
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetUserWithGivenUsername() returns error? {
    UserResponse response = check github->/users/[testUsername];
    test:assertEquals(response.login, testUsername);
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetRepository() returns error? {
    FullRepository response = check github->/repos/[testUsername]/[testUserRepositoryName];
    test:assertEquals(response.name, testUserRepositoryName);
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetRepositories() returns error? {
    Repository[]? response = check github->/user/repos();
    test:assertTrue(response is Repository[]);
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetRepositoriesOfGivenUser() returns error? {
    MinimalRepository[] response = check github->/users/[testUsername]/repos();
    test:assertTrue(response[0] is MinimalRepository);
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetRepositoriesOfGivenOrganization() returns error? {
    MinimalRepository[] response = check github->/orgs/[testOrganizationName]/repos();
    test:assertTrue(response[0] is MinimalRepository);
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetCollaborators() returns error? {
    Collaborator[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/collaborators();
    test:assertTrue(response[0] is Collaborator);
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testgetBranches() returns error? {
    ShortBranch[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/branches();
    test:assertTrue(response[0] is ShortBranch);
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testCreateRepository() returns error? {
    UserReposBody body = {
        name: TEST_REPO_NAME,
        description: "New Test Repo Description"
    };
    Repository? response = check github->/user/repos.post(body);
    test:assertEquals(response?.name, TEST_REPO_NAME);
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testCreateRepository]
}
function testUpdateRepository() returns error? {
    OwnerrepoBody1 body = {
        description: "New Updated Description"
    };
    FullRepository response = check github->/repos/[testUsername]/[TEST_REPO_NAME].patch(body);
    test:assertEquals(response.name, TEST_REPO_NAME);
    test:assertEquals(response.description, "New Updated Description");
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testUpdateRepository]
}
function testDeleteRepository() returns error? {
    check github->/repos/[testUsername]/[TEST_REPO_NAME].delete();
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetMilestone() returns error? {
    Milestone milestone = check github->/repos/[testUsername]/[testUserRepositoryName]/milestones/[milestoneNumber]();
    test:assertTrue(milestone.number == milestoneNumber);
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetMilestones() returns error? {
    Milestone[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/milestones();
    test:assertTrue(response[0] is Milestone);
}

// ----------NOTE----------
// The project created by this test case will no be deleted.
// Instead an already created project will be updated and deleted.
// The reason is Github seems to be adding project async mannger.
// Sometimes immediate call does not return the project when we try to get the created project.
// TODO: Re-enable `testCreateUserProject` and `testDeleteProject` if and when the test-user is changed as for this user
// project creation is disabled due to rate limit.
// An issue is created to track this: https://github.com/ballerina-platform/ballerina-library/issues/6917
@test:Config {
    enable: false
}
function testCreateUserProject() returns error? {
    UserProjectsBody body = {
        name: "Test Project Created by Ballerina GitHub Connector",
        body: "This is the body of the test project"
    };
    Project? response = check github->/user/projects.post(body);
    test:assertEquals(response?.name, "Test Project Created by Ballerina GitHub Connector");
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testGetMilestone]
}
function testCreateIssue() returns error? {
    RepoIssuesBody body = {
        title: "This is a test Issue Title",
        body: "This is test issue body",
        assignees: [testUsername],
        milestone: milestoneNumber,
        labels: ["bug"]
    };

    Issue response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues.post(body);
    createdIssueId = response.id;
    createdIssueNumber = response.number;
    test:assertEquals(response.title, "This is a test Issue Title");
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testCreateIssue]
}
function testUpdateIssue() returns error? {
    IssuesissueNumberBody body = {
        title: "Updated issue title",
        body: "This is updated test issue body",
        assignees: [testUsername],
        labels: ["enhancement"],
        milestone: milestoneNumber
    };
    Issue response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues/[createdIssueNumber].patch(body);
    test:assertEquals(response.title, "Updated issue title");
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testUpdateIssue]
}
function testGetIssue() returns error? {
    Issue? response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues/[createdIssueNumber]();
    test:assertTrue(response?.number == createdIssueNumber);
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testUpdateIssue]
}
function testGetIssues() returns error? {
    Issue[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues(assignee=testUsername, labels="enhancement");
    test:assertTrue(response[0] is Issue);
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testGetIssue]
}
function testAddComment() returns error? {
    CommentscommentIdBody1 body = {
        body: "Comment Added by Ballerina GitHub connector!"
    };
    IssueComment response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues/[createdIssueNumber]/comments.post(body);
    createdIssueCommentId = response.id;
    test:assertEquals(response.user?.login, testUsername);
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testAddComment]
}
function testUpdateComment() returns error? {
    CommentscommentIdBody2 body = {
        body: "New comment added with addComment() UPDATED"
    };
    IssueComment response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues/comments/[createdIssueCommentId].patch(body);
    test:assertEquals(response.body, "New comment added with addComment() UPDATED");
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testUpdateComment]
}
function testDeleteComment() returns error? {
    check github->/repos/[testUsername]/[testUserRepositoryName]/issues/comments/[createdIssueCommentId].delete();
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetRepositoryLabel() returns error? {
    string labelName = "bug";
    Label response = check github->/repos/[testUsername]/[testUserRepositoryName]/labels/[labelName]();
    test:assertTrue(response.name == "bug");
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testAddIssueLabels]
}
function testGetIssueLabels() returns error? {
    Label[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues/[createdIssueNumber]/labels();
    test:assertTrue(response[0] is Label);
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testCreateIssue]
}
function testAddIssueLabels() returns error? {
    IssueNumberLabelsBody1 body = {
        labels: ["bug"]
    };
    Label[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues/[createdIssueNumber]/labels.post(body);
    test:assertTrue(response.length() >= 0);
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testAddIssueLabels]
}
function testRemoveIssueLabels() returns error? {
    Label[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues/[createdIssueNumber]/labels/["bug"].delete();
    test:assertTrue(response.length() == 1);
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testRemoveIssueLabels]
}
function testCloseIssue() returns error? {
    IssuesissueNumberBody body = {
        state: "closed",
        stateReason: "not_planned"
    };
    Issue response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues/[createdIssueNumber].patch(body);
    test:assertEquals(response.state, "closed");
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetMasterBranchLatestCommitSHA() returns error? {
    BranchWithProtection response = check github->/repos/[testUsername]/[testUserRepositoryName]/branches/[MASTER_BRANCH]();
    string commitHash = response.'commit.sha;
    test:assertEquals(commitHash, LATEST_MASTER_COMMIT_HASH);
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testGetMasterBranchLatestCommitSHA]
}
function testCreateNewBranch() returns error? {
    GitRefsBody body = {
        ref: NEW_FEATURE_BRANCH_REF,
        sha: LATEST_MASTER_COMMIT_HASH
    };
    GitRef response = check github->/repos/[testUsername]/[testUserRepositoryName]/git/refs.post(body);
    test:assertEquals(response.ref, NEW_FEATURE_BRANCH_REF);
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testCreateNewBranch]
}
function testCommitNewFile() returns error? {
    GitBlobsBody blobBody = {
        content: "This is an example file content."
    };
    ShortBlob blobResponse = check github->/repos/[testUsername]/[testUserRepositoryName]/git/blobs.post(blobBody);
    string blobSHA = blobResponse.sha;

    GitCommit commitResponse = check github->/repos/[testUsername]/[testUserRepositoryName]/git/commits/[LATEST_MASTER_COMMIT_HASH]();
    string treeSHA = commitResponse.tree.sha;

    GitTreesBody treeBody = {
        baseTree: treeSHA,
        tree: [
            {
                path: "newFile.txt",
                mode: "100644",
                'type: "blob",
                sha: blobSHA
            }
        ]
    };
    GitTree treeResponse = check github->/repos/[testUsername]/[testUserRepositoryName]/git/trees.post(treeBody);
    string newTreeSHA = treeResponse.sha;

    GitCommitsBody commitBody = {
        parents: [LATEST_MASTER_COMMIT_HASH],
        tree: newTreeSHA,
        message: "Add a new text file"
    };
    GitCommit newCommitResponse = check github->/repos/[testUsername]/[testUserRepositoryName]/git/commits.post(commitBody);
    string newCommitSHA = newCommitResponse.sha;

    RefsrefBody updateRefBody = {
        sha: newCommitSHA
    };
    GitRef response = check github->/repos/[testUsername]/[testUserRepositoryName]/git/refs/[NEW_FEATURE_BRANCH_HEAD].patch(updateRefBody);
    test:assertEquals(response.ref, NEW_FEATURE_BRANCH_REF);
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testCommitNewFile]
}
function testCreatePullRequest() returns error? {
    RepoPullsBody body = {
        title: "Test PR created from Ballerina GitHub Connector",
        base: MASTER_BRANCH,
        head: NEW_FEATURE_BRANCH,
        body: "This is some dummy content for PR body"
    };

    PullRequest response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls.post(body);
    createdPullRequestId = response.id;
    createdPullRequestNumber = response.number;
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testCreatePullRequest]
}
function testGetAPullRequest() returns error? {
    PullRequest? response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber]();
    test:assertTrue(response?.number == createdPullRequestNumber, msg = "Failed testGetaPullRequest()");
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testCreatePullRequest]
}
function testGetPullRequestList() returns error? {
    PullRequestSimple[]? response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls();
    test:assertTrue(response is PullRequestSimple[]);
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testGetAPullRequest, testGetPullRequestList]
}
function testLastCommit() returns error? {
    Commit[] commits = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber]/commits();
    test:assertTrue(commits[0] is Commit, "Issue in fetching last commit");
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testLastCommit]
}
function testUpdatePullRequest() returns error? {
    PullspullNumberBody body = {
        title: "Test PR created from Ballerina GitHub Connector Updated"
    };
    PullRequest response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber].patch(body);
    test:assertTrue(response.number == createdPullRequestNumber, msg = "Failed testUpdatePullRequest()");
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testUpdatePullRequest]
}
function testUpdatePullRequestToClose() returns error? {
    PullspullNumberBody body = {
        state: "closed"
    };

    PullRequest response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber].patch(body);
    test:assertTrue(response.number == createdPullRequestNumber);
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testUpdatePullRequestToClose]
}
function testDeleteBranch() returns error? {
    check github->/repos/[testUsername]/[testUserRepositoryName]/git/refs/[NEW_FEATURE_BRANCH_HEAD].delete();
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testUpdatePullRequest]
}
function testCreatePullRequestReview() returns error? {
    PullNumberReviewsBody body = {
        body: "This is a test review comment for a pull  from Ballerina GitHub connector ",
        event: "COMMENT"
    };

    PullRequestReview response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber]/reviews.post(body);
    createdPullRequestReviewId = response.id;
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testUpdatePullRequest]
}
function testCreatePullRequestReviewWithPendingState() returns error? {
    PullNumberReviewsBody body = {
        body: "This is a test review comment for a pull  from Ballerina GitHub connector "
    };

    PullRequestReview response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber]/reviews.post(body);
    createdPullRequestReviewIdWithPendingState = response.id;
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testCreatePullRequestReview]
}
function testUpdatePullRequestReview() returns error? {
    ReviewsreviewIdBody body = {
        body: "This is a test review comment for a pull  from Ballerina GitHub connector Updated"
    };

    PullRequestReview response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber]/reviews/[createdPullRequestReviewId].put(body);
    test:assertTrue(response.id == createdPullRequestReviewId);
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testCreatePullRequestReviewWithPendingState]
}
function testDeletePullRequestReview() returns error? {
    PullRequestReview response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber]/reviews/[createdPullRequestReviewIdWithPendingState].delete();
    test:assertTrue(response.id == createdPullRequestReviewIdWithPendingState);
}

// Enable after fixing this: https://github.com/ballerina-platform/ballerina-library/issues/7777
@test:Config {enable: false}
function testGetOrgProjectList() returns error? {
    Project[] response = check github->/orgs/["wso2-enterprise"]/projects();
    test:assertTrue(response[0] is Project);
}

// Enable after fixing this: https://github.com/ballerina-platform/ballerina-library/issues/7777
@test:Config {enable: false}
function testGetLatestUserProject() returns error? {
    Project[] response = check github->/users/[testUsername]/projects();
    if response.length() > 0 {
        Project recentProject = response[0];
        fetchedProjectId = recentProject.id;
        fetchedProjectNumber = recentProject.number;
    } else {
        test:assertFail();
    }
}

// Enable after fixing this: https://github.com/ballerina-platform/ballerina-library/issues/7777
@test:Config {
    enable: false,
    dependsOn: [testGetLatestUserProject]
}
function testUpdateProject() returns error? {
    ProjectsprojectIdBody1 body = {
        name: "Test Project Created by Ballerina GitHub Connector UPDATED"
    };

    Project? response = check github->/projects/[fetchedProjectId].patch(body);
    test:assertTrue(response?.number == fetchedProjectNumber);
}

@test:Config {
    enable: false,
    dependsOn: [testUpdateProject, testCreateIssue]
}
function testDeleteProject() returns error? {
    check github->/projects/[fetchedProjectId].delete();
}

// Enable after fixing this: https://github.com/ballerina-platform/ballerina-library/issues/7777
@test:Config {enable: false}
function testGetRepositoryProjectList() returns error? {
    Project[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/projects();
    test:assertTrue(response[0] is Project);
}

// Enable after fixing this: https://github.com/ballerina-platform/ballerina-library/issues/7777
@test:Config {enable: false}
function testGetUserProjectList() returns error? {
    Project[] response = check github->/users/[testUsername]/projects();
    test:assertTrue(response[0] is Project);
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetOrganization() returns error? {
    OrganizationFull response = check github->/orgs/[testOrganizationName]();
    test:assertTrue(response is OrganizationFull);
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetUserOrganizationList() returns error? {
    OrganizationSimple[] response = check github->/users/["kasthuriraajan"]/orgs();
    test:assertTrue(response[0] is OrganizationSimple);
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetOrganizationMembersList() returns error? {
    SimpleUser[] response = check github->/orgs/["ballerina-platform"]/members();
    test:assertTrue(response[0] is SimpleUser);
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetLanguagesFromRepository() returns error? {
    Language response = check github->/repos/[testUsername]/[testUserRepositoryName]/languages();
    test:assertTrue(response is Language);
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetRepositoryContent() returns error? {
    InlineResponse200? response = check github->/repos/[testUsername]/[testUserRepositoryName]/contents/["src"]();
    if response is ContentDirectory {
        test:assertTrue(response.length() > 0);
    } else {
        test:assertFail();
    }
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testGetRepositoryContentOfFile() returns error? {
    InlineResponse200? response = check github->/repos/[testUsername]/[testUserRepositoryName]/contents/["src/db/main.bal"]();
    if response is ContentFile {
        test:assertTrue(response.name.length() > 0);
    } else {
        test:assertFail();
    }
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testStarRepository() returns error? {
    check github->/user/starred/[testUsername]/[testUserRepositoryName].put();
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testStarRepository]
}
function testUnstarRepository() returns error? {
    check github->/user/starred/[testUsername]/[testUserRepositoryName].delete();
}

@test:Config {groups: ["mock_tests", "live_tests"]}
function testStarGist() returns error? {
    check github->/gists/[testGistName]/star.put();
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testStarGist]
}
function testUnstarGist() returns error? {
    check github->/gists/[testGistName]/star.delete();
}
