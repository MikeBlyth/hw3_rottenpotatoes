require 'spec_helper'

describe MoviesController do
  describe "routing" do

		it "routes to director_search" do
			get("/director_search/1").should route_to("movies#director_search", :id=>'1')
 		end
  end

end
