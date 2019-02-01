class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.first
    binding.pry
  end
end
