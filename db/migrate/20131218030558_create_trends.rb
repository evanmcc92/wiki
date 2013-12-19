class CreateTrends < ActiveRecord::Migration
  def change
    create_table :trends do |t|
      t.integer :user_id
      t.string :title

      t.timestamps
    end
  end
end
