#!/usr/bin/env bash
# Script para verificar que el proyecto esté listo para deployment en Render

echo "🔍 Verificando configuración para Render..."
echo ""

# Verificar archivos necesarios
echo "📁 Verificando archivos necesarios:"

if [ -f "bin/render-build.sh" ]; then
    echo "✅ bin/render-build.sh existe"
else
    echo "❌ bin/render-build.sh NO existe"
fi

if [ -f "render.yaml" ]; then
    echo "✅ render.yaml existe"
else
    echo "❌ render.yaml NO existe"
fi

if [ -f "config/master.key" ]; then
    echo "✅ config/master.key existe"
    echo "🔑 RAILS_MASTER_KEY: $(cat config/master.key)"
else
    echo "❌ config/master.key NO existe"
fi

if [ -f "DEPLOYMENT.md" ]; then
    echo "✅ DEPLOYMENT.md existe"
else
    echo "❌ DEPLOYMENT.md NO existe"
fi

echo ""
echo "🚀 ¡Tu proyecto está listo para deployment en Render!"
echo "📖 Consulta DEPLOYMENT.md para instrucciones detalladas"
