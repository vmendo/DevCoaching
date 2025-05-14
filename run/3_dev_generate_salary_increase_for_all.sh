#!/bin/bash

# Set Oracle Wallet Location (if needed)
export TNS_ADMIN=/home/opc/DevCoaching/wallet/dev

# Define colors
BLUE='\033[34m'
RED='\033[31m'
GREEN='\033[32m'
NC='\033[0m' # No color (reset)

cd /home/opc/DevCoaching/my_projects/hr
echo -e "${BLUE}🆕💼 Now we are starting a new feature request: Our manager has asked us to create a procedure that 📈 increases salaries${NC}" 
echo -e "${BLUE} for employees who haven't received a salary review in the past 2 years.${NC}"

echo ""
echo -e "${GREEN}Create a function that:${NC}"
echo -e "${GREEN}  Raise salary a 5% to employees have not had a salary revision in the last two years.  ${NC}"
echo -e "${GREEN}----------------------------------------------------------${NC}"
echo -e "${BLUE}We will need: ${NC}"
echo -e "${BLUE}   1-. Create a new branch ${NC}"
echo -e "${BLUE}   2-. Create the salary_increase function, the trigger and the employee_performance table in the database${NC}"
echo -e "${BLUE}   3-. Use SQLcl project to promote the changes ${NC}"
echo ""
echo -e "${GREEN}----------------------------------------------------------${NC}"
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
git checkout -b salary-increase


echo ""
echo -e "${BLUE}   2-. We will create the salary_increase function using our favorite database tool${NC}"
echo -e "${BLUE}       I will use database actions in the OCI console.${NC}"
read -p "Press any key to continue when ready..." -n 1 -s
echo ""
read -p "Press any key to confirm that the function has been created and tested.." -n 1 -s

echo ""
echo -e "${BLUE}    3-. Generate the source code and push it to the code repository${NC}"
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
echo -e "${BLUE}       No more changes could be added to this version now, so we are ready to push them to the remote code repository and create the merge request${NC}"
echo -e "${GREEN}           git push origin salary-increase${NC}"
echo -e "${GREEN}           gh pr create \ ${NC}"
echo -e "${GREEN}            --base main \ ${NC}"
echo -e "${GREEN}            --head salary-increase \ ${NC}"
echo -e "${GREEN}            --title 'salary increase for any employee without any salary revision for two years (v1.1)' \${NC}"
echo -e "${GREEN}            --body 'Implements salary raise for employees with no salary review in 2 years'${NC}"
echo ""
read -p "Press any key to continue..." -n 1 -s
echo ""

git push origin salary-increase
gh pr create \
  --base main \
  --head salary-increase \
  --title "salary increase by performance (v1.1)" \
  --body "Implements salary raise for employees with no salary review in 2 years"


echo ""
read -p "Press any key to continue..." -n 1 -s
echo ""

echo -e "${BLUE}        We will wait for our branch to be merged or closed${NC}"
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
    echo -e "${GREEN}    gh release create v1.0 artifact/hr-1.1.zip --title 'Version 1.1' --notes 'Salary increase func included'${NC}"
    echo ""
    read -p "Press any key to continue..." -n 1 -s

    gh release create v1.0 artifact/hr-1.1.zip --title "Version 1.1" --notes "Salary increase func included"

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




