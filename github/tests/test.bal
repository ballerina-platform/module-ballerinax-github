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

Client githubClient = new (gitHubConfig);

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetAuthenticatedUser() {
    log:printInfo("githubClient -> getAuthenticatedUser()");
    var response = githubClient->getAuthenticatedUser();
    if(response is User){
        test:assertEquals(response.login, testUserName, msg = "Failed getAuthenticatedUser()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetUserRepository() {
    log:printInfo("githubClient -> getUserRepository()");
    var response = githubClient->getUserRepository(testUserName, testUserRepositoryName);
    if(response is Repository){
        test:assertEquals(response.name, testUserRepositoryName, msg = "Failed testGetUserRepository()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetAuthenticatedUserRepositoryList() {
    log:printInfo("githubClient -> getAuthenticatedUserRepositoryList()");
    int perPageCount = 10;
    var response = githubClient->getAuthenticatedUserRepositoryList(perPageCount);
    if(response is RepositoryList){
        test:assertTrue(response.nodes.length()>0, msg = "Failed testGetAuthenticatedUserRepositoryList()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetUserRepositoryList() {
    log:printInfo("githubClient -> getUserRepositoryList()");
    int perPageCount = 10;
    var response = githubClient->getUserRepositoryList(testUserName, perPageCount);
    if(response is RepositoryList){
        test:assertTrue(response.length()>0, msg = "Failed testGetUserRepositoryList()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetOrganizationRepositoryList() {
    log:printInfo("githubClient -> getOrganizationRepositoryList()");
    int perPageCount = 10;
    var response = githubClient->getOrganizationRepositoryList(testOrganizationName,perPageCount);
    if(response is RepositoryList){
        test:assertTrue(response.length()>0, msg = "Failed testGetOrganizationRepositoryList()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoryCollobaratorList() {
    log:printInfo("githubClient -> getRepositoryCollobaratorList()");
    int perPageCount = 10;
    var response = githubClient->getRepositoryCollobaratorList(testUserName, testUserRepositoryName, perPageCount);
    if(response is CollaboratorList){
        test:assertTrue(response.nodes.length()>0, msg = "Failed testGetRepositoryCollobaratorList()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoryBranchList() {
    log:printInfo("githubClient -> getRepositoryBranchList()");
    int perPageCount = 10;
    var response = githubClient->getRepositoryBranchList(testUserName, testUserRepositoryName, perPageCount);
    if(response is BranchList){
        test:assertTrue(response.nodes.length()>0, msg = "Failed testGetRepositoryBranchList()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testUpdateRepository() {
    log:printInfo("githubClient -> updateRepository()");
    UpdateRepositoryInput updateRepositoryInput = {
        description: "New Updated Description"
    };
    var response = githubClient->updateRepository(updateRepositoryInput, testUserName, testUserRepositoryName);

    if(response is error){
        test:assertFail(msg = response.message());
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetIssueListAssignedToUser() {
    log:printInfo("githubClient -> getRepositoryIssueListAssignedToUser()");
    int perPageCount = 10;
    var response = githubClient->getRepositoryIssueListAssignedToUser(testUserName, testUserRepositoryName, testIssueAssignee, perPageCount);
    if(response is IssueList){
        test:assertTrue(response.nodes.length()>=0, msg = "Failed testGetIssueListAssignedToUser()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetIssueList() {
    log:printInfo("githubClient -> getRepositoryIssueList()");
    int perPageCount = 10;
    var response = githubClient->getRepositoryIssueList(testUserName, testUserRepositoryName, [ISSUE_OPEN], perPageCount);
    if(response is IssueList){
        test:assertTrue(response.nodes.length()>=0, msg = "Failed testGetIssueList()");
    }else {
        test:assertFail(msg = response.message());
    }
}
string createdIssueId = "";
int createdIssueNumber = -1;
@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testCreateIssue() {
    log:printInfo("githubClient -> createIssue()");
    CreateIssueInput updateRepositoryInput = {
        title: "This is a test Issue Title"
    };

    var response = githubClient->createIssue(updateRepositoryInput, testUserName, testUserRepositoryName);

    if(response is Issue){
        createdIssueId = response.id;
        createdIssueNumber = response.number;
        test:assertTrue(true);
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreateIssue]
}
function testUpdateIssue() {
    log:printInfo("githubClient -> updateIssue()");
    UpdateIssueInput updateRepositoryInput = {
        id: createdIssueId,
        title: "Updated issue title"
    };

    var response = githubClient->updateIssue(updateRepositoryInput, testUserName, testUserRepositoryName, createdIssueNumber);

    if(response is Issue){
        test:assertTrue(true);
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreateIssue]
}
function testGetIssue() {
    log:printInfo("githubClient -> getRepositoryIssue()");
    var response = githubClient->getRepositoryIssue(testUserName, testUserRepositoryName, createdIssueNumber);
    if(response is Issue){
        test:assertTrue(response.number==createdIssueNumber, msg = "Failed testGetIssue()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testAddComment]
}
function testGetIssueCommentList() {
    log:printInfo("githubClient -> getRepositoryIssueCommentList()");
    int perPageCount = 10;

    var response = githubClient->getRepositoryIssueCommentList(testUserName, testUserRepositoryName, createdIssueNumber, perPageCount);
    if(response is IssueCommentList){
        test:assertTrue(response.length()>=0, msg = "Failed testGetIssue()");
    }else {
        test:assertFail(msg = response.message());
    }
}
string createdIssueCommentId="";
@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreateIssue]
}
function testAddComment() {
    log:printInfo("githubClient -> addComment()");
    AddCommentInput updateRepositoryInput = {
        subjectId: createdIssueId,
        body: "Comment Added by Ballerina GitHub connector!"
    };
    var response = githubClient->addComment(updateRepositoryInput);

    if(response is IssueComment){
        createdIssueCommentId = response.id;
        test:assertTrue(true);
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testGetIssueCommentList]
}
function testUpdateComment() {
    log:printInfo("githubClient -> updateComment()");
    UpdateIssueCommentInput updateIssueComment = {
        id: createdIssueCommentId,
        body: "new comment added with addComment() UPDATED"
    };
    var response = githubClient->updateComment(updateIssueComment);

    if(response is error){
        test:assertFail(msg = response.message());
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testUpdateComment]
}
function testDeleteComment() {
    log:printInfo("githubClient -> addComment()");
    DeleteIssueCommentInput deleteIssueComment = {
        id: createdIssueCommentId
    };
    var response = githubClient->deleteComment(deleteIssueComment);

    if(response is error){
        test:assertFail(msg = response.message());
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoryLabel() {
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
function testGetRepositoryLabelListInIssue() {
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
function testAddLabelsToLabelable() {
    log:printInfo("githubClient -> addLabelsToLabelable()");
    AddLabelsToLabelableInput addLabelInput = {
        labelableId: createdIssueId,
        labelIds: ["MDU6TGFiZWwyNTc0ODMzODMy", "MDU6TGFiZWwyNTc0ODMzODM3"] // ids of bug, duplicate labels
    };
    var response = githubClient->addLabelsToLabelable(addLabelInput);
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
function testRemoveLabelsFromLabelable() {
    log:printInfo("githubClient -> removeLabelFromLabelable()");
    RemoveLabelsFromLabelableInput addLabelInput = {
        labelableId: createdIssueId,
        labelIds: ["MDU6TGFiZWwyNTc0ODMzODMy", "MDU6TGFiZWwyNTc0ODMzODM3"] // ids of bug, duplicate labels
    };
    var response = githubClient->removeLabelFromLabelable(addLabelInput);
     if(response is error){
        test:assertFail(msg = response.message());
     }else {
        test:assertTrue(true);
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetIssuesWithLabel() {
    log:printInfo("githubClient -> getIssuesWithLabel()");
    int perPageCount = 10;
    string label = "bug";
    var response = githubClient->getIssuesWithLabel(testUserName, testUserRepositoryName, label, perPageCount);
     if(response is error){
        test:assertFail(msg = response.message());
     }else {
        test:assertTrue(true);
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoryMilestoneList() {
    log:printInfo("githubClient -> getRepositoryMilestoneList()");
    int perPageCount = 10;
    var response = githubClient->getRepositoryMilestoneList(testUserName, testUserRepositoryName, perPageCount);
     if(response is MilestoneList){
         test:assertTrue(response.nodes.length()>=0, msg = "Failed testGetRepositoryMilestoneList()");
     }else {
         test:assertFail(msg = response.message());
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoryMilestone() {
    log:printInfo("githubClient -> getRepositoryMilestone()");
    var response = githubClient->getRepositoryMilestone(testUserName, testUserRepositoryName, 6);
     if(response is Milestone){
         test:assertTrue(response.number==6, msg = "Failed testGetRepositoryMilestoneList()");
     }else {
         test:assertFail(msg = response.message());
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetPullRequest() {
    log:printInfo("githubClient -> getPullRequest()");
    var response = githubClient->getPullRequest(testUserName, testUserRepositoryName, 488);
     if(response is PullRequest){
         test:assertTrue(response.number==488, msg = "Failed testGetPullRequest()");
     }else {
         test:assertFail(msg = response.message());
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetPullRequestList() {
    log:printInfo("githubClient -> getRepositoryPullRequestList()");
    int perPageCount = 10;
    var response = githubClient->getRepositoryPullRequestList(testUserName, testUserRepositoryName, PULL_REQUEST_OPEN, perPageCount);
     if(response is PullRequestList){
         test:assertTrue(response.length()>=0, msg = "Failed testGetPullRequest()");
     }else {
         test:assertFail(msg = response.message());
     }
}
string createdPullRequestId="";
int createdPullRequestNumber=-1;
@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testCreatePullRequest() {
    log:printInfo("githubClient -> createPullRequest()");
    CreatePullRequestInput createPullRequestInput = {
       title: "Test PR created from Ballerina GitHub Connector",
       baseRefName: "master",
       headRefName: "feature11",
       body: "This is some dummy content for PR body"
    };
    var response = githubClient->createPullRequest(createPullRequestInput, testUserName, testUserRepositoryName);
     if(response is PullRequest){
         createdPullRequestId = response.id;
         createdPullRequestNumber = <int>(response?.number);
         test:assertTrue(true);
     }else {
         test:assertFail(msg = response.message());
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreatePullRequest]
}
function testUpdatePullRequest() {
    log:printInfo("githubClient -> updatePullRequest()");
    UpdatePullRequestInput updatePullRequestInput = {
       pullRequestId: createdPullRequestId,
       title: "Test PR created from Ballerina GitHub Connector Updated"
    };

    var response = githubClient->updatePullRequest(updatePullRequestInput, testUserName, testUserRepositoryName, createdPullRequestNumber);
     if(response is error){
         test:assertFail(msg = response.message());
     }else {
         test:assertTrue(true);
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testDeletePullRequestReview]
}
function testUpdatePullRequestToClose() {
    log:printInfo("githubClient -> updatePullRequest()");
    UpdatePullRequestInput updatePullRequestInput = {
       pullRequestId: createdPullRequestId,
       state: PULL_REQUEST_CLOSED
    };

    var response = githubClient->updatePullRequest(updatePullRequestInput, testUserName, testUserRepositoryName, createdPullRequestNumber);
     if(response is error){
         test:assertFail(msg = response.message());
     }else {
         test:assertTrue(true);
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreatePullRequestReview]
}
function testGetPullRequestReviewCommentList() {
    log:printInfo("githubClient -> getPullRequestReviewCommentList()");
    int pullRequestNumber = 165;
    int perPageCount = 10;
    var response = githubClient->getPullRequestReviewCommentList(testUserName, testUserRepositoryName, createdPullRequestNumber, perPageCount);
     if(response is PullRequestReviewList){
         test:assertTrue(response.nodes.length()>=0, msg = "Failed testGetPullRequest()");
     }else {
         test:assertFail(msg = response.message());
     }
}

string createdPullRequestReviewId = "";
string createdPullRequestReviewIdWithPendingState = "";
@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testUpdatePullRequest]
}
function testCreatePullRequestReview() {
    log:printInfo("githubClient -> createPullRequestReview()");
    AddPullRequestReviewInput createPullRequestReviewInput = {
        body: "This is a test review comment for a pull  from Ballerina GitHub connector ",
        event: PULL_REQUEST_REVIEW_COMMENT
    };

    var response = githubClient->createPullRequestReview(createPullRequestReviewInput, testUserName, testUserRepositoryName, createdPullRequestNumber);
    if(response is PullRequestReview){
        createdPullRequestReviewId = response.id;
        test:assertTrue(true);
    }else {
       test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testUpdatePullRequest]
}
function testCreatePullRequestReviewWithPendingState() {
    log:printInfo("githubClient -> createPullRequestReview()");
    AddPullRequestReviewInput createPullRequestReviewInput = {
        body: "This is a test review comment for a pull  from Ballerina GitHub connector "
    };

    var response = githubClient->createPullRequestReview(createPullRequestReviewInput, testUserName, testUserRepositoryName, createdPullRequestNumber);
    if(response is PullRequestReview){
        createdPullRequestReviewIdWithPendingState = response.id;
        test:assertTrue(true);
    }else {
       test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreatePullRequestReview]
}
function testUpdatePullRequestReview() {
    log:printInfo("githubClient -> updatePullRequestReview()");
    UpdatePullRequestReviewInput updatePullRequestReviewInput = {
        pullRequestReviewId: createdPullRequestReviewId,
        body: "This is a test review comment for a pull  from Ballerina GitHub connector Updated"
    };
    var response = githubClient->updatePullRequestReview(updatePullRequestReviewInput);
    if(response is error){
        test:assertFail(msg = response.message());
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreatePullRequestReviewWithPendingState]
}
function testDeletePullRequestReview() {
    log:printInfo("githubClient -> deletePendingPullRequestReview()");
    DeletePullRequestReviewInput deletePullRequestReview = {
        pullRequestReviewId: createdPullRequestReviewIdWithPendingState
    };
    var response = githubClient->deletePendingPullRequestReview(deletePullRequestReview);
    if(response is error){
        test:assertFail(msg = response.message());
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetOrgProjectList() {
    log:printInfo("githubClient -> getOrganizationProjectList()");
    int perPageCount = 10;
    var response = githubClient->getOrganizationProjectList(testOrganizationName, PROJECT_OPEN, perPageCount);
    if(response is ProjectList){
        test:assertTrue(response.nodes.length()>=0, msg = "Failed testGetOrgProjectList()");
    }else {
        test:assertFail(msg = response.message());
    }
}
string createdProjectId = "";
int createdProjectNumber =-1;
@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testCreateUserProject() returns error? {
    log:printInfo("githubClient -> createProject()");
    string userId = check githubClient->getUserId(testUserName);
    CreateProjectInput createProjectInput = {
        ownerId: userId,
        name: "Test Project Created by Ballerina GitHub Connector"
    };
    var response = githubClient->createProject(createProjectInput);
    if(response is Project){
        createdProjectId = response.id;
        createdProjectNumber = <int>(response?.number);
        test:assertTrue(true);
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreateUserProject]
}
function testGetUserProject() {
    log:printInfo("githubClient -> getUserProject()");
    var response = githubClient->getUserProject(testUserName, createdProjectNumber);
    if(response is error){
        test:assertFail(msg = response.message());
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testGetUserProject]
}
function testUpdateProject() {
    log:printInfo("githubClient -> updateProject()");
    UpdateProjectInput updateProjectInput = {
        projectId: createdProjectId,
        name: "Test Project Created by Ballerina GitHub Connector UPDATED"
    };

    var response = githubClient->updateProject(updateProjectInput);
    if(response is error){
        test:assertFail(msg = response.message());
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testUpdateProject]
}
function testDeleteProject() {
    log:printInfo("githubClient -> deleteProject()");
    DeleteProjectInput deleteProjectInput = {
        projectId: createdProjectId
    };
    var response = githubClient->deleteProject(deleteProjectInput);
    if(response is error){
        test:assertFail(msg = response.message());
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoryProjectList() {
    log:printInfo("githubClient -> getRepositoryProjectList()");
    int perPageCount = 10;
    var response = githubClient->getRepositoryProjectList(testUserName, testUserRepositoryName, PROJECT_OPEN, perPageCount);
    if(response is ProjectList){
        test:assertTrue(response.nodes.length()>=0, msg = "Failed testGetOrgProjectList()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetUserProjectList() {
    log:printInfo("githubClient -> getUserProjectList()");
    int perPageCount = 10;
    var response = githubClient->getUserProjectList(testUserName, perPageCount);
    if(response is ProjectList){
        test:assertTrue(response.nodes.length()>=0, msg = "Failed testGetOrgProjectList()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetOrganization() {
    log:printInfo("githubClient -> getOrganization()");
    var response = githubClient->getOrganization(testOrganizationName);
    if(response is Organization){
        test:assertTrue(response.login==testOrganizationName, msg = "Failed testGetOrganization()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetUserOrganizationList() {
    log:printInfo("githubClient -> getUserOrganizationList()");
    int perPageCount = 10;
    var response = githubClient->getUserOrganizationList(testUserName, perPageCount);
    if(response is OrganizationList){
        test:assertTrue(response.nodes.length()>=0, msg = "Failed testGetOrgProjectList()");
    }else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetOrganizationMembersList() {
    log:printInfo("githubClient -> getOrganizationMemberList()");
    int perPageCount = 10;
    var response = githubClient->getOrganizationMemberList(testOrganizationName, perPageCount);
    if(response is UserList){
        test:assertTrue(response.nodes.length()>=0, msg = "Failed testGetOrganizationMembersList()");
    }else {
        test:assertFail(msg = response.message());
    }
}
