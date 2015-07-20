class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.references :partner, index: true, foreign_key: true, null: false
    	t.references :practice, index: true, foreign_key: true, null: false
    	t.date :schedule_dt, null: false
      t.time :schedule_tm, null: false
    	t.integer :contact_type, null: false, default: 0
    	t.integer :outcome, null: false, default: 0
    	t.date :outcome_dt
    	t.text :description
      t.timestamps null: false
    end
  end
end
