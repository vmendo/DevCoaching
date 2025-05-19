#!/bin/bash

# Set Oracle Wallet Location (if needed)
export TNS_ADMIN=/home/opc/DevCoaching/wallet/pro

# Define colors
BLUE='\033[34m'
RED='\033[31m'
GREEN='\033[32m'
NC='\033[0m' # No color (reset)

echo -e "${BLUE}Connected to production database.${NC}"
echo -e "${BLUE}Listing current tables. We should have the initial data model, where employee_performance is not here${NC}"
echo ""
echo -e "${BLUE}Running ${GREEN}tables; ${BLUE}connected to the production database${NC}"
read -p "Press any key to check existing tables..." -n 1 -s
echo ""
echo ""

sql -name hr_pro <<EOF
tables;
exit
EOF

echo ""
echo -e "${BLUE}We are ready to deploy database application version 1.1 base_release ${NC}"
echo ""

echo -e "${BLUE}Moving to the project directory: /home/opc/dbcicd/my_projects/sample ${NC}"
cd /home/opc/DevCoaching/my_projects/hr

echo -e "${BLUE}We will connect to the production database and deploy the artifact${NC}"
echo -e "${BLUE}We are running the script in the same compute, so we do not need to copy or download the artifact${NC}"
echo ""
echo -e "${GREEN}sql -name hr_pro${NC}"
echo -e "${RED}project deploy -file artifact/hr-1.1.zip -verbose${NC}"
echo ""
read -p "Press any key to execute..." -n 1 -s
echo ""

sql -name hr_pro <<EOF
SET SCAN OFF;
project deploy -file artifact/hr-1.1.zip -verbose
exit
EOF

echo -e "${RED}Listing the tables in the prodution database${NC}"
echo -e "${BLUE} and showing data populated from custom code${NC}"
echo ""

sql -name hr_pro <<EOF
tables;
exit
EOF


echo -e "${RED}Salay Increase functionality has been added to  production!!!${NC}"
    
git checkout main
git pull origin main


