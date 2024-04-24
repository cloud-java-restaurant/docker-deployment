#!/bin/bash

echo -e "\n*** Starting Docker Containers ***\n"

docker volume rm docker_db-data

docker volume rm docker_connect-data

docker volume rm docker_kafka-data

docker compose up -d


