#!/usr/bin/env bash
# Script para verificar y configurar PostgreSQL en Render

echo "🐘 Configuración de PostgreSQL para Render"
echo "=========================================="
echo ""

# Función para mostrar información
show_info() {
    echo "📋 INFORMACIÓN PARA RENDER:"
    echo ""
    echo "1. 🗄️  CREAR BASE DE DATOS POSTGRESQL:"
    echo "   - Ve a: https://dashboard.render.com"
    echo "   - Clic en 'New +' > 'PostgreSQL'"
    echo "   - Name: piclens-db"
    echo "   - Database: piclens_production"
    echo "   - User: piclens_user"
    echo "   - Plan: Free (o el que prefieras)"
    echo ""
    
    echo "2. 🔧 VARIABLES DE ENTORNO NECESARIAS:"
    echo "   DATABASE_URL=postgres://user:pass@host:5432/dbname"
    echo "   RAILS_MASTER_KEY=$(cat config/master.key 2>/dev/null || echo 'TU_MASTER_KEY')"
    echo "   RAILS_ENV=production"
    echo "   BUNDLE_WITHOUT=development:test"
    echo "   RAILS_SERVE_STATIC_FILES=true"
    echo "   RAILS_LOG_TO_STDOUT=true"
    echo "   WEB_CONCURRENCY=2"
    echo "   RAILS_MAX_THREADS=5"
    echo ""
    
    echo "3. 🚀 CONFIGURACIÓN DEL WEB SERVICE:"
    echo "   - Build Command: ./bin/render-build.sh"
    echo "   - Start Command: bundle exec puma -C config/puma.rb"
    echo "   - Environment: Ruby"
    echo ""
}

# Función para verificar archivos
check_files() {
    echo "✅ VERIFICANDO ARCHIVOS:"
    
    files=(
        "bin/render-build.sh"
        "config/database.yml"
        "config/master.key"
        "render.yaml"
        "POSTGRES_SETUP.md"
    )
    
    for file in "${files[@]}"; do
        if [ -f "$file" ]; then
            echo "   ✅ $file"
        else
            echo "   ❌ $file (FALTANTE)"
        fi
    done
    echo ""
}

# Función para mostrar configuración de database.yml
show_database_config() {
    echo "🔍 CONFIGURACIÓN DE DATABASE.YML:"
    if [ -f "config/database.yml" ]; then
        echo "   ✅ Archivo existe"
        if grep -q "DATABASE_URL" config/database.yml; then
            echo "   ✅ DATABASE_URL configurado"
        else
            echo "   ❌ DATABASE_URL NO configurado"
        fi
    else
        echo "   ❌ Archivo NO existe"
    fi
    echo ""
}

# Función para mostrar master key
show_master_key() {
    echo "🔑 RAILS_MASTER_KEY:"
    if [ -f "config/master.key" ]; then
        echo "   ✅ $(cat config/master.key)"
        echo "   ⚠️  GUARDA ESTA CLAVE DE FORMA SEGURA"
    else
        echo "   ❌ Master key NO encontrada"
        echo "   💡 Ejecuta: EDITOR='echo \"secret_key_base: \$(bundle exec rails secret)\" >' bundle exec rails credentials:edit"
    fi
    echo ""
}

# Función para probar conexión local (si está disponible)
test_local_connection() {
    echo "🔌 PRUEBA DE CONEXIÓN LOCAL:"
    if command -v psql >/dev/null 2>&1; then
        echo "   ✅ PostgreSQL cliente instalado"
        if [ -n "$DATABASE_URL" ]; then
            echo "   🔄 Probando conexión a: $DATABASE_URL"
            if psql "$DATABASE_URL" -c "SELECT version();" >/dev/null 2>&1; then
                echo "   ✅ Conexión exitosa"
            else
                echo "   ❌ Error de conexión"
            fi
        else
            echo "   ⚠️  DATABASE_URL no configurada localmente"
        fi
    else
        echo "   ⚠️  PostgreSQL cliente no instalado localmente"
        echo "   💡 Para instalar: brew install postgresql"
    fi
    echo ""
}

# Función principal
main() {
    show_info
    check_files
    show_database_config
    show_master_key
    test_local_connection
    
    echo "📖 DOCUMENTACIÓN COMPLETA:"
    echo "   📄 POSTGRES_SETUP.md - Guía detallada de PostgreSQL"
    echo "   📄 DEPLOYMENT.md - Guía general de deployment"
    echo ""
    
    echo "🎯 PRÓXIMOS PASOS:"
    echo "1. 🌐 Ve a https://dashboard.render.com"
    echo "2. 🗄️  Crea una base de datos PostgreSQL"
    echo "3. 🚀 Crea un Web Service conectado a tu repo"
    echo "4. 🔧 Configura las variables de entorno"
    echo "5. 🎉 ¡Deploy automático!"
    echo ""
}

# Ejecutar solo si es llamado directamente
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    main "$@"
fi
