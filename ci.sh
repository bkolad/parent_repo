#!/bin/bash

RETRIES=6
WAIT_TIME=10
while :
do 
     echo "$RETRIES"
    if [[ RETRIES -lt 1 ]]
    then
        exit 1
    fi

    workflow_result="$(
        curl \
        -s \
        -L \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: token $CI_TRIGGER_ACCESS_TOKEN" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "https://api.github.com/repos/bkolad/child_repo/actions/workflows/workflow.yml/runs"
    )"

    workflow_conclusion=$(echo $workflow_result | jq -r '.workflow_runs[0].conclusion')
    echo $workflow_conclusion

    if [[ $workflow_conclusion == "success" ]]
    then
        echo "Loool X"
        break
    fi
    sleep $WAIT_TIME
    ((RETRIES--))
done 