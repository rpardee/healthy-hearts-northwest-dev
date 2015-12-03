# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
	$("#assign-practice-table").on 'click', '.delete-practice-assignment-button', ->
		$(this).parents(".deletable").remove()

$(document).on "page:change", ->
	$("#add-practice-assignment-button").on 'click', ->
		content = $("#add-practice-assignment-section").html()
		$("#add-practice-assignment-row").before(content)