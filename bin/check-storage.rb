#!/usr/bin/env ruby

# Quick database check script
puts "=== ESTADO DE LA BASE DE DATOS ==="
puts "Posts totales: #{Post.count}"
puts "Usuarios totales: #{User.count}"
puts "Followers totales: #{Follower.count}"
puts "Notificaciones totales: #{Notification.count}"

puts "\n=== ESTADO DE ACTIVESTORAGE ==="
puts "Active Storage Blobs: #{ActiveStorage::Blob.count}"
puts "Active Storage Attachments: #{ActiveStorage::Attachment.count}"

puts "\n=== POSTS CON IMÁGENES ==="
posts_with_images = Post.joins(:images_attachments).distinct.count
posts_without_images = Post.count - posts_with_images
puts "Posts con imágenes: #{posts_with_images}"
puts "Posts sin imágenes: #{posts_without_images}"

puts "\n=== ARCHIVOS FÍSICOS EN STORAGE ==="
storage_path = Rails.root.join('storage')
if Dir.exist?(storage_path)
  file_count = Dir.glob(File.join(storage_path, '**', '*')).count { |f| File.file?(f) }
  puts "Archivos en storage/: #{file_count}"
else
  puts "Directorio storage/ no existe"
end

puts "\n=== BLOBS SIN ARCHIVOS FÍSICOS ==="
missing_files = 0
ActiveStorage::Blob.find_each do |blob|
  unless File.exist?(blob.service.path_for(blob.key))
    missing_files += 1
    puts "Blob faltante: #{blob.filename} (key: #{blob.key})"
  end
end
puts "Total de archivos faltantes: #{missing_files}"
