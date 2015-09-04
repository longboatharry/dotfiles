#!/bin/bash

# Brightness
HUE_DULL=0
HUE_BRIGHT=1

# Foreground colors
export FG_BLACK=30
export FG_RED=31
export FG_GREEN=32
export FG_YELLOW=33
export FG_BLUE=34
export FG_VIOLET=35
export FG_CYAN=36
export FG_WHITE=37
export FG_NULL=00

# Background colors
export BG_BLACK=40
export BG_RED=41
export BG_GREEN=42
export BG_YELLOW=43
export BG_BLUE=44
export BG_VIOLET=45
export BG_CYAN=46
export BG_WHITE=47
export BG_NULL=00

# ANSI Escape Commands
export ANSI_ESC="\033"
export ANSI_NORMAL="$ESC[m"

# Pens
export PEN_RESET="$ANSI_ESC[${HUE_DULL};${FG_WHITE};${BG_NULL}m"

export PEN_BLACK="$ANSI_ESC[${HUE_DULL};${FG_BLACK}m"
export PEN_RED="$ANSI_ESC[${HUE_DULL};${FG_RED}m"
export PEN_GREEN="$ANSI_ESC[${HUE_DULL};${FG_GREEN}m"
export PEN_YELLOW="$ANSI_ESC[${HUE_DULL};${FG_YELLOW}m"
export PEN_BLUE="$ANSI_ESC[${HUE_DULL};${FG_BLUE}m"
export PEN_VIOLET="$ANSI_ESC[${HUE_DULL};${FG_VIOLET}m"
export PEN_CYAN="$ANSI_ESC[${HUE_DULL};${FG_CYAN}m"
export PEN_WHITE="$ANSI_ESC[${HUE_DULL};${FG_WHITE}m"

# BRIGHT TEXT
export PEN_BRIGHT_BLACK="$ANSI_ESC[${HUE_BRIGHT};${FG_BLACK}m"
export PEN_BRIGHT_RED="$ANSI_ESC[${HUE_BRIGHT};${FG_RED}m"
export PEN_BRIGHT_GREEN="$ANSI_ESC[${HUE_BRIGHT};${FG_GREEN}m"
export PEN_BRIGHT_YELLOW="$ANSI_ESC[${HUE_BRIGHT};${FG_YELLOW}m"
export PEN_BRIGHT_BLUE="$ANSI_ESC[${HUE_BRIGHT};${FG_BLUE}m"
export PEN_BRIGHT_VIOLET="$ANSI_ESC[${HUE_BRIGHT};${FG_VIOLET}m"
export PEN_BRIGHT_CYAN="$ANSI_ESC[${HUE_BRIGHT};${FG_CYAN}m"
export PEN_BRIGHT_WHITE="$ANSI_ESC[${HUE_BRIGHT};${FG_WHITE}m"

unset HUE_DULL
unset HUE_BRIGHT