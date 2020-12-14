class RestaurantsController < ApplicationController
  # get /restaurants
  def index
    restaurants = Restaurant.all
    render json: restaurants
  end

  def create
    unless @account.is_admin
      render json: { error: 'You do not have permission to create a new restaurant' }, status: 403
    end
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
end
