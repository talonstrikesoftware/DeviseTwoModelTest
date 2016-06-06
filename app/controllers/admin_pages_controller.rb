class AdminPagesController < ApplicationController
  before_action :authenticate_admin!
  layout 'adminlayout'

  def index
  end
end