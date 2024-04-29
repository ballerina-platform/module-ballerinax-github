# Introduction

This file documents the modifications applied to enhance the usability of the official OpenAPI Specification (OAS). These adjustments are made to address known limitations on the language side and improve overall functionality.

1. Remove the `x-webhooks` section along with all associated component schemas.

2. Restructure OpenAPI by relocating inline responses from endpoint definitions in `paths` section to the `components` section and reference them appropriately within each endpoint's response.
    - `#/components/schemas/manifest-conversions`
    - `#/components/schemas/repository-response`
    - `#/components/schemas/notification-read`
    - `#/components/schemas/actions-cache-usage-by-repository-response`
    - `#/components/schemas/runner-response`
    - `#/components/schemas/organization-actions-secret-response`
    - `#/components/schemas/minimal-repository-response`
    - `#/components/schemas/organization-actions-variable-response`
    - `#/components/schemas/codespace-response`
    - `#/components/schemas/codespaces-org-secret-response`
    - `#/components/schemas/copilot-seat-details-response`
    - `#/components/schemas/copilot-seat-created`
    - `#/components/schemas/copilot-seat-cancelled`
    - `#/components/schemas/organization-dependabot-secret-response`
    - `#/components/schemas/installation-response`
    - `#/components/schemas/interaction-limit-response-any`
    - `#/components/schemas/artifact-response`
    - `#/components/schemas/actions-secret-response`
    - `#/components/schemas/actions-variable-response`
    - `#/components/schemas/workflow-run-response`
    - `#/components/schemas/job-response`
    - `#/components/schemas/workflow-response`
    - `#/components/schemas/check-run-response`
    - `#/components/schemas/check-suite-response`
    - `#/components/schemas/dependabot-secret-response`
    - `#/components/schemas/snapshot-response`
    - `#/components/schemas/merged-branch-response`
    - `#/components/schemas/environment-response`
    - `#/components/schemas/deployment-branch-policy-response`
    - `#/components/schemas/deployment-protection-rule-response`
    - `#/components/schemas/custom-deployment-rule-app-response`
    - `#/components/schemas/stargazer-response`
    - `#/components/schemas/code-search-result-item-response`
    - `#/components/schemas/commit-search-result-item-response`
    - `#/components/schemas/issue-search-result-item-response`
    - `#/components/schemas/label-search-result-item-response`
    - `#/components/schemas/repo-search-result-item-response`
    - `#/components/schemas/topic-search-result-item-response`
    - `#/components/schemas/user-search-result-item-response`
    - `#/components/schemas/user-response`
    - `#/components/schemas/codespace-response`
    - `#/components/schemas/codespaces-secret-response`
    - `#/components/schemas/codespace-machine-response`
    - `#/components/schemas/installation-response`
    - `#/components/schemas/repository-response`
    - `#/components/schemas/starred-repository-response`

3. Change the name of the `Thread` schema to `NotificationThread` as a workaround for the issue outlined in [Openapi tool does not escape in built symbols](https://github.com/ballerina-platform/ballerina-standard-library/issues/5067)

4. Set the `nullable` property to `true` for the `company` and `email` fields in the `organization-full` schema under `component` section. This adjustment is made to address a data binding issue.

5. Set the `nullable` property to `true` for the `url` property of the `license` property in the `minimal-repository` schema under the `component` section. This adjustment is made to address a data binding issue.

6. Set the `nullable` property to `true` for the `description` property of the `labels` property in the `pull-request-simple` schema under the `component` section. This adjustment is made to address a data binding issue.(https://github.com/ballerina-platform/ballerina-library/issues/6259)

7. Update the response schema `#/components/schemas/content-tree` for the endpoint `/repos/{owner}/{repo}/contents/{path}` to represent the response as an array. This adjustment is made to address a data binding issue.

8. Update the `state_reason` field to be nullable in the `Issue` record within the generated types as a workaround for the issue outlined in [Nillable Enum Types Result in Incorrect Record Field Generation](https://github.com/ballerina-platform/ballerina-library/issues/5902)

9. Update the resource function `get user/repos(...)` to allow optional query parameters, in accordance with the OAS specification that designates them as non-required. This modification addresses a discrepancy in the generated client, which previously disallowed passing null values for the corresponding parameters.

10. Remove the security-sensitive keys, including the private key, GitHub app token, and JWT token, which are provided as example values. These keys are leading to failures in Trivy scans.

## OpenAPI cli command

```bash
bal openapi -i docs/spec/openapi.json --mode client --license docs/license.txt -o ballerina
```
