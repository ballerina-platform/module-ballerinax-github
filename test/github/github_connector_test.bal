//
// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
//

package test.wso2.github;

import ballerina.test;
import ballerina.util;
import ballerina.mime;
import ballerina.io;
import ballerina.net.http;

function beforeTestFunction () {
    _ = test:startService("echo");
}

function testBoolean () {
    //
    test:assertBooleanEquals(true,false, "Value doesn't match");
    io:println("Hello World!");
}


public function main (string[] args)  {

    beforeTestFunction();
    //io:println(serviceUrl);
    //http:HttpClient client = create http:HttpClient(serviceUrl, {});

    http:OutRequest request = {};
    http:InResponse response = {};

}
