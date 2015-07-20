class Event < ActiveRecord::Base
	belongs_to :partner
	belongs_to :practice

	validates_presence_of :schedule_dt, :schedule_tm, :contact_type, :outcome

	def appointment
		self.schedule_dt >= Date.today
	end

	enum contact_type: {
		"(no contact)" => 0,
		"phone" => 1,
		"email" => 2,
		"in-person" => 3
	}

	enum outcome: {
		"(no outcome)" => 0,
		"good outcome" => 1
	}

end
