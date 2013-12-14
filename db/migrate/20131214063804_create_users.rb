class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :remember_token
      t.boolean :admin

      t.timestamps
    end
    add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  end
end
