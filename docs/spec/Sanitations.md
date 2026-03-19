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

7. Update the response schema `#/components/schemas/content-tree` for the endpoint `/repos/{owner}/{repo}/contents/{path}` to represent the response as an array. Additionally, modify the corresponding generated resource function to handle both array and object responses, ensuring it consistently returns an array. This adjustment is made to address a data binding issue and to preserve backward compatibility, and the change will be reverted in the next major version.

8. Update the `state_reason` field to be nullable in the `Issue` record within the generated types as a workaround for the issue outlined in [Nillable Enum Types Result in Incorrect Record Field Generation](https://github.com/ballerina-platform/ballerina-library/issues/5902)

9. Update the resource function `get user/repos(...)` to allow optional query parameters, in accordance with the OAS specification that designates them as non-required. This modification addresses a discrepancy in the generated client, which previously disallowed passing null values for the corresponding parameters.

10. Remove the security-sensitive keys, including the private key, GitHub app token, and JWT token, which are provided as example values. These keys are leading to failures in Trivy scans.

11. Consolidate duplicate request body schemas for the branch protection restrictions endpoints. The flatten step generated three identical schemas for the PUT/POST/DELETE methods on each of the `/apps`, `/teams`, and `/users` restriction endpoints (e.g. `RestrictionsAppsBody`, `RestrictionsAppsBody1`, `RestrictionsAppsBody2`). All three methods accept the same body structure, so `Body1` and `Body2` variants (and their underlying duplicate `OneOf` component schemas) were removed, and the POST and DELETE endpoint refs updated to point to the canonical `Body` schema.

12. Rename the `RepositoryRuleDetailed` `oneOf` variant schemas from the verbose auto-generated names (e.g., `RepositoryRuleDetailedRepositoryRuleDetailed...OneOf12345678910111213`) to short names `RepositoryRuleDetailedOneOf1` through `RepositoryRuleDetailedOneOf14`. The `bal openapi align` tool generates cascading names by repeating the parent schema name for each nested variant, causing the file paths of the generated `.class` files to exceed OS limits and break the build.

13. Remove the `default: "all"` from the `type` query parameter of `GET /user/repos`. The GitHub API returns a 422 if `type` is sent in the same request as `visibility` or `affiliation`, but all three had defaults in the original spec, so every generated call triggered the error. Making `type` optional (no default) resolves this.

14. Remove the `default: false` from the `allow_forking` field in the `PATCH /repos/{owner}/{repo}` request body (`OwnerrepoBody1`). The GitHub API returns a 422 ("Allow forks can only be changed on org-owned repositories") if `allow_forking` is sent for a personal repository, but the default caused it to always be included in the request. Making it optional (no default) resolves this.

## OpenAPI cli command

**Important:** The overlay must be applied AFTER `bal openapi align`, not before. The align
step strips `description` from pure `$ref` properties (valid OpenAPI 3.0 behaviour), so
applying before align would lose those descriptions. The overlay converts pure `$ref`
properties to `allOf` wrappers to preserve descriptions through generation.

```bash
# Step 1: Flatten inline schemas into the components section
bal openapi flatten -i docs/spec/openapi.json
mv flattened_openapi.json docs/spec/openapi.json

# Step 2: Align naming conventions to Ballerina standards (adds x-ballerina-name extensions)
bal openapi align -i docs/spec/openapi.json
mv aligned_ballerina_openapi.json docs/spec/openapi.json

# Step 3: Apply the overlay (injects missing descriptions, wraps $ref props, strips backticks)
# (apply overlay.yaml to openapi.json locally before generating)

# Step 4: Generate the client
bal openapi -i docs/spec/openapi.json --mode client --license docs/license.txt -o ballerina
```

## Managing the overlay

Missing property and parameter descriptions are maintained in `docs/spec/overlay.yaml`
rather than edited directly in `openapi.json`. Descriptions survive spec upgrades —
when GitHub releases a new spec, re-applying the overlay restores all customisations.

`overlay.yaml` contains two sections:
- **`actions`**: schema property descriptions (`$.components.schemas.X.properties.Y`)
- **`path_params`**: inline query/path parameter descriptions for specific operations

To add descriptions for newly undocumented properties (e.g. after a spec update), generate
descriptions and append new actions to `overlay.yaml` (skipping already-covered properties),
then re-apply the updated overlay to `openapi.json`.

## Known generator warnings (unfixable without patching the Ballerina OpenAPI tool)

The following 6 warnings appear in the generated `client.bal` and cannot be resolved
from the spec side. They are caused by the Ballerina OpenAPI generator occasionally
mis-associating parameter documentation from one operation with another:

- `no such documentable parameter 'patId'` (lines ~2550, ~2564) — affects
  `POST /orgs/{org}/personal-access-token-requests/{patRequestId}` and the corresponding
  GET repositories endpoint; the generator uses `patId` docs from the `fine-grained-personal-access-token-id`
  component parameter instead of the inline `patRequestId` parameter.
- `no such documentable parameter 'ghsaId'` (lines ~5208, ~5220, ~5290) — affects
  `GET` and `PATCH /repos/{owner}/{repo}/check-runs/{checkRunId}` and a security advisory
  endpoint; the generator outputs security advisory parameter docs on check-run functions.
- `no such documentable parameter 'checkSuiteId'` (line ~5249) — affects
  `POST /repos/{owner}/{repo}/check-runs/{checkRunId}/rerequest`; the generator uses
  check-suite docs instead of check-run docs.
