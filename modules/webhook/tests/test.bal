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
import ballerina/io;

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

// listener Listener githubListener = new(8080);
listener websub:Listener githubListener = new(8080);

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
service /github on githubListener {

    isolated remote function onSubscriptionVerification(websub:SubscriptionVerification msg) returns websub:SubscriptionVerificationSuccess|websub:SubscriptionVerificationError {
      // execute subscription verification action
        io:println("on subscription verification");
        io:println(msg);
        websub:SubscriptionVerificationSuccess svs = {
            headers: {
                "Content-Encoding": "application/json"
            },
            body: {
                "message": "Successfully processed request"
            }
        };
        return svs;
    }

    remote function onEventNotification(websub:ContentDistributionMessage event) {
      // execute event notification received action
      io:println("on Event Notification");
      io:println(event);
      webhookRegistrationNotified = true;
    }

}


@test:Config {
    enable:true
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


string createdIssueTitle = "This is a test issue";
string[] createdIssueLabelArray = ["bug", "critical"];
string createdIssueAssignee = testIssueAssignee;

@test:Config {
    dependsOn: [testWebhookRegistration],
    enable:false
}
function testWebhookNotificationOnIssueCreation() {
    github:GitHubConfiguration gitHubConfig = {
        accessToken: accessToken
    };

    github:Client githubClient = new (gitHubConfig);

    var issueCreationStatus = githubClient->createIssue(testUserName, "github-connector", createdIssueTitle,
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
    dependsOn: [testWebhookNotificationOnIssueCreation],
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
    dependsOn: [testWebhookNotificationOnIssueCreation],
    enable:false
}
function testWebhookNotificationOnIssueAssignment() {
    test:assertTrue(issueAssignedNotified, msg = "expected an issue assigned notification");
    test:assertEquals(issueAssignee, createdIssueAssignee, msg = "invalid issue labels");
}

@test:Config {
    dependsOn: [testWebhookNotificationOnIssueCreation],
    enable: false // Disable the test as ballerinax/github module hasn't any function to edit the issue
}
function testWebhookNotificationOnIssueEdited() {
    test:assertTrue(issueEditedNotified, msg = "expected an issue edited notification");
    if (issueChanges is ()) {
        test:assertFail(msg = "expected `issueChanges` to not be `()`");
    }
}
