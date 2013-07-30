class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :article_id
      t.text :source_text
      t.text :target_translation
      t.text :reverse_translation

      t.timestamps
    end
  end
end
