#!/bin/bash

# Colors
default='\033[0m'    # Default ${default}
red='\033[0;31m'     # Red     ${red}
green='\033[0;32m'   # Green   ${green}
blue='\033[0;34m'    # Blue    ${blue}
cyan='\033[0;36m'    # cyan    ${cyan}
yellow='\033[00;33m' # Yellow  ${yellow}
white='\033[01;37m'  # White   ${white}

# Vars / const
options='+nocomments +stats'
sites="$(cat sites.txt)"


# User input
echo -e "${white}=============================================================${default}"
echo -e "${blue}Please choose a DNS server. ${default}"
echo -e "${red}1) - ${white}Cloudflare${default}"
echo -e "${red}2) - ${white}Google${default}"
echo -e "${red}3) - ${white}OpenDNS${default}"
echo -e "${red}4) - ${white}Norton ConnectSafe${default}"
echo -e "${red}5) - ${white}Comodo Secure DNS${default}"
echo -e "${red}6) - ${white}Quad9${default}"
echo -e "${red}7) - ${white}FreeDNS${default}"
echo -e "${red}8) - ${white}Verisign${default}"
echo -e "${red}9) - ${white}127.0.0.1 (Local DNS)${default}"
echo -e "${blue}If you want to use another ${white}DNS server${blue} just type the IP address${default}"
echo -e "${white}=============================================================${default}"
echo -ne "${red}My choose: ${default}"
read dns


# $dns's conditions

if [ "$dns" == "1" ]; then
	dns="1.1.1.1"

elif [ "$dns" == "2" ]; then
	dns="8.8.8.8"

elif [ "$dns" == "3" ]; then
	dns="208.67.220.220"

elif [ "$dns" == "4" ]; then
	dns="199.85.126.10"

elif [ "$dns" == "5" ]; then
	dns="8.26.56.26"

elif [ "$dns" == "6" ]; then
	dns="9.9.9.9"

elif [ "$dns" == "7" ]; then
	dns="37.235.1.174"

elif [ "$dns" == "8" ]; then
	dns="64.6.64.6"

elif [ "$dns" == "9" ]; then
	dns="127.0.0.1"

else
	dns=$dns
fi


# Main menu
echo -e "${green}============================== Main menu ==============================${default}"
echo -ne "${green}(1) ${white}- Default list / ${green}(2)${white} Custom / ${green}(3)${white} - Install dependencies ${default}: "
read choose
echo -e "${green}============================== Main menu ==============================${default}"


# $choose's conditions

if [ "$choose" == "1" ]; then
	echo -e "${red}Using DNS - ${yellow}$dns${default}"
	echo -e "${blue}"
	/usr/bin/dig @${dns} ${options} ${sites} | awk '/Query time/ { total += $4; count++ }
						                     END {print "Average query time:", total/count, "ms" }'
	echo -e "${default}"


elif [ "$choose" == "2" ]; then
	echo -ne "${blue}Please write the sites here. ${white}Example: ${blue}( google.com instagram.com ) : ${default}"
	read custom_list
	echo -e "${blue}"
	/usr/bin/dig @${dns} ${options} $custom_list | awk '/Query time/ { total += $4; count++ } 
                                                 END {print "Average query time:", total/count, "ms" }'
	echo -e "${default}"


elif [ "$choose" == "3" ]; then
apt-get install -y dnsutils


else
echo -e "${blue}Please choose a ${white}valid number${default}"
fi


