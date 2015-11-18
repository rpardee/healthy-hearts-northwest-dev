class AddFieldsToIvContact < ActiveRecord::Migration
  def change
  	add_column :ivcontacts, :status_text, :string
  	add_column :ivcontacts, :smsvy_name, :string
  	add_column :ivcontacts, :smsvy_email, :string
  	add_column :ivcontacts, :hit_ehr_vendor, :string
  	add_column :ivcontacts, :hit_tier, :integer
  	add_column :ivcontacts, :hit_quality, :integer
  	add_column :ivcontacts, :hit_quality_explain, :text
  end
end
