#!/bin/bash
tools/luatool.py --src app/${1}.lua --dest ${1}.lua -r -b 9600 -p /dev/tty.usbserial-A98RJP5T
