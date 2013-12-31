class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  def authorize_teacher!
    if user_signed_in? && current_user.is_teacher
      return
    elsif user_signed_in?
      flash[:notice] = 'You must be an authorized Teacher to do that!'
      # redirect_to :root
      redirect_to :back
    else
      flash[:notice] = 'You need to sign in first!'
      redirect_to new_user_session_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :is_teacher
    devise_parameter_sanitizer.for(:account_update) << :is_teacher
  end
end
