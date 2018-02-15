# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('.timepicker').pickatime
    default: 'now'
    fromnow: 0
    twelvehour: false
    donetext: 'OK'
    cleartext: 'Clear'
    canceltext: 'Cancel'
    autoclose: false
    ampmclickable: true
    aftershow: ->
  return