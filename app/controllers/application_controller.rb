class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def logged_in_user
    unless user_signed_in?
      flash[:danger] = "Please log in."
      redirect_to new_user_session_path
    end
  end
end
