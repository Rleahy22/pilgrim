class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :uid
    	t.string :email
    	t.string :given_name
    	t.string :family_name

      t.timestamps
    end
  end
end
