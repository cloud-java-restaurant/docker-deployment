#!/bin/bash

curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=max' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d 'client_secret=z8DEMatUnmNTJkPk1ov8Cc8nXYzpLdaD' -d 'scope=openid'