# Solution Documentation for User Management Script

## Introduction
This solution provides a Bash script (`user_management.sh`) designed to manage user accounts on a Linux system. The script supports creating, deleting, resetting passwords, listing user accounts, and modifying user properties.

---

## Script Features

### 1. **Create User Account (-c | --create)**
- **Description:** Allows the creation of a new user account.
- **Steps:**
  - Prompts the user for a username and password.
  - Checks if the username already exists.
  - If not, creates the user and assigns the provided password.
- **Error Handling:**
  - Displays an error if the username already exists.
- **Success Output:**
  - Confirms successful user creation.

### 2. **Delete User Account (-d | --delete)**
- **Description:** Deletes an existing user account.
- **Steps:**
  - Prompts for the username to delete.
  - Checks if the username exists.
  - If the user exists, deletes the user and associated home directory.
- **Error Handling:**
  - Displays an error if the user does not exist.
- **Success Output:**
  - Confirms successful user deletion.

### 3. **Reset User Password (-r | --reset)**
- **Description:** Resets the password of an existing user.
- **Steps:**
  - Prompts for the username and new password.
  - Checks if the user exists.
  - If the user exists, assigns the new password.
- **Error Handling:**
  - Displays an error if the user does not exist.
- **Success Output:**
  - Confirms successful password reset.

### 4. **List User Accounts (-l | --list)**
- **Description:** Lists user accounts with UID greater than 1000.
- **Output:**
  - Displays usernames, UIDs, home directories, and default shells in a formatted table.
- **Error Handling:**
  - Gracefully handles empty or unexpected account lists.

### 5. **Modify User Properties (-m | --modify)**
- **Description:** Allows modification of user properties including username, UID, home directory, and default shell.
- **Steps:**
  - Prompts for the property to modify.
  - Applies the requested changes.
- **Error Handling:**
  - Displays errors for invalid choices or unsuccessful modifications.
- **Success Output:**
  - Confirms successful property updates.

### 6. **Help (-h | --help)**
- **Description:** Displays usage instructions and available command-line options.

---

## Script Usage

### Running the Script
```bash
./user_management.sh [option]
```

### Available Options
| Option     | Description                               |
|------------|-------------------------------------------|
| `-c`       | Create a new user account                 |
| `-d`       | Delete an existing user account           |
| `-r`       | Reset a user's password                   |
| `-l`       | List user accounts with detailed info     |
| `-m`       | Modify user properties                    |
| `-h`       | Display help and usage information        |

---

## Example Commands

1. **Create a New User:**
   ```bash
   ./user_management.sh -c
   ```

2. **Delete a User:**
   ```bash
   ./user_management.sh -d
   ```

3. **Reset a User Password:**
   ```bash
   ./user_management.sh -r
   ```

4. **List Users:**
   ```bash
   ./user_management.sh -l
   ```

5. **Modify User Properties:**
   ```bash
   ./user_management.sh -m
   ```

6. **Show Help:**
   ```bash
   ./user_management.sh -h
   ```

---

## Assumptions and Requirements

1. **Root Privileges:** The script requires `sudo` for certain operations (creating, deleting, and modifying users).
2. **Linux Environment:** The script is intended for Linux systems using `/etc/passwd` for user management.
3. **Error Handling:** Proper checks are implemented for non-existent users and invalid inputs.

---

## Conclusion
This solution provides an efficient way to manage user accounts in Linux systems using a simple and interactive Bash script. With features for user creation, deletion, password management, and property modifications, it offers a complete and flexible tool for system administrators.

