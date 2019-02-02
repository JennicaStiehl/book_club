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
    end
    @top_3_books = Book.top_by_rating
    @bottom_3_books = Book.bottom_by_rating
    @top_users = User.most_reviews
  end

  def show
    @book = Book.first
  end

  def destroy
    Review.where(book_id: params[:id]).destroy_all
    AuthorBook.where(book_id: params[:id]).destroy_all
    Book.find(params[:id]).destroy
    redirect_to books_path
  end
end
