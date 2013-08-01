class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
