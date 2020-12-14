class RestaurantSerializer < ActiveModel::Serializer
  attributes :name, :address, :dishes

  def dishes
    object.dishes.map do |dish|
      {
        name: dish.name,
        restaurant_id: dish.restaurant_id,
        price: dish.price
      }
    end
  end
end
