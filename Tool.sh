#!/data/data/com.termux/files/usr/bin/bash

# --- CONFIGURACIÓN ---
USER="TuUsuario"  # Cambia esto por tu nombre de GitHub
REPO="TECNO-TOOL-KP"
RAW_URL="https://raw.githubusercontent.com/$USER/$REPO/main"

# --- INTERFAZ VISUAL ---
clear
echo -e "\e[1;36m======================================"
echo -e "       TECNO TOOL KP v1.0"
echo -e "======================================\e[0m"

echo "1. Desbloquear Bootloader (Básico)"
echo "2. Flashear Recovery + VBMETA (Desde Repositorio)"
echo "3. Entrar a FastbootD (Para modelos nuevos)"
echo "4. Salir"
read -p "Selecciona una opción: " opcion

case $opcion in
    1)
        echo "Asegúrate de tener 'Desbloqueo OEM' activo."
        adb reboot bootloader
        fastboot flashing unlock
        ;;
    2)
        echo -e "\nModelos disponibles: Spark10Pro, Pova5, Camon20"
        read -p "Escribe el modelo exacto: " modelo
        
        echo -e "\e[1;33mDescargando archivos para $modelo...\e[0m"
        
        # Descarga de archivos usando la estructura del repo
        curl -L "$RAW_URL/$modelo/recovery.img" -o recovery.img
        curl -L "$RAW_URL/$modelo/vbmeta.img" -o vbmeta.img
        
        echo "Flasheando Recovery..."
        fastboot flash recovery recovery.img
        
        echo "Flasheando VBMETA (Antiloop)..."
        fastboot flash vbmeta --disable-verity --disable-verification vbmeta.img
        
        echo -e "\e[1;32m¡Proceso terminado!\e[0m"
        rm recovery.img vbmeta.img # Limpia archivos temporales
        ;;
    3)
        echo "Reiniciando a FastbootD..."
        adb reboot fastboot
        ;;
    4)
        exit
        ;;
esac
