class CreatePersonnels < ActiveRecord::Migration
  def change
    create_table :personnels do |t|
    	t.references :practice, index: true, foreign_key: true, null: false
    	t.string :name, null: false
    	t.integer :role
    	t.string :best_contact
      t.timestamps null: false
    end
  end
end
