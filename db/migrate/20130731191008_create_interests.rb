class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
