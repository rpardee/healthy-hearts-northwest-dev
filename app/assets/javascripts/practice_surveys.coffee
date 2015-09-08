# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$( "#progressbar" ).progressbar({
	  value: $( "#progress-value-set" ).data( 'progress-value' )
	});

$( "#progress-value" ).val($( "#progress-value-set" ).data( 'progress-value' ))