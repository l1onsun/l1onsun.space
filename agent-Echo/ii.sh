#!/usr/bin/env bash
set -euox pipefail

GIT_TOPLEVEL=$1
REPO_MIRROR="${HOME}/rootMirror${GIT_TOPLEVEL}"
if [ ! -d "$REPO_MIRROR" ]; then
    mkdir -p "$REPO_MIRROR"
    git config --global --add safe.directory "$GIT_TOPLEVEL"
    git clone "$GIT_TOPLEVEL" "$REPO_MIRROR"
fi
cd $REPO_MIRROR
ORIGINAL_PROJECT_DIR=$GIT_TOPLEVEL pi
