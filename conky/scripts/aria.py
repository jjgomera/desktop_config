#!/usr/bin/python
# -*- coding: utf-8 -*-

#Change for your system
ip="192.168.1.145"
port="6800"

import sys
import xmlrpclib
import os.path

def byte2Str(bit, speed=False):
    if speed:
        code=["B/s", "KB/s", "MB/s"]
    else:
        code=["B", "KiB", "MiB", "GiB", "TiB"]
    num=bit
    indice=0
    while num>=1024:
        indice+=1
        num/=1024
    return "%0.2f%s" %(num, code[indice])
    
s = xmlrpclib.ServerProxy('http://%s:%s/rpc' %(ip, port))

if sys.argv[1]=="global":
    stat=s.aria2.getGlobalStat()
    print "%s/%s/%s" %(stat['numStopped'], stat['numActive'], stat['numWaiting'])
    
elif sys.argv[1]=="files":
    archivos=s.aria2.tellActive()
    string=""
    for archivo in archivos:
        directorio=os.path.dirname(archivo["files"][0]["path"]).split("/")[-1]
        if len(directorio)>=4 and directorio != "aria":
            directorio=directorio[0]+".."

        nombre=directorio+"/"+os.path.basename(archivo["files"][0]["path"])
        if len(nombre)>20:
            nombre=nombre[:15]+"..."+nombre[-5:]
        try:
            porcentaje=float(archivo["completedLength"])/float(archivo["totalLength"])*100
            string+="\n${color white}${font Liberation Sans:size=9:style=Bold}%s${font} %s " %(nombre.encode("utf-8"), byte2Str(float(archivo["downloadSpeed"]), True))
            string+="${execbar echo %i}${color}" %porcentaje 
        except ZeroDivisionError:
            porcentaje= 0
    if not string:
        string="${voffset 10}${color}Idle"
    print string
else:
    print """Usage: aria.py options

Options:
  -global,         show global statistics
  -files,          show statistics for current download"""
