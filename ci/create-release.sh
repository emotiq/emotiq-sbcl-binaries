#!/usr/bin/env bash

github-release release \
  --user ${GITHUB_REPO_OWNER} \
  --repo ${GITHUB_REPO} \
  --tag ${CI_COMMIT_TAG} \
  --description ${CI_COMMIT_MESSAGE}
