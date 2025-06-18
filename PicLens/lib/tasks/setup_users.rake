namespace :users do
  desc "Setup initial users with different roles"
  task setup: :environment do
    # Create admin user
    admin = User.create!(
      email: 'admins@piclens.com',
      password: 'admin123',
      user_name: 'adminpro',
      bio: 'Administrador de PicLens',
      role: 'admin'
    )
    puts "Admin user created: #{admin.email}"

    # Create regular user
    user = User.create!(
      email: 'user@piclens.com',
      password: 'user123',
      user_name: 'usuario',
      bio: 'Usuario de PicLens',
      role: 'user'
    )
    puts "Regular user created: #{user.email}"
    
    # Create user for testing follow functionality
    user2 = User.create!(
      email: 'user2@piclens.com',
      password: 'user123',
      user_name: 'usuario2',
      bio: 'Otro usuario de PicLens',
      role: 'user'
    )
    puts "Second regular user created: #{user2.email}"
  end
end
