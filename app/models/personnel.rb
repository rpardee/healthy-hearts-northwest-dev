class Personnel < ActiveRecord::Base
	belongs_to :practice

	validates_presence_of :name

	def best_contact
		if phone1_best == true
			best_contact = phone1
		elsif email1_best == true
			best_contact = email1
		elsif phone2_best == true
			best_contact = phone2
		elsif email2_best == true
			best_contact = email2
		else
			best_contact = "(none)"
		end
	end

	enum role: {
		"Practice Manager" => 1,
		"Primary Site Contact" => 2,
		"Primary Clinician" => 3,
		"Secondary Site Contact" => 4
	}
end
