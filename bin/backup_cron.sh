#!/bin/bash

function main()
{
	mkdir -p "/Users/${USER}/tmp" || { false; return; }
	crontab -l > "/Users/${USER}/tmp/crontab.bak"
}

main
exit $?
