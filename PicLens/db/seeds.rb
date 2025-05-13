# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Crear usuarios de ejemplo
puts "Creando usuarios..."
5.times do |i|
  User.create!(
    user_name: "usuario#{i + 1}",
    email: "usuario#{i + 1}@example.com",
    password: "password123",
    bio: "Este es el perfil del usuario #{i + 1}",
    photo_profile: "https://via.placeholder.com/150"
  )
end

# Crear hashtags de ejemplo
puts "Creando hashtags..."
hashtags = ["fotografia", "naturaleza", "viajes", "comida", "arte"]
hashtags.each do |tag|
  Hashtag.create!(tag: tag)
end

# Crear posts de ejemplo
puts "Creando posts..."
User.all.each do |user|
  3.times do
    post = Post.create!(
      user: user,
      caption: "Post de #{user.user_name} - Este es un post de ejemplo creado por #{user.user_name}",
      location: "Ciudad de México",
      image_count: 1
    )
    
    # Agregar imágenes a los posts
    Image.create!(
      post: post,
      image_url: "https://via.placeholder.com/800x600",
      position: 1
    )
    
    # Agregar hashtags a los posts
    post.hashtags << Hashtag.all.sample(2)
  end
end

# Crear comentarios de ejemplo
puts "Creando comentarios..."
Post.all.each do |post|
  3.times do
    Comment.create!(
      user: User.all.sample,
      post: post,
      text: "¡Excelente post! Me encanta la fotografía."
    )
  end
end

# Crear likes de ejemplo
puts "Creando likes..."
Post.all.each do |post|
  User.all.sample(3).each do |user|
    Like.create!(
      user: user,
      post: post
    )
  end
end

# Crear seguidores de ejemplo
puts "Creando seguidores..."
User.all.each do |user|
  User.all.sample(2).each do |follower|
    next if follower == user
    Follower.create!(
      follower_id: follower.id,
      followed_id: user.id
    )
  end
end

puts "¡Datos de ejemplo creados exitosamente!"
