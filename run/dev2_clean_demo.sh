#!/bin/bash

# ===============================
# DEMO CLEAN-UP SCRIPT
# ===============================

# --- Config ---
export DEMO_HOME="$(cd "$(dirname "$0")/.." && pwd)"
DEV_PROJECT_DIR="$DEMO_HOME/my_projects/hr"
GITHUB_USER="vmendo"
GITHUB_REPO="my_hr_demo"
DEV2_DB_ALIAS="hr_dev2"

# --- Colors ---
RED='\033[31m'
GREEN='\033[32m'
BLUE='\033[34m'
NC='\033[0m'

# --- Header ---
echo -e "${BLUE}🧹 Starting fdemo cleanup...${NC}"
echo -e "${BLUE}THIS WILL CLEAN DEV2 ...${NC}"
echo ""
read -p "Press any key to confirm..." -n 1 -s
echo ""


# --- Remove project directory ---
echo -e "${BLUE}Deleting local project directory: $DEV_PROJECT_DIR${NC}"
rm -rf "$DEV_PROJECT_DIR"
echo -e "${GREEN}✔ Local project directory removed.${NC}"

# --- Drop ALL objects in developer 2 database schema ---
export TNS_ADMIN=$DEMO_HOME/wallet/dev2
echo -e "${RED}⚠ Dropping ALL objects in the hr_dev2 schema...${NC}"
sql -name "$DEV2_DB_ALIAS" <<EOF
SET SERVEROUTPUT ON
BEGIN
  FOR rec IN (
    SELECT object_type, object_name
    FROM user_objects
    WHERE object_type IN (
      'TABLE', 'VIEW', 'SEQUENCE', 'PROCEDURE', 'FUNCTION', 'PACKAGE', 'INDEX', 'TRIGGER'
    )
    AND (object_type != 'SEQUENCE' OR object_name NOT LIKE 'ISEQ\$\$_%')
  ) LOOP
    BEGIN
      DBMS_OUTPUT.PUT_LINE('Dropping ' || rec.object_type || ' ' || rec.object_name);
      IF rec.object_type = 'TABLE' THEN
        EXECUTE IMMEDIATE 'DROP TABLE ' || rec.object_name || ' CASCADE CONSTRAINTS PURGE';
      ELSE
        EXECUTE IMMEDIATE 'DROP ' || rec.object_type || ' ' || rec.object_name;
      END IF;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Skipped ' || rec.object_type || ' ' || rec.object_name || ': ' || SQLERRM);
    END;
  END LOOP;
END;
/
EXIT
EOF
echo -e "${GREEN}✔ Developer 2 schema fully cleaned.${NC}"

echo -e "${BLUE}✅ DEV2 ENVIRONMET CLEANUP COMPLETE${NC}"
