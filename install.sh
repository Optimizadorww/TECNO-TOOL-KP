#!/data/data/com.termux/files/usr/bin/bash

echo "Preparando entorno..."

# 1. Instalar herramientas necesarias
pkg update -y
pkg install android-tools curl -y

# 2. Descargar el script principal
# Usamos -L para seguir redirecciones de GitHub y -o para ponerle nombre
curl -L "https://raw.githubusercontent.com/Optimizadorww/TECNO-TOOL-KP/main/Tool.sh" -o Tool.sh

# 3. Dar permisos de ejecución (Crucial para evitar 'Permiso denegado')
chmod +x Tool.sh

# 4. Mensaje final
echo "----------------------------------------"
echo "Instalación terminada."
echo "Para iniciar la herramienta escribe: ./Tool.sh"
echo "----------------------------------------"
