class User < ApplicationRecord
  has_many :reviews
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.most_reviews
    User.select('users.*, count(reviews.id) as num_reviews')
        .left_outer_joins(:reviews)
        .group('users.id')
        .order("num_reviews desc")
        .first(3)
  end

  def sort_by_oldest
    reviews.order(created_at: :desc)
  end

  def sort_by_newest
    reviews.order(created_at: :asc)
  end
end
