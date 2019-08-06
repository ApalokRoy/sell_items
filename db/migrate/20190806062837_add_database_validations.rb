class AddDatabaseValidations < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :name, false
    change_column :users, :name, :string, limit: 50
    change_column_null :users, :email, false
    change_column :users, :email, :string, limit: 100
    change_column_null :users, :password_digest, false
    change_column_null :posts, :name, false
    change_column_null :posts, :description, false
    change_column_null :posts, :phone_number, false
    change_column :posts, :phone_number, :string, limit: 15
    change_column_null :posts, :user_id, false
    change_column_null :posts, :category_id, false
    change_column_null :posts, :city, false
    change_column_null :messages, :message_body, false
    change_column_null :messages, :conversation_id, false
    change_column_null :messages, :user_id, false
    add_index :conversations, [:sender_id, :receiver_id], unique: true
    change_column_null :categories, :name, false
    change_column :categories, :name, :string, limit: 50
    change_column_null :assets, :post_id, false
  end
end
