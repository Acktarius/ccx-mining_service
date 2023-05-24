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
echo -e "#${WHITE} This script will place ccx-mining.service ${GRIS}                     -=:+-.  .-=:=:"
echo -e "#${WHITE} in /etc/systemd/system ${GRIS}                                        -=:+."
echo -e "#${WHITE} and enable the Service ${GRIS}                                        -=:+."
echo -e "#                                                           \t -=:+."
echo -e "#                                                           \t -=:=."
echo -e "#                                                           \t -+:-:    .::."
echo -e "#                                                           \t -+==------===-"
echo -e "###############################################################\t    :-=-==-:\n"
#question
read -p "Do you want to install mining service ? (Y/n)" answer
case "$answer" in
	Y|Yes|yes|y)
#check is oc is in place
	if [[ ! -f /opt/conceal-toolbox/oc-amd/oc-amd.sh ]]; then 
	sudo cp /opt/conceal-toolbox/mining_service/ccx-mining_temp_no_oc.service /etc/systemd/system/ccx-mining.service
	else
	sudo cp /opt/conceal-toolbox/mining_service/ccx-mining_temp_oc.service /etc/systemd/system/ccx-mining.service
	fi
sudo systemctl enable ccx-mining.service
sudo systemctl daemon-reload
echo -e "${WHITE}Service is in place and enabled${TURNOFF}!"
	exit
	;;
	*)
echo -e "${WHITE}Nothing has been done${TURNOFF}!"
sleep 2
	exit
	;;
esac
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
