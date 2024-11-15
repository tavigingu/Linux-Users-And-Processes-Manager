#!/bin/bash


can_login()
{
	if [[ $(sudo passwd -S "$1" | cut -d' ' -f2) == "NP" ]]; then
		return 1
	fi
	
	if [[ $(sudo passwd -S "$1" | cut -d' ' -f2) == "L" ]]; then
		return 2
	fi
	
	return 0	
}

fix_user()
{
	if [[ ! -z $(getent passwd "$1") ]]; then
		echo "userul $1 exista in sistem"
	else
		echo "userul $1 nu exista in sistem"
		exit 0
	fi
	
	can_login "$1"
	result=$(echo $?)
	echo "$result"
	if [[ $result -eq 0 ]]; then
		echo "se poate loga"
	elif [[ $result -eq 1 ]]; then
		echo "parola nu e setata"
		echo "vrei sa setezi parola?[y/n]"
		read ans;
		if [[ "$ans"=="y" ]]; then
			passwd "$1"
		fi
	elif [[ $result -eq 2 ]]; then
		echo "useru e blocat" 
		echo "parola nu e setata"
		echo "vrei sa setezi parola?[y/n]"
		read ans;
		if [[ "$ans"=="y" ]]; then
			sudo passwd "$1"
		fi
	fi  			
}

check_users()
{
	echo "in functie"
	if [[ ! -z $(getent passwd "$1") || ! -z $(getent passwd "$2") ]]; then
		#groupadd studenti
		#sudo usermod -aG studenti "$1"
		#sudo usermod -aG studenti "$2"
		
		echo "introduceti un director"
		read -r dir
		for file in $dir/*
		do
			if [[ $(stat -c%U "$file") == "$1" ]]; then
				#chown "$2" "$file"
				echo "s a schombat ownerul"
			fi
		done
			
	else
		echo "userii nu exista in sistem"
	fi
}

print_usersinfo()
{
	for username in "$@"
	do
		if [[ ! -z $(getent passwd "$username") ]]; then
			home=$(getent passwd "$username" | cut -d: -f6)
			grup=$(id -gn "$username")
			shell=$(getent passwd "$username" | cut -d: -f7)
			
			echo "$username $home $grup ${shell:+$shell}"
		else
			echo "nu exista"
		fi
	
	done

}

show_processes()
{
	sum=0
	while read -r line
	do
		#$line=$(echo "$line" | awk '{print $1, $2 / 1024}')
		val=$(echo "$line" | awk '{print $2 / 1024 }')
		sum=$(echo "$sum + $val" | bc)
	done <<< $(ps -eo user,vsz | egrep "$1")
	
	echo "$sum"
	
}


if [[ "$1" == "--proc" && $# -eq 2 ]]; then
	show_processes "$2"
elif [[ $# -eq 1 ]]; then
	echo "1"
	fix_user "$1"
elif [[ $# -eq 2 ]]; then
	check_users "$1" "$2"
elif [[ $# -gt 2 ]]; then
	print_usersinfo "$@"
else
	echo "script apelat incorect" 
fi

