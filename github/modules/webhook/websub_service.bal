import ballerina/websub;
import ballerina/log;

service class WebSubService {
    *websub:SubscriberService;

    private boolean isOnPingAvailable = false;
    private boolean isOnForkAvailable = false;
    private boolean isOnPushAvailable = false;
    private boolean isOnCreateAvailable = false;
    private boolean isOnReleasePublishedAvailable = false;
    private boolean isOnReleaseUnpublishedAvailable = false;
    private boolean isOnReleaseCreatedAvailable = false;
    private boolean isOnReleaseEditedAvailable = false;
    private boolean isOnReleaseDeletedAvailable = false;
    private boolean isOnPreReleasedAvailable = false;
    private boolean isOnReleasedAvailable = false;
    private boolean isOnWatchStartedAvailable = false;
    private boolean isOnIssueCommentCreatedAvailable = false;
    private boolean isOnIssueCommentEditedAvailable = false;
    private boolean isOnIssueCommentDeletedAvailable = false;
    private boolean isOnIssuesAssignedAvailable = false;
    private boolean isOnIssuesUnassignedAvailable = false;
    private boolean isOnIssuesLabeledAvailable = false;
    private boolean isOnIssuesUnlabeledAvailable = false;
    private boolean isOnIssuesOpenedAvailable = false;
    private boolean isOnIssuesEditedAvailable = false;
    private boolean isOnIssuesMilestonedAvailable = false;
    private boolean isOnIssuesDemilestonedAvailable = false;
    private boolean isOnIssuesClosedAvailable = false;
    private boolean isOnIssuesReopenedAvailable = false;
    private boolean isOnLabelCreatedAvailable = false;
    private boolean isOnLabelEditedAvailable = false;
    private boolean isOnLabelDeletedAvailable = false;
    private boolean isOnMilestoneCreatedAvailable = false;
    private boolean isOnMilestoneClosedAvailable = false;
    private boolean isOnMilestoneOpenedAvailable = false;
    private boolean isOnMilestoneEditedAvailable = false;
    private boolean isOnMilestoneDeletedAvailable = false;
    private boolean isOnPullRequestAssignedAvailable = false;
    private boolean isOnPullRequestUnassignedAvailable = false;
    private boolean isOnPullRequestReviewRequestedAvailable = false;
    private boolean isOnPullRequestReviewRequestRemovedAvailable = false;
    private boolean isOnPullRequestLabeledAvailable = false;
    private boolean isOnPullRequestUnlabeledAvailable = false;
    private boolean isOnPullRequestOpenedAvailable = false;
    private boolean isOnPullRequestEditedAvailable = false;
    private boolean isOnPullRequestClosedAvailable = false;
    private boolean isOnPullRequestReopenedAvailable = false;
    private boolean isOnPullRequestReviewSubmittedAvailable = false;
    private boolean isOnPullRequestReviewEditedAvailable = false;
    private boolean isOnPullRequestReviewDismissedAvailable = false;
    private boolean isOnPullRequestReviewCommentCreatedAvailable = false;
    private boolean isOnPullRequestReviewCommentEditedAvailable = false;
    private boolean isOnPullRequestReviewCommentDeletedAvailable = false;

    private SimpleWebhookService webhookService;

    public string? deleteWebhookEndpoint = ();

    public isolated function init(SimpleWebhookService webhookService) {
        self.webhookService = webhookService;
        string[] methodNames = getServiceMethodNames(webhookService);

        foreach var methodName in methodNames {
            match methodName {
                "onPing" => {
                    self.isOnPingAvailable = true;
                }
                "onFork" => {
                    self.isOnForkAvailable = true;
                }
                "onPush" => {
                    self.isOnPushAvailable = true;
                }
                "onCreate" => {
                    self.isOnCreateAvailable = true;
                }
                "onReleased" => {
                    self.isOnReleasedAvailable = true;
                }
                "onReleasePublished" => {
                    self.isOnReleasePublishedAvailable = true;
                }
                "onReleaseUnpublished" => {
                    self.isOnReleaseUnpublishedAvailable = true;
                }
                "onReleaseCreated" => {
                    self.isOnReleaseCreatedAvailable = true;
                }
                "onReleaseEdited" => {
                    self.isOnReleaseEditedAvailable = true;
                }
                "onReleaseDeleted" => {
                    self.isOnReleaseDeletedAvailable = true;
                }
                "onPreReleased" => {
                    self.isOnPreReleasedAvailable = true;
                }
                 "onWatch" => {
                    self.isOnWatchStartedAvailable = true;
                }
                 "onIssueCommentCreated" => {
                    self.isOnIssueCommentCreatedAvailable = true;
                }
                 "onIssueCommentEdited" => {
                    self.isOnIssueCommentEditedAvailable = true;
                }
                 "onIssueCommentDeleted" => {
                    self.isOnIssueCommentDeletedAvailable = true;
                }
                 "onIssuesAssigned" => {
                    self.isOnIssuesAssignedAvailable = true;
                }
                 "onIssuesUnassigned" => {
                    self.isOnIssuesUnassignedAvailable = true;
                }
                 "onIssuesLabeled" => {
                    self.isOnIssuesLabeledAvailable = true;
                }
                 "onIssuesUnlabeled" => {
                    self.isOnIssuesUnlabeledAvailable = true;
                }
                 "onIssuesOpened" => {
                    self.isOnIssuesOpenedAvailable = true;
                }
                 "onIssuesEdited" => {
                    self.isOnIssuesEditedAvailable = true;
                }
                 "onIssuesMilestoned" => {
                    self.isOnIssuesMilestonedAvailable = true;
                }
                 "onIssuesDemilestoned" => {
                    self.isOnIssuesDemilestonedAvailable = true;
                }
                 "onIssuesClosed" => {
                    self.isOnIssuesClosedAvailable = true;
                }
                 "onIssuesReopened" => {
                    self.isOnIssuesReopenedAvailable = true;
                }
                 "onLabelCreated" => {
                    self.isOnLabelCreatedAvailable = true;
                }
                 "onLabelEdited" => {
                    self.isOnLabelEditedAvailable = true;
                }
                 "onLabelDeleted" => {
                    self.isOnLabelDeletedAvailable = true;
                }
                 "onMilestoneCreated" => {
                    self.isOnMilestoneCreatedAvailable = true;
                }
                 "onMilestoneClosed" => {
                    self.isOnMilestoneClosedAvailable = true;
                }
                 "onMilestoneOpened" => {
                    self.isOnMilestoneOpenedAvailable = true;
                }
                 "onMilestoneEdited" => {
                    self.isOnMilestoneEditedAvailable = true;
                }
                 "onMilestoneDeleted" => {
                    self.isOnMilestoneDeletedAvailable = true;
                }
                 "onPullRequestAssigned" => {
                    self.isOnPullRequestAssignedAvailable = true;
                }
                 "onPullRequestUnassigned" => {
                    self.isOnPullRequestUnassignedAvailable = true;
                }
                 "onPullRequestReviewRequested" => {
                    self.isOnPullRequestReviewRequestedAvailable = true;
                }
                 "onPullRequestReviewRequestRemoved" => {
                    self.isOnPullRequestReviewRequestRemovedAvailable = true;
                }
                 "onPullRequestLabeled" => {
                    self.isOnPullRequestLabeledAvailable = true;
                }
                 "onPullRequestUnlabeled" => {
                    self.isOnPullRequestUnlabeledAvailable = true;
                }
                 "onPullRequestOpened" => {
                    self.isOnPullRequestOpenedAvailable = true;
                }
                 "onPullRequestEdited" => {
                    self.isOnPullRequestEditedAvailable = true;
                }
                 "onPullRequestClosed" => {
                    self.isOnPullRequestClosedAvailable = true;
                }
                 "onPullRequestReopened" => {
                    self.isOnPullRequestReopenedAvailable = true;
                }
                 "onPullRequestReviewSubmitted" => {
                    self.isOnPullRequestReviewSubmittedAvailable = true;
                }
                 "onPullRequestReviewEdited" => {
                    self.isOnPullRequestReviewEditedAvailable = true;
                }
                 "onPullRequestReviewDismissed" => {
                    self.isOnPullRequestReviewDismissedAvailable = true;
                }
                 "onPullRequestReviewCommentCreated" => {
                    self.isOnPullRequestReviewCommentCreatedAvailable = true;
                }
                 "onPullRequestReviewCommentEdited" => {
                    self.isOnPullRequestReviewCommentEditedAvailable = true;
                }
                 "onPullRequestReviewCommentDeleted" => {
                    self.isOnPullRequestReviewCommentDeletedAvailable = true;
                }

                _ => {
                    log:printError("Unrecognized method [" + methodName + "] found in the implementation");
                }
            }
        }
    }

    remote isolated function onEventNotification(websub:ContentDistributionMessage event)
                        returns websub:Acknowledgement|websub:SubscriptionDeletedError? {
        GitHubEvent|error eventPayload = event.content.cloneWithType(GitHubEvent);
        if((eventPayload is PingEvent) ) {
            Repository repository = eventPayload.repository;
            int hookId = eventPayload.hook_id;
            string fullName = eventPayload.repository.full_name;
            string deleteWebhookEndpoint = "/repos/"+fullName+"/hooks/"+hookId.toString();
            self.deleteWebhookEndpoint = deleteWebhookEndpoint;
            if (self.isOnPingAvailable) {
                var response = callOnPingMethod(self.webhookService, eventPayload);
            }
        }else if ((eventPayload is ForkEvent)) {
            if (self.isOnForkAvailable) {
                var response = callOnForkMethod(self.webhookService, eventPayload);
            }
        }else if ((eventPayload is PushEvent)) {
            if (self.isOnPushAvailable) {
                var response = callOnPushMethod(self.webhookService, eventPayload);
            }
        }else if ((eventPayload is CreateEvent)) {
            if (self.isOnCreateAvailable) {
                var response = callOnCreateMethod(self.webhookService, eventPayload);
            }
        }else if ((eventPayload is ReleaseEvent)) {
            match (eventPayload.action) {
                RELEASE_PUBLISHED => {
                    if (self.isOnReleasePublishedAvailable) {
                        var response = callOnReleasePublishedMethod(self.webhookService, eventPayload);
                    }
                }
                RELEASE_UNPUBLISHED => {
                    if (self.isOnReleaseUnpublishedAvailable) {
                        var response = callOnReleaseUnpublishedMethod(self.webhookService, eventPayload);
                    }
                }
                RELEASE_CREATED => {
                    if (self.isOnReleaseCreatedAvailable) {
                        var response = callOnReleaseCreatedMethod(self.webhookService, eventPayload);
                    }
                }
                RELEASE_EDITED => {
                    if (self.isOnReleaseEditedAvailable) {
                        var response = callOnReleaseEditedMethod(self.webhookService, eventPayload);
                    }
                }
                RELEASE_DELETED => {
                    if (self.isOnReleaseDeletedAvailable) {
                        var response = callOnReleaseDeletedMethod(self.webhookService, eventPayload);
                    }
                }
                RELEASE_PRE_RELEASED => {
                    if (self.isOnPreReleasedAvailable) {
                        var response = callOnPreReleasedMethod(self.webhookService, eventPayload);
                    }
                }
                RELEASE_RELEASED => {
                    if (self.isOnReleasedAvailable) {
                        var response = callOnReleasedMethod(self.webhookService, eventPayload);
                    }
                }
            }
        }else if ((eventPayload is WatchEvent)) {
            if (self.isOnWatchStartedAvailable) {
                var response = callOnWatchStartedMethod(self.webhookService, eventPayload);
            }
        }else if (eventPayload is IssueCommentEvent) {
            match (eventPayload.action) {
                ISSUE_COMMENT_CREATED => {
                    if (self.isOnIssueCommentCreatedAvailable) {
                        var response = callOnIssueCommentCreatedMethod(self.webhookService, eventPayload);
                    }
                }
                ISSUE_COMMENT_EDITED => {
                    if (self.isOnIssueCommentEditedAvailable) {
                        var response = callOnIssueCommentEditedMethod(self.webhookService, eventPayload);
                    }
                }
                ISSUE_COMMENT_DELETED => {
                    if (self.isOnIssueCommentDeletedAvailable) {
                        var response = callOnIssueCommentDeletedMethod(self.webhookService, eventPayload);
                    }
                }
            }
        }else if (eventPayload is IssuesEvent) {
            match (eventPayload.action) {
                ISSUE_ASSIGNED => {
                    if (self.isOnIssuesAssignedAvailable) {
                        var response = callOnIssuesAssignedMethod(self.webhookService, eventPayload);
                    }
                }
                ISSUE_UNASSIGNED => {
                    if (self.isOnIssuesUnassignedAvailable) {
                        var response = callOnIssuesUnassignedMethod(self.webhookService, eventPayload);
                    }
                }
                ISSUE_LABELED => {
                    if (self.isOnIssuesLabeledAvailable) {
                        var response = callOnIssuesLabeledMethod(self.webhookService, eventPayload);
                    }
                }
                ISSUE_UNLABELED => {
                    if (self.isOnIssuesUnlabeledAvailable) {
                        var response = callOnIssuesUnlabeledMethod(self.webhookService, eventPayload);
                    }
                }
                ISSUE_OPENED => {
                    if (self.isOnIssuesOpenedAvailable) {
                        var response = callOnIssuesOpenedMethod(self.webhookService, eventPayload);
                    }
                }
                ISSUE_EDITED => {
                    if (self.isOnIssuesEditedAvailable) {
                        var response = callOnIssuesEditedMethod(self.webhookService, eventPayload);
                    }
                }
                ISSUE_MILESTONED => {
                    if (self.isOnIssuesMilestonedAvailable) {
                        var response = callOnIssuesMilestonedMethod(self.webhookService, eventPayload);
                    }
                }
                ISSUE_DEMILESTONED => {
                    if (self.isOnIssuesDemilestonedAvailable) {
                        var response = callOnIssuesDemilestonedMethod(self.webhookService, eventPayload);
                    }
                }
                ISSUE_CLOSED => {
                    if (self.isOnIssuesClosedAvailable) {
                        var response = callOnIssuesClosedMethod(self.webhookService, eventPayload);
                    }
                }
                ISSUE_REOPENED => {
                    if (self.isOnIssuesReopenedAvailable) {
                        var response = callOnIssuesReopenedMethod(self.webhookService, eventPayload);
                    }
                }
            }
        }else if (eventPayload is LabelEvent) {
            match (eventPayload.action) {
                LABEL_CREATED => {
                    if (self.isOnLabelCreatedAvailable) {
                        var response = callOnLabelCreatedMethod(self.webhookService, eventPayload);
                    }
                }
                LABEL_EDITED => {
                    if (self.isOnLabelEditedAvailable) {
                        var response = callOnLabelEditedMethod(self.webhookService, eventPayload);
                    }
                }
                LABEL_DELETED => {
                    if (self.isOnLabelDeletedAvailable) {
                        var response = callOnLabelDeletedMethod(self.webhookService, eventPayload);
                    }
                }
            }
        }else if (eventPayload is MilestoneEvent) {
            match (eventPayload.action) {
                MILESTONE_CREATED => {
                    if (self.isOnMilestoneCreatedAvailable) {
                        var response = callOnMilestoneCreatedMethod(self.webhookService, eventPayload);
                    }
                }
                MILESTONE_CLOSED => {
                    if (self.isOnMilestoneClosedAvailable) {
                        var response = callOnMilestoneClosedMethod(self.webhookService, eventPayload);
                    }
                }
                MILESTONE_OPENED => {
                    if (self.isOnMilestoneOpenedAvailable) {
                        var response = callOnMilestoneOpenedMethod(self.webhookService, eventPayload);
                    }
                }
                MILESTONE_EDITED => {
                    if (self.isOnMilestoneEditedAvailable) {
                        var response = callOnMilestoneEditedMethod(self.webhookService, eventPayload);
                    }
                }
                MILESTONE_DELETED => {
                    if (self.isOnMilestoneDeletedAvailable) {
                        var response = callOnMilestoneDeletedMethod(self.webhookService, eventPayload);
                    }
                }
            }
        }else if (eventPayload is PullRequestEvent) {
            match (eventPayload.action) {
                PULL_REQUEST_ASSIGNED => {
                    if (self.isOnPullRequestAssignedAvailable) {
                        var response = callOnPullRequestAssignedMethod(self.webhookService, eventPayload);
                    }
                }
                PULL_REQUEST_UNASSIGNED => {
                    if (self.isOnPullRequestUnassignedAvailable) {
                        var response = callOnPullRequestUnassignedMethod(self.webhookService, eventPayload);
                    }
                }
                PULL_REQUEST_REVIEW_REQUESTED => {
                    if (self.isOnPullRequestReviewRequestedAvailable) {
                        var response = callOnPullRequestReviewRequestedMethod(self.webhookService, eventPayload);
                    }
                }
                PULL_REQUEST_REVIEW_REQUEST_REMOVED => {
                    if (self.isOnPullRequestReviewRequestRemovedAvailable) {
                        var response = callOnPullRequestReviewRequestRemovedMethod(self.webhookService, eventPayload);
                    }
                }
                PULL_REQUEST_LABELED => {
                    if (self.isOnPullRequestLabeledAvailable) {
                        var response = callOnPullRequestLabeledMethod(self.webhookService, eventPayload);
                    }
                }
                PULL_REQUEST_UNLABELED => {
                    if (self.isOnPullRequestUnlabeledAvailable) {
                        var response = callOnPullRequestUnlabeledMethod(self.webhookService, eventPayload);
                    }
                }
                PULL_REQUEST_OPENED => {
                    if (self.isOnPullRequestOpenedAvailable) {
                        var response = callOnPullRequestOpenedMethod(self.webhookService, eventPayload);
                    }
                }
                PULL_REQUEST_EDITED => {
                    if (self.isOnPullRequestEditedAvailable) {
                        var response = callOnPullRequestEditedMethod(self.webhookService, eventPayload);
                    }
                }
                PULL_REQUEST_CLOSED => {
                    if (self.isOnPullRequestClosedAvailable) {
                        var response = callOnPullRequestClosedMethod(self.webhookService, eventPayload);
                    }
                }
                PULL_REQUEST_REOPENED => {
                    if (self.isOnPullRequestReopenedAvailable) {
                        var response = callOnPullRequestReopenedMethod(self.webhookService, eventPayload);
                    }
                }
            }
        }else if (eventPayload is PullRequestReviewEvent) {
            match (eventPayload.action) {
                PULL_REQUEST_REVIEW_SUBMITTED => {
                    if (self.isOnPullRequestReviewSubmittedAvailable) {
                        var response = callOnPullRequestReviewSubmittedMethod(self.webhookService, eventPayload);
                    }
                }
                PULL_REQUEST_REVIEW_EDITED => {
                    if (self.isOnPullRequestReviewEditedAvailable) {
                        var response = callOnPullRequestReviewEditedMethod(self.webhookService, eventPayload);
                    }
                }
                PULL_REQUEST_REVIEW_DISMISSED => {
                    if (self.isOnPullRequestReviewDismissedAvailable) {
                        var response = callOnPullRequestReviewDismissedMethod(self.webhookService, eventPayload);
                    }
                }
            }
        }else if (eventPayload is PullRequestReviewCommentEvent) {
            match (eventPayload.action) {
                PULL_REQUEST_REVIEW_COMMENT_CREATED => {
                    if (self.isOnPullRequestReviewCommentCreatedAvailable) {
                        var response = callOnPullRequestReviewCommentCreatedMethod(self.webhookService, eventPayload);
                    }
                }
                PULL_REQUEST_REVIEW_COMMENT_EDITED => {
                    if (self.isOnPullRequestReviewCommentEditedAvailable) {
                        var response = callOnPullRequestReviewCommentEditedMethod(self.webhookService, eventPayload);
                    }
                }
                PULL_REQUEST_REVIEW_COMMENT_DELETED => {
                    if (self.isOnPullRequestReviewCommentDeletedAvailable) {
                        var response = callOnPullRequestReviewCommentDeletedMethod(self.webhookService, eventPayload);
                    }
                }
            }
        }else {
            log:printError("error:  ", errorPayload = eventPayload.message());
        }

        return {};
    }
}

