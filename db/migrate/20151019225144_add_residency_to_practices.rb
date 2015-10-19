class AddResidencyToPractices < ActiveRecord::Migration
  def change
  	add_column :practices, :residency_training_site, :boolean, :default => false
  end
end
