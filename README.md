# Ballerina GitHub Connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-github/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-github/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-github/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-github/actions/workflows/trivy-scan.yml)
[![codecov](https://codecov.io/gh/ballerina-platform/module-ballerinax-github/branch/master/graph/badge.svg)](https://codecov.io/gh/ballerina-platform/module-ballerinax-github)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-github/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-github/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-github.svg)](https://github.com/ballerina-platform/module-ballerinax-github/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/github.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fgithub)

[GitHub](https://github.com/) is a widely used platform for version control and collaboration, allowing developers to work together on projects from anywhere. It hosts a vast array of both open-source and private projects, providing a suite of development tools for collaborative software development.

This Ballerina connector is designed to interface with [GitHub's REST API (version 2022-11-28)](https://docs.github.com/en/rest?apiVersion=2022-11-28), facilitating programmatic access to GitHub's services. It enables developers to automate tasks, manage repositories, issues, pull requests, and more, directly from Ballerina applications.

## Setup guide

To use the GitHub Connector in Ballerina, you must have a GitHub account and a Personal Access Token (PAT) for authentication. If you already have a GitHub account, you can integrate the connector with your existing account. If not, you can create a new GitHub account by visiting [GitHub's Sign Up page](https://github.com/) and following the registration process. Once you have a GitHub account, you can proceed to create a PAT.

### Step 1: Access GitHub Settings

1. Once logged in, click on the profile picture in the top-right corner of the page.
2. Select **Settings** from the dropdown menu.

### Step 2: Navigate to Developer Settings

1. Scroll down in the sidebar on the left side of the settings page.
2. click on **Developer settings** located near the bottom.

### Step 3: Go to Personal Access Tokens

1. Inside Developer Settings find and click on **Personal access tokens**.

    <img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-github/master/docs/setup/resources/1-developer-settings.png alt="GitHub Developer Settings" width="50%">

### Step 4: Generate a New Token

1. Click on the **Generate new token** button (you might be asked to enter you password again for security purposes).

### Step 5: Configure & Generate the Token

 - **Note**: Give your token a descriptive name so you can remember it's purpose
 - **Expiration**: Select the duration before the token expires (e.g., 30 days, 60 days, 90 days, custom, or no expiration).
 - **Select Scopes**: Scopes control access for the token. Choose what you need the token for (e.g., repo access, user data access). For typical repository operations, selecting `repo` is often sufficient.

    <img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-github/master/docs/setup/resources/2-generate-token.png alt="Generate new PAT" width="50%">

## Quickstart

To use the `GitHub` connector in your Ballerina application, modify the `.bal` file as follows:

### Step 1: Import the connector

Import the `ballerinax/github` package into your Ballerina project.

```ballerina
import ballerinax/github;
```

### Step 2: Instantiate a new connector

Create a `github:ConnectionConfig` with the obtained PAT and initialize the connector with it.

```ballerina
github:ConnectionConfig gitHubConfig = {
    auth: {
        token: authToken
    }
};
github:Client github = check new (gitHubConfig);
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Get Private Repositories of Authenticated User

```ballerina
github:Repository[] userRepos = check github->/user/repos(visibility = "private", 'type = ());
```

#### Create a Private Repository

```ballerina
github:User_repos_body body = {
    name: "New Test Repo Name",
    'private: true,
    description: "New Test Repo Description"
};
github:Repository createdRepo = check github->/user/repos.post(body);
```

## Issues and projects

The **Issues** and **Projects** tabs are disabled for this repository as this is part of the Ballerina library. To report bugs, request new features, start new discussions, view project boards, etc., visit the Ballerina library [parent repository](https://github.com/ballerina-platform/ballerina-library).

This repository only contains the source code for the package.

## Build from the source

### Prerequisites

1. Download and install Java SE Development Kit (JDK) version 17. You can download it from either of the following sources:

   * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
   * [OpenJDK](https://adoptium.net/)

    > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

    > **Note**: Ensure that the Docker daemon is running before executing any tests.

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environment:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`github` package](https://lib.ballerina.io/ballerinax/github/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
