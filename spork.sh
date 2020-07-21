#!/bin/bash

#if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi
#source /opt/splunk/bin/setSplunkEnv
cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

[ ! -d "/opt/splunk" ] && echo "Splunk not Installed..."

#$SPLUNK_HOME="/opt/splunk"
#$SPLUNK_BIN="${SPLUNK_PATH}/bin"
#$SPLUNK="${$SPLUNK_BIN}/splunk"


function INCLUDE {
  . "./opt/${1,,}/${1,,}_sh.sh"
  . "./opt/${1,,}/${1,,}_tui.sh"
  "${1^^}_TUI";
}


function MAIN {
    local STATUS="0"
    local RESULTS=()

    #eval `resize`
    # $(( $LINES - 21 )) $(( $COLUMNS - 20 )) $(( $LINES - 33 )) \

    local TITLE="Splunk Operations Kontrol"
    local DESC="Use TAB/ARROW KEYS to navigate "
          DESC+="and SPACE BAR/RETURN to select."
    local CHOICES=(
      "State"      "Start, Stop, or Restart"
      "Configure"  "Reciever, Forwarder, Port, etc."
      "Users"      "Add/Import Users"
    )

    while [ "$STATUS" -eq 0 ]; do
        OPTION=$(
        whiptail --clear \
                --title "${TITLE}" \
                --menu "${DESC}" \
                --ok-button "Select" \
                --cancel-button "Quit" \
                12 66 4 \
                "${CHOICES[@]}" \
                3>&1 1>&2 2>&3)
        case "${OPTION^^}" in
            "STATE" )     INCLUDE "${OPTION}" ;;
            "CONFIGURE" ) INCLUDE "${OPTION}" ;;
            "USERS" )     INCLUDE "${OPTION}" ;;
            * )           STATUS=1 ;;
        esac
    done
    return 0
}

MAIN

