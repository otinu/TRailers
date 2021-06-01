class CreateGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :goods do |t|
      t.integer :post_id
      t.integer :user_id
      t.boolean :mine_open
      t.boolean :others_open

      t.timestamps
    end
  end
end
