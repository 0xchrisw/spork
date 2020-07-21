#!/bin/bash

function CONFIGURE_SH
(
  ##
  # TODO
  #   o Show what port is being used:
  #       > ./splunk show web-port ./splunk show splunkd-port
  ##


  function PORT {
    echo $@
    echo "./splunk set web-port ${1}"
    echo "./splunk set splunkd-port ${1}"
  }

  function RECIEVER {
    #https://docs.splunk.com/Documentation/Splunk/8.0.5/Forwarding/Enableareceiver
    #https://www.google.com/search?client=firefox-b-1-d&q=splunk+enable+listen
    echo "splunk enable listen <port> -auth <username>:<password>"
  }

  function SEARCHHEAD {
    echo
  }

  function INDEXER {
    echo
  }

  $@
)


