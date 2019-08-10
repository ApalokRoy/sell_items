class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 50
      t.string :email, null: false, limit: 100, index: {unique: true}
      t.string :password_digest, null: false
      t.boolean :admin, :default => false
      
      t.timestamps
    end
  end
end
