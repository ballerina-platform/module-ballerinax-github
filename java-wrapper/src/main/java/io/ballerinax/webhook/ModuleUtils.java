package io.ballerinax.webhook;

import io.ballerina.runtime.api.Environment;
import io.ballerina.runtime.api.Module;

/**
 * {@code ModuleUtils} contains the utility methods for the module.
 * 
 * @since 2.0.0
 */
public class ModuleUtils {

    private static Module websubModule;

    private ModuleUtils() {}

    public static void setModule(Environment environment) {
        websubModule = environment.getCurrentModule();
    }

    public static Module getModule() {
        return websubModule;
    }
}
