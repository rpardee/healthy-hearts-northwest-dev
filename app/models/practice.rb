class Practice < ActiveRecord::Base
	has_paper_trail
	validates_presence_of :name, :prac_state

	has_many :ivcontacts
	has_many :events
	has_and_belongs_to_many :partners
	has_one :practice_survey

	has_many :personnels, dependent: :destroy
	accepts_nested_attributes_for :personnels, :reject_if => :all_blank,
		:allow_destroy => true

	def primary_contact
		self.personnels.where(site_contact_primary: true).first.try(:name)
	end

	# has_many :personnels, dependent: :destroy do
	# 	def primary_contact_x
	# 		personnel = self.where(:site_contact_primary => true).first
	# 		if personnel.nil?
	# 			primary_contact = "(none)"
	# 		else
	# 			primary_contact = personnel.name
	# 		end
	# 	end
	# end

	def last_contact
		self.events.order('schedule_dt').last.try(:schedule_dt).try(:strftime, "%Y-%m-%d")
	end

	has_many :events, dependent: :destroy do
		# def last_contact_x
		# 	event = self.order("schedule_dt").last
		# 	if event.nil?
		# 		last_contact = ""
		# 	else
		# 		last_contact = event.schedule_dt.strftime("%Y-%m-%d")
		# 	end
		# end

		def appointments
			self.where("schedule_dt >= ?", Date.today)
		end

		def enrolled
			self.exists?(:outcome_pal_returned => true)
		end
	end

	def recruiter
		self.partners.where("recruiter = true").first
	end

	def coach
		# self.partners.find(coach_id) if coach_id
		Partner.find(self.coach_id) if coach_id
	end

	def pal_status
		event_list = self.events
		if event_list.exists?(:outcome_pal_returned => true)
			"Returned"
		elsif event_list.exists?(:outcome_pal_sent => true)
			"Sent"
		else
			""
		end
	end

	def status
		if primary_care == 2 || (prac_ehr.present? and prac_ehr > 1) ||
			prac_ehr_mu == 2 or (fte_clinicians.present? and fte_clinicians > 10)
			"Ineligible"
		elsif interest_yn.blank?
			if primary_care.blank? or fte_clinicians.blank? or prac_ehr.blank? or prac_ehr_mu.blank?
				"Interest/Eligibility TBD"
			elsif primary_care == 1 and fte_clinicians <= 10 and prac_ehr == 1 and prac_ehr_mu == 1
				"Eligible (Interest TBD)"
			else
				"Interest TBD (Status Problem)"
			end
		elsif interest_yn == 2
			"Refused"
		elsif interest_yn == 1
			if primary_care.blank? or fte_clinicians.blank? or prac_ehr.blank? or prac_ehr_mu.blank?
				"Interested (Eligibility TBD)"
			elsif primary_care == 1 and fte_clinicians <= 10 and prac_ehr == 1 and prac_ehr_mu == 1
				"Interested & Eligible"
			else
				"Interested (Status Problem)"
			end
		else
			"(Status Problem)"
		end
	end

  def next_inperson_contact
  	last_contact = Ivcontact.where(practice_id: self.id).maximum(:contact_specific)
  	if last_contact.nil?
  		return 1
  	else
  		return last_contact.to_i + 1
  	end
  end

  def get_inperson_visit(visitnum)
  	Ivcontact.where(practice_id: self.id, contact_specific: visitnum).first
  end

  def tier_value(visitnum)
    contact = get_inperson_visit(visitnum)
    if contact.nil?
      return 0
    else
      return contact.tier
    end
  end

	YN12_VALS = {
		"Yes" => 1,
		"No" => 2
	}

	YNM123_VALS = {
		"Yes" => 1,
		"No" => 2,
		"Maybe" => 3
	}

	YNMU1234_VALS = {
		"Yes" => 1,
		"No" => 2,
		"Maybe" => 3,
		"Unknown" => 4
	}

	PRAC_STATE_VALS = {
		"ID" => 1,
		"OR" => 2,
		"WA" => 3
	}

	RECRUITMENT_SOURCE_VALS = {
		"Email blast" => 1,
		"Individual email" => 2,
		"Flyer" => 3,
		"Referral (specify)" => 4,
		"Conference presentation" => 5
	}

	INTEREST_WHY_NOT_VALS = {
		"No time/too busy" => 1,
		"Already involved in an overlapping initiative" => 2,
		"Practice to close/move in near future" => 3,
		"Don’t need help/satisfied with internal QI" => 4,
		"Bad past experience" => 5,
		"Not relevant to patient population" => 6,
		"Bad timing" => 7,
		"No IT support onsite" => 8,
		"Data collection demands of project" => 9,
		"Other (specify)" => 99
	}

	PRAC_SPEC_MIX_VALS = {
		"Single-specialty" => 1,
		"Multi-specialty" => 2
	}

	# All Yes, Mediare options are coded as "1" per the evaluator doco
	# The original coding is included in comments below
	ELIG_ACO_VALS = {
		"Yes, a Medicare Pioneer ACO (SKIP to Q8)" => 1,
		"Yes, Medicare Shared Saving Program ACO (SKIP to Q8)" => 2,	# 1
		"Yes, Medicare Advance Payment ACO (SKIP to Q8)" => 3,				# 1
		"Yes, a commercial ACO (SKIP to Q8)" => 4,										# 2
		"Yes, another type of ACO (SKIP to Q8)" => 5,									# 3
		"Medicaid ACO (SKIP to Q8)" => 6,															# 4
		"No" => 0																											# 5
	}

	PRAC_EHR_VALS = {
		"Yes, all electronic" => 1,
		"Yes, part paper and part electronic" => 2,
		"No" => 3
	}

	PRAC_EHRNAME_VALS = {
		"All Scripts" => 1,
		"advancedMD" => 2,
		"Amazing charts" => 3,
		"Athenahealth" => 4,
		"Care360" => 5,
		"Cerner" => 6,
		"eClinicalWorks" => 7,
		"e-MDs" => 8,
		"EPIC" => 9,
		"GE/Centricity" => 10,
		"Greenway Medical" => 11,
		"McKesson/Practice Partner" => 12,
		"NextGen" => 13,
		"Practice Fusion" => 14,
		"Sage/Vitera" => 15,
		"SOAPware" => 16,
		"Other" => 99
	}

	PRAC_MU_STAGE1_VALS = {
		"Yes" => 1,
		"No, we did not apply (SKIP to Q6)" => 2,
		"Uncertain (SKIP to Q6)" => 3
	}

	PRAC_EHR_PERSON_EXTRACTDATA_VALS = {
		"A clinician or staff person in the practice" => 1,
		"A consultant/service on retainer to the practice" => 2,
		"An IT service provider within the health system or organization" => 3,
		"Other" => 9
	}

	PRAC_EHR_EXTRACTDATA_VALS = {
		"Yes" => 1,
		"No (SKIP to Q9)" => 2
	}

	PRAC_EHR_VENDOR_VALS = {
		"Yes, and there are restrictions to sharing & customization" => 1,
		"Yes, and there are no restrictions" => 2,
		"No" => 3,
		"Not applicable" => 4,
		"Don't know" => 8
	}

	PRAC_IT_SUPPORT_VALS = {
		"Yes" => 1,
		"No (SKIP to Q11)" => 2
	}

	PRAC_CQM_VALS = {
		"Yes" => 1,
		"No (SKIP to Q15)" => 2
	}

	SATISFIED1234_VALS = {
		"Very satisfied" => 1,
		"Somewhat satisfied" => 2,
		"Somewhat dissatisfied" => 3,
		"Very dissatisfied" => 4
	}

	INTEREST_CONTACT_MONTH_VALS = {
		"Aug 2015" => 8,
		"Sep 2015" => 9,
		"Oct 2015" => 10,
		"Nov 2015" => 11,
		"Dec 2015" => 12,
		"Jan 2016" => 1,
		"Feb 2016" => 2,
		"Mar 2016" => 3,
		"Apr 2016" => 4,
		"May 2016" => 5,
	}

	PRAC_ACO_JOIN_MEDICAID_VALS = {
		"Yes" => 1,
		"No" => 2,
		"Already contracting with a Medicaid ACO" => 3
	}

	PRAC_ACO_JOIN_MEDICARE_VALS = {
		"Yes" => 1,
		"No" => 2,
		"Already contracting with a Medicare ACO" => 3
	}

	PRAC_ACO_JOIN_COMMERCIAL_VALS = {
		"Yes" => 1,
		"No" => 2,
		"Already contracting with a private/commercial ACO" => 3,
		"Already contracting but plan to join ... (see below)*" => 4
	}
end
