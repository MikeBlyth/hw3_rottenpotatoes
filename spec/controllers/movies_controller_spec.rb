require 'spec_helper'

describe MoviesController do
  describe "director search" do
	
    it "calls Movie.director_search with movie id" do
      Movie.should_receive(:director_search).with('1')
      controller.get :director_search, :id=>'1'
    end
  end
end
