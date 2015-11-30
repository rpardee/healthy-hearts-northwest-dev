# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $(document).on "page:change", ->
# 	$('div#nav-right').sticky()

updateContactType = (contact_type_field) ->
	v = parseInt($(contact_type_field).val())
	if v == 1  				# Required/in-person
		$('#ivcontact-milestone').show()
		$('#ivcontact-pdsa').show()
		$('#ivcontact-gyr').show()
		$('#ivcontact-tier').show()
		$('#ivcontact-pcmha').show()
		$('#ivcontact-contactmode').hide()
		$('#ivcontact-disruption').show()
	else if v == 2  	# Required/other
		$('#ivcontact-milestone').show()
		$('#ivcontact-pdsa').show()
		$('#ivcontact-gyr').show()
		$('#ivcontact-tier').hide()
		$('#ivcontact-pcmha').hide()
		$('#ivcontact-disruption').hide()
		$('#ivcontact-contactmode').show()
	else if v == 9		# Ad-hoc contact/blank
		$('#ivcontact-milestone').hide()
		$('#ivcontact-pdsa').hide()
		$('#ivcontact-gyr').hide()
		$('#ivcontact-tier').hide()
		$('#ivcontact-pcmha').hide()
		$('#ivcontact-disruption').hide()
		$('#ivcontact-contactmode').show()
	else							# Blank
		$('#ivcontact-milestone').hide()
		$('#ivcontact-pdsa').hide()
		$('#ivcontact-gyr').hide()
		$('#ivcontact-tier').hide()
		$('#ivcontact-pcmha').hide()
		$('#ivcontact-disruption').hide()
		$('#ivcontact-contactmode').hide()

updateDisruptionTime = (contact_specific_field) ->
	v = parseInt($(contact_specific_field).val())
	if v == 1  																	# Baseline/1st Quarter
		$('#ivcontact-disruption-3').hide()
		$('#ivcontact-disruption-12').show()
	else if v == 2 | v == 3 | v == 4 | v == 5  	# 2nd-5th Quarter
		$('#ivcontact-disruption-3').show()
		$('#ivcontact-disruption-12').hide()
	else																				# Blank
		$('#ivcontact-disruption-3').hide()
		$('#ivcontact-disruption-12').hide()

updateQICA = (contact_type_field, contact_specific_field) ->
	contactType = parseInt($(contact_type_field).val())
	contactSpecific = parseInt($(contact_specific_field).val())
	if contactType == 1										# In-person visit
		if contactSpecific == 1	| contactSpecific == 4		# 1st & 4th visits
			$('#ivcontact-pcmha').show()
		else																# Other visits or Blank
			$('#ivcontact-pcmha').hide()
	else
		$('#ivcontact-pcmha').hide()

updateStaffMemberSurvey = (contact_type_field, contact_specific_field) ->
	contactType = parseInt($(contact_type_field).val())
	contactSpecific = parseInt($(contact_specific_field).val())
	if contactType == 1										# In-person visit
		if contactSpecific == 1	| contactSpecific == 5		# 1st & 5th visits
			$('#ivcontact-smsvy').show()
		else																# Other visits or Blank
			$('#ivcontact-smsvy').hide()
	else
		$('#ivcontact-smsvy').hide()

updateHIT = (contact_type_field, contact_specific_field) ->
	contactType = parseInt($(contact_type_field).val())
	contactSpecific = parseInt($(contact_specific_field).val())
	if contactType == 1										# In-person visit
		if contactSpecific == 1							# 1st visit
			$('#ivcontact-hit').show()
			$('#ivcontact-hit-vendor').show()
			$('#ivcontact-hit-tier').show()
		else if contactSpecific == 5				# 5th visit
			$('#ivcontact-hit').show()
			$('#ivcontact-hit-vendor').hide()
			$('#ivcontact-hit-tier').hide()
		else																# Other visits or Blank
			$('#ivcontact-hit').hide()
	else
		$('#ivcontact-hit').hide()

updateHITQuality = (hit_quality_field) ->
	hitQuality = parseInt($(hit_quality_field).val())
	if hitQuality == 3	| hitQuality == 4		# "Somewhat" or "Not confident"
		$('#ivcontact-hit-quality-explain').show()
	else																		# "Very", "Confident" or blank
		$('#ivcontact-hit-quality-explain').hide()

updateEHRWhich = (contact_type_field, contact_specific_field, new_ehr) ->
	contactType = parseInt($(contact_type_field).val())
	contactSpecific = parseInt($(contact_specific_field).val())
	if document.getElementById(new_ehr)
		if document.getElementById(new_ehr).checked
			if contactType == 1										# In-person visit
				if contactSpecific == 1								# 1st visit
					$('#ivcontact-ehr-which').show()
				else																# Other visits or Blank
					$('#ivcontact-ehr-which').hide()
			else
				$('#ivcontact-ehr-which').hide()
		else
			$('#ivcontact-ehr-which').hide()
	else
		$('#ivcontact-ehr-which').hide()

updateCheckbox = (checkbox_id, appear_id) ->
	if document.getElementById(checkbox_id)
		if document.getElementById(checkbox_id).checked
			$(appear_id).show()
		else
			$(appear_id).hide()

$(document).on "page:change", ->
	updateContactType('#ivcontact_contact_type')
	updateDisruptionTime('#contact_specific_calculated')
	updateQICA('#ivcontact_contact_type', '#contact_specific_calculated')
	updateHIT('#ivcontact_contact_type', '#contact_specific_calculated')
	updateHITQuality('#ivcontact_hit_quality')
	updateStaffMemberSurvey('#ivcontact_contact_type', '#contact_specific_calculated')
	updateEHRWhich('#ivcontact_contact_type', '#contact_specific_calculated', 'ivcontact_prac_change_ehr')
	updateCheckbox('ivcontact_topic_other', '#ivcontact-topicotherspecify')
	updateCheckbox('ivcontact_prac_change_other', '#ivcontact-pracchangespecify')

$(document).on "page:change", ->
	$('#ivcontact_contact_type').on 'change',  ->
		updateContactType('#ivcontact_contact_type')
		updateQICA('#ivcontact_contact_type', '#contact_specific_calculated')
		updateHIT('#ivcontact_contact_type', '#contact_specific_calculated')
		updateStaffMemberSurvey('#ivcontact_contact_type', '#contact_specific_calculated')

$(document).on "page:change", ->
	$('#ivcontact_topic_other').on 'click',  ->
		updateCheckbox('ivcontact_topic_other', '#ivcontact-topicotherspecify')

$(document).on "page:change", ->
	$('#ivcontact_prac_change_ehr').on 'click',  ->
		updateEHRWhich('#ivcontact_contact_type', '#contact_specific_calculated', 'ivcontact_prac_change_ehr')

$(document).on "page:change", ->
	$('#ivcontact_hit_quality').on 'click',  ->
		updateHITQuality('#ivcontact_hit_quality')

$(document).on "page:change", ->
	$('#ivcontact_prac_change_other').on 'click',  ->
		updateCheckbox('ivcontact_prac_change_other', '#ivcontact-pracchangespecify')

$(document).on "page:change", ->
	$('#ivcontact-tier1').on 'click', ->
		$('#tier1').dialog(
			closeText: "",
			width: 450
		)
		$('#tier1').dialog('open')
	$('#ivcontact-tier2').on 'click', ->
		$('#tier2').dialog(
			closeText: "",
			width: 450
		)
		$('#tier2').dialog('open')
	$('#ivcontact-tier3').on 'click', ->
		$('#tier3').dialog(
			closeText: "",
			width: 450
		)
		$('#tier3').dialog('open')
	$('#ivcontact-tier4').on 'click', ->
		$('#tier4').dialog(
			closeText: "",
			width: 450
		)
		$('#tier4').dialog('open')

$(document).on "page:change", ->
	$('#tier-tooltip').tooltip()
	$("#hlc-tooltip label").each ->
		if $(this).hasClass("priority1")
			$(this).attr('title', "Use when a practice has decided that a particular HLC was not a priority for them and/or have been intentional about not working on this HLC during the time since your last required contact. This rating can be made at any time during your work with the practice.")
		if $(this).hasClass("priority2")
			$(this).attr('title', "Use when practice has articulated intent to work on an HLC but since you last met with them has either made no progress, very minor progress, or is still in the planning/brainstorming phase and has not tested any of their planned changes.")
		if $(this).hasClass("priority3")
			$(this).attr('title', "Use when a practice has been completing agreed upon actions, running PDSA cycles, training staff and/or other activities that are clearly contributing to a knowledge/culture change in the practice around this HLC.")
		if $(this).hasClass("priority4")
			$(this).attr('title', "Use when a practice already has all the systems in place to carry out the HLC on a consistent basis and has no plans for further changes or testing at this point.")
		$(this).tooltip({
			position: {
				my: 'left+15 bottom-30',
				at: 'left bottom'
			}
		})

$(document).on "page:change", ->
	$("#personnel-wrapper").on 'click', '.delete-ivcontact-personnel-button', ->
		$(this).parents(".deletable").remove()

$(document).on "page:change", ->
	$("#add-ivcontact-personnel-button").on 'click', ->
		content = $("#add-ivcontact-personnel-content").html()
		$("#add-ivcontact-personnel-wrapper").before(content)

$(document).on "page:change", ->
	$('#new_ivcontact').validate({
		rules: {
			"ivcontact[contact_dt]": "required"
		}
	})

# Save newly added staff and add the staff member to the DOM
$(document).on "page:change", ->
	$("#add-staff-button").on 'click', ->
		$.ajax
			url: '/personnels'
			type: 'POST'
			data: { personnel: { practice_id: $('#coach-personnel-practice').val(), name: $('#coach-personnel-name').val(), role: $('#coach-personnel-role').val() } }
			dataType: 'json'
			error: (jqXHR, textStatus, errorThrown) ->
				$('#staffPopupMessage').html("Name is required. Cannot save staff member.")
			success: (data, textStatus, jqXHR) ->
				$('#popupForm').fadeOut 'fast'
				$('#staffPopupMessage').html("")
				$('#coach-personnel-name').val("")
				$('#coach-personnel-role').val("")
				$('#openPopupForm').before("<li><input type='checkbox' name='ivcontact[personnels][#{data.id}]' id='ivcontact_personnels_#{data.id}' value='1' checked /> <label for='ivcontact_personnels_#{data.id}'>#{data.name} (#{data.role_name})</label></li>")