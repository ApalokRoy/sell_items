class CreateAssets < ActiveRecord::Migration[5.2]
  def change
    create_table :assets do |t|
      t.references :post, foreign_key: true
      t.attachment :image

      t.timestamps
    end
  end
end
