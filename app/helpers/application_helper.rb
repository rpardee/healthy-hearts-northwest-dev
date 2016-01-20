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

	def recruiter_or_coach_default
		# controller_name and action_name are available methods
		recruiter_controllers = ['events','personnels','practices']
		coach_controllers = ['coach_items','coach_practices','high_level_change_tests',
			'ivcontacts']
		admin_controllers = ['partners','sites']
		if recruiter_controllers.include?(controller_name)
			"Recruiter"
		elsif coach_controllers.include?(controller_name)
			"Coach"
		elsif admin_controllers.include?(controller_name)
			"Admin"
		end
	end
  def check_if(boo, red_x_otherwise = false)
    if boo
      return image_tag("check-mark-blue.png", size: "25")
    else
    	if red_x_otherwise
    		return image_tag("red-x.png", size: "25")
    	else
	      return raw("&nbsp;")
	    end
    end
  end
end
