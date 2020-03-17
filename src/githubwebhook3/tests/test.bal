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

// import ballerina/config;
// import ballerina/http;
// import ballerina/oauth2;
// import ballerina/runtime;
// import ballerina/test;
// import ballerina/websub;
// import wso2/github4;

// boolean webhookRegistrationNotified = false;
// string webhookHookType = "";

// boolean issueCreationNotified = false;
// string issueTitle = "";

// boolean issueLabeledNotified = false;
// string issueLabels = "";

// boolean issueAssignedNotified = false;
// string issueAssignee = "";

// boolean issueEditedNotified = false;
// Changes? issueChanges = ();

// listener Listener githubListener = new(8080);

// oauth2:OutboundOAuth2Provider githubOAuth2Provider = new ({
//     accessToken: config:getAsString("GITHUB_TOKEN")
// });
// http:BearerAuthHandler githubOAuth2Handler = new (githubOAuth2Provider);

// @websub:SubscriberServiceConfig {
//     path: "/webhook",
//     subscribeOnStartUp: true,
//     target: [HUB, config:getAsString("GITHUB_TOPIC")],
//     hubClientConfig: {
//        auth: {
//            authHandler: githubOAuth2Handler
//        }
//     },
//     callback: GITHUB_CALLBACK // only needs to be specified if not http(s)://<HOST>:<PORT>/<path>
// }
// service githubWebhook on githubListener {
//     resource function onPing(websub:Notification notification, PingEvent event) {
//         webhookRegistrationNotified = true;
//         webhookHookType = <@untainted> event.hook["type"];
//     }

//     resource function onIssuesOpened(websub:Notification notification, IssuesEvent event) {
//         issueCreationNotified = true;
//         issueTitle = <@untainted> event.issue.title;
//     }

//     resource function onIssuesLabeled(websub:Notification notification, IssuesEvent event) {
//         issueLabeledNotified = true;
//         string receivedIssueLabels = "";
//         foreach Label label in event.issue.labels {
//             receivedIssueLabels += label.name;
//         }
//         issueLabels = <@untainted> receivedIssueLabels;
//     }

//     resource function onIssuesAssigned(websub:Notification notification, IssuesEvent event) {
//         issueAssignedNotified = true;
//         User assignee = <User> event.issue.assignee;
//         issueAssignee = <@untainted> assignee.login;
//     }

//     resource function onIssuesEdited(websub:Notification notification, IssuesEvent event) {
//         issueEditedNotified = true;
//         issueChanges = <@untainted> event.changes;
//     }
// }

// @test:Config {}
// function testWebhookRegistration() {
//     int counter = 10;
//     while (!webhookRegistrationNotified && counter >= 0) {
//         runtime:sleep(1000);
//         counter -= 1;
//     }
//     test:assertTrue(webhookRegistrationNotified,
//                     msg = "expected a webhook to be registered and receive a ping notification");
//     test:assertEquals(webhookHookType, "Repository", msg = "expected a repository hook to be added");
// }

// string createdIssueUsername = config:getAsString("GITHUB_USERNAME");
// string createdIssueRepoName = config:getAsString("GITHUB_REPO_NAME");
// string createdIssueTitle = "This is a test issue";
// string[] createdIssueLabelArray = ["bug", "critical"];
// string createdIssueAssignee = createdIssueUsername;

// @test:Config {
//     dependsOn: ["testWebhookRegistration"]
// }
// function testWebhookNotificationOnIssueCreation() {
//     github4:GitHubConfiguration gitHubConfig = {
//         accessToken: config:getAsString("GITHUB_TOKEN")
//     };
//     github4:Client githubClient = new (gitHubConfig);
//     var issueCreationStatus = githubClient->createIssue(createdIssueUsername, createdIssueRepoName, createdIssueTitle,
//                                             "This is the body of the test issue", createdIssueLabelArray,
//                                             [createdIssueAssignee]);
//     if (issueCreationStatus is error) {
//         test:assertFail(msg = "Issue creation failed: " + issueCreationStatus.reason());
//     }

//     int counter = 10;
//     while (!issueCreationNotified && counter >= 0) {
//         runtime:sleep(1000);
//         counter -= 1;
//     }
//     test:assertTrue(issueCreationNotified, msg = "expected an issue creation notification");
//     test:assertEquals(issueTitle, createdIssueTitle, msg = "invalid issue title");
// }

// @test:Config {
//     dependsOn: ["testWebhookNotificationOnIssueCreation"]
// }
// function testWebhookNotificationOnIssueLabeling() {
//     string createdIssueLabelString = "";
//     foreach string label in createdIssueLabelArray {
//         createdIssueLabelString += label;
//     }
//     test:assertTrue(issueLabeledNotified, msg = "expected an issue labeled notification");
//     test:assertEquals(issueLabels, createdIssueLabelString, msg = "invalid issue labels");
// }

// @test:Config {
//     dependsOn: ["testWebhookNotificationOnIssueCreation"]
// }
// function testWebhookNotificationOnIssueAssignment() {
//     test:assertTrue(issueAssignedNotified, msg = "expected an issue assigned notification");
//     test:assertEquals(issueAssignee, createdIssueAssignee, msg = "invalid issue labels");
// }

// @test:Config {
//     dependsOn: ["testWebhookNotificationOnIssueCreation"]
// }
// function testWebhookNotificationOnIssueEdited() {
//     test:assertTrue(issueEditedNotified, msg = "expected an issue edited notification");
//     if (issueChanges is ()) {
//         test:assertFail(msg = "expected `issueChanges` to not be `()`");
//     }

//     Changes setIssueChanges = <Changes> issueChanges;
//     boolean changesEmpty = true;
//     foreach var (key, value) in setIssueChanges {
//         if (!(value is ())) {
//             changesEmpty = false;
//             break;
//         }
//     }
//     test:assertTrue(changesEmpty, msg = "expected changes to be empty");
// }
