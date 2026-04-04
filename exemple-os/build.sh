#!/bin/bash

set -e

ROOTFS_DIR="rootfs"
TAR_FILE="rootfs.tar.gz"

echo "🧱 Création du rootfs Debian minimal..."

sudo debootstrap --variant=minbase bookworm $ROOTFS_DIR http://deb.debian.org/debian/

echo "⚙️ Configuration du rootfs..."

sudo chroot $ROOTFS_DIR /bin/bash -c "
apt update
xargs apt install -y < /config/packages.txt
apt clean
"

echo "📦 Création de l'archive..."

sudo tar -C $ROOTFS_DIR -czf $TAR_FILE .

echo "✅ Terminé !"