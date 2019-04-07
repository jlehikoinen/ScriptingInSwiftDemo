#!/bin/bash

# ================================================
# script_wrapper.sh
#
# Copyright (c) 2019 Janne Lehikoinen

# Vars
current_user=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
# temp_script_path="/Users/$current_user/Desktop/temp_script.swift"
temp_script_path="/private/tmp/temp_script.swift"

###

function check_commandline_tools() {

    if [[ ! -d "/Library/Developer/CommandLineTools" ]] || [[ ! -f "/usr/bin/swift" ]]; then
        echo "Xcode command line tools not installed"
        echo "Exiting"
        exit 1
    fi
}

function here_doc_moulinex() {

/bin/cat <<- 'SCRIPTCONTENTS' > "$temp_script_path"
# >>> Add script contents here <<<
SCRIPTCONTENTS
}

function run_script_as_user() {

    # Run script as current user
    /usr/bin/su - $current_user -c "/usr/bin/swift $temp_script_path"
}

function delete_temp_script() {

    # Delete temp script
    /bin/rm "$temp_script_path"
}

### Call functions
check_commandline_tools
here_doc_moulinex
run_script_as_user
delete_temp_script

exit $?
