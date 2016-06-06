class Admins::SessionsController < Devise::SessionsController
  # disable default no_authentication action
  skip_before_action :require_no_authentication, only: [:new, :create, :cancel]
end