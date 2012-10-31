Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  match '/director_search/:id', :action => :director_search, :controller => :movies, :as => :director_search
  root :to => redirect('/movies')
end
