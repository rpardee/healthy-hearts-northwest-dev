# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('click', '#openPopupForm', ( ->
	$('#popupForm').fadeIn 'fast'
))

$(document).on('click', '#closePopupForm', ( ->
	$('#popupForm').fadeOut 'fast'
))

$(document).ready ->
	$('table.enable-data-table')
		.addClass("compact hover stripe")
		.dataTable( {
			"paging": false,
			"info": false,
			stateSave: true
		})

$(document).ready ->
	$('input.datepicker').datepicker()

$(document).ready ->
	$('nav').sticky({ topSpacing: 50 })

enableObjectIf = (selectorObject, value, effectorName) ->
	effector = $(effectorName)
	v = parseInt($(selectorObject).val())
	if v == value
		$(effector).removeAttr('disabled')
	else
		$(effector).attr('disabled', true)

$(document).ready ->
	$('.enable-control').each (index, element) =>
		value = $(element).data('enablevalue')
		effectorName = $(element).data('effector')
		enableObjectIf($(element), value, effectorName)

$(document).ready ->
	$('.enable-control').on 'change',  ->
		value = $(this).data('enablevalue')
		effectorName = $(this).data('effector')
		enableObjectIf($(this), value, effectorName)

$(document).ready ->
	$('.timefield').mask('99:99 aa')