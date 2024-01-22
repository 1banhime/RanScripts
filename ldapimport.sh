#!/bin/bash

#script to add openLDAP user from a with info taken from csv file. 

logfile="LDAPIMPORT.log"  # define log file 
DN="" #your directories DN e.g DC=kirakira,DC=com
admin="" #your admin accounts DN e.g CN=1banhime,DC=kirakira,DC=com
pwd="" #the password for your admin account
serv="" #your server here e.g ldap://1banhime
if [ "$#" -ne 1 ]; then
    echo "INCORRECT # OF ARGUMENTS" >&2 #Exits script if incorrect number of arguments 
    exit 1
fi

#Used to use -e flag but it did not check if it was a regular file. it just checked if it exists
if [ ! -f "$1" ]; then
    echo "FILE ERROR" >&2 #Exits script if incorrect file given as agrument 
    exit 1
fi

while IFS="," read -r name uname passwd objclass gid; do #assigns the different fields in the CSV to variables
	hashpass=$(slappasswd -s $passwd)
	#Creates a string for the ldapadd command to use
	ldif=$(cat <<EOF
dn: uid=${uname},${DN}
objectClass: ${objclass}
uid: ${uname}
gid: ${gid}
cn: ${uname}
sn: ${uname}
givenName: ${name}
userPassword: ${hashpass}
EOF
		)
		echo "$ldif" | ldapadd -x -D $admin -w $pwd -H $serv | tee -a $logfile
		if [ $? -eq 0 ]; then
			echo $uname added succesfully
		else
			echo could not add $uname
		fi 
done < "$1" #Indicates the while loop to read from the arg

#ai kotoba no 1banhime
