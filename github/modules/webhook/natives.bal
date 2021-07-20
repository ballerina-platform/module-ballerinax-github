import ballerina/jballerina.java;

isolated class WebhookToGithubAdaptor {
    isolated function init(SimpleWebhookService serviceObj) returns error? {
        externInit(self, serviceObj);
    }
    // General Events

    isolated function callOnPingMethod(PingEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    isolated function callOnForkMethod(ForkEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    isolated function callOnPushMethod(PushEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    isolated function callOnCreateMethod(CreateEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    // Release Events

    isolated function callOnReleasePublishedMethod(ReleaseEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    isolated function callOnReleaseUnpublishedMethod(ReleaseEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    isolated function callOnReleaseCreatedMethod(ReleaseEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    isolated function callOnReleaseEditedMethod(ReleaseEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    isolated function callOnReleaseDeletedMethod(ReleaseEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    isolated function callOnPreReleasedMethod(ReleaseEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    isolated function callOnReleasedMethod(ReleaseEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    // Watch Events

    isolated function callOnWatchStartedMethod(WatchEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    // Issue Comment Events

    isolated function callOnIssueCommentCreatedMethod(IssueCommentEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    isolated function callOnIssueCommentEditedMethod(IssueCommentEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    isolated function callOnIssueCommentDeletedMethod(IssueCommentEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    // Issue Events

    isolated function callOnIssuesAssignedMethod(IssuesEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnIssuesUnassignedMethod(IssuesEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnIssuesLabeledMethod(IssuesEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnIssuesUnlabeledMethod(IssuesEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnIssuesOpenedMethod(IssuesEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnIssuesEditedMethod(IssuesEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnIssuesMilestonedMethod(IssuesEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnIssuesDemilestonedMethod(IssuesEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnIssuesClosedMethod(IssuesEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnIssuesReopenedMethod(IssuesEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    // Label Events

    isolated function callOnLabelCreatedMethod(LabelEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnLabelEditedMethod(LabelEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnLabelDeletedMethod(LabelEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    // Milestone Events

    isolated function callOnMilestoneCreatedMethod(MilestoneEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnMilestoneClosedMethod(MilestoneEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnMilestoneOpenedMethod(MilestoneEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnMilestoneEditedMethod(MilestoneEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnMilestoneDeletedMethod( MilestoneEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    // Pull Request Events

    isolated function callOnPullRequestAssignedMethod(PullRequestEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnPullRequestUnassignedMethod(PullRequestEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnPullRequestReviewRequestedMethod(PullRequestEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnPullRequestReviewRequestRemovedMethod(PullRequestEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnPullRequestLabeledMethod(PullRequestEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnPullRequestUnlabeledMethod(PullRequestEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnPullRequestOpenedMethod(PullRequestEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnPullRequestEditedMethod(PullRequestEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnPullRequestClosedMethod(PullRequestEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnPullRequestReopenedMethod(PullRequestEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    // Pull Request Review Events

    isolated function callOnPullRequestReviewSubmittedMethod(PullRequestReviewEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnPullRequestReviewEditedMethod(PullRequestReviewEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnPullRequestReviewDismissedMethod(PullRequestReviewEvent msg) returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    // Pull Request Review Comment Events

    isolated function callOnPullRequestReviewCommentCreatedMethod(PullRequestReviewCommentEvent msg) 
                                returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnPullRequestReviewCommentEditedMethod(PullRequestReviewCommentEvent msg) 
                                returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
    isolated function callOnPullRequestReviewCommentDeletedMethod(PullRequestReviewCommentEvent msg) 
                                returns error? = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;

    # Invoke native method to retrive implemented method names in the subscriber service
    #
    # + return - {@code string[]} containing the method-names in current implementation
    isolated function getServiceMethodNames() returns string[] = @java:Method {
        'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
    } external;
}

isolated function externInit(WebhookToGithubAdaptor adaptor, SimpleWebhookService serviceObj) = @java:Method {
    'class: "io.ballerinax.webhook.WebhookToGithubAdaptor"
} external;
