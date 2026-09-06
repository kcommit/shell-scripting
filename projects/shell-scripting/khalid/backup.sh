#!/bin/bash

if [[ "$?" -eq 0 ]]; then
    echo "The backup script succeeded."
else
    echo "The backup script failed."
fi
