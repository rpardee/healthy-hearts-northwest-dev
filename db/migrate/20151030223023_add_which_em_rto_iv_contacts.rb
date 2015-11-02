class AddWhichEmRtoIvContacts < ActiveRecord::Migration
  def change
  	add_column :ivcontacts, :prac_change_ehr_which, :string
  end
end
