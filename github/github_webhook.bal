import ballerina/http;
import ballerina/websub;

//////////////////////////////////////////////////////////
/// GitHub Webhook Service (WebSub Subscriber Service) ///
//////////////////////////////////////////////////////////
public type WebhookService object {

    public function getEndpoint() returns (WebhookListener) {
        WebhookListener ep = new;
        return ep;
    }

};

////////////////////////////////////////////////////////////////////
/// GitHub Webhook Endpoint (WebSub Subscriber Service Endpoint) ///
////////////////////////////////////////////////////////////////////
@Description {value:"Struct representing the GitHub Webhook (WebSub Subscriber Service) Endpoint"}
@Field {value:"config: The configuration for the endpoint"}
@Field {value:"serviceEndpoint: The underlying HTTP service endpoint"}
public type WebhookListener object {

    public {
        WebhookListenerConfiguration config;
    }

    private {
        websub:Listener websubListener;
    }

    public new() {
        websubListener = new;
    }

    @Description {value:"Gets called when the endpoint is being initialized during package init"}
    @Param {value:"config: The SubscriberServiceEndpointConfiguration of the endpoint"}
    public function init(WebhookListenerConfiguration config);

    @Description {value:"Gets called whenever a service attaches itself to this endpoint and during package init"}
    @Param {value:"serviceType: The service attached"}
    public function register(typedesc serviceType);

    @Description {value:"Starts the registered service"}
    public function start();

    @Description {value:"Returns the connector that client code uses"}
    @Return {value:"The connector that client code uses"}
    public function getCallerActions() returns (http:Connection);

    @Description {value:"Stops the registered service"}
    public function stop();

};

public type WebhookListenerConfiguration {
    string host,
    int port,
};

public function WebhookListener::init(WebhookListenerConfiguration config) {
    self.config = config;
    websub:SubscriberServiceEndpointConfiguration sseConfig = { host:config.host, port:config.port };
    sseConfig.topicIdentifier = websub:TOPIC_ID_HEADER_AND_PAYLOAD;
    sseConfig.topicHeader = GITHUB_TOPIC_HEADER;
    sseConfig.topicPayloadKeys = ["action"];
    sseConfig.topicResourceMap = GITHUB_TOPIC_RESOURCE_MAP;
    self.websubListener.init(sseConfig);
}

public function WebhookListener::register(typedesc serviceType) {
    self.websubListener.register(serviceType);
}

public function WebhookListener::start() {
    self.websubListener.start();
}

public function WebhookListener::getCallerActions() returns (http:Connection) {
    return self.websubListener.getCallerActions();
}

public function WebhookListener::stop () {
    self.websubListener.stop();
}

@final string GITHUB_TOPIC_HEADER = "X-GitHub-Event";

@final map<map<string>> GITHUB_TOPIC_RESOURCE_MAP = {
    "action" : {
        "issue_comment::created" : "onIssueCommentCreated",
        "issue_comment::edited" : "onIssueCommentEdited",
        "issue_comment::deleted" : "onIssueCommentDeleted",
        "issues::assigned" : "onIssuesAssigned",
        "issues::unassigned" : "onIssuesUnassigned",
        "issues::labeled" : "onIssuesLabeled",
        "issues::unlabeled" : "onIssuesUnlabeled",
        "issues::opened" : "onIssuesOpened",
        "issues::edited" : "onIssuesEdited",
        "issues::milestoned" : "onIssuesMilestoned",
        "issues::demilestoned" : "onIssuesDemilestoned",
        "issues::closed" : "onIssuesClosed",
        "issues::reopened" : "onIssuesReopened",
        "installation::created" : "onInstallationCreated",
        "installation::deleted" : "onInstallationDeleted",
        "installation_repositories::added" : "onInstallationRepositoriesAdded",
        "installation_repositories::removed" : "onInstallationRepositoriesRemoved",
        "label::created" : "onLabelCreated",
        "label::edited" : "onLabelEdited",
        "label::deleted" : "onLabelDeleted",
        "marketplace_purchase::purchased" : "onMarketplacePurchasePurchased",
        "marketplace_purchase::cancelled" : "onMarketplacePurchaseCancelled",
        "marketplace_purchase::changed" : "onMarketplacePurchaseChanged"
    },
    "ref_type" : {
        "create::repository" : "onCreateRepository",
        "create::branch" : "onCreateBranch",
        "create::tag" : "onCreateTag",
        "delete::branch" : "onDeleteBranch",
        "delete::tag" : "onDeleteTag"
    },
    "TOPIC_ID_HEADER" : {
        "commit_comment" : "onCommitComment",
        "deployment" : "onDeployment",
        "deployment_status" : "onDeploymentStatus",
        "fork" : "onFork",
        "gollum" : "onGollum",
        "member" : "onMember",
        "membership" : "onMembership",
        "milestone" : "onMilestone",
        "organization" : "onOrganization",
        "org_block" : "onOrgBlock",
        "page_build" : "onPageBuild",
        "project_card" : "onProject_card",
        "project_column" : "onProjectColumn",
        "project" : "onProject",
        "public" : "onPublic",
        "pull_request" : "onPullRequest",
        "pull_request_review" : "onPullRequestReview",
        "pull_request_review_comment" : "onPullRequestReviewComment",
        "push" : "onPush",
        "release" : "onRelease",
        "repository" : "onRepository",
        "status" : "onStatus",
        "team" : "onTeam",
        "team_add" : "onTeamAdd",
        "watch" : "onWatch::wso2.github:WatchEvent"
    }
};