#!/bin/sh

DATE=`date +%Y%m%d00`

#feh -x -g "170x110+420+10" http://www.aemet.es/imagenes_d/eltiempo/prediccion/precipitacion/dw1gp005.gif &
#feh -x -g "170x110+595+10" http://www.aemet.es/imagenes_d/eltiempo/prediccion/precipitacion/dp2gp005.gif &
#feh -x -g "170x110+770+10" http://www.aemet.es/imagenes_d/eltiempo/prediccion/precipitacion/dp3gp005.gif &
#feh -x -g "170x135+400+10" "http://www.aemet.es/imagenes_d/eltiempo/prediccion/precipitacion/2015040200+024_wr_bpd5p0d1.png" &
#feh -x -g "170x135+580+10" "http://www.aemet.es/imagenes_d/eltiempo/prediccion/precipitacion/2015040200+048_wr_bpd5p0d2.png" &
#feh -x -g "170x135+760+10" "http://www.aemet.es/imagenes_d/eltiempo/prediccion/precipitacion/2015040200+072_wr_bpd5p0d3.png" &
#feh -x -g "+450+660"  ~/Escritorio/Pantallazo_1242597799_1280x1024.png &
#feh -x -g "+420+555"  ~/Escritorio/Pantallazo_1252271007_1280x1024.png &
feh -x --scale-down -g "250x200+500+10"  "https://www.aemet.es/imagenes_d/eltiempo/prediccion/mapas_probabilisticos/$DATE+024_ww_bsmdp0d1.png" &
feh -x --scale-down -g "250x200+800+10"  "https://www.aemet.es/imagenes_d/eltiempo/prediccion/mapas_probabilisticos/$DATE+048_ww_bsmdp0d2.png" &
feh -x --scale-down -g "250x200+1100+10"  "https://www.aemet.es/imagenes_d/eltiempo/prediccion/mapas_probabilisticos/$DATE+072_ww_bsmdp0d3.png" &

#feh -x -g "232x295+1040+520" /home/jjgomera/configuracion/conchi.png &

sh ~/configuracion/nasaimg &
#sh ~/configuracion/infra.sh &
#sh ~/configuracion/radar.sh &
