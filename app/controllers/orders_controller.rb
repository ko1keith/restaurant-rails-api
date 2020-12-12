class OrdersController < ApplicationController
  
  def show

  end

  def create
    restaurant = Restaurant.find_by(id: create_params[:restaurant_id])
    return render json: {error: "restaurant not found"}, status: 404 unless restaurant

    dishes = [] 
    create_params[:dishes].each do |dish_order|
      dish = Dish.find_by(id: dish_order[0].to_i)
      return render json: {error: "dish not found"}, status:404 unless dish
      dishes << dish
    end
    
    render json: {dishes: ActiveModel::Serializer::CollectionSerializer.new(dishes, each_serializer: DishSerializer)}
  end

  def update 

  end

  def archive 

  end

  private
  def create_params
    params.permit(:restaurant_id, :dishes => {})
  end
end