
#!/bin/bash

#Set KONG_IMAGE variable with link of Kong EE Docker image


docker-compose -f deployments/$DEPLOYMENT/docker-compose.yml down --remove-orphans



