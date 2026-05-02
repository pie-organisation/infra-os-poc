#!/bin/bash

set -e

# X11 socket fix
mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

export DISPLAY=:1

# X server
Xvfb :1 -screen 0 1024x768x16 &
sleep 2

# DBus propre
export $(dbus-launch)

# XFCE (background OK mais après DBus)
startxfce4 &
sleep 2

# VNC
x11vnc \
  -display :1 \
  -forever \
  -shared \
  -passwd password \
  -noxdamage \
  -ncache 10 \
  -ncache_cr \
  -repeat \
  -rfbport 5900 &

# noVNC proxy (foreground recommandé)
exec websockify --web=/usr/share/novnc/ 6080 localhost:5900