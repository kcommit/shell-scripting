#!/bin/bash
#
#study CASE
#

read -r -p "Enter y or n: " answer

case "$answer" in 
    y|Y|yes|Yes|YES)
        echo "You selected Yes"
        ;;

    n|N|NO|no)
        echo "You selected No"
        ;;

    *)
        echo "Invalid answer"  1>&2
        exit 1
        ;;

    esac
exit 0
    
