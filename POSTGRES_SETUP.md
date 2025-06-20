# Configuración de PostgreSQL en Render para PicLens

## 1. Crear la Base de Datos PostgreSQL

### Opción A: Desde el Dashboard de Render

1. **Ir al Dashboard**: https://dashboard.render.com
2. **Crear nueva base de datos**:
   - Clic en "New +"
   - Seleccionar "PostgreSQL"
   
3. **Configurar la base de datos**:
   - **Name**: `piclens-db` (o el nombre que prefieras)
   - **Database**: `piclens_production`
   - **User**: `piclens_user`
   - **Region**: Selecciona la misma región donde deployarás tu app
   - **PostgreSQL Version**: 15 (recomendado)
   - **Plan**: Free (o el que necesites)

4. **Crear**: Clic en "Create Database"

### Opción B: Usando render.yaml (Infrastructure as Code)

El archivo `render.yaml` ya está configurado con:

```yaml
databases:
  - name: piclens-db
    plan: free
```

## 2. Obtener la URL de Conexión

Una vez creada la base de datos:

1. **Ve a tu base de datos** en el dashboard
2. **Copia la información de conexión**:
   - **Internal Database URL**: Para conectar desde tu app en Render
   - **External Database URL**: Para conectar desde fuera de Render

La URL tendrá este formato:
```
postgres://username:password@hostname:port/database_name
```

## 3. Configurar Variables de Entorno en tu Web Service

### Variables Principales:
```bash
DATABASE_URL=postgres://user:pass@hostname:5432/dbname
RAILS_MASTER_KEY=08fd5000cdf12de4b0a438cffd648cea
RAILS_ENV=production
BUNDLE_WITHOUT=development:test
RAILS_SERVE_STATIC_FILES=true
RAILS_LOG_TO_STDOUT=true
WEB_CONCURRENCY=2
RAILS_MAX_THREADS=5
```

### Variables para Múltiples Bases de Datos (Rails 8):
Si tu app usa múltiples bases de datos (cache, queue, cable):

```bash
# Base de datos principal
DATABASE_URL=postgres://user:pass@hostname:5432/dbname

# Opcional: URLs específicas para cada base
CACHE_DATABASE_URL=postgres://user:pass@hostname:5432/dbname_cache
QUEUE_DATABASE_URL=postgres://user:pass@hostname:5432/dbname_queue
CABLE_DATABASE_URL=postgres://user:pass@hostname:5432/dbname_cable
```

## 4. Crear el Web Service

1. **Crear nuevo servicio**:
   - Clic en "New +"
   - Seleccionar "Web Service"
   - Conectar tu repositorio GitHub

2. **Configurar el servicio**:
   - **Name**: `piclens`
   - **Environment**: Ruby
   - **Build Command**: `./bin/render-build.sh`
   - **Start Command**: `bundle exec puma -C config/puma.rb`
   - **Plan**: Free (o el que necesites)

3. **Variables de entorno**:
   - Agregar todas las variables listadas arriba
   - Para `DATABASE_URL`: seleccionar "From Database" y elegir tu base de datos

## 5. Verificar la Conexión

Después del deployment, puedes verificar la conexión:

### Desde Render Shell:
```bash
# Acceder al shell de tu servicio
bundle exec rails console

# Verificar conexión
ActiveRecord::Base.connection.execute("SELECT version()")
```

### Desde logs:
```bash
# Ver logs de la aplicación
# En dashboard > tu servicio > Logs
```

## 6. Comandos Útiles

### Ejecutar migraciones manualmente:
```bash
bundle exec rails db:migrate
```

### Verificar estado de la base de datos:
```bash
bundle exec rails db:version
```

### Acceder a la consola de Rails:
```bash
bundle exec rails console
```

### Ejecutar seeds:
```bash
bundle exec rails db:seed
```

## 7. Troubleshooting

### Error: "database does not exist"
```bash
bundle exec rails db:create
```

### Error: "PG::ConnectionBad"
- Verificar que DATABASE_URL esté configurada correctamente
- Verificar que la base de datos esté en la misma región que el web service

### Error de migraciones:
```bash
bundle exec rails db:migrate:status
bundle exec rails db:migrate
```

### Resetear base de datos (¡CUIDADO! Borra todos los datos):
```bash
bundle exec rails db:drop db:create db:migrate
```

## 8. Monitoreo

### Ver métricas de la base de datos:
- Dashboard > Tu base de datos > Metrics
- Conexiones activas
- Uso de CPU y memoria
- Espacio en disco

### Logs de la base de datos:
- Dashboard > Tu base de datos > Logs

## 9. Backup y Restauración

### Backup automático:
Render hace backups automáticos de bases de datos de pago.

### Backup manual:
```bash
pg_dump $DATABASE_URL > backup.sql
```

### Restaurar:
```bash
psql $DATABASE_URL < backup.sql
```

## 10. Escalabilidad

### Upgrade de plan:
- Dashboard > Tu base de datos > Settings > Change Plan

### Conexiones concurrentes:
- Plan Free: 97 conexiones
- Plan Starter: 197 conexiones
- Planes superiores: más conexiones

---

## ⚠️ Notas Importantes:

1. **Plan Free**: Limitaciones de 90 días de inactividad
2. **Backups**: Solo disponibles en planes de pago
3. **SSL**: Siempre habilitado en Render
4. **Ubicación**: Mantén la DB y el servicio en la misma región para menor latencia

¡Tu base de datos PostgreSQL estará lista para usar con tu aplicación PicLens!
