class BooksController < ApplicationController
  def index
    if params[:sort] == 'pages'
      @books = Book.sort_by_pages
    elsif params[:sort] == 'pages_desc'
      @books = Book.sort_by_pages_desc
    elsif params[:sort] == 'rating'
      @books = Book.sort_by_rating
    elsif params[:sort] == 'rating_desc'
      @books = Book.sort_by_rating_desc
    elsif params[:sort] == 'review_number'
      @books = Book.sort_by_review_number
    elsif params[:sort] == 'review_number_desc'
      @books = Book.sort_by_review_number_desc
    else
      @books = Book.all
    end
  end
end
