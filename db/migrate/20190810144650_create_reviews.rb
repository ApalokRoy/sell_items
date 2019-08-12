class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, index: true, foreign_key: {to_table: :users}
      t.references :post, null: false, index: true, foreign_key: true
      t.references :approved, foreign_key: {to_table: :users}
      t.string :heading, null: false
      t.string :content
      t.integer :rating, null: false

      t.timestamps
    end
  end
end