#set up the target time object

today = new Date()
if window.lmka.urlTimeAdd
  timeAdd = window.lmka.hours*3600000 + window.lmka.minutes*60000 
  target = new Date(today.getTime() + timeAdd)
else
  target = new Date today.getFullYear(),
                    today.getMonth(),
                    today.getDate(),
                    window.lmka.hours,
                    window.lmka.minutes, 
                    0,
                    0

#generate the time string 
if target.getMinutes() < 10
    minuteString = "0#{target.getMinutes()}"
else
    minuteString = target.getMinutes()

if target.getHours() == 0 or target.getHours() == 12
  hourString = '12'
else
  hourString = target.getHours()%12

if target.getHours() < 12
  meridiumString = "am"
else
  meridiumString = "pm"

timeString = "#{hourString}:#{minuteString}#{meridiumString}"

#logging cuz I'm a bad person
console.log("current time: #{today}")
console.log("target time: #{target}")

$ ->
  #update the document title
  window.document.title = timeString
  
  #update the header on the page
  $('.alarm-time').text(timeString)

  #create a new web worker to run the time checker
  worker = new Worker('javascripts/webworker.js')
  
  #remind the user when webworker decides time has come
  worker.onmessage = (e)->
    reminderText = $('.reminder').val()
    if reminderText == ""
      alert("Letting you know that it's now #{timeString}!")
    else
      alert("Letting you know, it's now #{timeString}!\n#{reminderText}")
    worker.terminate()

  #hand off the target time to the worker
  worker.postMessage(target.getTime())
