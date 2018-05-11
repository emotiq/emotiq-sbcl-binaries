#!/usr/bin/env bash

github-release upload \
  --user ${GITHUB_REPO_OWNER} \
  --repo ${GITHUB_REPO} \
  --tag ${CI_COMMIT_TAG} \
  --file $1
