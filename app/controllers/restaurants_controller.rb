class RestaurantsController < ApplicationController
  
  #get /restaurants
  def index 
    restaurants = Restaurant.all
    return render json: {restaurants: restaurants}
  end

  def create 
  end

  def show
  end
  

end