#!/bin/bash
# this file is subject to Licence
# Copyright (c) 2023, Acktarius

case "$TERM" in
        xterm-256color)
        WHITE=$(tput setaf 7 bold)
        ORANGE=$(tput setaf 202)
        GRIS=$(tput setaf 245)
	LINK=$(tput setaf 4 smul)
        TURNOFF=$(tput sgr0)
        ;;
        *)
        WHITE=''
	ORANGE=''
        GRIS=''
	LINK=''
        TURNOFF=''
        ;;
esac
#in case no mining service installed
if [[ ! -f /etc/systemd/system/ccx-mining.service ]]; then
#presentation
echo -e "${GRIS}###############################################################      .::::."
echo -e "#                                                                .:---=--=--::."
echo -e "#${WHITE} This script will generate ccx-mining.service ${TURNOFF}${GRIS}          \t -=:+-.  .-=:=:"
echo -e "#${WHITE} in /etc/systemd/system ${TURNOFF}${GRIS}                                        -=:+."
echo -e "#${WHITE} and enable the Service ${TURNOFF}${GRIS}                                        -=:+."
echo -e "#                                                           \t -=:+."
echo -e "#                                                           \t -=:=."
echo -e "#                                                           \t -+:-:    .::."
echo -e "#                                                           \t -+==------===-"
echo -e "###############################################################\t    :-=-==-:\n"
#question
sleep 1
if zenity --question --title "Confirm to proceed" --width 400 --height 80 --text "Do you want to generate mining service ?"
then
sleep 1
WDIR=$(zenity --file-selection --title="Select the miner working Directory" --width 400 --height 250 --directory)
case $? in
        0)

	MINER=$(zenity --file-selection --title="Select the miner executable File" --width 400 --height 250)

	case $? in
     		0)

#check is oc is in place
	if [[ ! -f /opt/conceal-toolbox/oc-amd/oc-amd.sh ]]; then 
		sudo cp /opt/conceal-toolbox/mining_service/ccx-mining_temp_no_oc.service /opt/conceal-toolbox/mining_service/ccx-mining_temp.service
	else
		sudo cp /opt/conceal-toolbox/mining_service/ccx-mining_temp_oc.service /opt/conceal-toolbox/mining_service/ccx-mining_temp.service
	fi
sudo sed -i "s~WWW~$WDIR~g" /opt/conceal-toolbox/mining_service/ccx-mining_temp.service
sudo sed -i "s~XXX~$MINER~g" /opt/conceal-toolbox/mining_service/ccx-mining_temp.service
sudo mv /opt/conceal-toolbox/mining_service/ccx-mining_temp.service /etc/systemd/system/ccx-mining.service
sudo systemctl enable ccx-mining.service
sudo systemctl daemon-reload
        	;;
		1)
                echo "No file selected."
		sleep 1
		exit
		;;
        	-1)
                echo "An unexpected error has occurred."
		sleep 1
		exit
		;;
		esac
	;;
	1)
	echo "No directory selected."
	sleep 1
	exit
	;;
	-1)
	echo "Unexpected Error !"
	sleep 1
	exit
	;;
esac
fi
fi
#in case service actif
actif=$(systemctl status ccx-mining | head -n 5 | grep -c "Active: a")
if [[ "$actif" > 0 ]]; then
#presentation
echo -e "${GRIS}###############################################################      .::::."
echo -e "#                                                                .:---=--=--::."
echo -e "#${WHITE} Mining Service is${ORANGE} Actif,${GRIS}      \t\t\t\t -=:+-.  .-=:=:"
echo -e "#${WHITE} this script will Stop AND Disable it. ${GRIS}    \t\t\t -=:+."
echo -e "#                                                           \t -=:+."
echo -e "#                                                           \t -=:+."
echo -e "#                                                           \t -=:=."
echo -e "#                                                           \t -+:-:    .::."
echo -e "#                                                           \t -+==------===-"
echo -e "###############################################################\t    :-=-==-:\n"

if zenity --question --title "Confirm to proceed" --width 400 --height 80 --text "Do you want to disable mining service ?"
then
echo -e "mining service will be${ORANGE} disabled${TURNOFF}"
sudo systemctl stop ccx-mining.service
sudo systemctl disable ccx-mining.service
sudo systemctl daemon-reload
else
echo -e "${WHITE}Nothing has been done${TURNOFF}!"
sleep 2
fi
exit
fi

#in case it's disabled
disabled=$(systemctl status ccx-mining | head -n 5 | grep -c "disabled")
if [[ "$disabled" > 0 ]]; then
#presentation
echo -e "${GRIS}###############################################################      .::::."
echo -e "#                                                                .:---=--=--::."
echo -e "#${WHITE} Mining Service is${ORANGE} Disabled,${GRIS}   \t\t\t\t -=:+-.  .-=:=:"
echo -e "#${WHITE} this script will Enable it. ${GRIS}      \t\t\t\t -=:+."
echo -e "#                                                           \t -=:+."
echo -e "#                                                           \t -=:+."
echo -e "#                                                           \t -=:=."
echo -e "#                                                           \t -+:-:    .::."
echo -e "#                                                           \t -+==------===-"
echo -e "###############################################################\t    :-=-==-:\n"
#
if zenity --question --title "Confirm to proceed" --width 400 --height 80 --text "Do you want to enable mining service ?"
then
	echo "mining service will be enable ?"
sudo systemctl enable ccx-mining.service
sudo systemctl daemon-reload
else
echo -e "${WHITE}Nothing has been done${TURNOFF}!"
sleep 2
fi
exit
fi

#in case service is enabled but not actif
enabled=$(systemctl status ccx-mining | head -n 5 | grep -c "enabled")
inactive=$(systemctl status ccx-mining | head -n 5 | grep -c "inactive")
if [[ "$enabled" > 0 ]] && [[ "$inactive" > 0 ]] ; then

#presentation
echo -e "${GRIS}###############################################################      .::::."
echo -e "#                                                                .:---=--=--::."
echo -e "#${WHITE} Mining Service is${ORANGE} Enabled${WHITE} but ${ORANGE}not Activated${TURNOFF} ${GRIS}\t\t\t -=:+-.  .-=:=:"
echo -e "#${WHITE} Use Conceal Assistant :  ${TURNOFF} ${GRIS}    \t\t\t\t -=:+."
echo -e "# ${LINK}http://127.0.0.1:3500/${TURNOFF} ${GRIS}           \t\t\t\t -=:+."
echo -e "#                                                           \t -=:+."
echo -e "#                                                           \t -=:=."
echo -e "#                                                           \t -+:-:    .::."
echo -e "#                                                           \t -+==------===-"
echo -e "###############################################################\t    :-=-==-:\n"
sleep 5
exit
fi
