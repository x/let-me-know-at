require 'sinatra'
require 'haml'

get '/' do
  haml :index
end

get '/:time' do
  t = params[:time]
  if t.match(/min|hour/)
    @add = true
    @minutes = t.slice(/\d+(?=min)/i).to_i
    @hours = t.slice(/\d+(?=hour)/i).to_i
  else
    @add = false
    stripped_number = t.scan(/\d/).join.to_i
    @minutes = (stripped_number > 99) ? stripped_number%100 : 0
    @hours = (stripped_number > 99) ? stripped_number/100 : stripped_number
    if @hours == 12
      unless t.match(/pm/i)
        @hours = 0
      end
    else
      if t.match(/pm/i)
        @hours += 12
      end
    end
  end
  
  if @hours < 24 and @minutes < 60 and t.match(/min|hour|am|pm/)
    haml :alarm
  else
    haml :error
  end
end

get '/:error' do
  haml :error
end
