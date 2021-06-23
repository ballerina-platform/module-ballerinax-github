import ballerina/websub;
import ballerina/log;

service class WebSubService {
    *websub:SubscriberService;
    final SupportedRemoteFunctionImpl supportedRemoteFunctionImpl = {};
    private SimpleWebhookService webhookService;

    public string? deleteWebhookEndpoint = ();

    public isolated function init(SimpleWebhookService webhookService) {
        self.webhookService = webhookService;
        string[] methodNames = getServiceMethodNames(webhookService);

        foreach var methodName in methodNames {
            match methodName {
                "onPing" => {
                    self.supportedRemoteFunctionImpl.isOnPingAvailable = true;
                }
                "onFork" => {
                    self.supportedRemoteFunctionImpl.isOnForkAvailable = true;
                }
                "onPush" => {
                    self.supportedRemoteFunctionImpl.isOnPushAvailable = true;
                }
                "onCreate" => {
                    self.supportedRemoteFunctionImpl.isOnCreateAvailable = true;
                }
                "onReleased" => {
                    self.supportedRemoteFunctionImpl.isOnReleasedAvailable = true;
                }
                "onReleasePublished" => {
                    self.supportedRemoteFunctionImpl.isOnReleasePublishedAvailable = true;
                }
                "onReleaseUnpublished" => {
                    self.supportedRemoteFunctionImpl.isOnReleaseUnpublishedAvailable = true;
                }
                "onReleaseCreated" => {
                    self.supportedRemoteFunctionImpl.isOnReleaseCreatedAvailable = true;
                }
                "onReleaseEdited" => {
                    self.supportedRemoteFunctionImpl.isOnReleaseEditedAvailable = true;
                }
                "onReleaseDeleted" => {
                    self.supportedRemoteFunctionImpl.isOnReleaseDeletedAvailable = true;
                }
                "onPreReleased" => {
                    self.supportedRemoteFunctionImpl.isOnPreReleasedAvailable = true;
                }
                 "onWatch" => {
                    self.supportedRemoteFunctionImpl.isOnWatchStartedAvailable = true;
                }
                 "onIssueCommentCreated" => {
                    self.supportedRemoteFunctionImpl.isOnIssueCommentCreatedAvailable = true;
                }
                 "onIssueCommentEdited" => {
                    self.supportedRemoteFunctionImpl.isOnIssueCommentEditedAvailable = true;
                }
                 "onIssueCommentDeleted" => {
                    self.supportedRemoteFunctionImpl.isOnIssueCommentDeletedAvailable = true;
                }
                 "onIssuesAssigned" => {
                    self.supportedRemoteFunctionImpl.isOnIssuesAssignedAvailable = true;
                }
                 "onIssuesUnassigned" => {
                    self.supportedRemoteFunctionImpl.isOnIssuesUnassignedAvailable = true;
                }
                 "onIssuesLabeled" => {
                    self.supportedRemoteFunctionImpl.isOnIssuesLabeledAvailable = true;
                }
                 "onIssuesUnlabeled" => {
                    self.supportedRemoteFunctionImpl.isOnIssuesUnlabeledAvailable = true;
                }
                 "onIssuesOpened" => {
                    self.supportedRemoteFunctionImpl.isOnIssuesOpenedAvailable = true;
                }
                 "onIssuesEdited" => {
                    self.supportedRemoteFunctionImpl.isOnIssuesEditedAvailable = true;
                }
                 "onIssuesMilestoned" => {
                    self.supportedRemoteFunctionImpl.isOnIssuesMilestonedAvailable = true;
                }
                 "onIssuesDemilestoned" => {
                    self.supportedRemoteFunctionImpl.isOnIssuesDemilestonedAvailable = true;
                }
                 "onIssuesClosed" => {
                    self.supportedRemoteFunctionImpl.isOnIssuesClosedAvailable = true;
                }
                 "onIssuesReopened" => {
                    self.supportedRemoteFunctionImpl.isOnIssuesReopenedAvailable = true;
                }
                 "onLabelCreated" => {
                    self.supportedRemoteFunctionImpl.isOnLabelCreatedAvailable = true;
                }
                 "onLabelEdited" => {
                    self.supportedRemoteFunctionImpl.isOnLabelEditedAvailable = true;
                }
                 "onLabelDeleted" => {
                    self.supportedRemoteFunctionImpl.isOnLabelDeletedAvailable = true;
                }
                 "onMilestoneCreated" => {
                    self.supportedRemoteFunctionImpl.isOnMilestoneCreatedAvailable = true;
                }
                 "onMilestoneClosed" => {
                    self.supportedRemoteFunctionImpl.isOnMilestoneClosedAvailable = true;
                }
                 "onMilestoneOpened" => {
                    self.supportedRemoteFunctionImpl.isOnMilestoneOpenedAvailable = true;
                }
                 "onMilestoneEdited" => {
                    self.supportedRemoteFunctionImpl.isOnMilestoneEditedAvailable = true;
                }
                 "onMilestoneDeleted" => {
                    self.supportedRemoteFunctionImpl.isOnMilestoneDeletedAvailable = true;
                }
                 "onPullRequestAssigned" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestAssignedAvailable = true;
                }
                 "onPullRequestUnassigned" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestUnassignedAvailable = true;
                }
                 "onPullRequestReviewRequested" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestReviewRequestedAvailable = true;
                }
                 "onPullRequestReviewRequestRemoved" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestReviewRequestRemovedAvailable = true;
                }
                 "onPullRequestLabeled" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestLabeledAvailable = true;
                }
                 "onPullRequestUnlabeled" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestUnlabeledAvailable = true;
                }
                 "onPullRequestOpened" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestOpenedAvailable = true;
                }
                 "onPullRequestEdited" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestEditedAvailable = true;
                }
                 "onPullRequestClosed" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestClosedAvailable = true;
                }
                 "onPullRequestReopened" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestReopenedAvailable = true;
                }
                 "onPullRequestReviewSubmitted" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestReviewSubmittedAvailable = true;
                }
                 "onPullRequestReviewEdited" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestReviewEditedAvailable = true;
                }
                 "onPullRequestReviewDismissed" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestReviewDismissedAvailable = true;
                }
                 "onPullRequestReviewCommentCreated" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestReviewCommentCreatedAvailable = true;
                }
                 "onPullRequestReviewCommentEdited" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestReviewCommentEditedAvailable = true;
                }
                 "onPullRequestReviewCommentDeleted" => {
                    self.supportedRemoteFunctionImpl.isOnPullRequestReviewCommentDeletedAvailable = true;
                }

                _ => {
                    log:printError("Unrecognized method [" + methodName + "] found in the implementation");
                }
            }
        }
    }

    remote isolated function onEventNotification(websub:ContentDistributionMessage event)
                        returns error? {

        GitHubEvent|error eventPayload = event.content.cloneWithType(GitHubEvent);
        if((eventPayload is PingEvent) ) {
            Repository repository = eventPayload.repository;
            int hookId = eventPayload.hook_id;
            string fullName = eventPayload.repository.full_name;
            string deleteWebhookEndpoint = "/repos/"+fullName+"/hooks/"+hookId.toString();
            self.deleteWebhookEndpoint = deleteWebhookEndpoint;
            if (self.supportedRemoteFunctionImpl.isOnPingAvailable) {
                var response = callOnPingMethod(self.webhookService, eventPayload);
                if (response is error) {
                    handleError(response);
                }
            }
        }else if ((eventPayload is ForkEvent)) {
            if (self.supportedRemoteFunctionImpl.isOnForkAvailable) {
                var response = callOnForkMethod(self.webhookService, eventPayload);
                if (response is error) {
                    handleError(response);
                }
            }
        }else if ((eventPayload is PushEvent)) {
            if (self.supportedRemoteFunctionImpl.isOnPushAvailable) {
                var response = callOnPushMethod(self.webhookService, eventPayload);
                if (response is error) {
                    handleError(response);
                }
            }
        }else if ((eventPayload is CreateEvent)) {
            if (self.supportedRemoteFunctionImpl.isOnCreateAvailable) {
                var response = callOnCreateMethod(self.webhookService, eventPayload);
                if (response is error) {
                    handleError(response);
                }
            }
        }else if (eventPayload is ReleaseEvent) {
            check handleReleaseEvent(self.webhookService, self.supportedRemoteFunctionImpl, eventPayload);
        }else if ((eventPayload is WatchEvent)) {
            if (self.supportedRemoteFunctionImpl.isOnWatchStartedAvailable) {
                var response = callOnWatchStartedMethod(self.webhookService, eventPayload);
                if (response is error) {
                    handleError(response);
                }
            }
        }else if (eventPayload is IssueCommentEvent) {
            check handleIssueCommentEvent(self.webhookService, self.supportedRemoteFunctionImpl, eventPayload);
        }else if (eventPayload is IssuesEvent) {
            check handleIssueEvent(self.webhookService, self.supportedRemoteFunctionImpl, eventPayload);
        }else if (eventPayload is LabelEvent) {
            check handleLabelEvent(self.webhookService, self.supportedRemoteFunctionImpl, eventPayload);
        }else if (eventPayload is MilestoneEvent) {
            check handleMilestoneEvent(self.webhookService, self.supportedRemoteFunctionImpl, eventPayload);
        }else if (eventPayload is PullRequestEvent) {
            check handlePullRequestEvent(self.webhookService, self.supportedRemoteFunctionImpl, eventPayload);
        }else if (eventPayload is PullRequestReviewEvent) {
            check handlePullRequestReviewEvent(self.webhookService, self.supportedRemoteFunctionImpl, eventPayload);
        }else if (eventPayload is PullRequestReviewCommentEvent) {
            check handlePullRequestReviewCommentEvent(self.webhookService, self.supportedRemoteFunctionImpl, eventPayload);
        }else {
            log:printDebug("Incoming event payload: "+event.content.toBalString());
            log:printDebug("Unsupported event received. Associated conversion error: "+eventPayload.message(), 'error=eventPayload);
        }
    }
}

isolated function handleReleaseEvent(SimpleWebhookService webhookService, SupportedRemoteFunctionImpl supportedRemoteFunctionImpl, ReleaseEvent eventPayload) returns error? {
    error? response = ();
    match (eventPayload.action) {
        RELEASE_PUBLISHED => {
            if (supportedRemoteFunctionImpl.isOnReleasePublishedAvailable) {
                response = callOnReleasePublishedMethod(webhookService, eventPayload);
            }
        }
        RELEASE_UNPUBLISHED => {
            if (supportedRemoteFunctionImpl.isOnReleaseUnpublishedAvailable) {
                response = callOnReleaseUnpublishedMethod(webhookService, eventPayload);
            }
        }
        RELEASE_CREATED => {
            if (supportedRemoteFunctionImpl.isOnReleaseCreatedAvailable) {
                response = callOnReleaseCreatedMethod(webhookService, eventPayload);
            }
        }
        RELEASE_EDITED => {
            if (supportedRemoteFunctionImpl.isOnReleaseEditedAvailable) {
                response = callOnReleaseEditedMethod(webhookService, eventPayload);
            }
        }
        RELEASE_DELETED => {
            if (supportedRemoteFunctionImpl.isOnReleaseDeletedAvailable) {
                response = callOnReleaseDeletedMethod(webhookService, eventPayload);
            }
        }
        RELEASE_PRE_RELEASED => {
            if (supportedRemoteFunctionImpl.isOnPreReleasedAvailable) {
                response = callOnPreReleasedMethod(webhookService, eventPayload);
            }
        }
        RELEASE_RELEASED => {
            if (supportedRemoteFunctionImpl.isOnReleasedAvailable) {
                response = callOnReleasedMethod(webhookService, eventPayload);
            }
        }
    }
    if (response is error) {
        handleError(response);
    }
}

isolated function handleIssueCommentEvent(SimpleWebhookService webhookService, SupportedRemoteFunctionImpl supportedRemoteFunctionImpl, IssueCommentEvent eventPayload) returns error? {
        error? response = ();
        match (eventPayload.action) {
            ISSUE_COMMENT_CREATED => {
                if (supportedRemoteFunctionImpl.isOnIssueCommentCreatedAvailable) {
                    response = callOnIssueCommentCreatedMethod(webhookService, eventPayload);
                }
            }
            ISSUE_COMMENT_EDITED => {
                if (supportedRemoteFunctionImpl.isOnIssueCommentEditedAvailable) {
                    response = callOnIssueCommentEditedMethod(webhookService, eventPayload);
                }
            }
            ISSUE_COMMENT_DELETED => {
                if (supportedRemoteFunctionImpl.isOnIssueCommentDeletedAvailable) {
                    response = callOnIssueCommentDeletedMethod(webhookService, eventPayload);
                }
            }
        }
        if (response is error) {
            handleError(response);
        }
    }

isolated function handleIssueEvent(SimpleWebhookService webhookService, SupportedRemoteFunctionImpl supportedRemoteFunctionImpl, IssuesEvent eventPayload) returns error? {
    error? response = ();
    match (eventPayload.action) {
        ISSUE_ASSIGNED => {
            if (supportedRemoteFunctionImpl.isOnIssuesAssignedAvailable) {
                response = callOnIssuesAssignedMethod(webhookService, eventPayload);
            }
        }
        ISSUE_UNASSIGNED => {
            if (supportedRemoteFunctionImpl.isOnIssuesUnassignedAvailable) {
                response = callOnIssuesUnassignedMethod(webhookService, eventPayload);
            }
        }
        ISSUE_LABELED => {
            if (supportedRemoteFunctionImpl.isOnIssuesLabeledAvailable) {
                response = callOnIssuesLabeledMethod(webhookService, eventPayload);
            }
        }
        ISSUE_UNLABELED => {
            if (supportedRemoteFunctionImpl.isOnIssuesUnlabeledAvailable) {
                response = callOnIssuesUnlabeledMethod(webhookService, eventPayload);
            }
        }
        ISSUE_OPENED => {
            if (supportedRemoteFunctionImpl.isOnIssuesOpenedAvailable) {
                response = callOnIssuesOpenedMethod(webhookService, eventPayload);
            }
        }
        ISSUE_EDITED => {
            if (supportedRemoteFunctionImpl.isOnIssuesEditedAvailable) {
                response = callOnIssuesEditedMethod(webhookService, eventPayload);
            }
        }
        ISSUE_MILESTONED => {
            if (supportedRemoteFunctionImpl.isOnIssuesMilestonedAvailable) {
                response = callOnIssuesMilestonedMethod(webhookService, eventPayload);
            }
        }
        ISSUE_DEMILESTONED => {
            if (supportedRemoteFunctionImpl.isOnIssuesDemilestonedAvailable) {
                response = callOnIssuesDemilestonedMethod(webhookService, eventPayload);
            }
        }
        ISSUE_CLOSED => {
            if (supportedRemoteFunctionImpl.isOnIssuesClosedAvailable) {
                response = callOnIssuesClosedMethod(webhookService, eventPayload);
            }
        }
        ISSUE_REOPENED => {
            if (supportedRemoteFunctionImpl.isOnIssuesReopenedAvailable) {
                response = callOnIssuesReopenedMethod(webhookService, eventPayload);
            }
        }
    }
    if (response is error) {
        handleError(response);
    }
}

isolated function handleLabelEvent(SimpleWebhookService webhookService, SupportedRemoteFunctionImpl supportedRemoteFunctionImpl, LabelEvent eventPayload) returns error? {
    error? response = ();
    match (eventPayload.action) {
        LABEL_CREATED => {
            if (supportedRemoteFunctionImpl.isOnLabelCreatedAvailable) {
                response = callOnLabelCreatedMethod(webhookService, eventPayload);
            }
        }
        LABEL_EDITED => {
            if (supportedRemoteFunctionImpl.isOnLabelEditedAvailable) {
                response = callOnLabelEditedMethod(webhookService, eventPayload);
            }
        }
        LABEL_DELETED => {
            if (supportedRemoteFunctionImpl.isOnLabelDeletedAvailable) {
                response = callOnLabelDeletedMethod(webhookService, eventPayload);
            }
        }
    }
    if (response is error) {
        handleError(response);
    }
}

isolated function handleMilestoneEvent(SimpleWebhookService webhookService, SupportedRemoteFunctionImpl supportedRemoteFunctionImpl, MilestoneEvent eventPayload) returns error? {
    error? response = ();
    match (eventPayload.action) {
        MILESTONE_CREATED => {
            if (supportedRemoteFunctionImpl.isOnMilestoneCreatedAvailable) {
                response = callOnMilestoneCreatedMethod(webhookService, eventPayload);
            }
        }
        MILESTONE_CLOSED => {
            if (supportedRemoteFunctionImpl.isOnMilestoneClosedAvailable) {
                response = callOnMilestoneClosedMethod(webhookService, eventPayload);
            }
        }
        MILESTONE_OPENED => {
            if (supportedRemoteFunctionImpl.isOnMilestoneOpenedAvailable) {
                response = callOnMilestoneOpenedMethod(webhookService, eventPayload);
            }
        }
        MILESTONE_EDITED => {
            if (supportedRemoteFunctionImpl.isOnMilestoneEditedAvailable) {
                response = callOnMilestoneEditedMethod(webhookService, eventPayload);
            }
        }
        MILESTONE_DELETED => {
            if (supportedRemoteFunctionImpl.isOnMilestoneDeletedAvailable) {
                response = callOnMilestoneDeletedMethod(webhookService, eventPayload);
            }
        }
    }
    if (response is error) {
        handleError(response);
    }
}

isolated function handlePullRequestEvent(SimpleWebhookService webhookService, SupportedRemoteFunctionImpl supportedRemoteFunctionImpl, PullRequestEvent eventPayload) returns error? {
    error? response = ();
    match (eventPayload.action) {
        PULL_REQUEST_ASSIGNED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestAssignedAvailable) {
                response = callOnPullRequestAssignedMethod(webhookService, eventPayload);
            }
        }
        PULL_REQUEST_UNASSIGNED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestUnassignedAvailable) {
                response = callOnPullRequestUnassignedMethod(webhookService, eventPayload);
            }
        }
        PULL_REQUEST_REVIEW_REQUESTED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestReviewRequestedAvailable) {
                response = callOnPullRequestReviewRequestedMethod(webhookService, eventPayload);
            }
        }
        PULL_REQUEST_REVIEW_REQUEST_REMOVED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestReviewRequestRemovedAvailable) {
                response = callOnPullRequestReviewRequestRemovedMethod(webhookService, eventPayload);
            }
        }
        PULL_REQUEST_LABELED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestLabeledAvailable) {
                response = callOnPullRequestLabeledMethod(webhookService, eventPayload);
            }
        }
        PULL_REQUEST_UNLABELED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestUnlabeledAvailable) {
                response = callOnPullRequestUnlabeledMethod(webhookService, eventPayload);
            }
        }
        PULL_REQUEST_OPENED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestOpenedAvailable) {
                response = callOnPullRequestOpenedMethod(webhookService, eventPayload);
            }
        }
        PULL_REQUEST_EDITED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestEditedAvailable) {
                response = callOnPullRequestEditedMethod(webhookService, eventPayload);
            }
        }
        PULL_REQUEST_CLOSED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestClosedAvailable) {
                response = callOnPullRequestClosedMethod(webhookService, eventPayload);
            }
        }
        PULL_REQUEST_REOPENED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestReopenedAvailable) {
                response = callOnPullRequestReopenedMethod(webhookService, eventPayload);
            }
        }
    }
    if (response is error) {
        handleError(response);
    }
}

isolated function handlePullRequestReviewEvent(SimpleWebhookService webhookService, SupportedRemoteFunctionImpl supportedRemoteFunctionImpl, PullRequestReviewEvent eventPayload) returns error? {
    error? response = ();
    match (eventPayload.action) {
        PULL_REQUEST_REVIEW_SUBMITTED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestReviewSubmittedAvailable) {
                response = callOnPullRequestReviewSubmittedMethod(webhookService, eventPayload);
            }
        }
        PULL_REQUEST_REVIEW_EDITED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestReviewEditedAvailable) {
                response = callOnPullRequestReviewEditedMethod(webhookService, eventPayload);
            }
        }
        PULL_REQUEST_REVIEW_DISMISSED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestReviewDismissedAvailable) {
                response = callOnPullRequestReviewDismissedMethod(webhookService, eventPayload);
            }
        }
    }
    if (response is error) {
        handleError(response);
    }
}

isolated function handlePullRequestReviewCommentEvent(SimpleWebhookService webhookService, SupportedRemoteFunctionImpl supportedRemoteFunctionImpl, PullRequestReviewCommentEvent eventPayload) returns error? {
    error? response = ();
    match (eventPayload.action) {
        PULL_REQUEST_REVIEW_COMMENT_CREATED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestReviewCommentCreatedAvailable) {
                response = callOnPullRequestReviewCommentCreatedMethod(webhookService, eventPayload);
            }
        }
        PULL_REQUEST_REVIEW_COMMENT_EDITED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestReviewCommentEditedAvailable) {
                response = callOnPullRequestReviewCommentEditedMethod(webhookService, eventPayload);
            }
        }
        PULL_REQUEST_REVIEW_COMMENT_DELETED => {
            if (supportedRemoteFunctionImpl.isOnPullRequestReviewCommentDeletedAvailable) {
                response = callOnPullRequestReviewCommentDeletedMethod(webhookService, eventPayload);
            }
        }
    }
    if (response is error) {
        handleError(response);
    }
}

isolated function handleError(error response) {
    log:printDebug(response.message(), 'error=response);
}


