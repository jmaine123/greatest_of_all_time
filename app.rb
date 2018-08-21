require "sinatra"
require 'sinatra/activerecord'
enable :sessions

set :database, "sqlite3:goat.sqlite3"

get '/' do
  $all_post = Post.all
  erb :home
end

get '/login' do
  erb :login
end

post '/login' do
  email = params['email']
  given_password = params['password']
  #check if email exists
  #check to see if the email has a password == form password
  p user = User.find_by(email: email)
  if user.password == given_password
    p session[:user] = user
    redirect :account
  else
    p "Invalid credentials"
    redirect '/'
  end
end

get '/signup' do
  erb :signup
end

post '/signup' do
  p params
  user = User.new(
    email: params['email'],
    first_name: params['firstname'],
    last_name: params['lastname'],
    password: params['password']
  )
  user.save
  redirect  '/'
end


get '/account' do

erb :account
end

get '/logout' do
  session[:user] = nil
  p 'user has logged out'

  redirect '/'
end

get '/post' do
  erb :post
end

post '/post' do
  author = session[:user]
  post = Post.new(
    title: params[:title],
    content: params[:content],
    image_url: params[:url]
  )
  p post.title

  post.save

  @title = post.title
  @content = post.content
  redirect :post
end

require "./models"
