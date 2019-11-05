require 'securerandom'

class ApplicationController < ActionController::API
  def user_exists?(user_params)
    User.where(email: user_params[:email]).present?
  end

  def valid_key? key
    User.where(api_key: key).present?
  end

  def generate_api_key
    SecureRandom.hex(13)
  end
end
