class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text   :title
      t.text   :url
      t.string :image
      t.text   :content
      t.text   :translatable
      t.text   :summary
      t.string :source_language

      t.timestamps
    end
  end
end
