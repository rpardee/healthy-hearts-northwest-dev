# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

updateContactType = (contact_type_field) ->
	alert parseInt($(contact_type_field).val())
	v = parseInt($(contact_type_field).val())
	if v == 1  				# Required/in-person
		$('#ivcontact-milestone').removeAttr('disabled')
	else if v == 2  	# Required/monthly call
		$('#ivcontact-milestone').removeAttr('disabled')
	else							# Ad-hoc contact/blank
		$('#ivcontact-milestone').attr('disabled', true)

$(document).ready ->
	updateContactType('#ivcontact_contact_type')

$(document).ready ->
	$('#ivcontact_contact_type').on 'change',  ->
		updateContactType('#ivcontact_contact_type')
