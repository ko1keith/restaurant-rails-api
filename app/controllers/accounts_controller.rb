class AccountsController < ApplicationController
  before_action :authorized, only: [:auto_login]

  # REGISTER
  def create 
    @account = Account.create(account_params)
    if @account.valid?
      token = encode_token({account_id: @account.id})
      render json: {account: @account, token:token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  def update
    @account = Account.find_by(email: update_params[:email])
    render json: {error: "Account with email #{update_params[:email]} not found"}, status: 404 unless @account
    if update_params[:email]
      @account.update(email: update_params[:email])
    end
    if update_params[:first_name]
      @account.update(first_name: update_params[:first_name])
    end
    if update_params[:last_name]
      @account.update(last_name: update_params[:last_name])
    end
    render json: {account: @account}
  end

  # Logging in
  def login 
    @account = Account.find_by(email: params[:email])
    if @account && @account.authenticate(params[:password])
      token = encode_token({account_id: @account.id})
      render json: {account: @account, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  def auto_login
    render json: @account
  end

  private 
  def account_params
    params.permit(:email, :password, :first_name, :last_name)
  end

  def update_params
    params.permit(:email, :first_name, :last_name)
  end
end
