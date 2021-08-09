# Kong Docker Compose Reference

Docker compose file collection for various Kong usecase.

# Requirements

- Docker
- Docker Compose 

# How to use

1. Setup environment variables for `KONG_IMAGE`, `KONG_LICENSE_DATA`, `DEPLOYMENT`

```
export KONG_IMAGE=kong/kong-gateway:2.4.1.1-alpine
export KONG_LICENSE_DATA=`cat ./license.json`

```
or you can just use the `env` file to initialize
```
./env
```


## Deployment description

Available DEPLOYMENT options


| Deployment Name        | Description           |
| ------------- |-------------|
|`kong_postgres`|Kong DB mode with Postgres|
|`kong_cassandra`|Kong DB mode with Single node Cassandra|
|`kong_dbless`|Kong DBless mode|

---

### Additional Notes

#### Extending and overriding Docker compose.

Each Docker Compose file in the `deployments` folder extending the Docker Compose file in `base` folder.

For example:
In `kong_postgres`, for `kong-ent` service you can see it's extending the `kong-ent` service from `kong.base.yml` in `base` folder. You can override any environment variables or any docker compose options, by editing the `docker-compose.yml` file in the `kong_postgres`/ 

```
$ cat ./deployments/kong_postgres/docker-compose.yml
		**
 kong-ent:
  extends:
   file: ../../base/docker-compose.base.yml
   service: kong-ent
		**

$ cat ./base/kong.base.yml
		**
 kong-ent:
   image: ${KONG_IMAGE} #  
   networks:
    - kong
   restart: always
   command: "kong start --run-migrations" 
   volumes:
    - ../cert:/tmp/cert
   environment:
#   - KONG_ENFORCE_RBAC=on
#   - KONG_ADMIN_GUI_AUTH=basic-auth
#   - KONG_ADMIN_GUI_SESSION_CONF={"secret":"secret","storage":"kong","cookie_secure":false}
    - KONG_PASSWORD=admin
    - KONG_AUDIT_LOG=on
    - KONG_LOG_LEVEL=debug 
    - KONG_PORTAL_GUI_PROTOCOL=http
    - KONG_PORTAL=on
    - KONG_PORTAL_AUTH=basic-auth
    - KONG_LICENSE_DATA=${KONG_LICENSE_DATA}
    - KONG_VITALS=on
    - KONG_PROXY_ACCESS_LOG=/dev/stdout
    - KONG_ADMIN_ACCESS_LOG=/dev/stdout
    - KONG_PROXY_ERROR_LOG=/dev/stderr
    - KONG_ADMIN_ERROR_LOG=/dev/stderr
    - KONG_PROXY_LISTEN=0.0.0.0:8000, 0.0.0.0:8443 ssl
    - KONG_STATUS_LISTEN=0.0.0.0:8100
    - KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl
    - KONG_ADMIN_GUI_LISTEN=0.0.0.0:8002, 0.0.0.0:8445 ssl
    - KONG_PORTAL_GUI_LISTEN=0.0.0.0:8003, 0.0.0.0:8446 ssl
    - KONG_PORTAL_SESSION_CONF={"storage":"kong","cookie_name":"portal_session","secret":"super-secret","cookie_secure":false}
    - KONG_PORTAL_API_LISTEN=0.0.0.0:8004, 0.0.0.0:8447 ssl
		**

```