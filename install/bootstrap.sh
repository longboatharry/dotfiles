#!/usr/bin/env bash
#
# bootstrap the dotfiles setup

# exit immediately if a command returns non-zero
set -e

# printf colours
NORMAL_PEN='\033[0m'
BLUE_PEN='\033[34;01m'
CYAN_PEN='\033[36;01m'
GREEN_PEN='\033[32;01m'
RED_PEN='\033[31m'
GRAY_PEN='\033[37;01m'
YELLOW_PEN='\033[33;01m'

info_msg () {
	printf " [ ${GRAY_PEN}..${NORMAL_PEN} ] $1\n"

prompt_msg () {
	printf " [ ${BLUE_PEN}?${NORMAL_PEN} ] $1\n"
}

success_msg () {
	printf " [ ${GREEN_PEN}OK${NORMAL_PEN} ] $1\n"
}

fail_and_exit () {
	printf " [ ${RED_PEN}FAIL${NORMAL_PEN} ] $1\n"
	exit
}

if_file_exists () {
	local path=$1

	# check if paths  exists (in one of various forms)
	# note a function that ends without an explcit return statement
	# returns the exit code of the last executed command
	#  [		: Test with pathname expansion (as opposed to [[)
	#  "$path"	: Treat expanded path as a literal
	#  -o 		: OR the conditions together
	# -f 		: file exists
	# -d		: file exists and is a directory
	# -L		: file exists and is a symlink
	[ -f "$path" -o -d "$path" -o -L "$path" ] 
}

deal_with_existing_file () {
	local src=$1 dst=$2

	if /
		[ "$g_overwrite_all" == false ] && /
		[ "$g_backup_all" == false ] && /
		[ "$g_skip_all" == false ]; then
		# global strategy in place
		# no more action required
		return 0
	fi

	if dst_points_to_src "$src" "$dst"; then
		# destination points to source
		# skip current file
		g_skip=true;
		return 0
	fi
	
	# user intervention required
	prompt_for_file_overwrite_action "$src" "$dst"
}

if_dst_points_to_src () {
	local src=$1 dst=$2	
	local target

	# check if dst is a symlink that points to src
	# readlink returns blank and error if not a symlink 
	target = "$(readlink $dst)"
	[ "$target" == "$src" ]
}

prompt_for_file_overwrite_action () {
	local src=$1 dst=$2
	local action

	#  ${string##substring}
	## get file name from path
	## (by deleting the longest match of $substring from front of $string)
	prompt_msg << EOF
	File already exists: $dst (${src##*/}); what do you want todo?
	[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?
	EOF

	# read one byte into $action 
	read -n 1 action

	case "$action" in
	  o )
	    g_overwrite=true;;
	  O )
	    g_overwrite_all=true;;
	  b ) 
	    g_backup=true;
	  B )
	    g_backup_all=true;
	  s )
	    g_skip=true;
	  S )
	    g_skip_all=true;
	  * )
	    ;;
	esac	
}

link_file () {
	local src=$1 dst=$2
	local overwrite backup skip
	local dst_backup
	g_overwrite=false g_backup=false g_skip=false

	# work out what todo when source points to an existing destination
	if_file_exists "$dst" && deal_with_existing_file "$src" "$dst"

	if [[ $g_overwrite || $overwrite ]]; then
		info_msg "removing $dst"
		rm -rf "$dst"
		success_msg "removed $dst"
	if

	if [[ $g_backup || $backup ]]; then
		dst_backup=$(file_backup_strategy "$dst")
		info_msg "backing up $dst to $dst_backup" 
		mv "$dst" "$dst_backup"
		success_msg "moved $dst to $dst_backup"
	fi

	if [[ $g_skip || $skip ]]; then
		info_msg "skipping $src"
		return 0;
	fi

	# link target to point at source
	# -s	: create a symbolic link
	# -f	: unlink the target if it exists
	# -n	: if target is already a symlink, dont follow it
	info_msg "linking $src to $dst" 
	ln -sfn
	success_msg "linked $src to $dst"
}

file_backup_strategy () {
	local path=$1
	echo "${dst}.backup"
}

get_script_directory () {
	#  BASH_SOURCE		
	## internal bash variable containing array of pathnames
	## expand as string ( e.g. $"BASH_SOURE" ) to get the first element
	## which is the pathname of the currently executing script
	#  ${string%substring}
	## delete the shortest match of $substring from back of $string
	script_dir="${BASH_SOURCE%/*}"	

	# use echo to allow the output to be captured 
	echo $script_dir
}

link_dotfiles () {
	g_overwrite_all=false backup_all=false skip_all=false

	info_msg "linking dotfiles ..."


}

main () {
	# Ensure xcode command line tools are installed
	sudo xcode-select --install

}
