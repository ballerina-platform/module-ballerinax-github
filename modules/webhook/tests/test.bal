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

import ballerina/config;
import ballerina/http;
import ballerina/oauth2;
import ballerina/runtime;
import ballerina/test;
import ballerina/websub;
import github.'client as github;

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

listener Listener githubListener = new(8080);

oauth2:DirectTokenConfig oauth2Config = {
    accessToken: config:getAsString("ACCESS_TOKEN")
};
oauth2:OutboundOAuth2Provider oauth2Provider = new(oauth2Config);
http:BearerAuthHandler bearerHandler = new(oauth2Provider);

@websub:SubscriberServiceConfig {
    subscribeOnStartUp: true,
    target: [HUB, config:getAsString("TOPIC_GITHUB")],
    secret: config:getAsString("SECRET_GITHUB"),
    callback: config:getAsString("CALLBACK_GITHUB"),
    hubClientConfig: {
        auth: {
            authHandler: bearerHandler
        }
    }
}
service websub:SubscriberService /github on githubListener {
 remote function onPing(websub:Notification notification, PingEvent event) {
     webhookRegistrationNotified = true;
     webhookHookType = <@untainted> event.hook.'type;
 }

 remote function onIssuesOpened(websub:Notification notification, IssuesEvent event) {
     issueCreationNotified = true;
     issueTitle = <@untainted> event.issue.title;
 }

 remote function onIssuesLabeled(websub:Notification notification, IssuesEvent event) {
     issueLabeledNotified = true;
     string receivedIssueLabels = "";
     foreach Label label in event.issue.labels {
         receivedIssueLabels += label.name;
     }
     issueLabels = <@untainted> receivedIssueLabels;
 }

 remote function onIssuesAssigned(websub:Notification notification, IssuesEvent event) {
     issueAssignedNotified = true;
     User assignee = <User> event.issue.assignee;
     issueAssignee = <@untainted> assignee.login;
 }

 remote function onIssuesEdited(websub:Notification notification, IssuesEvent event) {
     issueEditedNotified = true;
     issueChanges = <@untainted> event["changes"];
 }
}


@test:Config {
    enable:false
}
function testWebhookRegistration() {
    int counter = 10;
    while (!webhookRegistrationNotified && counter >= 0) {
        runtime:sleep(1000);
        counter -= 1;
    }
    test:assertTrue(webhookRegistrationNotified,
                 msg = "expected a webhook to be registered and receive a ping notification");
    test:assertEquals(webhookHookType, "Repository", msg = "expected a repository hook to be added");
}

string createdIssueUsername = config:getAsString("USERNAME_GITHUB");
string createdIssueRepoName = config:getAsString("REPO_NAME");
string createdIssueTitle = "This is a test issue";
string[] createdIssueLabelArray = ["bug", "critical"];
string createdIssueAssignee = createdIssueUsername;

@test:Config {
    dependsOn: ["testWebhookRegistration"],
    enable:false
}
function testWebhookNotificationOnIssueCreation() {
    github:GitHubConfiguration gitHubConfig = {
        accessToken: config:getAsString("ACCESS_TOKEN")
    };

    github:Client githubClient = new (gitHubConfig);

    var issueCreationStatus = githubClient->createIssue(createdIssueUsername, "github-connector", createdIssueTitle,
                                         "This is the body of the test issue: webhook", createdIssueLabelArray,
                                         [createdIssueAssignee]);
    if (issueCreationStatus is error) {
        test:assertFail(msg = "Issue creation failed: " + issueCreationStatus.message());
    }

    int counter = 10;
    while (!issueCreationNotified && counter >= 0) {
        runtime:sleep(1000);
        counter -= 1;
    }
    test:assertTrue(issueCreationNotified, msg = "expected an issue creation notification");
    test:assertEquals(issueTitle, createdIssueTitle, msg = "invalid issue title");
}

@test:Config {
    dependsOn: ["testWebhookNotificationOnIssueCreation"],
    enable:false
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
    dependsOn: ["testWebhookNotificationOnIssueCreation"],
    enable:false
}
function testWebhookNotificationOnIssueAssignment() {
    test:assertTrue(issueAssignedNotified, msg = "expected an issue assigned notification");
    test:assertEquals(issueAssignee, createdIssueAssignee, msg = "invalid issue labels");
}

@test:Config {
    dependsOn: ["testWebhookNotificationOnIssueCreation"],
    enable: false // Disable the test as ballerinax/github module hasn't any function to edit the issue
}
function testWebhookNotificationOnIssueEdited() {
    test:assertTrue(issueEditedNotified, msg = "expected an issue edited notification");
    if (issueChanges is ()) {
        test:assertFail(msg = "expected `issueChanges` to not be `()`");
    }
}
