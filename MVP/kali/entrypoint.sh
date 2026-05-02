#!/bin/bash
set -e

PORT=${PORT:-8080}

# Logs
exec > >(tee /var/log/entrypoint.log) 2>&1

# 1) DISPLAY
export DISPLAY=:0

echo "Starting Xvfb..."
Xvfb :0 -screen 0 1280x800x16 &
sleep 2

echo "Starting XFCE..."
startxfce4 &
sleep 2

echo "Starting x11vnc..."
x11vnc -display :0 -nopw -forever -shared -rfbport 5900 &
sleep 2

echo "Starting noVNC on port $PORT..."
websockify --web=/usr/share/novnc/ $PORT localhost:5900
