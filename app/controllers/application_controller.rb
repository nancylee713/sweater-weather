class ApplicationController < ActionController::API
  def user_exists?(user_params)
    User.where(email: user_params[:email]).present?
  end
end
