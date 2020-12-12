class AddAuthTokenColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :auth_token, :text
  end
end
