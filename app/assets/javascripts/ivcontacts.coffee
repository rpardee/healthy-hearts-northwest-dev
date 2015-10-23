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
		$('#ivcontact-disruption').show()
		$('#ivcontact-contactmode').hide()
		# $('#ivcontact-contactspecific').show()
		# $('#ivcontact_contact_specific').val($('#contact_specific_calculated').val())
	else if v == 2  	# Required/monthly call
		$('#ivcontact-milestone').show()
		$('#ivcontact-gyr').show()
		$('#ivcontact-tier').hide()
		$('#ivcontact-pcmha').hide()
		$('#ivcontact-disruption').hide()
		$('#ivcontact-contactmode').hide()
		# $('#ivcontact-contactspecific').hide()
		# $('#ivcontact_contact_specific').val(0)
	else if v == 3  	# Required/other
		$('#ivcontact-milestone').show()
		$('#ivcontact-gyr').show()
		$('#ivcontact-tier').hide()
		$('#ivcontact-pcmha').hide()
		$('#ivcontact-disruption').hide()
		$('#ivcontact-contactmode').show()
		# $('#ivcontact-contactspecific').hide()
		# $('#ivcontact_contact_specific').val(0)
	else if v == 9		# Ad-hoc contact/blank
		$('#ivcontact-milestone').hide()
		$('#ivcontact-gyr').hide()
		$('#ivcontact-tier').hide()
		$('#ivcontact-pcmha').hide()
		$('#ivcontact-disruption').hide()
		$('#ivcontact-contactmode').show()
		# $('#ivcontact-contactspecific').hide()
		# $('#ivcontact_contact_specific').val(0)
	else							# Blank
		$('#ivcontact-milestone').hide()
		$('#ivcontact-gyr').hide()
		$('#ivcontact-tier').hide()
		$('#ivcontact-pcmha').hide()
		$('#ivcontact-disruption').hide()
		$('#ivcontact-contactmode').hide()
		# $('#ivcontact-contactspecific').hide()
		# $('#ivcontact_contact_specific').val(0)

updateDisruptionTime = (contact_specific_field) ->
	v = parseInt($(contact_specific_field).val())
	if v == 1  																	# Baseline/1st Quarter
		$('#ivcontact-disruption-3').hide()
		$('#ivcontact-disruption-12').show()
		$('#ivcontact-disruption-warning').hide()
	else if v == 2 | v == 3 | v == 4 | v == 5  	# 2nd-5th Quarter
		$('#ivcontact-disruption-3').show()
		$('#ivcontact-disruption-12').hide()
		$('#ivcontact-disruption-warning').hide()
	else																				# Blank
		$('#ivcontact-disruption-3').hide()
		$('#ivcontact-disruption-12').hide()
		$('#ivcontact-disruption-warning').show()

updateCheckbox = (checkbox_id, appear_id) ->
	if document.getElementById(checkbox_id)
		if document.getElementById(checkbox_id).checked
			$(appear_id).show()
		else
			$(appear_id).hide()

$(document).on "page:change", ->
	updateContactType('#ivcontact_contact_type')
	updateDisruptionTime('#ivcontact_contact_specific')
	updateCheckbox('ivcontact_topic_other', '#ivcontact-topicotherspecify')
	updateCheckbox('ivcontact_prac_change_other', '#ivcontact-pracchangespecify')

$(document).on "page:change", ->
	$('#ivcontact_contact_type').on 'change',  ->
		updateContactType('#ivcontact_contact_type')

$(document).on "page:change", ->
	$('#ivcontact_contact_specific').on 'change',  ->
		updateDisruptionTime('#ivcontact_contact_specific')

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
