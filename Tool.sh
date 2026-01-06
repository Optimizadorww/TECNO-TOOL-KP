#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
NC='\033[0m'

# Limpiar pantalla y mostrar arte ASCII
clear
echo -e "${VERDE}"
echo "  _______                      _______             _ "
echo " |__   __|                    |__   __|           | |"
echo "    | | ___  ___ _ __   ___      | | ___   ___  | |"
echo "    | |/ _ \/ __| '_ \ / _ \     | |/ _ \ / _ \ | |"
echo "    | |  __/ (__| | | | (_) |    | | (_) | (_) || |"
echo "    |_|\___|\___|_| |_|\___/     |_|\___/ \___/ |_|"
echo "                                                     "
echo "        MODO: Creado Con Amor KP  - 2026          "
echo "====================================================="
echo ""
echo " 1) Desbloquear Bootloader (Standard)"
echo " 2) Flashear Recovery + VBMETA (Evita Bootloop)"
echo " 3) Entrar a Modo Fastboot"
echo " 4) Salir"
echo ""
read -p " SELECCIONA UNA OPCIÓN: " opt

case $opt in
    1)
        echo -e "\n[!] Asegúrate de activar OEM UNLOCK en ajustes."
        adb reboot bootloader
        fastboot flashing unlock
        ;;
    2)
        echo -e "\n[?] Modelos disponibles en repo: Spark10, Pova5, Camon20"
        read -p " Escribe el nombre del modelo: " modelo
        echo -e "\n[+] Descargando archivos desde el repositorio..."
        
        # El comando curl busca dentro de la carpeta Modelos de tu repo
        curl -L "https://raw.githubusercontent.com/Optimizadorww/TECNO-TOOL-KP/main/Modelos/$modelo/recovery.img" -o recovery.img
        curl -L "https://raw.githubusercontent.com/Optimizadorww/TECNO-TOOL-KP/main/Modelos/$modelo/vbmeta.img" -o vbmeta.img
        
        echo -e "\n[+] Iniciando flasheo..."
        fastboot flash recovery recovery.img
        fastboot flash vbmeta --disable-verity --disable-verification vbmeta.img
        
        # Limpiar basura
        rm recovery.img vbmeta.img
        echo -e "\n[✔] ¡Hecho! El dispositivo ya no debería dar Bootloop."
        ;;
    3)
        echo -e "\n[+] Reiniciando a Fastboot (Pantalla con letras rojas)..."
        adb reboot Bootloader 
        ;;
    4)
        echo -e " Saliendo...\n${NC}"
        exit 0
        ;;
    *)
        echo -e " Opción no válida."
        sleep 2
        TecnoTool # Reinicia el script
        ;;
esac
echo -e "${NC}"
