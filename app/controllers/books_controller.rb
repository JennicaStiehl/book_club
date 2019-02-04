class BooksController < ApplicationController
  def index
    if params[:sort] == 'pages'
      @books = Book.sort_by_pages(params[:order])
    elsif params[:sort] == 'pages_desc'
      @books = Book.sort_by_pages(params[:order])
    elsif params[:sort] == 'rating'
      @books = Book.sort_by_rating(params[:order])
    elsif params[:sort] == 'rating_desc'
      @books = Book.sort_by_rating(params[:order])
    elsif params[:sort] == 'review_number'
      @books = Book.sort_by_review_number(params[:order])
    elsif params[:sort] == 'review_number_desc'
      @books = Book.sort_by_review_number(params[:order])
    else
      @books = Book.all
    end
    @top_three_books = Book.top_by_rating
    @bottom_three_books = Book.bottom_by_rating
    @top_users = User.most_reviews
  end

  def show
    @book = Book.find(params[:id])
  end

  def destroy
    Review.where(book_id: params[:id]).destroy_all
    AuthorBook.where(book_id: params[:id]).destroy_all
    Book.find(params[:id]).destroy
    redirect_to books_path
  end

  def new
    @book = Book.new
  end

  def create
    authors = params[:book][:authors].split(', ').map(&:titlecase)
    authors.each do |author|
      Author.create(name: author)
    end
    authors = Author.where(name: authors)
    Book.create(title: params[:book][:title].titlecase, pages: params[:book][:pages], year: params[:book][:year], authors: authors)
    redirect_to books_path
  end
end
