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

