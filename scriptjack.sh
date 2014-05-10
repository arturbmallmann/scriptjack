#!/bin/bash
DIR=$HOME/configuracoesJack

PATCHBAY=${DIR}/definicoesqjack.xml
LOGJACK=${DIR}/logqjack

LOGJAMIN=${DIR}/logjamin
JAMINSETUP=${DIR}/.jamin/default.jam
case $1 in
	start)
		qjackctl -a ${PATCHBAY} -s &> ${LOGJACK}&
		jamin -f ${JAMINSETUP} &> ${LOGJAMIN}&
		jamin-scene 1&
		ln -s ${DIR}/asoundrc ~/.asoundrc
		;;
	stop)
		kill -9 `pidof jamin` &>/dev/null
		kill -9 `pidof qjackctl.real` &>/dev/null
		jack_control stop
		rm ~/.asoundrc;;
	config)
		mv ~/.jackdrc ~/.jackdrcold
		mv ~/.jamin ~/.jaminold
		ln -s ${DIR}/jackdrc ~/.jackdrc
		ln -s ${DIR}/.jamin ~/.jamin;;
#		--help) echo "help";
		*) echo "Please enter a option: $0 start|stop|config";;
esac

