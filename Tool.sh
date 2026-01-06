#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
NC='\033[0m'

clear
echo -e "${VERDE}"
echo "  _______                      _______             _ "
echo " |__   __|                    |__   __|           | |"
echo "    | | ___  ___ _ __   ___      | | ___   ___  | |"
echo "    | |/ _ \/ __| '_ \ / _ \     | |/ _ \ / _ \ | |"
echo "    | |  __/ (__| | | | (_) |    | | (_) | (_) || |"
echo "    |_|\___|\___|_| |_|\___/     |_|\___/ \___/ |_|"
echo "                                                     "
echo "        MODO: REPOSITORIO & STOCK FLASH - 2026       "
echo "====================================================="
echo ""
echo " 1) Desbloquear Bootloader"
echo " 2) Flashear Recovery (Desde Repositorio)"
echo " 3) Reiniciar a Modo FastbootD"
echo " 4) Flashear ROM Stock (Archivos Locales)"
echo " 5) Salir"
echo ""
read -p " SELECCIONA UNA OPCIÓN: " opt

case $opt in
    1)
        echo -e "\n[!] Entrando a Bootloader..."
        adb reboot bootloader
        fastboot flashing unlock
        ;;
    2)
        echo -e "\n[?] Modelos en repo: Spark10, Pova5, Camon20"
        read -p " Escribe el nombre del modelo: " modelo
        echo -e "\n[+] Descargando Recovery para $modelo..."
        
        # Descarga solo el recovery
        curl -L "https://raw.githubusercontent.com/Optimizadorww/TECNO-TOOL-KP/main/Modelos/$modelo/recovery.img" -o recovery.img
        
        if [ -f "recovery.img" ]; then
            echo -e "[+] Flasheando Recovery..."
            fastboot flash recovery recovery.img
            rm recovery.img
            echo -e "[✔] Recovery instalado correctamente."
        else
            echo -e "[✘] Error: No se encontró el archivo en el repositorio."
        fi
        ;;
    3)
        echo -e "\n[+] Reiniciando a FastbootD (Recomendado para ROMs)..."
        adb reboot fastboot
        ;;
    4)
        echo -e "\n[!] BUSCANDO ARCHIVOS DE ROM STOCK EN CARPETA LOCAL..."
        # Verificación de archivos antes de flashear
        archivos=("boot.img" "system.img" "vendor.img" "product.img")
        encontrados=true

        for img in "${archivos[@]}"; do
            if [ ! -f "$img" ]; then
                echo -e " [✘] Falta: $img"
                encontrados=false
            fi
        done

        if [ "$encontrados" = true ]; then
            read -p " ¿Confirmas el flasheo total? (s/n): " confirm
            if [ "$confirm" = "s" ]; then
                echo -e "[+] Flasheando..."
                fastboot flash boot boot.img
                fastboot flash system system.img
                fastboot flash vendor vendor.img
                fastboot flash product product.img
                echo -e "\n[✔] ROM Stock instalada. Reiniciando dispositivo..."
                fastboot reboot
            fi
        else
            echo -e "\n[!] Error: Asegúrate de que todos los archivos .img estén en esta carpeta."
        fi
        ;;
    5)
        echo -e " Saliendo...\n${NC}"
        exit 0
        ;;
    *)
        echo -e " Opción no válida."
        sleep 1
        TecnoTool
        ;;
esac
echo -e "${NC}"
