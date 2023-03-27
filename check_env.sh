#! /bin/bash

#------Colors--------
RED='\033[1;31m'
EOC='\033[0;0m'
GREEN='\033[1;32m'
#====================

if  [ ! -f ./srcs/.env ]; then
    echo -e "${RED}'.env' file is not existing, please edit "./srcs/env_to_edit" with desired credentials and rename it to '.env'${EOC}"
    exit 1
else
    echo -e "${GREEN}'.env' file is existing${EOC}"
fi
