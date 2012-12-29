# respond on message that hands off the target time
@onmessage = (e)->
  target = new Date(e.data)
  postMessage(target)

  # check the time every second
  setInterval ->
    now = new Date()
    if now > target
      postMessage('done')
  ,1000
