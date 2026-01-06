#!/data/data/com.termux/files/usr/bin/bash

# Colores estilo Hacker
VERDE='\033[1;32m'
NC='\033[0m'

# Ruta directa a descargas
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
    echo "                    @AntiKripis           "
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
            echo -e "\nPresiona Enter para volver al menú..."
            read
            ;;
        2)
            echo -e "\n[!] ADVERTENCIA: Esto borrará tus datos."
            read -p "¿Continuar con el desbloqueo? (s/n): " conf
            if [ "$conf" = "s" ]; then
                fastboot flashing unlock
            else
                echo -e "Acción cancelada."
            fi
            sleep 2
            ;;
        3)
            echo -e "\n[+] Reiniciando a Modo FastbootD..."
            adb reboot fastboot
            echo -e "\nPresiona Enter para volver al menú..."
            read
            ;;
        4)
            echo -e "\n[!] Buscando super.img en /sdcard/Download..."
            if [ -f "$SDCARD/super.img" ]; then
                echo -e "[✔] Archivo encontrado."
                read -p "¿Seguro que quieres flashear el super.img ahora? (s/n): " conf
                if [ "$conf" = "s" ]; then
                    echo -e "[+] Iniciando flasheo..."
                    fastboot flash super "$SDCARD/super.img"
                    echo -e "\n[✔] Flasheo terminado."
                else
                    echo -e "Flasheo cancelado por el usuario."
                fi
            else
                echo -e "\n[✘] ERROR: No se encontró super.img en Descargas."
            fi
            echo -e "\nPresiona Enter para volver al menú..."
            read
            ;;
        5)
            echo -e " Saliendo...\n${NC}"
            exit 0
            ;;
        *)
            echo -e " Opción no válida, intenta de nuevo."
            sleep 1
            ;;
    esac
done
