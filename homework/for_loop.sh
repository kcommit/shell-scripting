#1/bin/bash

# Title: Fruits items
# Purpose: Creating Fruits List wit item No

fruits=("grapes" "banana" "orange" "apricot" "mango")
	item_number=1

	for fruit in "${fruits[@]}"
	do
		echo "item $item_number: $fruit"
	       item_number=$((item_number + 1))
       done

exit 0       
