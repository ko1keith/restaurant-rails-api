class RestaurantsController < ApplicationController
  # get /restaurants
  def index
    restaurants = Restaurant.all
    render json: restaurants
  end

  def create
    unless @account.role == 'admin'
      render json: { error: 'You do not have permission to create a new restaurant' }, status: 403
    end

    restaurant = Restaurant.find_by(name: create_params[:name], address: create_params[:address])
    return render json: { error: 'Restaurant already exists' }, status: 400 if restaurant

    restaurant = Restaurant.create(name: create_params[:name], address: create_params[:address])
    render json: { message: 'Restaurant created', restaurant: restaurant }
  end

  def show
    restaurant = Restaurant.find_by(id: show_params[:id])
    return render json: { error: "Restaurant with id #{show_params[:id]} not found" }, status: 404 unless restaurant

    render json: restaurant
  end

  private

  def show_params
    params.permit(:id)
  end

  def create_params
    params.permit(:name, :address)
  end
end
