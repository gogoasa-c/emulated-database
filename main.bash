#!/bin/bash

source ./functii.bash

while [ TRUE ]
do

echo "1) View"
echo "2) Add"
echo "3) Search"
echo "4) Update"
echo "5) Delete"
echo "6) Exit"

read n


if (( $n == 1 ))
then
	view
fi

if (( $n == 2 ))
then
	add
fi

if (( $n == 3 ))
then
	search
fi

if (( $n == 4 ))
then
	update
fi

if (( $n == 5 ))
then
	delete	
fi

if (( $n == 6 ))
then
	out
fi
done
