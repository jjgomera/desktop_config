# This shell script is run before Openbox launches.
# Environment variables set here are passed to the Openbox session.

#Screen
xrandr --output VGA-1 --mode 1280x1024 --pos 0x0 --rotate normal --output DVI-I-1 --off --output HDMI-1 --off &

#Font render
xrdb ~/.Xdefaults 

#Teclado numérico activado
numlockx on

#Screensaver
xscreensaver -no-splash &

#taskbar
/home/jjgomera/compilaciones/visibility-python.git/visibility.py &

#traybar
sleep 5 && trayer --edge bottom --align right --widthtype request --height 18 --expand true --SetPartialStrut true --transparent true --alpha 255 --margin 800 &
sleep 10 && parcellite &
sleep 10 && volumeicon &

#desktop
sleep 5 && nitrogen --restore 
sleep 20 && sh /home/jjgomera/configuracion/conky.sh &
sleep 10 && sh /home/jjgomera/configuracion/imagen_escritorio.sh &
sleep 10 && gnome-terminal --window-with-profile=fondo --geometry=100x42+270+140 --role=fondo &

#Desktop effect
#sleep 50 && xcompmgr -cC -t-5 -l-6 -r5 &
sleep 50 && compton &

#Programacion
sleep 50 && eric4_tray &
