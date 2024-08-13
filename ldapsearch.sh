#!/bin/bash

# Configuration
LDAP_SERVER="<target-ip>"  # Replace with your LDAP server IP
BASE_DN="dc=example,dc=com"  # Replace with your base DN
BIND_DN="cn=manager,dc=example,dc=com"  # Replace with your bind DN
BIND_PW="password"  # Replace with your password

# LDAP search wrapper function
ldap_search() {
    echo -e "\n--- $1 ---"
    ldapsearch -x -H ldap://$LDAP_SERVER -D "$BIND_DN" -w "$BIND_PW" -b "$BASE_DN" "$2" $3
}

# Perform LDAP queries
# Query 1: All users
ldap_search "All Users" "(objectClass=person)" "cn mail"

# Query 2: All groups
ldap_search "All Groups" "(objectClass=group)" "cn"

# Query 3: Users with specific attribute (e.g., users with no password expiration)
ldap_search "Users with no password expiration" "(&(objectClass=person)(pwdLastSet=0))" "cn"

# Query 4: All organizational units
ldap_search "Organizational Units" "(objectClass=organizationalUnit)" "ou"

# Query 5: Members of a specific group (e.g., "Admins")
ldap_search "Members of 'Admins' Group" "(&(objectClass=person)(memberOf=cn=Admins,ou=groups,$BASE_DN))" "cn"

