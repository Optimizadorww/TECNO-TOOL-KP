#!/data/data/com.termux/files/usr/bin/bash

# Color Verde
VERDE='\033[0;32m'
NC='\033[0m'

echo -e "${VERDE}"
echo "------------------------------------------------"
echo "       INSTALANDO TECNO TOOL KP..."
echo "------------------------------------------------"

pkg update -y
pkg install android-tools curl -y

# Instalando el ejecutable
curl -L "https://raw.githubusercontent.com/Optimizadorww/TECNO-TOOL-KP/main/Tool.sh" -o $PREFIX/bin/TecnoTool
chmod +x $PREFIX/bin/TecnoTool

echo ""
echo " CONFIGURACIÓN COMPLETADA."
echo " Ahora puedes escribir: TecnoTool"
echo "------------------------------------------------"
echo -e "${NC}"
