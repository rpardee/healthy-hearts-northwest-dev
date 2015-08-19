class Event < ActiveRecord::Base
	belongs_to :partner
	belongs_to :practice
	validates_presence_of :practice_id, :schedule_dt

	has_paper_trail

	def appointment
		self.schedule_dt >= Date.today
	end

	def key_actions
		key_actions = ""
		key_actions += "Enrolled*" if outcome_pal_returned == true
		key_actions += "PAL Sent*" if outcome_pal_sent == true
		key_actions += "EHR Complete*" if outcome_complete_ehr == true
		key_actions += "Practice Characteristics Complete*" if outcome_complete_characteristics == true
		key_actions = key_actions.gsub(/(\w)(\*)(\w)/, '\1 - \3')
		key_actions.gsub(/\*$/, '')
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
		"" => 0,
		"Received recruitment materials" => 1,
		"Left voicemail message" => 2,
		"Conversation complete" => 3,
		"Activity cancelled" => 4,
		"Recruitment site visit scheduled" => 5,
		"Recruitment site visit completed" => 6,
		"Welcome site visit scheduled" => 7,
		"Welcome site visit completed" => 8,
	}

end
