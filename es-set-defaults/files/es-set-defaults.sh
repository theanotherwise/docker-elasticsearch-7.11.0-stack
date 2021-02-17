#!/bin/bash

while true ; do
  STATUS=`curl --silent http://es03-coo02:9200/_cluster/health | grep -o green | head -1`

  sleep 1

  if [[ "${STATUS}" == "green" ]] ; then
    break
  else
    echo "Waiting for GREEN status.."
  fi
done

curl -X PUT --header 'Content-Type: application/json' http://es03-coo02:9200/_ilm/policy/default -d '
{
  "policy": {
    "phases": {
      "hot": {
        "min_age": "0ms",
        "actions": {
          "rollover": {
            "max_size": "200kb",
            "max_age": "1m",
            "max_docs": 10
          },
          "set_priority": {
            "priority": 100
          }
        }
      },
      "warm": {
        "min_age": "1m",
        "actions": {
          "set_priority": {
            "priority": 50
          }
        }
      },
      "cold": {
        "min_age": "2m",
        "actions": {
          "set_priority": {
            "priority": 0
          }
        }
      },
      "delete": {
        "min_age": "3m",
        "actions": {
          "delete": {
            "delete_searchable_snapshot": true
          }
        }
      }
    }
  }
}'

curl -X PUT --header 'Content-Type: application/json' http://es03-coo02:9200/_cluster/settings -d '
{
    "persistent" : {
        "indices.lifecycle.poll_interval": "5s"
    }
}'

echo "All Requests executed"