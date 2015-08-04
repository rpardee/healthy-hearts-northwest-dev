class Event < ActiveRecord::Base
	belongs_to :partner
	belongs_to :practice

	validates_presence_of :schedule_dt, :schedule_tm

	def appointment
		self.schedule_dt >= Date.today
	end

	CONTACT_TYPE_VALS = {
		"(no contact)" => 0,
		"Phone" => 1,
		"Email" => 2,
		"In-person" => 3,
		"Text" => 4,
		"Other (specify)" => 9
	}

	OUTCOME_VALS = {
		"Pending" => 0,
		"Received recruitment materials" => 1,
		"Left voicemail message" => 2,
		"Conversation complete" => 3,
		"Site visit scheduled" => 4,
		"Site visit completed" => 5,
		"PAL sent" => 6,
		"Enrolled/PAL returned" => 7,
		"Practice characteristics complete" => 8,
		"EHR assessment complete" => 9,
		"All questions complete" => 10
	}

end
