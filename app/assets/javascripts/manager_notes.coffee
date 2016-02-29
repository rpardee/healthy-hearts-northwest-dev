# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
	$('table.enable-data-table-sort-col3')
		.addClass("compact hover stripe")
		.DataTable( {
			"paging": true,
			"info": true,
			"lengthMenu": [ 25, 100, 250 ],
			"order": [[ 2, 'desc' ]],
			retrieve: true,
			stateSave: true
		})