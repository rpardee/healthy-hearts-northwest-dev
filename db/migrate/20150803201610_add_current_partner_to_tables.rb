class AddCurrentPartnerToTables < ActiveRecord::Migration
  def change
  	add_column :practices, :current_partner, :string
  	add_column :events, :current_partner, :string
  	add_column :personnels, :current_partner, :string
  	add_column :events, :contact_type_other, :string
  end
end
