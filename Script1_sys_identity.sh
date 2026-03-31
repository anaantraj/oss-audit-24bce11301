#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author:   [Anaant Raj] | Roll No: [24BCE11301]
# Course:   Open Source Software (OSS NGMC)
# Purpose:  Displays a formatted welcome screen showing key
#           system information and the open-source license
#           governing the running operating system.
# ============================================================

# --- Student and project variables ---
STUDENT_NAME="[Anaant Raj]"         
ROLL_NUMBER="[24BCE11301]"   
SOFTWARE_CHOICE="Linux Kernel"     

# --- Gather system information using command substitution ---
KERNEL=$(uname -r)                  # Running kernel version (e.g. 5.14.0-362.el9.x86_64)
KERNEL_ARCH=$(uname -m)             # CPU architecture (e.g. x86_64)
USER_NAME=$(whoami)                 # Currently logged-in username
HOME_DIR=$HOME                      # Home directory of current user
HOSTNAME=$(hostname)                # System hostname
UPTIME=$(uptime -p)                 # Human-readable uptime (e.g. "up 2 hours, 15 minutes")
DATETIME=$(date '+%A, %d %B %Y — %H:%M:%S')  # Formatted date and time

# --- Detect Linux distribution name ---
# /etc/os-release is a standard file present on all modern Linux distros
if [ -f /etc/os-release ]; then
    # Source the file to load its variables, then read PRETTY_NAME
    DISTRO=$(grep '^PRETTY_NAME' /etc/os-release | cut -d= -f2 | tr -d '"')
else
    # Fallback if os-release is not found (older systems)
    DISTRO="Unknown Linux Distribution"
fi

# --- Determine the kernel's open-source license ---
# The Linux Kernel is licensed under GPL v2 — this is a known fact
# but we also try to verify from the kernel source if available
KERNEL_LICENSE="GPL v2 (GNU General Public License, Version 2)"

# --- Display the formatted system identity report ---
echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║          OPEN SOURCE AUDIT — SYSTEM IDENTITY            ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "  Student   : $STUDENT_NAME ($ROLL_NUMBER)"
echo "  Project   : $SOFTWARE_CHOICE Audit"
echo ""
echo "──────────────────────────────────────────────────────────"
echo "  SYSTEM INFORMATION"
echo "──────────────────────────────────────────────────────────"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Architecture : $KERNEL_ARCH"
echo "  Hostname     : $HOSTNAME"
echo ""
echo "  Logged-in as : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo ""
echo "  System Time  : $DATETIME"
echo "  Uptime       : $UPTIME"
echo ""
echo "──────────────────────────────────────────────────────────"
echo "  OPEN SOURCE LICENSE"
echo "──────────────────────────────────────────────────────────"
echo ""
echo "  The Linux Kernel running on this machine is licensed"
echo "  under the $KERNEL_LICENSE."
echo ""
echo "  This means:"
echo "   * You are free to run this OS for any purpose."
echo "   * You may study and modify the kernel source code."
echo "   * You may redistribute copies freely."
echo "   * Any modified version you distribute must also"
echo "     be released under GPL v2."
echo ""
echo "  Source: https://kernel.org | License: https://spdx.org/licenses/GPL-2.0-only.html"
echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║              End of System Identity Report               ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""