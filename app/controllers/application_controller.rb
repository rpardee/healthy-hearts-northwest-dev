class ApplicationController < ActionController::Base
	include Pundit
  before_filter :configure_permitted_parameters, if: :devise_controller?

	helper_method :current_user
	def current_user
		current_partner
	end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def after_sign_in_path_for(resource)
    partner_path(current_partner)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u|
      u.permit(:password, :password_confirmation, :current_password)
    }
  end

end
