class Site < ActiveRecord::Base
	has_many :partners, dependent: :destroy
	has_paper_trail

	SITE_VALS = {
		"GHRI" => 0,
		"ORPRN" => 1,
		"Qualis" => 2
	}
end
