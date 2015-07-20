class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
    	t.references :site, index: true, foreign_key: true, null: false
    	t.string :name, null: false
    	t.integer :role, default: 0, null: false
      t.timestamps null: false
    end
  end
end
