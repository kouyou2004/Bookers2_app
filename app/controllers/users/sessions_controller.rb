# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def create
    self.resource = User.find_by(name: params[:user][:name]) ||
                    User.find_by(email: params[:user][:email])
    if resource && resource.valid_password?(params[:user][:password])
      sign_in(resource_name, resource)
      flash[:notice] = 'Signed in successfully.'
      redirect_to after_sign_in_path_for(resource)
    else
      flash[:alert] = "Invalid name, email or password."
      render :new
    end
  end
end
