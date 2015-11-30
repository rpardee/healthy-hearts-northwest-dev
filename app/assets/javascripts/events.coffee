# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
	$('#new_event').validate({
		rules: {
			"event[practice_id]": "required",
			"event[schedule_dt]": "required",
			"event[contact_type]": "required",
			"event[outcome]": "required"
		}
	})