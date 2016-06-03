class CreateTvs < ActiveRecord::Migration
  def change
    create_table :tvs do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.string :introduction
      t.integer :theme_color

      t.timestamps null: false
      t.index [:user_id, :created_at]
    end
  end
end
