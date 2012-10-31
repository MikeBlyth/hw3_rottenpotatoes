require 'spec_helper'

describe MoviesController, :type => :controller do
  describe "director search" do
    context 'when movie has director' do	

      it "calls Movie.director_search with movie id" do
        Movie.should_receive(:director_search).with('1').and_return(true)
        get :director_search, :id=>'1'
      end

      it 'renders the director search template' do
        Movie.stub(:director_search => true)
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

    context 'when movie has no director' do
      before(:each) do
        Movie.stub(:director_search => nil)
        Movie.stub_chain(:find, :title => "Title")
      end    

      it 'redirects to home page' do
        get :director_search, :id=>'1'
        response.should redirect_to(movies_path)
      end
    end
  end
end
