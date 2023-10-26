#!/bin/bash

retries=2
wait_time=10
while :
do 
     echo "$retries"
    if [[ retries -lt 1 ]]
    then
        exit 1
    fi

    workflow_conclusion=$(curl -s "https://api.github.com/repos/bkolad/child_repo/actions/workflows/workflow.yml/runs" | jq -r '.workflow_runs[0].conclusion')
    echo "$workflow_conclusion"

    if [[ $workflow_conclusion == "success1" ]]
    then
        echo "Loool"
        break
    fi
    sleep $wait_time
    ((retries--))
done 