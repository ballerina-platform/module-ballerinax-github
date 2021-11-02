// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import ballerina/websub;
import ballerina/http;
import ballerina/log;

# The WebSub Hub URL for GitHub.
public const string HUB = "https://api.github.com/hub";

# GitHub REST API base url
public const string GITHUB_REST_API_BASE_URL = "https://api.github.com";

# Listener for GitHub connector
# 
@display {label: "GitHub Listener", iconPath:"resources/github.svg"}
public class Listener {
    private websub:Listener subscriberListener;
    private websub:SubscriberService? subscriberService;
    private string? accessToken;


    # Initializes GitHub connector listener.
    #
    # + listenTo - Port number or `http:Listener`
    # + config - Configurations for configure the underlying HTTP listener of the WebSub listener.
    # + return - An error on failure of initialization or else `()`
    public isolated function init(int|http:Listener listenTo, websub:ListenerConfiguration? config = ()) returns error? {
        websub:ListenerConfiguration subscriberListenerConfig = {};
        if (config is  websub:ListenerConfiguration) {
            subscriberListenerConfig = config;
        }
        self.subscriberListener = check new(listenTo, subscriberListenerConfig);
        self.subscriberService = ();
        self.accessToken = ();
        return;
    }

    public isolated function attach(SimpleWebhookService s, string[]|string? name = ()) returns error? {
        var configuration = retrieveSubscriberServiceAnnotations(s);
        if (configuration is websub:SubscriberServiceConfiguration) {
            websub:SubscriberServiceConfiguration config = <websub:SubscriberServiceConfiguration> configuration;
            if (config?.httpConfig is http:ClientConfiguration) {
                http:ClientConfiguration clientConfig = <http:ClientConfiguration> config?.httpConfig;
                if (clientConfig.auth is http:ClientAuthConfig) {
                    http:ClientAuthConfig auth = <http:ClientAuthConfig> clientConfig.auth;
                    self.accessToken = auth?.token;
                }
            }
            WebhookToGithubAdaptor adaptor = check new (s);
            self.subscriberService = new WebSubService(adaptor);
            check self.subscriberListener.attachWithConfig(<websub:SubscriberService>self.subscriberService, 
                    configuration, name);
        } else {
            return error ListenerError("Could not find the required service-configurations");
        }
        return;
    }

    public isolated function detach(SimpleWebhookService s) returns error? {
        check self.subscriberListener.detach(<WebSubService>self.subscriberService);
        return;
    }

    public isolated  function 'start() returns error? {
        check self.subscriberListener.'start();
        return;
    }

    public isolated function gracefulStop() returns error? {
        check self.deleteWebhook();
        return self.subscriberListener.gracefulStop();
    }

    public isolated function immediateStop() returns error? {
        check self.deleteWebhook();
        return self.subscriberListener.immediateStop();
    }

    private isolated function deleteWebhook() returns error? {
        if (self.subscriberService is WebSubService) {
            WebSubService websubService = <WebSubService>self.subscriberService;
            string? endpoint = websubService.getDeleteWeebhookEndpoint();
            if(endpoint is string){
                http:Request request = new;
                if(self.accessToken is string) {
                    request.setHeader("Authorization", "token " + <string>self.accessToken);
                    http:Client httpClient = check new (GITHUB_REST_API_BASE_URL, {});
                    http:Response result = check httpClient->delete(endpoint, request);
                    if (result.statusCode == 204) {
                        log:printInfo("Webhook deleted!");
                    }else {
                        log:printError("Webhook deletion failed : "+ check result.getTextPayload());
                    }
                }
            }
        }
        return;
    }
}

isolated function retrieveSubscriberServiceAnnotations(SimpleWebhookService serviceType) returns 
        websub:SubscriberServiceConfiguration? {
    typedesc<any> serviceTypedesc = typeof serviceType;
    return serviceTypedesc.@websub:SubscriberServiceConfig;
}
