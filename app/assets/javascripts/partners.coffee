# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Surface ability to change Partner
$(document).on('click', '#displayData', ( ->
	$('#displayData').hide()
	$('#selectData').fadeIn 'fast'
))

# Update Partner change
updateDisplay = () ->
	partnerId = $('#selectData option:selected').val()
	window.location.href = '/partners/'.concat(partnerId)

updateDisplayOriginal = () ->
	$('#displayData').text($('#data-select option:selected').text())
	$('#selectData').hide()
	$('#displayData').fadeIn 'fast'

$(document).on('change', '#selectData', ( ->
	updateDisplay()
))
