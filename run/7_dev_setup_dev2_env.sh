#!/bin/bash

# ============================================
#     Developer 2 Environment Setup Script
# ============================================

# Define variables
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT_DIR="${BASE_DIR}/my_projects/hr"
WALLET_DIR="${BASE_DIR}/wallet/dev2"
REPO_URL="git@github.com:vmendo/my_hr_demo.git"
ARTIFACT_NAME="hr-1.0.zip"
DB_CONN_ALIAS="hr_dev2"

# Define colors
BLUE='\033[34m'
GREEN='\033[32m'
RED='\033[31m'
NC='\033[0m'

echo -e "${BLUE}🚀 Starting Developer 2 setup...${NC}"

# Ensure base directories exist
cd "${BASE_DIR}/my_projects"

echo -e "${BLUE}📦 Cloning the project repository into hr folder...${NC}"
git clone "$REPO_URL" hr

if [[ $? -eq 0 ]]; then
    echo -e "${GREEN}✅ Repository cloned successfully into ${PROJECT_DIR}${NC}"
else
    echo -e "${RED}❌ Failed to clone repository.${NC}"
    exit 1
fi

cd hr

echo -e "${BLUE}📥 Downloading artifact ${ARTIFACT_NAME} from GitHub release...${NC}"
gh release download v1.0 --pattern "$ARTIFACT_NAME" --dir .

if [[ $? -eq 0 ]]; then
    echo -e "${GREEN}✅ Artifact downloaded successfully.${NC}"
else
    echo -e "${RED}❌ Failed to download artifact.${NC}"
    exit 1
fi

echo -e "${BLUE}🔗 Setting up wallet for dev2 connection...${NC}"
export TNS_ADMIN="$WALLET_DIR"

echo -e "${BLUE}📤 Deploying artifact to Developer 2 database using SQLcl project...${NC}"

sql -name "$DB_CONN_ALIAS" <<EOF
SET SCAN OFF;
project deploy -file artifact/hr-1.0.zip -verbose
exit
EOF


echo -e "${GREEN}🎉 Developer 2 environment is now ready with base release v1.0 deployed!${NC}"

