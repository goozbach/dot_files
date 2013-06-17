#!/bin/bash
# gives you a list of colors by name

# Primary color names
export Black="\033[0;30m"
export Red="\033[0;31m"
export Green="\033[0;32m"
export Yellow="\033[0;33m"
export Blue="\033[0;34m"
export Magenta="\033[0;35m"
export Cyan="\033[0;36m"
export White="\033[0;37m"
export Reset="\033[0;39m"

# Bright color names
export BrightBlack="\033[1;30m"
export BrightRed="\033[1;31m"
export BrightGreen="\033[1;32m"
export BrightYellow="\033[1;33m"
export BrightBlue="\033[1;34m"
export BrightMagenta="\033[1;35m"
export BrightCyan="\033[1;36m"
export BrightWhite="\033[1;37m"

# background
export BackgroundBlack="\033[;40m"
export BackgroundRed="\033[;41m"
export BackgroundGreen="\033[;42m"
export BackgroundYellow="\033[;43m"
export BackgroundBlue="\033[;44m"
export BackgroundMagenta="\033[;45m"
export BackgroundCyan="\033[;46m"
export BackgroundWhite="\033[;47m"
export BackgroundReset="\033[;49m"

# testing function
test_colors() {
  ## normal
  ### foregrounds
  echo -e "FOREGROUNDS"
  echo -e "Black = ${Black}this is Black${Reset}"
  echo -e "Red = ${Red}this is Red${Reset}"
  echo -e "Green = ${Green}this is Green${Reset}"
  echo -e "Yellow = ${Yellow}this is Yellow${Reset}"
  echo -e "Blue = ${Blue}this is Blue${Reset}"
  echo -e "Magenta = ${Magenta}this is Magenta${Reset}"
  echo -e "Cyan = ${Cyan}this is Cyan${Reset}"
  echo -e "White = ${White}this is White${Reset}"
  
  ## bright
  ### foregrounds
  echo -e "\nBright FOREGROUNDS"
  echo -e "Black = ${BrightBlack}this is BrightBlack${Reset}"
  echo -e "Red = ${BrightRed}this is BrightRed${Reset}"
  echo -e "Green = ${BrightGreen}this is BrightGreen${Reset}"
  echo -e "Yellow = ${BrightYellow}this is BrightYellow${Reset}"
  echo -e "Blue = ${BrightBlue}this is BrightBlue${Reset}"
  echo -e "Magenta = ${BrightMagenta}this is BrightMagenta${Reset}"
  echo -e "Cyan = ${BrightCyan}this is BrightCyan${Reset}"
  echo -e "White = ${BrightWhite}this is BrightWhite${Reset}"
  
  ## backgrounds
  echo -e "\nBACKGROUNDS"
  echo -e "Black = ${BackgroundBlack}this is Black${Reset}"
  echo -e "Red = ${BackgroundRed}this is Red${Reset}"
  echo -e "Green = ${BackgroundGreen}this is Green${Reset}"
  echo -e "Yellow = ${BackgroundYellow}this is Yellow${Reset}"
  echo -e "Blue = ${BackgroundBlue}this is Blue${Reset}"
  echo -e "Magenta = ${BackgroundMagenta}this is Magenta${Reset}"
  echo -e "Cyan = ${BackgroundCyan}this is Cyan${Reset}"
  echo -e "White = ${BackgroundWhite}this is White${Reset}"
}
