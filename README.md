# **User and Process Management Script**

## **Description**
This script is a utility designed for managing users, processes, and file ownership on a Linux system. It can perform various administrative tasks such as checking user login statuses, fixing user accounts, managing file ownership, and displaying memory usage statistics for processes. The script is highly useful for system administrators looking for an easy way to manage users and their associated processes.

---

## **Arguments and Flow of the Script**

### **Usage**
The script is designed to handle different scenarios based on the number and type of arguments passed to it. Here’s a breakdown of how the script behaves with various inputs:

### **1. Check Process Memory Usage for a User**
If the script is called with `--proc` followed by a second argument (the username), it will execute the `show_processes` function to display memory usage for processes owned by that user. This is particularly useful for tracking resource consumption per user on the system.

```bash
./script.sh --proc username
```

### **2. Fix User Account Issues (Single Argument)**
If the script is called with a single argument (the username), it will invoke the fix_user function to check the status of the specified user account. It will check if the user exists, if the password is set, and whether the user is locked or not. Based on the result, the script will provide options to set the user’s password if it’s not set or if the account is locked.

```bash
./script.sh username
```
This will:

Check if the user username exists on the system.
If the user exists, it will check if the account is locked or if the password is not set.
If needed, it will prompt to set a password for the user.

### **3. Change File Ownership Between Two Users (Two Arguments)**
When called with two arguments (representing two usernames), the script will invoke the check_users function to ensure that both users exist on the system. If they do, it will allow the user to specify a directory, and the script will change the ownership of files in that directory from the first user to the second user.

```bash
./script.sh user1 user2
```

This will:

Check if both user1 and user2 exist on the system.
If both users exist, it will prompt for a directory input.
It will then loop through all files in the specified directory, changing the ownership of files owned by user1 to user2.

### **4. Display User Information (More Than Two Arguments)**
If the script is called with more than two arguments, it will invoke the print_usersinfo function to display information about the specified users. This will include their home directories, primary groups, and shell configurations.

```bash
./script.sh user1 user2 user3
```

This will:

Display information for the users user1, user2, and user3.
For each user, it will show their home directory, group, and shell.

---

This script is an essential tool for system administrators, providing a simple way to manage users, processes, and file ownership. Whether it’s verifying user login permissions, checking memory usage of processes, or modifying file ownership, this script offers a quick and effective solution for common administrative tasks on a Linux system.


