class OrdersController < ApplicationController
  def index
    # check if account is owner of restaurant
    unless @account.restaurant.id == index_params[:restaurant_id].to_i
      return render json: { error: 'Must be the owner of the restaurant to see the restaurants orders' }, status: 403
    end

    # get orders
    orders = Order.where(restaurant_id: index_params[:restaurant_id], is_archived: false)
    render json: { orders: ActiveModel::Serializer::CollectionSerializer.new(orders, each_serializer: OrderSerializer) }
  end

  def show; end

  def create
    restaurant = Restaurant.find_by(id: create_params[:restaurant_id])
    return render json: { error: 'restaurant not found' }, status: 404 unless restaurant

    return render json: { error: 'No dishes given' } if create_params[:dishes].nil?

    dishes = Dish.where(id: create_params[:dishes].keys.map(&:to_i))
    unless dishes.count == create_params[:dishes].keys.count
      return render json: { error: 'dish(es) not found' }, status: 404
    end

    render json: { dishes: ActiveModel::Serializer::CollectionSerializer.new(dishes, each_serializer: DishSerializer) }
  end

  def update; end

  def archive; end

  private

  def create_params
    params.permit(:restaurant_id, dishes: {})
  end

  def index_params
    params.permit(:restaurant_id)
  end
end
