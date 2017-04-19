class UsersController < ApplicationController
  skip_before_filter :authenticate_request!, only: [:create]

  def create
    user = User.new(user_params)
    if user
      render json: {status: 'User created successfully', user: user}, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
