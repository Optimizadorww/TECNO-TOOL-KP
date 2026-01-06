#!/data/data/com.termux/files/usr/bin/bash

VERDE='\033[1;32m'
NC='\033[0m'

echo -e "${VERDE}[+] Iniciando instalación de TecnoTool v1.0...${NC}"

# Actualizar e instalar dependencias
pkg update -y && pkg upgrade -y
pkg install android-tools curl -y

# Configurar el ejecutable en el sistema
echo -e "${VERDE}[+] Configurando comando global...${NC}"
curl -L "https://raw.githubusercontent.com/Optimizadorww/TECNO-TOOL-KP/main/Tool.sh" -o $PREFIX/bin/TecnoTool
chmod +x $PREFIX/bin/TecnoTool

echo -e "\n${VERDE}=========================================="
echo "    INSTALACIÓN COMPLETADA CON ÉXITO"
echo "    Escribe 'TecnoTool' para iniciar"
echo -e "==========================================${NC}"
