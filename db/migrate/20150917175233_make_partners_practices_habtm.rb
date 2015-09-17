class MakePartnersPracticesHabtm < ActiveRecord::Migration
  def change
  	create_table :partners_practices, id: false do |t|
  		t.belongs_to :partner, index: true
  		t.belongs_to :practice, index: true
  	end
  	remove_column :practices, :partner_id, :integer
  	add_column :partners, :recruiter, :boolean
  	add_column :partners, :coach, :boolean
  end
end
