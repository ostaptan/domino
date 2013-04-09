# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  faye = new Faye.Client('http://localhost:9292/faye')
  faye.subscribe('/general-chat-channel', (data) ->
    eval(data)
  )
