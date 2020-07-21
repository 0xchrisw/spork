#!/bin/bash

function STATE_SH
(
    #local OPTION="${1^^}"  # Inherited from TUI_BACKUP
    echo "${OPTION}"

    case "${OPTION^^}" in
        "START" )
            echo "/opt/splunk/bin/splunk start --no-prompt --answer-yes"
            ;;
        "STOP" )
            echo "/opt/splunk/bin/splunk stop"
            ;;
        "RESTART" )
            echo "/opt/splunk/bin/splunk restart"
            ;;
        * ) STATUS=1 ;;
    esac

)