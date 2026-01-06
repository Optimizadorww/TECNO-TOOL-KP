#!/data/data/com.termux/files/usr/bin/bash

# Colores estilo Hacker
VERDE='\033[1;32m'
NC='\033[0m'

# Ruta directa a descargas
SDCARD="/sdcard/Download"

clear
echo -e "${VERDE}"
echo "  _______                      _______             _ "
echo " |__   __|                    |__   __|           | |"
echo "    | | ___  ___ _ __   ___      | | ___   ___  | |"
echo "    | |/ _ \/ __| '_ \ / _ \     | |/ _ \ / _ \ | |"
echo "    | |  __/ (__| | | | (_) |    | | (_) | (_) || |"
echo "    |_|\___|\___|_| |_|\___/     |_|\___/ \___/ |_|"
echo "                                                     "
echo "          DIRECT SUPER FLASH MODE - TECNO            "
echo "====================================================="
echo ""
echo " 1) Desbloquear Bootloader"
echo " 2) Entrar a Modo FastbootD (Letras Rojas)"
echo " 3) ¡FLASH DIRECTO SUPER.IMG! (Desde Descargas)"
echo " 4) Salir"
echo ""
read -p " OPCIÓN: " opt

case $opt in
    1)
        adb reboot bootloader && fastboot flashing unlock
        ;;
    2)
        echo -e "\n[+] Reiniciando a FastbootD..."
        adb reboot fastboot
        ;;
    3)
        echo -e "\n[!] Buscando super.img en /sdcard/Download..."
        
        if [ -f "$SDCARD/super.img" ]; then
            echo -e "[✔] Encontrado. Preparando flasheo..."
            # Flasheo directo
            fastboot flash super "$SDCARD/super.img"
            
            echo -e "\n[✔] Flasheo de SUPER terminado."
            read -p "¿Reiniciar teléfono? (s/n): " rin
            [ "$rin" = "s" ] && fastboot reboot
        else
            echo -e "\n[✘] Error: No existe el archivo 'super.img' en Descargas."
            echo "Asegúrate de que el nombre sea exactamente super.img (minúsculas)."
        fi
        ;;
    4)
        echo -e " Saliendo...\n${NC}"
        exit 0
        ;;
    *)
        TecnoTool
        ;;
esac
echo -e "${NC}"
