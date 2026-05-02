FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    xvfb \
    novnc \
    websockify \
    wget \
    x11vnc \
    dbus-x11 \
    && apt clean 

# Créer user
RUN useradd -m user

# Copier script AVANT USER
COPY start.sh /home/user/start.sh
RUN chmod +x /home/user/start.sh && chown user:user /home/user/start.sh

# Passer en user
USER user
WORKDIR /home/user

# Setup VNC
RUN mkdir -p ~/.vnc && \
    echo "password" | vncpasswd -f > ~/.vnc/passwd && \
    chmod 600 ~/.vnc/passwd

EXPOSE 6080

CMD ["./start.sh"]