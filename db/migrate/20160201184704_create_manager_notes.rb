class CreateManagerNotes < ActiveRecord::Migration
  def change
    create_table :manager_notes do |t|
    	t.references :site
    	t.integer :manager_note_type
    	t.string :manager_note_topic
    	t.text :manager_note_comment
      t.timestamps null: false
    end
  end
end
