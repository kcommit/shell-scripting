#!bin/bash

# Creating a User

read -r -p "Enter username: " username

sudo useradd -m -s /bin/bash "$username"  &&

# sudo passwd "$username" &&

echo "$username:abc" | sudo chpasswd

sudo chage -d 0 "$username"

id "$username" &&

getent passwd "$username" &&

echo "New user added: $username" ||

echo "user creation failed: $username"
