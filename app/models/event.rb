class Event < ActiveRecord::Base
  belongs_to :partner
  belongs_to :practice
  validates_presence_of :practice_id, :schedule_dt, :contact_type, :outcome

  has_paper_trail

  after_save :update_practice
  after_destroy :update_practice
  after_find :cache_pracid

  # initialize this to zero
  @original_pracid = 0

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

  def reset_cached_values(p)
    p.la_date_cached = p.last_contact
    # pal_status cached corresponds to pal_status
    p.pal_status_cached = p.pal_status

    # also set the study_id if pal_status == "Returned"
    # 1xxxx = ID, 2xxxx = OR, 3xxxxx = WA
    # x1xxx = ORPRN, x2xxx = Qualis
    if p.pal_status == "Returned"
      counter = Counter.first
      counter_study_id = counter.study_id
      counter_study_id += 1
      counter_f = "%03d" % counter_study_id
      if Practice::PRAC_STATE_VALS.key(p.prac_state) == "ID"
        study_id = "12#{counter_f}"
      elsif Practice::PRAC_STATE_VALS.key(p.prac_state) == "OR"
        study_id = "21#{counter_f}"
      elsif Practice::PRAC_STATE_VALS.key(p.prac_state) == "WA"
        study_id = "32#{counter_f}"
      else
        Rails.logger.debug "Error: #{p.name} returned PAL but has no state set."
      end
      p.study_id = study_id
      counter.study_id = counter_study_id
      counter.save!
    end

    p.save!
  end

  def update_practice
    # Set the event-determined cached fields on the practice whose event this is.
    # la_date_cached holds the date of the most recent event
    # it corresponds to practice.last_contact
    p = self.practice
    reset_cached_values(p)
    if @original_pracid && @original_pracid > 0 then
      p2 = Practice.find(@original_pracid)
      reset_cached_values(p2)
    end
  end

  def cache_pracid
    # Called by the after_find callback, this stores the id of the associated practice
    # in an instance var.  This way we have the original value in case the user is re-parenting
    # the event, so we can re-set the cached values on both the original practice and whatever the
    # new practice is.
    @original_pracid = self.practice_id
  end

end
