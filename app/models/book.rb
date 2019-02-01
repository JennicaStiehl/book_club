class Book < ApplicationRecord
  has_many :author_books
  has_many :authors, through: :author_books
  has_many :reviews

  def top_reviews
    reviews.order(rating: :desc).limit(3)
  end

  def bottom_reviews
    reviews.order(:rating).limit(3)
  end

  def average_rating
    reviews.average(:rating)
  end
end
