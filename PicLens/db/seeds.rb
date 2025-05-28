# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Creando usuarios..."
avatares = [
  "https://api.dicebear.com/6.x/fun-emoji/svg?seed=Aneka&backgroundColor=b6e3f4",
  "https://api.dicebear.com/6.x/fun-emoji/svg?seed=Felix&backgroundColor=d1d4f9",
  "https://api.dicebear.com/6.x/micah/svg?seed=Coco&backgroundColor=b6e3f4",
  "https://api.dicebear.com/6.x/micah/svg?seed=Daisy&backgroundColor=d1d4f9",
  "https://api.dicebear.com/6.x/thumbs/svg?seed=Mia&backgroundColor=ffd5dc",
  "https://api.dicebear.com/6.x/thumbs/svg?seed=Max&backgroundColor=c0aede",
  "https://api.dicebear.com/6.x/avataaars/svg?seed=Zoe&backgroundColor=ffdfbf",
  "https://api.dicebear.com/6.x/avataaars/svg?seed=Leo&backgroundColor=d1d4f9",
  "https://api.dicebear.com/6.x/human/svg?seed=Coco&backgroundColor=b6e3f4",
  "https://api.dicebear.com/6.x/human/svg?seed=Daisy&backgroundColor=d1d4f9"
]

20.times do |i|
  User.find_or_create_by!(email: "usuario#{i + 1}@example.com") do |user|
    user.user_name = "usuario#{i + 1}"
    user.password = "password123"
    user.bio = "Este es el perfil del usuario #{i + 1}. Explorando el mundo a través de imágenes."
    user.photo_profile = avatares.sample
  end
end

puts "Creando hashtags..."
hashtags_list = ["fotografia", "naturaleza", "viajes", "comida", "arte", "musica", "deporte", "tecnologia", "moda", "animales", "arquitectura", "design", "programacion", "ciencia", "historia", "libros", "peliculas", "familia", "amigos", "eventos", "random", "diaadia", "felicidad", "inspiracion"]
hashtags_list.each do |tag|
  Hashtag.find_or_create_by!(tag: tag)
end

imagenes = [
  "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1519985176271-adb1088fa94c?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1547032177-d69d2da22111?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1550101684-c2f81d491f27?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1505142468116-dfb9f49d546f?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1508921912186-1d1a45db9304?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1546527868-ccb7ee49680f?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1501854140803-b9fd1d1c9dc4?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-147592415673-49823b02f967?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1472214103451-9374fe4e084b?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1477322524746-ce0795e1c819?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1511576661531-b56961e35fba?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-14974360729c14-ab9b088a7cd9?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1520532527386-bb493ae1cb8b?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1522093007463-858716e1b55b?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1523459710952-69f2ba6e2090?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1501446020269-ec11e6ca81a5?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1503431128876-7cd934e3375c?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1500629150713-1ce07f2f0b45?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1506929562872-bb421503ef21?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1500964757632-ebba4cd7ef0a?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1507525428034-b723cf961bbe?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1510784718532-b631c1e013b5?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1547032177-d69d2da22111?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1550101684-c2f81d491f27?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1505142468116-dfb9f49d546f?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1508921912186-1d1a45db9304?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1546527868-ccb7ee49680f?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1501854140803-b9fd1d1c9dc4?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-147592415673-49823b02f967?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1472214103451-9374fe4e084b?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1477322524746-ce0795e1c819?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-1511576661531-b56961e35fba?auto=format&fit=crop&w=800&q=80",
  "https://images.unsplash.com/photo-14974360729c14-ab9b088a7cd9?auto=format&fit=crop&w=800&q=80",
  "https://www.infobae.com/resizer/v2/QCDBOMT3VNFGHBRPNUIP3VGSCQ.jpeg?auth=2e218b48ff434906195fe9b53123130eab7665faac4fc0817497512f752134ca&smart=true&width=1200&height=675&quality=85",
  "https://www.uandes.cl/wp-content/uploads/2023/06/Logo_Uandes.",
  "https://media.istockphoto.com/id/913781186/es/foto/horizonte-de-santiago-de-chile.jpg?s=612x612&w=0&k=20&c=cDQAUxUDAxKajXtcyGrRHQwe_YXWGBCjF2ZCHQFRb1E=",
  "https://storage.googleapis.com/chile-travel-cdn/2022/03/56b19812-paisaje-torres-del-paine.jpeg",
  "https://d2kkzshb6n9g86.cloudfront.net/wp-content/uploads/2023/11/ciencia-conocimiento-Geografia-en-Chile.jpeg",
  "https://billiken.lat/wp-content/uploads/2023/09/image-42.png",
  "https://media-front.elmostrador.cl/2018/06/imgen-de-chile.jpg",
  "https://www.encancha.cl/resizer/v2/KTMLEL5XVBGABK6ROSV7WVGTAQ.png?auth=9174a8dfc37f313ef9ac9fa2827535c12e6ecd57a1976a820cd79c29fde18f32&focal=620%2C452&width=950&height=633&quality=70",
  "https://d2kkzshb6n9g86.cloudfront.net/wp-content/uploads/2023/10/Good-News-Septiembre-Santiago.jpg"
]

captions = [
  "Explorando nuevos horizontes. Cada foto cuenta una historia.",
  "Momentos capturados que atesoro para siempre.",
  "La belleza está en todas partes, solo hay que saber mirar.",
  "Compartiendo un pedacito de mi mundo con ustedes.",
  "Una imagen que habla más que mil palabras.",
  "Mi pasión por la fotografía en cada clic.",
  "Perdido en la naturaleza, encontrando mi paz.",
  "Saboreando cada instante y capturándolo.",
  "El arte de ver lo extraordinario en lo ordinario.",
  "Creando recuerdos frame a frame.",
  "Luz, color y composición: la tríada perfecta.",
  "Inspirado por el mundo que me rodea.",
  "Siempre buscando la próxima aventura visual.",
  "Detalles que enamoran.",
  "Vibras positivas y buena luz.",
  "Un paseo por mis archivos fotográficos.",
  "Desde mi lente hasta sus ojos.",
  "Reflejando emociones a través de imágenes.",
  "Pequeñas pausas visuales en mi día.",
  "Simplemente disfrutando del proceso."
]

comments = [
  "¡Excelente post! Me encanta la fotografía.",
  "Impresionante, qué buena toma.",
  "Me transmite mucha paz, ¡gracias por compartir!",
  "Wow, ¿dónde es esto? ¡Qué ganas de visitar!Nombre de usuario",
  "Qué belleza de colores, muy bien capturado.",
  "Siempre sorprendiendo con tus fotos.",
  "Me gusta mucho el ángulo y la perspectiva.",
  "Tienes un talento increíble.",
  "Inspira mucho a salir a explorar.",
  "Gracias por la dosis diaria de belleza."
]

puts "Creando posts..."
User.all.each do |user|
  10.times do
    post = Post.find_or_create_by!(user: user, caption: captions.sample) do |p|
      p.location = "Ciudad #{['México', 'Bogotá', 'Lima', 'Buenos Aires', 'Santiago', 'Madrid', 'Barcelona'].sample}"
      p.image_count = 1
    end

    # Siempre asignar una imagen, aunque ya tenga una
    if post.images.empty?
      Image.create!(post: post, image_url: imagenes.sample, position: 1)
    else
      post.images.first.update(image_url: imagenes.sample)
    end

    Hashtag.all.sample(rand(1..4)).each do |hashtag|
      post.hashtags << hashtag unless post.hashtags.include?(hashtag)
    end
  end
end

puts "Creando comentarios..."
Post.all.each do |post|
  User.all.sample(rand(3..10)).each do |user|
    Comment.find_or_create_by!(user: user, post: post, text: comments.sample)
  end
end

puts "Creando likes..."
Post.all.each do |post|
  User.all.sample(rand(5..20)).each do |user|
    Like.find_or_create_by!(user: user, post: post)
  end
end

puts "Creando seguidores..."
User.all.each do |user|
  User.all.sample(rand(5..15)).each do |follower|
    next if follower == user
    Follower.find_or_create_by!(follower_id: follower.id, followed_id: user.id)
  end
end

puts "¡Datos de ejemplo creados exitosamente!"