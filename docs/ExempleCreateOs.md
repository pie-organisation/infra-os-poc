# 🧠 1. Ce que tu veux obtenir

À la fin tu auras :

✔️ build des images Docker (guest OS)
✔️ créer un rootfs Debian custom
✔️ utiliser Packer / Ansible
✔️ simuler ton infra localement

---

# ⚠️ 2. Limitation importante (WSL)

👉 WSL ≠ vrai Linux complet

Donc :

❌ pas de vrai kernel control
❌ Docker “classique” limité
❌ Packer VM limité

👉 MAIS :
✔️ parfait pour dev / build / test

---

# 🧱 3. Étape 1 — préparer Debian (base propre)

Dans ton WSL Debian :

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
  build-essential \
  curl \
  wget \
  git \
  unzip \
  ca-certificates \
  gnupg \
  lsb-release \
  software-properties-common
```

---

# 🐳 4. Étape 2 — installer Docker (IMPORTANT)

👉 sur WSL, tu dois utiliser **Docker Desktop Windows**

## 👉 côté Windows

Installe :
👉 **Docker Desktop**

Puis :

* activer WSL integration
* cocher ta Debian

---

## 👉 côté WSL (test)

```bash
docker ps
```

👉 si ça marche → parfait

---

# 🛠️ 5. Étape 3 — outils DevOps

Installe :

```bash
sudo apt install -y ansible
```

---

## Installer **Packer**

```bash
wget https://releases.hashicorp.com/packer/1.10.0/packer_1.10.0_linux_amd64.zip
unzip packer_1.10.0_linux_amd64.zip
sudo mv packer /usr/local/bin/
```

Test :

```bash
packer version
```

---

# 🧩 6. Étape 4 — installer debootstrap (clé pour ton OS)

```bash
sudo apt install -y debootstrap
```

👉 c’est L’outil pour créer ton Linux minimal

---

# 🧪 7. Étape 5 — créer ton premier “OS minimal”

```bash
mkdir ~/os-dev
cd ~/os-dev

sudo debootstrap --variant=minbase bookworm rootfs http://deb.debian.org/debian/
```

👉 ça va créer un mini Linux dans `rootfs/`

---

# 🔍 8. Étape 6 — entrer dedans (comme une VM)

```bash
sudo chroot rootfs
```

👉 là tu es “dans ton OS”

Test :

```bash
ls /
```

---

# ⚙️ 9. Étape 7 — customiser ton OS

Dans le chroot :

```bash
apt update
apt install -y xfce4 xfce4-terminal dbus-x11
```
(Tu vas devoir choisir un type de clavier. fais "Other / French / French Azerty")
👉 tu construis ton futur OS utilisateur

---

# 📦 10. Étape 8 — transformer en image Docker

Quitte le chroot :

```bash
exit
```

Puis :

```bash
sudo tar -C rootfs -czf rootfs.tar.gz .
```

---

Crée un Dockerfile :

```Dockerfile
FROM scratch
ADD rootfs.tar.gz /

CMD ["/bin/bash"]
```

---

Build :

```bash
docker build -t my-linux .
```

Run :

```bash
docker run -it my-linux
```

👉 BOOM 💥 tu as ton OS dans Docker

---

# 🧱 11. Étape 9 — structure de projet

```bash
mkdir -p infra-os/{guest-os,host-os}
cd infra-os
```

---

# 🖥️ 12. Bonus — tester XFCE (plus tard)

👉 dans WSL c’est compliqué (GUI)

Donc :

* test GUI dans VM (VirtualBox)
* ou via VNC

---

# 🚀 13. Ce que tu peux faire maintenant

👉 tu peux déjà :

✔️ créer ton OS minimal
✔️ le packager
✔️ le lancer en container

---


