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

final string CREATE_REPOSITORY = "mutation($createRepositoryInput: CreateRepositoryInput!) {\n"+
                                 "  createRepository(input:$createRepositoryInput){ \n"+
                                 "      clientMutationId \n"+
                                 "  }\n"+
                                 "}";

final string UPDATE_REPOSITORY = "mutation($updateRepositoryInput: UpdateRepositoryInput!) {\n"+
                                 "  updateRepository(input:$updateRepositoryInput){ \n"+
                                 "      clientMutationId \n"+
                                 "  }\n"+
                                 "}";

final string CREATE_ISSUE = "mutation($createIssueInput: CreateIssueInput!){\n"+
                            "   createIssue(input: $createIssueInput){\n"+
                            "       issue{\n"+
                                        ISSUE_FIELDS+
                            "       }\n"+
                            "   }\n"+
                            "}";

final string UPDATE_ISSUE = "mutation($updateIssueInput: UpdateIssueInput!){\n"+
                            "   updateIssue(input: $updateIssueInput){\n"+
                            "       clientMutationId,\n"+
                            "       issue{\n"+
                                        ISSUE_FIELDS+
                            "       }\n"+
                            "   }\n"+
                            "}";

final string ADD_COMMENT = "mutation($addCommentInput: AddCommentInput!){\n"+
                           "    addComment(input: $addCommentInput){\n"+
                           "        clientMutationId,\n"+
                           "        commentEdge{\n"+
                           "            node{\n"+
                                            ISSUE_COMMENT_FIELDS+
                           "            }\n"+
                           "        }\n"+
                           "    }\n"+
                           "}";

final string UPDATE_ISSUE_COMMENT = "mutation($updateIssueCommentInput: UpdateIssueCommentInput!){\n"+
                           "    updateIssueComment(input: $updateIssueCommentInput){\n"+
                           "        clientMutationId\n"+
                           "    }\n"+
                           "}";

final string DELETE_ISSUE_COMMENT = "mutation($deleteIssueCommentInput: DeleteIssueCommentInput!){\n"+
                           "    deleteIssueComment(input: $deleteIssueCommentInput){\n"+
                           "        clientMutationId\n"+
                           "    }\n"+
                           "}";

final string CREATE_LABEL = "mutation($createLabelInput: CreateLabelInput!){\n"+
                           "    createLabel(input: $createLabelInput){\n"+
                           "        clientMutationId\n"+
                           "    }\n"+
                           "}";

final string UPDATE_LABEL = "mutation($updateLabelInput: UpdateLabelInput!){\n"+
                           "    createLabel(input: $updateLabelInput){\n"+
                           "        clientMutationId\n"+
                           "    }\n"+
                           "}";

final string DELETE_LABEL = "mutation($deleteLabelInput: DeleteLabelInput!){\n"+
                           "    createLabel(input: $deleteLabelInput){\n"+
                           "        clientMutationId\n"+
                           "    }\n"+
                           "}";

final string ADD_LABELS_TO_LABELABLE = "mutation($addLabelsToLabelableInput: AddLabelsToLabelableInput!){\n"+
                                       "    addLabelsToLabelable(input: $addLabelsToLabelableInput){\n"+
                                       "        labelable{\n"+
                                       "            labels(first:100){\n"+
                                       "                nodes{\n"+
                                                            LABEL_FIELDS+
                                       "                }\n"+
                                                        PAGE_INFO_AND_TOTAL_COUNT+
                                       "            }\n"+
                                       "        },\n"+
                                       "        clientMutationId\n"+
                                       "    }"+
                                       "}";


final string REMOVE_LABELS_TO_LABELABLE = "mutation($removeLabelsFromLabelableInput: RemoveLabelsFromLabelableInput!){\n"+
                                       "    removeLabelsFromLabelable(input: $removeLabelsFromLabelableInput){\n"+
                                       "        clientMutationId\n"+
                                       "    }"+
                                       "}";
final string CREATE_PULL_REQUEST = "mutation($createPullRequestInput: CreatePullRequestInput!){\n"+
                                   "    createPullRequest(input: $createPullRequestInput){\n"+
                                   "        clientMutationId,\n"+
                                   "        pullRequest{\n"+
                                                PULL_REQUEST_FIELDS+
                                   "        }\n"+
                                   "    }\n"+
                                   "}";

final string UPDATE_PULL_REQUEST = "mutation($updatePullRequestInput: UpdatePullRequestInput!){\n"+
                                   "    updatePullRequest(input: $updatePullRequestInput){\n"+
                                   "        clientMutationId,\n"+
                                   "        pullRequest{\n"+
                                                PULL_REQUEST_FIELDS+
                                   "        }\n"+
                                   "    }\n"+
                                   "}";

final string ADD_PULL_REQUEST_REVIEW = "mutation($addPullRequestReview: AddPullRequestReviewInput!){\n"+
                                   "    addPullRequestReview(input: $addPullRequestReview){\n"+
                                   "        clientMutationId,\n"+
                                   "            pullRequestReview{\n"+
                                                    PULL_REQUEST_REVIEW_FIELDS+
                                   "            }\n"+
                                   "    }\n"+
                                   "}";

final string UPDATE_PULL_REQUEST_REVIEW = "mutation($updatePullRequestReview: UpdatePullRequestReviewInput!){\n"+
                                   "    updatePullRequestReview(input: $updatePullRequestReview){\n"+
                                   "        clientMutationId\n"+
                                   "    }\n"+
                                   "}";

final string DELETE_PULL_REQUEST_REVIEW = "mutation($deletePullRequestReview: DeletePullRequestReviewInput!){\n"+
                                   "    deletePullRequestReview(input: $deletePullRequestReview){\n"+
                                   "        clientMutationId\n"+
                                   "    }\n"+
                                   "}";

final string CREATE_PROJECT = "mutation($createProjectInput: CreateProjectInput!){\n"+
                                   "    createProject(input: $createProjectInput){\n"+
                                   "        clientMutationId,\n"+
                                   "        project{\n"+
                                                PROJECT_FIELDS+
                                   "        }\n"+
                                   "    }\n"+
                                   "}";

final string UPDATE_PROJECT = "mutation($updateProjectInput: UpdateProjectInput!){\n"+
                                   "    updateProject(input: $updateProjectInput){\n"+
                                   "        clientMutationId,\n"+
                                   "        project{\n"+
                                               PROJECT_FIELDS+
                                   "        }\n"+
                                   "    }\n"+
                                   "}";

final string DELETE_PROJECT = "mutation($deleteProjectInput: DeleteProjectInput!){\n"+
                                   "    deleteProject(input: $deleteProjectInput){\n"+
                                   "        clientMutationId\n"+
                                   "    }\n"+
                                   "}";
