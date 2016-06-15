# Homepage (Root path)
enable :sessions

helpers do

  def current_user
    @current_user ||= User.find_by username: session["username"] if session["username"] 
  end


  def logged_in?
    if session["username"]
      current_user
      if @current_user
        true
      end
    else
      false
    end
  end

  def voted?(current_track_id)
    current_user
    if Upvote.where(user_track_id: "#{current_user.id}-#{current_track_id}").exists?
      true
    else
      false
    end
  end

  def reviewed?(current_track_id)
    current_user
    if Review.where(user_track_id: "#{current_user.id}-#{current_track_id}").exists?
      true
    else
      false
    end    
  end

  # def total_votes(current_track_id)
  #   Upvote.where("tracks_id = ?", [current_track_id]).count
  # end

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
    author: params[:author],
    submitter: session["username"]
    )
  if @track.save
    redirect '/tracks'
  end
end

get '/tracks/new' do
  erb :'tracks/new'
end

get '/tracks/:id' do
  @track = Track.find params[:id]
  @reviews = Review.where track_id: params[:id]
  erb :'tracks/show'
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
  current_user

  if params[:password] && params[:password] == current_user.password
    session["username"] = current_user.username
    redirect '/tracks'
  else
    # TODO flash user error that the passwords do not match
    erb :'user/index'
  end
end

post '/logout' do
  session["username"] = nil
  redirect '/signup'
end

post '/vote' do
  current_user  
  @current_track = Track.find(params[:track_id])
  @vote = @current_track.upvotes.build(
    user_track_id: "#{current_user.id}-#{@current_track.id}",
    user: current_user
    )
  if @vote.save
    redirect '/tracks'
  end
end

# is this correct? 
# => not sure how/where to get @reviews 
# => in order to make it accessible to the templates!
get '/reviews' do
  @reviews = Review.all
  erb :'tracks/index'
end

post '/review' do
  current_user
  @current_track = Track.find(params[:track_id])
  @review = current_user.reviews.build(
    content: params[:content],
    user_track_id: "#{current_user.id}-#{@current_track.id}",
    track: @current_track
    )
  if @review.save
    redirect '/tracks/:track_id'
  end
end

post '/reviews/:id' do
  @review = Review.find params[:id]
  @review.destroy
  redirect '/tracks'
end
