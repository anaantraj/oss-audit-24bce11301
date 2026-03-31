#!/bin/bash
# Script 2: FOSS Package Inspector
# Author: Anaant Raj
# Demonstrates: Functions, if-then-else, case statements, cross-platform package querying.

PACKAGES=("python3" "apache2" "mysql-server" "vlc" "git")

# Determine package manager
if command -v dpkg-query &> /dev/null; then
    PKG_MGR="dpkg"
elif command -v rpm &> /dev/null; then
    PKG_MGR="rpm"
else
    echo "Error: Neither dpkg nor rpm found. Unsupported distribution."
    exit 1
fi

echo "Initiating FOSS Package Audit (Using: $PKG_MGR)..."
echo "--------------------------------------------------"

for PKG in "${PACKAGES[@]}"; do
    # Query logic based on detected package manager
    if [ "$PKG_MGR" == "dpkg" ]; then
        IS_INSTALLED=$(dpkg-query -W -f='${Status}' "$PKG" 2>/dev/null | grep -c "ok installed")
        VERSION=$(dpkg-query -W -f='${Version}' "$PKG" 2>/dev/null)
    else
        IS_INSTALLED=$(rpm -q "$PKG" &>/dev/null && echo 1 || echo 0)
        VERSION=$(rpm -q --queryformat '%{VERSION}' "$PKG" 2>/dev/null)
    fi

    if [ "$IS_INSTALLED" -gt 0 ]; then
        echo -e "[+] $PKG is installed (v $VERSION)."
    else
        echo -e "[-] $PKG is NOT installed."
    fi

    # Philosophical breakdown via case statement
    case $PKG in
        "python3")
            echo "    -> Python: The architectural glue of modern AI and data systems." ;;
        "apache2" | "httpd")
            echo "    -> Apache: The web server backbone of the early open internet." ;;
        "mysql-server" | "mariadb-server")
            echo "    -> MySQL/MariaDB: Relational data storage driven by community." ;;
        "git")
            echo "    -> Git: The tool Linus built to decentralize version control." ;;
        "vlc")
            echo "    -> VLC: A student project that grew into the ultimate media player." ;;
        *)
            echo "    -> Unknown package purpose." ;;
    esac
    echo ""
done