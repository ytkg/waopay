class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string "name",            limit: 191, null: false
      t.string "username",        limit: 191, null: false
      t.string "password_digest", limit: 191, null: false
      t.string "remember_token",  limit: 191

      t.timestamps
    end
  end
end
