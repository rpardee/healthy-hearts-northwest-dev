class AddHitCoachToIvContacts < ActiveRecord::Migration
  def change
  	add_column :ivcontacts, :hit_coach, :integer
  end
end
