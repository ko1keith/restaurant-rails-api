class OrderSerializer < ActiveModel::Serializer
  attributes :restaurant_id, :price, :updated_at, :dish_ids, :is_archived

  def dish_ids
    object.dish_ids.map do |dish|
      JSON.parse dish
    end
  end
end
