namespace :users do
  desc "Setup initial users with different roles"
  task setup: :environment do
    # Create admin user
    admin = User.create!(
      email: 'admin@piclens.com',
      password: 'admin123',
      user_name: 'admin',
      bio: 'Administrador de PicLens',
      role: 'admin'
    )
    puts "Admin user created: #{admin.email}"

    # Create moderator user
    moderator = User.create!(
      email: 'moderator@piclens.com',
      password: 'mod123',
      user_name: 'moderator',
      bio: 'Moderador de PicLens',
      role: 'moderator'
    )
    puts "Moderator user created: #{moderator.email}"

    # Create regular user
    user = User.create!(
      email: 'user@piclens.com',
      password: 'user123',
      user_name: 'usuario',
      bio: 'Usuario de PicLens',
      role: 'user'
    )
    puts "Regular user created: #{user.email}"
  end
end
