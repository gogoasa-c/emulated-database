#!/bin/bash
view()
{
	echo " ID     NUME CARTE            AUTOR	EDITURA	PRET"
	sort baza_date.txt
}

add()
{
	repeat=y
	while [ "$repeat" = "y" ] || [ "$repeat" = "Y" ]
	do
		echo -n "ID = "
		read ID
		echo -n "Nume carte = "
		read b_name
		echo -n "Autor = "
		read a_name
		echo -n "Editura = "
		read e_name
		echo -n "Pret = "
		read price
		echo -e "$ID,\t$b_name,\t$a_name,\t$e_name,\t$price" >> baza_date.txt
		echo -n "Add more items? [Yy]/[Nn]"
		read repeat
	done
}

search()
{
	echo -n "ID?"
	read id
	if grep -q "$id" baza_date.txt
	then
		grep "$id" baza_date.txt
	else
		echo "Element not found."
	fi
}

update()
{
	echo "ID?"
	read id
	grep "$id" baza_date.txt
	echo "Do you want to modify this element? [Yy]/[Nn]"
	read conf
	if [ "$conf" = "y" ] || [ "$conf" = "y"]
	then
		if grep -q "$id" baza_date.txt
		then
			touch temp.txt
			touch modify.txt
			touch item.txt
			touch desired.txt
			grep -v "$id" baza_date.txt > temp.txt
			grep "$id" baza_date.txt > modify.txt
			echo "What element do you wish to modify?"
			echo "2 - Book; 3 - Author; 4 - Publisher; 5 - Price"
			read i
			case $i in
			2)
				awk -F, '{print $2}' modify.txt > item.txt
				oldvalue=$(<item.txt)
			;;
			3)
				awk -F, '{print $3}' modify.txt > item.txt
				oldvalue=$(<item.txt)
			;;
			4)
				awk -F, '{print $4}' modify.txt > item.txt
				oldvalue=$(<item.txt)
			;;
			5)
				echo -ne "\t" > item.txt
				awk -F, '{print $5}' modify.txt >> item.txt
				oldvalue=$(<item.txt)
			;;
			*)
				exit
			;;
			esac
			echo "Updated value: "
			read newvalue
			
			sed "s/$oldvalue/$newvalue/" modify.txt > desired.txt
			cat temp.txt > baza_date.txt
			cat desired.txt >> baza_date.txt
			rm temp.txt
			rm modify.txt
			rm item.txt
			rm desired.txt
		else
			echo "Item non-existent"
		fi
	fi
}

delete()
{
	echo "ID?"
	read id
	grep "$id" baza_date.txt
	echo "Are you sure you want to delete this element? [Yy]/[Nn]"
	read confirm
	if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]
	then
		grep -v "$id" baza_date.txt > aux.txt
		cat aux.txt > baza_date.txt
		rm aux.txt
	fi
}

out()
{
	exit
}
