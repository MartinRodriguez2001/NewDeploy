# Deployment Guide para Render

Este documento explica cómo deployar la aplicación PicLens en Render.

## Prerrequisitos

1. Cuenta en [Render](https://render.com)
2. Repositorio en GitHub con el código actualizado
3. RAILS_MASTER_KEY de tu aplicación

## Pasos para el Deployment

### 1. Preparar las variables de entorno

Necesitarás configurar las siguientes variables de entorno en Render:

- `RAILS_MASTER_KEY`: La clave maestra de Rails (ver `config/master.key`)
- `RAILS_ENV`: `production`
- `BUNDLE_WITHOUT`: `development:test`
- `WEB_CONCURRENCY`: `2`
- `RAILS_MAX_THREADS`: `5`
- `RAILS_SERVE_STATIC_FILES`: `true`
- `RAILS_LOG_TO_STDOUT`: `true`

### 2. Obtener la RAILS_MASTER_KEY

```bash
cat config/master.key
```

### 3. Crear el servicio en Render

1. Ve a [Render Dashboard](https://dashboard.render.com)
2. Haz clic en "New +"
3. Selecciona "Web Service"
4. Conecta tu repositorio de GitHub
5. Configura el servicio:
   - **Name**: piclens
   - **Environment**: Ruby
   - **Build Command**: `./bin/render-build.sh`
   - **Start Command**: `bundle exec puma -C config/puma.rb`

### 4. Crear la base de datos PostgreSQL

1. En el dashboard de Render, haz clic en "New +"
2. Selecciona "PostgreSQL"
3. Configura:
   - **Name**: piclens-db
   - **Plan**: Free (o el que prefieras)

### 5. Conectar la base de datos

1. Ve a la configuración de tu web service
2. En "Environment Variables", añade:
   - **Key**: `DATABASE_URL`
   - **Value**: Selecciona "From Database" y elige tu base de datos

### 6. Deployment automático

Una vez configurado, Render automáticamente:
- Detectará cambios en tu repositorio
- Ejecutará el build script
- Desplegará la nueva versión

## Archivos importantes para Render

- `bin/render-build.sh`: Script que se ejecuta durante el build
- `render.yaml`: Configuración as-code para Render (opcional)
- `config/database.yml`: Configurado para usar DATABASE_URL
- `config/environments/production.rb`: Optimizado para Render

## Troubleshooting

### Problemas comunes:

1. **Error de RAILS_MASTER_KEY**: Asegúrate de que la variable esté configurada correctamente
2. **Error de base de datos**: Verifica que DATABASE_URL esté configurada
3. **Assets no cargan**: Verifica que RAILS_SERVE_STATIC_FILES esté en true

### Logs

Para ver los logs:
```bash
# En el dashboard de Render, ve a tu servicio y haz clic en "Logs"
```

## Comandos útiles

### Ejecutar migraciones manualmente
```bash
# En el shell de Render
bundle exec rails db:migrate
```

### Abrir consola de Rails
```bash
# En el shell de Render
bundle exec rails console
```

## URLs importantes

- **Dashboard**: https://dashboard.render.com
- **Documentación**: https://render.com/docs
- **Tu aplicación**: https://[tu-app-name].onrender.com
