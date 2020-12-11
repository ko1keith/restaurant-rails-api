class RestaurantsController < ApplicationController
  
  #get /restaurants
  def index 
    restaurants = Restaurant.all
    first = restaurants.first
    return render json: restaurants
  end

  def create 
  end

  def show
  end
  

end