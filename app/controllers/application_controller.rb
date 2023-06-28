class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, alert: exception.message
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) || User.new
  end


  helper_method :current_user
end
