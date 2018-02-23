package test.wso2.github;

import ballerina.test;
import ballerina.util;
import ballerina.mime;
function testBoolean () {
    test:assertBooleanEquals(true,false, "Value doesn't match");
    println("Hello World!");




}
public enum State {
    OPEN,
    CLOSED,
    ALL
}
public function main (string[] args)  {
    println(typeof State.OPEN);
}
