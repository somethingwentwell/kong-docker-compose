# kong_postgres

Deploys Kong EE DB mode with Postgresql.

## How to use

1. Just run `docker-compose up -d`

## Additional feature

### Enabling RBAC

RBAC for Admin API and Kong Manager.

1. Comment out these environment variables in `docker-compose-yml`

```
- KONG_ENFORCE_RBAC=on
- KONG_ADMIN_GUI_AUTH=basic-auth
- KONG_ADMIN_GUI_SESSION_CONF={"secret":"secret","storage":"kong","cookie_secure":false}
```
2. Redeploy again with `docker-compose up -d`
