#!/bin/bash
#Written by: Sohrab 
#Name of the script: UserManagement
#Date: 11/18/2020
#Description: User and group management in Linux

clear
echo "**********Welcome to my lab presentation**********"
sleep 1
echo "**********Written by: Sohrab**********"
sleep 3
#our while loop which will stop if we input Q or q for choice
while [ "$choice" != "Q" ]&&[ "$choice" != "q" ]
do
	clear
	echo
	echo "====================================================="
	echo "                 User Management            		   "
	echo "====================================================="
	echo "A) Create a user account"
	echo "B) Delete a user account"
	echo "C) Change supplementary group for a user account"
	echo "D) Change initial group for a user account"
	echo "E) Change default login shell for a user account"
	echo "F) Change account expiration date for a user account"
	echo "U) Update the system with using U or use UPG to update and upgrade the system"
	echo "Q) Quit"
	
	read -r -p "What would you like to do?: " choice
	
	#if statement which if choice is A or a it will ask for a username and will create the user account
	if [ '$choice' == "A" ]||[ '$choice' == "a" ]
	then
		echo
		#getting the username that we want to add
		read -r -p "Enter the username: " username
		#command for adding the user
		sudo useradd $username
		#indicates if previous command has been successful and if so will show a message to infrome the user
		if [[ $? == 0 ]]
                then
                        echo "$username's account has been successfully created"
                fi
		#confirming by checking the /etc/passwd file
		echo "Confirmation: " 
		cat /etc/passwd | grep $username
		#waiting 3 second at the end of the loop so the clinet can have time to read the result
		sleep 3
	fi

	#if statement which if choice is B or b will run and first it will show last 10 users that have been added to system then it ask which user client wants to remove and shows a confirmation
	if [ "$choice" == "B" ]||[ "$choice" == "b" ]
	then
		echo
		#showing the last 10 user that have been added on system
		echo "Last 10 users that have been added to the system: "
		tail /etc/passwd
		#getting the username that we want to delete
		read -r -p "Enter the username you want to delete: " username
		#command for deleting the selected user
		sudo userdel $username
                #indicates if previous command has been successful and if so will show a message to infrome the user
		if [[ $? == 0 ]]
		then
			echo -e "$username record has been successfully deleted"
		fi
		#waiting 3 second at the end of the loop so the clinet can have time to read the result
		sleep 3
	fi
	
	#if statement which if choice is C or c it will either replace the exisitng supplementary groups or add to them depending on user's selected option
	if [ "$choice" == "C" ]||[ "$choice" == "c" ]
	then
		#asking user if we want to replace or add to supplementary groups
		echo
		echo "A) Replace existing supplementary groups"
		echo "B) Adding a supplementary group to existing ones"
		#getting the user's selected option
		read -r -p "Choose your option: " opt

		#if statement which if selected option as opt is equal to A or a which we will replace exisiting supplementary groups
		if [ "$opt" == "A" ]||[ "$opt" == "a" ]
		then
			#getting username and supplementary groups
			read -r -p "Enter username of the user you wish to modify: " user
			read -r -p "Enter name of the supplementary group or groups with seprating them with commas: " supG
			#command that we use to replace the exisiting supplementary groups
			sudo usermod -G $supG $user
			#indicates if previous command has been successful and if so will show a message to infrome the user
			if [[ $? == 0 ]]
			then
				 echo "The supplementary group or groups has been added successfully"
			fi
			#showing the groups which the user is part of as supplementary group
			echo "Current group or groups that user is associated: "
			cat /etc/group | grep $user
			#waiting 3 second at the end of the loop so the clinet can have time to read the result
			sleep 3
		fi

		#if statement which if selected option as opt is equal to B or b which we will add to exisiting supplementary groups
	 	if [ "$opt" == "B" ]||[ "$opt" == "b" ]
		then
			#getting username and supplementary groups
			read -r -p "Enter username of the user you wish to modify: " user
			read -r -p "Enter name of the supplementary group or groups with seprating them with commas: " supG
			#command that we use to replace the exisiting supplementary groups
			sudo usermod -a -G $supG $user
			#indicates if previous command has been successful and if so will show a message to infrome the user
			if [[ $? == 0 ]]
			then
				echo "The supplementary group or groups has been added successfully"
			fi
			#showing the groups which the user is part of as supplementary group
			echo "Current group or groups that user is associated: "
			cat /etc/group | grep $user
			#waiting 3 second at the end of the loop so the clinet can have time to read the result
			sleep 3
		fi
	fi

	#if statement which if choice is equal to D or d which we will modify the primary group of the selected user
	if [ "$choice" == "D" ]||[ "$choice" == "d" ]
	then
		#getting username and initial group
		echo
		read -r -p "Enter username of the user you wish to modify: " user
		read -r -p "Enter name of the initial group you wish to assign for user $user: " iniG
		#command that we use to set the initial group for the selected user
		sudo usermod -g $iniG $user
		#indicates if previous command has been successful and if so will show a message to infrome the user
		if [[ $? == 0 ]]
		then
		        echo "The initial group has been changed successfully"
		fi
		#showing the initial group for the selected user as confirmation
		echo "Current primary group for user $user is: "
		id -gn $user
		#waiting 3 second at the end of the loop so the clinet can have time to read the result
		sleep 3

	fi
	
	#if statement which if choice is E or e, will modify the login shell for the selected user
	if [ "$choice" == "E" ]||[ "$choice" == "e" ]
	then
		#getting the username and the shell which we want to switch for the user
	        echo
		read -r -p "Enter username of the user you wish to modify: " user
		#showing the available shell for reference
		echo "Shells available on the system: "
		cat /etc/shells
		read -r -p "Enter the shell which you wish to switch on for user $user: " shell
		#command we use for modify the login shell
		sudo usermod -s $shell $user
		#indicates if previous command has been successful and if so will show a message to infrome the user
		if [[ $? == 0 ]]
		then
			echo "The shell has been changed successfully"
		fi
		#showing the initial group for the selected user as confirmation
		echo "User $user shell has been change to the following shell: "
		cat /etc/passwd | grep $user
		#waiting 3 second at the end of the loop so the clinet can have time to read the result
		sleep 3
	fi
	
	#if statement which if choice is F or f, will modify the expiration date for the selected user
	if [ "$choice" == "F" ]||[ "$choice" == "f" ]
	then
		#getting username and the new expiration date
		echo
		read -r -p "Enter username of the user you wish to modify: " user
		read -r -p "The date is specified in the format YYYY-MM-DD. Enter The date on which the user account will be disabled: " Date
		#command that we use for modifying the expire date
		sudo usermod -e $Date $user
		#indicates if previous command has been successful and if so will show a message to infrome the user
		if [[ $? == 0 ]]
		then
			echo "The user $user's expire date has been changed successfully"
			echo "$user's account will be expired at $Date. "
		fi
		#waiting 3 second at the end of the loop so the clinet can have time to read the result
		sleep 3
	fi

	#Updating the system if choice is u or U and updating and upgrading the system choice is UPG or upg
	if [ "$choice" == "U" ]||[ "$choice" == "u" ]||[ "$choice" == "upg" ]||[ "$choice" == "UPG" ]
	then
		echo "Updating the system..."
		sudo apt-get update
		if [ "$choice" == "upg" ]||[ "$choice" == "UPG" ]		
		then
			echo "Upgrading the system..."
			sleep 2
			sudo apt-get upgrade
		fi
	fi


#end of our while loop
done

#if statement which if choice is Q or q which will stop our while loop and will display a message
if [ "$choice" == "Q" ]||[ "$choice" == "q" ]
then
	echo "Goodbye... Have a nice day!"
fi





