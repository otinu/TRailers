class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :visiter, null: false
      t.references :visited, null: false
      t.bigint :post_id, null: false
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false
      t.timestamps
    end
    add_foreign_key :notifications, :users, column: :visiter_id
    add_foreign_key :notifications, :users, column: :visited_id
    add_foreign_key :notifications, :posts
  end
end
