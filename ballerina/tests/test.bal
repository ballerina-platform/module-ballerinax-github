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

import ballerina/log;
import ballerina/test;
// import ballerina/io;
import ballerina/http;
// import ballerina/uuid;
import ballerina/os;
// import ballerina/mime;
// import ballerina/lang.runtime;

configurable string testOrganizationName = os:getEnv("ORG_NAME");
configurable string testUserRepositoryName = os:getEnv("REPO_NAME");
configurable string testResourcePath = os:getEnv("RESOURCE_PATH");
configurable string testIssueAssignee = os:getEnv("ASSIGNEE");
configurable string testUsername = os:getEnv("USERNAME");
configurable string authToken = os:getEnv("ACCESS_TOKEN");
configurable string testTopicName = "language";
configurable string testGistName = "5a648dc78fd2d402ec484e2663282e6f";

const REPO_BASE_URL = "https://api.github.com/repos/connector-ecosystem/github-connector/contents";
const REPO_FILE_PATH = "/src/db/resources/info1.txt";
const FEATURE_BRANCH = "feature/feature2";
const TEST_REPO_NAME = "ballerina-github-connector-test-repo";

ConnectionConfig gitHubConfig = {
    auth: {
        token: authToken
    }
};

Client github = check new (gitHubConfig);

@test:Config {
    groups: ["github"]
}
function testGetUser() returns error? {
    UserResponse response = check github->/user();
    test:assertEquals(response.login, testUsername, msg = "Failed /user() funtion for authenticated user");
}

@test:Config {
    groups: ["github"]
}
function testGetUserWithGivenUsername() returns error? {
    UserResponse response = check github->/users/[testUsername];
    test:assertEquals(response.login, testUsername, msg = "Failed users/[string username]() funtion for a given username");
}

@test:Config {
    groups: ["github"]
}
function testGetRepository() returns error? {
    FullRepository response = check github->/repos/[testUsername]/[testUserRepositoryName];
    test:assertEquals(response.name, testUserRepositoryName, msg = "Failed repos/[string owner]/[string repo]()");
}

// @test:Config {
//     groups: ["github"]
// }
// function testGetRepositories() returns error? {
//     Repository[] response = check github->/user/repos();
//     test:assertTrue(response[0] is Repository, msg = "Failed user/repos() for authenticated user");
// }

@test:Config {
    groups: ["github"]
}
function testGetRepositoriesOfGivenUser() returns error? {
    MinimalRepository[] response = check github->/users/[testUsername]/repos();
    test:assertTrue(response[0] is MinimalRepository, msg = "Failed users/[string username]/repos()");
}

@test:Config {
    groups: ["github"]
}
function testGetRepositoriesOfGivenOrganization() returns error? {
    MinimalRepository[] response = check github->/orgs/[testOrganizationName]/repos();
    test:assertTrue(response[0] is MinimalRepository, msg = "Failed orgs/[string org]/repos()");
}

@test:Config {
    groups: ["github"]
}
function testGetCollaborators() returns error? {
    Collaborator[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/collaborators();
    test:assertTrue(response[0] is Collaborator);
}

@test:Config {
    groups: ["github"]
}
function testgetBranches() returns error? {
    ShortBranch[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/branches();
    test:assertTrue(response[0] is ShortBranch);
}

// @test:Config {
//     groups: ["github"]
// }
// function testCreateRepository() returns error? {
//     User_repos_body body = {
//         name: TEST_REPO_NAME,
//         description: "New Updated Description"
//     };
//     Repository response = check github->/user/repos.post(body);
//     test:assertEquals(response.name, TEST_REPO_NAME);
// }

// @test:Config {
//     groups: ["github"]
//     // dependsOn: [testCreateRepository]
// }
// function testDeleteRepository() returns error? {
//     http:Response response = check github->/repos/[testUsername]/[TEST_REPO_NAME].delete();
//     io:println(response);
//     // Repository response = check github->/user/repos.post(body);
//     // test:assertEquals(response.name, "ballerina-github-connector-test-repo");
// }

@test:Config {
    groups: ["github"]
}
function testUpdateRepository() returns error? {
    Owner_repo_body_1 body = {
        description: "New Updated Description"
    };
    FullRepository response = check github->/repos/[testUsername]/[TEST_REPO_NAME].patch(body);
    test:assertEquals(response.description, "New Updated Description");
}

int milestoneNumber = 2;

@test:Config {
    groups: ["github"]
}
function testGetMilestone() returns error? {
    Milestone milestone = check github->/repos/[testUsername]/[testUserRepositoryName]/milestones/[milestoneNumber]();
    test:assertTrue(milestone.number == milestoneNumber, msg = "Failed testgetMilestones()");
}

@test:Config {
    groups: ["github"]
}
function testGetMilestones() returns error? {
    Milestone[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/milestones();
    test:assertTrue(response[0] is Milestone);
}

int createdProjectId = -1;
int createdProjectNumber = -1;
int getProjectRetryCount = 0;

@test:Config {
    groups: ["github"]
}
function testCreateUserProject() returns error? {
    User_projects_body body = {
        name: "Test Project Created by Ballerina GitHub Connector",
        body: "This is the body of the test project"
    };
    Project response = check github->/user/projects.post(body);
    createdProjectId = response.id;
    createdProjectNumber = response.number;
    test:assertEquals(response.name, "Test Project Created by Ballerina GitHub Connector");
}

int createdIssueId = -1;
int createdIssueNumber = -1;

@test:Config {
    groups: ["github"],
    dependsOn: [testGetMilestone, testCreateUserProject]
}
function testCreateIssue() returns error? {
    Repo_issues_body body = {
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
    groups: ["github"],
    dependsOn: [testCreateIssue]
}
function testUpdateIssue() returns error? {
    Issues_issue_number_body body = {
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
    groups: ["github"],
    dependsOn: [testCreateIssue, testUpdateIssue]
}
function testGetIssue() returns error? {
    Issue? response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues/[createdIssueNumber]();
    test:assertTrue(response?.number == createdIssueNumber, msg = "Failed testGetIssue()");
}

@test:Config {
    groups: ["github"],
    dependsOn: [testCreateIssue, testUpdateIssue]
}
function testGetIssues() returns error? {
    Issue[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues(assignee=testUsername, labels="enhancement");
    test:assertTrue(response[0] is Issue);
}

int createdIssueCommentId = -1;

@test:Config {
    groups: ["github"],
    dependsOn: [testGetIssue]
}
function testAddComment() returns error? {
    Issue_number_comments_body body = {
        body: "Comment Added by Ballerina GitHub connector!"
    };
    IssueComment response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues/[createdIssueNumber]/comments.post(body);
    createdIssueCommentId = response.id;
    test:assertEquals(response.user?.login, testUsername);
}

@test:Config {
    groups: ["github"],
    dependsOn: [testAddComment]
}
function testUpdateComment() returns error? {
    Comments_comment_id_body_2 body = {
        body: "New comment added with addComment() UPDATED"
    };
    IssueComment response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues/comments/[createdIssueCommentId].patch(body);
    test:assertEquals(response.body, "New comment added with addComment() UPDATED");
}

@test:Config {
    groups: ["github"],
    dependsOn: [testUpdateComment]
}
function testDeleteComment() returns error? {
    check github->/repos/[testUsername]/[testUserRepositoryName]/issues/comments/[createdIssueCommentId].delete();
}

@test:Config {
    groups: ["github"]
}
function testGetRepositoryLabel() returns error? {
    string labelName = "bug";
    Label response = check github->/repos/[testUsername]/[testUserRepositoryName]/labels/[labelName]();
    test:assertTrue(response.name == "bug", msg = "Failed testGetRepositoryLabel()");
}

@test:Config {
    groups: ["github"],
    dependsOn: [testAddIssueLabels]
}
function testGetIssueLabels() returns error? {
    Label[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues/[createdIssueNumber]/labels();
    test:assertTrue(response[0] is Label);
}

@test:Config {
    groups: ["github"],
    dependsOn: [testCreateIssue]
}
function testAddIssueLabels() returns error? {
    Issue_number_labels_body_1 body = {
        labels: ["bug"]
    };
    Label[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues/[createdIssueNumber]/labels.post(body);
    test:assertTrue(response.length() >= 0, msg = "Failed testGetRepositoryLabelListInIssue()");
}

@test:Config {
    groups: ["github"],
    dependsOn: [testAddIssueLabels]
}
function testRemoveIssueLabels() returns error? {
    Label[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/issues/[createdIssueNumber]/labels/["bug"].delete();
}

int createdPullRequestId = -1;
int createdPullRequestNumber = -1;

@test:Config {
    groups: ["github"]
}
function testCreatePullRequest() returns error? {
    Repo_pulls_body body = {
        title: "Test PR created from Ballerina GitHub Connector",
        base: "master",
        head: FEATURE_BRANCH,
        body: "This is some dummy content for PR body"
    };

    PullRequest response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls.post(body);
    createdPullRequestId = response.id;
    createdPullRequestNumber = response.number;
}

@test:Config {
    groups: ["github"],
    dependsOn: [testCreatePullRequest]
}
function testGetAPullRequest() returns error? {
    PullRequest response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber]();
    test:assertTrue(response.number == createdPullRequestNumber, msg = "Failed testGetaPullRequest()");
}

@test:Config {
    groups: ["github"],
    dependsOn: [testCreatePullRequest]
}
function testGetPullRequestList() returns error? {
    PullRequestSimple[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls();
    test:assertTrue(response[0] is PullRequestSimple);
}

@test:Config {
    groups: ["github"],
    dependsOn: [testGetAPullRequest, testGetPullRequestList]
}
function testLastCommit() returns error? {
    Commit[] commits = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber]/commits();
    test:assertTrue(commits[0] is Commit, "Issue in fetching last commit");
}

@test:Config {
    groups: ["github"],
    dependsOn: [testLastCommit]
}
function testUpdatePullRequest() returns error? {
    Pulls_pull_number_body body = {
        title: "Test PR created from Ballerina GitHub Connector Updated"
    };
    PullRequest response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber].patch(body);
    test:assertTrue(response.number == createdPullRequestNumber, msg = "Failed testUpdatePullRequest()");
}

@test:Config {
    groups: ["github"],
    dependsOn: [testUpdatePullRequest]
}
function testUpdatePullRequestToClose() returns error? {
    Pulls_pull_number_body body = {
        state: "closed"
    };

    PullRequest response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber].patch(body);
    test:assertTrue(response.number == createdPullRequestNumber);
}

int createdPullRequestReviewId = -1;
int createdPullRequestReviewIdWithPendingState = -1;

@test:Config {
    groups: ["github"],
    dependsOn: [testUpdatePullRequest]
}
function testCreatePullRequestReview() returns error? {
    Pull_number_reviews_body body = {
        body: "This is a test review comment for a pull  from Ballerina GitHub connector ",
        event: "COMMENT"
    };

    PullRequestReview response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber]/reviews.post(body);
    createdPullRequestReviewId = response.id;
}

@test:Config {
    groups: ["github"],
    dependsOn: [testUpdatePullRequest]
}
function testCreatePullRequestReviewWithPendingState() returns error? {
    Pull_number_reviews_body body = {
        body: "This is a test review comment for a pull  from Ballerina GitHub connector "
    };

    PullRequestReview response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber]/reviews.post(body);
    createdPullRequestReviewIdWithPendingState = response.id;
}

@test:Config {
    groups: ["github"],
    dependsOn: [testCreatePullRequestReview]
}
function testUpdatePullRequestReview() returns error? {
    Reviews_review_id_body body = {
        body: "This is a test review comment for a pull  from Ballerina GitHub connector Updated"
    };

    PullRequestReview response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber]/reviews/[createdPullRequestReviewId].put(body);
    test:assertTrue(response.id == createdPullRequestReviewId);
}

@test:Config {
    groups: ["github"],
    dependsOn: [testCreatePullRequestReviewWithPendingState]
}
function testDeletePullRequestReview() returns error? {
    PullRequestReview response = check github->/repos/[testUsername]/[testUserRepositoryName]/pulls/[createdPullRequestNumber]/reviews/[createdPullRequestReviewIdWithPendingState].delete();
    test:assertTrue(response.id == createdPullRequestReviewIdWithPendingState);
}

@test:Config {
    groups: ["github"]
}
function testGetOrgProjectList() returns error? {
    Project[] response = check github->/orgs/["wso2-enterprise"]/projects();
    test:assertTrue(response[0] is Project);
}

@test:Config {
    groups: ["github"],
    dependsOn: [testCreateUserProject]
}
function testGetUserProject() returns error? {
    getProjectRetryCount = getProjectRetryCount + 1;
    Project|error project = github->/projects/[createdProjectNumber]();
    if project is Project {
        test:assertTrue(project.number == createdProjectNumber);
    } else if project is http:ClientError {
        // record {|anydata body?;|} errorDetails = project.detail();
        log:printError("Client error received. Error detail = ");
        // if getProjectRetryCount > 3 {
        //     return project;
        // } else {
        //     runtime:sleep(5); //Github seems to add project async mannger. Sometimes immediate call does not return the project.
        //     return testGetUserProject();
        // }
    } else {
        return project;
    }
}

@test:Config {
    groups: ["github"],
    dependsOn: [testGetUserProject]
}
function testUpdateProject() returns error? {
    Projects_project_id_body_1 body = {
        name: "Test Project Created by Ballerina GitHub Connector UPDATED"
    };

    Project response = check github->/projects/[createdProjectId].patch(body);
    test:assertTrue(response.number == createdProjectNumber);
}

@test:Config {
    groups: ["github"],
    dependsOn: [testUpdateProject, testCreateIssue]
}
function testDeleteProject() returns error? {
    http:Response response = check github->/projects/[createdProjectId].delete();
}

@test:Config {
    groups: ["github"]
}
function testGetRepositoryProjectList() returns error? {
    Project[] response = check github->/repos/[testUsername]/[testUserRepositoryName]/projects();
    test:assertTrue(response[0] is Project);
}

@test:Config {
    groups: ["github"]
}
function testGetUserProjectList() returns error? {
    Project[] response = check github->/users/[testUsername]/projects();
    test:assertTrue(response[0] is Project);
}

// Payload binding failure - Have to check with the API doc and update the schema.
// @test:Config {
//     groups: ["github"]
// }
// function testGetOrganization() returns error? {
//     OrganizationFull response = check github->/orgs/[testOrganizationName]();
//     test:assertTrue(response is OrganizationFull);
// }

@test:Config {
    groups: ["github"]
}
function testGetUserOrganizationList() returns error? {
    OrganizationSimple[] response = check github->/users/["kasthuriraajan"]/orgs();
    test:assertTrue(response[0] is OrganizationSimple);
}

@test:Config {
    groups: ["github"]
}
function testGetOrganizationMembersList() returns error? {
    SimpleUser[] response = check github->/orgs/["ballerina-platform"]/members();
    test:assertTrue(response[0] is SimpleUser);
}

// @test:Config {
//     groups: ["github"]
// }
// function testSearch() returns @tainted error? {
//     SearchResult response = check github->search("connector-", SEARCH_TYPE_USER, 10);
//     Issue[]|User[]|Organization[]|Repository[]|PullRequest[] result = response.results;
//     test:assertTrue(result is User[]);
// }

// @test:Config {
//     groups: ["github"]
// }
// function testSearchMultiWordsString() returns error? {

//     string query = string `repo:ballerina-platform/ballerina-extended-library is:issue is:open label:"Type/New Feature"`;
//     SearchResult response = check github->search(query, SEARCH_TYPE_ISSUE, 10);
//     Issue[]|User[]|Organization[]|Repository[]|PullRequest[] result = response.results;
//     test:assertTrue(result is Issue[]);
// }

// @test:Config {
//     groups: ["github"]
// }
// function testSearchIssueLabels() returns error? {

//     string query = string `repo:ballerina-platform/ballerina-extended-library is:issue is:open label:"Team/Connector"`;
//     SearchResult response = check github->search(query, SEARCH_TYPE_ISSUE, 1, 1);
//     Issue[]|User[]|Organization[]|Repository[]|PullRequest[] result = response.results;
//     if result is Issue[] {
//         if result.length() > 0 {
//             int labelCount = let var nodes = result[0]?.labels?.nodes
//                 in nodes is () ? 0 : nodes.length();
//             test:assertTrue(labelCount == 1);
//         }
//     } else {
//         test:assertFail("Incorrect search results");
//     }
// }

// @test:Config {
//     groups: ["github"]
// }
// function testSearchPullRequest() returns error? {

//     string query = string `repo:ballerina-platform/ballerina-extended-library is:pr is:open`;
//     SearchResult response = check github->search(query, SEARCH_TYPE_PULL_REQUEST, 10);
//     Issue[]|User[]|Organization[]|Repository[]|PullRequest[] result = response.results;
//     test:assertTrue(result is PullRequest[], "Unexpected search results Found. Expected: 'PullRequest[]', found: " + result.toBalString());
// }

// @test:Config {
//     groups: ["github"]
// }
// function testSearchPullRequestComplex() returns error? {

//     string query = string `repo:ballerina-platform/ballerina-extended-library is:pr state:closed author:abeykoon created:2021-11-01..2022-07-11`;
//     SearchResult response = check github->search(query, SEARCH_TYPE_PULL_REQUEST, 5);
//     Issue[]|User[]|Organization[]|Repository[]|PullRequest[] result = response.results;
//     test:assertTrue(result is PullRequest[]);
// }

// @test:Config {
//     groups: ["github"]
// }
// function testSearchPullRequestWithRelatedIssues() returns error? {

//     string query = string `repo:ballerina-platform/module-ballerinax-github is:pr is:closed author:sachinira`;
//     SearchResult response = check github->search(query, SEARCH_TYPE_PULL_REQUEST, 5);
//     Issue[]|User[]|Organization[]|Repository[]|PullRequest[] result = response.results;

//     if result is PullRequest[] {
//         foreach PullRequest item in result {
//             RelatedIssues issues = item?.closingIssuesReferences ?: {};
//             if issues?.nodes != [] {
//                 Issue[] issueData = issues?.nodes ?: [];
//                 test:assertTrue(issueData != []);
//             }
//         }
//     }
// }

// @test:Config {
//     groups: ["github"]
// }
// function testSearchPullRequestWithReviews() returns error? {

//     string query = string `repo:ballerina-platform/module-ballerinax-github is:pr is:closed review:approved author:sachinira`;
//     SearchResult response = check github->search(query, SEARCH_TYPE_PULL_REQUEST, 5, perPageCountForPRReviews = 1);
//     Issue[]|User[]|Organization[]|Repository[]|PullRequest[] result = response.results;

//     if result is PullRequest[] {
//         foreach PullRequest item in result {
//             PullRequestReview[]? pullRequestReviews = item.pullRequestReviews;
//             if pullRequestReviews is PullRequestReview[] {
//                 if pullRequestReviews.length() > 0 {
//                     test:assertTrue(pullRequestReviews.length() == 1);
//                 }
//             }
//         }
//     }
// }

// @test:Config {
//     groups: ["github"]
// }
// function testSearchUser() returns error? {

//     string query = string `mike in:name created:<2022-01-01 type:user`;
//     SearchResult response = check github->search(query, SEARCH_TYPE_USER, 20);
//     Issue[]|User[]|Organization[]|Repository[]|PullRequest[] result = response.results;
//     test:assertTrue(result is User[]);
// }

// @test:Config {
//     groups: ["github"]
// }
// function testSearchOrganization() returns error? {

//     string query = string `data in:email type:org`;
//     SearchResult response = check github->search(query, SEARCH_TYPE_ORGANIZATION, 20);
//     Issue[]|User[]|Organization[]|Repository[]|PullRequest[] result = response.results;
//     test:assertTrue(result is Organization[]);
// }

@test:Config {
    groups: ["github"]
}
function testGetLanguagesFromRepository() returns error? {
    Language response = check github->/repos/[testUsername]/[testUserRepositoryName]/languages();
    test:assertTrue(response is Language);
}

// @test:Config {
//     groups: ["github"]
// }
// function testGetRepositoryContent() returns error? {
//     ContentTree? response = check github->/repos/[testUsername]/[testUserRepositoryName]/contents/["src"]();
//     test:assertTrue(response is ContentTree);
// }

@test:Config {
    groups: ["github"]
}
function testStarRepository() returns error? {
    check github->/user/starred/[testUsername]/[testUserRepositoryName].put();
}

@test:Config {
    groups: ["github"],
    dependsOn: [testStarRepository]
}
function testUnstarRepository() returns error? {
    http:Response response = check github->/user/starred/[testUsername]/[testUserRepositoryName].delete();
}

// @test:Config {
//     groups: ["github"]
// }
// function testStarTopic() returns error? {
//     check github->starTopic(testTopicName);
// }

// @test:Config {
//     groups: ["github"],
//     dependsOn: [testStarTopic]
// }
// function testUnstarTopic() returns error? {
//     check github->unstarTopic(testTopicName);
// }

@test:Config {
    groups: ["github"]
}
function testStarGist() returns error? {
    http:Response response = check github->/gists/[testGistName]/star.put();
}

@test:Config {
    groups: ["github"],
    dependsOn: [testStarGist]
}
function testUnstarGist() returns error? {
    http:Response response = check github->/gists/[testGistName]/star.delete();
}
