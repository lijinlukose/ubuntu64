#!/bin/bash
#Script v6.3.1
#This script is Free and Open Source as part of the FOSS initiative worldwide
# Setting up a Linux system for eDistrict and other Projects.
# Do not edit this script or the files/folders along with the script, as it may break the
# functionality of the script.
# If you are changing the files/folders, also make corresponding changes to the main script

#including the script for functions
source ~/Desktop/ubuntu64/scripts/functions64.sh

code_name=$(grep "DISTRIB_CODENAME=" /etc/lsb-release | awk -F= {' print $2'}|sed s/\"//g |sed s/[0-9]//g | sed s/\)$//g |sed s/\(//g)

clear
/bin/echo -e "\e[33m[Script v6.3.1]\e[0m"
echo ""
/bin/echo -e "\e[36mOracle Java JRE 8u261\nAdobe Reader\nePass\nCanon iR2002\nCanon LBP6230dn\nKyocera TASKalfa 2201\nWatchData proXkey\nTeamViewer\nAnyDesk\nNICDSigner\nKavach Authenticator\nGoogle Chrome\nPaleMoon Browser\nMicrosoft Teams\nZoom Desktop Client\nPDFsam\nMalayalam Unicode Fonts\nUtilities\n\e[0m"
sleep 5s

java_install

adobe_install

canon2002_install

canon6230_install

kyocera2201_install

proxkey_install

teamviewer_install

anydesk_install

nicd_install

kavach_install

chrome_install

palemoon_install

teams_install

zoom_install

pdfsam_install

malfont_install

util_install

email_copy

wallpaper

keyboard_settings

codename_spec

zenity --info --title="Success" --text="Installation completed" --no-wrap 2>/dev/null

echo ""
echo ""
show_report
sleep 5s

main_menu