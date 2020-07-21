#!/bin/bash

function USERS_TUI
(
    local TITLE="SPORK - User Management"
    local DESC="Use TAB/ARROW KEYS to navigate "
          DESC+="and SPACE BAR/RETURN to select."
    local CHOICES=(
      "Add User"       ""
      #"Reset Password" ""
      "Import Users"   ""
      #"Export Users"   ""
      "Delete User"    ""
    )

    OPTION=$(
    whiptail --clear \
            --title "${TITLE}" \
            --menu "${DESC}" \
            --ok-button "Select" \
            --cancel-button "Back" \
            12 66 4 \
            "${CHOICES[@]}" \
            3>&1 1>&2 2>&3)

    case "${OPTION^^}" in
        "ADD USER" )
            NAME=$(
                whiptail --clear \
                --title "Add User" \
                --inputbox "Input Full Name(Firstname Lastname):" \
                8 78 \
                --ok-button "Next" \
                "" 3>&1 1>&2 2>&3)
            USERS_SH "ADD" $NAME
            #TODO - Check if canceled
            #PASSWORD=$(
            #    whiptail --clear \
            #    --title "Add User" \
            #    --inputbox "Input Password:" 8 78 \
            #    --ok-button "Next" \
            #    "" 3>&1 1>&2 2>&3)
            #USERS_SH "ADD" $NAME $PASSWORD
            ;;
        
        "IMPORT USERS" )
            IMPORTFILE=$(
                whiptail --clear \
                --title "Import Users" \
                --inputbox "Path to csv(/home/defender/users.csv):" \
                8 78 \
                --ok-button "Next" \
                "" 3>&1 1>&2 2>&3)
            USERS_SH "IMPORTCSV" $IMPORTFILE
            ;;

        "RESET PASSWORD" )
            echo "Reset Password"
            ;;

        "DELETE USER" )
            NAME=$(
                whiptail --clear \
                --title "Delete User" \
                --inputbox "username" \
                8 78 \
                --ok-button "Next" \
                "" 3>&1 1>&2 2>&3)
            USERS_SH "DELETE" $NAME
            ;;
        * ) STATUS=1 ;;
    esac

)