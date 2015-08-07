class DropEventOutcomeDate < ActiveRecord::Migration
  def change
  	remove_column :events, :outcome_dt, :date
  end
end
