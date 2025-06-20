#!/usr/bin/env ruby

puts "=== LIMPIEZA DE IMÁGENES FALTANTES ==="

# 1. Eliminar imágenes sin archivos adjuntos
orphaned_images = Image.left_joins(:file_attachment).where(active_storage_attachments: { id: nil })
orphaned_count = orphaned_images.count

puts "Eliminando #{orphaned_count} imágenes sin archivos adjuntos..."
orphaned_images.destroy_all

# 2. Eliminar blobs sin archivos físicos
missing_blobs = []
ActiveStorage::Blob.find_each do |blob|
  unless File.exist?(blob.service.path_for(blob.key))
    missing_blobs << blob
  end
end

puts "Eliminando #{missing_blobs.count} blobs sin archivos físicos..."
missing_blobs.each(&:destroy)

# 3. Verificar posts sin imágenes
posts_without_images = Post.left_joins(:images).where(images: { id: nil })
puts "Posts sin imágenes: #{posts_without_images.count}"

# 4. Crear imágenes placeholder para posts sin imágenes
if posts_without_images.any?
  puts "Creando imagen placeholder para posts sin imágenes..."
  
  # Crear un archivo placeholder simple
  placeholder_path = Rails.root.join('tmp', 'placeholder.png')
  unless File.exist?(placeholder_path)
    require 'mini_magick'
    begin
      # Crear imagen placeholder con MiniMagick si está disponible
      image = MiniMagick::Image.open("pattern:checkerboard")
      image.resize "400x400"
      image.format "png"
      image.write placeholder_path
      puts "✓ Imagen placeholder creada con MiniMagick"
    rescue LoadError, NameError
      # Si MiniMagick no está disponible, crear archivo básico
      require 'base64'
      # PNG básico de 1x1 pixel transparente en base64
      png_data = Base64.decode64("iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==")
      File.write(placeholder_path, png_data, mode: 'wb')
      puts "✓ Imagen placeholder básica creada"
    end
  end
  
  posts_without_images.each do |post|
    begin
      image = post.images.create!(position: 0)
      image.file.attach(
        io: File.open(placeholder_path),
        filename: 'placeholder.png',
        content_type: 'image/png'
      )
      puts "✓ Imagen placeholder adjuntada al post #{post.id}"
    rescue => e
      puts "✗ Error creando imagen para post #{post.id}: #{e.message}"
    end
  end
  
  # Limpiar archivo temporal
  File.delete(placeholder_path) if File.exist?(placeholder_path)
end

puts "\n=== ESTADO FINAL ==="
puts "Posts totales: #{Post.count}"
puts "Imágenes totales: #{Image.count}"
puts "Posts con imágenes: #{Post.joins(:images).distinct.count}"
puts "Imágenes con archivos: #{Image.joins(:file_attachment).count}"
puts "ActiveStorage Blobs: #{ActiveStorage::Blob.count}"
puts "ActiveStorage Attachments: #{ActiveStorage::Attachment.count}"

puts "\n✅ Limpieza completada"
