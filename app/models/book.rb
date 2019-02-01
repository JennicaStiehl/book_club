class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year

  has_many :author_books
  has_many :authors, through: :author_books
  has_many :reviews

  def self.sort_by_pages(order)
    Book.order(pages: :order)
  end

  def self.sort_by_rating(order)
    Book.select('books.*, avg(reviews.rating) as avg_rating').left_outer_joins(:reviews).group('books.id').order("avg_rating #{order}")
  end

  def self.sort_by_review_number(order)
    Book.select('books.*, count(reviews.rating) as num_rating').left_outer_joins(:reviews).group('books.id').order("num_rating #{order}")
  end

  def avg_rating(id)
    book = Book.find_or_create_by(id: id)
    book.reviews.average(:rating)
  end
end
