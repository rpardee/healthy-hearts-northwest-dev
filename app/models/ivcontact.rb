class Ivcontact < ActiveRecord::Base
	belongs_to :practice
	belongs_to :partner
  has_many :high_leverage_change_tests
  has_and_belongs_to_many :personnels
  has_paper_trail

  accepts_nested_attributes_for :high_leverage_change_tests, reject_if: proc { |attributes| attributes['description'].blank? }, allow_destroy: true

  validates_presence_of :contact_dt

  def disruptions
    disruptions = ""
    disruptions += "New EHR*" if prac_change_ehr == 1
    disruptions += "New location*" if prac_change_newlocation == 1
    disruptions += "Lost clinician*" if prac_change_lost_clin == 1
    disruptions += "Lost staff*" if prac_change_lost_om == 1
    disruptions += "New affiliation*" if prac_change_boughtover == 1
    disruptions += "New billing*" if prac_change_billing == 1
    disruptions += "Other*" if prac_change_other == 1
    disruptions = disruptions.gsub(/(\w)(\*)(\w)/, '\1 - \3')
    disruptions.gsub(/\*$/, '')
  end

  HIT_TIER_VALS = {
    "Tier 1" => 1,
    "Tier 2" => 2,
    "Tier 3" => 3,
    "Tier 4" => 4
  }

  HIT_QUALITY_VALS = {
    "Very confident" => 1,
    "Confident" => 2,
    "Somewhat confident" => 3,
    "Not confident" => 4,
  }

  CONTACT_TYPE_VALS = {
    "Quarterly in-person visit" => 1,
    "Other required contact" => 2,
    "Other ad-hoc contact" => 9
  }

  CONTACT_MODE_VALS = {
  	"In-person" => 1,
    "Phone" => 2,
    "Email" => 3,
  	"Online" => 4
  }

  CONTACT_SPECIFIC_VALS = {
		"Baseline" => 1,
		"Quarter 2" => 2,
		"Quarter 3" => 3,
		"Quarter 4" => 4,
		"Quarter 5" => 5,
  }

  Y1N2_VALS = {
  	"Yes" => 1,
  	"No" => 2
  }

  GYR_VALS = {
  	"Green" => 1,
  	"Yellow" => 2,
  	"Red" => 3
  }

  PROGRESS_VALS = {
  	"Not a priority" => 1,
  	"Planning, little/no progress" => 2,
  	"Making progress" => 3,
  	"Done/in place already" => 4
  }
end
