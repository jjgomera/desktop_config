#!/bin/bash
sleep 2 && conky -c /home/jjgomera/configuracion/conkysistema &
sleep 3 && conky -c /home/jjgomera/configuracion/conkybarra &
sleep 3 && conky -c /home/jjgomera/configuracion/conkycalendar &
sleep 3 && /home/jjgomera/configuracion/conkylua &
#sleep 5 && /home/jjgomera/configuracion/conkyaria &
#sleep 5 && /home/jjgomera/configuracion/conkyrtorrent &
#sleep 5 && /home/jjgomera/configuracion/conkyamule &

