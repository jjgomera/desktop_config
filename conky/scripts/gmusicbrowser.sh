#!/bin/bash
# gmusicbrowser info display script by jjgomera <jjgomera@gmail.com>
#
# requirements: gmusicbrowser with NowPlaying plugin on (!)



tiempo=`dbus-send --print-reply --dest=org.gmusicbrowser /org/gmusicbrowser org.gmusicbrowser.CurrentSong | grep -A1 "length" |tail -n1 | cut -d'"' -f2`
tiemposegundos=`dbus-send --print-reply --dest=org.gmusicbrowser /org/gmusicbrowser org.gmusicbrowser.CurrentSong | grep "length" -A 1 | tail -n1 | cut -d'"' -f2`
estado=`dbus-send --print-reply --dest=org.gmusicbrowser /org/gmusicbrowser org.gmusicbrowser.GetPosition | grep "double" | cut -d" " -f5 | cut -d"." -f1`

case "$1" in

minutostotales)
	expr $tiempo / 60
	;;

segundostotales)
	expr $tiempo % 60
	;;

minutosestado)
	expr $estado / 60
	;;
segundosestado)
	minutos=`~/configuracion/gmusicbrowser.sh minutosestado`
	expr $estado % 60
	;;
progreso)
        expr $estado \* 100  / $tiemposegundos
	;;

esac

