module CoachPracticesHelper
	def get_gyr_html(gyr_value)
		if Ivcontact::GYR_VALS.key(gyr_value) == "Green"
			html = "<span style='background-color: green; color: white; padding: 3px;'>Green</span>"
    elsif Ivcontact::GYR_VALS.key(gyr_value) == "Yellow"
      html = "<span style='background-color: yellow; padding: 3px';>Yellow</span>"
 		elsif Ivcontact::GYR_VALS.key(gyr_value) == "Red"
      html = "<span style='background-color: red; color: white; padding: 3px;'>Red</span>"
    end
    return html.html_safe if html
	end
end
