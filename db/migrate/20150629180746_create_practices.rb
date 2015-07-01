class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
    	t.references :partner, index: true, foreign_key: true, null: false
      t.string :name
    	t.string :address
    	t.string :phone
    	t.string :url
    	t.boolean :milestone_1
    	t.boolean :milestone_2
    	t.boolean :milestone_3
      t.timestamps null: false
    end
  end
end
