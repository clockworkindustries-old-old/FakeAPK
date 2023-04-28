#!/bin/bash
# Made by kxtz#8161
# Licenced under the MIT Licence
# Script is linked at https://github.com/kxtzownsu/fakeapk
# FakeAPK Build 1


# Getting command variables, example: bash fakeapk.sh 0 0
vb=$1


# Checking if Root
if [ "$EUID" -ne 0 ]; then
        echo "Please run as root"
        exit
    fi
# Detecting Verbose Mode
if [ "$1" = "1" ]; then
  echo "You are running the script with Verbose Mode! This will print every single action done."
else
  echo "FakeAPK.Verbose.Disabled.Message"
fi

traps() {
    set -e
    trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
    trap 'echo "\"${last_command}\" command failed with exit code $?. THIS IS A BUG, REPORT IT HERE https://github.com/clockworkindustries/fakeapk"' EXIT
}

# Setting Ascii Logo
ascii_logo() {
  clear
  cat <<-EOF

 ________ ________  ___  __    _______   ________  ________  ___  __
|\\  _____\\\\   __  \\|\\  \\|\\  \\ |\\  ___ \\ |\\   __  \\|\\   __  \\|\\  \\|\\  \\
\\ \\  \\__/\\ \\  \\|\\  \\ \\  \\/  /|\\ \\   __/|\\ \\  \\|\\  \\ \\  \\|\\  \\ \\  \\/  /
 \\ \\   __\\\\ \\   __  \\ \\   ___  \\ \\  \\_|/_\\ \\   __  \\ \\   ____\\ \\  ___ \\
  \\ \\  \\_| \\ \\  \\ \\  \\ \\  \\\\ \\  \\ \\  \\_|\\ \\ \\  \\ \\  \\ \\  \\___|\\ \\ \\\\ \\ \\
   \\ \\__\\   \\ \\__\\ \\__\\ \\__\\\\ \\__\\ \\_______\\ \\__\\ \\__\\ \\__\\    \\ \\_\\\\ \\_\\
    \\|__|    \\|__|\\|__|\\|__| \\|__|\\|_______|\\|__|\\|__|\\|__|     \\|_| \\|_|
                                                                           
                                                                           
                                                                           

THIS IS FREE SOFTWARE! if you paid for this, you have been scammed and should demand your money back

FakeAPK - This is a tool which while using fakemurk you are able to install APKs. This tool is for the people whos Play Store does not work while using fakemurk.

Notes: This will most likely flag that you booted in Developer Mode. Read the README.md for more info. https://github.com/clockworkindustries/fakeapk

EOF
}

disable_fakeapk() {
  
  echo "--- Patching crossystem ---"
  echo "Writing to crossystem"
  sed -i "s/\(cros_debug=\).*/\10/" /usr/bin/crossystem
  echo "Done! Press enter to restart your chromebook automatically then install your APKs of choice!"
  read disablefakeapk
  reboot
}

enable_fakeapk() {
  
  echo "--- Patching crossystem ---"
  sed -i "s/\(cros_debug=\).*/\11/" /usr/bin/crossystem
  echo "Writing to crossystem"
  echo "Done! Press enter to restart your chromebook automatically then install your APKs of choice!"
  read enablefakeapk
  reboot
}

credits() {
  cat <<-EOF

---| Credits |---
  
kxtz#8161 - Finding the Exploit & Making the script
Mercury Workshop - Making fakemurk, which makes this all possible (and for some of the code: error catching & ascii art)!

EOF

echo "Press enter to go back."
read lollllll
main

}


main() {
  traps
  ascii_logo
  echo "--- Select an option ---"
  echo "1) Enable FakeAPK       "
  echo "2) Disable FakeAPK      "
  echo "3) View Credits         "
  read selection
  
  if [[ "$selection" = "1" ]]; then
    enable_fakeapk
  fi
  if [[ "$selection" = "2" ]]; then
    disable_fakeapk
  fi
  if [[ "$selection" = "3" ]]; then
    credits
  fi
}

main
