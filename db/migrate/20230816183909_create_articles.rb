class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false, index: true
      t.text :body
      t.text :short_body
      t.string :url, null: false, index: true
      t.date :publish_date
      t.string :preview_picture

      t.timestamps
    end
  end
end
