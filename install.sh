#!/bin/bash

########################################
# helpers
function print_err {
    local COLOR='\e[91m'
    local NOCOLOR='\e[0m'
    echo -e ${COLOR}$1${NOCOLOR}
}

function print_info {
    local COLOR='\e[92m'
    local NOCOLOR='\e[0m'
    echo -e ${COLOR}$1${NOCOLOR}
}

function prologue {
    print_info "[start of $1]"
}

function epilogue {
    print_info "[end of $1]"
}

########################################

print_info "install script"
print_info "finished"
