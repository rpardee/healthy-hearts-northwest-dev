class BreakOutOutcomeAndPracticeCategories < ActiveRecord::Migration
  def change
  	add_column :practices, :zip_code, :string, :limit => 10
  	change_table :events do |t|
  		t.column :outcome_pal_sent, :boolean, default: false
  		t.column :outcome_pal_returned, :boolean, default: false
  		t.column :outcome_complete_ehr, :boolean, default: false
  		t.column :outcome_complete_characteristics, :boolean, default: false
  	end
  	change_table :personnels do |t|
  		t.column :site_contact_primary, :boolean, default: false
  		t.column :site_contact_secondary, :boolean, default: false
  		t.column :site_contact_champion, :boolean, default: false
  	end
  end
end
