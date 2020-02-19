#!/usr/bin/env bash
if [ ! -z $1 ]; then 
    if [[ $1 = 'postgres' ]] ; then 
        docker-compose exec $1 psql -U postgres -h postgres
    elif [[ $1 = 'redis' ]] ; then 
        docker-compose exec $1 redis-cli
    elif docker-compose exec $1 test -f /bin/bash; then
		docker-compose exec $1 bash
	else
		docker-compose exec $1 sh
	fi
else
	echo "No arg. Use $0 container_name "
	exit 1
fi