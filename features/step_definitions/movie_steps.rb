# Add a declarative step here for populating the DB with movies.

def extract_movies
  movie_array = page.html.scan(/<tr>\s?<td>(.*?)<\/td>\s?<td>(.*?)<\/td>/m)
	return movie_array
end

def parse_ratings(rating_list)
    ratings = rating_list.split(/[,;]\s*|\s+/) 
end

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
	ratings = parse_ratings(rating_list)
  if uncheck
    ratings.each {|r| uncheck "ratings_"+r}
  else
    ratings.each {|r| check "ratings_"+r}
  end
#save_and_open_page
end

Then /^I should see all of the movies$/ do
  page.should have_xpath(".//*[@id='movies']/tbody/tr[#{Movie.count+1}]")
end

Then /^I should see all the movies with ratings: (.*)/ do |rating_list|
	ratings = parse_ratings(rating_list)
	extract_movies.map{|movie| movie[0]}.sort.should == 
      Movie.where("rating in (?)", ratings).select(:title).map{|m| m.title}.sort
end

Then /^I should see no movies with ratings: (.*)/ do |rating_list|
	ratings = parse_ratings(rating_list)
  unselected = Movie.where("rating in (?)", ratings).select(:title).map{|m| m.title}
	extract_movies.each{|movie| unselected.should_not include(movie[0]) }
end

