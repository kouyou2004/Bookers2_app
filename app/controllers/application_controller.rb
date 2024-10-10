class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user

  def after_sign_in_path_for(resource)
    user_path(resource) 
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def set_current_user
    @user = current_user if user_signed_in?
  end
  
  def set_flash_message
    flash[:notice] = 'Signed in successfully.'
  end
  
end
