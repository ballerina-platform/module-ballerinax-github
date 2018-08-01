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

    public WebhookListenerConfiguration webhookListenerConfig;

    private websub:Listener websubListener;

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

public type WebhookListenerConfiguration record {
    string host,
    int port,
};

function WebhookListener::init(WebhookListenerConfiguration config) {
    self.webhookListenerConfig = config;
    websub:ExtensionConfig extensionConfig = {
        topicIdentifier: websub:TOPIC_ID_HEADER_AND_PAYLOAD,
        topicHeader: GITHUB_TOPIC_HEADER,
        headerResourceMap: GITHUB_TOPIC_HEADER_RESOURCE_MAP,
        payloadKeyResourceMap: GITHUB_TOPIC_PAYLOAD_KEY_RESOURCE_MAP,
        headerAndPayloadKeyResourceMap: GITHUB_TOPIC_HEADER_AND_PAYLOAD_KEY_RESOURCE_MAP
    };
    websub:SubscriberServiceEndpointConfiguration sseConfig = { host: config.host, port: config.port,
                                                                extensionConfig: extensionConfig };
    self.websubListener.init(sseConfig);
}

function WebhookListener::register(typedesc serviceType) {
    self.websubListener.register(serviceType);
}

function WebhookListener::start() {
    self.websubListener.start();
}

function WebhookListener::getCallerActions() returns (http:Connection) {
    return self.websubListener.getCallerActions();
}

function WebhookListener::stop () {
    self.websubListener.stop();
}

@final string GITHUB_TOPIC_HEADER = "X-GitHub-Event";

@final map<(string, typedesc)> GITHUB_TOPIC_HEADER_RESOURCE_MAP = {
    "watch" : ("onWatch", WatchEvent)
};

@final map<map<(string, typedesc)>> GITHUB_TOPIC_PAYLOAD_KEY_RESOURCE_MAP = {
    "action" : {
        "opened" : ("onIssueOpened", IssueEvent),
        "edited" : ("onIssueEdited", IssueEvent),
        "closed" : ("onIssueClosed", IssueEvent)
    }
};

@final map<map<map<(string, typedesc)>>> GITHUB_TOPIC_HEADER_AND_PAYLOAD_KEY_RESOURCE_MAP = {
    "issue_comment" : {
        "action" : {
            "created" : ("onIssueCommentCreated", IssueCommentEvent),
            "edited" : ("onIssueCommentEdited", IssueCommentEvent),
            "deleted" : ("onIssueCommentDeleted", IssueCommentEvent)
        }
    }
};
