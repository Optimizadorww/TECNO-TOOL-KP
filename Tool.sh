#!/data/data/com.termux/files/usr/bin/bash

# Colores estilo Hacker
VERDE='\033[1;32m'
NC='\033[0m'

# Ruta directa a descargas de Android
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
echo "          @AntiKripis 2025/2026           "
echo "====================================================="
echo ""
echo " 1) Reiniciar en Modo Bootloader (Fastboot)"
echo " 2) Desbloquear Bootloader (Unlock)"
echo " 3) Reiniciar a Modo FastbootD (Letras Rojas)"
echo " 4) ¡Flashear Rom stock SUPER.IMG! (Ruta) (Descargas)"
echo " 5) Salir"
echo ""
read -p " SELECCIONA UNA OPCIÓN: " opt

case $opt in
    1)
        echo -e "\n[+] Reiniciando a Modo Bootloader..."
        adb reboot bootloader
        ;;
    2)
        echo -e "\n[!] Intentando desbloqueo de Bootloader..."
        fastboot flashing unlock
        ;;
    3)
        echo -e "\n[+] Reiniciando a Modo FastbootD (Necesario para SUPER)..."
        adb reboot fastboot
        ;;
    4)
        echo -e "\n[!] Buscando super.img en /sdcard/Download..."
        
        if [ -f "$SDCARD/super.img" ]; then
            echo -e "[✔] Encontrado. Iniciando flasheo directo..."
            # Comando de flasheo directo al grano
            fastboot flash super "$SDCARD/super.img"
            
            echo -e "\n[✔] Flasheo de SUPER finalizado con éxito."
            read -p "¿Deseas reiniciar el sistema ahora? (s/n): " rin
            [ "$rin" = "s" ] && fastboot reboot
        else
            echo -e "\n[✘] ERROR: No se encontró 'super.img' en la carpeta de Descargas."
            echo " Asegúrate de que el archivo esté en /sdcard/Download/super.img"
        fi
        ;;
    5)
        echo -e " Saliendo...\n${NC}"
        exit 0
        ;;
    *)
        # Si el usuario pone algo mal, limpia y reinicia el menú
        TecnoTool
        ;;
esac
echo -e "${NC}"
