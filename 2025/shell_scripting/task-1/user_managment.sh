#!/bin/bash

# Function to check if a user already exists
check_user_exists() {
    id "$1" &>/dev/null
    return $?
}

# Function to create a new user account
create_user() {
    read -p "Enter new username: " username

    # Checkng if user exists
    if check_user_exists "$username"; then
        echo "Error: User '$username' already exists."
        exit 1
    fi

    read -s -p "Enter password for $username: " password
    echo

    # Create user and set password
    sudo useradd -m "$username" && echo "$username:$password" | sudo chpasswd

    if [ $? -eq 0 ]; then
        echo "Success: User '$username' has been created."
    else
        echo "Error: Failed to create user '$username'."
        exit 1
    fi
}

# Function to delete an existing user account
delete_user() {
    read -p "Enter username to delete: " username

    # Check if username exists
    if ! check_user_exists "$username"; then
        echo "Error: User '$username' does not exist."
        exit 1
    fi

    # Delete the user
    sudo userdel -r "$username"

    if [ $? -eq 0 ]; then
        echo "Success: User '$username' has been deleted."
    else
        echo "Error: Failed to delete user '$username'."
        exit 1
    fi
}

# Function to reset the password of an existing user
reset_password() {
    read -p "Enter username to reset password: " username

    # Check if username exists
    if ! check_user_exists "$username"; then
        echo "Error: User '$username' does not exist."
        exit 1
    fi

    read -s -p "Enter new password for $username: " password
    echo

    # Reset the password
    echo "$username:$password" | sudo chpasswd

    if [ $? -eq 0 ]; then
        echo "Success: Password for user '$username' has been reset."
    else
        echo "Error: Failed to reset password for user '$username'."
        exit 1
    fi
}

# Function to list all user accounts with UID greater than 1000
list_users() {
    echo "User accounts on this system (UID > 1000):"
    awk -F: '($3 >= 1000) { printf "%-15s UID: %-5s Home: %-25s Shell: %s\n", $1, $3, $6, $7 }' /etc/passwd | column -t
}

# Function to modify user account properties
modify_user() {
    read -p "Enter the username to modify: " username

    # Check if username exists
    if ! check_user_exists "$username"; then
        echo "Error: User '$username' does not exist."
        exit 1
    fi

    echo "Select the property to modify:"
    echo "1) Username:"
    echo "2) User ID (UID):"
    echo "3) Home Directory:"
    echo "4) Default Shell:"
    read -p "Enter your choice (1-4): " choice

    case "$choice" in
        1)
            read -p "Enter new username: " new_username
            sudo usermod -l "$new_username" "$username"
            [ $? -eq 0 ] && echo "Username changed to '$new_username'." || echo "Failed to change username."
            ;;
        2)
            read -p "Enter new UID: " new_uid
            sudo usermod -u "$new_uid" "$username"
            [ $? -eq 0 ] && echo "UID changed to '$new_uid'." || echo "Failed to change UID."
            ;;
        3)
            read -p "Enter new home directory: " new_home
            sudo usermod -d "$new_home" -m "$username"
            [ $? -eq 0 ] && echo "Home directory changed to '$new_home'." || echo "Failed to change home directory."
            ;;
        4)
            read -p "Enter new default shell: " new_shell
            sudo usermod -s "$new_shell" "$username"
            [ $? -eq 0 ] && echo "Default shell changed to '$new_shell'." || echo "Failed to change default shell."
            ;;
        5)
             
        *)
            echo "Invalid choice."
            ;;
    esac
}

# Function to display help and usage information
show_help() {
    echo "User Account Management Script"
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -c, --create      Create a new user"
    echo "  -d, --delete      Delete an existing user"
    echo "  -r, --reset       Reset the password of an existing user"
    echo "  -l, --list        List user"
    echo "  -m, --modify      Modify user account"
    echo "  -h, --help        Display help and usage information"
}

# Main script logic
case "$1" in
    -c|--create)
        create_user
        ;;
    -d|--delete)
        delete_user
        ;;
    -r|--reset)
        reset_password
        ;;
    -l|--list)
        list_users
        ;;
    -m|--modify)
        modify_user
        ;;
    -h|--help)
        show_help
        ;;
    *)
        echo "Invalid option. Use -h or --help for usage information."
        exit 1
        ;;
esac