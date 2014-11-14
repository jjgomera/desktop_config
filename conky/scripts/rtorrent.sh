#!/bin/sh
test -S "$2" &&
"$@" d.multicall default \
   d.get_name= \
   d.get_up_rate= \
   d.get_down_rate= \
   d.get_bytes_done= \
   d.get_size_bytes= \
   d.get_peers_connected= \
   d.get_peers_not_connected= \
   d.get_peers_accounted= \
   d.get_ratio= \
|
xmlstarlet sel -t -v / |
awk '/./ {
   if (++i%9 == 1) name=$0
   else if (i%9 == 2) up[name]=$0
   else if (i%9 == 3) down[name]=$0
   else if (i%9 == 4) done[name]=$0
   else if (i%9 == 5) size[name]=$0
   else if (i%9 == 6) active[name]=$0
   else if (i%9 == 7) peers[name]=$0
   else if (i%9 == 8) leech[name]=$0
   else if (i%9 == 0) ratio[name]=$0
} END {
   for(name in active) {
      if(active[name]) {
         up_sum += up[name]
         down_sum += down[name]
         #if(++j<=4)
         {
            printf("${color white}${font Liberation Sans:size=9:style=Bold}%s${font}${color}\n", name)
            printf("${color #888888} Progreso:${color} %d%%", 100 * done[name] / size[name])
	    printf("${alignr}${color #888888}Ratio:${color} %.3f\n", ratio[name] / 1000)
            printf("${color #888888} Subida:${color} %.1f kB/s", up[name] / 1024)
            printf("${alignr}${color #888888}Descarga:${color} %.1f kB/s\n", down[name] / 1024)
	    printf("${color #888888} Subiendo a %i ", leech[name])
	    printf("de %i pares", peers[name] + leech[name])
	    printf("${alignr}${color} %.3f MB\n", size[name]/1024/1024)
            printf("\n\b")
         }
      }
   }
   printf("      ${color gold}${font Arrows:size=10}S$font${color white} %.1f kB/s", up_sum / 1024)
   printf("${alignr 30}${color gold}${font Arrows:size=10}N$font${color white} %.1f kB/s\n", down_sum / 1024)
   printf("${color #888888}${stippled_hr 2}${voffset 5}\n")
}' |
xargs -d'\b' -n1 printf '%s\0' |
sort -z |
xargs -0 -n1 printf '%s'
