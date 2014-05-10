#!/bin/bash
DIR=$HOME/configuracoesJack

PATCHBAY=${DIR}/definicoesqjack.xml
LOGJACK=${DIR}/.logs/logqjack
LOGA2JM=${DIR}/.logs/loga2jmidid
LOGJAMIN=${DIR}/.logs/logjamin
JAMINSETUP=${DIR}/.jamin/default.jam

MPCONFIG=${HOME}/.mplayer/config

function ativaconfigs {
		ln -s ${DIR}/asoundrc ${HOME}/.asoundrc
		mv ${MPCONFIG} ${MPCONFIG}old
		ln -s ${DIR}/mplayer ${MPCONFIG}
}
function desativaconfigs {
		rm ${MPCONFIG}
		cp ${MPCONFIG}old ${MPCONFIG}
		rm ~/.asoundrc
}

case $1 in
	start)
		qjackctl -a ${PATCHBAY} -s &> ${LOGJACK}&
		a2jmidid &> ${LOGA2JM} &
		jamin -f ${JAMINSETUP} &> ${LOGJAMIN}&
		jamin-scene 1&
		ativaconfigs
		;;
	stop)
		kill -9 `pidof jamin` &>/dev/null
		kill -9 `pidof qjackctl.real` &>/dev/null
		kill -9 `pidof a2jmidid` &> /dev/null
		jack_control stop
		desativaconfigs
		;;
	config)
		mv ~/.jackdrc ~/.jackdrcold
		mv ~/.jamin ~/.jaminold
		ln -s ${DIR}/jackdrc ~/.jackdrc
		ln -s ${DIR}/.jamin ~/.jamin;;
#		--help) echo "help";
		*) echo "Please enter a option: $0 start|stop|config";;
esac
