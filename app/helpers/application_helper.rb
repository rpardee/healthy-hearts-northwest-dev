module ApplicationHelper
	def thermometer(prac_state)
		state_key = Practice::PRAC_STATE_VALS[prac_state]
		n = 0
		Practice.where("prac_state = ?", state_key).each do |p|
			n += 1 if p.events.exists?(:outcome_pal_returned => true)
		end
		if prac_state == "WA" then
			return "WA: #{n}/150"
		elsif prac_state == "OR" then
			return "OR: #{n}/130"
		elsif prac_state == "ID" then
			return "ID: #{n}/40"
		else
			return "(undefined)"
		end
	end
end
