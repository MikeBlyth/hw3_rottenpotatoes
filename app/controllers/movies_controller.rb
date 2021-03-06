class MoviesController < ApplicationController
  
  def director_search
    id = params['id']
	  @movies = Movie.director_search(id)
    unless @movies
      flash[:notice] = "'#{Movie.find(id).title}' has no director info"
      redirect_to(movies_path) 
    end
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || session[:ratings] || {}
    @movies = Movie.all
  end

  def new
    # default: render 'new' template
  end

  def create
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
  end

end
