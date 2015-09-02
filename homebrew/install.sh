#!/bin/bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

CWD="${BASH_SOURCE%/*}" # path to executing script
DEPENDS_ON=(../functions/pretty-print.sh \
	../functions/if-exists.sh)

__main () (

	# load dependencies
	for FILE in $DEPENDS_ON; do source "${CWD}/${FILE}"; done


	exit 0

	__install_brew
        __install_brew_packages
        __install_cask_packages

        exit 0
)

__load_dependencies() {
        local script_dir="${BASH_SOURCE%/*}"
	# source the scripts into the current shell process
        source "${script_dir}/../functions/pretty-print.sh"
        source "${script_dir}/../functions/if-exists.sh"
}

__install_brew () {
	app_exists? "brew" || {
        	print_info "Installing Homebrew ..."
        	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	}

	app_exists? "brew cask" || {
		print_info "Installing Cask ..."
		brew install caskroom/cask/brew-cask

	}

	print_info "Updating Homebrew ..."
	brew update

	print_info "Checking for updates to any pre-existing formulae ..."
	brew upgrade
}

__install_brew_packages () {
	brew install grc coreutils spark
	brew install wget
	brew install pstree
}

__install_cask_packages () {
	brew cask install iterm2
}

__main "$@"

unset CWD
unset DEPENDS_ON

unset -f __main
unset -f __load_dependencies
unset -f __install_brew
unset -f __install_brew_packages
unset -f __install_cask_packages
