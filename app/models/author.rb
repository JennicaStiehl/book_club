class Author < ApplicationRecord
  validates_uniqueness_of :name

  has_many :author_books
  has_many :books, through: :author_books
end
