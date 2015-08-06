class Practice < ActiveRecord::Base
	belongs_to :partner
	validates_presence_of :name

	has_paper_trail

	has_many :personnels, dependent: :destroy do
		def primary_contact
			personnel = self.where("role = ?", Personnel::ROLE_VALS["Primary site contact"]).first
			if personnel.nil?
				primary_contact = "(none)"
			else
				primary_contact = personnel.name
			end
		end
	end
	accepts_nested_attributes_for :personnels, :reject_if => :all_blank,
		:allow_destroy => true

	has_many :events, dependent: :destroy do
		def last_contact
			event = self.order("schedule_dt").last
			if event.nil?
				last_contact = ""
			else
				last_contact = event.schedule_dt.strftime("%Y-%m-%d")
			end
		end

		def appointments
			self.where("schedule_dt >= ?", Date.today)
		end
	end

	def status
		if interest_yn == 2 then
			"Refused"
		elsif primary_care.blank? or elig_phys_fte.blank? or prac_ehr_mu.blank?
			"Interested (Eligibility TBD)"
		elsif primary_care == 1 and elig_phys_fte <= 10 and prac_ehr_mu == 1
			"Eligible"
		elsif primary_care == 2 or elig_phys_fte > 10 or prac_ehr_mu == 2
			"Ineligible"
		else
			"(Status Error)"
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

	# "Other" is 16 in original coding
	ELIG_OWNERSHIP_VALS = {
		"Private solo or group practice" => 1,
		"Freestanding urgent care center" => 2,
		"Hospital owned" => 3,
		"Health system owned" => 4,
		"Industrial outpatient facility" => 5,
		"Mental health center" => 6,
		"Non-federal government clinic (e.g., state, county, city, etc.)" => 7,
		"Federally Qualified Health Center or Look-Alike" => 8,
		"Rural Health Clinic" => 9,
		"Indian Health Service" => 10,
		"Institutional setting (school-based, nursing home, prison)" => 11,
		"Academic health center / faculty practice" => 12,
		"Health maintenance organization (e.g., Kaiser Permanente)" => 13,
		"Federal (Military, Veterans Administration, Department of Defense)" => 14,
		"Public Health Service" => 15,
		"Other" => 99
	}

	ELIG_SPECIALTY_VALS = {
		"Single-specialty" => 1,
		"Multi-specialty" => 2
	}

	# All Yes, Mediare options are coded as "1" per the evaluator doco
	# The original coding is included in comments below
	ELIG_ACO_VALS = {
		"Yes, a Medicare Pioneer ACO" => 1,
		"Yes, Medicare Shared Saving Program ACO" => 2, # 1
		"Yes, Medicare Advance Payment ACO" => 3,				# 1
		"Yes, a commercial ACO" => 4,										# 2
		"Yes, another type of ACO" => 5,								# 3
		"Medicaid ACO" => 6,														# 4
		"No" => 0																				# 5
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
		"Yes, we have applied and receive payments" => 1,
		"Yes, we already applied" => 2,
		"Yes, we intend to apply" => 3,
		"Uncertain if we will apply" => 4,
		"No, we will not apply" => 5
	}

	PRAC_EHR_PERSON_EXTRACTDATA_VALS = {
		"Me" => 1,
		"Someone else in the office" => 2,
		"A consultant/service on retainer" => 3,
		"Other" => 9
	}

	SATISFIED1234_VALS = {
		"Very satisfied" => 1,
		"Somewhat satisfied" => 2,
		"Somewhat dissatisfied" => 3,
		"Very dissatisfied" => 4
	}
end
