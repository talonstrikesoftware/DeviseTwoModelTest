Rails.application.routes.draw do
#  devise_for :admins
  devise_for :admins, module: 'admins', controllers: {sessions: 'admins/sessions', registrations:'admins/registrations'}

#  devise_for :users
  devise_for :users, module: 'users', controllers: {sessions: 'users/sessions', registrations:'users/registrations'}

  # These are the protected routes.
  # The pages controller is for the user model and the
  # admin_pages is for the admin model
  get '/secret', to: 'pages#secret', as: :secret
  get '/adminsecret', to: 'admin_pages#secret', as: :adminsecret
  get '/adminhome', to: 'admin_pages#index'

  # Define the root for when a user is authenticated
  authenticated :user do
    root 'pages#index', as: :authenticated_user_root
  end

  # Define the root for when an admin is authenticated
  authenticated :admin do
    root 'admin_pages#index', as: :authenticated_admin_root
  end

  # default root (should never use this)
  root to: 'pages#index'
end
