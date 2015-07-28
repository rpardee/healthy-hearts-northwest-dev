class Event < ActiveRecord::Base
	belongs_to :partner
	belongs_to :practice

	validates_presence_of :schedule_dt

	def appointment
		self.schedule_dt >= Date.today
	end

	CONTACT_TYPE_VALS = {
		"(no contact)" => 0,
		"phone" => 1,
		"email" => 2,
		"in-person" => 3
	}

	OUTCOME_VALS = {
		"(no outcome)" => 0,
		"good outcome" => 1
	}

end
