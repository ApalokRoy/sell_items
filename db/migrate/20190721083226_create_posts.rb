class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name
      t.references :category, index: true, foreign_key: true
      t.string :description
      t.references :user, index: true, foreign_key: {to_table: :users}
      t.string :phone_number
      t.string :city
      t.references :approved, foreign_key: {to_table: :users}
      
      t.timestamps
    end
  end
end
