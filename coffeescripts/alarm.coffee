$ ->
  alarmTime = new Date(window.lmka.miliseconds)
  console.log alarmTime
  hour = alarmTime.getHours() % 12
  hour = 12 if hour is 0
  minutes = alarmTime.getMinutes()
  if minutes < 10
    timeString = "#{hour}:0#{minutes}"
  else
    timeString = "#{hour}:#{minutes}"
  
  #update the document title
  window.document.title = timeString
  
  #update the header on the page
  $('.alarm-time').text(timeString)

  #create a new web worker to run the time checker
  worker = new Worker('javascripts/webworker.js')
  
  #remind the user when webworker decides time is good
  worker.onmessage = (e)->
    console.log(e.data)
    alert("Reminding you!")
    worker.terminate()

  #hand off the target time to the worker
  worker.postMessage(window.lmka.miliseconds)
