package io.ballerinax.webhook;

import io.ballerina.runtime.api.async.Callback;
import io.ballerina.runtime.api.values.BError;

import java.util.concurrent.CountDownLatch;

/**
 * This class is used as a callback class for Ballerina resource execution.
 */
public class CallableUnitCallback implements Callback {
    private CountDownLatch latch;
    private Object result;

    public CallableUnitCallback(CountDownLatch latch) {
        this.latch = latch;
    }

    public Object getResult() {
        return this.result;
    }

    @Override
    public void notifySuccess(Object o) {
        this.result = o;
        this.latch.countDown();
    }

    @Override
    public void notifyFailure(BError bError) {
        this.result = bError;
        this.latch.countDown();
    }
}
