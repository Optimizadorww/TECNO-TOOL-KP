#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
NC='\033[0m'

# Ruta de descargas de Android
DOWNLOAD_DIR="/sdcard/Download"

clear
echo -e "${VERDE}"
echo "  _______                      _______             _ "
echo " |__   __|                    |__   __|           | |"
echo "    | | ___  ___ _ __   ___      | | ___   ___  | |"
echo "    | |/ _ \/ __| '_ \ / _ \     | |/ _ \ / _ \ | |"
echo "    | |  __/ (__| | | | (_) |    | | (_) | (_) || |"
echo "    |_|\___|\___|_| |_|\___/     |_|\___/ \___/ |_|"
echo "                                                     "
echo "        Creador AntiKripis          "
echo "====================================================="
echo ""
echo " 1) Desbloquear Bootloader"
echo " 2) Flashear Recovery (Desde Repositorio)"
echo " 3) Reiniciar a Modo FastbootD (OBLIGATORIO)"
echo " 4) Flashear ROM (Busca super.img en Descargas)"
echo " 5) Salir"
echo ""
read -p " SELECCIONA UNA OPCIÓN: " opt

case $opt in
    1)
        echo -e "\n[!] Reiniciando a Bootloader..."
        adb reboot bootloader
        fastboot flashing unlock
        ;;
    2)
        read -p " Escribe el modelo: " modelo
        echo -e "\n[+] Descargando Recovery..."
        curl -L "https://raw.githubusercontent.com/Optimizadorww/TECNO-TOOL-KP/main/Modelos/$modelo/recovery.img" -o recovery.img
        if [ -f "recovery.img" ]; then
            fastboot flash recovery recovery.img
            rm recovery.img
            echo -e "[✔] Recovery instalado."
        else
            echo -e "[✘] Error: No se encontró el archivo en GitHub."
        fi
        ;;
    3)
        echo -e "\n[+] Entrando a FastbootD..."
        adb reboot fastboot
        ;;
    4)
        echo -e "\n[!] ESCANEANDO CARPETA DE DESCARGAS..."
        
        # Comprobar si tenemos acceso a la memoria
        if [ ! -d "$DOWNLOAD_DIR" ]; then
            echo -e "[!] Error de acceso. Ejecutando termux-setup-storage..."
            termux-setup-storage
            echo "Por favor, acepta el permiso en pantalla y vuelve a ejecutar la opción 4."
        else
            # Buscar archivos
            SUPER_PATH="$DOWNLOAD_DIR/super.img"
            BOOT_PATH="$DOWNLOAD_DIR/boot.img"

            if [ -f "$SUPER_PATH" ] && [ -f "$BOOT_PATH" ]; then
                echo -e " [✔] Archivos encontrados en: $DOWNLOAD_DIR"
                read -p " ¿Deseas flashear super.img y boot.img ahora? (s/n): " confirm
                if [ "$confirm" = "s" ]; then
                    echo -
