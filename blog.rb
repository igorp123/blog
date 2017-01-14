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
	@posts_list = @db.execute 'select * from Posts order by id desc' 
	erb :index

end

get '/new' do
	erb :new
end


post '/new' do
	
	@newpost=params[:newpost].strip

	if @newpost.length == 0
		@error = 'Enter your post please...'
		return erb :new
	end
	
	@db.execute 'insert into Posts (created_date, post) values(datetime(),?)', [@newpost]

	redirect '/'
	
end
