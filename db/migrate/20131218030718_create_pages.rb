class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :user_id
      t.integer :trend_id
      t.string :title
      t.string :summary
      t.string :body

      t.timestamps
    end
  end
end
