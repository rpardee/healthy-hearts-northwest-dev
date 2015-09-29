# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('click', '#openPopupForm', ( ->
	$('#popupForm').fadeIn 'fast'
))

$(document).on('click', '#closePopupForm', ( ->
	$('#popupForm').fadeOut 'fast'
))

$(document).on "page:change", ->
	$('table.enable-data-table')
		.addClass("compact hover stripe")
		.dataTable( {
			"paging": false,
			"info": false,
			stateSave: true
		})

$(document).on "page:change", ->
	$('input.datepicker').datepicker()

$(document).on "page:change", ->
	$('nav').sticky({ topSpacing: 50 })

enableObjectIf = (selectorObject, value, effectorName) ->
	effector = $(effectorName)
	v = parseInt($(selectorObject).val())
	if v == value
		$(effector).removeAttr('disabled')
	else
		$(effector).attr('disabled', true)

$(document).on "page:change", ->
	$('.enable-control').each (index, element) =>
		if $(element).is("input")
			value = +$(element).prop("checked")
		else
			value = $(element).data('enablevalue')
		effectorName = $(element).data('effector')
		enableObjectIf($(element), value, effectorName)

$(document).on "page:change", ->
	$('.enable-control').on 'change',  ->
		value = $(this).data('enablevalue')
		effectorName = $(this).data('effector')
		enableObjectIf($(this), value, effectorName)

$(document).on "page:change", ->
	$('.timefield').mask('99:99 aa')