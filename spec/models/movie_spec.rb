require 'spec_helper'

describe Movie do

	describe 'director search' do
    before(:each) do
      @hit_1 = Movie.create(:title=>"Hit 1", :director => "A")
      @hit_2 = Movie.create(:title=>"Hit 2", :director => "A")
      @miss_1 = Movie.create(:title=>"Miss 1", :director => "B")
      @miss_2 = Movie.create(:title=>"Miss 2", :director => nil)
    end

    it 'returns list of movies with same director as self' do
      @hit_1.director_search.sort.should eq [@hit_1, @hit_2]
    end

    it 'returns no movies if director is empty' do
      @miss_2.director_search.should be_nil
    end

  end
end      
