# kong_dbless

Deploys Kong EE DB less

This deployment will deploy Kong in Dbless mode with `kong.yml` declarative config in the root dir loaded

## How to use

1. Just run `docker-compose up -d`

## Additional feature

### Readonly Admin API and Kong Manager

Comment out `KONG_ADMIN_LISTEN` and `KONG_ADMIN_GUI_LISTEN` to enable Admin API and Kong Manager.
As this is running in dbless mode, it only available in read-only mode.

