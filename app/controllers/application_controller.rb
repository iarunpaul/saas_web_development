class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # Whitelist the following form fields so that we can process them
  # if coming from a Devise sign up form
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:plan, :stripe_card_token, :email, :password, :password_confirmation, :card_code,
    :card_month, :card_number) }
     devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password) }
  end
end
