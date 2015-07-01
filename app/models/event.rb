class Event < ActiveRecord::Base
	belongs_to :partner
	belongs_to :practice

	def appointment
		self.schedule_dt >= Date.today
	end
end
