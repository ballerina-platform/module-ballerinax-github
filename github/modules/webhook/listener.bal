import ballerina/websub;
import ballerina/http;

# The WebSub Hub URL for GitHub.
public const string HUB = "https://api.github.com/hub";

public class Listener {
    private websub:Listener subscriberListener;
    private websub:SubscriberService? subscriberService;

    public isolated function init(int|http:Listener listenTo, websub:ListenerConfiguration? config = ()) returns error? {
        websub:ListenerConfiguration subscriberListenerConfig = {};
        if (config is  websub:ListenerConfiguration) {
            subscriberListenerConfig = config;
        }
        self.subscriberListener = check new(listenTo, subscriberListenerConfig);
        self.subscriberService = ();
    }

    public function attach(SimpleWebhookService s, string[]|string? name = ()) returns error? {
        var configuration = retrieveSubscriberServiceAnnotations(s);
        if (configuration is websub:SubscriberServiceConfiguration) {
            self.subscriberService = new WebSubService(s);
            check self.subscriberListener.attachWithConfig(<websub:SubscriberService>self.subscriberService, configuration, name);
        } else {
            return error ListenerError("Could not find the required service-configurations");
        }
    }

    public isolated function detach(SimpleWebhookService s) returns error? {
        check self.subscriberListener.detach(<WebSubService>self.subscriberService);
    }

    public function 'start() returns error? {
        check self.subscriberListener.'start();
    }

    public isolated function gracefulStop() returns error? {
        return self.subscriberListener.gracefulStop();
    }

    public isolated function immediateStop() returns error? {
        return self.subscriberListener.immediateStop();
    }
}

isolated function retrieveSubscriberServiceAnnotations(SimpleWebhookService serviceType) returns websub:SubscriberServiceConfiguration? {
    typedesc<any> serviceTypedesc = typeof serviceType;
    return serviceTypedesc.@websub:SubscriberServiceConfig;
}
