#!/usr/bin/env bash
if [ ! -z $1 ]; then 
    CONTAINER_ID="docker ps -q -f name=$1"
    if [[ $($CONTAINER_ID) ]] ; then 
        echo "Container ID: $($CONTAINER_ID)"
    else 
        echo "No container found: $1"
        exit 1
    fi

    if [[ $1 = 'postgres' ]] ; then 
        docker exec -it $($CONTAINER_ID) psql -U postgres -h postgres
    elif [[ $1 = 'redis' ]] ; then 
        docker exec -it $($CONTAINER_ID) redis-cli
    elif docker exec -it $($CONTAINER_ID) test -f /bin/bash; then
		docker exec -it $($CONTAINER_ID) bash
	else
		docker exec -it $($CONTAINER_ID) sh
	fi
else
	echo "No arg. Use $0 container_name "
	exit 1
fi