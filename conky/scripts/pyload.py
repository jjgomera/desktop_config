#!/usr/bin/python
# -*- coding: utf-8 -*-

from urllib import urlopen, urlencode
from json import dumps

#Change this values for your system
user="xxxxxx"
password="xxxxxxx"
ip="192.168.1.145"
port="8000"

URL = "http://%s:%s/api/%s" % (ip, port, "%s")

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
    
def login(user, pw):
    params = {"username": user, "password": pw}
    ret = urlopen(URL % "login", urlencode(params))
    return ret.read().strip("\"")

# send arbitrary command to pyload api, parameter as keyword argument
def send(session, command, **kwargs):
    # convert arguments to json format
    params = dict([(k, dumps(v)) for k,v in kwargs.iteritems()])
    params["session"] = session
    ret = urlopen(URL % command, urlencode(params))
    return ret.read()

if __name__ == "__main__":

    try:
        session = login(user, password)
        archivos = eval(send(session, "statusDownloads"))
        string=""
        for archivo in archivos:
            nombre=archivo["name"]
            if len(nombre)>20:
                nombre=nombre[:15]+"..."+nombre[-5:]
            string+="\n${color white}${font Liberation Sans:size=9:style=Bold}%s${font} %s " %(nombre, byte2Str(float(archivo["speed"]), True))
            string+="${execbar echo %i}${color}" %archivo["percent"]
        if not string:
            string="\n${color}Idle"
    except IOError:
        string="\n${color}Not Running"
    print string


