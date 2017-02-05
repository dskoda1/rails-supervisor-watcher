class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: :index
  
  def home
  end
  
  def index
    # Only logged in user can access this page
  end
end
