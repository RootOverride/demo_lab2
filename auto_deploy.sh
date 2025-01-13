#!/bin/bash

# Colores ANSI
CRE='\033[31m'  # Rojo
CYE='\033[33m'  # Amarillo
CGR='\033[32m'  # Verde
CBL='\033[34m'  # Azul
CBLE='\033[36m' # Cyan
CBK='\033[37m'  # Blanco
CGY='\033[38m'  # Gris
BLD='\033[1m'   # Negrita
CNC='\033[0m'   # Resetear colores


# Recorre cada uno de los nombres proporcionados como parámetros
for name in "$@"; do
    base_name=$(basename "$name" .tar)

    image_id=$(docker images -q "$base_name")
    if [ ! -z "$image_id" ]; then
        echo -e "\e[38;5;230;1mSe han detectado máquinas de DockerLabs previas, debemos limpiarlas para evitar problemas, espere un momento...\e[0m"
        container_ids=$(docker ps -a -q --filter "ancestor=$image_id")
        if [ ! -z "$container_ids" ]; then
            docker stop $container_ids > /dev/null 2>&1
            docker rm $container_ids > /dev/null 2>&1
        fi
    fi

done

for name in "$@"; do
    base_name=$(basename "$name" .tar)

    image_id=$(docker images -q "$base_name")
    if [ ! -z "$image_id" ]; then
        echo -e "\e[38;5;230;1mSe han detectado imágenes previas, eliminando para evitar conflictos...\e[0m"
        docker rmi -f "$image_id" > /dev/null 2>&1
    fi
done

if [ $# -ne 1 ]; then
    echo "Uso: $0 <archivo_tar>"
    exit 1
fi

if ! command -v docker &> /dev/null; then
    echo -e "\033[1;36m\nDocker no está instalado. Instalando Docker...\033[0m"
    sudo apt update
    sudo apt install docker.io -y
    echo -e "\033[1;36m\nEstamos habilitando el servicio de docker. Espere un momento...\033[0m"
    sleep 10
    systemctl restart docker && systemctl enable docker
    if [ $? -eq 0 ]; then
        echo "Docker ha sido instalado correctamente."
    else
        echo "Error al instalar Docker. Por favor, verifique y vuelva a intentarlo."
        exit 1
    fi
fi

TAR_FILE="$1"

echo -e "\e[1;93m\nEstamos desplegando la máquina vulnerable, espere un momento.\e[0m"
docker load -i "$TAR_FILE" > /dev/null

if [ $? -eq 0 ]; then

    IMAGE_NAME=$(basename "$TAR_FILE" .tar) # Obtiene el nombre del archivo sin la extensión .tar
    CONTAINER_NAME="${IMAGE_NAME}_container"

    if uname -a | grep -q arm; then # Línea para procesadores Mac OS
        apt install --assume-yes binfmt-support qemu-user-static -y > /dev/null
        docker run --platform linux/amd64 -d -p 8080:80 --name $CONTAINER_NAME $IMAGE_NAME > /dev/null
    else
        docker run -d -p 8080:80 --name $CONTAINER_NAME $IMAGE_NAME > /dev/null
    fi

    IP_ADDRESS=$(curl -s ifconfig.me)

    echo -e "\e[1;96m\nMáquina desplegada. Accede desde tu navegador a: http://<IP-PUBLICA>:8080\e[0m"

else
    echo -e "\e[91m\nHa ocurrido un error al cargar el laboratorio en Docker.\e[0m"
    exit 1
fi