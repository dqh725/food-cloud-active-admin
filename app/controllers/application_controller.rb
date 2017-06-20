class ApplicationController < ActionController::Base
  class ForbiddenError < RuntimeError; end
  rescue_from ApplicationController::ForbiddenError do
    render nothing: true, status: :forbidden
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_ability
    @current_ability ||= ::Ability.new(current_user || current_customer)
  end

  def access_denied(exception)
    redirect_to admin_welcome_path, alert: exception.message
  end

  # def switch
  #   new_user = User.find_by_id(params[:id])
  #   if current_user && new_user && current_user.email == new_user.email
  #     sign_out(current_user) && sign_in(new_user)
  #   end
  #   redirect_to :back
  # end

  def home
    render '/home'
  end
end
