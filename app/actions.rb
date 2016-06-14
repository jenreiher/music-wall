# Homepage (Root path)
enable :sessions

helpers do

  def logged_in?(current_user)
    @user = current_user
    if session["username"]
      true
    elsif
      # TODO logic here is wrong? it assumes that there is always a current user when there is not !
      password_correct?(current_user)
      session["username"] = params[:username]
      true
    else
      false
    end
  end

  def password_correct?(current_user)
    if params[:password] && params[:password] == @user.password
      true
    else
      # TODO flash user error
      false
    end
  end

end

get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end

post '/tracks' do
  @track = Track.new(
    url: params[:url],
    song_title: params[:song_title],
    author: params[:author]
    )
  if @track.save
    redirect '/tracks'
  end
end

get '/tracks/new' do
  erb :'tracks/new'
end

post '/signup' do
  @user = User.new(
    username: params[:username],
    email: params[:email],
    email_confirmation: params[:email_confirmation],
    password: params[:password],
    password_confirmation: params[:password_confirmation]
    )

  if @user.save
    redirect '/tracks'
  else
    erb :'user/index'
  end
end

get '/signup' do
  erb :'user/index'
end

post '/login' do
  @user = User.find_by username: params[:username]

  if logged_in?(@user)
    redirect '/tracks'
  else
    erb :'user/index'
  end
end

post '/logout' do
  session["username"] = nil
  redirect '/signup'
end
