#!/bin/bash
# Script 5: Open Source Manifesto Generator
# Author: Anaant Raj
# Demonstrates: Input validation (while loops), file redirection, string interpolation.

echo "=================================================="
echo "      Open Source Manifesto Generator v1.0"
echo "=================================================="

# Function to safely read input and ensure it's not empty
prompt_input() {
    local prompt_text=$1
    local var_name=$2
    local input=""
    
    while [ -z "$input" ]; do
        read -p "$prompt_text" input
        if [ -z "$input" ]; then
            echo "  [!] Input cannot be empty. Please try again."
        fi
    done
    eval $var_name="'$input'"
}

prompt_input "1. Name a core open-source tool you rely on: " TOOL
prompt_input "2. Name an architecture/project you want to build and share: " BUILD
prompt_input "3. Define 'freedom' in a single word regarding software: " FREEDOM

DATE=$(date '+%B %d, %Y - %H:%M')
OUTPUT="manifesto_$(whoami)_$(date +%s).txt"

echo "--------------------------------------------------"
echo "Compiling structural manifesto..."

# Constructing the document
cat << EOF > "$OUTPUT"
OPEN SOURCE MANIFESTO
Date: $DATE
Author: Anaant Raj

Modern software architecture does not exist in a vacuum. My workflows and research pipelines rely entirely on foundational tools like $TOOL, built by communities prioritizing collective advancement over siloed IP. 

To me, the core of open source is $FREEDOM. It allows us to construct complex systems without constantly reinventing the wheel. Because I benefit from this ecosystem, I hold a responsibility to contribute back. My objective is to develop $BUILD and release it openly, ensuring the ladder of technological progress remains lowered for those who follow.
EOF

echo "Success. Manifesto written to: $OUTPUT"
echo "--------------------------------------------------"
cat "$OUTPUT"