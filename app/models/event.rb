class Event < ActiveRecord::Base
	belongs_to :partner
	belongs_to :practice
	validates_presence_of :practice_id, :schedule_dt

	has_paper_trail

	after_save :update_practice

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
		"Phone meeting scheduled" => 9,
		"Site visit" => 10
	}

	protected

	def update_practice
		# Set the event-determined cached fields on the practice whose event this is.
		# la_date_cached holds the date of the most recent event
		# it corresponds to practice.last_contact
		p = self.practice
		p.la_date_cached = p.last_contact

		# pal_status cached corresponds to pal_status
		p.pal_status_cached = p.pal_status

		p.save!

	end

end
