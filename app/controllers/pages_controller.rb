class PagesController < ApplicationController
  before_action :authenticate_user!
  def home
    @title = "Home"
  end
end
S