class CreateSnsCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :sns_credentials do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.bigint :user_id, null: false
      t.timestamps
    end
    add_foreign_key :sns_credentials, :users
  end
end
