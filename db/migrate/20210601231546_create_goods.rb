class CreateGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :goods do |t|
      t.integer :post_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
    add_foreign_key :goods, :posts
    add_foreign_key :goods, :users
  end
end
