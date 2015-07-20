class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
    	t.references :partner, index: true, foreign_key: true, null: false
      t.string :name, null: false
    	t.string :address
    	t.string :phone
    	t.string :url
      t.integer :status, default: 0, null: false
    	t.boolean :primary_care, default: false, null: false
    	t.integer :md_fte, default: 0, null: false
      t.boolean :emr_certified, default: false, null: false
    	t.integer :emr_certified_year, default: 0, null: false
      t.timestamps null: false
    end
  end
end
