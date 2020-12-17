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

    return render json: { error: 'No dishes given' } unless create_params[:dishes]

    order = Order.with_discarded.where(restaurant_id: create_params[:restaurant_id], account_id: @account.id).undiscarded
    return render json: { error: 'You already have a pending order with this restaurant' }, status: 400 if order

    dishes = Dish.where(id: create_params[:dishes].keys.map(&:to_i))
    unless dishes.count == create_params[:dishes].keys.count
      return render json: { error: 'dish(es) not found' }, status: 404
    end

    order = Order.create(
      restaurant_id: create_params[:restaurant_id],
      dish_ids: create_params[:dishes].to_json,
      account_id: @account.id
    )

    render json: order
  end

  def update; end

  def archive
    order = Order.with_discarded.where(restaurant_id: archive_params[:restaurant_id], account_id: @account.id).undiscarded
    return render json: { error: 'order not found' }, status: 404 unless order

    if order.count > 1
      render json: { error: "More than one order with restaurant_id #{archive_params[:restaurant_id]} found" }
    end

    # order is not nil, and is less then 1, should be safe to discard?
    order&.discard
  end

  private

  def create_params
    params.permit(:restaurant_id, dishes: {})
  end

  def index_params
    params.permit(:restaurant_id)
  end

  def archive_params
    params.permit(:restaurant_id)
  end
end
