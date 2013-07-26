class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :entry

      t.timestamps
    end
  end
end
