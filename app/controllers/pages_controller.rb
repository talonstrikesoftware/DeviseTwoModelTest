class PagesController < ApplicationController
  before_action :authenticate_user!

  layout 'userlayout'
end
