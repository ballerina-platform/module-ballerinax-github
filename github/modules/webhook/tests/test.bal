// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import ballerina/test;
import ballerina/websub;
import ballerina/log;
import ballerina/lang.runtime;
import ballerinax/github;

listener Listener webhookListener = new (9090);
boolean webhookRegistrationNotified = false;
string webhookHookType = "";

boolean issueCreationNotified = false;
string issueTitle = "";

boolean issueLabeledNotified = false;
string issueLabels = "";

boolean issueAssignedNotified = false;
string issueAssignee = "";

boolean issueEditedNotified = false;
Changes? issueChanges = ();

int createdIssueNumber = -1;

configurable string githubTopic = ?;
configurable string githubSecret = ?;
configurable string githubCallback = ?;
configurable string testIssueAssignee = ?;
configurable string testUserName = ?;
configurable string authToken = ?;

@websub:SubscriberServiceConfig {
    target: [HUB, githubTopic],
    secret: githubSecret,
    callback: githubCallback,
    httpConfig: {
        auth: {
            token: authToken
        }
    }
}
service /subscriber on webhookListener {
    remote function onPing(PingEvent event) returns Acknowledgement? {
        log:printInfo("Received ping-event-message ", notificationMsg = event);
        webhookRegistrationNotified = true;
        webhookHookType = <@untainted> event.hook.'type;
        return {};
    }

    remote function onIssuesOpened(IssuesEvent event) returns Acknowledgement? {
        log:printInfo("Issue opened", notificationMsg = event);
        issueCreationNotified = true;
        issueTitle = <@untainted> event.issue.title;
    }

    remote function onIssuesEdited(IssuesEvent event) returns Acknowledgement? {
        log:printInfo("Issue edited");
        issueEditedNotified = true;
        issueChanges = <@untainted> event["changes"];
    }

    remote function onIssuesLabeled(IssuesEvent event) returns Acknowledgement? {
        log:printInfo("Issue labeled");
        issueLabeledNotified = true;
        string receivedIssueLabels = "";
        foreach Label label in event.issue.labels {
            receivedIssueLabels += label.name;
        }
        issueLabels = <@untainted> receivedIssueLabels;
    }

    remote function onIssuesAssigned(IssuesEvent event) returns Acknowledgement? {
       log:printInfo("Issue assigned");
       issueAssignedNotified = true;
       User assignee = <User> event.issue.assignee;
       issueAssignee = <@untainted> assignee.login;
    }

}

@test:Config {
    enable: false
}
function testWebhookRegistration() {
    int counter = 10;
    while (!webhookRegistrationNotified && counter >= 0) {
        runtime:sleep(1);
        counter -= 1;
    }
    test:assertTrue(webhookRegistrationNotified,
                 msg = "expected a webhook to be registered and receive a ping notification");
    test:assertEquals(webhookHookType, "Repository", msg = "expected a repository hook to be added");
}

string createdIssueTitle = "This is a test issue";
string updatedIssueTitle = "Updated Issue Title";
string[] createdIssueLabelArray = ["bug", "critical"];
string createdIssueAssignee = testIssueAssignee;

@test:Config {
    dependsOn: [testWebhookRegistration],
    enable: false
}
function testWebhookNotificationOnIssueCreation() {
    github:ConnectionConfig gitHubConfig = {
        auth: {
            token: authToken
        }
    };

    github:Client githubClient = checkpanic new (gitHubConfig);

    github:CreateIssueInput createIssueInput = {
        title: createdIssueTitle
    };

    var issueCreationPayload = githubClient->createIssue(createIssueInput, testUserName, "github-connector");

    if (issueCreationPayload is error) {
        test:assertFail(msg = "Issue creation failed: " + issueCreationPayload.message());
    }else {
        createdIssueNumber = <@untainted>issueCreationPayload.number;
    }

    int counter = 10;
    while (!issueCreationNotified && counter >= 0) {
        runtime:sleep(1);
        counter -= 1;
    }
    test:assertTrue(issueCreationNotified, msg = "expected an issue creation notification");
    test:assertEquals(issueTitle, createdIssueTitle, msg = "invalid issue title");
}

@test:Config {
    dependsOn: [testWebhookNotificationOnIssueCreation],
    enable: false
}
function testWebhookNotificationOnIssueLabeling() {
    string createdIssueLabelString = "";
    foreach string label in createdIssueLabelArray {
        createdIssueLabelString += label;
    }
    test:assertTrue(issueLabeledNotified, msg = "expected an issue labeled notification");
    test:assertEquals(issueLabels, createdIssueLabelString, msg = "invalid issue labels");
}

@test:Config {
    dependsOn: [testWebhookNotificationOnIssueCreation],
    enable: false
}
function testWebhookNotificationOnIssueAssignment() {
    test:assertTrue(issueAssignedNotified, msg = "expected an issue assigned notification");
    test:assertEquals(issueAssignee, createdIssueAssignee, msg = "invalid issue labels");
}

@test:Config {
    dependsOn: [testWebhookNotificationOnIssueCreation],
    enable: false
}
function testWebhookNotificationOnIssueEdited() returns error? {

    github:ConnectionConfig gitHubConfig = {
        auth: {
            token: authToken
        }
    };

    github:Client githubClient = checkpanic new (gitHubConfig);

    github:UpdateIssueInput updateRepositoryInput = {
        title: updatedIssueTitle
    };

    var updatedIssue = githubClient->updateIssue(updateRepositoryInput, testUserName, "github-connector", createdIssueNumber);

    if (updatedIssue is error) {
        test:assertFail(msg = "Issue edit failed: "+updatedIssue.message());
    }

    int counter = 10;
    while (!issueEditedNotified && counter >= 0) {
        runtime:sleep(1);
        counter -= 1;
    }
    test:assertTrue(issueEditedNotified, msg = "expected an issue edited notification");
}
