class AddPracticeIdToIvcontacts < ActiveRecord::Migration
  def change
  	add_column :ivcontacts, :practice_id, :integer
  end
end
