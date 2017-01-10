# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  console.log 'done'
  taskId = $('.task').attr('task-id')
  userId = $('.task').attr('user-id')
  hasTimer = false
  $('.start-timer-btn').click ->
    hasTimer = true
    $('.timer').timer 'start'
    $(this).addClass 'hide'
    $('.pause-timer-btn, .remove-timer-btn').removeClass 'hide'
    return
  # Init timer resume
  $('.resume-timer-btn').on 'click', ->
    console.log 'resuming...'
    $('.timer').timer seconds: $('.timer').text()
    $('.aux_text').addClass 'hide'
    $(this).addClass 'hide'
    $('.pause-timer-btn, .remove-timer-btn').removeClass 'hide'
    $.ajax
      url: '/users/' + userId + '/tasks/' + taskId + '/set_state_tracking'
      type: 'POST'
      dataType: 'json'
      data: 'state': 'open'
      success: (data) ->
        console.log 'successfully ' + data
        return
    return
  # Init timer pause
  $('.pause-timer-btn').on 'click', ->
    $('.timer').timer 'pause'
    $(this).addClass 'hide'
    $('.resume-timer-btn').removeClass 'hide'
    $.ajax
      url: '/users/' + userId + '/tasks/' + taskId + '/set_time_tracking'
      type: 'POST'
      dataType: 'json'
      data:
        'duration': $('.timer').data('seconds')
        'state': 'paused'
      success: (data) ->
        console.log 'successfully ' + data
        return
    return
  # Remove timer
  $('.remove-timer-btn').on 'click', ->
    $('.timer').timer 'pause'
    $(this).addClass 'hide'
    $('.pause-timer-btn, .resume-timer-btn').addClass 'hide'
    $.ajax
      url: '/users/' + userId + '/tasks/' + taskId + '/set_time_tracking'
      type: 'POST'
      dataType: 'json'
      data:
        'duration': $('.timer').data('seconds')
        'state': 'closed'
      success: (data) ->
        console.log 'successfully ' + data
        return
    return
  return