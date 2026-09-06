#!/bin/bash

# ==============================================================================
# PRO-TIP: To safely stop a running infinite loop in your terminal,
#          press Ctrl + C.
# ==============================================================================

# Print Pro-Tip to the terminal before entering the loop
echo -e "\033[01;33m[PRO-TIP]\033[00m Press \033[01;31mCtrl + C\033[00m at any time to safely stop this loop.\n"

while true; do                         # Loop forever
    echo "Running..."                  # Output status message
    sleep 2                            # Wait 2 seconds before next iteration
done                                   # End of loop
