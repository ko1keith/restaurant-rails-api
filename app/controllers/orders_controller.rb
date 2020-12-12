class OrdersController < ApplicationController
  
  def show

  end

  def create
    restaurant = Restaurant.find_by(id: create_params[:restaurant_id])
    return render json: {error: "restaurant not found"}, status: 404 unless restaurant

    dishes = Dish.where(id: create_params[:dishes].keys.map{|key| key.to_i})
    return render json: {error: "dish(es) not found"}, status:404 unless dishes.count == create_params[:dishes].keys.count

    
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