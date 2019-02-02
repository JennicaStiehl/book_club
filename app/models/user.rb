class User < ApplicationRecord
  has_many :reviews

  def self.most_reviews
    User.select('users.*, count(reviews.id) as num_reviews')
        .left_outer_joins(:reviews)
        .group('users.id')
        .order("num_reviews desc")
  end
  
end
