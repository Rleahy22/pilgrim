class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :article_id
      t.string :language
      t.text :json
      t.timestamps
    end
  end
end
