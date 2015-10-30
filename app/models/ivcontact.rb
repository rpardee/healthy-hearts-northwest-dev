class Ivcontact < ActiveRecord::Base
	belongs_to :practice
	belongs_to :partner
  has_many :high_leverage_change_tests
  has_and_belongs_to_many :personnels
  has_paper_trail

  accepts_nested_attributes_for :high_leverage_change_tests, :reject_if => :all_blank, :allow_destroy => true

  validates_presence_of :contact_dt

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
