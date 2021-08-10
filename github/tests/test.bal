// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import ballerina/log;
import ballerina/test;
import ballerina/os;

configurable string testOrganizationName = os:getEnv("ORG_NAME");
configurable string testUserRepositoryName = os:getEnv("USER_REPO_NAME");
configurable string testResourcePath = os:getEnv("RESOURCE_PATH");
configurable string testIssueAssignee = os:getEnv("ISSUE_ASSIGNEE");
configurable string testUserName = os:getEnv("GITHUB_USERNAME");
configurable string accessToken = os:getEnv("ACCESS_TOKEN");

Configuration gitHubConfig = {
    accessToken: accessToken
};

Client githubClient = checkpanic new (gitHubConfig);

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetAuthenticatedUser() returns @tainted error? {
    log:printInfo("githubClient -> getAuthenticatedUser()");
    var response = githubClient->getAuthenticatedUser();
    if(response is User){
        test:assertEquals(response.login, testUserName, msg = "Failed getAuthenticatedUser()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetUserRepository() returns @tainted error? {
    log:printInfo("githubClient -> getUserRepository()");
    var response = githubClient->getUserRepository(testUserName, testUserRepositoryName);
    if(response is Repository){
        test:assertEquals(response.name, testUserRepositoryName, msg = "Failed testGetUserRepository()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetAuthenticatedUserRepositoryList() returns @tainted error? {
    log:printInfo("githubClient -> getAuthenticatedUserRepositoryList()");
    int perPageCount = 10;
    var response = githubClient->getAuthenticatedUserRepositoryList(perPageCount);
    if(response is RepositoryList){
        test:assertTrue(response.repositories.length()>0, msg = "Failed testGetAuthenticatedUserRepositoryList()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetUserRepositoryList() returns @tainted error? {
    log:printInfo("githubClient -> getUserRepositoryList()");
    int perPageCount = 10;
    var response = githubClient->getUserRepositoryList(testUserName, perPageCount);
    if(response is RepositoryList){
        test:assertTrue(response.length()>0, msg = "Failed testGetUserRepositoryList()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetOrganizationRepositoryList() returns @tainted error? {
    log:printInfo("githubClient -> getOrganizationRepositoryList()");
    int perPageCount = 10;
    var response = githubClient->getOrganizationRepositoryList(testOrganizationName,perPageCount);
    if(response is RepositoryList){
        test:assertTrue(response.length()>0, msg = "Failed testGetOrganizationRepositoryList()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoryCollobaratorList() returns @tainted error? {
    log:printInfo("githubClient -> getRepositoryCollobaratorList()");
    int perPageCount = 10;
    var response = githubClient->getRepositoryCollobaratorList(testUserName, testUserRepositoryName, perPageCount);
    if(response is CollaboratorList){
        test:assertTrue(response.collaborators.length()>0, msg = "Failed testGetRepositoryCollobaratorList()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoryBranchList() returns @tainted error? {
    log:printInfo("githubClient -> getRepositoryBranchList()");
    int perPageCount = 10;
    var response = githubClient->getRepositoryBranchList(testUserName, testUserRepositoryName, perPageCount);
    if(response is BranchList){
        test:assertTrue(response.branches.length()>0, msg = "Failed testGetRepositoryBranchList()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: false // This test case have been disabled as this operation cannot be run continuosly without 
                  // deleteRepository operation which is not yet supported by the GitHub GraphQL API.
}
function testCreateRepository() returns @tainted error? {
    log:printInfo("githubClient -> createRepository()");
    CreateRepositoryInput createRepositoryInput = {
        name: "ballerina-github-connector-test-repo",
        visibility: PUBLIC_REPOSITORY,
        description: "New Updated Description"
    };
    var response = githubClient->createRepository(createRepositoryInput);

    if(response is error){
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testUpdateRepository() returns @tainted error? {
    log:printInfo("githubClient -> updateRepository()");
    UpdateRepositoryInput updateRepositoryInput = {
        description: "New Updated Description"
    };
    var response = githubClient->updateRepository(updateRepositoryInput, testUserName, testUserRepositoryName);

    if(response is error){
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetIssueListAssignedToUser() returns @tainted error? {
    log:printInfo("githubClient -> getRepositoryIssueListAssignedToUser()");
    int perPageCount = 10;
    var response = githubClient->getRepositoryIssueListAssignedToUser(testUserName, testUserRepositoryName, testIssueAssignee, perPageCount);
    if(response is IssueList){
        test:assertTrue(response.issues.length()>=0, msg = "Failed testGetIssueListAssignedToUser()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetIssueList() returns @tainted error? {
    log:printInfo("githubClient -> getRepositoryIssueList()");
    int perPageCount = 10;
    var response = githubClient->getRepositoryIssueList(testUserName, testUserRepositoryName, [ISSUE_OPEN], perPageCount);
    if(response is IssueList){
        test:assertTrue(response.issues.length()>=0, msg = "Failed testGetIssueList()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

string milestoneId="";

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoryMilestone() returns @tainted error? {
    log:printInfo("githubClient -> getRepositoryMilestone()");
    var response = githubClient->getRepositoryMilestone(testUserName, testUserRepositoryName, 2);
     if(response is Milestone){
         test:assertTrue(response.number==2, msg = "Failed testGetRepositoryMilestoneList()");
         milestoneId=response.id;
     }else {
         test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
     }
}

string createdProjectId = "";
int createdProjectNumber =-1;
@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testCreateUserProject() returns @tainted error? {
    log:printInfo("githubClient -> createProject()");
    string userId = check githubClient->getUserId(testUserName);
    CreateRepositoryProjectInput createRepositoryProjectInput = {
        ownerName: testUserName,
        name: "Test Project Created by Ballerina GitHub Connector",
        body: "This is the body of the test project"
    };
    var response = githubClient->createProject(createRepositoryProjectInput);
    if(response is Project){
        createdProjectId = <@untainted>response.id;
        createdProjectNumber = <@untainted>(<int>(response?.number));
        test:assertTrue(true);
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

string createdIssueId = "";
int createdIssueNumber = -1;
@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testGetRepositoryMilestone, testCreateUserProject]
}
function testCreateIssue() returns @tainted error?{
    log:printInfo("githubClient -> createIssue()");
    CreateIssueInput createIssueInput = {
        title: "This is a test Issue Title",
        body: "This is test issue body",
        labelNames: ["bug"],
        assigneeNames: [testUserName],
        projectIds: [createdProjectId],
        milestoneId: milestoneId
    };

    var response = githubClient->createIssue(createIssueInput, testUserName, testUserRepositoryName);

    if(response is Issue){
        createdIssueId = <@untainted>response.id;
        createdIssueNumber = <@untainted>response.number;
        test:assertTrue(true);
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreateIssue]
}
function testUpdateIssue() returns @tainted error? {
    log:printInfo("githubClient -> updateIssue()");
    UpdateIssueInput updateRepositoryInput = {
        title: "Updated issue title",
        body: "This is updated test issue body",
        labelNames: ["enhancement"],
        assigneeNames: [testUserName],
        milestoneId: milestoneId
    };

    var response = githubClient->updateIssue(updateRepositoryInput, testUserName, testUserRepositoryName, createdIssueNumber);

    if(response is Issue){
        test:assertTrue(true);
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreateIssue]
}
function testGetIssue() returns @tainted error? {
    log:printInfo("githubClient -> getRepositoryIssue()");
    var response = githubClient->getRepositoryIssue(testUserName, testUserRepositoryName, createdIssueNumber);
    if(response is Issue){
        test:assertTrue(response.number==createdIssueNumber, msg = "Failed testGetIssue()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testAddComment]
}
function testGetIssueCommentList() returns @tainted error? {
    log:printInfo("githubClient -> getRepositoryIssueCommentList()");
    int perPageCount = 10;

    var response = githubClient->getRepositoryIssueCommentList(testUserName, testUserRepositoryName, createdIssueNumber, perPageCount);
    if(response is IssueCommentList){
        test:assertTrue(response.length()>=0, msg = "Failed testGetIssue()");
    }else {
        test:assertFail(msg = response.message()+": "+ <string> check response.detail()["message"]);
    }
}
string createdIssueCommentId="";
@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreateIssue]
}
function testAddComment() returns @tainted error? {
    log:printInfo("githubClient -> addComment()");
    AddIssueCommentInput addIssueCommentInput = {
        repositoryOwnerName: testUserName,
        repositoryName: testUserRepositoryName,
        issueNumber: createdIssueNumber,
        body: "Comment Added by Ballerina GitHub connector!"
    };
    var response = githubClient->addComment(addIssueCommentInput);

    if(response is IssueComment){
        createdIssueCommentId = <@untainted>response.id;
        test:assertTrue(true);
    }else {
        test:assertFail(msg = response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testGetIssueCommentList]
}
function testUpdateComment() returns @tainted error?{
    log:printInfo("githubClient -> updateComment()");
    UpdateIssueCommentInput updateIssueComment = {
        id: createdIssueCommentId,
        body: "new comment added with addComment() UPDATED"
    };
    var response = githubClient->updateComment(updateIssueComment);

    if(response is error){
        test:assertFail(msg = response.message()+": "+ <string> check response.detail()["message"]);
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testUpdateComment]
}
function testDeleteComment() returns @tainted error? {
    log:printInfo("githubClient -> deleteComment()");
    DeleteIssueCommentInput deleteIssueComment = {
        id: createdIssueCommentId
    };
    var response = githubClient->deleteComment(deleteIssueComment);

    if(response is error){
        test:assertFail(msg = response.message()+": "+ <string> check response.detail()["message"]);
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoryLabel() returns @tainted error? {
    log:printInfo("githubClient -> getRepositoryLabel()");
    string labelName = "bug";
    var response = githubClient->getRepositoryLabel(testUserName, testUserRepositoryName, labelName);
    if(response is Label){
        test:assertTrue(response.name=="bug", msg = "Failed testGetRepositoryLabel()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testAddLabelsToLabelable]
}
function testGetRepositoryLabelListInIssue() returns @tainted error? {
    log:printInfo("githubClient -> getLabelsInIssue()");
    int perPageCount = 10;
    var response = githubClient->getLabelsInIssue(testUserName, testUserRepositoryName, createdIssueNumber, perPageCount);
    if(response is LabelList){
        test:assertTrue(response.length()>=0, msg = "Failed testGetRepositoryLabelListInIssue()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreateIssue]
}
function testAddLabelsToLabelable() returns @tainted error? {
    log:printInfo("githubClient -> addIssueLabel()");
    AddIssueLabelsInput addIssueLabelInput = {
        repositoryOwnerName: testUserName,
        repositoryName: testUserRepositoryName, 
        issueNumber: createdIssueNumber,
        labelNames: ["bug"] 
    };
    var response = githubClient->addIssueLabels(addIssueLabelInput);
    if(response is LabelList){
        test:assertTrue(response.length()>=0, msg = "Failed testGetRepositoryLabelListInIssue()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testAddLabelsToLabelable]
}
function testRemoveLabelsFromLabelable() returns @tainted error? {
    log:printInfo("githubClient -> removeLabelFromLabelable()");
    RemoveIssueLabelInput removeIssueLabelsInput = {
        repositoryOwnerName: testUserName,
        repositoryName: testUserRepositoryName,
        issueNumber: createdIssueNumber,
        labelNames: ["bug"] 
    };
    var response = githubClient->removeLabelFromLabelable(removeIssueLabelsInput);
     if(response is error){
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
     }else {
        test:assertTrue(true);
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetIssuesWithLabel() returns @tainted error? {
    log:printInfo("githubClient -> getIssuesWithLabel()");
    int perPageCount = 10;
    string label = "bug";
    var response = githubClient->getIssuesWithLabel(testUserName, testUserRepositoryName, label, perPageCount);
     if(response is error){
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
     }else {
        test:assertTrue(true);
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoryMilestoneList() returns @tainted error? {
    log:printInfo("githubClient -> getRepositoryMilestoneList()");
    int perPageCount = 10;
    var response = githubClient->getRepositoryMilestoneList(testUserName, testUserRepositoryName, perPageCount);
     if(response is MilestoneList){
         test:assertTrue(response.milestones.length()>=0, msg = "Failed testGetRepositoryMilestoneList()");
     }else {
         test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
     }
}

string createdPullRequestId="";
int createdPullRequestNumber=-1;
@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testCreatePullRequest() returns @tainted error? {
    log:printInfo("githubClient -> createPullRequest()");
    CreatePullRequestInput createPullRequestInput = {
       title: "Test PR created from Ballerina GitHub Connector",
       baseRefName: "master",
       headRefName: "feature/feature2",
       body: "This is some dummy content for PR body"
    };
    var response = githubClient->createPullRequest(createPullRequestInput, testUserName, testUserRepositoryName);
     if(response is PullRequest){
         createdPullRequestId = <@untainted>response.id;
         createdPullRequestNumber = <@untainted>(<int>(response?.number));
         test:assertTrue(true);
     }else {
         test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreatePullRequest]
}
function testGetPullRequest() returns @tainted error? {
    log:printInfo("githubClient -> getPullRequest()");
    var response = githubClient->getPullRequest(testUserName, testUserRepositoryName, createdPullRequestNumber);
     if(response is PullRequest){
         test:assertTrue(response.number==createdPullRequestNumber, msg = "Failed testGetPullRequest()");
     }else {
         test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetPullRequestList() returns @tainted error? {
    log:printInfo("githubClient -> getRepositoryPullRequestList()");
    int perPageCount = 10;
    var response = githubClient->getRepositoryPullRequestList(testUserName, testUserRepositoryName, PULL_REQUEST_OPEN, perPageCount);
     if(response is PullRequestList){
         test:assertTrue(response.length()>=0, msg = "Failed testGetPullRequest()");
     }else {
         test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreatePullRequest]
}
function testUpdatePullRequest() returns @tainted error? {
    log:printInfo("githubClient -> updatePullRequest()");
    UpdatePullRequestInput updatePullRequestInput = {
       title: "Test PR created from Ballerina GitHub Connector Updated",
       labelNames: ["bug"],
       assigneeNames: ["MadhurangaWije"]
    };

    var response = githubClient->updatePullRequest(updatePullRequestInput, testUserName, testUserRepositoryName, createdPullRequestNumber);
     if(response is error){
         test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
     }else {
         test:assertTrue(true);
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testUpdatePullRequestToClose() returns @tainted error? {
    log:printInfo("githubClient -> updatePullRequest()");
    UpdatePullRequestInput updatePullRequestInput = {
       state: PULL_REQUEST_CLOSED
    };

    var response = githubClient->updatePullRequest(updatePullRequestInput, testUserName, testUserRepositoryName, createdPullRequestNumber);
     if(response is error){
         test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
     }else {
         test:assertTrue(true);
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreatePullRequestReview]
}
function testGetPullRequestReviewCommentList() returns @tainted error? {
    log:printInfo("githubClient -> getPullRequestReviewCommentList()");
    int pullRequestNumber = 165;
    int perPageCount = 10;
    var response = githubClient->getPullRequestReviewCommentList(testUserName, testUserRepositoryName, createdPullRequestNumber, perPageCount);
     if(response is PullRequestReviewList){
         test:assertTrue(response.pullRequestReviews.length()>=0, msg = "Failed testGetPullRequest()");
     }else {
         test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
     }
}

string createdPullRequestReviewId = "";
string createdPullRequestReviewIdWithPendingState = "";
@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testUpdatePullRequest]
}
function testCreatePullRequestReview() returns @tainted error? {
    log:printInfo("githubClient -> createPullRequestReview()");
    AddPullRequestReviewInput createPullRequestReviewInput = {
        body: "This is a test review comment for a pull  from Ballerina GitHub connector ",
        event: PULL_REQUEST_REVIEW_COMMENT
    };

    var response = githubClient->createPullRequestReview(createPullRequestReviewInput, testUserName, testUserRepositoryName, createdPullRequestNumber);
    if(response is PullRequestReview){
        createdPullRequestReviewId = <@untainted>response.id;
        test:assertTrue(true);
    }else {
       test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testUpdatePullRequest]
}
function testCreatePullRequestReviewWithPendingState() returns @tainted error? {
    log:printInfo("githubClient -> createPullRequestReview()");
    AddPullRequestReviewInput createPullRequestReviewInput = {
        body: "This is a test review comment for a pull  from Ballerina GitHub connector "
    };

    var response = githubClient->createPullRequestReview(createPullRequestReviewInput, testUserName, testUserRepositoryName, createdPullRequestNumber);
    if(response is PullRequestReview){
        createdPullRequestReviewIdWithPendingState = <@untainted>response.id;
        test:assertTrue(true);
    }else {
       test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreatePullRequestReview]
}
function testUpdatePullRequestReview() returns @tainted error? {
    log:printInfo("githubClient -> updatePullRequestReview()");
    UpdatePullRequestReviewInput updatePullRequestReviewInput = {
        pullRequestReviewId: createdPullRequestReviewId,
        body: "This is a test review comment for a pull  from Ballerina GitHub connector Updated"
    };
    var response = githubClient->updatePullRequestReview(updatePullRequestReviewInput);
    if(response is error){
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreatePullRequestReviewWithPendingState]
}
function testDeletePullRequestReview() returns @tainted error? {
    log:printInfo("githubClient -> deletePendingPullRequestReview()");
    DeletePullRequestReviewInput deletePullRequestReview = {
        pullRequestReviewId: createdPullRequestReviewIdWithPendingState
    };
    var response = githubClient->deletePendingPullRequestReview(deletePullRequestReview);
    if(response is error){
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetOrgProjectList() returns @tainted error? {
    log:printInfo("githubClient -> getOrganizationProjectList()");
    int perPageCount = 10;
    var response = githubClient->getOrganizationProjectList(testOrganizationName, PROJECT_OPEN, perPageCount);
    if(response is ProjectList){
        test:assertTrue(response.projects.length()>=0, msg = "Failed testGetOrgProjectList()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}


@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreateUserProject]
}
function testGetUserProject() returns @tainted error? {
    log:printInfo("githubClient -> getUserProject()");
    var response = githubClient->getUserProject(testUserName, createdProjectNumber);
    if(response is error){
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testGetUserProject]
}
function testUpdateProject() returns @tainted error? {
    log:printInfo("githubClient -> updateProject()");
    UpdateProjectInput updateProjectInput = {
        projectId: createdProjectId,
        name: "Test Project Created by Ballerina GitHub Connector UPDATED"
    };

    var response = githubClient->updateProject(updateProjectInput);
    if(response is error){
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testUpdateProject]
}
function testDeleteProject() returns @tainted error? {
    log:printInfo("githubClient -> deleteProject()");
    DeleteProjectInput deleteProjectInput = {
        projectId: createdProjectId
    };
    var response = githubClient->deleteProject(deleteProjectInput);
    if(response is error){
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoryProjectList() returns @tainted error? {
    log:printInfo("githubClient -> getRepositoryProjectList()");
    int perPageCount = 10;
    var response = githubClient->getRepositoryProjectList(testUserName, testUserRepositoryName, PROJECT_OPEN, perPageCount);
    if(response is ProjectList){
        test:assertTrue(response.projects.length()>=0, msg = "Failed testGetOrgProjectList()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetUserProjectList() returns @tainted error? {
    log:printInfo("githubClient -> getUserProjectList()");
    int perPageCount = 10;
    var response = githubClient->getUserProjectList(testUserName, perPageCount);
    if(response is ProjectList){
        test:assertTrue(response.projects.length()>=0, msg = "Failed testGetOrgProjectList()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetOrganization() returns @tainted error? {
    log:printInfo("githubClient -> getOrganization()");
    var response = githubClient->getOrganization(testOrganizationName);
    if(response is Organization){
        test:assertTrue(response.login==testOrganizationName, msg = "Failed testGetOrganization()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetUserOrganizationList() returns @tainted error? {
    log:printInfo("githubClient -> getUserOrganizationList()");
    int perPageCount = 10;
    var response = githubClient->getUserOrganizationList(testUserName, perPageCount);
    if(response is OrganizationList){
        test:assertTrue(response.organizations.length()>=0, msg = "Failed testGetOrgProjectList()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetOrganizationMembersList() returns @tainted error? {
    log:printInfo("githubClient -> getOrganizationMemberList()");
    int perPageCount = 10;
    var response = githubClient->getOrganizationMemberList(testOrganizationName, perPageCount);
    if(response is UserList){
        test:assertTrue(response.users.length()>=0, msg = "Failed testGetOrganizationMembersList()");
    }else {
        test:assertFail(msg = response.message()+response.message()+": "+ <string> check response.detail()["message"]);
    }
}
