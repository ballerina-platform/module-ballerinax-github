package src.wso2.github.structTemplates;

public struct Project {
    string id;
    int databaseId;
    string name;
    string body;
    int number;
    string createdAt;
    string closed;
    string closedAt;
    string updatedAt;
    string resourcePath;
    string state;
    string url;
    boolean viewerCanUpdate;
    Creator creator;
    Owner owner;
}

public struct Creator {
    string login;
    string resourcePath;
    string url;
    string avatarUrl;
}

public struct Owner {
    string id;
    string projectsResourcePath;
    string projectsUrl;
    boolean viewerCanCreateProjects;
}

public struct Error {
    string message;
}


