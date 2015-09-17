class Ivcontact < ActiveRecord::Base
	belongs_to :practice
	belongs_to :partner
  has_paper_trail
end
