#!/data/data/com.termux/files/usr/bin/bash

# Definición de colores
VERDE='\033[0;32m'
NC='\033[0m' # Sin Color (Reset)

# Aplicar color verde a partir de aquí
echo -e "${VERDE}"
clear

echo "=========================================="
echo "      TECNO TOOL - MODO REPOSITORIO"
echo "=========================================="
echo ""
echo "1) Desbloquear Bootloader"
echo "2) Flashear Recovery + VBMETA (Antiloop)"
echo "3) Entrar a FastbootD"
echo "4) Salir"
echo ""
read -p "Selecciona una opción: " opt

case $opt in
    1)
        echo "[!] Iniciando desbloqueo..."
        adb reboot bootloader
        fastboot flashing unlock
        ;;
    2)
        read -p "Escribe el modelo (ej: Spark10): " modelo
        echo "[+] Descargando archivos para $modelo..."
        curl -L "https://raw.githubusercontent.com/Optimizadorww/TECNO-TOOL-KP/main/Modelos/$modelo/recovery.img" -o recovery.img
        curl -L "https://raw.githubusercontent.com/Optimizadorww/TECNO-TOOL-KP/main/Modelos/$modelo/vbmeta.img" -o vbmeta.img
        fastboot flash recovery recovery.img
        fastboot flash vbmeta --disable-verity --disable-verification vbmeta.img
        echo "[+] Proceso completado correctamente."
        ;;
    3)
        echo "[+] Reiniciando a FastbootD..."
        adb reboot fastboot
        ;;
    4)
        echo -e "${NC}" # Resetear color antes de salir
        exit 0
        ;;
    *)
        echo "Opción no válida."
        ;;
esac

# Mantener el color verde si vuelve al menú
echo -e "${NC}"
