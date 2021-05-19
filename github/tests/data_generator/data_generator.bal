import ballerina/log;
import ballerina/io;
import ballerina/os;
import ballerinax/github;

github:Configuration gitHubConfig = {
    accessToken: os:getEnv("githubPATtoken")
};

// Connector configuration
github:Client githubClient = check new (gitHubConfig);
string connecterVersion = "0.99.14";

// Variables
string pr1Id = "1";
int pr1Number = 1;
string pr2Id = "1";
int pr2Number = 1;
string pr3Id = "1";
int pr3Number = 1;
string createdIssueId = "";
int createdIssueNumber = -1;

// Configurations
string githubUserName = "SkNuwanTissera";

string githubRepo1 = "HexSpeak";
string githubRepo2 = "Automated_Attendance";
string githubRepo3 = "AwruduKemaMLClassifier";

string testOrganizationName = "DataGeneratorTest";

string sampleRepo1 = "github-data-generator-1";

int issueNumber = 6;
int perPageCount = 3;
int issueForLabelExtraction = 45;

// Constants
string COMMA = ",";
string SQUARE_BRACKET_LEFT = "[";
string SQUARE_BRACKET_RIGHT = "]";

string rootPath = "./data/";

string userDataJson = rootPath + "User_data.json";
string issueDataJson = rootPath + "Issue_data.json";
string issueListDataJson = rootPath + "IssueList_data.json";
string actorDataJson = rootPath + "Actor_data.json";
string repoDataJson = rootPath + "Repository_data.json";
string repoOwnerDataJson = rootPath + "RepositoryOwner_data.json";
string repoListDataJson = rootPath + "RepositoryList_data.json";
string collaboratorListDataJson = rootPath + "CollaboratorList_data.json";
string branchListDataJson = rootPath + "BranchList_data.json";
string pageInfoDataJson = rootPath + "PageInfo_data.json";
string issueCommentListDataJson = rootPath + "IssueCommentList_data.json";
string issueCommentDataJson = rootPath + "IssueComment_data.json";
string pullRequestDataJson = rootPath + "PullRequest_data.json";
string pullRequestListDataJson = rootPath + "PullRequestList_data.json";
string pullRequestReviewDataJson = rootPath + "PullRequestReview_data.json";
string pullRequestReviewListDataJson = rootPath + "PullRequestReviewList_data.json";
string createPullRequestDataJson = rootPath + "CreatePullRequestInput_data.json";
string labelListDataJson = rootPath + "LabelList_data.json";
string labelDataJson = rootPath + "Label_data.json";
string milestoneListJson = rootPath + "MilestoneList_data.json";
string milestoneJson = rootPath + "Milestone_data.json";
string projectListJson = rootPath + "ProjectList_data.json";
string projectJson = rootPath + "Project_data.json";
string organizationListJson = rootPath + "OrganizationList_data.json";
string organizationJson = rootPath + "Organization_data.json";
string userListJson = rootPath + "UserList_data.json";
string addLabelsToLabelableInputDataJson = rootPath + "AddLabelsToLabelableInput_data.json";
string removeLabelsToLabelableInputDataJson = rootPath + "RemoveLabelsFromLabelableInput_data.json";
string updateRepoInputJson = rootPath + "UpdateRepositoryInput_data.json";
string createIssueInputsJson = rootPath + "CreateIssueInput_data.json";
string updateIssueInputsJson = rootPath + "UpdateIssueInput_data.json";
string addCommentInputsJson = rootPath + "AddCommentInput_data.json";
string updateCommentInputsJson = rootPath + "UpdateIssueCommentInput_data.json";
string deleteCommentInputsJson = rootPath + "DeleteIssueCommentInput_data.json";
string createLabelInputsJson = rootPath + "CreateLabelInput_data.json";
string updateLabelInputsJson = rootPath + "UpdateLabelInput_data.json";
string deleteLabelInputsJson = rootPath + "DeleteLabelInput_data.json";
string arrayOfUpdatePullRequestInputsJson = rootPath + "UpdatePullRequestInput_data.json";
string createProjectInputsJson = rootPath + "CreateProjectInput_data.json";
string updateProjectInputsJson = rootPath + "UpdateProjectInput_data.json";
string deleteProjectInputsJson = rootPath + "DeleteProjectInput_data.json";
string addPullRequestReviewInputJson = rootPath + "AddPullRequestReviewInput_data.json";
string updatePullRequestReviewInputJson = rootPath + "UpdatePullRequestReviewInput_data.json";
string deletePullRequestReviewInputJson = rootPath + "DeletePullRequestReviewInput_data.json";

public function main() returns error? {
    _ = check createIssue(); 
    _ = check generateUserData(); 
    _ = check generateIssueData(); 
    _ = check generateRepositoryData(); 
    _ = check generateRepositoryListData(); 
    _ = check generateCollaboratorListData(); 
    _ = check generateBranchListData(); 
    _ = check generateIssueListData(); 
    _ = check generateIssueCommentData(); 
    _ = check createPullRequests(); 
    _ = check createPullRequestReview(); 
    _ = check generatePullRequestListData();
    _ = check generatePullRequestReviewListData();
    _ = check generateMilestoneListData();
    _ = check generateProjectListData();
    _ = check generateOrganizationListData();
    _ = check generateInputData();
    _ = check closePRs();

}

public function generateInputData() returns error?{

    log:printInfo("SampleDataGenerator -> (TASK) Generating Input Record types");

    log:printInfo("SampleDataGenerator -> LabelListData, LabelData, AddLabelsToLabelableInputData");

    github:Label labelIdResponse = checkpanic githubClient->getRepositoryLabel(githubUserName, sampleRepo1, "bug");
    github:AddLabelsToLabelableInput addLabelInput = {
        labelableId: createdIssueId,
        labelIds: [labelIdResponse.id],
        clientMutationId : "clientMutationId"
    };
    string arrayOfLabelInput = SQUARE_BRACKET_LEFT + addLabelInput.toJsonString() + COMMA 
                                + addLabelInput.toJsonString() + COMMA 
                                + addLabelInput.toJsonString() + SQUARE_BRACKET_RIGHT;    

    github:LabelList labelListResponse = check githubClient->getLabelsInIssue(githubUserName, sampleRepo1, issueForLabelExtraction, perPageCount);
    string labelList = labelListResponse.toJsonString();

    string label1 = labelListResponse?.nodes[0].toJsonString();
    string label2 = labelListResponse?.nodes[1].toJsonString();
    string label3 = labelListResponse?.nodes[2].toJsonString();

    string arrayOfLabelList = SQUARE_BRACKET_LEFT + labelList + COMMA + labelList + COMMA + 
                                        labelList + SQUARE_BRACKET_RIGHT;
    string arrayOfLabels = SQUARE_BRACKET_LEFT + label1 + COMMA + label2 + COMMA + 
                                        label3 + SQUARE_BRACKET_RIGHT;
                                        
    string preparedJsonLabelList = "{"+"\"ballerinax/github:"+connecterVersion+":LabelList\""+":"+arrayOfLabelList+"}";
    string preparedJsonLabels = "{"+"\"ballerinax/github:"+connecterVersion+":Label\""+":"+arrayOfLabels+"}";
    string preparedJsonAddLabelsToLabelableInput = "{"+"\"ballerinax/github:"+connecterVersion+":AddLabelsToLabelableInput\""+":"+arrayOfLabelInput+"}";
    string preparedJsonRemoveLabelsFromLabelableInput = "{"+"\"ballerinax/github:"+connecterVersion+":AddLabelsToLabelableInput\""+":"+arrayOfLabelInput+"}";

    check io:fileWriteJson(labelListDataJson, check preparedJsonLabelList.cloneWithType(json));
    check io:fileWriteJson(labelDataJson, check preparedJsonLabels.cloneWithType(json));
    check io:fileWriteJson(addLabelsToLabelableInputDataJson, check preparedJsonAddLabelsToLabelableInput.cloneWithType(json));
    check io:fileWriteJson(removeLabelsToLabelableInputDataJson, check preparedJsonRemoveLabelsFromLabelableInput.cloneWithType(json));

    log:printInfo("SampleDataGenerator -> UpdateRepositoryInputData");

    github:UpdateRepositoryInput updateRepositoryInput1 = {
        clientMutationId : "clientMutationId1",
        description : "description1",
        hasIssuesEnabled : true,
        hasProjectsEnabled : true,
        hasWikiEnabled : true,
        homePageUrl : "https://github.com/TestRepository1",
        name : "Test Repository1",
        repositoryId : "1",
        template : true
    };

    github:UpdateRepositoryInput updateRepositoryInput2 = {
        clientMutationId : "clientMutationId2",
        description : "description2",
        hasIssuesEnabled : true,
        hasProjectsEnabled : true,
        hasWikiEnabled : true,
        homePageUrl : "https://github.com/TestRepository2",
        name : "Test Repository2",
        repositoryId : "2",
        template : true
    };

    github:UpdateRepositoryInput updateRepositoryInput3 = {
        clientMutationId : "clientMutationId3",
        description : "description3",
        hasIssuesEnabled : true,
        hasProjectsEnabled : true,
        hasWikiEnabled : true,
        homePageUrl : "https://github.com/TestRepository3",
        name : "Test Repository3",
        repositoryId : "3",
        template : true
    };

    string updateRepoInput1 = updateRepositoryInput1.toJsonString();
    string updateRepoInput2 = updateRepositoryInput2.toJsonString();
    string updateRepoInput3 = updateRepositoryInput3.toJsonString();

    string arrayOfUpdateRepoInputs = SQUARE_BRACKET_LEFT + updateRepoInput1 + COMMA + updateRepoInput2 + COMMA + updateRepoInput3 + SQUARE_BRACKET_RIGHT;
    string preparedJsonUpdateRepoInputs = "{"+"\"ballerinax/github:"+connecterVersion+":UpdateRepositoryInput\""+":"+arrayOfUpdateRepoInputs+"}";
                            
    check io:fileWriteJson(updateRepoInputJson, check preparedJsonUpdateRepoInputs.cloneWithType(json));

    log:printInfo("SampleDataGenerator -> CreateIssueInputData");

    github:CreateIssueInput createIssueInput1 = {
        repositoryId :"1",
        title : "Issue in Test Repo 1",
        body : "This issue is a blocker",
        assigneeIds : ["Nuwan", "Kanishka", "Roland"],
        milestoneId : "1",
        labelIds : ["abc111"],
        projectIds : ["1"],
        issueTemplate : "https://github.com/stevemao/github-issue-templates/blob/master/bugs-only/ISSUE_TEMPLATE.md",
        clientMutationId : "clientMutationId1"
    };

    github:CreateIssueInput createIssueInput2 = {
        repositoryId :"2",
        title : "Issue in Test Repo 2",
        body : "This issue is a blocker",
        assigneeIds : ["Nuwan", "Kanishka", "Roland"],
        milestoneId : "2",
        labelIds : ["abc222"],
        projectIds : ["2"],
        issueTemplate : "https://github.com/stevemao/github-issue-templates/blob/master/bugs-only/ISSUE_TEMPLATE.md",
        clientMutationId : "clientMutationId2"
    };

    github:CreateIssueInput createIssueInput3 = {
        repositoryId :"3",
        title : "Issue in Test Repo 3",
        body : "This issue is a blocker",
        assigneeIds : ["Nuwan", "Kanishka", "Roland"],
        milestoneId : "3",
        labelIds : ["abc333"],
        projectIds : ["3"],
        issueTemplate : "https://github.com/stevemao/github-issue-templates/blob/master/bugs-only/ISSUE_TEMPLATE.md",
        clientMutationId : "clientMutationId3"
    };

    string arrayOfcreateIssueInputs = SQUARE_BRACKET_LEFT + createIssueInput1.toJsonString() + COMMA 
                                        + createIssueInput1.toJsonString() + COMMA + createIssueInput1.toJsonString() 
                                        + SQUARE_BRACKET_RIGHT;
    string preparedJsonCreateIssueInputs = "{"+"\"ballerinax/github:"+connecterVersion+":CreateIssueInput\""+":"+arrayOfUpdateRepoInputs+"}";  
    check io:fileWriteJson(createIssueInputsJson, check preparedJsonCreateIssueInputs.cloneWithType(json));

    log:printInfo("SampleDataGenerator -> updateIssueInputData");
    github:UpdateIssueInput updateIssueInput1 = {
        id :"1",
        title : "Issue in Test Repo 1",
        body : "This issue is a blocker",
        assigneeIds : ["Nuwan", "Kanishka", "Roland"],
        milestoneId : "1",
        labelIds : ["abc111"],
        projectIds : ["1"],
        state : github:ISSUE_OPEN,
        clientMutationId : "clientMutationId1"
    };

    github:UpdateIssueInput updateIssueInput2 = {
        id :"2",
        title : "Issue in Test Repo 2",
        body : "This issue is a blocker",
        assigneeIds : ["Nuwan", "Kanishka", "Roland"],
        milestoneId : "2",
        labelIds : ["abc222"],
        projectIds : ["2"],
        state : github:ISSUE_OPEN,
        clientMutationId : "clientMutationId2"
    };

    github:UpdateIssueInput updateIssueInput3 = {
        id :"3",
        title : "Issue in Test Repo 3",
        body : "This issue is a blocker",
        assigneeIds : ["Nuwan", "Kanishka", "Roland"],
        milestoneId : "3",
        labelIds : ["abc333"],
        projectIds : ["3"],
        state : github:ISSUE_OPEN,
        clientMutationId : "clientMutationId3"
    };

    string arrayOfUpdateIssueInputs = SQUARE_BRACKET_LEFT + updateIssueInput1.toJsonString() + COMMA 
                                        + updateIssueInput2.toJsonString() + COMMA + updateIssueInput3.toJsonString() 
                                        + SQUARE_BRACKET_RIGHT;
    string preparedJsonUpdateIssueInputs = "{"+"\"ballerinax/github:"+connecterVersion+":UpdateIssueInput\""+":"+arrayOfUpdateIssueInputs+"}";
    check io:fileWriteJson(updateIssueInputsJson, check preparedJsonUpdateIssueInputs.cloneWithType(json));

    log:printInfo("SampleDataGenerator -> AddCommentInputData");
    github:AddCommentInput addCommentInput1 = {
        subjectId : "Comment Input1",
        body : "This contains comment input",
        clientMutationId : "clientMutationId1"
    };
    github:AddCommentInput addCommentInput2 = {
        subjectId : "Comment Input2",
        body : "This contains comment input",
        clientMutationId : "clientMutationId2"
    };
    github:AddCommentInput addCommentInput3 = {
        subjectId : "Comment Input3",
        body : "This contains comment input",
        clientMutationId : "clientMutationId3"
    };

    string arrayOfAddCommentInputs = SQUARE_BRACKET_LEFT + addCommentInput1.toJsonString() + COMMA 
                                        + addCommentInput2.toJsonString() + COMMA + addCommentInput3.toJsonString() 
                                        + SQUARE_BRACKET_RIGHT;
    string preparedJsonAddCommentInputs = "{"+"\"ballerinax/github:"+connecterVersion+":AddCommentInput\""+":"+arrayOfAddCommentInputs+"}";
    check io:fileWriteJson(addCommentInputsJson, check preparedJsonAddCommentInputs.cloneWithType(json));


    log:printInfo("SampleDataGenerator -> UpdateIssueCommentInputData");
    github:UpdateIssueCommentInput updateIssueCommentInput1 = {
        id : "1",
        body : "This contains Updated comment input",
        clientMutationId : "clientMutationId1"
    };
    github:UpdateIssueCommentInput updateIssueCommentInput2 = {
        id : "2",
        body : "This contains Updated comment input",
        clientMutationId : "clientMutationId2"
    };
    github:UpdateIssueCommentInput updateIssueCommentInput3 = {
        id : "3",
        body : "This contains Updated comment input",
        clientMutationId : "clientMutationId3"
    };

    string arrayOfUpdateIssueCommentInputs = SQUARE_BRACKET_LEFT + updateIssueCommentInput1.toJsonString() + COMMA 
                                        + updateIssueCommentInput2.toJsonString() + COMMA + updateIssueCommentInput3.toJsonString() 
                                        + SQUARE_BRACKET_RIGHT;
    string preparedJsonUpdateIssueCommentInputs = "{"+"\"ballerinax/github:"+connecterVersion+":UpdateIssueCommentInput\""+":"+arrayOfUpdateIssueCommentInputs+"}";
    check io:fileWriteJson(updateCommentInputsJson, check preparedJsonUpdateIssueCommentInputs.cloneWithType(json));


    log:printInfo("SampleDataGenerator -> DeleteIssueCommentInputData");
    github:DeleteIssueCommentInput deleteIssueCommentInput1 = {
        id : "1",
        clientMutationId : "clientMutationId1"
    };
    github:DeleteIssueCommentInput deleteIssueCommentInput2 = {
        id : "2",
        clientMutationId : "clientMutationId2"
    };
    github:DeleteIssueCommentInput deleteIssueCommentInput3 = {
        id : "3",
        clientMutationId : "clientMutationId3"
    };

    string arrayOfDeleteIssueCommentInputs = SQUARE_BRACKET_LEFT + deleteIssueCommentInput1.toJsonString() + COMMA 
                                        + deleteIssueCommentInput2.toJsonString() + COMMA + deleteIssueCommentInput3.toJsonString() 
                                        + SQUARE_BRACKET_RIGHT;
    string preparedJsonDeleteIssueCommentInput = "{"+"\"ballerinax/github:"+connecterVersion+":DeleteIssueCommentInput\""+":"+arrayOfDeleteIssueCommentInputs+"}";
    check io:fileWriteJson(deleteCommentInputsJson, check preparedJsonDeleteIssueCommentInput.cloneWithType(json));


    log:printInfo("SampleDataGenerator -> CreateLabelInputData");
    github:CreateLabelInput createLabelInput1 = {
        name : "bug",
        description : "bug description",
        color : "red",
        repositoryId : "1",
        clientMutationId : "clientMutationId1"
    };
    github:CreateLabelInput createLabelInput2 = {
        name : "enhancement",
        description : "enhancement description",
        color : "blue",
        repositoryId : "2",
        clientMutationId : "clientMutationId2"
    };
    github:CreateLabelInput createLabelInput3 = {
        name : "documentation",
        description : "documentation description",
        color : "green",
        repositoryId : "3",
        clientMutationId : "clientMutationId3"
    };

    string arrayOfCreateLabelInputs = SQUARE_BRACKET_LEFT + createLabelInput1.toJsonString() + COMMA 
                                        + createLabelInput2.toJsonString() + COMMA + createLabelInput3.toJsonString() 
                                        + SQUARE_BRACKET_RIGHT;
    string preparedJsonCreateLabelInputs = "{"+"\"ballerinax/github:"+connecterVersion+":CreateLabelInput\""+":"+arrayOfCreateLabelInputs+"}";
    check io:fileWriteJson(createLabelInputsJson, check preparedJsonCreateLabelInputs.cloneWithType(json));

    log:printInfo("SampleDataGenerator -> UpdateLabelInputData");
    github:UpdateLabelInput updateLabelInput1 = {
        id : "1",
        name : "bug",
        description : "bug description",
        color : "red",
        clientMutationId : "clientMutationId1"
    };
    github:UpdateLabelInput updateLabelInput2 = {
        id : "2",
        name : "enhancement",
        description : "enhancement description",
        color : "blue",
        clientMutationId : "clientMutationId2"
    };
    github:UpdateLabelInput updateLabelInput3 = {
        id : "3",
        name : "documentation",
        description : "documentation description",
        color : "green",
        clientMutationId : "clientMutationId3"
    };

    string arrayOfUpdateLabelInputs = SQUARE_BRACKET_LEFT + updateLabelInput1.toJsonString() + COMMA 
                                        + updateLabelInput2.toJsonString() + COMMA + updateLabelInput3.toJsonString() 
                                        + SQUARE_BRACKET_RIGHT;
    string preparedJsonUpdateLabelInputs = "{"+"\"ballerinax/github:"+connecterVersion+":UpdateLabelInput\""+":"+arrayOfUpdateLabelInputs+"}";
    check io:fileWriteJson(updateLabelInputsJson, check preparedJsonUpdateLabelInputs.cloneWithType(json));

    log:printInfo("SampleDataGenerator -> DeleteLabelInputData");
    github:DeleteLabelInput deleteLabelInput1 = {
        id : "1",
        clientMutationId : "clientMutationId1"
    };
    github:DeleteLabelInput deleteLabelInput2 = {
        id : "2",
        clientMutationId : "clientMutationId2"
    };
    github:DeleteLabelInput deleteLabelInput3 = {
        id : "3",
        clientMutationId : "clientMutationId3"
    };

    string arrayOfDeleteLabelInputs = SQUARE_BRACKET_LEFT + deleteLabelInput1.toJsonString() + COMMA 
                                        + deleteLabelInput2.toJsonString() + COMMA + deleteLabelInput3.toJsonString() 
                                        + SQUARE_BRACKET_RIGHT;
    string preparedJsonDeleteLabelInputs = "{"+"\"ballerinax/github:"+connecterVersion+":DeleteLabelInput\""+":"+arrayOfDeleteLabelInputs+"}";
    check io:fileWriteJson(deleteLabelInputsJson, check preparedJsonDeleteLabelInputs.cloneWithType(json));

    log:printInfo("SampleDataGenerator -> UpdatePullRequestInputData");
    github:UpdatePullRequestInput updatePullRequestInput1 = {
       pullRequestId : "1",
       state : github:PULL_REQUEST_OPEN,
       assigneeIds : ["1","2"],
       title: "Update Test PR created from Ballerina GitHub Data Generator",
       baseRefName: "main",
       body: "This is some dummy content for PR body",
       maintainerCanModify : true,
       milestoneId : "1",
       labelId : "1",
       projectIds : ["12"],
       clientMutationId : "clientMutationId1"
    };

    github:UpdatePullRequestInput updatePullRequestInput2 = {
       pullRequestId : "2",
       state : github:PULL_REQUEST_OPEN,
       assigneeIds : ["1","2"],
       title: "Update Test PR created from Ballerina GitHub Data Generator2",
       baseRefName: "main",
       body: "This is some dummy content for PR body",
       maintainerCanModify : true,
       milestoneId : "2",
       labelId : "2",
       projectIds : ["22"],
       clientMutationId : "clientMutationId1"
    };

    github:UpdatePullRequestInput updatePullRequestInput3 = {
       pullRequestId : "3",
       state : github:PULL_REQUEST_OPEN,
       assigneeIds : ["1","2"],
       title: "Update Test PR created from Ballerina GitHub Data Generator3",
       baseRefName: "main",
       body: "This is some dummy content for PR body",
       maintainerCanModify : true,
       milestoneId : "3",
       labelId : "3",
       projectIds : ["33"],
       clientMutationId : "clientMutationId1"
    };

    string arrayOfUpdatePullRequestInputs = SQUARE_BRACKET_LEFT + updatePullRequestInput1.toJsonString() + COMMA 
                                        + updatePullRequestInput2.toJsonString() + COMMA + updatePullRequestInput3.toJsonString() 
                                        + SQUARE_BRACKET_RIGHT;
    string preparedJsonUpdatePullRequestInputs = "{"+"\"ballerinax/github:"+connecterVersion+":UpdatePullRequestInput\""+":"+arrayOfUpdatePullRequestInputs+"}";
    check io:fileWriteJson(arrayOfUpdatePullRequestInputsJson, check preparedJsonUpdatePullRequestInputs.cloneWithType(json));

    log:printInfo("SampleDataGenerator -> CreateProjectInputData");
    github:CreateProjectInput createProjectInput1 = {
       ownerId : "1",
       name : "TestProject",
       body: "This is some dummy content for body",
       repositoryIds : ["12"],
       clientMutationId : "clientMutationId1",
       template : github:PROJECT_TEMPLATE_AUTOMATED_KANBAN_V2
    };

    github:CreateProjectInput createProjectInput2 = {
       ownerId : "2",
       name : "TestProject2",
       body: "This is some dummy content for body",
       repositoryIds : ["122"],
       clientMutationId : "clientMutationId2",
       template : github:PROJECT_TEMPLATE_AUTOMATED_KANBAN_V2
    };

    github:CreateProjectInput createProjectInput3 = {
       ownerId : "3",
       name : "TestProject3",
       body: "This is some dummy content for body",
       repositoryIds : ["3333"],
       clientMutationId : "clientMutationId3",
       template : github:PROJECT_TEMPLATE_AUTOMATED_KANBAN_V2
    };

    string arrayOfCreateProjectInput = SQUARE_BRACKET_LEFT + createProjectInput1.toJsonString() + COMMA 
                                        + createProjectInput2.toJsonString() + COMMA + createProjectInput3.toJsonString() 
                                        + SQUARE_BRACKET_RIGHT;
    string preparedJsonCreateProjectInput = "{"+"\"ballerinax/github:"+connecterVersion+":CreateProjectInput\""+":"+arrayOfCreateProjectInput+"}";
    check io:fileWriteJson(createProjectInputsJson, check preparedJsonCreateProjectInput.cloneWithType(json));

    log:printInfo("SampleDataGenerator -> UpdateProjectInputData");
    github:UpdateProjectInput updateProjectInput1 = {
       projectId : "1",
       name : "TestProject1",
       body: "This is some dummy content for body",
       'public : true,
       updateClientMutationId : "clientMutationId1",
       state : github:PROJECT_OPEN
    };
    github:UpdateProjectInput updateProjectInput2 = {
       projectId : "2",
       name : "TestProject2",
       body: "This is some dummy content for body",
       'public : true,
       updateClientMutationId : "clientMutationId2",
       state : github:PROJECT_OPEN
    };
    github:UpdateProjectInput updateProjectInput3 = {
       projectId : "3",
       name : "TestProject3",
       body: "This is some dummy content for body",
       'public : true,
       updateClientMutationId : "clientMutationId3",
       state : github:PROJECT_OPEN
    };
    string arrayOfupdateProjectInput = SQUARE_BRACKET_LEFT + updateProjectInput1.toJsonString() + COMMA 
                                        + updateProjectInput2.toJsonString() + COMMA + updateProjectInput3.toJsonString() 
                                        + SQUARE_BRACKET_RIGHT;
    string preparedJsonupdateProjectInputt = "{"+"\"ballerinax/github:"+connecterVersion+":UpdateProjectInput\""+":"+arrayOfupdateProjectInput+"}";
    check io:fileWriteJson(updateProjectInputsJson, check preparedJsonupdateProjectInputt.cloneWithType(json));

    log:printInfo("SampleDataGenerator -> DeleteProjectInputData");
    github:DeleteProjectInput deleteProjectInput1 = {
       projectId : "1",
       clientMutationId : "clientMutationId1"
    };
    github:DeleteProjectInput deleteProjectInput2 = {
       projectId : "2",
       clientMutationId : "clientMutationId2"
    };
    github:DeleteProjectInput deleteProjectInput3 = {
       projectId : "3",
       clientMutationId : "clientMutationId3"
    };
    string arrayOfdeleteProjectInput = SQUARE_BRACKET_LEFT + deleteProjectInput1.toJsonString() + COMMA 
                                        + deleteProjectInput2.toJsonString() + COMMA + deleteProjectInput3.toJsonString() 
                                        + SQUARE_BRACKET_RIGHT;
    string preparedJsondeleteProjectInput = "{"+"\"ballerinax/github:"+connecterVersion+":DeleteProjectInput\""+":"+arrayOfdeleteProjectInput+"}";
    check io:fileWriteJson(deleteProjectInputsJson, check preparedJsondeleteProjectInput.cloneWithType(json));

    log:printInfo("SampleDataGenerator -> AddPullRequestReviewInputData");
    github:AddPullRequestReviewInput addPullRequestReviewInput1 = {
       pullRequestId : "1",
       commitOID : "521747298a3790fde1710f3aa2d03b55020575aa",
       body : "Adding review for a PR",
       event : github:PULL_REQUEST_REVIEW_APPROVE,
       comments : [{path: "https://github.com/SkNuwanTissera/module-ballerinax-github/commit/2", body: "Commit", position: 34}],
       clientMutationId : "clientMutationId1"
    };
    github:AddPullRequestReviewInput addPullRequestReviewInput2 = {
       pullRequestId : "2",
       commitOID : "521747298a3790ffsdfsdfsgddfgdfb55020575aa",
       body : "Adding review for a PR",
       event : github:PULL_REQUEST_REVIEW_APPROVE,
       comments : [{path: "https://github.com/SkNuwanTissera/module-ballerinax-github/commit/2", body: "Commit", position: 23}],
       clientMutationId : "clientMutationId2"
    };
    github:AddPullRequestReviewInput addPullRequestReviewInput3 = {
       pullRequestId : "3",
       commitOID : "521747298adfggfdgdg5020575aa",
       body : "Adding review for a PR",
       event : github:PULL_REQUEST_REVIEW_APPROVE,
       comments : [{path: "https://github.com/SkNuwanTissera/module-ballerinax-github/commit/2", body: "Commit", position: 223}],
       clientMutationId : "clientMutationId3"
    };

    string arrayOfaddPullRequestReviewInput = SQUARE_BRACKET_LEFT + addPullRequestReviewInput1.toJsonString() + COMMA 
                                        + addPullRequestReviewInput2.toJsonString() + COMMA + addPullRequestReviewInput3.toJsonString() 
                                        + SQUARE_BRACKET_RIGHT;
    string preparedJsonaddPullRequestReviewInput = "{"+"\"ballerinax/github:"+connecterVersion+":AddPullRequestReviewInput\""+":"+arrayOfaddPullRequestReviewInput+"}";
    check io:fileWriteJson(addPullRequestReviewInputJson, check preparedJsonaddPullRequestReviewInput.cloneWithType(json));

    log:printInfo("SampleDataGenerator -> UpdatePullRequestReviewInputData");
    github:UpdatePullRequestReviewInput updatePullRequestReviewInput1 = {
       pullRequestReviewId : "1",
       body : "Adding review for a PR",
       clientMutationId : "clientMutationId1"
    };
    github:UpdatePullRequestReviewInput updatePullRequestReviewInput2 = {
       pullRequestReviewId : "2",
       body : "Adding review for a PR",
       clientMutationId : "clientMutationId2"
    };
    github:UpdatePullRequestReviewInput updatePullRequestReviewInput3 = {
       pullRequestReviewId : "3",
       body : "Adding review for a PR",
       clientMutationId : "clientMutationId3"
    };

    string arrayOfupdatePullRequestReviewInput = SQUARE_BRACKET_LEFT + updatePullRequestReviewInput1.toJsonString() + COMMA 
                                        + updatePullRequestReviewInput2.toJsonString() + COMMA + updatePullRequestReviewInput3.toJsonString() 
                                        + SQUARE_BRACKET_RIGHT;
    string preparedJsonupdatePullRequestReviewInput = "{"+"\"ballerinax/github:"+connecterVersion+":UpdatePullRequestReviewInput\""+":"+arrayOfupdatePullRequestReviewInput+"}";
    check io:fileWriteJson(updatePullRequestReviewInputJson, check preparedJsonupdatePullRequestReviewInput.cloneWithType(json));

    log:printInfo("SampleDataGenerator -> DeletePullRequestReviewInputData");
    github:DeletePullRequestReviewInput deletePullRequestReviewInput1 = {
       pullRequestReviewId : "1",
       clientMutationId : "clientMutationId1"
    };
    github:DeletePullRequestReviewInput deletePullRequestReviewInput2 = {
       pullRequestReviewId : "2",
       clientMutationId : "clientMutationId2"
    };
    github:DeletePullRequestReviewInput deletePullRequestReviewInput3 = {
       pullRequestReviewId : "3",
       clientMutationId : "clientMutationId3"
    };

    string arrayOfdeletePullRequestReviewInput = SQUARE_BRACKET_LEFT + deletePullRequestReviewInput1.toJsonString() + COMMA 
                                        + deletePullRequestReviewInput2.toJsonString() + COMMA + deletePullRequestReviewInput3.toJsonString() 
                                        + SQUARE_BRACKET_RIGHT;
    string preparedJsondeletePullRequestReviewInput = "{"+"\"ballerinax/github:"+connecterVersion+":DeletePullRequestReviewInput\""+":"+arrayOfdeletePullRequestReviewInput+"}";
    check io:fileWriteJson(deletePullRequestReviewInputJson, check preparedJsondeletePullRequestReviewInput.cloneWithType(json));
}

public function createIssue() returns error? {
    log:printInfo("githubClient -> createIssue()");
    github:CreateIssueInput createIssueInput = {
        title: "This is a test Issue Title"
    };
    github:Issue response = check githubClient->createIssue(createIssueInput, githubUserName, sampleRepo1);
    createdIssueId = <@untainted>response.id;
    createdIssueNumber = <@untainted>response.number;
}

public function generateUserData() returns error? {
    log:printInfo("SampleDataGenerator -> UserData");
    github:User response1 = check githubClient->getAuthenticatedUser();
    string output1 = response1.toJsonString();
    string array = SQUARE_BRACKET_LEFT + output1 + COMMA + output1 + COMMA + output1 + SQUARE_BRACKET_RIGHT;
    string preparedJson = "{"+"\"ballerinax/github:"+connecterVersion+":User\""+":"+array+"}";
    json validatedJson = check preparedJson.cloneWithType(json);
    check io:fileWriteJson(userDataJson, validatedJson);

    log:printInfo("SampleDataGenerator -> UserListData");
    github:UserList usrList = check githubClient->getOrganizationMemberList(testOrganizationName, perPageCount);
    string arrayOfUserList = SQUARE_BRACKET_LEFT + usrList.toJsonString() + COMMA + usrList.toJsonString() + COMMA 
                            + usrList.toJsonString() + SQUARE_BRACKET_RIGHT;
    string preparedJsonUserList = "{"+"\"ballerinax/github:"+connecterVersion+":UserList\""+":"+arrayOfUserList+"}";          
    check io:fileWriteJson(userListJson, check preparedJsonUserList.cloneWithType(json));
}

public function generateIssueData() returns error? {
    log:printInfo("SampleDataGenerator -> IssueData, ActorData");
    var response2_1 = githubClient->getRepositoryIssue(githubUserName, githubRepo1, issueNumber);
    var response2_2 = githubClient->getRepositoryIssue(githubUserName, githubRepo1, issueNumber+1);
    var response2_3 = githubClient->getRepositoryIssue(githubUserName, githubRepo1, issueNumber+2);
    if(response2_1 is github:Issue && response2_2 is github:Issue && response2_3 is github:Issue){
        string issue1 = response2_1.toJsonString();
        string issue2 = response2_2.toJsonString();
        string issue3 = response2_3.toJsonString();

        string actor1 = response2_1?.author.toJsonString();
        string actor2 = response2_2?.author.toJsonString();
        string actor3 = response2_3?.author.toJsonString();

        string arrayOfIssues = SQUARE_BRACKET_LEFT + issue1 + COMMA + issue2 + COMMA + issue3 + SQUARE_BRACKET_RIGHT;
        string arrayOfActors = SQUARE_BRACKET_LEFT + actor1 + COMMA + actor2 + COMMA + actor3 + SQUARE_BRACKET_RIGHT;

        string preparedJsonIssues = "{"+"\"ballerinax/github:"+connecterVersion+":Issue\""+":"+arrayOfIssues+"}";
        string preparedJsonActors = "{"+"\"ballerinax/github:"+connecterVersion+":Actor\""+":"+arrayOfActors+"}";

        check io:fileWriteJson(issueDataJson, check preparedJsonIssues.cloneWithType(json));
        // check io:fileWriteJson(actorDataJson, check preparedJsonActors.cloneWithType(json));
    }
}

public function generateRepositoryData() returns error? {
    log:printInfo("SampleDataGenerator -> RepositoryData, RepositoryOwnerData");
    var response3_1 = githubClient->getUserRepository(githubUserName, githubRepo1);
    var response3_2 = githubClient->getUserRepository(githubUserName, githubRepo2);
    var response3_3 = githubClient->getUserRepository(githubUserName, githubRepo3);

    if(response3_1 is github:Repository && response3_2 is github:Repository && response3_3 is github:Repository){

        string repo1 = response3_1.toJsonString();
        string repo2 = response3_2.toJsonString();
        string repo3 = response3_3.toJsonString();

        string repoOwner1 = response3_1?.owner.toJsonString();
        string repoOwner2 = response3_2?.owner.toJsonString();
        string repoOwner3 = response3_3?.owner.toJsonString();

        string arrayOfRepoOwners = SQUARE_BRACKET_LEFT + repoOwner1 + COMMA + repoOwner2 + COMMA + repoOwner3 + SQUARE_BRACKET_RIGHT;
        string arrayOfRepos = SQUARE_BRACKET_LEFT + repo1 + COMMA + repo2 + COMMA + repo3 + SQUARE_BRACKET_RIGHT;

        string preparedJsonRepoOwners = "{"+"\"ballerinax/github:"+connecterVersion+":RepositoryOwner\""+":"+arrayOfRepoOwners+"}";
        string preparedJsonRepos = "{"+"\"ballerinax/github:"+connecterVersion+":Repository\""+":"+arrayOfRepos+"}";

        check io:fileWriteJson(repoOwnerDataJson, check preparedJsonRepoOwners.cloneWithType(json));
        check io:fileWriteJson(repoDataJson, check preparedJsonRepos.cloneWithType(json));
    }
}

public function generateRepositoryListData() returns error? {
    log:printInfo("SampleDataGenerator -> RepositoryListData");
    var response4_1 = githubClient->getAuthenticatedUserRepositoryList(perPageCount);
    var response4_2 = githubClient->getAuthenticatedUserRepositoryList(perPageCount);
    var response4_3 = githubClient->getAuthenticatedUserRepositoryList(perPageCount);

    if(response4_1 is github:RepositoryList && response4_2 is github:RepositoryList 
        && response4_3 is github:RepositoryList){

        string repoList1 = response4_1.toJsonString();
        string repoList2 = response4_2.toJsonString();
        string repoList3 = response4_3.toJsonString();

        string arrayOfRepoList = SQUARE_BRACKET_LEFT + repoList1 + COMMA + repoList2 + COMMA + repoList3 + SQUARE_BRACKET_RIGHT;

        string preparedJsonRepoList = "{"+"\"ballerinax/github:"+connecterVersion+":RepositoryList\""+":"+arrayOfRepoList+"}";

        check io:fileWriteJson(repoListDataJson, check preparedJsonRepoList.cloneWithType(json));
    }
}

public function generateCollaboratorListData() returns error? {
    log:printInfo("SampleDataGenerator -> CollaboratorListData");
    var response5_1 = githubClient->getRepositoryCollobaratorList(githubUserName, githubRepo1, perPageCount);
    var response5_2 = githubClient->getRepositoryCollobaratorList(githubUserName, githubRepo2, perPageCount);
    var response5_3 = githubClient->getRepositoryCollobaratorList(githubUserName, githubRepo3, perPageCount);

    if(response5_1 is github:CollaboratorList && response5_2 is github:CollaboratorList && response5_3 is github:CollaboratorList){

        string collaboratorList1 = response5_1.toJsonString();
        string collaboratorList2 = response5_2.toJsonString();
        string collaboratorList3 = response5_3.toJsonString();

        string arrayOfCollaboratorList = SQUARE_BRACKET_LEFT + collaboratorList1 + COMMA + collaboratorList2 + COMMA + collaboratorList3 + SQUARE_BRACKET_RIGHT;

        string preparedJsonCollaboratorList = "{"+"\"ballerinax/github:"+connecterVersion+":CollaboratorList\""+":"+arrayOfCollaboratorList+"}";

        check io:fileWriteJson(collaboratorListDataJson, check preparedJsonCollaboratorList.cloneWithType(json));
    }
}

public function generateBranchListData() returns error? {
    log:printInfo("SampleDataGenerator -> BranchListData");
    var response6_1 = githubClient->getRepositoryBranchList(githubUserName, githubRepo1, perPageCount);
    var response6_2 = githubClient->getRepositoryBranchList(githubUserName, githubRepo2, perPageCount);
    var response6_3 = githubClient->getRepositoryBranchList(githubUserName, githubRepo3, perPageCount);

    if(response6_1 is github:BranchList && response6_2 is github:BranchList && response6_3 is github:BranchList){

        string branchList1 = response6_1.toJsonString();
        string branchList2 = response6_2.toJsonString();
        string branchList3 = response6_3.toJsonString();

        string pageInfo1 = response6_1.pageInfo.toJsonString();
        string pageInfo2 = response6_2.pageInfo.toJsonString();
        string pageInfo3 = response6_3.pageInfo.toJsonString();

        string arrayOfBranchList = SQUARE_BRACKET_LEFT + branchList1 + COMMA + branchList2 + COMMA + branchList3 + SQUARE_BRACKET_RIGHT;
        string arrayOfPageInfo = SQUARE_BRACKET_LEFT + pageInfo1 + COMMA + pageInfo2 + COMMA + pageInfo3 + SQUARE_BRACKET_RIGHT;

        string preparedJsonBranchList = "{"+"\"ballerinax/github:"+connecterVersion+":BranchList\""+":"+arrayOfBranchList+"}";
        string preparedJsonPageInfo = "{"+"\"ballerinax/github:"+connecterVersion+":BranchList\""+":"+arrayOfPageInfo+"}";

        check io:fileWriteJson(branchListDataJson, check preparedJsonBranchList.cloneWithType(json));
        check io:fileWriteJson(pageInfoDataJson, check preparedJsonPageInfo.cloneWithType(json));
    }
}

public function generateIssueListData() returns error? {
    log:printInfo("SampleDataGenerator -> IssueListData");
    var response7_1 = githubClient->getRepositoryIssueList(githubUserName, githubRepo1, [github:ISSUE_OPEN], perPageCount);
    var response7_2 = githubClient->getRepositoryIssueList(githubUserName, githubRepo2, [github:ISSUE_OPEN], perPageCount);
    var response7_3 = githubClient->getRepositoryIssueList(githubUserName, githubRepo3, [github:ISSUE_OPEN], perPageCount);

    if(response7_1 is github:IssueList && response7_2 is github:IssueList && response7_3 is github:IssueList){

        string issueList1 = response7_1.toJsonString();
        string issueList2 = response7_2.toJsonString();
        string issueList3 = response7_3.toJsonString();

        string arrayOfIssueList = SQUARE_BRACKET_LEFT + issueList1 + COMMA + issueList2 + COMMA + issueList3 + SQUARE_BRACKET_RIGHT;
        string preparedJsonIssueList = "{"+"\"ballerinax/github:"+connecterVersion+":IssueList\""+":"+arrayOfIssueList+"}";
        check io:fileWriteJson(issueListDataJson, check preparedJsonIssueList.cloneWithType(json));
    }
}

public function generateIssueCommentData() returns error? {
    log:printInfo("SampleDataGenerator -> IssueCommentData, IssueCommentListData");
    var response8_1 = githubClient->getRepositoryIssueCommentList(githubUserName, githubRepo1, issueNumber, perPageCount);
    var response8_2 = githubClient->getRepositoryIssueCommentList(githubUserName, githubRepo1, issueNumber+1, perPageCount);
    var response8_3 = githubClient->getRepositoryIssueCommentList(githubUserName, githubRepo1, issueNumber+2, perPageCount);

    if(response8_1 is github:IssueCommentList && response8_2 is github:IssueCommentList && response8_3 is github:IssueCommentList){

        string issueCommentList1 = response8_1.toJsonString();
        string issueCommentList2 = response8_2.toJsonString();
        string issueCommentList3 = response8_3.toJsonString();

        string issueComment1 = response8_1?.nodes.toJsonString();
        string issueComment2 = response8_2?.nodes.toJsonString();
        string issueComment3 = response8_3?.nodes.toJsonString();

        string arrayOfIssueCommentList = SQUARE_BRACKET_LEFT + issueCommentList1 + COMMA + issueCommentList2 + COMMA + 
                                            issueCommentList3 + SQUARE_BRACKET_RIGHT;
        string arrayOfIssueComment = SQUARE_BRACKET_LEFT + issueComment1 + COMMA + issueComment2 + COMMA + 
                                            issueComment3 + SQUARE_BRACKET_RIGHT;
        
        string preparedJsonIssueCommentList = "{"+"\"ballerinax/github:"+connecterVersion+":IssueCommentList\""+":"+arrayOfIssueCommentList+"}";
        string preparedJsonIssueComment = "{"+"\"ballerinax/github:"+connecterVersion+":IssueComment\""+":"+arrayOfIssueComment+"}";

        check io:fileWriteJson(issueCommentListDataJson, check preparedJsonIssueCommentList.cloneWithType(json));
        check io:fileWriteJson(issueCommentDataJson, check preparedJsonIssueComment.cloneWithType(json));
    }
}

public function createPullRequests() returns error? {
    // Create Pull requests
    log:printInfo("SampleDataGenerator -> (TASK) createPullRequests");
    github:CreatePullRequestInput createPullRequestInput1 = {
       title: "Test PR created from Ballerina GitHub Data Generator",
       baseRefName: "main",
       headRefName: "test1",
       body: "This is some dummy content for PR body",
       maintainerCanModify : true,
       draft : false,
       clientMutationId : "clientMutationId1"
    };
    github:CreatePullRequestInput createPullRequestInput2 = {
       title: "Test PR created from Ballerina GitHub Data Generator",
       baseRefName: "main",
       headRefName: "test2",
       body: "This is some dummy content for PR body",
       maintainerCanModify : true,
       draft : false,
       clientMutationId : "clientMutationId1"
    };
    github:CreatePullRequestInput createPullRequestInput3 = {
       title: "Test PR created from Ballerina GitHub Data Generator",
       baseRefName: "main",
       headRefName: "test3",
       body: "This is some dummy content for PR body",
       maintainerCanModify : true,
       draft : false,
       clientMutationId : "clientMutationId1"
    };

    log:printInfo("SampleDataGenerator -> CreatePullRequestInput");
    string createPR1 = createPullRequestInput1.toJsonString();
    string createPR2 = createPullRequestInput2.toJsonString();
    string createPR3 = createPullRequestInput3.toJsonString();

    string arrayOfCreatePR = SQUARE_BRACKET_LEFT + createPR1 + COMMA + createPR2 + COMMA + 
                                            createPR3 + SQUARE_BRACKET_RIGHT;

    string preparedJsonCreatePR= "{"+"\"ballerinax/github:"+connecterVersion+":CreatePullRequestInput\""+":"+arrayOfCreatePR+"}";
    check io:fileWriteJson(createPullRequestDataJson, check preparedJsonCreatePR.cloneWithType(json));

    github:PullRequest pr1 = check githubClient->createPullRequest(createPullRequestInput1, githubUserName, sampleRepo1);
    github:PullRequest pr2 = check githubClient->createPullRequest(createPullRequestInput2, githubUserName, sampleRepo1);
    github:PullRequest pr3 = check githubClient->createPullRequest(createPullRequestInput3, githubUserName, sampleRepo1);

    pr1Id = <@untainted>pr1.id;
    pr1Number = <@untainted>(<int>(pr1?.number));
    io:println("New PR : #",pr1Number);
    pr2Id = <@untainted>pr2.id;
    pr2Number = <@untainted>(<int>(pr2?.number));
    io:println("New PR : #",pr2Number);
    pr3Id = <@untainted>pr3.id;
    pr3Number = <@untainted>(<int>(pr3?.number));
    io:println("New PR : #",pr3Number);
}

public function createPullRequestReview() returns error?{
    log:printInfo("SampleDataGenerator -> (TASK) createPullRequestReview");
    github:AddPullRequestReviewInput createPullRequestReviewInput = {
        body: "This is a test review comment",
        event: github:PULL_REQUEST_REVIEW_COMMENT
    };

    github:PullRequestReview pr1_review = check githubClient->createPullRequestReview(createPullRequestReviewInput, githubUserName, sampleRepo1, pr1Number);
    github:PullRequestReview pr2_review = check githubClient->createPullRequestReview(createPullRequestReviewInput, githubUserName, sampleRepo1, pr2Number);
    github:PullRequestReview pr3_review = check githubClient->createPullRequestReview(createPullRequestReviewInput, githubUserName, sampleRepo1, pr3Number);

    string pullRequestReview1 = pr1_review.toJsonString();
    string pullRequestReview2 = pr2_review.toJsonString();
    string pullRequestReview3 = pr3_review.toJsonString();

    string arrayOfPullRequestReviews = SQUARE_BRACKET_LEFT + pullRequestReview1 + COMMA + pullRequestReview2 + COMMA + 
                                            pullRequestReview3 + SQUARE_BRACKET_RIGHT;

    string preparedJsonPullRequestReview = "{"+"\"ballerinax/github:"+connecterVersion+":PullRequestReview\""+":"+arrayOfPullRequestReviews+"}";
    check io:fileWriteJson(pullRequestReviewDataJson, check preparedJsonPullRequestReview.cloneWithType(json));
}

public function generatePullRequestListData() returns error? {
    log:printInfo("SampleDataGenerator -> PullRequestData, PullRequestListData");

    var response9_1 = githubClient->getRepositoryPullRequestList(githubUserName, sampleRepo1, github:PULL_REQUEST_OPEN, perPageCount);

    if(response9_1 is github:PullRequestList){

        string pullRequest1 = response9_1?.nodes[0].toJsonString();
        string pullRequest2 = response9_1?.nodes[1].toJsonString();
        string pullRequest3 = response9_1?.nodes[2].toJsonString();

        string pullRequestList1 = response9_1.toJsonString();

        string arrayOfPullRequests = SQUARE_BRACKET_LEFT + pullRequest1 + COMMA + pullRequest2 + COMMA + 
                                            pullRequest3 + SQUARE_BRACKET_RIGHT;
        string arrayOfPullRequestList = SQUARE_BRACKET_LEFT + pullRequestList1 + COMMA + pullRequestList1 + COMMA + 
                                            pullRequestList1 + SQUARE_BRACKET_RIGHT;
        
        string preparedJsonPullRequests = "{"+"\"ballerinax/github:"+connecterVersion+":PullRequest\""+":"+arrayOfPullRequests+"}";
        string preparedJsonPullRequestList = "{"+"\"ballerinax/github:"+connecterVersion+":PullRequestList\""+":"+arrayOfPullRequestList+"}";

        check io:fileWriteJson(pullRequestDataJson, check preparedJsonPullRequests.cloneWithType(json));
        check io:fileWriteJson(pullRequestListDataJson, check preparedJsonPullRequestList.cloneWithType(json));
    }
}

public function generatePullRequestReviewListData() returns error? {

    log:printInfo("SampleDataGenerator -> PullRequestReviewData, PullRequestReviewListData");

    github:PullRequestReviewList response10_1 = check githubClient->getPullRequestReviewCommentList(githubUserName, sampleRepo1, pr1Number, perPageCount);

    string pullRequestReviewList1 = response10_1.toJsonString();

    string arrayOfPullRequestReviewList = SQUARE_BRACKET_LEFT + pullRequestReviewList1 + COMMA + pullRequestReviewList1 + COMMA + 
                                        pullRequestReviewList1 + SQUARE_BRACKET_RIGHT;
    
    string preparedJsonPullRequestReviewList = "{"+"\"ballerinax/github:"+connecterVersion+":PullRequestReviewList\""+":"+arrayOfPullRequestReviewList+"}";

    check io:fileWriteJson(pullRequestReviewListDataJson, check preparedJsonPullRequestReviewList.cloneWithType(json));
}

public function generateMilestoneListData() returns error? {

    log:printInfo("SampleDataGenerator -> MilestoneListData, MilestoneData");
    github:MilestoneList reponseMilestoneList = check githubClient->getRepositoryMilestoneList(githubUserName, sampleRepo1, perPageCount);
    string milestoneList = reponseMilestoneList.toJsonString(); 

    string milestone1 = reponseMilestoneList?.nodes[0].toJsonString(); 
    string milestone2 = reponseMilestoneList?.nodes[1].toJsonString(); 
    string milestone3 = reponseMilestoneList?.nodes[2].toJsonString(); 

    string arrayOfMilestoneList = SQUARE_BRACKET_LEFT + milestoneList + COMMA + milestoneList + COMMA + 
                                        milestoneList + SQUARE_BRACKET_RIGHT;   
    string preparedJsonMilestoneList = "{"+"\"ballerinax/github:"+connecterVersion+":MilestoneList\""+":"+arrayOfMilestoneList+"}";

    string arrayOfMilestones = SQUARE_BRACKET_LEFT + milestone1 + COMMA + milestone2 + COMMA + 
                                        milestone3 + SQUARE_BRACKET_RIGHT;   
    string preparedJsonMilestones = "{"+"\"ballerinax/github:"+connecterVersion+":Milestone\""+":"+arrayOfMilestones+"}";
    
    check io:fileWriteJson(milestoneListJson, check preparedJsonMilestoneList.cloneWithType(json));
    check io:fileWriteJson(milestoneJson, check preparedJsonMilestones.cloneWithType(json));
}

public function generateProjectListData() returns error? {

    log:printInfo("SampleDataGenerator -> ProjectListData, ProjectData");
    github:ProjectList projectListResponse = check githubClient->getOrganizationProjectList(testOrganizationName, github:PROJECT_OPEN, perPageCount);
    string projectList = projectListResponse.toJsonString(); 
    
    string project1 = projectListResponse?.nodes[0].toJsonString(); 
    string project2 = projectListResponse?.nodes[1].toJsonString(); 
    string project3 = projectListResponse?.nodes[2].toJsonString(); 

    string arrayOfProjectList = SQUARE_BRACKET_LEFT + projectList + COMMA + projectList + COMMA + 
                                        projectList + SQUARE_BRACKET_RIGHT; 
    string arrayOfProjects = SQUARE_BRACKET_LEFT + project1 + COMMA + project2 + COMMA + 
                                        project3 + SQUARE_BRACKET_RIGHT;   

    string preparedJsonProjectList = "{"+"\"ballerinax/github:"+connecterVersion+":ProjectList\""+":"+arrayOfProjectList+"}";
    string preparedJsonProject = "{"+"\"ballerinax/github:"+connecterVersion+":Project\""+":"+arrayOfProjects+"}";

    check io:fileWriteJson(projectListJson, check preparedJsonProjectList.cloneWithType(json));
    check io:fileWriteJson(projectJson, check preparedJsonProject.cloneWithType(json));
}
public function generateOrganizationListData() returns error? {

    log:printInfo("SampleDataGenerator -> OrganizationListData, OrganizationData");
    github:OrganizationList orgListResponse = check githubClient->getUserOrganizationList(githubUserName, perPageCount);
    string organizationList = orgListResponse.toJsonString(); 
    
    string org1 = orgListResponse?.nodes[0].toJsonString(); 
    string org2 = orgListResponse?.nodes[1].toJsonString(); 
    string org3 = orgListResponse?.nodes[2].toJsonString(); 

    string arrayOfOrgList = SQUARE_BRACKET_LEFT + organizationList + COMMA + organizationList + COMMA + 
                                        organizationList + SQUARE_BRACKET_RIGHT;   
    string arrayOfOrg = SQUARE_BRACKET_LEFT + org1 + COMMA + org2 + COMMA + org3 + SQUARE_BRACKET_RIGHT; 

    string preparedJsonOrganizationList = "{"+"\"ballerinax/github:"+connecterVersion+":OrganizationList\""+":"+arrayOfOrgList+"}";
    string preparedJsonOrganization = "{"+"\"ballerinax/github:"+connecterVersion+":Organization\""+":"+arrayOfOrg+"}";
  

    check io:fileWriteJson(organizationListJson, check preparedJsonOrganizationList.cloneWithType(json));
    check io:fileWriteJson(organizationJson, check preparedJsonOrganization.cloneWithType(json));
}

public function closePRs() returns error? {
    log:printInfo("SampleDataGenerator -> (TASK) Closing opened PR's");

    github:UpdatePullRequestInput updatePullRequestInput1 = {
       pullRequestId: pr1Id,
       state: github:PULL_REQUEST_CLOSED
    };

    github:UpdatePullRequestInput updatePullRequestInput2 = {
       pullRequestId: pr2Id,
       state: github:PULL_REQUEST_CLOSED
    };

    github:UpdatePullRequestInput updatePullRequestInput3 = {
       pullRequestId: pr3Id,
       state: github:PULL_REQUEST_CLOSED
    };

    _ = check githubClient->updatePullRequest(updatePullRequestInput1, githubUserName, sampleRepo1, pr1Number);
    _ = check githubClient->updatePullRequest(updatePullRequestInput2, githubUserName, sampleRepo1, pr2Number);
    _ = check githubClient->updatePullRequest(updatePullRequestInput3, githubUserName, sampleRepo1, pr3Number);

    io:println("Closed PR :", pr1Number);
    io:println("Closed PR :", pr2Number);
    io:println("Closed PR :", pr3Number);
}
