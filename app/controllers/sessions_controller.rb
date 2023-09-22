class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      handle_successful_login(user)
    else
      handle_failed_login
    end
  end

  def destroy
    handle_logout
  end

  private

  def handle_successful_login(user)
    session[:user_id] = user.id
    if request.xhr?  # Check if the request is an XMLHttpRequest (API request)
      render json: user, status: :ok
    else
      redirect_to root_path, notice: 'Logged in successfully.'
    end
  end

  def handle_failed_login
    if request.xhr?  # Check if the request is an XMLHttpRequest (API request)
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    else
      flash.now.alert = 'Invalid email or password.'
      render 'new'
    end
  end

  def handle_logout
    session[:user_id] = nil
    if request.xhr?  # Check if the request is an XMLHttpRequest (API request)
      head :no_content
    else
      redirect_to root_path, notice: 'Logged out successfully.'
    end
  end
end
