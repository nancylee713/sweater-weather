class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      render json: {
        "api_key": "jgn983hy48thw9begh98h4539h4",
        status: 200
      }, status: 200

    elsif user_exists?(user_params)
      render json: {
        error: 'Incorrect password. Please try again.',
        status: 400
        }, status: 400

    else
      render json: {
        error:'Email not found in the system. Please register first.',
        status: 400
        }, status: 400
    end
  end

  private
  def user_params
    params.permit(:email, :password)
  end
end
