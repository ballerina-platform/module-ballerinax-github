# Ballerina GitHub Connector
===================

[![Build](https://github.com/ballerina-platform/module-ballerinax-github/workflows/CI/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-github/actions?query=workflow%3ACI)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-github.svg)](https://github.com/ballerina-platform/module-ballerinax-github/commits/master)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

[GitHub](https://github.com/) brings together the world's largest community of developers to discover, share, and build better software. From open source projects to private team repositories, GitHub is an all-in-one platform for collaborative development.

The `github` is a [Ballerina](https://ballerina.io/) connector for GitHub.

This connector provides operations for connecting and interacting with GitHub GraphQL API endpoints over the network. 

For more information, go to the module(s).
-  [github](github/Module.md)
-  [github.webhook](github/modules/webhook/Module.md)


# Building from the Source
## Setting Up the Prerequisites

1. Download and install Java SE Development Kit (JDK) version 11 (from one of the following locations).

   * [Oracle](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)

   * [OpenJDK](https://adoptopenjdk.net/)

        > **Note:** Set the JAVA_HOME environment variable to the path name of the directory in which you installed JDK.

2. Download and install [Ballerina Swan Lake Beta 2](https://ballerina.io/). 

## Building the Source
Execute the commands below to build from the source after installing Ballerina SL Beta 2 version:

- To build the package:
    ```    
    bal build -c ./github
    ```
- To run the without tests:
    ```
    bal build -c --skip-tests ./github
    ```

# Contributing to Ballerina
As an open source project, Ballerina welcomes contributions from the community. 

For more information, see the [Contribution Guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/main/CONTRIBUTING.md).

# Code of Conduct
All contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

# Useful Links
* Discuss code changes of the Ballerina project via [email](mailto:ballerina-dev@googlegroups.com).
* Chat live with us via our [Slack channel](https://ballerina.io/community/slack/).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
