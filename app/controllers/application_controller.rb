require 'rest-client'
require 'json'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:home]
  
  def home
    # @parts = Part.paginate(:page => params[:page], :per_page => 50)
  end  
  
  def billing
    
  end
  
  def dashboard
    url = "https://api.monday.com:443/v1/boards.json?api_key=84ab557aeddbcbb389a4336ddc289bb7"
    api_token = "84ab557aeddbcbb389a4336ddc289bb7"
    board = "31511360"
    
    response = RestClient.get url
    @code = response.body
  end
  
  def app_settings
    
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
