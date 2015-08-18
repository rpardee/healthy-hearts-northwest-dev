class AddAdminFlagToPartners < ActiveRecord::Migration
  def change
  	add_column :partners, :role, :integer
  end
end
