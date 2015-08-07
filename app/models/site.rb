class Site < ActiveRecord::Base
	has_many :partners, dependent: :delete_all
	has_paper_trail

	enum site: {
		"ORPRN" => 1,
		"Qualis" => 2
	}

end
