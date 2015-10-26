class CoachItem < ActiveRecord::Base
	belongs_to :practice

  validates_presence_of :practice_id

	ITEM_TYPE_VALS = {
		"Action item" => 1,
		"Coach follow-up" => 2
	}
end
