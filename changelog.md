# Changelog
This file contains all the notable changes done to the Ballerina GitHub package through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Breaking Changes
- [[#8642](https://github.com/ballerina-platform/ballerina-library/issues/8642)] Regenerated the connector from the aligned OpenAPI specification
  - Record field names now use camelCase with `@jsondata:Name` annotations for JSON mapping (e.g., `created_at` -> `createdAt`, `body_html` -> `bodyHtml`)
  - Request body type names updated to follow new naming convention (e.g., `Git_refs_body` -> `git_refs_body`, `Pulls_pull_number_body` -> `pulls_pullNumber_body`)
  - Some client resource methods now return optional types (e.g., `PullRequest|error?` instead of `PullRequest|error`)
  - `ContentTree` type replaced with `inline_response_200` union type (`ContentDirectory|ContentFile|ContentSymlink|ContentSubmodule`)

### Fixed
- [[#8642](https://github.com/ballerina-platform/ballerina-library/issues/8642)] Fixed data binding error when fetching `/search/issues` due to `body` field not being nullable

### Changed
- Updated keywords for connector filtering
