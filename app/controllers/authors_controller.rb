class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
  end

  def destroy
    book_ids = Author.find(params[:id]).books.pluck(:id)
    book_ids.each do |id|
      Review.where(book_id: id).destroy_all
      AuthorBook.where(book_id: id).destroy_all
      Book.find(id).destroy
    end
    Author.find(params[:id]).destroy
    redirect_to books_path
  end
end
