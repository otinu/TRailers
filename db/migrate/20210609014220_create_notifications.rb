class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :visiter, foreign_key: true, null: false
      t.references :visited, foreign_key: true, null: false, comment: "「visiteds」では表記がおかしいため、references型で生成"
      t.integer :post_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false
      t.timestamps
    end
    add_foreign_key :notifications, :posts
  end
end
