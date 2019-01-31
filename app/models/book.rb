class Book < ApplicationRecord
  has_many :author_books
  has_many :authors, through: :author_books
  has_many :reviews

  def self.sort_by_pages
    Book.order(:pages)
  end

  def self.sort_by_pages_desc
    Book.order(pages: :desc)
  end

  def self.sort_by_rating
    # binding.pry
    Book.select('books.id, avg(reviews.rating)').joins(:reviews).group('books.id').order('avg(review.rating)')
  end

  def self.sort_by_rating_desc
  end

  def self.sort_by_review_number
  end

  def self.sort_by_review_number_desc
  end
end
