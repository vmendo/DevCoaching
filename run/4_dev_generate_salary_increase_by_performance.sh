#!/bin/bash

# Set Oracle Wallet Location (if needed)
export TNS_ADMIN=/home/opc/DevCoaching/wallet/dev

# Define colors
BLUE='\033[34m'
RED='\033[31m'
GREEN='\033[32m'
NC='\033[0m' # No color (reset)

cd /home/opc/DevCoaching/my_projects/hr
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
echo -e "${BLUE}   2-. We will create the employee_perfromance table and the salary_increase procedure using our favorite database tool and test it ${NC}"
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

sql -name hr_dev <<EOF
project export
exit
EOF

git add src
git commit -m "feat: pay rise for employees by performance but only those without revision for two years"
tree 

read -p "Press any key to continue..." -n 1 -s
echo ""

echo -e "${BLUE}        We will generate the changelogs and close the release before push the changes to the remote code repository${NC}"
echo -e "${BLUE}        so no more changes will be alowed in this version we are workin on.${NC}"
echo -e "${BLUE}        But we must wait until our changes are approved to create the artifact${NC}"
echo ""
echo -e "${RED}          project stage -verbose${NC}"
echo -e "${RED}          project release -version 1.0 -verbose${NC}"
echo ""
read -p "Press any key to continue..." -n 1 -s
echo ""

sql -name hr_dev <<EOF
project stage -verbose
project release -version 1.1 -verbose
exit
EOF
tree

read -p "Press any key to continue..." -n 1 -s
echo ""

echo ""
echo -e "${BLUE}       No more changes could be added to this version, so we are ready to push them to the remote code repository and create the merge request${NC}"
echo -e "${GREEN}           git push origin salary-increase-by-performance${NC}"
echo -e "${GREEN}           gh pr create \ ${NC}"
echo -e "${GREEN}            --base main \ ${NC}"
echo -e "${GREEN}            --head dev-salary-by-performance \ ${NC}"
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

echo -e "${BLUE}        We will wait for our branch to be merged or closed${NC}"
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
    echo -e "${RED} Pull request #$PR_NUMBER has been merged!${NC}"
    echo ""
    echo -e "${BLUE}Now, we can create the artifact for this version${NC}"
    echo -e "${RED}    project gen-artifact -name hr -version 1.1 -format zip -verbose${NC}"
    echo ""
    read -p "Press any key to continue..." -n 1 -s
    
    sql -name hr_dev<<EOF
project gen-artifact -name hr -version 1.1 -format zip -verbose
exit
EOF
    tree
    echo ""
    echo -e "${BLUE}We will store the artifact as a GitHub Release Asset${NC}"
    echo -e "${GREEN}    gh release create v1.1 artifact/hr-1.1.zip --title 'Version 1.1' --notes 'Salary increase func included'${NC}"
    echo ""
    read -p "Press any key to continue..." -n 1 -s

    gh release create v1.1 artifact/hr-1.1.zip --title "Version 1.1" --notes "Salary increase func included"

    break
  elif [[ "$STATUS" == "CLOSED" ]]; then
    echo -e "${RED} Pull request #$PR_NUMBER was closed without merging.${NC}"
    break
  else
    echo "Still open... waiting 10 seconds..."
    sleep 10
  fi
done


echo -e "${BLUE}       We sync our local repository with the remote one again${NC}"
echo -e "${BLUE}       and delete the salary-increase branch${NC}"
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




