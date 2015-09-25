class Ivcontact < ActiveRecord::Base
	belongs_to :practice
	belongs_to :partner
  has_paper_trail

  CONTACT_TYPE_VALS = {
    "Required in-person visit" => 1,
    "Required phone call" => 2,
    "Other contact" => 9
  }

  CONTACT_MODE_VALS = {
  	"In-person" => 1,
    "Phone" => 2,
    "Email" => 3,
  	"Text" => 4,
  	"Other" => 9
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
  	"Starting to work on this" => 2,
  	"Little/no progress" => 3,
  	"Making progress" => 4,
  	"Done/in place already" => 5
  }
end
