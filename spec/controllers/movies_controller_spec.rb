require 'spec_helper'

describe MoviesController, :type => :controller do
  describe "director search" do
	
    it "calls Movie.director_search with movie id" do
      Movie.should_receive(:director_search).with('1')
      get :director_search, :id=>'1'
    end

    it 'renders the director search template' do
      Movie.stub(:director_search)
      get :director_search, :id=>'1'
      response.should render_template('director_search')
    end

    it 'passes movies list to template' do
      list = mock('Movies List')
      Movie.stub(:director_search).and_return(list)
      get :director_search, :id=>'1'
      assigns(:movies).should eq list
    end

  end
end
