class Site < ActiveRecord::Base
	has_many :partners, dependent: :destroy
	has_paper_trail
end
