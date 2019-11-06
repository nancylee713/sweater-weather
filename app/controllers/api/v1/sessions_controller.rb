class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(email: user_params[:email])

    if registered_user
      render_200

    elsif incorrect_password
      render_400_bad_credentials

    else
      render_400_unregistered
    end
  end

  private
  def user_params
    params.permit(:email, :password)
  end

  def registered_user
    @user && @user.authenticate(user_params[:password])
  end

  def incorrect_password
    user_exists?(user_params)
  end

  def render_200
    render json: {
      "api_key": @user.api_key,
      status: 200
    }, status: 200
  end

  def render_400_bad_credentials
    render json: {
      error: 'Incorrect password. Please try again.',
      status: 400
      }, status: 400
  end

  def render_400_unregistered
    render json: {
      error:'Email not found in the system. Please register first.',
      status: 400
      }, status: 400
  end
end
