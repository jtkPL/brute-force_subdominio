#!/bin/bash

echo ""
echo "[ ** BRUTE FORCE SUB DOMAIN ** ]"
echo ""

if [ "$1" != "" ]
then
    verify_domain=$(host $1 | grep "NXDOMAIN" | cut -d ")" -f1 | cut -d "(" -f2)
fi

if [ "$1" = "" -o "$2" = "" -o "$verify_domain" = "NXDOMAIN" ]
then
    echo "usage: bash sub_domain.sh <domain> <wordlist>"
    echo ""
else
    echo "" > file.txt

    i=$(cat $2 | wc -l)
    n=0

    for prefix_sub in $(cat $2)
    do
        if [ "$prefix_sub" != "" ]
        then 
            sub_domain=$(host -t A $prefix_sub.$1 | grep -v "NXDOMAIN" | cut -d " " -f1) 
            
            if [ "$sub_domain" != "" ]
            then 
                ip_sub_domain=$(host -t A $sub_domain | cut -d " " -f4)
                echo "$sub_domain : $ip_sub_domain" >> file.txt
            fi
            
        fi
        ((n++))
        echo "[$n]de[$i]"
    done 
fi

