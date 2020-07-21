#!/bin/bash

function STATE_TUI
(
    local TITLE="SPORK - State Management"
    local DESC="Use TAB/ARROW KEYS to navigate "
          DESC+="and SPACE BAR/RETURN to select."
    local CHOICES=(
      "Start" ""
      "Stop" ""
      "Restart" ""
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
    
    STATE_SH "${OPTION^^}"

)