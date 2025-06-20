#!/usr/bin/env bash
# Script simple para verificar que el build funcione con SECRET_KEY_BASE

echo "🧪 Probando build process para Render..."

# Simular variables de entorno de Render
export RAILS_ENV=production
export RAILS_MASTER_KEY=$(cat config/master.key)
export SECRET_KEY_BASE=$(bundle exec rails secret)
export DATABASE_URL="postgresql://test:test@localhost/test"

echo "✅ Variables configuradas"
echo "🔑 RAILS_MASTER_KEY: $RAILS_MASTER_KEY"
echo "🔐 SECRET_KEY_BASE: ${SECRET_KEY_BASE:0:20}..."

# Probar que Rails arranque correctamente
echo ""
echo "🚀 Probando inicialización de Rails..."
if bundle exec rails runner "puts 'Rails OK: ' + Rails.env" 2>/dev/null; then
    echo "✅ Rails se inicializa correctamente"
else
    echo "❌ Error al inicializar Rails"
    exit 1
fi

# Probar precompilación de assets
echo ""
echo "🎨 Probando precompilación de assets..."
if RAILS_ENV=production bundle exec rails assets:precompile 2>/dev/null; then
    echo "✅ Assets se precompilan correctamente"
    bundle exec rails assets:clobber >/dev/null 2>&1
else
    echo "❌ Error al precompilar assets"
    exit 1
fi

echo ""
echo "🎉 ¡Prueba exitosa! El proyecto está listo para Render"
echo ""
echo "📋 Variables requeridas en Render:"
echo "   RAILS_MASTER_KEY=$RAILS_MASTER_KEY"
echo "   SECRET_KEY_BASE=[Render lo generará automáticamente]"
echo "   DATABASE_URL=[desde PostgreSQL database]"
