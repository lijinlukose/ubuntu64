#!/bin/bash
#Script v6.3.1
#This script is Free and Open Source as part of the FOSS initiative worldwide
# Setting up a Linux system for eDistrict and other Projects.
# Do not edit this script or the files/folders along with the script, as it may break the
# functionality of the script.
# If you are changing the files/folders, also make corresponding changes to the main script

#Definitions of Functions used in other scripts

#Functions to change directories
function cd_desktop()
{
	cd
	cd Desktop/
}
function cd_files()
{
	cd
	cd Desktop/ubuntu64/files/
}
function cd_java()
{
	cd
	cd Desktop/ubuntu64/files/java/
}
function cd_ubuntu()
{
	cd
	cd Desktop/ubuntu64/
}
function cd_safesign()
{
	cd
	cd Desktop/ubuntu64/files/SafeSign/
}
function cd_scripts()
{
	cd
	cd Desktop/ubuntu64/scripts/
}
function cd_canon()
{
	cd
	cd Desktop/ubuntu64/files/Canon/
}
function cd_epass()
{
	cd
	cd Desktop/ubuntu64/files/ePass2003/amd64/config/
}
function cd_fonts()
{
	cd
	cd Desktop/ubuntu64/files/Fonts/
}
function cd_ricoh()
{
	cd
	cd Desktop/ubuntu64/files/RICOH/
}
function cd_adobe()
{
	cd
	cd Desktop/ubuntu64/files/Adobe/
}
function cd_palemoon()
{
	cd
	cd Desktop/ubuntu64/files/PaleMoon/
}
function cd_nicd()
{
	cd
	cd Desktop/ubuntu64/files/NICDSign/
}
function cd_kavach()
{
	cd
	cd Desktop/ubuntu64/files/Kavach/
}
function cd_kyocera()
{
	cd
	cd Desktop/ubuntu64/files/Kyocera2201/
}

function main_menu()
{
	cd_scripts
	clear
	./main64.sh
}
function edist_menu()
{
	cd_scripts
	clear
	./edist_essentials.sh
}
function dsc_menu()
{
	cd_scripts
	clear
	./dsc.sh
}
function printer_menu()
{
	cd_scripts
	clear
	./printers.sh
}
function optsoft_menu()
{
	cd_scripts
	clear
	./optional_sw.sh
}

#Installation functions
function java_install()
{
	#Installing Java JRE 64-bit
	/bin/echo -e "\e[36mJava JRE 64-bit installation\e[0m"
	#Delete Java directory if already exist
	sudo rm -r /usr/lib/java/
	#Making directory for  new Java installation
	sudo mkdir -p /usr/lib/java/
	#Changing to directory where JRE source is located
	cd_java
	#Extracting the file to  the newly created directory
	sudo tar -xvzf jre-8u261-linux-x64.tar.gz -C /usr/lib/java
	#Deleting existing profile file
	sudo rm /etc/profile
	#Copying modified profile file for setting PATH environmental variable for Java
	sudo cp profile /etc/
	#Creating directory for java plugin if not exist
	sudo mkdir -p /usr/lib/mozilla/plugins/
	#Delete java plugin if exist in either firefox-addons or mozilla
	sudo rm /usr/lib/mozilla/plugins/libnpjp2.so
	sudo rm /usr/lib/firefox-addons/plugins/libnpjp2.so
	#Installing java plugin for Mozilla Firefox
	sudo ln -s /usr/lib/java/jre1.8.0_261/lib/amd64/libnpjp2.so /usr/lib/mozilla/plugins/libnpjp2.so
	/bin/echo -e "\e[32mJava installed successfully\e[0m"
	write_report "Java JRE 64-bit installed"
	java_settings
	sleep 5s
}

function epass_install()
{
	#Installing ePass2003 DSC 64-bit driver
	/bin/echo -e "\e[36m ePass2003 DSC driver installation\e[0m"
	#Changing directory
	cd_epass
	#Running script to install configuration
	sudo sh config.sh
	#Copying ePass2003 folder and plugin
	cd_files
	sudo cp -rf ePass2003/ /usr/lib/
	sudo cp ePass2003/amd64/redist/libcastle.so.1.0.0 /usr/lib/
	#Create a symbolic link and change permissions for token management tool
	sudo ln -s /usr/lib/ePass2003/amd64/redist/pkimanager_admin /bin/pkimanager_admin
	sudo chmod 777 /usr/lib/ePass2003/amd64/redist/pkimanager_admin
	/bin/echo -e "\e[32m ePass 2003 installed successfully\e[0m"
	write_report "ePass2003 installed"
	sleep 5s
}

function proxkey_install()
{
	#Installing proXkey DSC 64-bit driver
	/bin/echo -e "\e[36mproXkey DSC driver installation\e[0m"
	#Changing directory
	cd_files
	#Removing eMudhra and TrustKey token drivers
	#Removal is mandatory, since these packages cause proXkey not to function as desired
	sudo apt purge -y wdtokentool-emudhra
	sudo apt purge -y wdtokentool-trustkey
	#Removing WatchData directory if exist
	sudo rm -r /usr/lib/WatchData/
	#Installing proXkey
	sudo dpkg -i proxkey_v1.1.1-4.deb
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
		/bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
		sudo apt -fy install
		#Installing proXkey Token Driver
		sudo dpkg -i proxkey_v1.1.1-4.deb
			else
		    	/bin/echo -e "\e[32mproXkey installed successfully\e[0m"
				sleep 5s
	fi
	write_report "proXkey installed"
}

function nicd_install()
{
	#Installing NICDSigner
	#Note: RootCA certificate has to be imported to Mozilla Firefox manually
	/bin/echo -e "\e[36mNICDSigner installation\e[0m"
	#Removing DSC Signer if exist
	#Removal is mandatory, since these packages cause NICDSigner not to function as desired
	sudo apt purge -y dscsigner
	#Changing directory
	cd_nicd
	#Installing NICDSigner
	sudo dpkg -i NICDSign_v2.0.1.deb
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
		/bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
		sudo apt -fy install
		#Installing NICDSigner
		sudo dpkg -i NICDSign_v2.0.1.deb
			else
		    	/bin/echo -e "\e[32mNICDSigner installed successfully\e[0m"
				sleep 5s
	fi
	write_report "NICDSigner installed"
}

function adobe_install()
{
	#Installing Adobe Reader
	/bin/echo -e "\e[36mAdobe Reader installation\e[0m"
	#Installing required dependencies
	sudo apt install -y libxml2:i386 libcanberra-gtk-module:i386 gtk2-engines-murrine:i386 libatk-adaptor:i386
	#Changing directory
	cd_adobe
	#Installing Adobe Reader
	sudo dpkg -i AdbeRdr9.5.5-1_i386linux_enu.deb
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
	    /bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
	    sudo apt -fy install
		#Installing Adobe Reader
		sudo dpkg -i AdbeRdr9.5.5-1_i386linux_enu.deb
			else
		    	/bin/echo -e "\e[32mAdobe Reader installed successfully\e[0m"
				sleep 5s
	fi
	#Replacing modified .desktop file for better app association
	sudo rm /usr/share/applications/AdobeReader.desktop
	sudo cp AdobeReader.desktop /usr/share/applications/
	write_report "Adobe Reader installed"
}

function palemoon_install()
{
	#Installing PaleMoon
	/bin/echo -e "\e[36mPaleMoon installation\e[0m"
	#Changing directory
	cd_palemoon
	#Extracting PaleMoon package
	sudo tar -xvf palemoon-29.4.4.linux-x86_64-gtk3.tar.xz -C /usr/local/
	sudo chmod 777 -R /usr/local/palemoon/
	sudo ln -s /usr/local/palemoon/palemoon /usr/bin/palemoon
	sudo rm /usr/share/applications/palemoon.desktop
	sudo cp palemoon.desktop /usr/share/applications/
	#Holding PaleMoon updates, in order to protect java plugin compatibility (if compatibility breaks in a future update)
	#sudo apt-mark hold palemoon
	write_report "PaleMoon Browser installed"
	palemoon_settings
}

function chrome_install()
{
	#Installing Google Chrome Web Browser
	/bin/echo -e "\e[36mGoogle Chrome installation\e[0m"
	#Changing directory
	cd_files
	#Installing Google Chrome
	sudo dpkg -i google-chrome-stable_v98.0.4758.102_amd64.deb
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
	    /bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
	    sudo apt -fy install
		#Installing Google Chrome
		sudo dpkg -i google-chrome-stable_v98.0.4758.102_amd64.deb
			else
		    	/bin/echo -e "\e[32mGoogle Chrome installed successfully\e[0m"
				sleep 5s
	fi
	write_report "Google Chrome installed"
}

function zoom_install()
{
	#Installing Zoom Desktop Client
	/bin/echo -e "\e[36mZoom Desktop Client installation\e[0m"
	#Changing directory
	cd_files
	#Installing Zoom Desktop Client
	sudo dpkg -i zoom_v5.9.3-1911_amd64.deb
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
		/bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
		sudo apt -fy install
		#Installing Zoom Desktop Client
		sudo dpkg -i zoom_v5.9.3-1911_amd64.deb
			else
		    	/bin/echo -e "\e[32mZoom Desktop Client installed successfully\e[0m"
				sleep 5s
	fi
	write_report "Zoom Desktop Client installed"
}

function canon2002_install()
{
	#Installing Canon iR2002 64-bit driver
	/bin/echo -e "\e[36mCanon imageRUNNER 2002 driver installation\e[0m"
	#Changing directory
	cd_canon
	#Installing Common Unix Printing System Package and other dependencies
	sudo apt install -y cups
	sudo apt install -y libsane
	sudo apt install -y libglade2-0
	#Installing Printer Drivers
	sudo dpkg -i cnrdrvcups-ufr2-uk_5.40-1_amd64.deb
	#Installing iR2002 Scanner Driver
	sudo dpkg -i canon-mfscanner_1.00-1_amd64.deb
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
	    /bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
	    sudo apt -fy install
		#Installing Printer Driver
		sudo dpkg -i cnrdrvcups-ufr2-uk_5.40-1_amd64.deb
		#Installing Scanner Driver
		sudo dpkg -i canon-mfscanner_1.00-1_amd64.deb
			else
				/bin/echo -e "\e[32mCanon imageRUNNER 2002 installed successfully\e[0m"
				sleep 5s
	fi
	write_report "Canon imageRUNNER 2002 installed"
}

function canon6230_install()
{
	#Installing Canon LBP6230dn 64-bit driver
	/bin/echo -e "\e[36mCanon LBP6230dn driver installation\e[0m"
	#Changing directory
	cd_canon
	#Installing Common Unix Printing System Package and other dependencies
	sudo apt install -y cups
	sudo apt install -y libglade2-0
	#Installing Printer Drivers
	sudo dpkg -i cnrdrvcups-ufr2lt-uk_5.00-1_amd64.deb
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
	    /bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
	    sudo apt -fy install
		#Installing Printer Driver
		sudo dpkg -i cnrdrvcups-ufr2lt-uk_5.00-1_amd64.deb
			else
			    /bin/echo -e "\e[32mCanon imageCLASS LBP6230dn installed successfully\e[0m"
				sleep 5s
	fi
	write_report "Canon imageCLASS LBP6230dn installed"
}

function kyocera2201_install()
{
	#Installing Kyocera TASKalfa 2201 64-bit driver
	/bin/echo -e "\e[36mKyocera TASKalfa 2201 driver installation\e[0m"
	#Changing directory
	cd_kyocera
	#Installing Common Unix Printing System Package and libsane for scanner
	sudo apt install -y cups
	sudo apt install -y libsane
	#Installing Printer Driver
	sudo sh install.sh
	#Installing Scanner Driver
	sudo dpkg -i kyocera-sane_1.1.0228_amd64.deb
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
	    /bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
	    sudo apt -fy install
		#Installing Scanner Driver
		sudo dpkg -i kyocera-sane_1.1.0228_amd64.deb
			else
			    /bin/echo -e "\e[32mKyocera TASKalfa 2201 installed successfully\e[0m"
				sleep 5s
	fi
	write_report "Kyocera TASKalfa 2201 installed"
}

function ricoh212_install()
{
	#Installing RICOH SP212SNw drivers
	/bin/echo -e "\e[36mRICOH SP212SNw driver installation\e[0m"
	#Changing directory
	cd_ricoh
	#Installing Printer Drivers
	sudo apt install -y cups
	sudo apt install -y libsane
	sudo dpkg -i RICOH-212SNw-Printer-Driver-1.00-noarch.deb
	sudo dpkg -i RICOH-212SNw-Scanner-Driver-1.01-noarch.deb
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
	    /bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
	    sudo apt -fy install
		#Installing Printer Driver
		sudo dpkg -i RICOH-212SNw-Printer-Driver-1.00-noarch.deb
		sudo dpkg -i RICOH-212SNw-Scanner-Driver-1.01-noarch.deb
			else
		    	/bin/echo -e "\e[32mRICOH SP212SNw installed successfully\e[0m"
				sleep 5s
	fi
	write_report "RICOH SP212SNw installed"
}

function ricoh310_install()
{
	
	code_name=$(grep "DISTRIB_CODENAME=" /etc/lsb-release | awk -F= {' print $2'}|sed s/\"//g |sed s/[0-9]//g | sed s/\)$//g |sed s/\(//g)
	#Installing RICOH SP310SFN drivers
	/bin/echo -e "\e[36mRICOH SP310SFN driver installation\e[0m"
	#Changing directory
	cd_ricoh
	#Installing Printer Drivers
	sudo apt install -y cups
	sudo apt install -y libsane
	sudo dpkg -i SP310MF1a-pcl-0.5.deb
	if [ $code_name = "xenial" ]
	then
		sudo dpkg -i sp-310sfn-310sfnw_Scanner_v0.08-noarch.deb
		else
			 /bin/echo -e "\e[32mRICOH SP310SFN Scanner is only supported on Ubuntu 16.04. Skipping...\e[0m"
	fi
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
		/bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
	    sudo apt -fy install
		#Installing Printer Driver
		sudo dpkg -i SP310MF1a-pcl-0.5.deb
		if [ $code_name = "xenial" ]
		then
			sudo dpkg -i sp-310sfn-310sfnw_Scanner_v0.08-noarch.deb
			else
			 /bin/echo -e "\e[32mRICOH SP310SFN Scanner is only supported on Ubuntu 16.04. Skipping...\e[0m"
		fi
	else
			    /bin/echo -e "\e[32mRICOH SP310SFN installed successfully\e[0m"
				sleep 5s
	fi
	write_report "RICOH SP310SFN installed"
}

function ricoh1813_install()
{
	#Installing RICOH MP 1813L drivers
	/bin/echo -e "\e[36mRICOH MP 1813L driver installation\e[0m"
	#Changing directory
	cd_ricoh
	#Installing Printer Drivers
	sudo apt install -y cups
	sudo apt install -y libsane
	sudo dpkg -i MP_1813L_Printer_v1.00.deb
	sudo dpkg -i MP_1813L_Scanner_v1.00.deb
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
		/bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
	    sudo apt -fy install
		#Installing Printer Driver
		sudo dpkg -i MP_1813L_Printer_v1.00.deb
		sudo dpkg -i MP_1813L_Scanner_v1.00.deb
			else
		    	/bin/echo -e "\e[32mRICOH 1813L installed successfully\e[0m"
				sleep 5s
	fi
	write_report "RICOH 1813L installed"
}

function hp_install()
{
	#Installing HP Printer driver
	/bin/echo -e "\e[36mHP Printer driver installation\e[0m"
	#Installing GUI for HP Printer Driver
	sudo apt install -y cups
	sudo apt install -y libsane
	sudo apt install -y hplip-gui
	#Running HP Setup
	sudo hp-setup
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
		/bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
	    sudo apt -fy install
		#Installing GUI for HP Printer Driver
		sudo apt install -y cups
		sudo apt install -y libsane
		sudo apt install -y hplip-gui
		#Running HP Setup
		sudo hp-setup
			else
		   		/bin/echo -e "\e[32mHP Printer installed successfully\e[0m"
				sleep 5s
	fi
	write_report "HP Printer installed"
}

function teamviewer_install()
{
	#Installing TeamViewer
	/bin/echo -e "\e[36mTeamViewer installation\e[0m"
	#Changing directory
	cd_files
	#Installing TeamViewer
	sudo dpkg -i teamviewer_15.25.5_amd64.deb
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
		/bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
	    sudo apt -fy install
		#Installing TeamViewer
		sudo dpkg -i teamviewer_15.25.5_amd64.deb
			else
		    	/bin/echo -e "\e[32mTeamViewer installed successfully\e[0m"
				sleep 5s
	fi
	write_report "TeamViewer installed"
}

function anydesk_install()
{
	#Installing AnyDesk
	/bin/echo -e "\e[36mAnyDesk installation\e[0m"
	#Changing directory
	cd_files
	#Installing AnyDesk
	sudo apt install -y libgtkglext1
	sudo dpkg -i anydesk_6.1.1-1_amd64.deb
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
		/bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
		sudo apt -fy install
		#Installing AnyDesk
		sudo dpkg -i anydesk_6.1.1-1_amd64.deb
			else
		    	/bin/echo -e "\e[32mAnyDesk installed successfully\e[0m"
				sleep 5s
	fi
	write_report "AnyDesk installed"
}

function pdfsam_install()
{
	#Installing PDFsam
	/bin/echo -e "\e[36mPDFsam installation\e[0m"
	#Changing directory
	cd_files
	#Installing PDFsam
	sudo dpkg -i pdfsam_4.2.10-1_amd64.deb
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
		/bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
		sudo apt -fy install
		#Installing PDFsam
		sudo dpkg -i pdfsam_4.2.10-1_amd64.deb
			else
		    	/bin/echo -e "\e[32mPDFsam installed successfully\e[0m"
				sleep 5s
	fi
	write_report "PDFsam installed"
}

function teams_install()
{
	#Installing Microsoft Teams
	/bin/echo -e "\e[36mMicrosoft Teams installation\e[0m"
	#Changing directory
	cd_files
	#Installing Teams
	sudo dpkg -i teams_1.4.00.26453_amd64.deb
	#Checking if any error occured while installing
	if [ $? != 0 ]; then
		/bin/echo -e "\e[33mAdditional Packages are to be Installed\e[0m"
		sudo apt -fy install
		#Installing Microsoft Teams
		sudo dpkg -i teams_1.4.00.26453_amd64.deb
			else
		    	/bin/echo -e "\e[32mMicrosoft Teams installed successfully\e[0m"
				sleep 5s
	fi
	write_report "Microsoft Teams installed"
}

function kavach_install()
{
	#Installing Kavach Authenticator v3.4
	#If you are installing Kavach individually, java version in Kavach.desktop is to be matched witht he java installed in the system.
	#By default, the java version is 8u261 in Kavach.dekstop
	/bin/echo -e "\e[36mKavach Authenticator installation\e[0m"
	#Changing directory
	cd_kavach
	#Installing Kavach
	sudo mkdir -p /usr/local/Kavach/
	sudo cp KavachAuthentication.jar /usr/local/Kavach/
	sudo cp Kavach.png /usr/local/Kavach/
	sudo cp Kavach.desktop /usr/share/applications/
	sudo mkdir -p ~/.config/autostart/
	sudo cp Kavach.desktop ~/.config/autostart/
	sleep 5s
	write_report "Kavach Authenticator installed"
}

function malfont_install()
{
	#Installing Malayalam Unicode Fonts
	/bin/echo -e "\e[36mMalayalam Unicode Fonts installation\e[0m"
	#Changing directory
	cd_fonts
	#Making directories for Fonts
	sudo mkdir -p /usr/share/fonts/truetype/Anjali/
	sudo mkdir -p /usr/share/fonts/truetype/Chilanka/
	sudo mkdir -p /usr/share/fonts/truetype/Dyuthi/
	sudo mkdir -p /usr/share/fonts/opentype/Gayathri/
	sudo mkdir -p /usr/share/fonts/truetype/Kartika/
	sudo mkdir -p /usr/share/fonts/truetype/Karumbi/
	sudo mkdir -p /usr/share/fonts/truetype/Keraleeyam/
	sudo mkdir -p /usr/share/fonts/opentype/Manjari/
	sudo mkdir -p /usr/share/fonts/truetype/Meera/
	sudo mkdir -p /usr/share/fonts/truetype/Rachana/
	sudo mkdir -p /usr/share/fonts/truetype/Raghu/
	sudo mkdir -p /usr/share/fonts/truetype/Suruma/
	sudo mkdir -p /usr/share/fonts/truetype/Uroob/
	#Copying Fonts to directory
	sudo cp AnjaliOldLipi-Regular.ttf /usr/share/fonts/truetype/Anjali/
	sudo cp Chilanka-Regular.ttf /usr/share/fonts/truetype/Chilanka/
	sudo cp Dyuthi-Regular.ttf /usr/share/fonts/truetype/Dyuthi/
	sudo cp Gayathri-Regular.otf /usr/share/fonts/opentype/Gayathri/
	sudo cp Gayathri-Thin.otf /usr/share/fonts/opentype/Gayathri/
	sudo cp Kartika.ttf /usr/share/fonts/truetype/Kartika/
	sudo cp Kartika-Bold.ttf /usr/share/fonts/truetype/Kartika/
	sudo cp Karumbi-Regular.ttf /usr/share/fonts/truetype/Karumbi/
	sudo cp Keraleeyam-Regular.ttf /usr/share/fonts/truetype/Keraleeyam/
	sudo cp Manjari-Bold.otf /usr/share/fonts/opentype/Manjari/
	sudo cp Manjari-Regular.otf /usr/share/fonts/opentype/Manjari/
	sudo cp Manjari-Thin.otf /usr/share/fonts/opentype/Manjari/
	sudo cp Meera-Regular.ttf /usr/share/fonts/truetype/Meera/
	sudo cp Rachana-Bold.ttf /usr/share/fonts/truetype/Rachana/
	sudo cp Rachana-Regular.ttf /usr/share/fonts/truetype/Rachana/
	sudo cp RaghuMalayalamSans-Regular.ttf /usr/share/fonts/truetype/Raghu/
	sudo cp Suruma.ttf /usr/share/fonts/truetype/Suruma/
	sudo cp Uroob-Regular.ttf /usr/share/fonts/truetype/Uroob/

	/bin/echo -e "\e[32mMalayalam Unicode Fonts installed successfully\e[0m"
	write_report "Malayalam Unicode Fonts installed"
	sleep 3s
}

function guestoff()
{
	#Turning off Guest Session (Ubuntu 16.04 only)
	/bin/echo -e "\e[36mTurning Off Guest Session in Ubuntu 16.04. Effective only after system reboot\e[0m"
	sudo touch /etc/lightdm/lightdm.conf
	sudo chmod 777 /etc/lightdm/lightdm.conf
	sudo echo $'[SeatDefaults]\nuser-session=ubuntu\ngreeter-session=unity-greeter\nallow-guest=false' >> /etc/lightdm/lightdm.conf
	
	/bin/echo -e "\e[32mGuest Session Turned Off Successfully\e[0m"
	write_report "Guest Session is Turned Off"
	sleep 3s
}

function email_copy()
{
	cd_files
	#Copying Email ID list to Desktop
	sudo cp eMail.pdf ~/Desktop/
	sudo chown $USER ~/Desktop/eMail.pdf
	write_report "eMail file copied to Desktop"
	sleep 3s
}

function util_install()
{
	/bin/echo -e "\e[36mUtilities installation\e[0m"
	echo ""
	echo ""
	#Installing GDebi Package Installer
	/bin/echo -e "\e[36mGDebi installation\e[0m"
	sudo apt install -y gdebi

	#Installing SSH
	/bin/echo -e "\e[36mSSH installation\e[0m"
	sudo apt install -y ssh

	#Installing Samba
	/bin/echo -e "\e[36mSamba installation\e[0m"
	sudo apt install -y samba

	#Installing Xarchiver
	/bin/echo -e "\e[36mXarchiver installation\e[0m"
	sudo apt install -y xarchiver

	#Installing GParted
	/bin/echo -e "\e[36m GParted installation\e[0m"
	sudo apt install -y gparted

	#Installing 7-Zip
	/bin/echo -e "\e[36m 7-Zip installation\e[0m"
	sudo apt install -y p7zip-full

	#Adding PPA of LibreOffice for future updates
	sudo add-apt-repository -y ppa:libreoffice/ppa

	#Installing PDF Shuffler
	/bin/echo -e "\e[36m PDF Shuffler installation\e[0m"
	sudo apt install -y pdfshuffler

	#Installing Stacer System Monitor Utility
	#/bin/echo -e "\e[36m Stacer installation\e[0m"
	#sudo add-apt-repository -y ppa:oguzhaninan/stacer
	#sudo apt update
	sudo apt install -y stacer

	#Installing GrUB Customizer
	#/bin/echo -e "\e[36m GrUB Customizer installation\e[0m"
	#sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
	#sudo apt update
	#sudo apt install -y grub-customizer

	#Installing Synaptic Package Manager
	#/bin/echo -e "\e[36mSynaptic installation\e[0m"
	#sudo apt install -y synaptic

	#Installing Boot Repair
	#/bin/echo -e "\e[36m Boot Repair installation\e[0m"
	#sudo add-apt-repository -y ppa:yannubuntu/boot-repair
	#sudo apt update
	#sudo apt install -y boot-repair

	#Install Brasero Disc Burner
	#Installing this app since, it's not pre-loaded in Ubuntu
	#/bin/echo -e "\e[36m Brasero installation\e[0m"
	#sudo apt install -y brasero

	#Installing GScan2PDF scanning utility
	#/bin/echo -e "\e[36mGSan2PDF installation\e[0m"
	#sudo add-apt-repository -y ppa:jeffreyratcliffe/ppa
	#sudo apt update
	#sudo apt -y install gscan2pdf

	#Installing NeoFetch System Information Tool
	#/bin/echo -e "\e[36m Neofetch installation\e[0m"
	#sudo add-apt-repository -y ppa:dawidd0811/neofetch
	#sudo apt update
	#sudo apt install -y neofetch

	#Installing Simple Screen Recorder
	/bin/echo -e "\e[36m Simple Screen Recorder installation\e[0m"
	sudo add-apt-repository -y ppa:maarten-baert/simplescreenrecorder
	sudo apt update
	sudo apt install -y simplescreenrecorder

	gimp_install

	vlc_install

	/bin/echo -e "\e[32mUtilities installed successfully\e[0m"
	write_report "Utilities installed"
	sleep 3s
}

function gimp_install()
{
	#Installing GIMP - GNU Image Manipulation Program
	/bin/echo -e "\e[36mGIMP installation\e[0m"
	sudo apt install -y gimp
	write_report "GIMP installed"
	sleep 3s
}

function vlc_install()
{
	#Installing VLC Media Player
	/bin/echo -e "\e[36mVLC installation\e[0m"
	sudo apt install -y vlc
	write_report "VLC installed"
	sleep 3s
}

function gnometweak_install()
{
	#Installing GNOME Tweaks Tool
	/bin/echo -e "\e[36mGNOME Tweaks Tool installation\e[0m"
	sudo apt install -y gnome-tweaks
	write_report "GNOME Tweaks Tool installed"
	sleep 3s
}

function unitytweak_install()
{
	#Installing Unity Tweaks Tool
	/bin/echo -e "\e[36mUnity Tweaks Tool installation\e[0m"
	sudo apt install -y unity-tweak-tool
	write_report "Unity Tweaks Tool installed"
	sleep 3s
} 

function unityicons()
{
	/bin/echo -e "\e[36mSetting icons in Unity Launcher (16.04)\e[0m"
	#Setting icons of frequently used Apps in Unity Launcher
	gsettings set com.canonical.Unity.Launcher favorites "['application://simple-scan.desktop', 'application://org.gnome.Nautilus.desktop', 'application://firefox.desktop', 'application://google-chrome.desktop', 'application://palemoon.desktop', 'application://libreoffice-writer.desktop', 'application://libreoffice-calc.desktop', 'application://gedit.desktop', 'application://gnome-calculator.desktop', 'application://com.teamviewer.TeamViewer.desktop', 'application://anydesk.desktop', 'application://unity-control-center.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"
	write_report "Icons placed in Unity Launcher"
	sleep 3s
}

function gnomeicons()
{
	/bin/echo -e "\e[36mSetting icons in GNOME Panel (18.04)\e[0m"
	#Setting icons of frequently used Apps in Gnome Panel
	gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'simple-scan.desktop', 'firefox.desktop', 'palemoon.desktop', 'google-chrome.desktop', 'libreoffice-writer.desktop', 'libreoffice-calc.desktop', 'system-config-printer.desktop', 'org.gnome.gedit.desktop', 'org.gnome.Calculator.desktop', 'anydesk.desktop', 'Kavach.desktop', 'gnome-control-center.desktop']"
	write_report "Icons placed in GNOME Panel"
	sleep 3s
}

function wallpaper()
{
	#Changing default wallpaper
	/bin/echo -e "\e[36mSetting Wallpaper\e[0m"
	cd_files
	sudo mkdir /home/$USER/Pictures/Wallpapers/
	sudo cp wallpaper.jpg /home/$USER/Pictures/Wallpapers/wallpaper.jpg
	sudo chown $USER -R /home/$USER/Pictures/Wallpapers/wallpaper.jpg
	gsettings set org.gnome.desktop.background picture-uri "file:///home/$USER/Pictures/Wallpapers/wallpaper.jpg"
	/bin/echo -e "\e[32mWallpaper set successfully\e[0m"
	write_report "Wallpaper set"
	sleep 3s
}

function gen_checksum()
{
	#This function is to generate MD5 checksum in order to ensure integrity of 
	#the script package ubuntu64.zip
	#changing directory to the location of ubuntu64.zip
	cd_desktop
	#calculating MD5 checksum for ubuntu64.zip
	md5=$(md5sum ubuntu64.zip)

	#checking if the checksum.md5 file exists
	if [ -e checksum.md5 ]; then
    	#if the checksum.md5 file exist, append the incoming message
		#emptying checksum.md5
		> checksum.md5
		/bin/echo -e "Checksum of ubuntu64.zip" >> checksum.md5
		/bin/echo -e "------------------------" >> checksum.md5
		/bin/echo -e "\nMD5:$md5" >> checksum.md5
		/bin/echo -e "\n\n" >> checksum.md5
		/bin/echo -e "Checksum of all files in ubuntu64.zip" >> checksum.md5
		/bin/echo -e "-------------------------------------\n\n" >> checksum.md5

		#Generating MD5 checksum for all the files inside ubuntu64 in order to ensure integrity
		find ~/Desktop/ubuntu64/ -type f -exec md5sum {} \; >> ~/Desktop/checksum.md5
		
	else
    	#creating a blank checksum.md5 file if doesn't exist already
		touch checksum.md5
		/bin/echo -e "Checksum of ubuntu64.zip" >> checksum.md5
		/bin/echo -e "------------------------" >> checksum.md5
		/bin/echo -e "\nMD5:$md5" >> checksum.md5
		/bin/echo -e "\n\n" >> checksum.md5
		/bin/echo -e "Checksum of all files in ubuntu64.zip" >> checksum.md5
		/bin/echo -e "-------------------------------------\n\n" >> checksum.md5

		#Generating MD5 checksum for all the files inside ubuntu64 in order to ensure integrity
		find ~/Desktop/ubuntu64/ -type f -exec md5sum {} \; >> ~/Desktop/checksum.md5
	fi
}

function java_settings()
{
	cd ~/
	sudo rm -rf .java/
	cd_files
	sudo cp -rf .java/ ~/
	sudo chmod 777 -R ~/.java/
	/bin/echo -e "\e[32mJava Settings Configured\e[0m"
	write_report "Java Settings Configured"
}

function palemoon_settings()
{
	cd ~/
	sudo rm -rf .moonchild\ productions/
	cd_files
	sudo cp -rf .moonchild\ productions/ ~/
	sudo mkdir -p ~/.cache/moonchild\ productions/
	sudo chmod 777 -R ~/.moonchild\ productions/
	sudo chmod 777 -R ~/.cache/moonchild\ productions/
	/bin/echo -e "\e[32mPaleMoon Settings Configured\e[0m"
	write_report "PaleMoon Settings Configured"
}

function keyboard_settings()
{
	gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'in+mal_enhanced')]"
	/bin/echo -e "\e[32mKeyboards Added\e[0m"
	write_report "Keyboards Added"
}

function codename_spec()
{
	if [ $code_name = "focal" -o $code_name = "bionic" ];
	then
    	gnometweak_install
    	gnomeicons
    	elif [ $code_name = "xenial" ]
    	then
        	guestoff
        	unitytweak_install
        	unityicons
    	else
        	/bin/echo -e "\e[32mThis OS version is not supported.Skipping...\e[0m"
	fi
}

function write_report()
{
	#This function is to create and display a brief installation report on the go
	#changing to the directory where the report is to be created
	cd_ubuntu
	#checking if the report file exists
	if [ -e install_report.txt ]; then
    	#if the report file exist, append the incoming message
		echo "$1" >> install_report.txt
	else
    	#creating a blank report file if doesn't exist already
		touch install_report.txt
		echo "$1" > install_report.txt
	fi
}

function show_report()
{
	#changing to the directory where the report is stored
	cd_ubuntu
	#checking if the report file exists
	if [ -e install_report.txt ]; then	
		#Displaying the installation summary
		/bin/echo -e "\e[36mInstallation Summary\e[0m"
		echo " "
		/bin/echo -e "\e[32m$(cat install_report.txt)\e[0m"
	else
		#creating a blank report file if doesn't exist already
		touch install_report.txt
	fi
}