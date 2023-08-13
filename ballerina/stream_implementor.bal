// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import ballerina/http;

class CollaboratorStream {
    private User[] currentEntries = [];
    private int index = 0;
    private string? nextPageCursor = ();
    private boolean hasNextPage = false;
    private final http:Client githubGraphQlClient;
    private final string authToken;
    private final string ownerName;
    private final string repositoryName;

    isolated function init(http:Client githubGraphQlClient, string authToken, string ownerName, string repositoryName)
            returns Error? {
        self.githubGraphQlClient = githubGraphQlClient;
        self.authToken = authToken;
        self.ownerName = ownerName;
        self.repositoryName = repositoryName;
        self.currentEntries = check self.fetchCollaborators();
    }

    public isolated function next() returns record {|User value;|}|Error? {
        if self.index < self.currentEntries.length() {
            record {|User value;|} collaborator = {value: self.currentEntries[self.index]};
            self.index += 1;
            return collaborator;
        }
        if self.hasNextPage {
            self.index = 0;
            self.currentEntries = check self.fetchCollaborators();
            record {|User value;|} collaborator = {value: self.currentEntries[self.index]};
            self.index += 1;
            return collaborator;
        }
        return;
    }

    isolated function fetchCollaborators() returns User[]|Error {
        int perPageCount = 100;
        CollaboratorList response = check getCollaborators(self.ownerName, self.repositoryName, perPageCount,
                self.authToken, self.githubGraphQlClient,  self.nextPageCursor);
        self.hasNextPage = response.pageInfo.hasNextPage;
        self.nextPageCursor = response.pageInfo.endCursor;
        return response.collaborators;
    }
}

class BranchStream {
    private Branch[] currentEntries = [];
    private int index = 0;
    private string? nextPageCursor = ();
    private boolean hasNextPage = false;
    private final http:Client githubGraphQlClient;
    private final string authToken;
    private final string ownerName;
    private final string repositoryName;

    isolated function init(http:Client githubGraphQlClient, string authToken, string ownerName, string repositoryName)
            returns Error? {
        self.githubGraphQlClient = githubGraphQlClient;
        self.authToken = authToken;
        self.ownerName = ownerName;
        self.repositoryName = repositoryName;
        self.currentEntries = check self.fetchBranches();
    }

    public isolated function next() returns record {|Branch value;|}|Error? {
        if self.index < self.currentEntries.length() {
            record {|Branch value;|} branch = {value: self.currentEntries[self.index]};
            self.index += 1;
            return branch;
        }
        if self.hasNextPage {
            self.index = 0;
            self.currentEntries = check self.fetchBranches();
            record {|Branch value;|} branch = {value: self.currentEntries[self.index]};
            self.index += 1;
            return branch;
        }
        return;
    }

    isolated function fetchBranches() returns Branch[]|Error {
        int perPageCount = 100;
        BranchList response = check getBranches(self.ownerName, self.repositoryName, perPageCount, self.authToken,
                self.githubGraphQlClient, self.nextPageCursor);
        self.hasNextPage = response.pageInfo.hasNextPage;
        self.nextPageCursor = response.pageInfo.endCursor;
        return response.branches;
    }
}

class LabelStream {
    private Label[] currentEntries = [];
    private int index = 0;
    private string? nextPageCursor = ();
    private boolean hasNextPage = false;
    private final http:Client githubGraphQlClient;
    private final string authToken;
    private final string ownerName;
    private final string repositoryName;
    private final int issueNumber;

    isolated function init(http:Client githubGraphQlClient, string authToken, string ownerName, string repositoryName,
                            int issueNumber) returns Error? {
        self.githubGraphQlClient = githubGraphQlClient;
        self.authToken = authToken;
        self.ownerName = ownerName;
        self.repositoryName = repositoryName;
        self.issueNumber = issueNumber;
        self.currentEntries = check self.fetchLabels();
    }

    public isolated function next() returns record {|Label value;|}|Error? {
        if self.index < self.currentEntries.length() {
            record {|Label value;|} label = {value: self.currentEntries[self.index]};
            self.index += 1;
            return label;
        }
        if self.hasNextPage {
            self.index = 0;
            self.currentEntries = check self.fetchLabels();
            record {|Label value;|} label = {value: self.currentEntries[self.index]};
            self.index += 1;
            return label;
        }
        return;
    }

    isolated function fetchLabels() returns Label[]|Error {
        int perPageCount = 100;
        LabelList response = check getLabels(self.ownerName,
                                                    self.repositoryName,
                                                    self.issueNumber,
                                                    perPageCount,
                                                    self.authToken,
                                                    self.githubGraphQlClient,
                                                    self.nextPageCursor);
        self.hasNextPage = response.pageInfo.hasNextPage;
        self.nextPageCursor = response.pageInfo.endCursor;
        return response.labels;
    }
}

class MilestoneStream {
    private Milestone[] currentEntries = [];
    private int index = 0;
    private string? nextPageCursor = ();
    private boolean hasNextPage = false;
    private final http:Client githubGraphQlClient;
    private final string authToken;
    private final string ownerName;
    private final string repositoryName;

    isolated function init(http:Client githubGraphQlClient, string authToken, string ownerName, string repositoryName)
                            returns Error? {
        self.githubGraphQlClient = githubGraphQlClient;
        self.authToken = authToken;
        self.ownerName = ownerName;
        self.repositoryName = repositoryName;
        self.currentEntries = check self.fetchMilestones();
    }

    public isolated function next() returns record {|Milestone value;|}|Error? {
        if self.index < self.currentEntries.length() {
            record {|Milestone value;|} milestone = {value: self.currentEntries[self.index]};
            self.index += 1;
            return milestone;
        }
        if self.hasNextPage {
            self.index = 0;
            self.currentEntries = check self.fetchMilestones();
            record {|Milestone value;|} milestone = {value: self.currentEntries[self.index]};
            self.index += 1;
            return milestone;
        }
        return;
    }

    isolated function fetchMilestones() returns Milestone[]|Error {
        int perPageCount = 100;
        MilestoneList response = check getMilestones(self.ownerName,
                                                            self.repositoryName,
                                                            perPageCount,
                                                            self.authToken,
                                                            self.githubGraphQlClient,
                                                            self.nextPageCursor);
        self.hasNextPage = response.pageInfo.hasNextPage;
        self.nextPageCursor = response.pageInfo.endCursor;
        return response.milestones;
    }
}

class PullRequestStream {
    private PullRequest[] currentEntries = [];
    private int index = 0;
    private string? nextPageCursor = ();
    private boolean hasNextPage = false;
    private final http:Client githubGraphQlClient;
    private final string authToken;
    private final string ownerName;
    private final string repositoryName;
    private final PullRequestState state;

    isolated function init(http:Client githubGraphQlClient, string authToken, string ownerName, string repositoryName,
                            PullRequestState state) returns Error? {
        self.githubGraphQlClient = githubGraphQlClient;
        self.authToken = authToken;
        self.ownerName = ownerName;
        self.repositoryName = repositoryName;
        self.state = state;
        self.currentEntries = check self.fetchPullRequests();
    }

    public isolated function next() returns record {|PullRequest value;|}|Error? {
        if self.index < self.currentEntries.length() {
            record {|PullRequest value;|} pullRequest = {value: self.currentEntries[self.index]};
            self.index += 1;
            return pullRequest;
        }
        if self.hasNextPage {
            self.index = 0;
            self.currentEntries = check self.fetchPullRequests();
            record {|PullRequest value;|} pullRequest = {value: self.currentEntries[self.index]};
            self.index += 1;
            return pullRequest;
        }
        return;
    }

    isolated function fetchPullRequests() returns PullRequest[]|Error {
        int perPageCount = 100;
        PullRequestList response = check getPullRequests(self.ownerName,
                                                            self.repositoryName,
                                                            self.state,
                                                            perPageCount,
                                                            self.authToken,
                                                            self.githubGraphQlClient,
                                                            self.nextPageCursor);
        self.hasNextPage = response.pageInfo.hasNextPage;
        self.nextPageCursor = response.pageInfo.endCursor;
        return response.pullRequests;
    }
}

class OrganizationMemberStream {
    private User[] currentEntries = [];
    private int index = 0;
    private string? nextPageCursor = ();
    private boolean hasNextPage = false;
    private final http:Client githubGraphQlClient;
    private final string authToken;
    private final string organizationName;

    isolated function init(http:Client githubGraphQlClient, string authToken, string organizationName)
                            returns Error? {
        self.githubGraphQlClient = githubGraphQlClient;
        self.authToken = authToken;
        self.organizationName = organizationName;
        self.currentEntries = check self.fetchOrganizationMembers();
    }

    public isolated function next() returns record {|User value;|}|Error? {
        if self.index < self.currentEntries.length() {
            record {|User value;|} organizationMember = {value: self.currentEntries[self.index]};
            self.index += 1;
            return organizationMember;
        }
        if self.hasNextPage {
            self.index = 0;
            self.currentEntries = check self.fetchOrganizationMembers();
            record {|User value;|} organizationMember = {value: self.currentEntries[self.index]};
            self.index += 1;
            return organizationMember;
        }
        return;
    }

    isolated function fetchOrganizationMembers() returns User[]|Error {
        int perPageCount = 100;
        UserList response = check getOrganizationMembers(self.organizationName,
                                                            perPageCount,
                                                            self.authToken,
                                                            self.githubGraphQlClient,
                                                            self.nextPageCursor);
        self.hasNextPage = response.pageInfo.hasNextPage;
        self.nextPageCursor = response.pageInfo.endCursor;
        return response.users;
    }
}

class RepositoryStream {
    private Repository[] currentEntries = [];
    private int index = 0;
    private string? nextPageCursor = ();
    private boolean hasNextPage = false;
    private final http:Client githubGraphQlClient;
    private final string authToken;
    private final string? owner;
    private final boolean isOrganization;

    isolated function init(http:Client githubGraphQlClient, string authToken, string? owner, boolean isOrganization)
                            returns Error? {
        self.githubGraphQlClient = githubGraphQlClient;
        self.authToken = authToken;
        self.owner = owner;
        self.isOrganization = isOrganization;
        self.currentEntries = check self.fetchRepositories();
    }

    public isolated function next() returns record {|Repository value;|}|Error? {
        if self.index < self.currentEntries.length() {
            record {|Repository value;|} repository = {value: self.currentEntries[self.index]};
            self.index += 1;
            return repository;
        }
        if self.hasNextPage {
            self.index = 0;
            self.currentEntries = check self.fetchRepositories();
            record {|Repository value;|} repository = {value: self.currentEntries[self.index]};
            self.index += 1;
            return repository;
        }
        return;
    }

    isolated function fetchRepositories() returns Repository[]|Error {
        int perPageCount = 100;
        RepositoryList response = check getRepositoryList(perPageCount, self.authToken, self.githubGraphQlClient,
                self.isOrganization, self.owner, self.nextPageCursor);
        self.hasNextPage = response.pageInfo.hasNextPage;
        self.nextPageCursor = response.pageInfo.endCursor;
        return response.repositories;
    }
}

class ProjectStream {
    private Project[] currentEntries = [];
    private int index = 0;
    private string? nextPageCursor = ();
    private boolean hasNextPage = false;
    private final http:Client githubGraphQlClient;
    private final string authToken;
    private final string owner;
    private final OwnerType ownerType;
    private final string? repository;
    private final ProjectState? state;

    isolated function init(http:Client githubGraphQlClient, string authToken, string owner, OwnerType ownerType,
                            string? repository, ProjectState? state) returns Error? {
        self.githubGraphQlClient = githubGraphQlClient;
        self.authToken = authToken;
        self.owner = owner;
        self.ownerType = ownerType;
        self.repository = repository;
        self.state = state;
        self.currentEntries = check self.fetchProjects();
    }

    public isolated function next() returns record {|Project value;|}|Error? {
        if self.index < self.currentEntries.length() {
            record {|Project value;|} project = {value: self.currentEntries[self.index]};
            self.index += 1;
            return project;
        }
        if self.hasNextPage {
            self.index = 0;
            self.currentEntries = check self.fetchProjects();
            record {|Project value;|} project = {value: self.currentEntries[self.index]};
            self.index += 1;
            return project;
        }
        return;
    }

    isolated function fetchProjects() returns Project[]|Error {
        int perPageCount = 100;
        string? repository = self.repository;
        ProjectList response;
        if repository is string {
            response = check getRepositoryProjectList(self.owner, repository, self.state, perPageCount, self.authToken,
                    self.githubGraphQlClient, self.nextPageCursor);
        } else {
            if self.ownerType === GITHUB_USER {
                response = check getUserProjectList(self.owner, perPageCount, self.authToken, self.githubGraphQlClient,
                        self.nextPageCursor);
            } else {
                response = check getOrganizationProjectList(self.owner, self.state, perPageCount, self.authToken,
                        self.githubGraphQlClient, self.nextPageCursor);
            }
        }
        self.hasNextPage = response.pageInfo.hasNextPage;
        self.nextPageCursor = response.pageInfo.endCursor;
        return response.projects;
    }
}

class OrganizationStream {
    private Organization[] currentEntries = [];
    private int index = 0;
    private string? nextPageCursor = ();
    private boolean hasNextPage = false;
    private final http:Client githubGraphQlClient;
    private final string authToken;
    private final string owner;
    private final OwnerType ownerType;

    isolated function init(http:Client githubGraphQlClient, string authToken, string owner, OwnerType ownerType)
                            returns Error? {
        self.githubGraphQlClient = githubGraphQlClient;
        self.authToken = authToken;
        self.owner = owner;
        self.ownerType = ownerType;
        self.currentEntries = check self.fetchOrganizations();
    }

    public isolated function next() returns record {|Organization value;|}|Error? {
        if self.index < self.currentEntries.length() {
            record {|Organization value;|} organization = {value: self.currentEntries[self.index]};
            self.index += 1;
            return organization;
        }
        if self.hasNextPage {
            self.index = 0;
            self.currentEntries = check self.fetchOrganizations();
            record {|Organization value;|} organization = {value: self.currentEntries[self.index]};
            self.index += 1;
            return organization;
        }
        return;
    }

    isolated function fetchOrganizations() returns Organization[]|Error {
        int perPageCount = 100;
        if self.ownerType is GITHUB_USER {
            OrganizationList response = check getUserOrganizationList(self.owner, perPageCount, self.authToken,
                    self.githubGraphQlClient, self.nextPageCursor);
            self.hasNextPage = response.pageInfo.hasNextPage;
            self.nextPageCursor = response.pageInfo.endCursor;
            return response.organizations;
        } else {
            Organization organization = check getOrganization(self.owner, self.authToken, self.githubGraphQlClient);
            return [organization];
        }
    }
}

class IssueStream {
    private Issue[] currentEntries = [];
    private int index = 0;
    private string? nextPageCursor = ();
    private boolean hasNextPage = false;
    private final http:Client githubGraphQlClient;
    private final string authToken;
    private final string owner;
    private final string repository;
    private final IssueFilters issueFilters;

    isolated function init(http:Client githubGraphQlClient, string authToken, string owner,
                            string repository, IssueFilters issueFilters) returns Error? {
        self.githubGraphQlClient = githubGraphQlClient;
        self.authToken = authToken;
        self.owner = owner;
        self.repository = repository;
        self.issueFilters = issueFilters;
        self.currentEntries = check self.fetchIssues();
    }

    public isolated function next() returns record {|Issue value;|}|Error? {
        if self.index < self.currentEntries.length() {
            record {|Issue value;|} issue = {value: self.currentEntries[self.index]};
            self.index += 1;
            return issue;
        }
        if self.hasNextPage {
            self.index = 0;
            self.currentEntries = check self.fetchIssues();
            record {|Issue value;|} issue = {value: self.currentEntries[self.index]};
            self.index += 1;
            return issue;
        }
        return;
    }

    isolated function fetchIssues() returns Issue[]|Error {
        int perPageCount = 100;
        IssueList response = check getIssues(self.owner, self.repository, perPageCount, self.authToken,
                self.githubGraphQlClient, self.nextPageCursor, self.issueFilters);
        self.hasNextPage = response.pageInfo.hasNextPage;
        self.nextPageCursor = response.pageInfo.endCursor;
        return response.issues;
    }
}
