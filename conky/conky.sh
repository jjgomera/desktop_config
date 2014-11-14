#!/bin/bash
sleep 20 && /home/jjgomera/configuracion/conkysistema &
sleep 10 && /home/jjgomera/configuracion/conkygmail &
sleep 10 && /home/jjgomera/configuracion/conkycalendar &
sleep 10 && /home/jjgomera/configuracion/conkydescargas &
sleep 10 && /home/jjgomera/configuracion/conkybarra &
sleep 30 && ssh -X pi@raspberrypi conky &

