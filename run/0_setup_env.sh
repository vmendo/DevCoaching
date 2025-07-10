#!/bin/bash

# Set project base directory
export DEMO_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# GitHub Configuration (user-specific)
export GITHUB_USER="synuora"
export GITHUB_REPO="my_hr_demo"
export GITHUB_URL="https://github.com/$GITHUB_USER/$GITHUB_REPO.git"