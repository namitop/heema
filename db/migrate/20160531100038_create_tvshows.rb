class CreateTvshows < ActiveRecord::Migration
  def change
    create_table :tvshows do |t|
      t.references :tv, index: true, foreign_key: true
      t.string :introduction
      t.text :video_url

      t.timestamps null: false
      t.index [:tv_id, :created_at]
    end
  end
end
