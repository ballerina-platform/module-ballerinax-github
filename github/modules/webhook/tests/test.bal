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
configurable string accessToken = ?;

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
service /subscriber on webhookListener {

    remote function onPing(PingEvent event) returns Acknowledgement? {
        log:printInfo("Received ping-event-message ", notificationMsg = event);
        webhookRegistrationNotified = true;
        webhookHookType = <@untainted> event.hook.'type;
        return {};
    }

    remote function onIssuesOpened(IssuesEvent event) returns Acknowledgement? {
        log:printInfo("Issue opened");
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
    github:Configuration gitHubConfig = {
        accessToken: accessToken
    };

    github:Client githubClient = new (gitHubConfig);

    github:CreateIssueInput createIssueInput = {
        title: createdIssueTitle
    };

    var issueCreationPayload = githubClient->createIssue(createIssueInput, testUserName, "github-connector");

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

    github:Configuration gitHubConfig = {
        accessToken: accessToken
    };

    github:Client githubClient = new (gitHubConfig);

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
