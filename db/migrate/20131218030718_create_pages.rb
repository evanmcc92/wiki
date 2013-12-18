class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.reference :user_id
      t.referene :trend_id
      t.string :title
      t.string :summary
      t.string :body

      t.timestamps
    end
  end
end
