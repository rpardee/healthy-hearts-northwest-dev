# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

updateContactType = (contact_type_field) ->
	v = parseInt($(contact_type_field).val())
	if v == 1  				# Required/in-person
		$('#ivcontact-milestone').show()
		$('#ivcontact-gyr').show()
		$('#ivcontact-tier').show()
		$('#ivcontact-pcmha').show()
		$('#ivcontact-contactmode').hide()
		$('#ivcontact-disruption').show()
	else if v == 2  	# Required/monthly call
		$('#ivcontact-milestone').show()
		$('#ivcontact-gyr').show()
		$('#ivcontact-tier').hide()
		$('#ivcontact-pcmha').hide()
		$('#ivcontact-disruption').hide()
		$('#ivcontact-contactmode').hide()
	else if v == 3  	# Required/other
		$('#ivcontact-milestone').show()
		$('#ivcontact-gyr').show()
		$('#ivcontact-tier').hide()
		$('#ivcontact-pcmha').hide()
		$('#ivcontact-disruption').hide()
		$('#ivcontact-contactmode').show()
	else if v == 9		# Ad-hoc contact/blank
		$('#ivcontact-milestone').hide()
		$('#ivcontact-gyr').hide()
		$('#ivcontact-tier').hide()
		$('#ivcontact-pcmha').hide()
		$('#ivcontact-disruption').hide()
		$('#ivcontact-contactmode').show()
	else							# Blank
		$('#ivcontact-milestone').hide()
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

updateCheckbox = (checkbox_id, appear_id) ->
	if document.getElementById(checkbox_id)
		if document.getElementById(checkbox_id).checked
			$(appear_id).show()
		else
			$(appear_id).hide()

$(document).on "page:change", ->
	updateContactType('#ivcontact_contact_type')
	updateDisruptionTime('#contact_specific_calculated')
	updateCheckbox('ivcontact_topic_other', '#ivcontact-topicotherspecify')
	updateCheckbox('ivcontact_prac_change_other', '#ivcontact-pracchangespecify')

$(document).on "page:change", ->
	$('#ivcontact_contact_type').on 'change',  ->
		updateContactType('#ivcontact_contact_type')

$(document).on "page:change", ->
	$('#ivcontact_topic_other').on 'click',  ->
		updateCheckbox('ivcontact_topic_other', '#ivcontact-topicotherspecify')

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
		$(this).tooltip()

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
