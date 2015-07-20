class Practice < ActiveRecord::Base
	belongs_to :partner

	validates_presence_of :name, :status, :md_fte, :emr_certified_year

	enum status: {
		"(pending contact)" => 0,
		"ineligible" => 1,
		"interested" => 2,
		"site visit scheduled" => 3,
		"site visit completed" => 4
	}

	has_many :personnels, dependent: :destroy
	has_many :events, dependent: :destroy do

		def last_contact
			event = self.order("schedule_dt").last
			if event.nil?
				last_contact = ""
			else
				last_contact = event.schedule_dt.strftime("%-m/%-d/%Y")
			end
		end

		def appointments
			self.where("schedule_dt >= ?", Date.today)
		end

	end

	def hte_complete
		false
	end

end
