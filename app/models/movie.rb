class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def director_search
    return nil if self.director.blank?
    Movie.where('director = ?', self.director)
  end

end
