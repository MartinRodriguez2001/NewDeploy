# Project Assignment

## Members:
- Bastian Cepeda
- Lucas Fuentes
- Martin Rodriguez

## Commands to implement in case of errors

```bash
rails assets:clobber
rails assets:precompile

#For the image in the web-site
sudo apt update
sudo apt install redis-server
```

## Commands to implement for the create Admin User

 ```bash
 rails users:setup
 ```

## Test User Credentials

The following test accounts are available for login:

- **Admin Account**:
  - Email: admins@piclens.com
  - Password: admin123
  - Role: admin (full access to all features)

- **Regular User Accounts**:
  - Email: usuario1@example.com to usuario20@example.com
  - Password: password123
  - Role: user (standard user permissions)

## Roles and Permissions

The application has two main roles with different permission levels:

### Admin Role
- Can manage all resources in the application
- Can create, read, update, and delete any post
- Can ban users
- Has full access to all features

### User Role
- Can read all public content
- Can discover other users
- Can create posts and manage their own posts (edit/delete)
- Can create comments and manage their own comments
- Can like/unlike posts
- Can update their own profile
- Can follow/unfollow other users
- Cannot modify content created by other users
- Cannot access admin features