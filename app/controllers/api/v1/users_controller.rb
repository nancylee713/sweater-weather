class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    if user.save
      render json: UserSerializer.new(User.all)
    else
      rescue_from ActionController::ParameterMissing do
        render :nothing => true, :status => :bad_request
      end
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
