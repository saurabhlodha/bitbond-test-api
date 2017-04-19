class AccountsController < ApplicationController
  def index
    accounts = User.find(params[:email]).identities
    if accounts
      render json: {status: 'User accounts fetched', accounts: accounts.to_a}, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def provider
    accounts = User.find(params[:email]).identities.where(provider: params[:provider])
    if accounts
      render json: {status: 'Accounts fetched', accounts: accounts.to_a}, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def connections
    accounts = User.find(params[:email]).identities
    if accounts
      render json: {status: 'User accounts fetched', accounts: accounts.to_a}, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end
end
