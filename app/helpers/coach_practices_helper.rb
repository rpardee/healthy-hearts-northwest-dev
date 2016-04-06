module CoachPracticesHelper
	def get_gyr_html(gyr_value)
		if Ivcontact::GYR_VALS.key(gyr_value) == "Green"
			html = "<span class='gyr-green'>Green</span>"
    elsif Ivcontact::GYR_VALS.key(gyr_value) == "Yellow"
      html = "<span class='gyr-yellow'>Yellow</span>"
 		elsif Ivcontact::GYR_VALS.key(gyr_value) == "Red"
      html = "<span class='gyr-red'>Red</span>"
    end
    return html.html_safe if html
	end
  def flag_incomplete(boo, tit = "One or more items in this section is missing a response!")
    if boo
      return raw("&nbsp;")
    else
      return image_tag("red-x.png", size: "25", title: tit)
    end
  end
  def practice_tr_style(prac)
    raw('style="background-color: darkgrey;" title="This practice has dropped from the study."') if !prac.active
  end
end
