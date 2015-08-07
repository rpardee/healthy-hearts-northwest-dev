class AddStateToPractices < ActiveRecord::Migration
  def change
  	add_column :practices, :prac_state, :integer
  end
end
