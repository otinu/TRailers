class CreateGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :goods do |t|
      t.integer :post_id, null: false
      t.integer :user_id, null: false
      t.boolean :mine_open, default: true, null: false
      t.boolean :others_open, default: true, null: false

      t.timestamps
    end
  end
end
