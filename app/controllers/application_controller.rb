class ApplicationController < ActionController::API
  include ::ActionController::Cookies

  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  def auth_header
    # {Authorization: 'Bearer <token>'}
    request.headers['Authorization']
  end

  def decode_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>'}
      begin
        JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decode_token
      account_id = decode_token[0]['account_id']
      @account = Account.find_by(id: account_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: 403 unless logged_in?
  end
end
