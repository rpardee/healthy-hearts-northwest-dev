class ManagerNote < ActiveRecord::Base
	belongs_to :site
	has_paper_trail

  MANAGER_NOTE_TYPE_VALS = {
  	"Barrier" => 1,
    "Success" => 2,
    "Support" => 3
  }
end
