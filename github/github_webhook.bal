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

@final map<map<map<(string, typedesc)>|(string, typedesc)>> GITHUB_TOPIC_RESOURCE_MAP = {
    "issue_comment" : {
        "action" : {
            "created" : ("onIssueCommentCreated", IssueCommentEvent),
            "edited" : ("onIssueCommentEdited", IssueCommentEvent),
            "deleted" : ("onIssueCommentDeleted", IssueCommentEvent)
        }
    },
    "create" : {
        "ref_type" : {
            "repository" : ("onCreateRepository", websub:Notification),
            "branch" : ("onCreateBranch", websub:Notification),
            "tag" : ("onCreateTag", websub:Notification)
        }
    },
    "delete" : {
        "ref_type" : {
            "branch" : ("onDeleteBranch", websub:Notification),
            "tag" : ("onDeleteTag", websub:Notification)
        }
    },
    "TOPIC_ID_HEADER" : {
        "watch" : ("onWatch", WatchEvent),
        "commit_comment" : ("onCommitComment", websub:Notification)
    },
    "TOPIC_ID_PAYLOAD_KEY" : {
        "event_type" : {
            "PAYMENT.AUTHORIZATION.CREATED" : ("onPaymentAuthorizatonCreated", websub:Notification),
            "BILLING.PLAN.CREATED" : ("onBillingPlanCreated", websub:Notification)
        },
        "action" : {
            "created" : ("onIssueCommentCreated", IssueCommentEvent),
            "edited" : ("onIssueCommentEdited", IssueCommentEvent),
            "deleted" : ("onIssueCommentDeleted", IssueCommentEvent)
        }
    }
};