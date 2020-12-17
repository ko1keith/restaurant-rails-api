class OrderSerializer < ActiveModel::Serializer
  attributes :restaurant_id, :price, :created_at, :dish_ids, :is_archived, :account

  def dish_ids
    JSON.parse object.dish_ids
  end

  def account
    account = {
      email: object.account.email,
      first_name: object.account.first_name,
      last_name: object.account.last_name,
      account_id: object.account.id

    }
  end
end
