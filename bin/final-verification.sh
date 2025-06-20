#!/bin/bash

echo "🔍 VERIFICACIÓN FINAL PRE-DEPLOYMENT"
echo "=================================="
echo

# Verificar que estamos en el directorio correcto
if [ ! -f "config/application.rb" ]; then
    echo "❌ Error: No se encuentra config/application.rb"
    echo "   Asegúrate de estar en la raíz del proyecto Rails"
    exit 1
fi

echo "✅ Directorio del proyecto correcto"

# Verificar archivos críticos
echo
echo "🔍 Verificando archivos críticos..."

critical_files=(
    "bin/render-build.sh"
    "config/database.yml"
    "config/master.key"
    "config/credentials.yml.enc"
    "config/environments/production.rb"
    "render.yaml"
)

for file in "${critical_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file - FALTANTE"
        exit 1
    fi
done

# Verificar que render-build.sh sea ejecutable
if [ -x "bin/render-build.sh" ]; then
    echo "✅ bin/render-build.sh es ejecutable"
else
    echo "⚠️  Haciendo bin/render-build.sh ejecutable..."
    chmod +x bin/render-build.sh
    echo "✅ bin/render-build.sh ahora es ejecutable"
fi

# Verificar variables de entorno
echo
echo "🔍 Verificando variables de entorno..."

if [ -n "$RAILS_MASTER_KEY" ]; then
    echo "✅ RAILS_MASTER_KEY configurada: ${RAILS_MASTER_KEY:0:8}..."
else
    echo "❌ RAILS_MASTER_KEY no configurada"
    echo "   Ejecuta: export RAILS_MASTER_KEY=cac35977f1b62444e5d10efd79d60ff4"
    exit 1
fi

# Verificar dependencias
echo
echo "🔍 Verificando dependencias..."

if command -v bundle &> /dev/null; then
    echo "✅ Bundler disponible"
else
    echo "❌ Bundler no encontrado"
    exit 1
fi

if command -v yarn &> /dev/null; then
    echo "✅ Yarn disponible"
else
    echo "❌ Yarn no encontrado"
    exit 1
fi

# Probar inicialización de Rails
echo
echo "🔍 Probando inicialización de Rails..."
if RAILS_ENV=production bundle exec rails runner "puts 'OK'" &> /dev/null; then
    echo "✅ Rails se inicializa correctamente"
else
    echo "❌ Error al inicializar Rails"
    exit 1
fi

# Probar precompilación de assets (sin ejecutar completamente)
echo
echo "🔍 Verificando configuración de assets..."
if RAILS_ENV=production bundle exec rails runner "puts Rails.application.config.assets.prefix" &> /dev/null; then
    echo "✅ Configuración de assets OK"
else
    echo "❌ Error en configuración de assets"
    exit 1
fi

echo
echo "🎉 VERIFICACIÓN FINAL EXITOSA"
echo "=========================="
echo "✅ El proyecto está listo para deployment en Render"
echo
echo "📋 PRÓXIMOS PASOS:"
echo "1. Ir a Render Dashboard"
echo "2. Actualizar RAILS_MASTER_KEY: cac35977f1b62444e5d10efd79d60ff4"
echo "3. Crear PostgreSQL database: piclens-db"
echo "4. Conectar DATABASE_URL desde la base de datos"
echo "5. Hacer re-deploy"
echo
echo "📚 Documentación disponible:"
echo "   - FINAL_STATUS.md - Resumen completo"
echo "   - DEPLOYMENT.md - Guía de deployment"
echo "   - POSTGRES_SETUP.md - Configuración de base de datos"
echo
