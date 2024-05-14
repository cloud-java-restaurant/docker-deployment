```shell
./kc.sh export --dir /tmp/export --users realm_file

docker cp keycloak:/tmp/export/cloud-java-realm.json /home/user/Desktop
```

Set alias to keycloak localhost:
1. Windows: C:\Windows\System32\drivers\etc\hosts
2. UNIX: /etc/hosts 