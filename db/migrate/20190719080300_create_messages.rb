class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :message_body, null: false
      t.references :conversation, null: false, index: true, foreign_key: true
      t.references :user, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
