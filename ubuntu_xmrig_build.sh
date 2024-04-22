#!/bin/bash 
#Author: New Wavex86 
#Date Created: Thu Apr 18 06:47:24
#Script i created for the Codey 
#Will download, and build the xmrig program..also gives usage to download the monero wallet



#Doms Wallet
WALLET="45GPMasYkZgCtSyMs3nCbSVzSQTgpwHwjZapcucRmdBy38uS15NHqKcXP9J7HNokSe9MersndaYyp8o6frGvzjtxV6t9ygu" 

wallet-get(){

	read -p "Do you want to mine to dom's wallet?[Y/n]" WREPLY

	if [ $WREPLY == "Y" ];
	then
		WALLET="45GPMasYkZgCtSyMs3nCbSVzSQTgpwHwjZapcucRmdBy38uS15NHqKcXP9J7HNokSe9MersndaYyp8o6frGvzjtxV6t9ygu" 
	else
		read -p "Enter Wallet address..\n" WALLET

	fi

}



make_global(){

	#Save xmrig command to a variable
	xmrig_command=$(alias xmrig_mine='./xmrig -o gulf.moneroocean.stream:10001 -u ${WALLET}')

	#Check if bash_alias file exists
	if [ -f .bash_aliases ];
	then
		echo ${xmrig_command} >> .bash_aliases

	#Bash_alias file doesent exist..
	else
		
		touch $HOME/.bash_aliases
		echo ${xmrig_command} >> .bash_aliases

	fi

}


sudo-check(){
	#Check if root
	if [ $EUID -eq 0 ]
	then
		echo "You are root, please turn rerun without\n sudo"
		exit 0

	else
		echo "NO sudo!..contiuing to run program"

	fi


}

startup(){

	#Check if install already ran
	if [[ $(sudo cat .bashrc | grep "xmrig_command" ) ]]
	then
		echo "Install already occured"

	else
		echo "Installing packages.."
		sleep 1

		#Install the necessary packages 
s		sudo apt install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev

		#Update the packages

		sudo apt update -yy && sudo apt full-upgrade -yy

	fi

}


sudo-check

echo "setting up monero wallet.."
#wallet-get
echo "Wallet all set up"

echo "Installing necessary packages.."
sleep 1
startup
sleep 1

#Get into Home Directory
cd $HOME/

#Get xmrig
git clone https://github.com/xmrig/xmrig.git
cd xmrig
mkdir
cd build

#Build the xmrig binary
cmake ..
make

clear
echo "xmrig miner added to aliases\n alias: xmrig_command"
sleep 2

echo "please restart system before running the miner"



exit 0 
