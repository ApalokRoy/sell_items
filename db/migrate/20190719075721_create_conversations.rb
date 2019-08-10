class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.references :sender, index: true, foreign_key: {to_table: :users}
      t.references :receiver, index: true, foreign_key: {to_table: :users}
      t.references :post, index: true, foreign_key: true
      t.index [:sender_id, :receiver_id, :post_id], unique: true

      t.timestamps
    end
  end
end
