```shell
./kc.sh export --dir /tmp/export --users realm_file

docker cp keycloak:/tmp/export/cloud-java-realm.json /home/user/Desktop
```

Set alias to keycloak localhost:
1. Windows: C:\Windows\System32\drivers\etc\hosts
2. UNIX: /etc/hosts 

## Прописать зеркала для образов Docker

## Fix Docker mirror on linux
```shell
sudo sh -c 'echo "{"registry-mirrors": ["https://mirror.gcr.io"]}" > /etc/docker/daemon.json'
```
## Fix Docker mirror on Mac
1. Перейти в директорию /Users/USER_FOLDER/.docker где USER_FOLDER - папка текущего пользователя
2. Открыть файл daemon.json или создать его
3. Добавить в файл (если он был ранее)
```json
"registry-mirrors": ["https://mirror.gcr.io"]
```
Если файл только что создан:
```json
{"registry-mirrors": ["https://mirror.gcr.io"]}
```
4. Перезапустить Docker Daemon


# Grafana Dashboards:

- https://github.com/spring-cloud/spring-cloud-gateway/blob/main/docs/src/main/asciidoc/gateway-grafana-dashboard.json
- https://github.com/resilience4j/resilience4j/blob/master/grafana_dashboard.json
- https://grafana.com/grafana/dashboards/17175-spring-boot-observability/