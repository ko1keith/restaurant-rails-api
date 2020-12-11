class DishSerializer < ActiveModel::Serializer
  attributes :name, :restaurant_id, :price
end
