class ApplicationController < ActionController::API
  def user_exists?(user_params)
    User.where(email: user_params[:email]).present?
  end

  def valid_key? key
    key == 'jgn983hy48thw9begh98h4539h4'
  end
end
