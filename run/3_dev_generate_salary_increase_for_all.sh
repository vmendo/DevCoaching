#!/bin/bash

source "$(dirname "$0")/0_setup_env.sh"

# Set Oracle Wallet Location
export TNS_ADMIN="$DEMO_HOME/wallet/dev"

# Define colors
BLUE='\033[34m'
RED='\033[31m'
GREEN='\033[32m'
NC='\033[0m' # No color (reset)

cd $DEMO_HOME/my_projects/hr
echo -e "${BLUE}🆕💼 Now we are starting a new feature request: Our manager has asked us to create a procedure that 📈 increases salaries${NC}" 
echo -e "${BLUE} for employees who haven't received a salary review in the past 2 years.${NC}"

echo ""
echo -e "${BLUE}🧠  Goal: Create a procedure that...${NC}"
echo -e "${BLUE}📈  Raises salary by 5% for employees who have not had a salary review in the last 2 years.${NC}"
echo -e "${GREEN}----------------------------------------------------------${NC}"

echo -e "${BLUE}🛠️  Steps required: ${NC}"
echo -e "${BLUE}   1️⃣  Create a new Git branch for this feature${NC}"
echo -e "${BLUE}   2️⃣  Implement changes in the database:Create the procedure${NC}"
echo -e "${BLUE}   3️⃣  Use SQcl project commands to stage and promote the changes${NC}"
echo -e "${GREEN}----------------------------------------------------------${NC}"
echo ""
echo -e "${GREEN}      git checkout main${NC}"
echo -e "${GREEN}      git pull origin main${NC}"
echo -e "${GREEN}      git checkout -b salary-increase${NC}"
echo ""
read -p "Press any key to execute..." -n 1 -s
echo ""

git checkout main
git pull origin main
git checkout -b salary-increase


echo ""
echo -e "${BLUE}🧾 Step 2: We will now create the ${GREEN}salary_increase${BLUE} function using your preferred database tool.${NC}"
read -p "🟢 Press any key to continue when ready..." -n 1 -s
echo ""
read -p "✅ Press any key to confirm that the function has been created and tested..." -n 1 -s
echo ""
echo -e "${BLUE}📤 Step 3: Generate the source code and push it to the GitHub repository.${NC}"
echo ""
echo -e "${RED}          project export${NC}"
echo -e "${GREEN}         git add src${NC}"
echo -e "${GREEN}         git commit -m 'feat: pay rise for employees without any salary revision for two years'${NC}"
echo ""
read -p "Press any key to continue..." -n 1 -s
echo ""

sql -name hr_dev <<EOF
project export
exit
EOF

git add src
git commit -m "feat: pay rise for employees without revision for two years"
tree 

read -p "Press any key to continue..." -n 1 -s
echo ""

echo -e "${BLUE}⏳ Before generating changelogs and the artifact, we need approval from the project manager.${NC}"
echo -e "${BLUE}📤 We’ll push our branch to the remote repository and open a merge request for review.${NC}"
echo -e "${GREEN}           git push origin salary-increase${NC}"
echo -e "${GREEN}           gh pr create \ ${NC}"
echo -e "${GREEN}            --base main \ ${NC}"
echo -e "${GREEN}            --head salary-increase \ ${NC}"
echo -e "${GREEN}            --title 'salary increase (v1.1)' \${NC}"
echo -e "${GREEN}            --body 'Implements salary raise for employees with no salary review in 2 years.'${NC}"
echo ""
read -p "Press any key to continue..." -n 1 -s
echo ""

git push origin salary-increase
gh pr create \
  --base main \
  --head salary-increase \
  --title "salary increase (v1.1)" \
  --body "Implements salary raise for employees with no salary review in 2 years"


echo ""
read -p "Press any key to continue..." -n 1 -s
echo ""

echo -e "${BLUE}🔁 Waiting for the merge request to be ${GREEN}approved and merged${BLUE}, or ${RED}closed without merging${BLUE}.${NC}"
echo ""

# Get PR number
PR_NUMBER=$(gh pr list --head salary-increase --json number --jq '.[0].number')

if [[ -z "$PR_NUMBER" ]]; then
  echo -e "${RED} No pull request created. Exiting.${NC}"
  exit 1
fi

echo " Waiting for PR #$PR_NUMBER to be merged or closed..."

# Wait loop
while true; do
  STATUS=$(gh pr view "$PR_NUMBER" --json state --jq '.state')
  if [[ "$STATUS" == "MERGED" ]]; then
    echo -e "${RED}✅ Pull request #$PR_NUMBER has been merged!${NC}"
    echo ""
    echo -e "${BLUE}📦 Proceeding to generate the changelogs, close the release, and create the artifact for deployment.${NC}"
    echo -e "${RED}    sql -name hr_dev ${NC}"
    echo -e "${RED}    project stage -verbose${NC}"
    echo -e "${RED}    project release -version 1.1 -verbose${NC}"
    echo -e "${RED}    project gen-artifact -name hr -version 1.1 -format zip -verbose${NC}"
    echo ""
    read -p "Press any key to continue..." -n 1 -s
    
    sql -name hr_dev<<EOF
project stage -verbose
project release -version 1.1 -verbose
project gen-artifact -name hr -version 1.1 -format zip -verbose
exit
EOF
    tree
    echo ""
    echo -e "${BLUE}🏷️  A new release ${GREEN}(v1.1)${BLUE} has been successfully created.${NC}"
    echo -e "${BLUE}📌 This stage includes only the changes introduced in this branch compared to ${GREEN}main${BLUE}.${NC}"
    echo -e "${BLUE}📦 The v1.1 artifact can be used to either: ${NC}"
    echo -e "${BLUE}   🔁 Upgrade from version 1.0 to 1.1, or${NC}"
    echo -e "${BLUE}   🆕 Deploy the full database application from scratch.${NC}"
    echo ""
    echo -e "${BLUE}🚀 Storing the generated artifact as a GitHub Release Asset...${NC}"
    echo -e "${GREEN}    gh release create v1.1 artifact/hr-1.1.zip --title 'Version 1.1' --notes 'Salary increase func included'${NC}"
    echo ""
    read -p "Press any key to continue..." -n 1 -s

    gh release create v1.1 artifact/hr-1.1.zip --title "Version 1.1" --notes "Salary increase func included"

    break
  elif [[ "$STATUS" == "CLOSED" ]]; then
    echo -e "${RED}❌ Pull request #$PR_NUMBER has been closed without merging.${NC}"
    echo ""
    echo -e "${BLUE}⚠️  The changes in this branch were not approved.${NC}"
    echo -e "${BLUE}⛔ This is the expected behaviour as our branch does not match the salary increase requirementes based in performance.${NC}"

    break
  else
    echo "Still open... waiting 10 seconds..."
    sleep 10
  fi
done


echo -e "${BLUE}🔄 Syncing the local repository with the remote to reflect the latest changes...${NC}"
echo -e "${BLUE}🌿 Then, we will delete the ${GREEN}salary-increase${BLUE} branch locally and remotely to keep the workspace clean.${NC}"
echo ""
echo -e "${GREEN}      git checkout main${NC}"
echo -e "${GREEN}      git pull origin main${NC}"
echo -e "${GREEN}      git branch -d salary-increase${NC}"
echo ""
read -p "Press any key to execute..." -n 1 -s
echo ""

# Sync local main
git checkout main
git pull origin main

# Optional: clean up local branch
git branch -d salary-increase 2>/dev/null

echo -e "${BLUE}      Exiting the demo!!!${NC}"




