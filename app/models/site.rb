class Site < ActiveRecord::Base
	has_many :partners, dependent: :destroy

	enum site: {
		"ORPRN" => 1,
		"Qualis" => 2
	}
end
