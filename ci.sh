#!/bin/bash

retries=2
wait_time=10

curl_command="-L \
  -H 'Accept: application/vnd.github+json' \
  -H 'Authorization: Bearer ${{ secrets.G_PERSONAL }}' \
  -H 'X-GitHub-Api-Version: 2022-11-28' \
  'https://api.github.com/repos/bkolad/child_repo/actions/workflows/workflow.yml/runs'"

curl_command2="-s \
  'https://api.github.com/repos/bkolad/child_repo/actions/workflows/workflow.yml/runs'"


while :
do 
     echo "$retries"
    if [[ retries -lt 1 ]]
    then
        exit 1
    fi

    

    #workflow_conclusion=$(curl -s "https://api.github.com/repos/bkolad/child_repo/actions/workflows/workflow.yml/runs" | jq -r '.workflow_runs[0].conclusion')


    workflow_conclusion=$(curl -H 'Accept: application/vnd.github+json' -H 'Authorization: Bearer $ACCESS_TOKEN' -H 'X-GitHub-Api-Version: 2022-11-28' "https://api.github.com/repos/bkolad/child_repo/actions/workflows/workflow.yml/runs")
    echo "$workflow_conclusion"
    
    if [[ $workflow_conclusion == "success1" ]]
    then
        echo "Loool"
        break
    fi
    sleep $wait_time
    ((retries--))
done 