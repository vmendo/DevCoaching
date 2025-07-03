#!/bin/bash

source "$(dirname "$0")/0_setup_env.sh"

# Set Oracle Wallet Location
export TNS_ADMIN="$DEMO_HOME/wallet/pro"

# Define colors
BLUE='\033[34m'
RED='\033[31m'
GREEN='\033[32m'
NC='\033[0m' # No color (reset)

echo -e "${BLUE}🔐 Connected to production database.${NC}"
echo -e "${BLUE}📋 Listing current tables. We should have the initial data model, where employee_performance is not here${NC}"
echo ""
echo -e "${BLUE}📂 Running ${GREEN}tables; ${BLUE}connected to the production database${NC}"
read -p "Press any key to check existing tables..." -n 1 -s
echo ""
echo ""

sql -name hr_pro <<EOF
tables;
exit
EOF

echo ""
echo -e "${BLUE}🚀 We are ready to deploy database application version 1.1 base_release ${NC}"
echo ""

echo -e "${BLUE}📁 Moving to the project directory: $DEMO_HOME/my_projects/sample ${NC}"
cd $DEMO_HOME/my_projects/hr

# Check and download artifact if not present
if [ ! -f "artifact/hr-1.1.zip" ]; then
  echo -e "${BLUE}📦 Artifact hr-1.1.zip not found. Downloading from GitHub release...${NC}"
  cd artifact
  gh release download v1.1 --pattern "hr-1.1.zip" --dir .
  cd ..
else
  echo -e "${GREEN}✅ Artifact hr-1.1.zip already exists. Skipping download.${NC}"
fi

echo -e "${BLUE}🔐 Connecting to the production database and deploying database application version 1.1.${NC}"
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

echo -e "${RED}📋 Verifying deployment: listing tables in the production database...${NC}"
echo ""

sql -name hr_pro <<EOF
tables;
exit
EOF


echo -e "${RED}✅ Salay Increase functionality has been successfully deployed to production! 🎉${NC}"
    
git checkout main
git pull origin main


