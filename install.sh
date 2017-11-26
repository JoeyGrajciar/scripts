#!/bin/bash

########################################
# helpers
########################################
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

########################################
# configuration setup functions
########################################

function config_prepare {
	prologue ${FUNCNAME[0]}
	git clone --bare https://github.com/JoeyGrajciar/dotfiles.git $HOME/.cfg-test
	epilogue ${FUNCNAME[0]}
}

function config {
	/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME $@
}

function config_install {
	prologue ${FUNCNAME[0]}
	cd $HOME
	mkdir -p .config-backup
	config checkout
	if [ $? = 0 ]; then
		echo "Checked out config";
		else
		echo "Backing up pre-existing dot files";
		config checkout 2>$1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
	fi;
	config checkout
	config config --local status.showUntrackedFiles no
	epilogue ${FUNCNAME[0]}
}

#######################################

print_info "install script"

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
	cfg)
		CONFIG=1
		shift
		;;
esac
done

if [[ $CONFIG == 1 ]]; then
	config_prepare
	config_install
fi

print_info "finished"
