class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  respond_to :html, :json

  # the layout should be specified by the resource (i.e. admin or user)
  layout :layout_by_resource

  protected

  # ensure name is allowed
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  # if we are using a devise controller then we can check the resource_name and return the appropriate layout
  def layout_by_resource
    puts "LayoutByResource: IS DEVISE CONTROLLER?: #{devise_controller?}"
    if devise_controller?
      puts "LayoutByResource - Resource name:#{resource_name}"
    end
    if devise_controller? && resource_name == :admin
      puts 'LayoutByResource is returning adminlayout'
      'adminlayout'
    elsif devise_controller? && resource_name == :account
      puts 'LayoutByResource is returning accountlayout'
      'accountlayout'
    elsif devise_controller? && resource_name == :user
      'userlayout'
    else
      puts 'LayoutByResource is returning application'
      'application'
    end
  end

  # Specify where to go after successful login again this is dictated by the resource that logged in
  def after_sign_in_path_for(resource)
    puts "AfterSignIn: IS DEVISE CONTROLLER?: #{devise_controller?}"
    puts "AfterSignIn - Resource: #{resource}"
    if devise_controller?
      puts "AfterSignIn - Resource name: #{resource_name}"
    end
    if devise_controller? && resource_name == :admin
      puts 'AfterSignIn is returning authenticated_admin_root_path'
      authenticated_admin_root_path
    elsif devise_controller? && resource_name == :account
      puts 'AfterSignIn is returning authenticated_account_root_path'
      authenticated_account_root_path
    elsif devise_controller? && resource_name == :user
      authenticated_user_root_path
    else
      puts 'AfterSignIn is returning root_path'
      root_path
    end
  end

  # Specify where to go after successful logout again this is dictated by the resource that logged in
  def after_sign_out_path_for(resource)
    puts "AfterSignOut: IS DEVISE CONTROLLER?: #{devise_controller?}"
    puts "AfterSignOut - Resource: #{resource}"
    if devise_controller?
      puts "AfterSignOut - Resource name: #{resource_name}"
    end
    if devise_controller? && resource_name == :admin
      puts 'AfterSignOut is returning new_admin_session_path'
      new_admin_session_path
    elsif devise_controller? && resource_name == :account
      puts 'AfterSignOut is returning new_account_session_path'
      new_account_session_path
    elsif devise_controller? && resource_name == :user
      new_user_session_path
    else
      puts 'AfterSignOut is returning application'
      'application'
    end
  end

end
