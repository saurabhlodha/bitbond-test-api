class AccountsController < ApplicationController

  def index
    accounts = User.find(params[:email]).identities
    if accounts
      render json: {status: 'User accounts fetched', accounts: accounts.to_a}, status: :created
    else
      render json: { errors: 'Something went wrong' }, status: :bad_request
    end
  end

  def provider
    @facebook, @twitter = nil
    @account = User.find(params[:email]).identities.where(provider: params[:provider]).first
    if @account && params[:provider].eql?('facebook')
      get_facebook_connection
    elsif @account && params[:provider].eql?('twitter')
      get_twitter_connection
    end
    if @account && ( @facebook || @twitter )
      render json: { email: current_user.email, provider: params[:provider].to_s, connections: instance_variable_get("@#{params[:provider]}") }, status: :ok
    else
      render json: { errors: 'Something went wrong or social media not linked' }, status: :bad_request
    end
  end

  def connections
    accounts = User.find(params[:email]).identities
    total = 0
    accounts.each do |account|
      @account = account
      con = send("get_#{account.provider}_connection")
      total += con.to_a.length
      instance_variable_set("@#{account.provider}", con.to_a.length)
    end
    if accounts
      render json: {total: total, facebook: @facebook, twitter: @twitter}, status: :ok
    else
      render json: { errors: 'Something went wrong' }, status: :bad_request
    end
  end

  private

  def get_facebook_connection
      fb = Koala::Facebook::API.new(@account.access_token)
      @facebook = fb.get_connections("me", "friends", api_version: 'v2.0')
  end

  def get_twitter_connection
      tw = Twitter::REST::Client.new do |data|
          data.consumer_key        = ENV['TWITTER_KEY']
          data.consumer_secret     = ENV['TWITTER_SECRET']
          data.access_token        = @account.access_token
          data.access_token_secret = @account.secret
      end
      @twitter = tw.followers.to_hash[:users]
  end

end

