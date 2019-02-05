class ReviewsController < ApplicationController

  def destroy
    Review.find(params[:id]).destroy
    redirect_to user_path(params[:user_id])
  end

  def new
    @review = Review.new
    @book = Book.find(params[:book_id])
  end

  def create
    user = User.create(name: params[:review][:user].titlecase)
    book = Book.find(params[:book_id])
    Review.create(
        review_title: params[:review][:review_title],
        rating: params[:review][:rating],
        text: params[:review][:text],
        user: user,
        book: book)
    redirect_to book_path(params[:book_id])
  end


end
