#!/bin/bash

[ -z ${__ERRORS+.} ] && readonly __ERRORS= || return 0

function __exit_handler()
{
	rm $ERR_PIPE
	exec 3>&-
}

function __error_handler()
{
	local message=$(head -n1 < $ERR_PIPE) 
	local line_no="$1"
	local code="${2:-1}"
	msg_error "Error on line ${line_no}: ${message}; exiting with status ${code}"
	exit "${code}"
}

function enable_errors()
{
	# Inherit traps on ERR within shell functions, command substitutions and subshells
	set -o errtrace

	# Cause any failure anywhere in a pipeline to cause the entire pipeline to fail
	set -o pipefail

	# Exit the script on any attempt to use an uninitialized variable
	set -o nounset

	# Exit the script if any statement returns a non-true return code
	set -o errexit

	# create a temporary named pipe
	ERR_PIPE=$(mktemp -u)
	mkfifo $ERR_PIPE

	# redirect file descriptor 3 to stdout
	exec 3>&1

	# redirect all stdout to the temporary named pipe, filtering on stderr
	exec > >(tee $ERR_PIPE) 2>&1 1>&3
	
	# wire up exit and error handlers
	trap '__exit_handler' EXIT
	trap '__error_handler ${LINENO} $?' ERR
}

