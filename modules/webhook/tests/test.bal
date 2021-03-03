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

import ballerina/lang.runtime;
import ballerina/test;
import ballerina/websub;
import ballerinax/github;
import ballerina/log;

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

listener Listener githubListener = new(8080);

configurable string & readonly githubTopic = ?;
configurable string & readonly githubSecret = ?;
configurable string & readonly githubCallback = ?;
configurable string & readonly testIssueAssignee = ?;
configurable string & readonly testUserName = ?;
configurable string & readonly accessToken = ?;

@websub:SubscriberServiceConfig {
    target: [HUB, githubTopic],
    secret: githubSecret,
    callback: githubCallback,
    httpConfig: {
        auth: {
            token: accessToken
        }
    }
}
service /subscriber on githubListener {
      remote function onEventNotification(websub:ContentDistributionMessage event) {
            var payload = githubListener.getEventType(event);
            if(payload is PingEvent) {
                webhookRegistrationNotified = true;
                webhookHookType = <@untainted> payload.hook.'type;
            }else if (payload is IssuesEvent) {
                if (payload.action == ISSUE_OPENED) {
                    log:print("Issue opened");
                    issueCreationNotified = true;
                    issueTitle = <@untainted> payload.issue.title;
                }else if (payload.action == ISSUE_LABELED) {
                    log:print("Issue labeled");
                    issueLabeledNotified = true;
                    string receivedIssueLabels = "";
                    foreach Label label in payload.issue.labels {
                        receivedIssueLabels += label.name;
                    }
                    issueLabels = <@untainted> receivedIssueLabels;
                }else if (payload.action == ISSUE_ASSIGNED) {
                    log:print("Issue assigned");
                    issueAssignedNotified = true;
                    User assignee = <User> payload.issue.assignee;
                    issueAssignee = <@untainted> assignee.login;
                }else if (payload.action == ISSUE_EDITED) {
                    log:print("Issue edited");
                    issueEditedNotified = true;
                    issueChanges = <@untainted> payload["changes"];
                }
            }else if (payload is PushEvent) {
                log:print("Push Event Received");
                log:print("Commits: ", commits = payload.commits);
            }
      }

      

}


@test:Config {
    enable:true
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
    enable: true
}
function testWebhookNotificationOnIssueCreation() {
    github:GitHubConfiguration gitHubConfig = {
        accessToken: accessToken
    };

    github:Client githubClient = new (gitHubConfig);

    var issueCreationPayload = githubClient->createIssue(testUserName, "github-connector", createdIssueTitle,
                                         "This is the body of the test issue: webhook", createdIssueLabelArray,
                                         [createdIssueAssignee]);
    if (issueCreationPayload is error) {
        test:assertFail(msg = "Issue creation failed: " + issueCreationPayload.message());
    }else {
        createdIssueNumber = issueCreationPayload.number;
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
    enable: true
}
function testWebhookNotificationOnIssueAssignment() {
    test:assertTrue(issueAssignedNotified, msg = "expected an issue assigned notification");
    test:assertEquals(issueAssignee, createdIssueAssignee, msg = "invalid issue labels");
}

@test:Config {
    dependsOn: [testWebhookNotificationOnIssueCreation],
    enable: true 
}
function testWebhookNotificationOnIssueEdited() returns error? {

    github:GitHubConfiguration gitHubConfig = {
        accessToken: accessToken
    };

    github:Client githubClient = new (gitHubConfig);

    var updatedIssue = githubClient->updateIssue(testIssueAssignee, "github-connector", createdIssueNumber,
    updatedIssueTitle, "This is the body of the test issue updated", ["bug", "critical"], [testIssueAssignee], "open");
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
