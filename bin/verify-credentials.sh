#!/usr/bin/env bash
# Script para verificar que las credenciales funcionen correctamente

echo "🔍 Verificando configuración de Rails credentials..."
echo ""

# Verificar que master.key existe
if [ -f "config/master.key" ]; then
    echo "✅ config/master.key existe"
    echo "🔑 RAILS_MASTER_KEY: $(cat config/master.key)"
else
    echo "❌ config/master.key NO existe"
    exit 1
fi

# Verificar que credentials.yml.enc existe
if [ -f "config/credentials.yml.enc" ]; then
    echo "✅ config/credentials.yml.enc existe"
else
    echo "❌ config/credentials.yml.enc NO existe"
    exit 1
fi

# Probar que las credenciales se pueden leer
echo ""
echo "🔐 Probando acceso a credenciales..."

if bundle exec rails runner "puts 'Secret key base present: ' + Rails.application.credentials.secret_key_base.present?.to_s" 2>/dev/null; then
    echo "✅ Credenciales funcionan correctamente"
else
    echo "❌ Error al acceder a las credenciales"
    echo "💡 Regenera las credenciales con: bundle exec rails credentials:edit"
    exit 1
fi

# Probar precompilación de assets (simulando build de Render)
echo ""
echo "🎨 Probando precompilación de assets..."
echo "   (Esto simula parte del proceso de build de Render)"

export RAILS_ENV=production
export SECRET_KEY_BASE=$(bundle exec rails runner "puts Rails.application.credentials.secret_key_base")

if bundle exec rails assets:precompile 2>/dev/null; then
    echo "✅ Assets se precompilan correctamente"
    # Limpiar assets después de la prueba
    bundle exec rails assets:clobber >/dev/null 2>&1
else
    echo "❌ Error al precompilar assets"
    exit 1
fi

echo ""
echo "🎉 ¡Todas las verificaciones pasaron!"
echo "🚀 Tu aplicación está lista para Render con la nueva RAILS_MASTER_KEY"
echo ""
echo "📋 Para Render, configura:"
echo "   RAILS_MASTER_KEY=$(cat config/master.key)"
