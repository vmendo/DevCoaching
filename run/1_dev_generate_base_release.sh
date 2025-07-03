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

# Check if the project folder already exists
if [ -d "../my_projects/hr" ]; then
    echo -e "${RED}ERROR: The folder $DEMO_HOME/my_projects/hr already exists!${NC}"
    echo -e "${RED}Please remove it manually, and run the script again ${NC}"
    exit 1
fi

echo -e "${BLUE}📁 Moving to the project directory: $DEMO_HOME/my_projects${NC}"
cd $DEMO_HOME/my_projects/

echo -e "${BLUE}⚙️  Initializing the project...${NC}"
echo -e "${GREEN}sql /nolog${NC}"
echo -e "${RED}project init -name hr -schemas HR -makeroot${NC}"
echo ""
read -p "Press any key to execute..." -n 1 -s
echo ""

sql /nolog <<EOF
project init -name hr -schemas HR -makeroot
exit
EOF

echo -e "${BLUE}📂 Entering the newly created project folder: $DEMO_HOME/my_projects/hr ${NC}"
cd hr

echo -e "${BLUE}🧾 Displaying project folder structure...${NC}"
tree -a

read -p "Press any key to continue..." -n 1 -s
echo ""

echo -e "${BLUE}🧩 SQL Projects use filters to manage database objects to be included in this project${NC}"
echo -e "${BLUE}📝 You can edit the project.filters file to exclude grants from the export${NC}"
echo -e "${BLUE}📄   Path: $DEMO_HOME/my_projects/hr/.dbtools/filters/project.filters${NC}"
echo -e "${RED}🔧   - Tip: Uncomment the line → export_type not in ... USER_SYS_PRIVS${NC}"

read -p "Press any key to continue after making the changes..." -n 1 -s
echo ""

rm $DEMO_HOME/my_projects/hr/.dbtools/filters/project.filters
cp $DEMO_HOME/aux/project.filters $DEMO_HOME/my_projects/hr/.dbtools/filters/project.filters

echo -e "${BLUE}🌐 We will use GitHub as our code repository.${NC}"
echo -e "${BLUE}📦 Initializing Git repository, adding the project files, and committing changes...${NC}"
echo -e "${GREEN}    git init --initial-branch=main${NC}"
echo -e "${GREEN}    git add .${NC}" 
echo -e "${GREEN}    git commit -m 'chore: initializing repository with default project files'${NC}"
echo ""
echo -e "${BLUE}🚀 Pushing changes to the remote repository on GitHub...${NC}"
echo -e "${GREEN}    git remote add origin $GITHUB_URL'${NC}"
echo -e "${GREEN}    git push -u origin main'${NC}"
echo ""
read -p "Press any key to run the commands"  -n 1 -s
echo ""

git init --initial-branch=main
git add .
git commit -m "chore: initializing repository with default project files"


git remote add origin $GITHUB_URL
git push -u origin main --force

echo -e "${BLUE}✅ The project structure has been committed to the code repository. Next steps:${NC}" 
echo -e "${BLUE}  1️⃣ Create a new branch and extract the DB ojects${NC}" 
echo -e "${BLUE}  2️⃣ dd the exported code to the Git repository${NC}" 
echo -e "${BLUE}  3️⃣ Generate the changelogs by comparing this branchwith main${NC}" 
echo -e "${BLUE}  4️⃣ Add custom SQL scrpts to populate the database with demo data${NC}"
echo -e "${BLUE}  5️⃣ Close the changes to include them in the current elease${NC}" 
echo -e "${BLUE}  6️⃣ Generate the ZIP artifact we’ll use to deploy to production${NC}" 
echo ""
echo ""
echo -e "${BLUE}🔀 Step 1: Creating a new branch and exporting database objects...${NC}"

echo -e "${GREEN}      git checkout -b base-release${NC}"
echo -e "${RED}      project export${NC}"
echo ""
read -p "Press any key to continue..." -n 1 -s
echo ""

git checkout -b base-release
sql -name hr_dev <<EOF
project export
exit
EOF
tree

read -p "Press any key to continue..." -n 1 -s
echo ""

echo -e "${BLUE}📥 Step 2: Adding the source code to the Git repository...${NC}"
echo -e "${GREEN}    git add src${NC}"
echo -e "${GREEN}    git commit -m 'chore: base export of sample app and tables'${NC}"
echo -e "${GREEN}    git push -u origin base-release${NC}"
echo ""
read -p "Press any key to execute..."  -n 1 -s
echo ""

git add src
git commit -m "chore: base export HR database application"
git push -u origin base-release

echo -e "${BLUE}🧾 Step 3: Generating the changelogs by comparing this branch with main...${NC}"
echo -e "${RED}    project stage${NC}"
echo ""
read -p "Press any key to execute..."  -n 1 -s
echo ""

sql -name hr_dev <<EOF
project stage -verbose
exit
EOF
tree

echo ""
read -p "Press any key to continue..." -n 1 -s
echo ""

echo -e "${BLUE}🛠️ Step 4: Adding custom code that we want to execute in production.${NC}"
echo -e "${BLUE}📊 In this demo, we’ll include SQL scripts to insert sample data into our tables.${NC}"
echo -e "${BLUE}➕ We’ll use the 'project stage add-custom' command to register these scripts.${NC}"
echo -e "${RED}    project stage add-custom -file-name populate_tables_with_demo_data.sql${NC}"
echo ""
read -p "Press any key to execute..."  -n 1 -s
echo ""

sql -name hr_dev  <<EOF
project stage add-custom -file-name populate_tables_with_demo_data.sql
exit
EOF
tree

read -p "Press any key to continue..." -n 1 -s
echo ""

echo -e "${BLUE}🧾 The generated file includes only Liquibase annotations — we need to insert the actual SQL code manually.${NC}"
echo -e "${BLUE}📂 We’ll now run a shell script to append the SQL code to the appropriate file.${NC}"
echo ""
read -p "Press any key to execute..."  -n 1 -s
echo ""

cd $DEMO_HOME/aux/custom
./append_base_release_sql_files.sh
cd $DEMO_HOME/my_projects/hr

echo -e "${BLUE}✅ The  file now contain the SQL code to populate the application tables and the Liquibase annotations.${NC}"
echo ""
read -p "Press any key to execute..."  -n 1 -s
echo ""

echo -e "${BLUE}📦 Step 5: Closing the staged changes to finalize this release version.${NC}"
echo -e "${RED}    project release -version 1.0 -verbose${NC}"
echo ""
read -p "Press any key to execute..." -n 1 -s
echo ""

sql -name hr_dev <<EOF
project release -version 1.0 -verbose
exit
EOF
tree

read -p "Press any key to continue..." -n 1 -s
echo ""

echo -e "${BLUE}🗜️ Step 6: Generating the ZIP artifact to deploy the application to production.${NC}"
echo -e "${RED}    project gen-artifact -name hr -version 1.0 -format zip -verbose${NC}"
echo ""
read -p "Press any key to execute..." -n 1 -s
echo ""

sql -name hr_dev <<EOF
project gen-artifact -name hr -version 1.0 -format zip -verbose
exit
EOF
tree

echo ""
read -p "Press any key to execute..." -n 1 -s
echo ""

echo -e "${RED}✅ The artifact for the base release is ready!${NC}"
echo -e "${BLUE}🚀 Uploading the ZIP artifact to GitHub Releases...${NC}"
echo -e "${GREEN}    gh release create v1.0 artifact/hr-1.0.zip \${NC}"
echo -e "${GREEN}      --title 'Version 1.0' \${NC}"
echo -e "${GREEN}       --notes 'Base release for the HR database application"

gh release create v1.0 artifact/hr-1.0.zip \
  --title "Version 1.0" \
  --notes "Base release for the HR database application"

echo -e "${BLUE}🏁 Base release complete — time to deploy to production.${NC}"

