class Movie < ActiveRecord::Base
  def self.others_by_same_director director
    Movie.where(:director => director)
  end   
end
