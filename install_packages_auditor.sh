#!/bin/bash

START_TIME=$(date '+%Y-%m-%d %H:%M:%S')
echo ""
echo "########## ⏰ Inicio del script: $START_TIME"
echo ""
echo "########## Comprobando conexión a internet"
echo ""
# Dirección a comprobar (puede ser cualquier sitio confiable)
CHECK_URL="8.8.8.8"
# Bucle hasta que haya conexión
while ! ping -c 1 -W 2 $CHECK_URL &> /dev/null; do
  echo "Sin conexión, reintentando..."
  sleep 1  # Espera 1 segundo antes de volver a comprobar
done

# Actualización del sistema operativo
echo ""
echo "########## Actualizando Sistema"
echo ""
sudo apt-get update -y -o Acquire::ForceIPv4=true
#sudo apt-get upgrade -y


#echo ""
#echo "########## Instalando Librerias de Python"
#echo ""
# Instacion Librerias Python3
#sudo apt-get install python3-pip -y -o Acquire::ForceIPv4=true
#sudo pip install virtualenv -y -o Acquire::ForceIPv4=true

echo ""
echo "########## Instalando Metasploit"
echo ""
# Instalación de Metasploit (Framework Pruebas de Penetración)
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
sudo chmod 755 msfinstall
sudo ./msfinstall

echo ""
echo "########## Instalando Nmap"
echo ""
# Instalación de Nmap (Enumeración)
sudo apt-get install nmap -y -o Acquire::ForceIPv4=true

echo ""
echo "########## Actualizando Hping3"
echo ""
# Instalación de HPing3 (Enviar paquetes ICMP/UDP/TCP personalizados)
sudo apt-get install hping3 -y -o Acquire::ForceIPv4=true

echo ""
echo "########## Instalando Scapy"
echo ""
# Instalación de Scapy (Manipulación de paquetes)
sudo apt-get install python3-scapy -y -o Acquire::ForceIPv4=true

echo ""
echo "########## Instalando Yersinia"
echo ""
# Instalación de Yersinia (Ataques de Red)
sudo apt-get install yersinia -y -o Acquire::ForceIPv4=true

echo ""
echo "########## Instalando Wfuzz y Gobuster"
echo ""
# Instalación de Wfuzz (Fuzzing)
sudo apt-get install wfuzz -y -o Acquire::ForceIPv4=true
sudo apt-get install gobuster -y -o Acquire::ForceIPv4=true

echo ""
echo "########## Instalando SqlMap"
echo ""
# Instalación de SQLMap (Inyecciones SQL)
sudo apt-get install sqlmap -y -o Acquire::ForceIPv4=true

echo ""
echo "########## Actualizando Hydra"
echo ""
# Instalación de Hydra (Ataques de Fuerza Bruta)
sudo apt-get install hydra -y -o Acquire::ForceIPv4=true

echo ""
echo "########## Instalando John The Ripper"
echo ""
# Instalación de John the Ripper (Descifrador de contraseñas)
sudo apt-get install john -y -o Acquire::ForceIPv4=true

echo ""
echo "########## Instalando DNSRecon"
echo ""
# Instalación de DNSRecon (Herramienta de escaneo y enumeración DNS)
sudo apt-get install dnsrecon -y -o Acquire::ForceIPv4=true

echo ""
echo "########## Instalando WhatWeb"
echo ""
# Instalación de WhatWeb (Recopila información de sito Web)
sudo apt-get install whatweb -y -o Acquire::ForceIPv4=true

echo ""
echo "########## Instalando TShark"
echo ""
# Instlación de Tshark (Capt-getura y Analisis de Paquetes)
sudo DEBIAN_FRONTEND=noninteractive apt-get install tshark -y -o Acquire::ForceIPv4=true

echo ""
echo "########## Cambiando Hostname"
echo ""
# Cambiar Hostname
sudo hostnamectl set-hostname Auditor

# Instalación de Evil-WinRM (Marco de pruebas de penetración)
#sudo gem install evil-winrm

# Instalación de OpenVAS (Escáner de vulnerabilidades)
#sudo apt-get install -y gvm
#sudo gvm-setup
#sudo systemctl start gvmd
#sudo systemctl start ospd-openvas
#sudo systemctl start gsad

# Descargar Diccionarios
echo ""
echo "########## Descargando Diccionario Rockyou"
echo ""
cd /home/ubuntu/
mkdir diccionarios
cd diccionarios
#git clone https://github.com/danielmiessler/SecLists.git
sudo git clone https://github.com/zacheller/rockyou.git
sudo tar -xvzf ./rockyou/rockyou.txt.tar.gz
sudo rm -Rf rockyou

START_TIMEF=$(date '+%Y-%m-%d %H:%M:%S')
echo ""
echo "########## ⏰ Finalización del script: $START_TIMEF"
echo ""
