#!/bin/bash

# Display an action for a traffic-light color

read -r -p "Enter traffic-light color (red/yellow/green): " light

if [ "$light" = "red" ]
then
    echo "Stop"
elif [ "$light" = "yellow" ]
then
    echo "Wait"
elif [ "$light" = "green" ]
then
    echo "Go"
else
    echo "Unknown color"
fi
