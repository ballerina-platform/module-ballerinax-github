## Overview

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

    <img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-github/master/docs/setup/resources/1-developer-settings.png alt="GitHub Developer Settings">

### Step 4: Generate a New Token

1. Click on the **Generate new token** button (you might be asked to enter you password again for security purposes).

### Step 5: Configure & Generate the Token

 - **Note**: Give your token a descriptive name so you can remember it's purpose
 - **Expiration**: Select the duration before the token expires (e.g., 30 days, 60 days, 90 days, custom, or no expiration).
 - **Select Scopes**: Scopes control access for the token. Choose what you need the token for (e.g., repo access, user data access). For typical repository operations, selecting `repo` is often sufficient.

    <img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-github/master/docs/setup/resources/2-generate-token.png alt="Generate new PAT">

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

## Examples

The `GitHub` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-github/tree/master/examples), covering use cases like initializing a new project, creating issues, and managing pull requests.

1. [Initialize a New GitHub Project](https://github.com/ballerina-platform/module-ballerinax-github/tree/master/examples/initialize-new-project) - Create a new repository on GitHub, initialize it with a README file, and add collaborators to the repository.

2. [Create and Assign an Issue in GitHub](https://github.com/ballerina-platform/module-ballerinax-github/tree/master/examples/create-and-assign-issue) - Create a new issue on GitHub, assign it to a specific user, and add labels.

3. [Create and Manage a PullRequest in GitHub](https://github.com/ballerina-platform/module-ballerinax-github/tree/master/examples/create-and-manage-pull-request) - Create a pull request on GitHub, and request changes as necessary.

4. [Star Ballerina-Platform Repositories](https://github.com/ballerina-platform/module-ballerinax-github/tree/master/examples/star-ballerina-repositories) - Fetch all repositories under the `ballerina-platform` organization on GitHub and star each of them
