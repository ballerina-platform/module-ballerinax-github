import ballerina/jballerina.java;

// General Events

isolated function callOnPingMethod(SimpleWebhookService webhookService, PingEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

isolated function callOnForkMethod(SimpleWebhookService webhookService, ForkEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

isolated function callOnPushMethod(SimpleWebhookService webhookService, PushEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

isolated function callOnCreateMethod(SimpleWebhookService webhookService, CreateEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

// Release Events

isolated function callOnReleasePublishedMethod(SimpleWebhookService webhookService, ReleaseEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

isolated function callOnReleaseUnpublishedMethod(SimpleWebhookService webhookService, ReleaseEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

isolated function callOnReleaseCreatedMethod(SimpleWebhookService webhookService, ReleaseEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

isolated function callOnReleaseEditedMethod(SimpleWebhookService webhookService, ReleaseEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

isolated function callOnReleaseDeletedMethod(SimpleWebhookService webhookService, ReleaseEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

isolated function callOnPreReleasedMethod(SimpleWebhookService webhookService, ReleaseEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

isolated function callOnReleasedMethod(SimpleWebhookService webhookService, ReleaseEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

// Watch Events

isolated function callOnWatchStartedMethod(SimpleWebhookService webhookService, WatchEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

// Issue Comment Events

isolated function callOnIssueCommentCreatedMethod(SimpleWebhookService webhookService, IssueCommentEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

isolated function callOnIssueCommentEditedMethod(SimpleWebhookService webhookService, IssueCommentEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

isolated function callOnIssueCommentDeletedMethod(SimpleWebhookService webhookService, IssueCommentEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

// Issue Events

isolated function callOnIssuesAssignedMethod(SimpleWebhookService webhookService, IssuesEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnIssuesUnassignedMethod(SimpleWebhookService webhookService, IssuesEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnIssuesLabeledMethod(SimpleWebhookService webhookService, IssuesEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnIssuesUnlabeledMethod(SimpleWebhookService webhookService, IssuesEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnIssuesOpenedMethod(SimpleWebhookService webhookService, IssuesEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnIssuesEditedMethod(SimpleWebhookService webhookService, IssuesEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnIssuesMilestonedMethod(SimpleWebhookService webhookService, IssuesEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnIssuesDemilestonedMethod(SimpleWebhookService webhookService, IssuesEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnIssuesClosedMethod(SimpleWebhookService webhookService, IssuesEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnIssuesReopenedMethod(SimpleWebhookService webhookService, IssuesEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

// Label Events

isolated function callOnLabelCreatedMethod(SimpleWebhookService webhookService, LabelEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnLabelEditedMethod(SimpleWebhookService webhookService, LabelEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnLabelDeletedMethod(SimpleWebhookService webhookService, LabelEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

// Milestone Events

isolated function callOnMilestoneCreatedMethod(SimpleWebhookService webhookService, MilestoneEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnMilestoneClosedMethod(SimpleWebhookService webhookService, MilestoneEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnMilestoneOpenedMethod(SimpleWebhookService webhookService, MilestoneEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnMilestoneEditedMethod(SimpleWebhookService webhookService, MilestoneEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnMilestoneDeletedMethod(SimpleWebhookService webhookService, MilestoneEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

// Pull Request Events

isolated function callOnPullRequestAssignedMethod(SimpleWebhookService webhookService, PullRequestEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnPullRequestUnassignedMethod(SimpleWebhookService webhookService, PullRequestEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnPullRequestReviewRequestedMethod(SimpleWebhookService webhookService, PullRequestEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnPullRequestReviewRequestRemovedMethod(SimpleWebhookService webhookService, PullRequestEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnPullRequestLabeledMethod(SimpleWebhookService webhookService, PullRequestEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnPullRequestUnlabeledMethod(SimpleWebhookService webhookService, PullRequestEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnPullRequestOpenedMethod(SimpleWebhookService webhookService, PullRequestEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnPullRequestEditedMethod(SimpleWebhookService webhookService, PullRequestEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnPullRequestClosedMethod(SimpleWebhookService webhookService, PullRequestEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnPullRequestReopenedMethod(SimpleWebhookService webhookService, PullRequestEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

// Pull Request Review Events

isolated function callOnPullRequestReviewSubmittedMethod(SimpleWebhookService webhookService, PullRequestReviewEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnPullRequestReviewEditedMethod(SimpleWebhookService webhookService, PullRequestReviewEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnPullRequestReviewDismissedMethod(SimpleWebhookService webhookService, PullRequestReviewEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

// Pull Request Review Comment Events

isolated function callOnPullRequestReviewCommentCreatedMethod(SimpleWebhookService webhookService, PullRequestReviewCommentEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnPullRequestReviewCommentEditedMethod(SimpleWebhookService webhookService, PullRequestReviewCommentEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
isolated function callOnPullRequestReviewCommentDeletedMethod(SimpleWebhookService webhookService, PullRequestReviewCommentEvent msg)
                                returns error? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

# Invoke native method to retrive implemented method names in the subscriber service
#
# + subscriberService - current subscriber-service
# + return - {@code string[]} containing the method-names in current implementation
isolated function getServiceMethodNames(SimpleWebhookService subscriberService) returns string[] = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

