class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.director_search(id)
    base = Movie.find(id)
    return nil if base.nil? || base.director.blank?
    Movie.where('director = ?', base.director)
  end

end
