#!/usr/bin/env bash

TASK_ID="$1"

# where feature branch was merged
MERGE_COMMIT=$(git log --oneline -1 -p ":/Merge branch.*#$TASK_ID" --format=format:"%H" 2>/dev/null || echo)

if [[ "$MERGE_COMMIT" != "" ]]; then
    echo MERGE_COMMIT \"$MERGE_COMMIT\"

    # where feature branch started
    PARENT="$MERGE_COMMIT^1..$MERGE_COMMIT"

    # log feature branch commits
    git log $PARENT $MERGE_COMMIT --format=format:"%H"
    echo feature branch
    exit
fi

SINGLE_COMMIT=$(git log --oneline -1 ":/#$TASK_ID" --format=format:"%H" 2>/dev/null || echo)

if [[ $SINGLE_COMMIT != "" ]]; then
   git log -1 $SINGLE_COMMIT --format=format:"%H"
   echo single commit
   exit
fi

echo Task not found: \#$TASK_ID
