class ApplicationController < ActionController::Base
  before_action :authenticate_user

  private

  def authenticate_user
    if request.format.json? # Check if the request format is JSON (API request)
      authenticate_api_user
    else
      authenticate_web_user
    end
  end

  def authenticate_api_user
    unless current_user
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end

  def authenticate_web_user
    unless logged_in?
      redirect_to login_path, alert: 'You must be logged in to access this page.'
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user, :logged_in?
end
