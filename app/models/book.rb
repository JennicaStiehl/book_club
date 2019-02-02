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

  def coauthors(author)
    authors.where.not(id: author.id)
  end

  def self.sort_by_pages(order)
    Book.order(pages: :"#{order}")
  end

  def self.sort_by_rating(order)
    Book.select('books.*, avg(reviews.rating) as avg_rating').left_outer_joins(:reviews).group('books.id').order("avg_rating #{order}")
  end

  def self.sort_by_review_number(order)
    Book.select('books.*, count(reviews.rating) as num_rating').left_outer_joins(:reviews).group('books.id').order("num_rating #{order}")
  end
end
