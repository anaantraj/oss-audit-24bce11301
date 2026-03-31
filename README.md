# Open Source Audit: The Python Ecosystem
**Author:** Anaant Raj  
**Institution:** Vellore Institute of Technology (VIT) Bhopal  
**Course:** CSE0002: Open Source Software | NGMC  
**Target Software:** Python 3  

## 1. Project Overview
This repository serves as the technical deliverable for the Open Source Audit capstone project. It contains a suite of five defensive, POSIX-compliant shell scripts designed to audit, monitor, and interact with the Python open-source ecosystem on a Linux machine. 

Choosing Python for this audit was a deliberate architectural choice. As it forms the foundational infrastructure for modern machine learning pipelines and my ongoing research workflows, understanding how it interacts with the underlying Linux kernel—its package managers, standard libraries, and system daemon logs—is a critical technical requirement.

## 2. Development & Testing Methodology
The development of these utilities followed a strict iterative lifecycle to ensure robustness across different environments. 

* **Environment Setup:** All scripts were initially drafted and aggressively tested on a local Ubuntu 22.04 LTS virtual machine. 
* **Cross-Platform Considerations:** During testing, I recognized that lab environments might utilize Fedora or CentOS instead of Debian-based systems. Consequently, I engineered Script 2 (`pkg_inspector.sh`) to dynamically detect the host's package manager (`dpkg` vs. `rpm`) before executing queries, preventing fatal runtime errors.
* **Handling Edge Cases:** Script 3 (`disk_auditor.sh`) was refined to dynamically locate the user's local Python `site-packages` directory instead of hardcoding paths, as Python environments vary wildly between developers. I also implemented `2>/dev/null` redirection across all scripts to gracefully suppress standard error outputs when auditing directories owned by `root`.
* **Log Parsing:** Developing the log analyzer required fine-tuning the `grep` regex pipeline to handle case-insensitive anomaly detection without throwing false positives on standard system output. 

## 3. Environment & Setup Requirements
To ensure 100% execution success, your testing environment should meet the following baseline requirements:

### Prerequisites
* **Operating System:** Any modern Linux Distribution (Ubuntu/Debian, RHEL/Fedora, Arch).
* **Shell:** GNU Bash (v4.0 or higher recommended).
* **Dependencies:** Standard GNU `coreutils` (`awk`, `grep`, `cut`, `du`, `df`, `free`). No external packages or third-party libraries are required.

### Deployment Instructions
1.  **Clone the Repository:** Pull this source code into your local or lab machine.
    ```bash
    git clone [https://github.com/yourusername/oss-audit-](https://github.com/yourusername/oss-audit-)[rollnumber].git
    cd oss-audit-[rollnumber]
    ```
2.  **Grant Execution Privileges:** By default, git may not preserve the executable bit. You must make the scripts executable:
    ```bash
    chmod +x *.sh
    ```
3.  **Optional Log Setup:** If testing on a restricted lab machine where you do not have `sudo` access to read `/var/log/syslog`, use the provided `syslog` mock file included in this repository to test Script 4's logic.

## 4. Script Execution & Architecture

### Script 1: `sys_identity.sh`
* **Execution:** `./sys_identity.sh`
* **Architecture:** Extracts and formats raw hardware telemetry (`/proc/cpuinfo`, `free -h`) and operating system metadata into a color-coded, human-readable system dashboard, alongside the mandatory FOSS OS license declaration.

### Script 2: `pkg_inspector.sh`
* **Execution:** `./pkg_inspector.sh`
* **Architecture:** A robust auditing tool. It first evaluates the binary path to determine if the system uses `APT` or `RPM`, then loops through an array of foundational FOSS packages (Python, Apache, MySQL, Git, VLC) to extract their installation status, versioning numbers, and philosophical significance.

### Script 3: `disk_auditor.sh`
* **Execution:** `./disk_auditor.sh`
* **Architecture:** Automates storage and security auditing. It iterates through critical system paths and the dynamically resolved Python library directory, utilizing `awk` to parse `ls -ld` outputs. It formats the permissions, ownership, and disk utilization (`du -sh`) into a strict tabular layout using `printf`.

### Script 4: `log_analyzer.sh`
* **Execution:** `./log_analyzer.sh [path_to_log] [search_keyword]`
    * *Standard run:* `./log_analyzer.sh /var/log/syslog "error"`
    * *Lab test run:* `./log_analyzer.sh syslog "error"` (Uses the local mock file).
* **Architecture:** A defensive log parsing utility. It checks for file readability, safely reads the file line-by-line via a `while IFS=` loop to avoid memory buffer overloads on massive logs, calculates the percentage frequency of the targeted anomaly, and extracts the most recent occurrences.

### Script 5: `manifesto_gen.sh`
* **Execution:** `./manifesto_gen.sh`
* **Architecture:** An interactive shell utility. It utilizes `while` loops to validate user input (preventing empty string submissions) before injecting those variables into a predefined text template. The output is redirected (`>>`) to a dynamically generated, timestamped `.txt` file tied to the current user's session.
