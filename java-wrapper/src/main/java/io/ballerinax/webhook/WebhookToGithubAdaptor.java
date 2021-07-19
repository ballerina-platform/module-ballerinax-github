package io.ballerinax.webhook;

import io.ballerina.runtime.api.Environment;
import io.ballerina.runtime.api.Future;
import io.ballerina.runtime.api.Module;
import io.ballerina.runtime.api.async.Callback;
import io.ballerina.runtime.api.async.StrandMetadata;
import io.ballerina.runtime.api.creators.ErrorCreator;
import io.ballerina.runtime.api.creators.ValueCreator;
import io.ballerina.runtime.api.types.MethodType;
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BError;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BObject;
import io.ballerina.runtime.api.values.BString;

import java.util.ArrayList;
import java.util.concurrent.CountDownLatch;

import static io.ballerina.runtime.api.utils.StringUtils.fromString;

public class WebhookToGithubAdaptor {
    public static final String SERVICE_OBJECT = "GITHUB_SERVICE_OBJECT";

    public static void externInit(BObject adaptor, BObject service) {
        adaptor.addNativeData(SERVICE_OBJECT, service);
    }

    public static Object callOnStartupMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnStartupMethod", "onStartup");
    }

    public static Object callOnEventMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnEventMethod", "onEvent");
    }

    public static Object callOnPingMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPingMethod", "onPing");
    }

    public static Object callOnForkMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnForkMethod", "onFork");
    }

    public static Object callOnPushMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPushMethod", "onPush");
    }

    public static Object callOnCreateMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnCreateMethod", "onCreate");
    }

    public static Object callOnReleasePublishedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnReleasePublishedMethod", "onReleasePublished");
    }

    public static Object callOnReleaseUnpublishedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnReleaseUnpublishedMethod", "onReleaseUnpublished");
    }

    public static Object callOnReleaseCreatedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnReleaseCreatedMethod", "onReleaseCreated");
    }

    public static Object callOnReleaseEditedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnReleaseEditedMethod", "onReleaseEdited");
    }

    public static Object callOnReleaseDeletedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnReleaseDeletedMethod", "onReleaseDeleted");
    }

    public static Object callOnPreReleasedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPreReleasedMethod", "onPreReleased");
    }

    public static Object callOnReleasedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnReleasedMethod", "onReleased");
    }

    public static Object callOnWatchStartedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnWatchStartedMethod", "onWatchStarted");
    }

    public static Object callOnIssueCommentCreatedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnIssueCommentCreatedMethod", "onIssueCommentCreated");
    }

    public static Object callOnIssueCommentEditedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnIssueCommentEditedMethod", "onIssueCommentEdited");
    }

    public static Object callOnIssueCommentDeletedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnIssueCommentDeletedMethod", "onIssueCommentDeleted");
    }

    public static Object callOnIssuesAssignedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnIssuesAssignedMethod", "onIssuesAssigned");
    }

    public static Object callOnIssuesUnassignedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnIssuesUnassignedMethod", "onIssuesUnassigned");
    }

    public static Object callOnIssuesLabeledMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnIssuesLabeledMethod", "onIssuesLabeled");
    }

    public static Object callOnIssuesUnlabeledMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnIssuesUnlabeledMethod", "onIssuesUnlabeled");
    }

    public static Object callOnIssuesOpenedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnIssuesOpenedMethod", "onIssuesOpened");
    }

    public static Object callOnIssuesEditedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnIssuesEditedMethod", "onIssuesEdited");
    }

    public static Object callOnIssuesMilestonedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnIssuesMilestonedMethod", "onIssuesMilestoned");
    }

    public static Object callOnIssuesDemilestonedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnIssuesDemilestonedMethod", "onIssuesDemilestoned");
    }

    public static Object callOnIssuesClosedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnIssuesClosedMethod", "onIssuesClosed");
    }

    public static Object callOnIssuesReopenedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnIssuesReopenedMethod", "onIssuesReopened");
    }

    public static Object callOnLabelCreatedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnLabelCreatedMethod", "onLabelCreated");
    }

    public static Object callOnLabelEditedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnLabelEditedMethod", "onLabelEdited");
    }

    public static Object callOnLabelDeletedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnLabelDeletedMethod", "onLabelDeleted");
    }

    public static Object callOnMilestoneCreatedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnMilestoneCreatedMethod", "onMilestoneCreated");
    }

    public static Object callOnMilestoneClosedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnMilestoneClosedMethod", "onMilestoneClosed");
    }

    public static Object callOnMilestoneOpenedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnMilestoneOpenedMethod", "onMilestoneOpened");
    }

    public static Object callOnMilestoneEditedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnMilestoneEditedMethod", "onMilestoneEdited");
    }

    public static Object callOnMilestoneDeletedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnMilestoneDeletedMethod", "onMilestoneDeleted");
    }

    public static Object callOnPullRequestAssignedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestAssignedMethod", "onPullRequestAssigned");
    }

    public static Object callOnPullRequestUnassignedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestUnassignedMethod", "onPullRequestUnassigned");
    }

    public static Object callOnPullRequestReviewRequestedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestReviewRequestedMethod", "onPullRequestReviewRequested");
    }

    public static Object callOnPullRequestReviewRequestRemovedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestReviewRequestRemovedMethod", "onPullRequestReviewRequestRemoved");
    }

    public static Object callOnPullRequestLabeledMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestLabeledMethod", "onPullRequestLabeled");
    }

    public static Object callOnPullRequestUnlabeledMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestUnlabeledMethod", "onPullRequestUnlabeled");
    }

    public static Object callOnPullRequestOpenedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestOpenedMethod", "onPullRequestOpened");
    }

    public static Object callOnPullRequestEditedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestEditedMethod", "onPullRequestEdited");
    }

    public static Object callOnPullRequestClosedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestClosedMethod", "onPullRequestClosed");
    }

    public static Object callOnPullRequestReopenedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestReopenedMethod", "onPullRequestReopened");
    }

    public static Object callOnPullRequestReviewSubmittedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestReviewSubmittedMethod", "onPullRequestReviewSubmitted");
    }

    public static Object callOnPullRequestReviewEditedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestReviewEditedMethod", "onPullRequestReviewEdited");
    }

    public static Object callOnPullRequestReviewDismissedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestReviewDismissedMethod", "onPullRequestReviewDismissed");
    }

    public static Object callOnPullRequestReviewCommentCreatedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestReviewCommentCreatedMethod", "onPullRequestReviewCommentCreated");
    }

    public static Object callOnPullRequestReviewCommentEditedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestReviewCommentEditedMethod", "onPullRequestReviewCommentEdited");
    }

    public static Object callOnPullRequestReviewCommentDeletedMethod(Environment env, BObject adaptor, BMap<BString, Object> message) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT); 
        return invokeRemoteFunction(env, serviceObj, message, "callOnPullRequestReviewCommentDeletedMethod", "onPullRequestReviewCommentDeleted");
    }

    public static BArray getServiceMethodNames(BObject adaptor) {
        BObject serviceObj = (BObject) adaptor.getNativeData(SERVICE_OBJECT);
        ArrayList<BString> methodNamesList = new ArrayList<>();
        for (MethodType method : serviceObj.getType().getMethods()) {
            methodNamesList.add(StringUtils.fromString(method.getName()));
        }
        return ValueCreator.createArrayValue(methodNamesList.toArray(BString[]::new));
    }

    private static Object invokeRemoteFunction(Environment env, BObject bWebhookService, BMap<BString, Object> message,
                                               String parentFunctionName, String remoteFunctionName) {
        Future balFuture = env.markAsync();
        Module module = ModuleUtils.getModule();
        StrandMetadata metadata = new StrandMetadata(module.getOrg(), module.getName(), module.getVersion(),
                parentFunctionName);
        Object[] args = new Object[]{message, true};
        env.getRuntime().invokeMethodAsync(bWebhookService, remoteFunctionName, null, metadata, new Callback() {
            @Override
            public void notifySuccess(Object result) {
                if(result instanceof BError){
                    BError error = (BError) result;
                    error.printStackTrace();
                }
                balFuture.complete(result);
            }

            @Override
            public void notifyFailure(BError bError) {
                BString errorMessage = fromString("service method invocation failed: " + bError.getErrorMessage());
                BError invocationError = ErrorCreator.createError(errorMessage, bError);
                balFuture.complete(invocationError);
            }
        }, args);
        return null;
    }
}