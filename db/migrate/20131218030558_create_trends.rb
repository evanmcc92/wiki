class CreateTrends < ActiveRecord::Migration
  def change
    create_table :trends do |t|
      t.reference :user_id
      t.string :title
      t.reference :page_id

      t.timestamps
    end
  end
end
