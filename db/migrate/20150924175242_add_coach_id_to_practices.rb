class AddCoachIdToPractices < ActiveRecord::Migration
  def change
  	add_column :practices, :coach_id, :integer
  end
end
