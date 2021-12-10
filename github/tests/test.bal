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
configurable string testUsername = os:getEnv("GITHUB_USERNAME");
configurable string authToken = os:getEnv("ACCESS_TOKEN");

ConnectionConfig gitHubConfig = {
    auth: {
        token: authToken
    }
};

Client githubClient = checkpanic new (gitHubConfig);

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetUser(){
    log:printInfo(" Testing githubClient -> getUser()");
    User|Error response = githubClient->getUser();
    if response is User {
        test:assertEquals(response.login, testUsername, msg = "Failed getUser() funtion for authenticated user");
    } else {
        test:assertFail(response.toString());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetUserWithGivenUsername(){
    log:printInfo("Testing githubClient -> getUser() with a given username");
    User|Error response = githubClient->getUser(testUsername);
    if response is User {
        test:assertEquals(response.login, testUsername, msg = "Failed getUser() funtion for a given username");
    } else {
        test:assertFail(response.toString());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepository(){
    log:printInfo("Testing githubClient -> getRepository()");
    Repository|Error response = githubClient->getRepository(testUsername, testUserRepositoryName);
    if(response is Repository){
        test:assertEquals(response.name, testUserRepositoryName, msg = "Failed testGetUserRepository()");
    }else {
        test:assertFail(response.toString());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositories() returns @tainted Error? {
    log:printInfo("Testing githubClient -> getRepositories() for authenticated user");
    stream<Repository,Error?> response = check githubClient->getRepositories();
    
    test:assertTrue(response.next() is record {| Repository value; |},
                     msg = "Failed testGetRepositories() for authenticated user");
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoriesOfGivenUser() returns @tainted Error? {
    log:printInfo("Testing githubClient -> getRepositories() for a given user");
    stream<Repository,Error?> response = check githubClient->getRepositories(testUsername);
    test:assertTrue(response.next() is record {| Repository value; |},
                    msg = "Failed testGetRepositories() for a given user");
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoriesOfGivenOrganization() returns @tainted Error? {
    log:printInfo("Testing githubClient -> getRepositories() for a given organization");
    stream<Repository,Error?> response = check githubClient->getRepositories(testOrganizationName, true);
    test:assertTrue(response.next() is record {| Repository value; |},
                    msg = "Failed testGetRepositories() for a given organization");
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetCollaborators() returns @tainted Error? {
    log:printInfo("githubClient -> getCollaborators()");
    stream<User,Error?> response = check githubClient->getCollaborators(testUsername, testUserRepositoryName);
    test:assertTrue(response.next() is record {| User value; |});
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testgetBranches() returns @tainted Error? {
    log:printInfo("githubClient -> getBranches()");
    stream<Branch,Error?> response = check githubClient->getBranches(testUsername, testUserRepositoryName);
    test:assertTrue(response.next() is record {| Branch value; |});
}

@test:Config {
    groups: ["network-calls"],
    enable: false // This test case have been disabled as this operation cannot be run continuosly without 
                  // deleteRepository operation which is not yet supported by the GitHub GraphQL API.
}
function testCreateRepository() returns @tainted Error? {
    log:printInfo("githubClient -> createRepository()");
    CreateRepositoryInput createRepositoryInput = {
        name: "ballerina-github-connector-test-repo",
        visibility: PUBLIC_REPOSITORY,
        description: "New Updated Description"
    };
    check githubClient->createRepository(createRepositoryInput);
    test:assertTrue(true);
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testUpdateRepository() returns @tainted Error? {
    log:printInfo("githubClient -> updateRepository()");
    UpdateRepositoryInput updateRepositoryInput = {
        description: "New Updated Description"
    };
    check githubClient->updateRepository(updateRepositoryInput, testUsername, testUserRepositoryName);
    test:assertTrue(true);
}

string milestoneId="";

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetMilestone() returns @tainted Error? {
    log:printInfo("githubClient -> getMilestone()");
    var response = githubClient->getMilestone(testUsername, testUserRepositoryName, 2);
     if(response is Milestone){
         test:assertTrue(response.number==2, msg = "Failed testgetMilestones()");
         milestoneId=response.id;
     }else {
         test:assertFail(msg = response.toString());
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetMilestones() returns @tainted Error? {
    log:printInfo("githubClient -> getMilestones()");
    stream<Milestone,Error?> response = check githubClient->getMilestones(testUsername, testUserRepositoryName);
    test:assertTrue(response.next() is record {| Milestone value; |});
}

string createdProjectId = "";
int createdProjectNumber =-1;
@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testCreateUserProject() returns @tainted Error? {
    log:printInfo("githubClient -> createProject()");
    CreateRepositoryProjectInput createRepositoryProjectInput = {
        ownerName: testUsername,
        name: "Test Project Created by Ballerina GitHub Connector",
        body: "This is the body of the test project"
    };
    var response = githubClient->createProject(createRepositoryProjectInput);
    if(response is Project){
        createdProjectId = <@untainted>response.id;
        createdProjectNumber = <@untainted>(<int>(response?.number));
        test:assertTrue(true);
    }else {
        test:assertFail(msg = response.toString());
    }
}

string createdIssueId = "";
int createdIssueNumber = -1;
@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testGetMilestone, testCreateUserProject]
}
function testCreateIssue() returns @tainted Error?{
    log:printInfo("githubClient -> createIssue()");
    CreateIssueInput createIssueInput = {
        title: "This is a test Issue Title",
        body: "This is test issue body",
        labelNames: ["bug"],
        assigneeNames: [testUsername],
        projectIds: [createdProjectId],
        milestoneId: milestoneId
    };

    var response = githubClient->createIssue(createIssueInput, testUsername, testUserRepositoryName);

    if(response is Issue){
        createdIssueId = <@untainted>response.id;
        createdIssueNumber = <@untainted>response.number;
        test:assertTrue(true);
    }else {
        test:assertFail(msg = response.toString());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreateIssue]
}
function testUpdateIssue() returns @tainted Error? {
    log:printInfo("githubClient -> updateIssue()");
    UpdateIssueInput updateRepositoryInput = {
        title: "Updated issue title",
        body: "This is updated test issue body",
        labelNames: ["enhancement"],
        assigneeNames: [testUsername],
        milestoneId: milestoneId
    };

    var response = githubClient->updateIssue(updateRepositoryInput, testUsername, testUserRepositoryName, createdIssueNumber);

    if(response is Issue){
        test:assertTrue(true);
    }else {
        test:assertFail(msg = response.toString());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreateIssue]
}
function testGetIssue() returns @tainted Error? {
    log:printInfo("githubClient -> getIssue()");
    Issue response = check githubClient->getIssue(testUsername, testUserRepositoryName, createdIssueNumber);
    test:assertTrue(response.number==createdIssueNumber, msg = "Failed testGetIssue()");
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetIssues() returns @tainted Error? {
    log:printInfo("githubClient -> getIssues()");
    IssueFilters issueFilters = {
        assignee: testUsername,
        labels: ["good first issue"]
    };
    stream<Issue,Error?> response = check githubClient->getIssues(testUsername, testUserRepositoryName, issueFilters);
    test:assertTrue(response.next() is record {| Issue value; |});
}

string createdIssueCommentId="";
@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreateIssue]
}
function testAddComment() returns @tainted Error? {
    log:printInfo("githubClient -> addComment()");
    AddIssueCommentInput addIssueCommentInput = {
        repositoryOwnerName: testUsername,
        repositoryName: testUserRepositoryName,
        issueNumber: createdIssueNumber,
        body: "Comment Added by Ballerina GitHub connector!"
    };
    var response = githubClient->addComment(addIssueCommentInput);

    if(response is IssueComment){
        createdIssueCommentId = <@untainted>response.id;
        test:assertTrue(true);
    }else {
        test:assertFail(msg = response.toString());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testAddComment]
}
function testUpdateComment() returns @tainted Error?{
    log:printInfo("githubClient -> updateComment()");
    UpdateIssueCommentInput updateIssueComment = {
        id: createdIssueCommentId,
        body: "new comment added with addComment() UPDATED"
    };
    var response = githubClient->updateComment(updateIssueComment);

    if(response is Error){
        test:assertFail(msg = response.toString());
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testUpdateComment]
}
function testDeleteComment() returns @tainted Error? {
    log:printInfo("githubClient -> deleteComment()");
    DeleteIssueCommentInput deleteIssueComment = {
        id: createdIssueCommentId
    };
    var response = githubClient->deleteComment(deleteIssueComment);

    if(response is Error){
        test:assertFail(msg = response.toString());
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoryLabel() returns @tainted Error? {
    log:printInfo("githubClient -> getLabel()");
    string labelName = "bug";
    var response = githubClient->getLabel(testUsername, testUserRepositoryName, labelName);
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
function testGetLabels() returns @tainted Error? {
    log:printInfo("githubClient -> getLabels()");
    stream<Label,Error?> response = check githubClient->getLabels(testUsername, testUserRepositoryName, createdIssueNumber);
    test:assertTrue(response.next() is record {| Label value; |});
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreateIssue]
}
function testAddLabelsToLabelable() returns @tainted Error? {
    log:printInfo("githubClient -> addIssueLabel()");
    AddLabelsInput addIssueLabelInput = {
        repositoryOwnerName: testUsername,
        repositoryName: testUserRepositoryName, 
        issueNumber: createdIssueNumber,
        labelNames: ["bug"] 
    };
    var response = githubClient->addLabels(addIssueLabelInput);
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
function testRemoveLabelsFromLabelable() returns @tainted Error? {
    log:printInfo("githubClient -> removeLabel()");
    RemoveIssueLabelInput removeIssueLabelsInput = {
        repositoryOwnerName: testUsername,
        repositoryName: testUserRepositoryName,
        issueNumber: createdIssueNumber,
        labelNames: ["bug"] 
    };
    var response = githubClient->removeLabel(removeIssueLabelsInput);
     if(response is Error){
        test:assertFail(msg = response.toString());
     }else {
        test:assertTrue(true);
     }
}

string createdPullRequestId="";
int createdPullRequestNumber=-1;
@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testCreatePullRequest() returns @tainted Error? {
    log:printInfo("githubClient -> createPullRequest()");
    CreatePullRequestInput createPullRequestInput = {
       title: "Test PR created from Ballerina GitHub Connector",
       baseRefName: "master",
       headRefName: "feature/feature2",
       body: "This is some dummy content for PR body"
    };
    var response = githubClient->createPullRequest(createPullRequestInput, testUsername, testUserRepositoryName);
     if(response is PullRequest){
         createdPullRequestId = <@untainted>response.id;
         createdPullRequestNumber = <@untainted>(<int>(response?.number));
         test:assertTrue(true);
     }else {
         test:assertFail(msg = response.toString());
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreatePullRequest]
}
function testGetPullRequest() returns @tainted Error? {
    log:printInfo("githubClient -> getPullRequest()");
    var response = githubClient->getPullRequest(testUsername, testUserRepositoryName, createdPullRequestNumber);
     if(response is PullRequest){
         test:assertTrue(response.number==createdPullRequestNumber, msg = "Failed testGetPullRequest()");
     }else {
         test:assertFail(msg = response.toString());
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetPullRequestList() returns @tainted Error? {
    log:printInfo("githubClient -> getPullRequests()");
    stream<PullRequest,Error?> response = check githubClient->getPullRequests("ballerina-platform", "module-ballerinax-googleapis.gmail", PULL_REQUEST_MERGED);
    test:assertTrue(response.next() is record {| PullRequest value; |});
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreatePullRequest]
}
function testUpdatePullRequest() returns @tainted Error? {
    log:printInfo("githubClient -> updatePullRequest()");
    UpdatePullRequestInput updatePullRequestInput = {
       title: "Test PR created from Ballerina GitHub Connector Updated",
       labelNames: ["bug"],
       assigneeNames: ["MadhurangaWije"]
    };

    var response = githubClient->updatePullRequest(updatePullRequestInput, testUsername, testUserRepositoryName, createdPullRequestNumber);
     if(response is Error){
         test:assertFail(msg = response.toString());
     }else {
         test:assertTrue(true);
     }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testUpdatePullRequestToClose() returns @tainted Error? {
    log:printInfo("githubClient -> updatePullRequest()");
    UpdatePullRequestInput updatePullRequestInput = {
       state: PULL_REQUEST_CLOSED
    };

    var response = githubClient->updatePullRequest(updatePullRequestInput, testUsername, testUserRepositoryName, createdPullRequestNumber);
     if(response is Error){
         test:assertFail(msg = response.toString());
     }else {
         test:assertTrue(true);
     }
}

string createdPullRequestReviewId = "";
string createdPullRequestReviewIdWithPendingState = "";
@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testUpdatePullRequest]
}
function testCreatePullRequestReview() returns @tainted Error? {
    log:printInfo("githubClient -> createPullRequestReview()");
    AddPullRequestReviewInput createPullRequestReviewInput = {
        body: "This is a test review comment for a pull  from Ballerina GitHub connector ",
        event: PULL_REQUEST_REVIEW_COMMENT
    };

    var response = githubClient->createPullRequestReview(createPullRequestReviewInput, testUsername, testUserRepositoryName, createdPullRequestNumber);
    if(response is PullRequestReview){
        createdPullRequestReviewId = <@untainted>response.id;
        test:assertTrue(true);
    }else {
       test:assertFail(msg = response.toString());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testUpdatePullRequest]
}
function testCreatePullRequestReviewWithPendingState() returns @tainted Error? {
    log:printInfo("githubClient -> createPullRequestReview()");
    AddPullRequestReviewInput createPullRequestReviewInput = {
        body: "This is a test review comment for a pull  from Ballerina GitHub connector "
    };

    var response = githubClient->createPullRequestReview(createPullRequestReviewInput, testUsername, testUserRepositoryName, createdPullRequestNumber);
    if(response is PullRequestReview){
        createdPullRequestReviewIdWithPendingState = <@untainted>response.id;
        test:assertTrue(true);
    }else {
       test:assertFail(msg = response.toString());
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreatePullRequestReview]
}
function testUpdatePullRequestReview() returns @tainted Error? {
    log:printInfo("githubClient -> updatePullRequestReview()");
    UpdatePullRequestReviewInput updatePullRequestReviewInput = {
        pullRequestReviewId: createdPullRequestReviewId,
        body: "This is a test review comment for a pull  from Ballerina GitHub connector Updated"
    };
    var response = githubClient->updatePullRequestReview(updatePullRequestReviewInput);
    if(response is Error){
        test:assertFail(msg = response.toString());
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreatePullRequestReviewWithPendingState]
}
function testDeletePullRequestReview() returns @tainted Error? {
    log:printInfo("githubClient -> deletePendingPullRequestReview()");
    DeletePullRequestReviewInput deletePullRequestReview = {
        pullRequestReviewId: createdPullRequestReviewIdWithPendingState
    };
    var response = githubClient->deletePendingPullRequestReview(deletePullRequestReview);
    if(response is Error){
        test:assertFail(msg = response.toString());
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetOrgProjectList() returns @tainted Error? {
    log:printInfo("githubClient -> getOrganizationProjectList()");
    stream<Project,Error?> response = check githubClient->getProjects("wso2-enterprise", GITHUB_ORGANIZATION, (), PROJECT_OPEN);
    test:assertTrue(response.next() is record {| Project value; |});
}


@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testCreateUserProject]
}
function testGetUserProject() returns @tainted Error? {
    log:printInfo("githubClient -> getProject()");
    var response = githubClient->getProject(testUsername, createdProjectNumber);
    if(response is Error){
        test:assertFail(msg = response.toString());
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testGetUserProject]
}
function testUpdateProject() returns @tainted Error? {
    log:printInfo("githubClient -> updateProject()");
    UpdateProjectInput updateProjectInput = {
        projectId: createdProjectId,
        name: "Test Project Created by Ballerina GitHub Connector UPDATED"
    };

    var response = githubClient->updateProject(updateProjectInput);
    if(response is Error){
        test:assertFail(msg = response.toString());
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true,
    dependsOn: [testUpdateProject]
}
function testDeleteProject() returns @tainted Error? {
    log:printInfo("githubClient -> deleteProject()");
    DeleteProjectInput deleteProjectInput = {
        projectId: createdProjectId
    };
    var response = githubClient->deleteProject(deleteProjectInput);
    if(response is Error){
        test:assertFail(msg = response.toString());
    }else {
        test:assertTrue(true);
    }
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetRepositoryProjectList() returns @tainted Error? {
    log:printInfo("githubClient -> getRepositoryProjectList()");
    stream<Project,Error?> response = check githubClient->getProjects(testUsername, GITHUB_USER, testUserRepositoryName, PROJECT_OPEN);
    test:assertTrue(response.next() is record {| Project value; |});
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetUserProjectList() returns @tainted Error? {
    log:printInfo("githubClient -> getUserProjectList()");
    stream<Project,Error?> response = check githubClient->getProjects(testUsername, GITHUB_USER);
    test:assertTrue(response.next() is record {| Project value; |});
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetOrganization() returns @tainted Error? {
    log:printInfo("githubClient -> getOrganization()");
    stream<Organization,Error?> response = check githubClient->getOrganizations(testOrganizationName, GITHUB_ORGANIZATION);
    test:assertTrue(response.next() is record {| Organization value; |});
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetUserOrganizationList() returns @tainted Error? {
    log:printInfo("githubClient -> getUserOrganizationList()");
    stream<Organization,Error?> response = check githubClient->getOrganizations("kasthuriraajan", GITHUB_USER);
    test:assertTrue(response.next() is record {| Organization value; |});
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testGetOrganizationMembersList() returns @tainted Error? {
    log:printInfo("githubClient -> getOrganizationMembers()");
    stream<User,Error?> response = check githubClient->getOrganizationMembers("ballerina-platform");
    test:assertTrue(response.next() is record {| User value; |});
}

@test:Config {
    groups: ["network-calls"],
    enable: true
}
function testSearch() returns @tainted Error? {
    log:printInfo("githubClient -> search()");
    SearchResult response = check githubClient-> search("wso2",SEARCH_TYPE_USER, 10);
    var result = response.results;
    test:assertTrue(result is User[]|Organization[]);    
}
