$ ->
  faye = new Faye.Client('http://localhost:9292/faye')
  id = $('#game_online').data('game_id')
  faye.subscribe('/online_game/' + id, (data) ->
    eval(data)
  )