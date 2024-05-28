#!/bin/bash

ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=alex' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d 'client_secret=z8DEMatUnmNTJkPk1ov8Cc8nXYzpLdaD' -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"

echo -e "\n*** Submitting requests to Menu Service ***\n"
printf "\n\n"
curl -X POST http://localhost:9099/v1/menu-items -H "$AUTH_HEADER" -H 'Content-Type: application/json' -d '{"name": "One","description": "Nice Item One", "price": 10.10, "category": "drinks", "timeToCook": 1000, "weight": 10.20, "imageUrl": "http://images.com/one.png", "ingredientCollection": {"ingredients": [{"name": "ingredient one", "calories": 10}, {"name": "ingredient two", "calories": 20}]}}'
printf "\n\n"
curl -X POST http://localhost:9099/v1/menu-items -H "$AUTH_HEADER" -H 'Content-Type: application/json' -d '{"name": "Two","description": "Nice Item Two", "price": 10.10, "category": "drinks", "timeToCook": 1000, "weight": 10.20, "imageUrl": "http://images.com/one.png", "ingredientCollection": {"ingredients": [{"name": "ingredient one", "calories": 10}, {"name": "ingredient two", "calories": 20}]}}'
printf "\n\n"
curl -X POST http://localhost:9099/v1/menu-items -H "$AUTH_HEADER" -H 'Content-Type: application/json' -d '{"name": "Three","description": "Nice Item Three", "price": 10.10, "category": "drinks", "timeToCook": 1000, "weight": 10.20, "imageUrl": "http://images.com/one.png", "ingredientCollection": {"ingredients": [{"name": "ingredient one", "calories": 10}, {"name": "ingredient two", "calories": 20}]}}'
printf "\n\n"


echo -e "\n*** Submitting requests to Orders Service ***\n"
ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=max' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d 'client_secret=z8DEMatUnmNTJkPk1ov8Cc8nXYzpLdaD' -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"

printf "\n\n"
curl -X POST http://localhost:9099/v1/menu-orders -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"nameToQuantity": {"One": 10, "Two": 20, "Three": 30 }, "address": { "city": "Moscow", "street": "Street", "house": 1, "apartment": 1}}'
printf "\n\n"

ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=michael' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d 'client_secret=z8DEMatUnmNTJkPk1ov8Cc8nXYzpLdaD' -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"

curl -X POST http://localhost:9099/v1/menu-orders -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"nameToQuantity": {"One": 5, "Two": 6, "Three": 7 }, "address": { "city": "Kaluga", "street": "Street", "house": 1, "apartment": 1}}'
printf "\n\n"

ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=john' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d 'client_secret=z8DEMatUnmNTJkPk1ov8Cc8nXYzpLdaD' -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"

curl -X POST http://localhost:9099/v1/menu-orders -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"nameToQuantity": {"One": 1, "Two": 2, "Three": 3 }, "address": { "city": "Samara", "street": "Street", "house": 1, "apartment": 1}}'
printf "\n\n"

ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=jane' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d 'client_secret=z8DEMatUnmNTJkPk1ov8Cc8nXYzpLdaD' -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"

curl -X POST http://localhost:9099/v1/menu-orders -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"nameToQuantity": {"One": 100, "Two": 200, "Three": 300 }, "address": { "city": "Rostov", "street": "Street", "house": 1, "apartment": 1}}'
printf "\n\n"

ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=kate' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d 'client_secret=z8DEMatUnmNTJkPk1ov8Cc8nXYzpLdaD' -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"

curl -X POST http://localhost:9099/v1/menu-orders -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"nameToQuantity": {"One": 100, "Two": 200, "Three": 300 }, "address": { "city": "Rostov", "street": "Street", "house": 1, "apartment": 1}}'
printf "\n\n"

echo -e "\n*** Submitting requests to Review Service ***\n"

ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=max' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d 'client_secret=z8DEMatUnmNTJkPk1ov8Cc8nXYzpLdaD' -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"

printf "\n\n"
curl -X POST http://localhost:9099/v1/reviews -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"menuId": 1, "comment": "Comment", "rate": 5}'
printf "\n\n"
curl -X POST http://localhost:9099/v1/reviews -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"menuId": 2, "comment": "Comment", "rate": 5}'
printf "\n\n"
curl -X POST http://localhost:9099/v1/reviews -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"menuId": 3, "comment": "Comment", "rate": 5}'
printf "\n\n"


ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=john' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d 'client_secret=z8DEMatUnmNTJkPk1ov8Cc8nXYzpLdaD' -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"

curl -X POST http://localhost:9099/v1/reviews -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"menuId": 1, "comment": "Comment", "rate": 5}'
printf "\n\n"

ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=michael' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d 'client_secret=z8DEMatUnmNTJkPk1ov8Cc8nXYzpLdaD' -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"

curl -X POST http://localhost:9099/v1/reviews -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"menuId": 1, "comment": "Comment", "rate": 3}'
printf "\n\n"

ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=jane' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d 'client_secret=z8DEMatUnmNTJkPk1ov8Cc8nXYzpLdaD' -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"

curl -X POST http://localhost:9099/v1/reviews -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"menuId": 1, "comment": "Comment", "rate": 2}'
printf "\n\n"

ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=kate' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d 'client_secret=z8DEMatUnmNTJkPk1ov8Cc8nXYzpLdaD' -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"

curl -X POST http://localhost:9099/v1/reviews -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"menuId": 1, "comment": "Comment", "rate": 2}'
printf "\n\n"

curl http://localhost:9099/v1/reviews/1
printf "\n\n"

curl "http://localhost:9099/v1/reviews/menu-item/1?from=0&size=10&sortBy=date_asc"
printf "\n\n"

ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=max' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d 'client_secret=z8DEMatUnmNTJkPk1ov8Cc8nXYzpLdaD' -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"

curl -H "$AUTH_HEADER" "http://localhost:9099/v1/reviews/my?from=0&size=10&sortBy=date_asc"
printf "\n\n"

curl -X POST http://localhost:9099/v1/reviews/ratings -H 'Content-Type: application/json' -d '{"menuIds": [1,2,3,4,5]}'
printf "\n\n"

echo -e "\n*** Submitting requests to Menu Aggregate Service ***\n"
printf "\n\n"

curl http://localhost:9099/v1/menu-aggregate/1
printf "\n\n"

curl "http://localhost:9099/v1/menu-aggregate?category=DRINKS"
printf "\n\n"

