class ChangeBooleanFieldsToInteger < ActiveRecord::Migration
  def change
  	remove_column :practices, :primary_care, :boolean
  	add_column :practices, :primary_care, :integer
  	remove_column :practices, :prac_ehr, :boolean
  	add_column :practices, :prac_ehr, :integer
  	add_column :practices, :prac_ehr_mu_yr, :integer
  	add_column :practices, :interest_yn, :integer
  	add_column :practices, :interest_why_not, :integer
  	add_column :practices, :interest_why_not_other, :string
  end
end
