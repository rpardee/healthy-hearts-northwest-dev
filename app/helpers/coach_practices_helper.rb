module CoachPracticesHelper
	def get_gyr_html(gyr_value)
		if Ivcontact::GYR_VALS.key(gyr_value) == "Green"
			html = "<span style='color: green;'>Green</span>"
    elsif Ivcontact::GYR_VALS.key(gyr_value) == "Yellow"
      html = "<span style='color: yellow;'>Yellow</span>"
 		elsif Ivcontact::GYR_VALS.key(gyr_value) == "Red"
      html = "<span style='color: red;'>Red</span>"
    end
    return html.html_safe if html
	end
end
