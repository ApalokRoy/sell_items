class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name, null: false
      t.references :category, null: false, index: true, foreign_key: true
      t.string :description, null: false
      t.references :user, null: false, index: true, foreign_key: { to_table: :users }
      t.string :phone_number, null: false, limit: 15
      t.string :city, null: false
      t.references :approved, foreign_key: { to_table: :users }
      
      t.timestamps
    end
  end
end
