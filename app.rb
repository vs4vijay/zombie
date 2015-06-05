# app.rb

require 'sinatra/base'

class App < Sinatra::Application
  get '/' do
    "Hello, World"
  end
end

App.run!
