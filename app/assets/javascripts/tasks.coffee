# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  console.log 'done'
  hasTimer = false
  $('.start-timer-btn').click ->
    hasTimer = true
    $('.timer').timer 'start'
    $(this).addClass 'hide'
    $('.pause-timer-btn, .remove-timer-btn').removeClass 'hide'
    return
  # Init timer resume
  $('.resume-timer-btn').on 'click', ->
    $('.timer').timer 'resume'
    $(this).addClass 'hide'
    $('.pause-timer-btn, .remove-timer-btn').removeClass 'hide'
    return
  # Init timer pause
  $('.pause-timer-btn').on 'click', ->
    $('.timer').timer 'pause'
    $(this).addClass 'hide'
    $('.resume-timer-btn').removeClass 'hide'
    taskId = $('.task').attr('task-id')
    userId = $('.task').attr('user-id')
    $.ajax
      url: '/users/' + userId + '/tasks/' + taskId + '/set_time_tracking'
      type: 'POST'
      dataType: 'json'
      data: 'duration': $('.timer').data('seconds')
      success: (data) ->
        console.log 'successfully ' + data
        return
    return
  # Remove timer
  $('.remove-timer-btn').on 'click', ->
    hasTimer = false
    $('.timer').timer 'remove'
    $(this).addClass 'hide'
    $('.start-timer-btn').removeClass 'hide'
    $('.pause-timer-btn, .resume-timer-btn').addClass 'hide'
    return
  return