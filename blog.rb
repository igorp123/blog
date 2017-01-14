require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'


def init_db
	@db=SQLite3::Database.new 'blog.db'
	@db.results_as_hash=true
end

before do
	init_db
end

configure do
	init_db
	@db.execute 'create table if not exists Posts
  		(
  			id integer primary key autoincrement,
  			created_date date, 
  			post text
   		)'
end

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
	
	@db.execute 'insert into Posts (created_date, post) values(datetime(),?)', [@newpost.strip]

	erb "You wrote: #{@newpost}"
	
end
