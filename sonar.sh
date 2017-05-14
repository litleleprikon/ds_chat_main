#!/bin/bash

YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

printf "${YELLOW}Cheking code Sonar${NC}\n"
ssh a_abdulmadzhidov@35.190.169.10 << EOF
rm -rf ds_chat
git clone https://github.com/mrZizik/ds_chat
cd ds_chat
/etc/sonarscan/bin/sonar-scanner
printf "Cheking: [${GREEN}OK${NC}]\n"