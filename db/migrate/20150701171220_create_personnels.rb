class CreatePersonnels < ActiveRecord::Migration
  def change
    create_table :personnels do |t|
    	t.references :practice, index: true, foreign_key: true, null: false
    	t.string :name, null: false
    	t.integer :role
    	t.string :phone1, limit: 20
    	t.boolean :phone1_best, null: false, default: false
    	t.string :phone2, limit: 20
    	t.boolean :phone2_best, null: false, default: false
    	t.string :email1, limit: 20
    	t.boolean :email1_best, null: false, default: false
    	t.string :email2, limit: 20
    	t.boolean :email2_best, null: false, default: false
      t.timestamps null: false
    end
  end
end
