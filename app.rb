require "sinatra"
require 'sinatra/activerecord'
enable :sessions

require 'active_record'
# set :database, "sqlite3:goat.sqlite3"
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])



get '/' do
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
  user = User.find_by(email: email)
  if user.password == given_password
    session[:user] = user
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
p @user = session[:user]
post_owner = session[:user]
p @my_post = Post.where(owner: post_owner.first_name)

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
    category: params[:category],
    title: params[:title],
    playerOne: params[:playerone],
    playerOne_img: params[:p1_url],
    p1_statOne: params[:p1_statOne],
    p1_statTwo: params[:p1_statTwo],
    p1_statThree: params[:p1_statThree],
    playerTwo: params[:playertwo],
    playerTwo_img: params[:p2_url],
    p2_statOne: params[:p2_statOne],
    p2_statTwo: params[:p2_statTwo],
    p2_statThree: params[:p2_statThree],
    playerThree: params[:playerthree],
    playerThree_img: params[:p3_url],
    p3_statOne: params[:p3_statOne],
    p3_statTwo: params[:p3_statTwo],
    p3_statThree: params[:p3_statThree],
    content: params[:content],
    owner: session[:user].first_name
  )
  p post.owner

  post.user = author

  post.save

  redirect :account
end

get '/timeline' do
  user = session[:user].id
  @all_post = Post.where.not(user_id: user)
  erb :timeline
end

get '/settings' do

  erb :settings
end

get '/delete' do
  current = session[:user].id
  user = User.find_by(id: current)
  user.destroy
  session[:user] = nil
  redirect '/'
end

require "./models"
