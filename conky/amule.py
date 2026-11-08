#!/usr/bin/python3
# -*- coding: utf-8 -*-

import subprocess

# Change for your system
# host = "jjgomera.tk"
host = "rpi"
port = "4712"

statisticsCommand = "amulecmd -h %s -p %s -c Statistics" % (host, port)
process = subprocess.Popen(statisticsCommand.split(), stdout=subprocess.PIPE)
statistics = process.communicate()[0].split(b"\n")

statusCommand = "amulecmd -h %s -p %s -c status" % (host, port)
process = subprocess.Popen(statusCommand.split(), stdout=subprocess.PIPE)
status = process.communicate()[0].split(b"\n")

process = subprocess.Popen(["amulecmd", "-h", host, "-p", port, "-c", "Show Log"], stdout=subprocess.PIPE)
log = (process.communicate()[0]).split(b"\n")
count = 0
download = []
for line in log:
    if b"terminada" in line:
        count += 1
        descarga = line.split(b" Descarga terminada: ")[-1].replace(b"\n",b"")
        download.append(descarga)


string = ""
if b"Succeeded!" in statistics[3]:
    data = statistics[5].split(b": ")[-1].split(b" ")
    d = 0
    if "Days" in data:
        d = int(data[0])
    h = data[-2].split(b":")[0].decode("utf8")
    m = data[-2].split(b":")[1].decode("utf8")

    string += "${color1}${alignr}Sesion: ${color white}%sd%sh%sm" % (d, h, m)
    string += """\n${voffset -8}${color #ffd700}${hr 1}"""

    ed2k = status[4].split(b": ")[-1].decode("utf8")
    if "Not connected" in ed2k:
        ed2k = "${color red}No"
    kad = status[5].split(b": ")[-1].decode("utf8")
    if "ok" in kad:
        kad = "ok"
    string += "\n${color1}ED2K: ${color white}%s" % (ed2k)
    string += "\n${color1}KAD: ${color white}%s" % (kad)
    string += "\n${color gold}${font Arrows:size=10}d${font} %i${color}" % count
    if count:
        string += " ${color blue}%s" % download[-1].decode("utf8")

    files = statistics[-4].split(b": ")[-1].decode("utf8")
    clients = status[-3].split(b"\t")[-1].decode("utf8")
    string += "\n${color1}Compartidos: ${color white}%s$alignr${color1}En cola: ${color white}%s" % (files, clients)

    upkb, upunit = status[7].split(b"\t")[-1].split()
    if upunit == b"bytes/sec":
        upkb = b"0"
    downkb, downunit = status[6].split(b"\t")[-1].split()
    if downunit == b"bytes/sec":
        downkb = b"0"
    up = statistics[9].split(b": ")[-1]

    index = statistics.index(b" >   Downloads")+1
    down = statistics[index].split(b": ")[-1]
    string += "\n${color1}Subida: ${color white}%s kB/s${alignr}${color}%s" % (upkb.decode("utf8"), up.decode("utf8"))
    string += "\n${color1}Descarga: ${color white}%s kB/s${alignr}${color}%s" % (downkb.decode("utf8"), down.decode("utf8"))
    string += "${voffset 8}"

else:
	string += """\n${voffset -5}${color #ffd700}${stippled_hr 1}
${color #ff0000} aMule no ejecutandose"""

print(string)
