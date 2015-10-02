class Personnel < ActiveRecord::Base
	belongs_to :practice
	has_and_belongs_to_many :ivcontacts
	validates_presence_of :name

	has_paper_trail

	def best_contact
		if phone1_best == true
			best_contact = phone1
		elsif email1_best == true
			best_contact = email1
		elsif phone2_best == true
			best_contact = phone2
		elsif email2_best == true
			best_contact = email2
		else
			best_contact = "(none)"
		end
	end

	ROLE_VALS = {
		"Practice manager" => 1,
		# "Primary site contact" => 2,
		"Primary clinician" => 3,
		# "Secondary site contact" => 4,
		"Front desk" => 5,
		"IT manager" => 6,
		"Physician" => 7,
		"Nurse practitioner" => 8,
		"PA" => 9,
		"MA" => 10,
		"LPN" => 11,
		"RN" => 12,
		"Psychologist" => 13,
		"Licensed social worker" => 14,
		"Social worker" => 15,
		"Psychiatrist" => 16,
		"PT" => 17,
		"OT" => 18,
		"Certified nurse midwife" => 19,
		"Pharmacist" => 20,
		"Other" => 99
	}

end
