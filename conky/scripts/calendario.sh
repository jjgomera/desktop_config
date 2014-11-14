#! /bin/sh


DATE=`date | awk -F" " '{print $3}'`

case "$1" in
mes)
cal | head -n1
;;
semana)
gcal -i -s 1 | head -n3 | tail -n1 | tr 'visá' 'vi sa'
;;
pasado)
gcal -i -s 1 | grep -v '[a-zA-Z]' | grep '[0-9]' | tr "<" " " | tr ">" " " | tr "  " " " | awk -F$DATE ' BEGIN {i=0}
($1 == $0 && i==0) {print $1}($1 != $0 && i==0){i=i+1;print $1}'
;;
hoy)
echo $DATE
;;
futuro)
gcal -i -s 1 | grep -v '[a-zA-Z]' | grep '[0-9]' | tr "<" " " | tr ">" " "| awk -F$DATE ' BEGIN {i=1}
(i==0) {print $0}($1 != $0 && i==1){i=i-1;print $2}'
;;
centrado)
cal | grep -v '[a-zA-Z]' | grep '[0-9]' | tr "<" " " | tr ">" " "| awk -F$DATE ' BEGIN {i=0}
($1 == $0 && i==0) {print $1}($1 != $0 && i==0){i=i+1;print $1}' && echo $DATE
;;
esac
