class Practice < ActiveRecord::Base
	has_paper_trail
	validates_presence_of :name, :prac_state

	has_many :ivcontacts
	has_many :events
	has_and_belongs_to_many :partners

	belongs_to :site

	has_many :coach_items
  has_many :surveys

	accepts_nested_attributes_for :coach_items, :reject_if => :all_blank,
		:allow_destroy => true

	has_many :personnels, dependent: :destroy

  # Need these to cure the 3*(n + 1) queries problem in practices/index.csv
  # http://guides.rubyonrails.org/association_basics.html#has-many-association-reference
  has_many :primary_contacts, -> { where "site_contact_primary  = 't'"}, class_name: "Personnel"
  has_many :ehr_extractors  , -> { where "ehr_extractor         = 't'"}, class_name: "Personnel"
  has_many :ehr_helpers     , -> { where "ehr_helper            = 't'"}, class_name: "Personnel"

	accepts_nested_attributes_for :personnels, :reject_if => :all_blank,
		:allow_destroy => true

  def brief_status
    self.coach_items.where(item_type: CoachItem::ITEM_TYPE_VALS["Brief status update"])
      .order(:updated_at).last.try(:notes)
  end

  def practice_survey
    self.surveys.where(survey_type: 'Practice').order('date_sent').last
  end

  def staff_survey
    self.surveys.where(survey_type: 'Staff').order('date_sent').last
  end

  def abcs(which_quarter = 'q20154')
    self.surveys.where(survey_type: 'ABCS', status: which_quarter).first
  end

	def primary_contact
		self.personnels.where(site_contact_primary: true).first.try(:name)
	end

  def last_contact
    self.events.maximum(:schedule_dt)
  end

  def last_required_iv_contact_date
    lric = last_required_iv_contact
    lric.contact_dt if lric
  end
  def last_required_iv_contact
    self.ivcontacts.where({ contact_type: [1, 2] }).order(:contact_dt).last
  end

  def last_iv_status
    iv_with_status = self.ivcontacts.where.not(status_text: nil)
    iv_with_status.order(:contact_dt).last.status_text if iv_with_status.count > 0
  end

  def last_iv_gyr
    iv_with_gyr = self.ivcontacts.where({ contact_type: [1, 2] })
    iv_with_gyr.order(:contact_dt).last.gyr if iv_with_gyr.count > 0
	end

  def iv_ehr_vendor
    iv_first_required = self.ivcontacts.where({ contact_type: 1, contact_specific: 1 })
    iv_first_required.first.hit_ehr_vendor if iv_first_required.count > 0
  end

  def iv_qica_dt
    iv_qica_required = self.ivcontacts.where({ contact_type: 1, contact_specific: [1, 4] })
    iv_qica_required.order(:contact_dt).last.contact_dt if iv_qica_required.count > 0
  end

  def get_last_qica
    visit14 = self.ivcontacts.where({ contact_type: 1, contact_specific: [1, 4] })
    visit14.order(:contact_dt).last if visit14
  end

  def randomization_fields_complete?
    REQUIRED_FOR_RANDOMIZATION.keys.each do |fld|
      if self.send(fld).nil? then
        return false
      end
    end
    return true
  end

  def last_qica_complete?
    qica = get_last_qica
    if qica
      [qica.pcmha_1,
       qica.pcmha_2,
       qica.pcmha_3,
       qica.pcmha_4,
       qica.pcmha_5,
       qica.pcmha_6,
       qica.pcmha_7,
       qica.pcmha_8,
       qica.pcmha_9,
       qica.pcmha_10,
       qica.pcmha_11,
       qica.pcmha_12,
       qica.pcmha_13,
       qica.pcmha_14,
       qica.pcmha_15,
       qica.pcmha_16,
       qica.pcmha_17,
       qica.pcmha_18,
       qica.pcmha_19,
       qica.pcmha_20].all?
    else
      return nil
    end
  end

  # The grouping of QICA (old PCMHA) items was not considered when first built
  # Grouping is defined here and displayed separately in ivcontacts\form.html.erb
  # Update in both places if necessary
  def get_qica_summary
    qica_summary = Array.new
    qica = get_last_qica
    if qica
      sum = qica.pcmha_1 || 0
      pct = ((sum || 0)/12.to_f * 100)
      cmplt = [qica.pcmha_1].all?
      qica_summary[0] = [sum, pct, 12, cmplt]

      ar = [qica.pcmha_2, qica.pcmha_3]
      sum = ar.compact.reduce(0, :+)
      pct = ((sum || 0)/24.to_f * 100)
      cmplt = ar.all?
      qica_summary[1] = [sum, pct, 24, cmplt]

      ar = [qica.pcmha_4, qica.pcmha_5, qica.pcmha_6]
      sum = ar.compact.reduce(0, :+)
      pct = ((sum || 0)/36.to_f * 100)
      cmplt = ar.all?
      qica_summary[2] = [sum, pct, 36, cmplt]

      ar = [qica.pcmha_7, qica.pcmha_8, qica.pcmha_9, qica.pcmha_10]
      sum = ar.compact.reduce(0, :+)
      pct = ((sum || 0)/48.to_f * 100)
      cmplt = ar.all?
      qica_summary[3] = [sum, pct, 48, cmplt]

      ar = [qica.pcmha_11, qica.pcmha_12, qica.pcmha_13, qica.pcmha_14]
      sum = ar.compact.reduce(0, :+)
      pct = ((sum || 0)/48.to_f * 100)
      cmplt = ar.all?
      qica_summary[4] = [sum, pct, 48, cmplt]

      ar = [qica.pcmha_15, qica.pcmha_16, qica.pcmha_17]
      sum = ar.compact.reduce(0, :+)
      pct = ((sum || 0)/36.to_f * 100)
      cmplt = ar.all?
      qica_summary[5] = [sum, pct, 36, cmplt]

      ar = [qica.pcmha_18, qica.pcmha_19, qica.pcmha_20]
      sum = ar.compact.reduce(0, :+)
      pct = ((sum || 0)/36.to_f * 100)
      cmplt = ar.all?
      qica_summary[6] = [sum, pct, 36, cmplt]
    end
    return qica_summary
  end

	has_many :events, dependent: :destroy do
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
    last_contact = Ivcontact.where(practice_id: self.id, contact_type: Ivcontact::CONTACT_TYPE_VALS["Quarterly in-person visit"]).maximum(:contact_specific)
    if last_contact.nil?
      return 1
    else
      return last_contact.to_i + 1
    end
  end

  def get_inperson_visit(visitnum)
  	# Ivcontact.where(practice_id: self.id, contact_type: 1, contact_specific: visitnum).first
  	self.ivcontacts.where(contact_type: 1, contact_specific: visitnum).first
  end

  def tier_value(visitnum)
    contact = get_inperson_visit(visitnum)
    if contact.nil?
      return 0
    else
      return contact.tier
    end
  end
  def formatted_address
    "#{address} #{city} #{PRAC_STATE_VALS.key(prac_state)} #{zip_code}"
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
    "Yes, Medicare Shared Saving Program ACO (SKIP to Q8)" => 2,  # 1
    "Yes, Medicare Advance Payment ACO (SKIP to Q8)" => 3,        # 1
    "Yes, a commercial ACO (SKIP to Q8)" => 4,                    # 2
    "Yes, another type of ACO (SKIP to Q8)" => 5,                 # 3
    "Medicaid ACO (SKIP to Q8)" => 6,                             # 4
    "No" => 0                                                     # 5
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
    # "No (SKIP to Q9)" => 2
    "No (SKIP to Q3)" => 2
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
    # "No (SKIP to Q11)" => 2
    "No" => 2
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

  INACTIVE_RSN_VALS = {
    "Active" => 0,
    "Dropout" => 1
  }

  DROP_DETERMINE_VALS = {
    "Practice not responding to coaches" => 1,
    "Practice notified coach of decision" => 2,
    "H2N staff made decision" => 3
  }

  DROP_NOTIFY_HOW_VALS = {
    "In person" => 1,
    "Phone" => 2,
    "Email" => 3,
    "Other" => 9
  }


  # This list is made-up for now--just roughing out a possible solution to demo.
  REQUIRED_FOR_RANDOMIZATION = {
     # prac_aco_join_medicaid: "Plans to join medicaid ACO",
     # prac_ehr_mu: "Whether EMR is meaningful-use certified",
     # prac_ehr_extractdata: "Does practice have someone to extract data from EHR?",
     # number_clinicians: "Number of clinicians.",
     # fte_clinicians: "Clinician FTE",
     name: "Practice Name",
     prac_state: "Practice State"
   }

  EXPORT_VARIABLES = %w(name, address, phone, url)

  require File.expand_path('lib/variable_map')
  include VariableMap

  def self.export_variable_header
    prettyName = Array.new
    Practice.attribute_names.each do |dbname|
    # Practice::EXPORT_VARIABLES.each do |dbname|
      lookupVarName = VariableMap::PRACTICE_MAP[dbname][0] if VariableMap::PRACTICE_MAP[dbname]
      if lookupVarName.nil?
        prettyName << dbname.humanize
      else
        prettyName << lookupVarName
      end
    end
    return ('"' + prettyName.join('","') + '"').html_safe
  end

  def export_variable_values
    prettyVars = Array.new
    self.attributes.each do |a|
      lookupValue = VariableMap::PRACTICE_MAP[a[0]][1] if VariableMap::PRACTICE_MAP[a[0]]
      if lookupValue.nil?
        prettyVars << a[1]
      else
        prettyVars << lookupValue.constantize.key(a[1])
      end
    end
    return ('"' + prettyVars.join('","') + '"').html_safe
  end

end
