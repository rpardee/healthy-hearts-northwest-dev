class CreateCoachItems < ActiveRecord::Migration
  def change
    create_table :coach_items do |t|
    	t.integer :item_type
    	t.date :add_dt
    	t.boolean :complete
    	t.date :complete_dt
    	t.text :notes
    	t.references :practice
      t.timestamps null: false
    end
  end
end
