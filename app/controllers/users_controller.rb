class UsersController < ApplicationController
  skip_before_filter :authenticate_request!, only: [:create, :create_by_provider]

  def create
    user = User.new(user_params)
    if user
      render json: {status: 'User created successfully', user: user}, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def create_by_provider
    user = User.find_for_oauth(env["omniauth.auth"], current_user)
    if user.persisted?
      render json: {status: 'User created successfully', user: user, auth_token: JsonWebToken.encode({user_id: user.id})}, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
