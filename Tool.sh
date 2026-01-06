#!/data/data/com.termux/files/usr/bin/bash

# Colores estilo Hacker
VERDE='\033[1;32m'
NC='\033[0m'

# Ruta a la carpeta de Descargas de Android
SDCARD="/sdcard/Download"

# Bucle principal para permitir "Volver Atrás"
while true; do
    clear
    echo -e "${VERDE}"
    echo "  _______                      _______             _ "
    echo " |__   __|                    |__   __|           | |"
    echo "    | | ___  ___ _ __   ___      | | ___   ___  | |"
    echo "    | |/ _ \/ __| '_ \ / _ \     | |/ _ \ / _ \ | |"
    echo "    | |  __/ (__| | | | (_) |    | | (_) | (_) || |"
    echo "    |_|\___|\___|_| |_|\___/     |_|\___/ \___/ |_|"
    echo "                                                     "
    echo "                     @AntiKripis   "
    echo "====================================================="
    echo ""
    echo " 1) Reiniciar en Modo Bootloader (Fastboot)"
    echo " 2) Flashear Recovery (Desde /Descargas)"
    echo " 3) Reiniciar a Modo FastbootD (Letras Rojas)"
    echo " 4) Flashear Rom stock SUPER.IMG (Desde /Descargas)"
    echo " 5) Desbloquear Bootloader (Unlock)"
    echo " 6) Salir"
    echo ""
    read -p " SELECCIONA UNA OPCIÓN: " opt

    case $opt in
        1)
            echo -e "\n[+] Reiniciando a Modo Bootloader..."
            adb reboot bootloader
            echo -e "\nPresiona Enter para volver..."
            read
            ;;
        2)
            echo -e "\n[!] Buscando recovery.img en /sdcard/Download..."
            if [ -f "$SDCARD/recovery.img" ]; then
                echo -e "[✔] Archivo detectado."
                read -p "¿Confirmas flashear el Recovery? (s/n): " conf
                if [ "$conf" = "s" ]; then
                    echo -e "[+] Flasheando Recovery..."
                    fastboot flash recovery "$SDCARD/recovery.img"
                    echo -e "[✔] Proceso terminado."
                else
                    echo -e "Acción cancelada."
                fi
            else
                echo -e "\n[✘] ERROR: No se encontró 'recovery.img' en Descargas."
                echo " Asegúrate de que el archivo se llame exactamente recovery.img"
            fi
            echo -e "\nPresiona Enter para volver..."
            read
            ;;
        3)
            echo -e "\n[+] Reiniciando a Modo FastbootD..."
            adb reboot fastboot
            echo -e "\nPresiona Enter para volver..."
            read
            ;;
        4)
            echo -e "\n[!] Buscando super.img en /sdcard/Download..."
            if [ -f "$SDCARD/super.img" ]; then
                echo -e "[✔] Archivo encontrado."
                read -p "¿Seguro que quieres flashear el super.img? (s/n): " conf
                if [ "$conf" = "s" ]; then
                    echo -e "[+] Iniciando flasheo (Sé paciente)..."
                    fastboot flash super "$SDCARD/super.img"
                    echo -e "\n[✔] Flasheo terminado."
                else
                    echo -e "Flasheo cancelado."
                fi
            else
                echo -e "\n[✘] ERROR: No se encontró super.img en Descargas."
            fi
            echo -e "\nPresiona Enter para volver..."
            read
            ;;
        5)
            echo -e "\n[!] ADVERTENCIA: Se borrarán todos los datos."
            read -p "¿Proceder con el Unlock? (s/n): " conf
            if [ "$conf" = "s" ]; then
                fastboot flashing unlock
            else
                echo -e "Cancelado."
            fi
            sleep 2
            ;;
        6)
            echo -e " Saliendo...\n${NC}"
            exit 0
            ;;
        *)
            echo -e " Opción no válida."
            sleep 1
            ;;
    esac
done
