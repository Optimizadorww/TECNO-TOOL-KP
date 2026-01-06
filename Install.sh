#!/data/data/com.termux/files/usr/bin/bash

echo -e "\e[1;32m[+] Instalando dependencias necesarias...\e[0m"

# Actualizar paquetes e instalar android-tools y curl
pkg update -y && pkg upgrade -y
pkg install android-tools curl wget -y

# Dar permisos de almacenamiento
termux-setup-storage

# Descargar el script principal de la herramienta
echo -e "\e[1;32m[+] Descargando TecnoToolKP...\e[0m"
curl -L "https://raw.githubusercontent.com/KP/TECNO-TOOL-KP/main/Tool.sh" -o Tool.sh

# Dar permisos de ejecución
chmod +x tecno.sh

echo -e "\e[1;34m======================================="
echo -e " Instalación completada con éxito."
echo -e " Para iniciar usa: ./Tool.sh"
echo -e "=======================================\e[0m"
