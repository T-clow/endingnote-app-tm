class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :phone_number, :full_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :phone_number, :full_name, :username, :password, :password_confirmation, :current_password, :avatar])
  end
end
