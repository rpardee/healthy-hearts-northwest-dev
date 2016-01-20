# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  $('#coach-practice-comment-opener').on 'click', ->
    $('#contact-comments').dialog(
      closeText: "",
      minWidth: 800,
      show: { effect: "fadeIn", delay: 100 },
      resizable: false,
      create: ->
        closeBtn = $('.ui-dialog-titlebar-close')
        closeBtn.css({ "position": "absolute", "right": "10px" })
    )