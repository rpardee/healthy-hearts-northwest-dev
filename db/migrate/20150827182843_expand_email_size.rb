class ExpandEmailSize < ActiveRecord::Migration
  def up
  	change_column :personnels, :email1, :string, :limit => 255
  	change_column :personnels, :email2, :string, :limit => 255
  end

  def down
  	change_column :personnels, :email1, :string, :limit => 20
  	change_column :personnels, :email2, :string, :limit => 20
  end
end
