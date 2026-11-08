# This shell script is run before Openbox launches.
# Environment variables set here are passed to the Openbox session.

#gnome-settings-daemon &
#kdeinit &
#pulseaudio &

#Renderizado de fuentes
#xrdb ~/.Xdefaults 

#Teclado numérico activado
#numlockx off
#setleds +num
#xbindkeys 

#Protector de pantalla
xscreensaver -no-splash &

#automontado
#pcmanfm --daemon-mode &
#gnome-volume-manager &

#escritorio
sleep 5 && nitrogen --restore &
sh /home/jjgomera/configuracion/conky.sh &
sleep 10 && sh /home/jjgomera/configuracion/imagen_escritorio.sh &
#sleep 10 && gnome-terminal --window-with-profile=fondo --geometry=100x42+270+140 --role=fondo &

#taskbar
#sleep 5 && python2 /home/jjgomera/Programacion/visibility/visibility.py &
tint2 &

#traybar
trayer --edge bottom --align right --widthtype request --height 20 --expand true --SetPartialStrut true --transparent true --alpha 255 --margin 750 &
# sleep 2 & wicd-client &
#sleep 5 && /home/jjgomera/configuracion/tidybattery/tidybattery.py &
sleep 5 && volumeicon &
sleep 5 && lxqt-powermanagement &

# Clipboard manager
# sleep 5 && qlipper &
#sleep 10 && diodon &
sleep 10 && copyq &

# sleep 1 && radiotray &


#Efectos de escritorio
#sleep 15 && xcompmgr -cC -t-5 -l-6 -r5 &
#compton -cCGf &
picom &
#idesk &

# Vim editor
sleep 5 && gvim &
sleep 5 && terminator -p pychemqt -l pychemqt &

# Download app
#sleep 10 && qbittorrent &
#sleep 10 && transmission-gtk &
sleep 10 && amulegui -s &
