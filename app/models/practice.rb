class Practice < ActiveRecord::Base
	belongs_to :partner
	has_many :events, dependent: :destroy do

		def last_contact
			event = self.order("schedule_dt").last
			if event.nil?
				last_contact = ""
			else
				last_contact = event.schedule_dt.strftime("%m/%d/%Y")
			end
		end

		def appointments
			self.where("schedule_dt >= ?", Date.today)
		end

	end

	has_many :personnels, dependent: :destroy

end
