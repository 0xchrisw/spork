#!/bin/bash

function CONFIGURE_TUI
(
    local TITLE="SPORK - Configuration"
    local DESC="Use TAB/ARROW KEYS to navigate "
          DESC+="and SPACE BAR/RETURN to select."
     local CHOICES=(
      "Auto Start"          "Enable/Disable"
      "Port"                "Web Server Port"
      "Reciever"            ""
      "Universal Forwarder" "Dedicate data fowarder"
      "Heavy Forwarder"     "Full Splunk Enterprise Install"
    )

    OPTION=$(
        whiptail --clear \
        --title "${TITLE}" \
        --menu "${DESC}" \
        --ok-button "Select" \
        --cancel-button "Back" \
        33 75 21 \
        "${CHOICES[@]}" \
        3>&1 1>&2 2>&3)

    case "${OPTION^^}" in
        "AUTO START" )
            if ( whiptail --clear \
                    --title "Auto Start" \
                    --yesno "Start Splunk at Boot?" 8 78 ); then
                echo "SPLUNK_HOME/bin/splunk enable boot-start"
            else
                echo "SPLUNK_HOME/bin/splunk disable boot-start"
            fi
          ;;
        "PORT" )
            PORT=$(
                whiptail --clear \
                --title "Change Port" \
                --inputbox "Enter a new port(e.g. 6666):" \
                8 78 \
                --ok-button "Next" \
                "" 3>&1 1>&2 2>&3)
            CONFIGURE_SH "PORT" $PORT
        ;;
        * ) STATUS=1 ;;
    esac
)