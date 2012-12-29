require 'sinatra'
require 'haml'

get '/' do
  haml :index
end

get '/:time' do
  t = params[:time]
  if t.match(/min|hour|day/)
    @add = true
    minutes = t.slice(/\d+(?=min)/).to_i
    hours = t.slice(/\d+(?=hour)/).to_i
    @seconds = hours * 3600 + minutes * 60
  else
    @add = false
    stripped_number = t.scan(/\d/).join.to_i
    minutes = (stripped_number > 99) ? stripped_number%100 : 0
    hours = (stripped_number > 99) ? stripped_number/100 : stripped_number
    @seconds = hours * 3600 + minutes * 60
  end
  haml :alarm
end
