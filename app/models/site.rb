class Site < ActiveRecord::Base
	has_many :partners, dependent: :destroy
end
