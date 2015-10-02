class CreateIvcontactsPersonnels < ActiveRecord::Migration
  def change
    create_table :ivcontacts_personnels, id: false do |t|
    	t.belongs_to :ivcontact, index: true
    	t.belongs_to :personnel, index: true
    end
  end
end
