#!/bin/bash

# Set Oracle Wallet Location (if needed)
export TNS_ADMIN=/home/opc/DevCoaching/wallet/pro

# Define colors
BLUE='\033[34m'
RED='\033[31m'
GREEN='\033[32m'
NC='\033[0m' # No color (reset)

echo -e "${BLUE}Connected to production database.${NC}"
echo -e "${BLUE}Listing current tables. It should be empty for this demo${NC}"
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
echo -e "${BLUE}We are ready to deploy database application version 1.0 base_release ${NC}"
echo ""

echo -e "${BLUE}Moving to the project directory: /home/opc/dbcicd/my_projects/sample ${NC}"
cd /home/opc/DevCoaching/my_projects/hr

echo -e "${BLUE}We will connect to the production database and deploy the artifact${NC}"
echo -e "${BLUE}We are running the script in the same compute, so we do not need to copy or download the artifact${NC}"
echo ""
echo -e "${GREEN}sql -name hr_pro${NC}"
echo -e "${RED}project deploy -file artifact/hr-1.0.zip -verbose${NC}"
echo ""
read -p "Press any key to execute..." -n 1 -s
echo ""

sql -name hr_pro <<EOF
SET SCAN OFF;
project deploy -file artifact/hr-1.0.zip -verbose
exit
EOF

echo -e "${RED}Listing the tables in the prodution database${NC}"
echo -e "${BLUE} and showing data populated from custom code${NC}"
echo ""

sql -name hr_pro <<EOF
tables;
select * from EMPLOYEES;
exit
EOF


echo -e "${RED}The initial application version is ready in production!!!${NC}"
echo ""
echo -e "${BLUE}Now, we can merge base-release branch into main${NC}"
echo -e "${BLUE}We will create a merge request and wait until it is approved or deleted${NC}"
echo ""
echo -e "${GREEN} gh pr create \${NC}"
echo -e "${GREEN}  --base main \${NC}"
echo -e "${GREEN}  --head base-release \${NC}"
echo -e "${GREEN}  --title 'Promote base-release to main' \${NC}"
echo -e "${GREEN}  --body 'Base-release deployed to production. This PR promotes it to main.'${NC}"
echo ""
read -p "Press any key to execute..." -n 1 -s
echo ""

gh pr create \
  --base main \
  --head base-release \
  --title "Promote base-release to main" \
  --body "Base-release deployed to production. This PR promotes it to main."

# Set your PR head branch name
PR_BRANCH="base-release"

# Get PR number based on the branch name
PR_NUMBER=$(gh pr list --head "$PR_BRANCH" --json number --jq '.[0].number')

echo "⏳ Waiting for PR #$PR_NUMBER to be merged or closed..."

while true; do
  STATUS=$(gh pr view "$PR_NUMBER" --json state --jq '.state') 
  if [[ "$STATUS" == "MERGED" ]]; then
    echo -e "${RED}Pull request #$PR_NUMBER has been merged!${NC}"
    echo ""
    echo -e "${BLUE} We need to sync our local main with the remote repository, and optinally we can delete local and remote base-release branches${NC}" 
    echo -e "${GREEN}   git checkout main${NC}"
    echo -e "${GREEN}   git pull origin main${NC}"
    echo -e "${BLUE}    Optional: Delete base-release branch${NC}"
    echo -e "${GREEN}   git branch -d base-release${NC}"
    echo -e "${GREEN}   git push origin --delete base-release${NC}"
    echo ""
    read -p "Press any key to execute..." -n 1 -s
    echo ""
    
    git checkout main
    git pull origin main

    # Delete local branch if it exists
    if git show-ref --quiet refs/heads/"$PR_BRANCH"; then
      git branch -d "$PR_BRANCH"
    fi

    # Delete remote branch
    git push origin --delete "$PR_BRANCH"
    echo -e "${BLUE} Our remote and local repository are up-to-date and we can continue working adding new functionality${NC}"
    break
  elif [[ "$STATUS" == "CLOSED" ]]; then
    echo -e "${RED} Pull request #$PR_NUMBER was closed without merging.${NC}"
    echo ""
    echo -e "${BLUE} Merge was not approved, so we clean up local branch${NC}"
    
    if git show-ref --quiet refs/heads/"$PR_BRANCH"; then
       git branch -d "$PR_BRANCH"
    fi

    echo -e "${RED} Main does not contais the base-release changes, so we can not continue the demo${RED}

    break
  else
    echo "⏳ PR #$PR_NUMBER is still open... checking again in 10 seconds."
    sleep 10
  fi
done

