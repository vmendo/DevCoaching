#!/bin/bash

# Set DEMO_HOME to avoid full path 
# export DEMO_HOME="$(cd "$(dirname "$0")/.." && pwd)"

source "$(dirname "$0")/0_setup_env.sh"


echo "DEMO_HOME: $DEMO_HOME"
echo "GITHUB_URL: $GITHUB_URL"

# Set Oracle Wallet Location
export TNS_ADMIN="$DEMO_HOME/wallet/dev"

# THIS SCRIPT IS FOR DEMO PROPOSALS SO IT CONTAINS COMMENTS FOR EACH STEP
# We will set some colors for comments
# Define colors
BLUE='\033[34m'
RED='\033[31m'
GREEN='\033[32m'
NC='\033[0m' # No color (reset)

echo -e "${BLUE}📁 Moving to the project directory: $DEMO_HOME/my_projects${NC}"
cd $DEMO_HOME/my_projects/

echo ""
read -p "Press any key to continue..." -n 1 -s
echo ""

echo -e "${BLUE}🛠️ Step N: Adding custom code to setup user production.${NC}"
echo -e "${RED}    project stage add-custom -file-name project_custom_pre.sql${NC}"
echo ""
read -p "Press any key to execute..."  -n 1 -s
echo ""

TARGET_DIR="$DEMO_HOME/my_projects/hr/dist/releases/next/changes/base-release/_custom"

sql -name sys_conn  <<EOF
@$DEMO_HOME/run/environments/create_alias_get_user.sql
BEGIN
dbms_metadata.set_transform_param(
        dbms_metadata.session_transform,
        'SQLTERMINATOR',TRUE);
END;
/


project stage add-custom -file-name project_custom_pre.sql

SET long 1000
SPOOL $TARGET_DIR/project_custom_pre.sql APPEND
user HR_DEV
SPOOL OFF
exit
EOF
tree