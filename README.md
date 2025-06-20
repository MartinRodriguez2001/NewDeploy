# PicLens - Social Media Application

Una aplicación de redes sociales construida con Ruby on Rails que permite a los usuarios compartir imágenes, interactuar y comunicarse.

## 🚀 Deployment en Render

Este proyecto está configurado para deployment automático en Render.

### Variables de Entorno Requeridas:
- `RAILS_MASTER_KEY`: `08fd5000cdf12de4b0a438cffd648cea`
- `DATABASE_URL`: Conectar desde base de datos PostgreSQL
- `RAILS_ENV`: `production`
- `BUNDLE_WITHOUT`: `development:test`
- `RAILS_SERVE_STATIC_FILES`: `true`

### Archivos de Configuración:
- `bin/render-build.sh`: Script de build para Render
- `render.yaml`: Configuración Infrastructure as Code
- `DEPLOYMENT.md`: Guía completa de deployment
- `POSTGRES_SETUP.md`: Guía específica de PostgreSQL

## 🛠️ Desarrollo Local

### Prerrequisitos:
- Ruby 3.4.4+
- PostgreSQL
- Node.js
- Yarn

### Setup:
```bash
bundle install
yarn install
rails db:create db:migrate db:seed
rails server
```

## 📁 Estructura del Proyecto

```
├── app/                    # Código de la aplicación
├── bin/                    # Scripts ejecutables
├── config/                 # Configuración
├── db/                     # Base de datos y migraciones
├── public/                 # Archivos estáticos
├── render.yaml            # Configuración para Render
├── DEPLOYMENT.md          # Guía de deployment
└── POSTGRES_SETUP.md      # Guía de PostgreSQL
```
