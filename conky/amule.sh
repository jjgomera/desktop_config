#!/bin/bash
# amule info display script by jjgomera <jjgomera@gmail.com>
#
# requirements: amule with "Online Signature" on (!)


case "$1" in

ed2k)
	stat=`head -n5 ~/.aMule/amulesig.dat |tail -n1`
	if (( $stat == H )); then
		expr "HighID"
	else
		if (( $stat == L )); then
			expr "LowID"
		else    expr "No Conectado"
		fi
	fi
	;;

kad)
	stat=`head -n6 ~/.aMule/amulesig.dat |tail -n1`
	if (( $stat == 2 )); then
		expr "OK"
	else
		if (($stat == 1 )); then
			expr "Firewalled"
		else
			expr "off"
		fi
	fi
	;;

horas)
	tiempo=`head -n17 ~/.aMule/amulesig.dat |tail -n1`
	expr $tiempo / 3600
	;;

minutos)
	tiempo=`head -n17 ~/.aMule/amulesig.dat |tail -n1`
	horas=`~/configuracion/amule.sh horas`
    expr $tiempo / 60 - $horas \* 60
	;;

segundos)
	tiempo=`head -n17 ~/.aMule/amulesig.dat |tail -n1`
	horas=`~/configuracion/amule.sh horas`
	minutos=`~/configuracion/amule.sh minutos`
	expr $tiempo - $minutos \* 60 - $horas \* 3600
	;;

descargadosesion)
	dato=`head -n15 ~/.aMule/amulesig.dat |tail -n1`
	if (( $dato <= 1024 )); then
        expr $dato
    else
        if (( $dato <= 1048576 )); then
            dc -e "1k $dato 1024 /p"
		else
			if (( $dato <= 1073741824 )); then
				 dc -e "1k $dato 1048576 /p"
			else dc -e "2k $dato 1073741824 /p" 
			fi  
		fi
    fi
	;;

unidaddescargadosesion)
	dato=`head -n15 ~/.aMule/amulesig.dat |tail -n1`
	if (( $dato <= 1024 )); then
        expr "bytes"
    else
        if (( $dato <= 1048576 )); then
            expr "KB"
		else
			if (( $dato <= 1073741824 )); then
				expr "MB"
			else expr "GB" 
			fi  
		fi
    fi	
	;;

subidosesion)
	dato=`head -n16 ~/.aMule/amulesig.dat |tail -n1`
	if (( $dato <= 1024 )); then
        expr $dato
    else
        if (( $dato <= 1048576 )); then
            dc -e "1k $dato 1024 /p"
		else
			if (( $dato <= 1073741824 )); then
				dc -e "1k $dato 1048576 /p"
			else dc -e "1k $dato 1073741824 /p" 
			fi  
		fi
    fi	
	;;

unidadsubidosesion)
	dato=`head -n16 ~/.aMule/amulesig.dat |tail -n1`
	if (( $dato <= 1024 )); then
        expr "bytes"
    else
        if (( $dato <= 1048576 )); then
            expr "KB"
		else
			if (( $dato <= 1073741824 )); then
				expr "MB"
			else expr "GB" 
			fi  
		fi
    fi	
	;;

descargadototal)
	dato=`head -n12 ~/.aMule/amulesig.dat |tail -n1`
	if (( $dato <= 1024 )); then
        expr $dato
    else
        if (( $dato <= 1048576 )); then
            dc -e "1k $dato 1024 /p"
		else
			if (( $dato <= 1073741824 )); then
				dc -e "1k $dato 1048576 /p"
			else 
				if (( $dato <= 1099511627776 )); then
					dc -e "2k $dato 1073741824 /p"
				else dc -e "3k $dato 1099511627776 /p"
				fi
			fi  
		fi
    fi	
	;;

unidaddescargadototal)
	dato=`head -n12 ~/.aMule/amulesig.dat |tail -n1`
	if (( $dato <= 1024 )); then
        expr "bytes"
    else
        if (( $dato <= 1048576 )); then
            expr "KB"
		else
			if (( $dato <= 1073741824 )); then
				expr "MB"
			else
				if (( $dato <= 1099511627776 )); then
					expr "GB"
				else expr "TB"
				fi
			fi  
		fi
    fi	
	;;


subidototal)
	dato=`head -n13 ~/.aMule/amulesig.dat |tail -n1`
	if (( $dato <= 1024 )); then
        expr $dato
    else
        if (( $dato <= 1048576 )); then
            dc -e "2k $dato 1024 /p"
		else
			if (( $dato <= 1073741824 )); then
				dc -e "2k $dato 1048576 /p"
			else 
				if (( $dato <= 1099511627776 )); then
					dc -e "2k $dato 1073741824 /p"
				else dc -e "2k $dato 1099511627776 /p"
				fi
			fi  
		fi
    fi	
	;;

unidadsubidototal)
	dato=`head -n13 ~/.aMule/amulesig.dat |tail -n1`
	if (( $dato <= 1024 )); then
        expr "bytes"
    else
        if (( $dato <= 1048576 )); then
            expr "KB"
		else
			if (( $dato <= 1073741824 )); then
				expr "MB"
			else
				if (( $dato <= 1099511627776 )); then
					expr "GB"
				else expr "TB"
				fi
			fi  
	fi
        fi	
	;;

porcentaje)
	descargado=`head -n7 ~/.aMule/amulesig.dat |tail -n1 | cut -d"," -f1`
	expr $descargado / 6
    ;;
esac





    



