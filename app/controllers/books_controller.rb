class BooksController < ApplicationController
  def index
    if params[:sort] == 'pages'
      @books = Book.sort_by_pages(order)
    elsif params[:sort] == 'pages_desc'
      @books = Book.sort_by_pages(order)
    elsif params[:sort] == 'rating'
      @books = Book.sort_by_rating(order)
    elsif params[:sort] == 'rating_desc'
      @books = Book.sort_by_rating(order)
    elsif params[:sort] == 'review_number'
      @books = Book.sort_by_review_number(order)
    elsif params[:sort] == 'review_number_desc'
      @books = Book.sort_by_review_number(order)
    else
      @books = Book.all
      @top_3_books = Book.select_by_rating(order, num)
    end
  end

  def show
    @book = Book.first
  end
end
