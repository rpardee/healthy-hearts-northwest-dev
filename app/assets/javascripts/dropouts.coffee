# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

updateDropoutReentry = () ->
	v = $("#practice_active").val()
	if v == "true"						# Update practice to active
		$("#drop-dt").hide()
		$("#drop-reentry-dt").show()
	else if v == "false"			# Update practice to inactive
		$("#drop-dt").show()
		$("#drop-reentry-dt").hide()

updateDropoutType = () ->
	v = parseInt($("#practice_drop_determine").val())
	if v == 1					# Practice not responding to coaches
		$("#drop-not-responding").show()
		$("#drop-notified").hide()
		$("#drop-staff-decision").hide()
	else if v == 2		# Practice notified coach
		$("#drop-not-responding").hide()
		$("#drop-notified").show()
		$("#drop-staff-decision").hide()
	else if v == 3		# H2N staff decision
		$("#drop-not-responding").hide()
		$("#drop-notified").hide()
		$("#drop-staff-decision").show()
	else							# Blank
		$("#drop-not-responding").hide()
		$("#drop-notified").hide()
		$("#drop-staff-decision").hide()

$(document).on "page:change", ->
	updateDropoutReentry()
	updateDropoutType()
	$('#practice_drop_determine').on 'change',  ->
		updateDropoutType()
