#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Burp Suite Pro Patch Script
# Usage:
#   ./burp-suite-patch.sh [path to burp *.vmoptions file or install directory]
# Example:
#   ./burp-suite-patch.sh                                           # Finds the vmoptions file automatically
#   ./burp-suite-patch.sh /opt/BurpSuitePro/BurpSuitePro.vmoptions  # Manually specified path to the vmoptions file
#   ./burp-suite-patch.sh /opt/BurpSuitePro/                        # Same as above, but with install directory

# If no path is provided, the script will try to find the file automatically on the local machine.

# Get current script path
extract_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
self_filename=$(basename "${BASH_SOURCE[0]}")

VMOPTIONS_FILENAME="BurpSuitePro.vmoptions"
KEYGEN_JAR_FILENAME="BurpLoaderKeygen.jar"

function append_line() {
    filename=$1
    line=$2
    
    
    # Check if the line exists in the file
    if grep -qsF -- "$line" "$filename"; then
        echo "Already Patched!"
        return 0
    else
        # Append the line to the file
        echo "$line" >> "$filename"
        return 0
    fi
}

if [[ ! -f "$extract_path/$KEYGEN_JAR_FILENAME" ]]; then
    echo "[!] Couldn't find the keygen file '$KEYGEN_JAR_FILENAME' in '$extract_path'."
    echo "    Make sure you have the keygen file in the same directory as this script."
    exit 1
fi

# first argument is the path to the vmoptions file, add default value
user_input=${1:-}
burp_dir=""
vmoptions=""

# Check argument is given and that path exists
if [[ -n "$user_input" ]]; then

  # Check directory or file exists
  if [[ -d "$user_input" ]]; then
    # Directory
    burp_dir="$user_input"
  elif [[ -f "$user_input" ]]; then
    # File
    vmoptions="$user_input"
  else
    echo "[!] Invalid path to burp directory or vmoptions file - '$user_input'!"
    exit 1
  fi

else
  # Find all BurpSuite installed on the system
  echo "[+] Finding Burp Suite Installations..."
  installs=$(find / -maxdepth 3 -xdev \( -path /bin -prune -o -path /boot -prune -path /etc -prune -o -path /lib -prune -o -path /media -prune -o -path /mnt -prune -o -path /var -prune \) -o -type f -name $VMOPTIONS_FILENAME -printf "%h\n" 2>/dev/null || true)

  # Check if we found any installations
  if [[ -z "$installs" ]]; then
      echo "[!] Couldn't find the Burp Suite installation."
      echo "    Make sure you have Burp Suite installed and try again."
      echo "    If you have Burp Suite installed, try running this script with the vmoptions as an argument."
      echo "    Example: ./${self_filename} /opt/BurpSuitePro/BurpSuitePro.vmoptions"
      exit 1
  fi

  # Prompt the user to choose a file
  echo "[?] Choose Installation:"
  select burp_dir in "${installs[@]}"; do
    break
  done
fi

# if the vmoptions file is not given, find it
if [[ -z "$vmoptions" ]]; then
  vmoptions="$burp_dir/$VMOPTIONS_FILENAME"
else
  burp_dir=$(dirname "$vmoptions")
fi

echo "[+] Patching Burp Suite installation at $burp_dir..."
if [[ ! -f "$vmoptions" ]]; then
      echo "Invalid selection! vmoption file doesn't exist. Exiting..."
    exit 1
fi
echo "[+] Patching $vmoptions..."
# Add the activation file to the vmoptions file
append_line "$vmoptions" "-include-options activation.vmoptions"


# Create the activation file
echo "[+] Creating 'activation.vmoptions' file..."
activation_file="$burp_dir/activation.vmoptions"
append_line "$activation_file" "-noverify"
append_line "$activation_file" "-javaagent:$KEYGEN_JAR_FILENAME"
append_line "$activation_file" "--add-opens=java.base/java.lang=ALL-UNNAMED"
append_line "$activation_file" "--add-opens=java.desktop/javax.swing=ALL-UNNAMED"
append_line "$activation_file" "--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED"
append_line "$activation_file" "--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED"
append_line "$activation_file" "--add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED"

# Download the keygen jar file
echo "[+] Copying $KEYGEN_JAR_FILENAME file..."
cp "$extract_path/$KEYGEN_JAR_FILENAME" "$burp_dir/$KEYGEN_JAR_FILENAME"

echo "[+] Finished!"
echo "
Activation Instructions:
1. Run the keygen
2. Copy the activation code to burp and proceed
3. Click "Manual Activation"
4. Copy Activation request to the keygen
5. Copy the generated activation response to burp and activate
6. That's it ;)

"

read -p "Press [Enter] key to start BurpSuite and the Keygen to start the activation process..."
cd "$burp_dir"
echo "[+] Starting Burp Suite..."
"$burp_dir/BurpSuitePro" &
echo "[+] Starting the keygen..."
"$burp_dir/jre/bin/java" -jar "$burp_dir/$KEYGEN_JAR_FILENAME" &


exit 0
