# Introduction

This file records the sanitation done on top of the official OAS. These sanitation's are done for improving usability and as workaround for known limitations in language side.

1. Remove resource paths,
    * /users/{userId}/settings - This path has around 20 odd sub paths and does not add significant usability.
    * /users/{userId}/watch & /users/{userId}/stop - This will be covered in Google PubSub

2. Rename `Thread` schema to `NotificationThread`. This is done as a workaround for issue, [Openapi tool does not escape in built symbols](https://github.com/ballerina-platform/ballerina-standard-library/issues/5067)

## OpenAPI cli command

```bash
bal openapi -i docs/open-api-spec/openapi.json --mode client -o ballerina
```
