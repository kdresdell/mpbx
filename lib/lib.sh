#!/bin/bash


##################################################################
# FONCTION    :  header
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# DESCRIPTION :  Affiche un bloque de texte avec un Background 
# EXAMPLE     :  header "Installation de Asterisk"
# AUTEUR      :  Ken Dresdell
# UPDATE      :  29-10-2008
##################################################################
function header {

  #EMPTY_SCREEN="---------1---------1---------1---------1---------1---------1---------1---------1"
  EMPTY_SCREEN="                                                                                "
        TEASER="    DRESDELL NETWORK, INC                              www.dresdell.com         "

  TITLE=$1

  CHAR_NUMBER=${#TITLE}
  let DIVISION=$CHAR_NUMBER/2
  let MODULUS=$CHAR_NUMBER%2
  let CENTER=40-$DIVISION

  clear
  # NOM ENTRPRISE ET INFO (TEL ET WEB)
  echo -e '\E[7;37m'"\033[1m$TEASER\033[0m"

  # White on blue background
  echo -e '\E[37;44m'"\033[1m$EMPTY_SCREEN\033[0m"
  COUNTER=0
  while [  $COUNTER -lt $CENTER ]; do
    echo -en '\E[37;44m'"\033[1m \033[0m"
    let COUNTER=COUNTER+1 
  done
  echo -en '\E[37;44m'"\033[1m$TITLE\033[0m"
  let SPACE_LEFT=$CENTER-$MODULUS
  COUNTER=0
  
  let SPACE_LEFT=$SPACE_LEFT-1
  while [  $COUNTER -lt $SPACE_LEFT ]; do
    echo -en '\E[37;44m'"\033[1m \033[0m"
    let COUNTER=COUNTER+1 
  done
  echo -e '\E[37;44m'"\033[1m \033[0m"
  echo -e '\E[4;44m'"\033[1m$EMPTY_SCREEN\033[0m"

  # Reset colors to "normal."
  tput sgr0
  echo " "
  echo " "
}




##################################################################
# FONCTION    :  title
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# DESCRIPTION :  Affiche un titre en vert
# EXAMPLE     :  titre "Installation de Asterisk"
# AUTEUR      :  Ken Dresdell
# DATE        :  11-10-2007
# UPDATE      :  29-10-2008
##################################################################
function title {

  TITLE=$1

  CHAR_NUMBER=${#TITLE}
  let SPACE_LEFT=74-$CHAR_NUMBER

  echo -en '\E[9;31m'"+ $TITLE"

  i=4
  while [ $i -le $SPACE_LEFT ]; do
	sleep 0.01
	echo -n "."
	let i=$i+1
  done
  echo "."
  
  tput sgr0
}
