#!/bin/bash
# Script 1: System Identity Report
# Author: Anaant Raj
# Course: CSE0002: Open Source Software | NGMC
# Demonstrates: Variables, command substitution, ANSI colors, hardware querying.

# --- Styling Variables ---
BOLD="\e[1m"
CYAN="\e[36m"
GREEN="\e[32m"
RESET="\e[0m"

# --- System info ---
STUDENT_NAME="Anaant Raj"
SOFTWARE_CHOICE="Python"
KERNEL=$(uname -rm)
USER_NAME=$(whoami)
UPTIME=$(uptime -p | sed 's/up //')
DISTRO=$(grep "^PRETTY_NAME" /etc/os-release | cut -d '=' -f 2 | tr -d '"')
DATE_TIME=$(date +"%Y-%m-%d %H:%M:%S %Z")

# Hardware info (safely extracting first line/match)
CPU_MODEL=$(grep -m 1 "model name" /proc/cpuinfo | awk -F: '{print $2}' | xargs)
MEM_TOTAL=$(free -h | awk '/^Mem:/ {print $2}')

# --- Display ---
echo -e "${CYAN}====================================================${RESET}"
echo -e "${BOLD}              OPEN SOURCE AUDIT REPORT${RESET}"
echo -e "${CYAN}====================================================${RESET}"
echo -e " ${BOLD}Student:${RESET}    $STUDENT_NAME"
echo -e " ${BOLD}Focus:${RESET}      $SOFTWARE_CHOICE"
echo -e "${CYAN}----------------------------------------------------${RESET}"
echo -e " ${BOLD}Date/Time:${RESET}  $DATE_TIME"
echo -e " ${BOLD}OS Distro:${RESET}  $DISTRO"
echo -e " ${BOLD}Kernel:${RESET}     $KERNEL"
echo -e " ${BOLD}Hardware:${RESET}   $CPU_MODEL | $MEM_TOTAL RAM"
echo -e " ${BOLD}Session:${RESET}    User '$USER_NAME' | Uptime: $UPTIME"
echo -e "${CYAN}====================================================${RESET}"
echo -e "${GREEN}[License Note]${RESET} The underlying kernel operating this"
echo -e "environment is licensed under the GPL v2, ensuring the"
echo -e "foundation of our infrastructure remains open and free."
echo -e "${CYAN}====================================================${RESET}"
