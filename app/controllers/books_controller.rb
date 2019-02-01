class BooksController < ApplicationController
  def index
    if params[:sort] == 'pages'
      @books = Book.sort_by_pages('asc')
    elsif params[:sort] == 'pages_desc'
      @books = Book.sort_by_pages('desc')
    elsif params[:sort] == 'rating'
      @books = Book.sort_by_rating('asc')
    elsif params[:sort] == 'rating_desc'
      @books = Book.sort_by_rating('desc')
    elsif params[:sort] == 'review_number'
      @books = Book.sort_by_review_number('asc')
    elsif params[:sort] == 'review_number_desc'
      @books = Book.sort_by_review_number('desc')
    else
      @books = Book.all
    end
  end
end
