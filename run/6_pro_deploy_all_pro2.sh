#!/bin/bash

# Set Oracle Wallet Location (if needed)
export TNS_ADMIN=/home/opc/DevCoaching/wallet/pro2

# Define colors
BLUE='\033[34m'
RED='\033[31m'
GREEN='\033[32m'
NC='\033[0m' # No color (reset)

echo -e "${BLUE}?~_~T~P Connected to the a new region production database.${NC}"
echo -e "${BLUE}?~_~S~K Listing current tables ?~@~T it should be empty for this demo.${NC}"echo ""
echo -e "${BLUE}Running ${GREEN}tables; ${BLUE}connected to production database 2!${NC}"
read -p "Press any key to check existing tables..." -n 1 -s
echo ""
echo ""

sql -name hr_pro2 <<EOF
tables;
exit
EOF

echo ""
echo -e "${BLUE}🚀 Ready to deploy database application version ${GREEN}1.1${BLUE}, which includes:${NC}"
echo -e "${BLUE}   📦 Base Release${NC}"
echo -e "${BLUE}   💰 Salary Increase Feature${NC}"
echo ""

cd /home/opc/DevCoaching/my_projects/hr

echo -e "${BLUE}?~_~T~W Connecting to the production database and deploying the artifact...${NC}"
echo -e "${BLUE}?~_~S? Since we?~@~Yre running this script on the same compute node, there?~@~Ys no need to copy or download the artifact.${NC}"
echo ""
echo -e "${GREEN}sql -name hr_pro2${NC}"
echo -e "${RED}project deploy -file artifact/hr-1.1.zip -verbose${NC}"
echo ""
read -p "Press any key to execute..." -n 1 -s
echo ""

sql -name hr_pro2 <<EOF
SET SCAN OFF;
project deploy -file artifact/hr-1.1.zip -verbose
exit
EOF

echo -e "${RED}?~_~S~K Verifying deployment: listing tables in the region two production database...${NC}"
echo ""

sql -name hr_pro <<EOF
tables;
exit
EOF

echo -e "${RED}?~\~E Database Application version 1.1 has been successfully deployed to region two production database! ?~_~N~I${NC}"
    

