class OrdersController < ApplicationController
  
  def show

  end

  def create
    
    render json: {message: params[:dishes]}
  end

  def update 

  end

  def archive 

  end

  private
  def create_params
    params.permit(:dishes)
  end
end