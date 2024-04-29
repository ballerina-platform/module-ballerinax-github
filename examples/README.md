# Examples

The `GitHub` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-github/tree/master/examples), covering use cases like initializing a new project, creating issues, and managing pull requests.

1. [Initialize a New GitHub Project](https://github.com/ballerina-platform/module-ballerinax-github/tree/master/examples/initialize-new-project) - Create a new repository on GitHub, initialize it with a README file, and add collaborators to the repository.

2. [Create and Assign an Issue in GitHub](https://github.com/ballerina-platform/module-ballerinax-github/tree/master/examples/create-and-assign-issue) - Create a new issue on GitHub, assign it to a specific user, and add labels.

3. [Create and Manage a PullRequest in GitHub](https://github.com/ballerina-platform/module-ballerinax-github/tree/master/examples/create-and-manage-pull-request) - Create a pull request on GitHub, and request changes as necessary.

4. [Star Ballerina-Platform Repositories](https://github.com/ballerina-platform/module-ballerinax-github/tree/master/examples/star-ballerina-repositories) - Fetch all repositories under the `ballerina-platform` organization on GitHub and star each of them

## Prerequisites

1. Follow the [instructions](https://github.com/ballerina-platform/module-ballerinax-github#set-up-guide) to set up the GitHub API.

2. For each example, create a `config.toml` file with your GitHub PAT. Here's an example of how your `config.toml` file should look:

    ```toml
    authToken="<GITHUB_PAT>"
    ```

## Running an Example

Execute the following commands to build an example from the source.

* To build an example

  `bal build <example-name>`


* To run an example

  `bal run <example-name>`

## Building the Examples with the Local Module

**Warning**: Because of the absence of support for reading local repositories for single Ballerina files, the bala of
the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your
local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally.

* To build all the examples

  `./build.sh build`


* To run all the examples

  `./build.sh run`
