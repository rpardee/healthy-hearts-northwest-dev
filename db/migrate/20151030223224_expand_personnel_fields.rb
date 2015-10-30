class ExpandPersonnelFields < ActiveRecord::Migration
  def change
  	change_column :personnels, :phone1, :string, :limit => 40
  	change_column :personnels, :phone2, :string, :limit => 40
  end
end
