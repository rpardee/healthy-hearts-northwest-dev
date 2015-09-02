class AddCityToPractices < ActiveRecord::Migration
  def change
  	add_column :practices, :city, :string, :limit => 50
  end
end
