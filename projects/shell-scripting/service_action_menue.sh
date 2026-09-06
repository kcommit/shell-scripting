while true
do
    read -r -p "Do you create a new user ? enter y or n or for quit q: " action

    case "$action" in
        y)
            read -r -p "Enter username: " username

            sudo useradd -m -s /bin/bash "$username" &&

            #sudo passwd "$username" &&

            echo "$username:$username@123" | sudo chpasswd &&

            sudo chage -d 0 "$username" &&

            id "$username" &&

            getent passwd "$username" &&

            echo "New user added: $username" ||

            echo "user creation failed: $username"
            ;;

        n)
            echo "Stopping..."
            ;;

        q)
            echo "Goodbye."
            break
            ;;
        *)
            echo "Unknown action." >&2
            ;;
    esac
done
