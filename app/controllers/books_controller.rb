class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.first
  end
end
