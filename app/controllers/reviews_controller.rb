class ReviewsController < ApplicationController
  def destroy
    Review.find(params[:id]).destroy
    redirect_to user_path
  end
end
