#! /bin/sh

running=`pgrep xmouseless`

if [ "$running" = "" ]
then
	echo "<span>mouse inactive</span>"
else 
	echo "<span background=\"#FE7E29\" foreground=\"#232121\">               mouse active               </span>"
fi
