import ballerina/websub;
import ballerina/log;

isolated service class WebSubService {
    *websub:SubscriberService;
    private final WebhookToGithubAdaptor adaptor;
    private string? deleteWebhookEndpoint = ();

    private final boolean isOnPingAvailable;
    private final boolean isOnForkAvailable;
    private final boolean isOnPushAvailable;
    private final boolean isOnCreateAvailable;
    private final boolean isOnReleasedAvailable;
    private final boolean isOnReleasePublishedAvailable;
    private final boolean isOnReleaseUnpublishedAvailable;
    private final boolean isOnReleaseCreatedAvailable;
    private final boolean isOnReleaseEditedAvailable;
    private final boolean isOnReleaseDeletedAvailable;
    private final boolean isOnPreReleasedAvailable;
    private final boolean isOnWatchStartedAvailable;
    private final boolean isOnIssueCommentCreatedAvailable;
    private final boolean isOnIssueCommentEditedAvailable;
    private final boolean isOnIssueCommentDeletedAvailable;
    private final boolean isOnIssuesAssignedAvailable;
    private final boolean isOnIssuesUnassignedAvailable;
    private final boolean isOnIssuesLabeledAvailable;
    private final boolean isOnIssuesUnlabeledAvailable;
    private final boolean isOnIssuesOpenedAvailable;
    private final boolean isOnIssuesEditedAvailable;
    private final boolean isOnIssuesMilestonedAvailable;
    private final boolean isOnIssuesDemilestonedAvailable;
    private final boolean isOnIssuesClosedAvailable;
    private final boolean isOnIssuesReopenedAvailable;
    private final boolean isOnLabelCreatedAvailable;
    private final boolean isOnLabelEditedAvailable;
    private final boolean isOnLabelDeletedAvailable;
    private final boolean isOnMilestoneCreatedAvailable;
    private final boolean isOnMilestoneClosedAvailable;
    private final boolean isOnMilestoneOpenedAvailable;
    private final boolean isOnMilestoneEditedAvailable;
    private final boolean isOnMilestoneDeletedAvailable;
    private final boolean isOnPullRequestAssignedAvailable;
    private final boolean isOnPullRequestUnassignedAvailable;
    private final boolean isOnPullRequestReviewRequestedAvailable;
    private final boolean isOnPullRequestReviewRequestRemovedAvailable;
    private final boolean isOnPullRequestLabeledAvailable;
    private final boolean isOnPullRequestUnlabeledAvailable;
    private final boolean isOnPullRequestOpenedAvailable;
    private final boolean isOnPullRequestEditedAvailable;
    private final boolean isOnPullRequestClosedAvailable;
    private final boolean isOnPullRequestReopenedAvailable;
    private final boolean isOnPullRequestReviewSubmittedAvailable;
    private final boolean isOnPullRequestReviewEditedAvailable;
    private final boolean isOnPullRequestReviewDismissedAvailable;
    private final boolean isOnPullRequestReviewCommentCreatedAvailable;
    private final boolean isOnPullRequestReviewCommentEditedAvailable;
    private final boolean isOnPullRequestReviewCommentDeletedAvailable;
    
    isolated function getDeleteWeebhookEndpoint() returns string? {
        lock {
            return self.deleteWebhookEndpoint;
        }
    }

    isolated function init(WebhookToGithubAdaptor adaptor) {
        self.adaptor = adaptor;
        
        string[] methodNames = adaptor.getServiceMethodNames();
        self.isOnPingAvailable = isMethodAvailable("onPing", methodNames);
        self.isOnForkAvailable = isMethodAvailable("onFork", methodNames);
        self.isOnPushAvailable = isMethodAvailable("onPush", methodNames);
        self.isOnCreateAvailable = isMethodAvailable("onCreate", methodNames);
        self.isOnReleasedAvailable = isMethodAvailable("onReleased", methodNames);
        self.isOnReleasePublishedAvailable = isMethodAvailable("onReleasePublished", methodNames);
        self.isOnReleaseUnpublishedAvailable = isMethodAvailable("onReleaseUnpublished", methodNames);
        self.isOnReleaseCreatedAvailable = isMethodAvailable("onReleaseCreated", methodNames);
        self.isOnReleaseEditedAvailable = isMethodAvailable("onReleaseEdited", methodNames);
        self.isOnReleaseDeletedAvailable = isMethodAvailable("onReleaseDeleted", methodNames);
        self.isOnPreReleasedAvailable = isMethodAvailable("onPreReleased", methodNames);
        self.isOnWatchStartedAvailable = isMethodAvailable("onWatch", methodNames);
        self.isOnIssueCommentCreatedAvailable = isMethodAvailable("onIssueCommentCreated", methodNames);
        self.isOnIssueCommentEditedAvailable = isMethodAvailable("onIssueCommentEdited", methodNames);
        self.isOnIssueCommentDeletedAvailable = isMethodAvailable("onIssueCommentDeleted", methodNames);
        self.isOnIssuesAssignedAvailable = isMethodAvailable("onIssuesAssigned", methodNames);
        self.isOnIssuesUnassignedAvailable = isMethodAvailable("onIssuesUnassigned", methodNames);
        self.isOnIssuesLabeledAvailable = isMethodAvailable("onIssuesLabeled", methodNames);
        self.isOnIssuesUnlabeledAvailable = isMethodAvailable("onIssuesUnlabeled", methodNames);
        self.isOnIssuesOpenedAvailable = isMethodAvailable("onIssuesOpened", methodNames);
        self.isOnIssuesEditedAvailable = isMethodAvailable("onIssuesEdited", methodNames);
        self.isOnIssuesMilestonedAvailable = isMethodAvailable("onIssuesMilestoned", methodNames);
        self.isOnIssuesDemilestonedAvailable = isMethodAvailable("onIssuesDemilestoned", methodNames);
        self.isOnIssuesClosedAvailable = isMethodAvailable("onIssuesClosed", methodNames);
        self.isOnIssuesReopenedAvailable = isMethodAvailable("onIssuesReopened", methodNames);
        self.isOnLabelCreatedAvailable = isMethodAvailable("onLabelCreated", methodNames);
        self.isOnLabelEditedAvailable = isMethodAvailable("onLabelEdited", methodNames);
        self.isOnLabelDeletedAvailable = isMethodAvailable("onLabelDeleted", methodNames);
        self.isOnMilestoneCreatedAvailable = isMethodAvailable("onMilestoneCreated", methodNames);
        self.isOnMilestoneClosedAvailable = isMethodAvailable("onMilestoneClosed", methodNames);
        self.isOnMilestoneOpenedAvailable = isMethodAvailable("onMilestoneOpened", methodNames);
        self.isOnMilestoneEditedAvailable = isMethodAvailable("onMilestoneEdited", methodNames);
        self.isOnMilestoneDeletedAvailable = isMethodAvailable("onMilestoneDeleted", methodNames);
        self.isOnPullRequestAssignedAvailable = isMethodAvailable("onPullRequestAssigned", methodNames);
        self.isOnPullRequestUnassignedAvailable = isMethodAvailable("onPullRequestUnassigned", methodNames);
        self.isOnPullRequestReviewRequestedAvailable = isMethodAvailable("onPullRequestReviewRequested", methodNames);
        self.isOnPullRequestReviewRequestRemovedAvailable = isMethodAvailable("onPullRequestReviewRequestRemoved", methodNames);
        self.isOnPullRequestLabeledAvailable = isMethodAvailable("onPullRequestLabeled", methodNames);
        self.isOnPullRequestUnlabeledAvailable = isMethodAvailable("onPullRequestUnlabeled", methodNames);
        self.isOnPullRequestOpenedAvailable = isMethodAvailable("onPullRequestOpened", methodNames);
        self.isOnPullRequestEditedAvailable = isMethodAvailable("onPullRequestEdited", methodNames);
        self.isOnPullRequestClosedAvailable = isMethodAvailable("onPullRequestClosed", methodNames);
        self.isOnPullRequestReopenedAvailable = isMethodAvailable("onPullRequestReopened", methodNames);
        self.isOnPullRequestReviewSubmittedAvailable = isMethodAvailable("onPullRequestReviewSubmitted", methodNames);
        self.isOnPullRequestReviewEditedAvailable = isMethodAvailable("onPullRequestReviewEdited", methodNames);
        self.isOnPullRequestReviewDismissedAvailable = isMethodAvailable("onPullRequestReviewDismissed", methodNames);
        self.isOnPullRequestReviewCommentCreatedAvailable = isMethodAvailable("onPullRequestReviewCommentCreated", methodNames);
        self.isOnPullRequestReviewCommentEditedAvailable = isMethodAvailable("onPullRequestReviewCommentEdited", methodNames);
        self.isOnPullRequestReviewCommentDeletedAvailable = isMethodAvailable("onPullRequestReviewCommentDeleted", methodNames);

        if (methodNames.length() > 0) {
            foreach string methodName in methodNames {
                log:printError("Unrecognized method [" + methodName + "] found in user implementation."); 
            }
        }
    }

    remote isolated function onEventNotification(websub:ContentDistributionMessage event) returns error? {
        GitHubEvent|error eventPayload = event.content.cloneWithType(GitHubEvent);
        if ((eventPayload is PingEvent)) {
            Repository repository = eventPayload.repository;
            int hookId = eventPayload.hook_id;
            string fullName = eventPayload.repository.full_name;
            string deleteWebhookEndpoint = "/repos/"+fullName+"/hooks/"+hookId.toString();
            lock {
                self.deleteWebhookEndpoint = deleteWebhookEndpoint;
            }
            if (self.isOnPingAvailable) {
                var response = self.adaptor.callOnPingMethod(eventPayload);
                if (response is error) {
                    handleError(response);
                }
            }
        } else if ((eventPayload is ForkEvent)) {
            if (self.isOnForkAvailable) {
                var response = self.adaptor.callOnForkMethod(eventPayload);
                if (response is error) {
                    handleError(response);
                }
            }
        } else if ((eventPayload is PushEvent)) {
            if (self.isOnPushAvailable) {
                var response = self.adaptor.callOnPushMethod(eventPayload);
                if (response is error) {
                    handleError(response);
                }
            }
        } else if ((eventPayload is CreateEvent)) {
            if (self.isOnCreateAvailable) {
                var response = self.adaptor.callOnCreateMethod(eventPayload);
                if (response is error) {
                    handleError(response);
                }
            }
        } else if (eventPayload is ReleaseEvent) {
            check self.handleReleaseEvent(self.adaptor, eventPayload);
        } else if ((eventPayload is WatchEvent)) {
            if (self.isOnWatchStartedAvailable) {
                var response = self.adaptor.callOnWatchStartedMethod(eventPayload);
                if (response is error) {
                    handleError(response);
                }
            }
        } else if (eventPayload is IssueCommentEvent) {
            check self.handleIssueCommentEvent(self.adaptor, eventPayload);
        } else if (eventPayload is IssuesEvent) {
            check self.handleIssueEvent(self.adaptor, eventPayload);
        } else if (eventPayload is LabelEvent) {
            check self.handleLabelEvent(self.adaptor, eventPayload);
        } else if (eventPayload is MilestoneEvent) {
            check self.handleMilestoneEvent(self.adaptor, eventPayload);
        } else if (eventPayload is PullRequestEvent) {
            check self.handlePullRequestEvent(self.adaptor, eventPayload);
        } else if (eventPayload is PullRequestReviewEvent) {
            check self.handlePullRequestReviewEvent(self.adaptor, eventPayload);
        } else if (eventPayload is PullRequestReviewCommentEvent) {
            check self.handlePullRequestReviewCommentEvent(self.adaptor, eventPayload);
        } else {
            log:printDebug("Incoming event payload: " + event.content.toBalString());
            log:printDebug("Unsupported event received. Associated conversion error: " + eventPayload.message(), 
                'error = eventPayload);
        }
    }

    isolated function handleReleaseEvent(WebhookToGithubAdaptor adaptor, ReleaseEvent eventPayload) returns error? {
        error? response = ();
        match (eventPayload.action) {
            RELEASE_PUBLISHED => {
                if (self.isOnReleasePublishedAvailable) {
                    response = adaptor.callOnReleasePublishedMethod(eventPayload);
                }
            }
            RELEASE_UNPUBLISHED => {
                if (self.isOnReleaseUnpublishedAvailable) {
                    response = adaptor.callOnReleaseUnpublishedMethod(eventPayload);
                }
            }
            RELEASE_CREATED => {
                if (self.isOnReleaseCreatedAvailable) {
                    response = adaptor.callOnReleaseCreatedMethod(eventPayload);
                }
            }
            RELEASE_EDITED => {
                if (self.isOnReleaseEditedAvailable) {
                    response = adaptor.callOnReleaseEditedMethod(eventPayload);
                }
            }
            RELEASE_DELETED => {
                if (self.isOnReleaseDeletedAvailable) {
                    response = adaptor.callOnReleaseDeletedMethod(eventPayload);
                }   
            }
            RELEASE_PRE_RELEASED => {
                if (self.isOnPreReleasedAvailable) {
                    response = adaptor.callOnPreReleasedMethod(eventPayload);
                }
            }
            RELEASE_RELEASED => {
                if (self.isOnReleasedAvailable) {
                    response = adaptor.callOnReleasedMethod(eventPayload);
                }
            }
        }
        if (response is error) {
            handleError(response);
        }
    }

    isolated function handleIssueCommentEvent(WebhookToGithubAdaptor adaptor, IssueCommentEvent eventPayload) returns error? {
        error? response = ();
        match (eventPayload.action) {
            ISSUE_COMMENT_CREATED => {
                if (self.isOnIssueCommentCreatedAvailable) {
                    response = adaptor.callOnIssueCommentCreatedMethod(eventPayload);
                }
            }
            ISSUE_COMMENT_EDITED => {
                if (self.isOnIssueCommentEditedAvailable) {
                    response = adaptor.callOnIssueCommentEditedMethod(eventPayload);
                }
            }
            ISSUE_COMMENT_DELETED => {
                if (self.isOnIssueCommentDeletedAvailable) {
                    response = adaptor.callOnIssueCommentDeletedMethod(eventPayload);
                }
            }
        }
        if (response is error) {
            handleError(response);
        }
    }

    isolated function handleIssueEvent(WebhookToGithubAdaptor adaptor, IssuesEvent eventPayload) returns error? {
        error? response = ();
        match (eventPayload.action) {
            ISSUE_ASSIGNED => {
                if (self.isOnIssuesAssignedAvailable) {
                    response = adaptor.callOnIssuesAssignedMethod(eventPayload);
                }
            }
            ISSUE_UNASSIGNED => {
                if (self.isOnIssuesUnassignedAvailable) {
                    response = adaptor.callOnIssuesUnassignedMethod(eventPayload);
                }
            }
            ISSUE_LABELED => {
                if (self.isOnIssuesLabeledAvailable) {
                    response = adaptor.callOnIssuesLabeledMethod(eventPayload);
                }
            }
            ISSUE_UNLABELED => {
                if (self.isOnIssuesUnlabeledAvailable) {
                    response = adaptor.callOnIssuesUnlabeledMethod(eventPayload);
                }
            }
            ISSUE_OPENED => {
                if (self.isOnIssuesOpenedAvailable) {
                    response = adaptor.callOnIssuesOpenedMethod(eventPayload);
                }
            }
            ISSUE_EDITED => {
                if (self.isOnIssuesEditedAvailable) {
                    response = adaptor.callOnIssuesEditedMethod(eventPayload);
                }
            }
            ISSUE_MILESTONED => {
                if (self.isOnIssuesMilestonedAvailable) {
                    response = adaptor.callOnIssuesMilestonedMethod(eventPayload);
                }
            }
            ISSUE_DEMILESTONED => {
                if (self.isOnIssuesDemilestonedAvailable) {
                    response = adaptor.callOnIssuesDemilestonedMethod(eventPayload);
                }
            }
            ISSUE_CLOSED => {
                if (self.isOnIssuesClosedAvailable) {
                    response = adaptor.callOnIssuesClosedMethod(eventPayload);
                }
            }
            ISSUE_REOPENED => {
                if (self.isOnIssuesReopenedAvailable) {
                    response = adaptor.callOnIssuesReopenedMethod(eventPayload);
                }
            }
        }
        if (response is error) {
            handleError(response);
        }
    }

    isolated function handleLabelEvent(WebhookToGithubAdaptor adaptor, LabelEvent eventPayload) returns error? {
        error? response = ();
        match (eventPayload.action) {
            LABEL_CREATED => {
                if (self.isOnLabelCreatedAvailable) {
                    response = adaptor.callOnLabelCreatedMethod(eventPayload);
                }
            }
            LABEL_EDITED => {
                if (self.isOnLabelEditedAvailable) {
                    response = adaptor.callOnLabelEditedMethod(eventPayload);
                }
            }
            LABEL_DELETED => {
                if (self.isOnLabelDeletedAvailable) {
                    response = adaptor.callOnLabelDeletedMethod(eventPayload);
                }
            }
        }
        if (response is error) {
            handleError(response);
        }
    }

    isolated function handleMilestoneEvent(WebhookToGithubAdaptor adaptor, MilestoneEvent eventPayload) returns error? {
        error? response = ();
        match (eventPayload.action) {
            MILESTONE_CREATED => {
                if (self.isOnMilestoneCreatedAvailable) {
                    response = adaptor.callOnMilestoneCreatedMethod(eventPayload);
                }
            }
            MILESTONE_CLOSED => {
                if (self.isOnMilestoneClosedAvailable) {
                    response = adaptor.callOnMilestoneClosedMethod(eventPayload);
                }
            }
            MILESTONE_OPENED => {
                if (self.isOnMilestoneOpenedAvailable) {
                    response = adaptor.callOnMilestoneOpenedMethod(eventPayload);
                }
            }
            MILESTONE_EDITED => {
                if (self.isOnMilestoneEditedAvailable) {
                    response = adaptor.callOnMilestoneEditedMethod(eventPayload);
                }
            }
            MILESTONE_DELETED => {
                if (self.isOnMilestoneDeletedAvailable) {
                    response = adaptor.callOnMilestoneDeletedMethod(eventPayload);
                }
            }
        }
        if (response is error) {
            handleError(response);
        }
    }

    isolated function handlePullRequestEvent(WebhookToGithubAdaptor adaptor, PullRequestEvent eventPayload) returns error? {
        error? response = ();
        match (eventPayload.action) {
            PULL_REQUEST_ASSIGNED => {
                if (self.isOnPullRequestAssignedAvailable) {
                    response = adaptor.callOnPullRequestAssignedMethod(eventPayload);
                }
            }
            PULL_REQUEST_UNASSIGNED => {
                if (self.isOnPullRequestUnassignedAvailable) {
                    response = adaptor.callOnPullRequestUnassignedMethod(eventPayload);
                }
            }
            PULL_REQUEST_REVIEW_REQUESTED => {
                if (self.isOnPullRequestReviewRequestedAvailable) {
                    response = adaptor.callOnPullRequestReviewRequestedMethod(eventPayload);
                }
            }
            PULL_REQUEST_REVIEW_REQUEST_REMOVED => {
                if (self.isOnPullRequestReviewRequestRemovedAvailable) {
                    response = adaptor.callOnPullRequestReviewRequestRemovedMethod(eventPayload);
                }
            }
            PULL_REQUEST_LABELED => {
                if (self.isOnPullRequestLabeledAvailable) {
                    response = adaptor.callOnPullRequestLabeledMethod(eventPayload);
                }
            }
            PULL_REQUEST_UNLABELED => {
                if (self.isOnPullRequestUnlabeledAvailable) {
                    response = adaptor.callOnPullRequestUnlabeledMethod(eventPayload);
                }
            }
            PULL_REQUEST_OPENED => {
                if (self.isOnPullRequestOpenedAvailable) {
                    response = adaptor.callOnPullRequestOpenedMethod(eventPayload);
                }
            }
            PULL_REQUEST_EDITED => {
                if (self.isOnPullRequestEditedAvailable) {
                    response = adaptor.callOnPullRequestEditedMethod(eventPayload);
                }
            }
            PULL_REQUEST_CLOSED => {
                if (self.isOnPullRequestClosedAvailable) {
                    response = adaptor.callOnPullRequestClosedMethod(eventPayload);
                }
            }
            PULL_REQUEST_REOPENED => {
                if (self.isOnPullRequestReopenedAvailable) {
                    response = adaptor.callOnPullRequestReopenedMethod(eventPayload);
                }
            }
        }
        if (response is error) {
            handleError(response);
        }
    }

    isolated function handlePullRequestReviewCommentEvent(WebhookToGithubAdaptor adaptor, PullRequestReviewCommentEvent 
                                                          eventPayload) returns error? {
        error? response = ();
        match (eventPayload.action) {
            PULL_REQUEST_REVIEW_COMMENT_CREATED => {
                if (self.isOnPullRequestReviewCommentCreatedAvailable) {
                    response = adaptor.callOnPullRequestReviewCommentCreatedMethod(eventPayload);
                }
            }
            PULL_REQUEST_REVIEW_COMMENT_EDITED => {
                if (self.isOnPullRequestReviewCommentEditedAvailable) {
                    response = adaptor.callOnPullRequestReviewCommentEditedMethod(eventPayload);
                }
            }
            PULL_REQUEST_REVIEW_COMMENT_DELETED => {
                if (self.isOnPullRequestReviewCommentDeletedAvailable) {
                    response = adaptor.callOnPullRequestReviewCommentDeletedMethod(eventPayload);
                }
            }
        }
        if (response is error) {
            handleError(response);
        }
    }

    isolated function handlePullRequestReviewEvent(WebhookToGithubAdaptor adaptor, PullRequestReviewEvent eventPayload) 
            returns error? {
        error? response = ();
        match (eventPayload.action) {
            PULL_REQUEST_REVIEW_SUBMITTED => {
                if (self.isOnPullRequestReviewSubmittedAvailable) {
                    response = adaptor.callOnPullRequestReviewSubmittedMethod(eventPayload);
                }
            }
            PULL_REQUEST_REVIEW_EDITED => {
                if (self.isOnPullRequestReviewEditedAvailable) {
                    response = adaptor.callOnPullRequestReviewEditedMethod(eventPayload);
                }
            }
            PULL_REQUEST_REVIEW_DISMISSED => {
                if (self.isOnPullRequestReviewDismissedAvailable) {
                    response = adaptor.callOnPullRequestReviewDismissedMethod(eventPayload);
                }
            }
        }
        if (response is error) {
            handleError(response);
        }
    }
}

isolated function handleError(error response) {
    log:printDebug(response.message(), 'error=response);
}

# Retrieves whether the particular remote method is available.
#
# + methodName - Name of the required method
# + methods - All available methods
# + return - `true` if method available or else `false`
isolated function isMethodAvailable(string methodName, string[] methods) returns boolean {
    boolean isAvailable = methods.indexOf(methodName) is int;
    if (isAvailable) {
        var index = methods.indexOf(methodName);
        if (index is int) {
            _ = methods.remove(index);
        }
    }
    return isAvailable;
}
