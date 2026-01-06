#!/data/data/com.termux/files/usr/bin/bash

# Colores para que se vea bien
VERDE='\033[0;32m'
AZUL='\033[0;34m'
AMARILLO='\033[1;33m'
RESET='\033[0m'

clear
echo -e "${AZUL}=========================================="
echo -e "      TECNO TOOL - MODO REPOSITORIO"
echo -e "==========================================${RESET}"

echo -e "1) Desbloquear Bootloader"
echo -e "2) Flashear Recovery + VBMETA (Antiloop)"
echo -e "3) Reiniciar a FastbootD"
echo -e "4) Salir"
read -p "Selecciona una opción: " opt

case $opt in
    1)
        echo -e "${AMARILLO}[!] Asegúrate de tener OEM Unlocking activo.${RESET}"
        adb reboot bootloader
        fastboot flashing unlock
        ;;
    2)
        echo -e "${AZUL}[?] Modelos: Spark10, Pova5, Camon20${RESET}"
        read -p "Escribe el modelo: " modelo
        # Aquí es donde el script baja archivos de tu repo
        echo -e "${VERDE}[+] Descargando archivos para $modelo...${RESET}"
        curl -L "https://raw.githubusercontent.com/Optimizadorww/TECNO-TOOL-KP/main/Modelos/$modelo/recovery.img" -o recovery.img
        curl -L "https://raw.githubusercontent.com/Optimizadorww/TECNO-TOOL-KP/main/Modelos/$modelo/vbmeta.img" -o vbmeta.img
        
        fastboot flash recovery recovery.img
        fastboot flash vbmeta --disable-verity --disable-verification vbmeta.img
        echo -e "${VERDE}[+] Proceso completado.${RESET}"
        ;;
    3)
        adb reboot fastboot
        ;;
    4)
        exit 0
        ;;
    *)
        echo "Opción no válida."
        ;;
esac
