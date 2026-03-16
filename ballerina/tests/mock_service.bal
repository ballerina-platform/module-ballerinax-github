// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.org).
//
// WSO2 LLC. licenses this file to you under the Apache License,
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

import ballerina/http;

configurable int MOCK_SERVICE_PORT = 9090;

int nextReviewId = 1000;

service on new http:Listener(MOCK_SERVICE_PORT) {

    // ─── Users ───

    resource function get user() returns json {
        return {
            "login": "testUser",
            "id": 1,
            "node_id": "MDQ6VXNlcjE=",
            "avatar_url": "https://mock-url",
            "gravatar_id": "",
            "url": "https://mock-url",
            "html_url": "https://mock-url",
            "followers_url": "https://mock-url",
            "following_url": "https://mock-url",
            "gists_url": "https://mock-url",
            "starred_url": "https://mock-url",
            "subscriptions_url": "https://mock-url",
            "organizations_url": "https://mock-url",
            "repos_url": "https://mock-url",
            "events_url": "https://mock-url",
            "received_events_url": "https://mock-url",
            "type": "User",
            "site_admin": false,
            "name": "Test User",
            "company": null,
            "blog": "",
            "location": null,
            "email": null,
            "hireable": null,
            "bio": null,
            "public_repos": 10,
            "public_gists": 0,
            "followers": 5,
            "following": 3,
            "created_at": "2020-01-01T00:00:00Z",
            "updated_at": "2024-01-01T00:00:00Z"
        };
    }

    resource function get users/[string username]() returns json {
        return {
            "login": username,
            "id": 1,
            "node_id": "MDQ6VXNlcjE=",
            "avatar_url": "https://mock-url",
            "gravatar_id": "",
            "url": "https://mock-url",
            "html_url": "https://mock-url",
            "followers_url": "https://mock-url",
            "following_url": "https://mock-url",
            "gists_url": "https://mock-url",
            "starred_url": "https://mock-url",
            "subscriptions_url": "https://mock-url",
            "organizations_url": "https://mock-url",
            "repos_url": "https://mock-url",
            "events_url": "https://mock-url",
            "received_events_url": "https://mock-url",
            "type": "User",
            "site_admin": false,
            "name": "Test User",
            "company": null,
            "blog": "",
            "location": null,
            "email": null,
            "hireable": null,
            "bio": null,
            "public_repos": 10,
            "public_gists": 0,
            "followers": 5,
            "following": 3,
            "created_at": "2020-01-01T00:00:00Z",
            "updated_at": "2024-01-01T00:00:00Z"
        };
    }

    // ─── Repositories ───

    resource function get repos/[string owner]/[string repo]() returns json {
        return repoJson(repo, owner);
    }

    resource function get user/repos() returns json[] {
        return [repoJson("test-repo", "testUser")];
    }

    resource function post user/repos(http:Request req) returns json|error {
        json payload = check req.getJsonPayload();
        string name = check payload.name;
        return repoJson(name, "testUser");
    }

    resource function patch repos/[string owner]/[string repo](http:Request req) returns json|error {
        json payload = check req.getJsonPayload();
        string desc = "Test repository";
        json|error descVal = payload.description;
        if descVal is json && descVal != () {
            desc = descVal.toString();
        }
        return repoJsonWithDesc(repo, owner, desc);
    }

    resource function delete repos/[string owner]/[string repo]() returns http:NoContent {
        return {};
    }

    resource function get users/[string username]/repos() returns json[] {
        return [minimalRepoJson("test-repo", username)];
    }

    resource function get orgs/[string org]/repos() returns json[] {
        return [minimalRepoJson("org-repo", org)];
    }

    // ─── Branches ───

    resource function get repos/[string owner]/[string repo]/branches() returns json[] {
        return [
            {
                "name": "master",
                "commit": {"sha": "abc123", "url": "https://mock-url"},
                "protected": false,
                "protection_url": "https://mock-url"
            }
        ];
    }

    resource function get repos/[string owner]/[string repo]/branches/[string branch]() returns json {
        return {
            "name": branch,
            "commit": commitJson("9e7ce2f52536e7c5b90f8fee35f129fb14d1631f"),
            "protection": {},
            "protection_url": "https://mock-url",
            "protected": false,
            "_links": {"html": "https://mock-url", "self": "https://mock-url"}
        };
    }

    // ─── Collaborators ───

    resource function get repos/[string owner]/[string repo]/collaborators() returns json[] {
        return [
            {
                "login": owner,
                "id": 1,
                "node_id": "MDQ6VXNlcjE=",
                "avatar_url": "https://mock-url",
                "gravatar_id": "",
                "url": "https://mock-url",
                "html_url": "https://mock-url",
                "followers_url": "https://mock-url",
                "following_url": "https://mock-url",
                "gists_url": "https://mock-url",
                "starred_url": "https://mock-url",
                "subscriptions_url": "https://mock-url",
                "organizations_url": "https://mock-url",
                "repos_url": "https://mock-url",
                "events_url": "https://mock-url",
                "received_events_url": "https://mock-url",
                "type": "User",
                "site_admin": false,
                "permissions": {"admin": true, "push": true, "pull": true},
                "role_name": "admin"
            }
        ];
    }

    // ─── Milestones ───

    resource function get repos/[string owner]/[string repo]/milestones() returns json[] {
        return [milestoneJson(1), milestoneJson(2)];
    }

    resource function get repos/[string owner]/[string repo]/milestones/[int milestoneNumber]() returns json {
        return milestoneJson(milestoneNumber);
    }

    // ─── Issues ───

    resource function post repos/[string owner]/[string repo]/issues(http:Request req) returns json|error {
        json payload = check req.getJsonPayload();
        string title = check payload.title;
        return issueJson(100, 42, title, "open");
    }

    resource function patch repos/[string owner]/[string repo]/issues/[int issueNumber](http:Request req) returns json|error {
        json payload = check req.getJsonPayload();
        string title = "Test Issue";
        json|error titleVal = payload.title;
        if titleVal is json && titleVal != () {
            title = titleVal.toString();
        }
        string state = "open";
        json|error stateVal = payload.state;
        if stateVal is json && stateVal != () {
            state = stateVal.toString();
        }
        return issueJson(100, issueNumber, title, state);
    }

    resource function get repos/[string owner]/[string repo]/issues/[int issueNumber]() returns json {
        return issueJson(100, issueNumber, "Test Issue", "open");
    }

    resource function get repos/[string owner]/[string repo]/issues() returns json[] {
        return [issueJson(100, 42, "Test Issue", "open")];
    }

    // ─── Issue Comments ───

    resource function post repos/[string owner]/[string repo]/issues/[int issueNumber]/comments(http:Request req) returns json|error {
        json payload = check req.getJsonPayload();
        string body = check payload.body;
        return commentJson(200, body, "testUser");
    }

    resource function patch repos/[string owner]/[string repo]/issues/comments/[int commentId](http:Request req) returns json|error {
        json payload = check req.getJsonPayload();
        string body = check payload.body;
        return commentJson(commentId, body, "testUser");
    }

    resource function delete repos/[string owner]/[string repo]/issues/comments/[int commentId]() returns http:NoContent {
        return {};
    }

    // ─── Labels ───

    resource function get repos/[string owner]/[string repo]/labels/[string name]() returns json {
        return labelJson(name);
    }

    resource function get repos/[string owner]/[string repo]/issues/[int issueNumber]/labels() returns json[] {
        return [labelJson("bug"), labelJson("enhancement")];
    }

    resource function post repos/[string owner]/[string repo]/issues/[int issueNumber]/labels(http:Request req) returns json[] {
        return [labelJson("bug"), labelJson("enhancement")];
    }

    resource function delete repos/[string owner]/[string repo]/issues/[int issueNumber]/labels/[string name]() returns json[] {
        return [labelJson("enhancement")];
    }

    // ─── Git Operations ───

    resource function post repos/[string owner]/[string repo]/git/refs(http:Request req) returns json|error {
        json payload = check req.getJsonPayload();
        string ref = check payload.ref;
        string sha = check payload.sha;
        return gitRefJson(ref, sha);
    }

    resource function post repos/[string owner]/[string repo]/git/blobs(http:Request req) returns json {
        return {"sha": "a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2", "url": "https://mock-url"};
    }

    resource function get repos/[string owner]/[string repo]/git/commits/[string sha]() returns json {
        return gitCommitJson(sha, "b1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6b1b2");
    }

    resource function post repos/[string owner]/[string repo]/git/trees(http:Request req) returns json {
        return {
            "sha": "c1c2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6c1c2",
            "url": "https://mock-url",
            "tree": [],
            "truncated": false
        };
    }

    resource function post repos/[string owner]/[string repo]/git/commits(http:Request req) returns json|error {
        json payload = check req.getJsonPayload();
        string treeSha = check payload.tree;
        return gitCommitJson("d1d2d3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6d1d2", treeSha);
    }

    resource function patch repos/[string owner]/[string repo]/git/refs/[string ref](http:Request req) returns json {
        string fullRef = string `refs/${ref}`;
        return gitRefJson(fullRef, "d1d2d3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6d1d2");
    }

    resource function delete repos/[string owner]/[string repo]/git/refs/[string ref]() returns http:NoContent {
        return {};
    }

    // ─── Pull Requests ───

    resource function post repos/[string owner]/[string repo]/pulls(http:Request req) returns json|error {
        json payload = check req.getJsonPayload();
        string title = check payload.title;
        return pullRequestJson(300, 7, title, "open");
    }

    resource function get repos/[string owner]/[string repo]/pulls() returns json[] {
        return [pullRequestSimpleJson(300, 7, "Test PR", "open")];
    }

    resource function get repos/[string owner]/[string repo]/pulls/[int pullNumber]() returns json {
        return pullRequestJson(300, pullNumber, "Test PR", "open");
    }

    resource function patch repos/[string owner]/[string repo]/pulls/[int pullNumber](http:Request req) returns json|error {
        json payload = check req.getJsonPayload();
        string state = "open";
        json|error stateVal = payload.state;
        if stateVal is json && stateVal != () {
            state = stateVal.toString();
        }
        return pullRequestJson(300, pullNumber, "Updated PR", state);
    }

    resource function get repos/[string owner]/[string repo]/pulls/[int pullNumber]/commits() returns json[] {
        return [commitJson("abc123")];
    }

    // ─── Pull Request Reviews ───

    resource function post repos/[string owner]/[string repo]/pulls/[int pullNumber]/reviews(http:Request req) returns json|error {
        json payload = check req.getJsonPayload();
        string body = check payload.body;
        int reviewId;
        lock {
            nextReviewId += 1;
            reviewId = nextReviewId;
        }
        return reviewJson(reviewId, body);
    }

    resource function put repos/[string owner]/[string repo]/pulls/[int pullNumber]/reviews/[int reviewId](http:Request req) returns json|error {
        json payload = check req.getJsonPayload();
        string body = check payload.body;
        return reviewJson(reviewId, body);
    }

    resource function delete repos/[string owner]/[string repo]/pulls/[int pullNumber]/reviews/[int reviewId]() returns json {
        return reviewJson(reviewId, "deleted review");
    }

    // ─── Organizations ───

    resource function get orgs/[string org]() returns json {
        return {
            "login": org,
            "id": 1000,
            "node_id": "MDEyOk9yZzEwMDA=",
            "url": "https://mock-url",
            "repos_url": "https://mock-url",
            "events_url": "https://mock-url",
            "hooks_url": "https://mock-url",
            "issues_url": "https://mock-url",
            "members_url": "https://mock-url",
            "public_members_url": "https://mock-url",
            "avatar_url": "https://mock-url",
            "description": "Test Organization",
            "type": "Organization",
            "has_organization_projects": true,
            "has_repository_projects": true,
            "public_repos": 5,
            "public_gists": 0,
            "followers": 0,
            "following": 0,
            "html_url": "https://mock-url",
            "created_at": "2020-01-01T00:00:00Z",
            "updated_at": "2024-01-01T00:00:00Z"
        };
    }

    resource function get users/[string username]/orgs() returns json[] {
        return [
            {
                "login": "test-org",
                "id": 1000,
                "node_id": "MDEyOk9yZzEwMDA=",
                "url": "https://mock-url",
                "repos_url": "https://mock-url",
                "events_url": "https://mock-url",
                "hooks_url": "https://mock-url",
                "issues_url": "https://mock-url",
                "members_url": "https://mock-url",
                "public_members_url": "https://mock-url",
                "avatar_url": "https://mock-url",
                "description": "Test Org"
            }
        ];
    }

    resource function get orgs/[string org]/members() returns json[] {
        return [simpleUserJson("member1")];
    }

    // ─── Content ───

    resource function get repos/[string owner]/[string repo]/contents/[string path]() returns json {
        if path.includes(".") {
            return {
                "type": "file",
                "encoding": "base64",
                "size": 100,
                "name": "main.bal",
                "path": path,
                "content": "dGVzdCBjb250ZW50",
                "sha": "abc123",
                "url": "https://mock-url",
                "git_url": "https://mock-url",
                "html_url": "https://mock-url",
                "download_url": "https://mock-url",
                "_links": {"git": "https://mock-url", "html": "https://mock-url", "self": "https://mock-url"}
            };
        }
        return [
            {
                "type": "dir",
                "size": 0,
                "name": "db",
                "path": "src/db",
                "sha": "abc123",
                "url": "https://mock-url",
                "git_url": "https://mock-url",
                "html_url": "https://mock-url",
                "download_url": null,
                "_links": {"git": "https://mock-url", "html": "https://mock-url", "self": "https://mock-url"}
            }
        ];
    }

    resource function get repos/[string owner]/[string repo]/languages() returns json {
        return {"Ballerina": 1000, "Java": 500};
    }

    // ─── Stars & Gists ───

    resource function put user/starred/[string owner]/[string repo]() returns http:NoContent {
        return {};
    }

    resource function delete user/starred/[string owner]/[string repo]() returns http:NoContent {
        return {};
    }

    resource function put gists/[string gistId]/star() returns http:NoContent {
        return {};
    }

    resource function delete gists/[string gistId]/star() returns http:NoContent {
        return {};
    }
}

// ─── Helper functions ───

function repoJsonWithDesc(string name, string owner, string desc) returns json {
    return {
        "id": 1,
        "node_id": "MDEwOlJlcG9zaXRvcnkx",
        "name": name,
        "full_name": string `${owner}/${name}`,
        "owner": simpleUserJson(owner),
        "private": false,
        "html_url": "https://mock-url",
        "description": desc,
        "fork": false,
        "url": "https://mock-url",
        "archive_url": "https://mock-url",
        "assignees_url": "https://mock-url",
        "blobs_url": "https://mock-url",
        "branches_url": "https://mock-url",
        "collaborators_url": "https://mock-url",
        "comments_url": "https://mock-url",
        "commits_url": "https://mock-url",
        "compare_url": "https://mock-url",
        "contents_url": "https://mock-url",
        "contributors_url": "https://mock-url",
        "deployments_url": "https://mock-url",
        "downloads_url": "https://mock-url",
        "events_url": "https://mock-url",
        "forks_url": "https://mock-url",
        "git_commits_url": "https://mock-url",
        "git_refs_url": "https://mock-url",
        "git_tags_url": "https://mock-url",
        "hooks_url": "https://mock-url",
        "issue_comment_url": "https://mock-url",
        "issue_events_url": "https://mock-url",
        "issues_url": "https://mock-url",
        "keys_url": "https://mock-url",
        "labels_url": "https://mock-url",
        "languages_url": "https://mock-url",
        "merges_url": "https://mock-url",
        "milestones_url": "https://mock-url",
        "notifications_url": "https://mock-url",
        "pulls_url": "https://mock-url",
        "releases_url": "https://mock-url",
        "ssh_url": "git@mock-url",
        "stargazers_url": "https://mock-url",
        "statuses_url": "https://mock-url",
        "subscribers_url": "https://mock-url",
        "subscription_url": "https://mock-url",
        "tags_url": "https://mock-url",
        "teams_url": "https://mock-url",
        "trees_url": "https://mock-url",
        "clone_url": "https://mock-url",
        "git_url": "git://mock-url",
        "svn_url": "https://mock-url",
        "forks": 0,
        "open_issues": 0,
        "watchers": 0,
        "size": 100,
        "default_branch": "master",
        "stargazers_count": 0,
        "watchers_count": 0,
        "has_issues": true,
        "has_projects": true,
        "has_downloads": true,
        "has_wiki": true,
        "has_pages": false,
        "has_discussions": false,
        "forks_count": 0,
        "archived": false,
        "disabled": false,
        "open_issues_count": 0,
        "allow_forking": true,
        "is_template": false,
        "visibility": "public",
        "license": null,
        "mirror_url": null,
        "homepage": null,
        "language": null,
        "created_at": "2020-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z",
        "pushed_at": "2024-01-01T00:00:00Z",
        "subscribers_count": 1,
        "network_count": 0
    };
}

function repoJson(string name, string owner) returns json {
    return repoJsonWithDesc(name, owner, "Test repository");
}

function minimalRepoJson(string name, string owner) returns json {
    return {
        "id": 1,
        "node_id": "MDEwOlJlcG9zaXRvcnkx",
        "name": name,
        "full_name": string `${owner}/${name}`,
        "owner": simpleUserJson(owner),
        "private": false,
        "html_url": "https://mock-url",
        "description": "Test repository",
        "fork": false,
        "url": "https://mock-url",
        "archive_url": "https://mock-url",
        "assignees_url": "https://mock-url",
        "blobs_url": "https://mock-url",
        "branches_url": "https://mock-url",
        "collaborators_url": "https://mock-url",
        "comments_url": "https://mock-url",
        "commits_url": "https://mock-url",
        "compare_url": "https://mock-url",
        "contents_url": "https://mock-url",
        "contributors_url": "https://mock-url",
        "deployments_url": "https://mock-url",
        "downloads_url": "https://mock-url",
        "events_url": "https://mock-url",
        "forks_url": "https://mock-url",
        "git_commits_url": "https://mock-url",
        "git_refs_url": "https://mock-url",
        "git_tags_url": "https://mock-url",
        "hooks_url": "https://mock-url",
        "issue_comment_url": "https://mock-url",
        "issue_events_url": "https://mock-url",
        "issues_url": "https://mock-url",
        "keys_url": "https://mock-url",
        "labels_url": "https://mock-url",
        "languages_url": "https://mock-url",
        "merges_url": "https://mock-url",
        "milestones_url": "https://mock-url",
        "notifications_url": "https://mock-url",
        "pulls_url": "https://mock-url",
        "releases_url": "https://mock-url",
        "ssh_url": "git@mock-url",
        "stargazers_url": "https://mock-url",
        "statuses_url": "https://mock-url",
        "subscribers_url": "https://mock-url",
        "subscription_url": "https://mock-url",
        "tags_url": "https://mock-url",
        "teams_url": "https://mock-url",
        "trees_url": "https://mock-url"
    };
}

function simpleUserJson(string login) returns json {
    return {
        "login": login,
        "id": 1,
        "node_id": "MDQ6VXNlcjE=",
        "avatar_url": "https://mock-url",
        "gravatar_id": "",
        "url": "https://mock-url",
        "html_url": "https://mock-url",
        "followers_url": "https://mock-url",
        "following_url": "https://mock-url",
        "gists_url": "https://mock-url",
        "starred_url": "https://mock-url",
        "subscriptions_url": "https://mock-url",
        "organizations_url": "https://mock-url",
        "repos_url": "https://mock-url",
        "events_url": "https://mock-url",
        "received_events_url": "https://mock-url",
        "type": "User",
        "site_admin": false
    };
}

function milestoneJson(int number) returns json {
    return {
        "url": "https://mock-url",
        "html_url": "https://mock-url",
        "labels_url": "https://mock-url",
        "id": number,
        "node_id": "MDk6TWlsZXN0b25lMQ==",
        "number": number,
        "title": string `Milestone ${number}`,
        "description": "Test milestone",
        "creator": simpleUserJson("testUser"),
        "open_issues": 1,
        "closed_issues": 0,
        "state": "open",
        "created_at": "2020-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z",
        "due_on": null,
        "closed_at": null
    };
}

function issueJson(int id, int number, string title, string state) returns json {
    return {
        "id": id,
        "node_id": "MDU6SXNzdWUx",
        "url": "https://mock-url",
        "repository_url": "https://mock-url",
        "labels_url": "https://mock-url",
        "comments_url": "https://mock-url",
        "events_url": "https://mock-url",
        "html_url": "https://mock-url",
        "number": number,
        "state": state,
        "title": title,
        "body": "Test issue body",
        "user": simpleUserJson("testUser"),
        "labels": [],
        "assignees": [],
        "milestone": milestoneJson(2),
        "locked": false,
        "comments": 0,
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z",
        "closed_at": null,
        "author_association": "OWNER",
        "reactions": {
            "url": "https://mock-url",
            "total_count": 0,
            "+1": 0,
            "-1": 0,
            "laugh": 0,
            "hooray": 0,
            "confused": 0,
            "heart": 0,
            "rocket": 0,
            "eyes": 0
        }
    };
}

function commentJson(int id, string body, string login) returns json {
    return {
        "id": id,
        "node_id": "MDEyOklzc3VlQ29tbWVudDE=",
        "url": "https://mock-url",
        "html_url": "https://mock-url",
        "body": body,
        "user": simpleUserJson(login),
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z",
        "issue_url": "https://mock-url",
        "author_association": "OWNER"
    };
}

function labelJson(string name) returns json {
    return {
        "id": 1,
        "node_id": "MDU6TGFiZWwx",
        "url": "https://mock-url",
        "name": name,
        "color": "fc2929",
        "default": false,
        "description": "Test label"
    };
}

function gitRefJson(string ref, string sha) returns json {
    return {
        "ref": ref,
        "node_id": "MDM6UmVmMQ==",
        "url": "https://mock-url",
        "object": {
            "type": "commit",
            "sha": sha,
            "url": "https://mock-url"
        }
    };
}

function gitCommitJson(string sha, string treeSha) returns json {
    return {
        "sha": sha,
        "node_id": "MDM6Q29tbWl0MQ==",
        "url": "https://mock-url",
        "html_url": "https://mock-url",
        "author": {"name": "Test", "email": "test@test.com", "date": "2024-01-01T00:00:00Z"},
        "committer": {"name": "Test", "email": "test@test.com", "date": "2024-01-01T00:00:00Z"},
        "tree": {"sha": treeSha, "url": "https://mock-url"},
        "message": "Test commit",
        "parents": [],
        "verification": {"verified": false, "reason": "unsigned", "signature": null, "payload": null}
    };
}

function linkJson() returns json {
    return {"href": "https://mock-url"};
}

function pullRequestJson(int id, int number, string title, string state) returns json {
    return {
        "id": id,
        "node_id": "MDExOlB1bGxSZXF1ZXN0MQ==",
        "url": "https://mock-url",
        "html_url": "https://mock-url",
        "diff_url": "https://mock-url",
        "patch_url": "https://mock-url",
        "issue_url": "https://mock-url",
        "commits_url": "https://mock-url",
        "review_comments_url": "https://mock-url",
        "review_comment_url": "https://mock-url",
        "comments_url": "https://mock-url",
        "statuses_url": "https://mock-url",
        "number": number,
        "state": state,
        "locked": false,
        "title": title,
        "body": "Test PR body",
        "user": simpleUserJson("testUser"),
        "labels": [],
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z",
        "closed_at": null,
        "merged_at": null,
        "merge_commit_sha": null,
        "merged": false,
        "mergeable": true,
        "rebaseable": true,
        "merged_by": null,
        "auto_merge": null,
        "milestone": null,
        "assignee": null,
        "maintainer_can_modify": false,
        "head": {
            "label": "testUser:feature",
            "ref": "feature",
            "sha": "abc123",
            "user": simpleUserJson("testUser"),
            "repo": repoJson("test-repo", "testUser")
        },
        "base": {
            "label": "testUser:master",
            "ref": "master",
            "sha": "def456",
            "user": simpleUserJson("testUser"),
            "repo": repoJson("test-repo", "testUser")
        },
        "author_association": "OWNER",
        "_links": {
            "self": linkJson(),
            "html": linkJson(),
            "issue": linkJson(),
            "comments": linkJson(),
            "review_comments": linkJson(),
            "review_comment": linkJson(),
            "commits": linkJson(),
            "statuses": linkJson()
        },
        "mergeable_state": "clean",
        "comments": 0,
        "review_comments": 0,
        "deletions": 0,
        "additions": 1,
        "changed_files": 1,
        "commits": 1
    };
}

function pullRequestSimpleJson(int id, int number, string title, string state) returns json {
    return {
        "id": id,
        "node_id": "MDExOlB1bGxSZXF1ZXN0MQ==",
        "url": "https://mock-url",
        "html_url": "https://mock-url",
        "diff_url": "https://mock-url",
        "patch_url": "https://mock-url",
        "issue_url": "https://mock-url",
        "commits_url": "https://mock-url",
        "review_comments_url": "https://mock-url",
        "review_comment_url": "https://mock-url",
        "comments_url": "https://mock-url",
        "statuses_url": "https://mock-url",
        "number": number,
        "state": state,
        "locked": false,
        "title": title,
        "body": "Test PR body",
        "user": simpleUserJson("testUser"),
        "labels": [],
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z",
        "head": {
            "label": "testUser:feature",
            "ref": "feature",
            "sha": "abc123",
            "user": simpleUserJson("testUser"),
            "repo": repoJson("test-repo", "testUser")
        },
        "base": {
            "label": "testUser:master",
            "ref": "master",
            "sha": "def456",
            "user": simpleUserJson("testUser"),
            "repo": repoJson("test-repo", "testUser")
        },
        "author_association": "OWNER",
        "_links": {
            "self": linkJson(),
            "html": linkJson(),
            "issue": linkJson(),
            "comments": linkJson(),
            "review_comments": linkJson(),
            "review_comment": linkJson(),
            "commits": linkJson(),
            "statuses": linkJson()
        }
    };
}

function commitJson(string sha) returns json {
    return {
        "sha": sha,
        "node_id": "MDM6Q29tbWl0MQ==",
        "url": "https://mock-url",
        "html_url": "https://mock-url",
        "comments_url": "https://mock-url",
        "commit": {
            "url": "https://mock-url",
            "author": {"name": "Test", "email": "test@test.com", "date": "2024-01-01T00:00:00Z"},
            "committer": {"name": "Test", "email": "test@test.com", "date": "2024-01-01T00:00:00Z"},
            "message": "Test commit",
            "comment_count": 0,
            "tree": {"sha": "tree-sha", "url": "https://mock-url"}
        },
        "parents": [],
        "author": simpleUserJson("testUser"),
        "committer": simpleUserJson("testUser")
    };
}

function reviewJson(int id, string body) returns json {
    return {
        "id": id,
        "node_id": "MDE3OlB1bGxSZXF1ZXN0UmV2aWV3MQ==",
        "user": simpleUserJson("testUser"),
        "body": body,
        "state": "COMMENTED",
        "html_url": "https://mock-url",
        "pull_request_url": "https://mock-url",
        "author_association": "OWNER",
        "submitted_at": "2024-01-01T00:00:00Z",
        "commit_id": "abc123",
        "_links": {
            "html": linkJson(),
            "pull_request": linkJson()
        }
    };
}
