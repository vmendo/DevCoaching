#!/bin/bash

# Set Oracle Wallet Location (if needed)
export TNS_ADMIN=/home/oracle/DevCoaching/wallet/dev2

# Define colors
BLUE='\033[34m'
RED='\033[31m'
GREEN='\033[32m'
NC='\033[0m' # No color (reset)

cd /home/oracle/DevCoaching/my_projects/hr
echo -e "${BLUE}🗣️🚪 During a quick elevator chat, our manager added a detail he forgot: the salary increase should depend on employee performance.${NC}"
echo -e "${BLUE}?🧠📊 So now we need to create an evaluation process, and only employees rated above 3 out of 5${NC}"
echo -e "${BLUE}?— and without a salary review in the last 2 years${NC}"
echo -e "${BLUE}?— will receive the raise.${NC}"
echo ""
echo ""
echo -e "${GREEN}Create a database table to support the employee evaluation.${NC}"
echo -e "${GREEN}Create a function that:${NC}"
echo -e "${GREEN}  Raise salary a 5% to employees with performance rate = 4 ${NC}"
echo -e "${GREEN}  Raise salary a 10% to employees with performance rate = 5 ${NC}"
echo -e "${GREEN}    but only if they have not had a salary revision in the last two years. ${NC}"
echo -e "${GREEN}----------------------------------------------------------${NC}"
echo ""
echo -e "${BLUE}We will need: ${NC}"
echo -e "${BLUE}   1-. Create a new branch ${NC}"
echo -e "${BLUE}   2-. Create the employee_performance table and the salary_increase function${NC}"
echo -e "${BLUE}   3-. Use SQLcl project to promote the changes ${NC}"
echo ""
echo -e "${BLUE}   1-. Create a new branch ${NC}"
echo -e "${BLUE}       We will sync our local repository with the remote one first${NC}"
echo -e "${BLUE}       and then we will crease the salary-increase branch${NC}"
echo ""
echo -e "${GREEN}      git checkout main${NC}"
echo -e "${GREEN}      git pull origin main${NC}"
echo -e "${GREEN}      git checkout -b salary-increase${NC}"
echo ""
read -p "Press any key to execute..." -n 1 -s
echo ""

git checkout main
git pull origin main
git checkout -b salary-increase-by-performance


echo ""
echo -e "${BLUE}   2-. We will create the employee_performance table and the salary_increase procedure using our favorite database tool and test it ${NC}"
read -p "Press any key to continue when ready..." -n 1 -s
echo ""
read -p "Press any key to confirm that table and function have been created..." -n 1 -s

echo ""
echo -e "${BLUE}        Generate the source code and push it to the code repository${NC}"
echo ""
echo -e "${RED}          project export${NC}"
echo -e "${GREEN}         git add src${NC}"
echo -e "${GREEN}         git commit -m 'feat: pay rise for employees by performance but only those without revision for two years'${NC}"
echo ""
read -p "Press any key to continue..." -n 1 -s
echo ""

sql -name hr_dev2 <<EOF
project export
exit
EOF

git add src
git commit -m "feat: pay rise for employees by performance but only those without revision for two years"
tree 

read -p "Press any key to continue..." -n 1 -s
echo ""

echo ""

echo -e "${BLUE}⏳ Before generating changelogs and the artifact, we need approval from the project manager.${NC}"
echo -e "${BLUE}📤 We’ll push our branch to the remote repository and open a merge request for review.${NC}"
echo -e "${GREEN}           git push origin salary-increase-by-performance${NC}"
echo -e "${GREEN}           gh pr create \ ${NC}"
echo -e "${GREEN}            --base main \ ${NC}"
echo -e "${GREEN}            --head salary-increase-by-performance \ ${NC}"
echo -e "${GREEN}            --title 'salary increase by performance (v1.1)' \${NC}"
echo -e "${GREEN}            --body 'Implements salary raise for employees with no salary review in 2 years and considering performance in the last year.'${NC}"
echo ""
read -p "Press any key to continue..." -n 1 -s
echo ""

git push origin salary-increase-by-performance
gh pr create \
  --base main \
  --head salary-increase-by-performance \
  --title "salary increase by performance (v1.1)" \
  --body "Implements salary raise for employees with no salary review in 2 years and considering performance in the last year."


echo ""
read -p "Press any key to continue..." -n 1 -s
echo ""

echo -e "${BLUE}🔁 Waiting for the merge request to be ${GREEN}approved and merged${BLUE}, or ${RED}closed without merging${BLUE}.${NC}"
echo ""

# Get PR number
PR_NUMBER=$(gh pr list --head salary-increase-by-performance --json number --jq '.[0].number')

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
    echo -e "${RED}    sql -name hr_dev2 ${NC}"
    echo -e "${RED}    project stage -verbose${NC}"
    echo -e "${RED}    project release -version 1.1 -verbose${NC}"
    echo -e "${RED}    project gen-artifact -name hr -version 1.1 -format zip -verbose${NC}"
    echo ""
    read -p "Press any key to continue..." -n 1 -s

    sql -name hr_dev2<<EOF
project stage -verbose
project release -version 1.1 -verbose
project gen-artifact -name hr -version 1.1 -format zip -verbose
exit
EOF
    tree
    echo ""
    echo -e "${BLUE}?~_~O??~O  A new release ${GREEN}(v1.1)${BLUE} has been successfully created.${NC}"
    echo -e "${BLUE}?~_~S~L This stage includes only the changes introduced in this branch compared to ${GREEN}main${BLUE}.${NC}"
    echo -e "${BLUE}?~_~S? The v1.1 artifact can be used to either: ${NC}"
    echo -e "${BLUE}   ?~_~T~A Upgrade from version 1.0 to 1.1, or${NC}"
    echo -e "${BLUE}   ?~_~F~U Deploy the full database application from scratch.${NC}"echo ""
    echo ""
    echo -e "${BLUE}🚀 Storing the generated artifact as a GitHub Release Asset...${NC}"
    echo -e "${GREEN}    gh release create v1.1 artifact/hr-1.1.zip --title 'Version 1.1' --notes 'Salary increase by performance func included'${NC}"
    echo ""
    read -p "Press any key to continue..." -n 1 -s

    gh release create v1.1 artifact/hr-1.1.zip --title "Version 1.1" --notes "Salary increase by performance func included"

    break
  elif [[ "$STATUS" == "CLOSED" ]]; then
    echo -e "${RED}❌ Pull request #$PR_NUMBER has been closed without merging.${NC}"
    echo ""
    echo -e "${BLUE}⚠️  The changes in this branch were not approved.${NC}"
    echo -e "${BLUE}⛔ Demo flow will stop here, as the correct version ${GREEN}v1.1${BLUE} was not promoted to main.${NC}"
    break
  else
    echo "Still open... waiting 10 seconds..."
    sleep 10
  fi
done


echo -e "${BLUE}🔄 Syncing the local repository with the remote to reflect the latest changes...${NC}"
echo -e "${BLUE}🌿 Then, we will delete the ${GREEN}salary-increase-by-performance${BLUE} branch locally and remotely to keep the workspace clean.${NC}"
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




