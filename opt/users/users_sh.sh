#!/bin/bash

    ##
    # RULES
    #   o Usernames & Role cannot contain space, colons,
    #     or forward slashes.
    #   o Username are case-insensitive.
    #   o Roles are lowercase only.
    #   o Roles have capabilities. Capabilities define the
    #     actions that are available to roles
    #
    # RESOURCES
    #   o https://www.thegeekstuff.com/2019/03/splunk-user-and-role-cli-web/
    #
    # TODO
    #   o Reset Password
    #      > $SPLUNK_HOME/etc/passwd
    #      > /opt/splunk/bin/splunk hash-passwd 'I<3bigDATA'
    #      > https://www.hurricanelabs.com/splunk-tutorials/splunk-7-1-performing-a-splunk-password-reset
    #   o Edit Users
    #      > splunk edit user <username> -full-name "<FullName>"
    #   o Edit Roles
    #      > splunk edit user <username> -role Power
    #   o Delete Roles
    #      > splunk remove role splunkreadonly
    ##

function USERS_SH
(
    #local OPTION="${1^^}"  # Inherited from TUI_BACKUP

    local ROLES=( "admin" "power" "user" "can_delete" )

    function ADD {
        # @notes     User is forced to change password at login.
        # @fullname
        # @password
        # @role

        args=("$@")
        #if [[ ${args[#]} -gt 1 ]]; then
        FULLNAME="${args[0]} ${args[1]}"
        USERNAME="${FULLNAME//[[:space:]]/}"
        #PASSWORD="${args[2]}"
        PASSWORD="password"
        ROLE="${args[2]:-user}"
        echo "splunk add user ${USERNAME,,} -role ${ROLE} -password ${PASSWORD} -full-name '${FULLNAME}' -force-change-pass true"
    }


    function IMPORTCSV {
        if [[ ! -f "${1}" ]]; then echo "File Not Found!"; exit 99; fi
        local ROW=1
        while IFS=',' read -r FULLNAME ROLE; do
            # Skip Headers
            if [[ "${ROW}" == 1 ]]; then ((ROW++)); continue; fi;
            if [[ ! -z "${FULLNAME}" ]]; then
                USERNAME="${FULLNAME//[[:space:]]/}"
                PASSWORD="password"
                ROLE="${ROLE:-user}"
                echo "splunk add user ${USERNAME,,} -role ${ROLE} -password ${PASSWORD} -full-name '${FULLNAME}' -force-change-pass true"
            fi
        done < "${1}"
    }


    function ResetPassword {
        echo "RESET"
        echo ' splunk edit user admin -password newPassowrd  -auth admin:changeme'
        #history -c  # Do not log to histroy file
    }

    function ExportUsers {
        echo "splunk list user"
        #whiptail --textbox <filename> <height> <width>
    }


    function DELETE {
        echo "splunk remove user ${1}"
    }

    $@  # YOLO, full send
)