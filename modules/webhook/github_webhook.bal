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
import ballerina/http;
import ballerina/lang.'object as lang;
import ballerina/websub;

# The WebSub Hub URL for GitHub.
public const string HUB = "https://api.github.com/hub";

const string TOPIC_HEADER = "X-GitHub-Event";

////////////////////////////////////////////////////////////////////
/// GitHub Webhook Listener (WebSub Subscriber Service Listener) ///
////////////////////////////////////////////////////////////////////
# Object representing the GitHub Webhook (WebSub Subscriber Service) Listener.
#
# + webhookListenerConfig - The configuration for the listener
public class Listener {

    *lang:Listener;

    public WebhookListenerConfiguration? webhookListenerConfig = ();

    private websub:Listener websubListener;

    public function init(int port, WebhookListenerConfiguration? config = ()) {
        self.webhookListenerConfig = config;
        websub:ExtensionConfig extensionConfig = {
            topicIdentifier: websub: TOPIC_ID_HEADER_AND_PAYLOAD,
            topicHeader: TOPIC_HEADER,
            headerResourceMap: GITHUB_TOPIC_HEADER_RESOURCE_MAP,
            headerAndPayloadKeyResourceMap: GITHUB_TOPIC_HEADER_AND_PAYLOAD_KEY_RESOURCE_MAP
        };
        websub:SubscriberListenerConfiguration slConfig = {
            extensionConfig: extensionConfig
        };
        if (config is WebhookListenerConfiguration) {
            string? specHost = config["host"];
            if (specHost is string) {
                slConfig.host = specHost;
            }
            slConfig.httpServiceSecureSocket = config["httpServiceSecureSocket"];
        }
        self.websubListener = new (port, slConfig);
    }

    public function __attach(service s, string? name = ()) returns error? {
        return self.websubListener.__attach(s, name);
    }

    public function __detach(service s) returns error? {
        return self.websubListener.__detach(s);
    }

    public function __start() returns error? {
        return self.websubListener.__start();
    }

    public function __gracefulStop() returns error? {
        return self.websubListener.__gracefulStop();
    }

    public function __immediateStop() returns error? {
        return self.websubListener.__immediateStop();
    }
}

# Record representing the configuration for the GitHub Webhook Listener.
#
# + host - The host name/IP of the listener
# + httpServiceSecureSocket - The SSL configurations for the listener
public type WebhookListenerConfiguration record {|
    string host?;
    http:ListenerSecureSocket httpServiceSecureSocket?;
|};

final map<[string,typedesc<record {}>]> GITHUB_TOPIC_HEADER_RESOURCE_MAP = {
    "ping": ["onPing", PingEvent],
    "fork": ["onFork", ForkEvent],
    "push": ["onPush", PushEvent],
    "release": ["onRelease", ReleaseEvent],
    "watch": ["onWatch", WatchEvent]
};

final map<map<map<[string,typedesc<record {}>]>>> GITHUB_TOPIC_HEADER_AND_PAYLOAD_KEY_RESOURCE_MAP = {
    "issue_comment": {
        "action": {
            "created": ["onIssueCommentCreated", IssueCommentEvent],
            "edited": ["onIssueCommentEdited", IssueCommentEvent],
            "deleted": ["onIssueCommentDeleted", IssueCommentEvent]
        }
    },
    "issues": {
        "action": {
            "assigned": ["onIssuesAssigned", IssuesEvent],
            "unassigned": ["onIssuesUnassigned", IssuesEvent],
            "labeled": ["onIssuesLabeled", IssuesEvent],
            "unlabeled": ["onIssuesUnlabeled", IssuesEvent],
            "opened": ["onIssuesOpened", IssuesEvent],
            "edited": ["onIssuesEdited", IssuesEvent],
            "milestoned": ["onIssuesMilestoned", IssuesEvent],
            "demilestoned": ["onIssuesDemilestoned", IssuesEvent],
            "closed": ["onIssuesClosed", IssuesEvent],
            "reopened": ["onIssuesReopened", IssuesEvent]
        }
    },
    "label": {
        "action": {
            "created": ["onLabelCreated", LabelEvent],
            "edited": ["onLabelEdited", LabelEvent],
            "deleted": ["onLabelDeleted", LabelEvent]
        }
    },
    "milestone": {
        "action": {
            "created": ["onMilestoneCreated", MilestoneEvent],
            "closed": ["onMilestoneClosed", MilestoneEvent],
            "opened": ["onMilestoneOpened", MilestoneEvent],
            "edited": ["onMilestoneEdited", MilestoneEvent],
            "deleted": ["onMilestoneDeleted", MilestoneEvent]
        }
    },
    "pull_request": {
        "action": {
            "assigned": ["onPullRequestAssigned", PullRequestEvent],
            "unassigned": ["onPullRequestUnassigned", PullRequestEvent],
            "review_requested": ["onPullRequestReviewRequested", PullRequestEvent],
            "review_request_removed": ["onPullRequestReviewRequestRemoved", PullRequestEvent],
            "labeled": ["onPullRequestLabeled", PullRequestEvent],
            "unlabeled": ["onPullRequestUnlabeled", PullRequestEvent],
            "opened": ["onPullRequestOpened", PullRequestEvent],
            "edited": ["onPullRequestEdited", PullRequestEvent],
            "closed": ["onPullRequestClosed", PullRequestEvent],
            "reopened": ["onPullRequestReopened", PullRequestEvent]
        }
    },
    "pull_request_review": {
        "action": {
            "submitted": ["onPullRequestReviewSubmitted", PullRequestReviewEvent],
            "edited": ["onPullRequestReviewEdited", PullRequestReviewEvent],
            "dismissed": ["onPullRequestReviewDismissed", PullRequestReviewEvent]
        }
    },
    "pull_request_review_comment": {
        "action": {
            "created": ["onPullRequestReviewCommentCreated", PullRequestReviewCommentEvent],
            "edited": ["onPullRequestReviewCommentEdited", PullRequestReviewCommentEvent],
            "deleted": ["onPullRequestReviewCommentDeleted", PullRequestReviewCommentEvent]
        }
    }
};
