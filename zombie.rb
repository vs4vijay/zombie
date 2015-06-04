# zombie.rb
require 'sinatra'

enable :sessions
set :public_folder, File.dirname(__FILE__) + '/'
#set :views, settings.root + '/templates'

use Rack::Lint
# use Rack::Auth::Basic do |username, password|
#   username == 'admin' && password == 'admin'
# end

get '/' do
  'Hello Zombies!'
end

get '/login' do
  'render some login page'
end

post '/login' do
  if params['username'] == 'admin' && params['password'] == 'admin'
    sessions['username'] = params['username']
  else
    redirect '/login'
  end
end

get '/code' do
  code = "<%= Time.now %>"
  erb code
end

get '/json' do
  render json: {hi: 1}
end

get '/hamlviz' do
  haml :hamlviz
end

get '/halt' do
  halt 401, 'go away!'
end

get '/custom' do
  status 418
  headers "Allow"   => "BREW, POST, GET, PROPFIND, WHEN"
  body "I'm a tea pot!"
end

get '/stream' do
  stream do |out|
    out << "It's gonna be legen -\n"
    sleep 0.5
    out << " (wait for it) \n"
    sleep 1
    out << "- dary!\n"
  end
end

get '/batman' do
  send_file 'images/batman.jpg'
end

get '/attachment' do
  attachment 'images/batman.jpg'
end

get '/request' do
  p request
  status 200
  body request
end

get '/create/:url' do
  url = Sinatra.new do
    get('/jazz') { 'url response at runtime' }
  end
  url.run!
end

not_found do
  'This is nowhere to be found custom message.'
end

get '/secret' do
  403
end

error 403 do
  'Access forbidden for Zombies'
end

__END__

@@ layout
%html
  = yield

@@ hamlviz
%div.title Hello world.
