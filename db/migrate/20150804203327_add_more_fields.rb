class AddMoreFields < ActiveRecord::Migration
  def change
  	change_column_null :events, :schedule_tm, true
  	add_column :practices, :parent_organization, :string
  	add_column :practices, :interest_contact_month, :integer
  	change_table :personnels do |t|
  		t.column :ehr_extractor, :boolean, default: false
  		t.column :ehr_helper, :boolean, default: false
  		t.column :ehr_cqm, :boolean, default: false
  		t.column :role_other, :string
  	end
  end
end
