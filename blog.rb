require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello!"			
end

get '/new' do
	erb :new
end

get '/posts' do
	erb "Posts"
end


post '/new' do
	
	@newpost=params[:newpost]
	erb "You wrote: #{@newpost}"
	
end
